Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Mr7Vd/PHR7TDRzNoudqRzeGo8+JoJhUwfCiJ5cz/Vmlzu4Z9AO9h04sBkcLAuqnMUaI/H
ARC-Seal: i=1; a=rsa-sha256; t=1519218627; cv=none;
        d=google.com; s=arc-20160816;
        b=ZtH1KMsCptlu8SNXoAkUr+QOZqt6ac+y2QyMOtTBPdwI1gpQiTnLYV4qSB+YRrprot
         mSiX57XDtgdL00Jlm+BLH4hpyIyDiuZzXnVmK+0YaxgeDzC8r/RFLQIAX85LQEyHad9T
         tZg6212zhYMzOSHBopZP2DgXmTlG6vuQK3oQaejbmTgpM/KKidaU9W9WLvMbT5cPpefb
         IKD1gamVYjrqFoRSNxR44UHcXfcrwG77l5XR8jRm6FLD/3ZY/wIcS6zDhW4gOy88e7uu
         6D0SYpp6rRRq+ago/H1FF19gZPpTsPvK3hHVbybmZMKMqghq03JyI8a5PymbTIM8w5YK
         YtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l3dbplbKF+U+g0HfbxhaaPsPsE8zrp1rcT/qFG2w0uE=;
        b=tKT1pq8KICm0Mi5nrayStM+wwIuuL+i+RnBy4JujbJsUQ93stjuYCmJzyElaFGGeTD
         NROTpmFhrYF1eNDjQn8RuG3DLa4YMzr1zR21/KlKpcm2oX/1x6X3tWcRDXpG+1lhijxO
         pp7M3esjHuKpvM+w32lLolZm1r/iC4pc0qDrj+FsUSkqw5fnYI2Jgf2vTWAwL6dcN0Gw
         uxp5YN6DRfY9YaByO9m4XB+mEbuhsHtj4LeoINtaJaQCbh8N1LYEXgrW91rBQAnD1efh
         ntFoTfDpgnEgD6YGS0w239uP6NDtPtOp2GOuPpIjWzgwqfKxKI07KLK9l8i6txudxfxf
         6zcA==
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
Subject: [PATCH 4.15 102/163] mmc: bcm2835: Dont overwrite max frequency unconditionally
Date: Wed, 21 Feb 2018 13:48:51 +0100
Message-Id: <20180221124535.926505294@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015683406226777?=
X-GMAIL-MSGID: =?utf-8?q?1593016191115209745?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
