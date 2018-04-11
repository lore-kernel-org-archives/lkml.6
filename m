Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+LW4lzhI2/lHBRd+nZdIvXW+Po7s3a2wQtQduG1I1TEOQljZG85dIeQJcLFsJDdR04cHi+
ARC-Seal: i=1; a=rsa-sha256; t=1523472102; cv=none;
        d=google.com; s=arc-20160816;
        b=yl9PvbnJF7VPoqBOxuKKkkq489qxbJ3hPxPECExe+RTxbZ7p2F63ci8mjyr4VwAjQe
         358id2YSKUyWWBLcKvzZ/6ATZmBrYiHE+7zqviKOGdHGSROh9jtQ0+91TSHmRQ7WH6Ch
         EHkMklp3DMdYsoyU9ofI31cQTWS0uVdWwMDzyLfiYmCUm0EQB26ZZNvv09wfFXffdTc/
         oqp5AoIeVJSKJA5PuCaTmyoqufHnajcM5cFUWJGcWpqHymUqI+s8FD4YbGAuuRQeySny
         AyimM++9RouraOykdCqq+MYsMVh8dOgi1ZkTQEuA22sR6A8e/UOyneiP/mUqxl9+Vo5N
         5CpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NWnVLGAMhEACUVK5aw0zyLeIik1WiAb+9rHdDrKMSv8=;
        b=moCvRu7imY9uqIxfoV9MiW9psXMnfnmRQYnzCW0Xt6rkbanJqrm4pQIF2GBlUg6soG
         KVG2h7dbF2MkjM7yK1zQic16RAgkas3WOANUIxyVbljAhYpGt93yXasWnr+NRrqihKIa
         B0xWHhZmrdzPesr++1SXelS7LiovNeQFbDn0En3r/aOlt7aC4JjQSReFytdtoVKETaV0
         YrpY3GIaEvQXymXtmOI21Hpv/ScwaZ819fDCjkm9qfh4lepyTtce0jsBCf42qE6gFct6
         NEBYLl7hArGjyb8pn/FFpakTx0WBEM177viQFMCTrLAddE/6rBwIz8J/AUAQLwHlb007
         ipCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Firo Yang <firogm@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 053/121] hdlcdrv: Fix divide by zero in hdlcdrv_ioctl
Date: Wed, 11 Apr 2018 20:35:56 +0200
Message-Id: <20180411183459.539382641@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476282817788876?=
X-GMAIL-MSGID: =?utf-8?q?1597476282817788876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Firo Yang <firogm@gmail.com>


[ Upstream commit fb3ce90b7d7761b6f7f28f0ff5c456ef6b5229a1 ]

syszkaller fuzzer triggered a divide by zero, when set calibration
through ioctl().

To fix it, test 'bitrate' if it is negative or 0, just return -EINVAL.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Firo Yang <firogm@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hamradio/hdlcdrv.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/hamradio/hdlcdrv.c
+++ b/drivers/net/hamradio/hdlcdrv.c
@@ -571,6 +571,8 @@ static int hdlcdrv_ioctl(struct net_devi
 	case HDLCDRVCTL_CALIBRATE:
 		if(!capable(CAP_SYS_RAWIO))
 			return -EPERM;
+		if (s->par.bitrate <= 0)
+			return -EINVAL;
 		if (bi.data.calibrate > INT_MAX / s->par.bitrate)
 			return -EINVAL;
 		s->hdlctx.calibrate = bi.data.calibrate * s->par.bitrate / 16;
