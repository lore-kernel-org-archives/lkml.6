Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELufNm4BTedKlGgj0Be2aHr+x4iGrHwpPtsy+Z4KZP8xBpyDf1J8xrSG4E6JY0OYwAPW4Es/
ARC-Seal: i=1; a=rsa-sha256; t=1521483993; cv=none;
        d=google.com; s=arc-20160816;
        b=EQ5D3sQc/DUR7Q1SOqJ9q5LLNKV55dT88z7q1u2w8YpS0TVbz7/kfiyjmY+WgUEOH8
         js2ZjhQU9sYXFMvrB+2QLTJJhyqt3NwxTJoItJiJLXP0qKx7TGUy5Sguq2c+OpgfXz2d
         xBOnZDOxYQdpCkprWAO0sT3gSB2SeGErlq/WbyS3RvZh/2vykxNnCZEO0utmtdGXGx+q
         84kDHSGYcRGlA09Yncmm3UkyWED4XiNG4b4awJZj3QxB8j5HtqvmdJyRU+7NLGSwZ6wQ
         9CCxmXiblfgDjqyHFGmFeI0PFJAClJrBvBeigYftK0iVd57kb9dyigc5f1noNoUhBD1o
         ZspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w2+jqMp/n6p512Fi83UoEtDWjmz/g8vD/I98nUUoIew=;
        b=XiJ/GjH7c5vCDwI22Xefu3R6jjjS58Xu3htYEirWjc6xm3xFleW0KXPWpl2ymGus1+
         SU9q9eOTt5QP0Ewtog3rhTGqyPq3sjFRdTrBwMuEc9OUU1MO/80jU4ezdpyPV15rN7vN
         qCUfDO7+1E2YgvRV1Y2Aaz+R3KyEBDVgA1zWD85CpJ6tj3gdDuRelx6SkFDURE8nngWf
         uuNveKiBm0Cjjy053GEiQAu0ZpvNnIo8Fw9fUlt8JO9cWLOEauDEYTCr4N82q6nJpQLv
         4KsoowGxdBJ9A7wEkvTqRZV5gaOdfq8MthN2xtp4+y88ArXH2CZGJxtXJq0SibWJWsTE
         +Pig==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Bogendoerfer <tbogendoerfer@suse.de>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 193/241] bnxt_en: Dont print "Link speed -1 no longer supported" messages.
Date: Mon, 19 Mar 2018 19:07:38 +0100
Message-Id: <20180319180759.134408058@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391599018925243?=
X-GMAIL-MSGID: =?utf-8?q?1595391599018925243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>


[ Upstream commit a8168b6cee6e9334dfebb4b9108e8d73794f6088 ]

On some dual port NICs, the 2 ports have to be configured with compatible
link speeds.  Under some conditions, a port's configured speed may no
longer be supported.  The firmware will send a message to the driver
when this happens.

Improve this logic that prints out the warning by only printing it if
we can determine the link speed that is no longer supported.  If the
speed is unknown or it is in autoneg mode, skip the warning message.

Reported-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Tested-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1498,12 +1498,16 @@ static int bnxt_async_event_process(stru
 
 		if (BNXT_VF(bp))
 			goto async_event_process_exit;
-		if (data1 & 0x20000) {
+
+		/* print unsupported speed warning in forced speed mode only */
+		if (!(link_info->autoneg & BNXT_AUTONEG_SPEED) &&
+		    (data1 & 0x20000)) {
 			u16 fw_speed = link_info->force_link_speed;
 			u32 speed = bnxt_fw_to_ethtool_speed(fw_speed);
 
-			netdev_warn(bp->dev, "Link speed %d no longer supported\n",
-				    speed);
+			if (speed != SPEED_UNKNOWN)
+				netdev_warn(bp->dev, "Link speed %d no longer supported\n",
+					    speed);
 		}
 		set_bit(BNXT_LINK_SPEED_CHNG_SP_EVENT, &bp->sp_event);
 		/* fall thru */
