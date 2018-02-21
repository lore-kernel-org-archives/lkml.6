Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226pBv6Ch/rbQWwPqnOYPRMM0CMjdcy4m8fq+PELfPrPHS1AIkx7DA5S3myfJp95gCRSLP6E
ARC-Seal: i=1; a=rsa-sha256; t=1519218143; cv=none;
        d=google.com; s=arc-20160816;
        b=0vVInXhVBhSVA6v7XgqmXNXMYfijCKAu2CmTq5bWGW5kn9r56sXkL0kLSf9RV3L2Oe
         kSESqFDNJCAsW+TqTsa8VrI8NKSh05bFhQqJL8DED3EzjA2JW/DUdX9xqEvArdRUr3vi
         Mul0Au+TmGr+TWwSsGAxEKqRpSC1IB+1W84Oj3taEyIT6EbYqzxHiv63nJ1tV5m8fMAs
         A1c+0pxZ4XWTqllx5g0u/wdgu37hOpzkWA+FNXWeZNo+2sS2M6LLUU2z+hJ+JAuwOEaj
         gvzEZou/bIXKwZX81dzmzOXXyBXkQmrsTwBGf0+Ef07QuDEVFHF4wZNiLieWW6DYpPxD
         n5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QZdYoyvBx24rwyZcxWcxRtuNKm/Ngcxps5s741t9c/0=;
        b=mSVSP4s1GCeFc6CpMBNELqhBAmpjJFUTI8bDCkevRCUeO5m4EjhA9Rye2wZXHwy2b/
         6oD+Zm2iDcJF/2Gkx/cQP2MT99SFefOuM1BEXrjl1c6rJm6wMtpn05cjz4q5sN/KyTrn
         RSNugDWwLwxDgoCBTmFBelIRBTB3Vwi7P8G8KKQ+w4nKRMNyO5dFqwN+ObHZSTEy2Vpp
         UhWO216WeT9ufjkBnlpdkCSfZZSNvTev7RrlhALK+zGpILWGbTF7mQAg0SMn45xLNrfN
         YFfQ4UuKixy2fyyxwuHeuyeXvBL3G3BtYoLWZiZ+LQWXP0fxOtUHtvaOMERQXvDWAFGx
         WFmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Phil Elwell <phil@raspberrypi.org>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 101/167] mmc: bcm2835: Dont overwrite max frequency unconditionally
Date: Wed, 21 Feb 2018 13:48:32 +0100
Message-Id: <20180221124529.887041447@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015683406226777?=
X-GMAIL-MSGID: =?utf-8?q?1593015683406226777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Elwell <phil@raspberrypi.org>

commit 118032be389009b07ecb5a03ffe219a89d421def upstream.

The optional DT parameter max-frequency could init the max bus frequency.
So take care of this, before setting the max bus frequency.

Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Cc: <stable@vger.kernel.org> # 4.12+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/bcm2835.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1265,7 +1265,8 @@ static int bcm2835_add_host(struct bcm28
 	char pio_limit_string[20];
 	int ret;
 
-	mmc->f_max = host->max_clk;
+	if (!mmc->f_max || mmc->f_max > host->max_clk)
+		mmc->f_max = host->max_clk;
 	mmc->f_min = host->max_clk / SDCDIV_MAX_CDIV;
 
 	mmc->max_busy_timeout = ~0 / (mmc->f_max / 1000);
