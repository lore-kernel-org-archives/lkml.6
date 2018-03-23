Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtIYU5SQ78GbdJ378RA2LU5TzfXuUuKoUO//+j1T5dfDNh7f13QmL9Eqe1+bCtkjjWbIcI1
ARC-Seal: i=1; a=rsa-sha256; t=1521800310; cv=none;
        d=google.com; s=arc-20160816;
        b=jbBelo+pT1FlCiNvDtJxsbAP3wtH/peO17FFyxixsIgaGsuY+SKc/LNbjWQw77swwz
         U2S4JzSNxtx12fze0mqufaa9G5hzoKqIpzTDcCkt42qx32VTYXHZ7lrCtRomZm7UQFzE
         AtkYBehfWjTXxkXNrsm3m0mjebcpt08mm2X3ZOoe3hAdXch3pZO88YOn+TBBuNo2mgqb
         omB5KuEnBBh+zRswMW7vyAKM4GGr2MMNo5IMTJPQ85WFB7FC6qfrvFf8uauUzqrOZ6Oe
         oNGp+omr3R4HfgxY+OjUdIirvceZCqTF9EVqs3WIBZYxlKMSn3yyXJmp1Y9k0fnCQOC9
         iodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7hz7rEX9eIXdz26EmTZbENug2cKIem6Hcb1fwL+wXS8=;
        b=PSzlySFW9qJz270d42/OJkSC32zy7+D3bM448HRjPlnYKGPFGTtkzhobUw2msTjNB5
         qO60rWUSvkHTYPw/IYioNR7rcN9N3vo70BzINOzekOYNsBChAEt2/zzKJ7exbw5im0kd
         FVs//qPKF2yenkvItU1+qzr/B1X20JGIYw+sIcEz3YVcPWgn4YPm+D/JCZAoaYJ36tyI
         /SPSWSkXKNOsZONG9Eyx3G7I97CY84o8lQR9Xq6/+6JgxXq83QmDsZT4GnluiDRCath6
         l8aNDDFqd55fdDDdcDVVvaS8B9ZNAlNGnB/9nGyW6fkMEG8z3rMj+Bw6orM27uKGyCJb
         6/FQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jasmin jessich <jasmin@anw.at>,
	Ralph Metzler <rjkm@metzlerbros.de>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 09/47] [media] media/dvb-core: Race condition when writing to CAM
Date: Fri, 23 Mar 2018 10:55:00 +0100
Message-Id: <20180323094248.522646244@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722417300385279?=
X-GMAIL-MSGID: =?utf-8?q?1595723282318034068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jasmin J <jasmin@anw.at>


[ Upstream commit e7080d4471d805d921a9ea21b32f911a91e248cb ]

It started with a sporadic message in syslog: "CAM tried to send a
buffer larger than the ecount size" This message is not the fault
itself, but a consecutive fault, after a read error from the CAM. This
happens only on several CAMs, several hardware, and of course sporadic.

It is a consecutive fault, if the last read from the CAM did fail. I
guess this will not happen on all CAMs, but at least it did on mine.
There was a write error to the CAM and during the re-initialization
procedure, the CAM finished the last read, although it got a RS.

The write error to the CAM happened because a race condition between HC
write, checking DA and FR.

This patch added an additional check for DA(RE), just after checking FR.
It is important to read the CAMs status register again, to give the CAM
the necessary time for a proper reaction to HC. Please note the
description within the source code (patch below).

[mchehab@s-opensource.com: make checkpatch happy]

Signed-off-by: Jasmin jessich <jasmin@anw.at>
Tested-by: Ralph Metzler <rjkm@metzlerbros.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-core/dvb_ca_en50221.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -749,6 +749,29 @@ static int dvb_ca_en50221_write_data(str
 		goto exit;
 	}
 
+	/*
+	 * It may need some time for the CAM to settle down, or there might
+	 * be a race condition between the CAM, writing HC and our last
+	 * check for DA. This happens, if the CAM asserts DA, just after
+	 * checking DA before we are setting HC. In this case it might be
+	 * a bug in the CAM to keep the FR bit, the lower layer/HW
+	 * communication requires a longer timeout or the CAM needs more
+	 * time internally. But this happens in reality!
+	 * We need to read the status from the HW again and do the same
+	 * we did for the previous check for DA
+	 */
+	status = ca->pub->read_cam_control(ca->pub, slot, CTRLIF_STATUS);
+	if (status < 0)
+		goto exit;
+
+	if (status & (STATUSREG_DA | STATUSREG_RE)) {
+		if (status & STATUSREG_DA)
+			dvb_ca_en50221_thread_wakeup(ca);
+
+		status = -EAGAIN;
+		goto exit;
+	}
+
 	/* send the amount of data */
 	if ((status = ca->pub->write_cam_control(ca->pub, slot, CTRLIF_SIZE_HIGH, bytes_write >> 8)) != 0)
 		goto exit;
