Return-Path: <moritz.fischer@ettus.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522338185; cv=none;
        d=google.com; s=arc-20160816;
        b=GkntRrzaAhR1U7O7Rz+QLi7XSeaLTF+cwFi+kXpM9iFTIv/AGEBr7tpAdFAHUxPGFm
         bAzu9mAR+9s2mBBHej0XIaUpimmHpAnP+A7u0n7vuFyPHm/ayl0lukC1+54HOC/Ujjvu
         8mQJS8yg6MQ/bHtgYQ4hDsvp+ruNeM7kNDUbpVHSDg/npY/MsaVojogoIvbDB2bn9kxQ
         t6lT3DboglufHxmh40DJolLoZ9KcySttKUmlIIFzv79m8EYcNtRLXJae0Aw5d+bwSqx5
         h9/rNTSXZdkIJcO7cqkgKMWMmkyTkfwBSvKEQKPXl82xLLnPJsbqtMJnH+4FMSi2u7+S
         fhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=DYQOrmGLKmS21CXf9yjRbVOUQn+BAWdjj/vyTTjbKNU=;
        b=iUTBter41iDthDPWv5F8e6a2bKngd27lcWaHogrpvvs4QrM1gsceO6P51qXVAMy7sr
         VAFCBnC1mzOsv9rADdSYYZodkht0hfWNqEO4mK6nY8//1QisdTO6w8KORz4GroVHNEgi
         daq2VbaSM0uQoFTd1Kpb4xtYHiM1dh8fRqV9+sxNovmcdwwkbsrvKKZ4WXTCiESCDvmW
         U1ddbS6SdSrJdMexS7+o4l1dbCEL9eKVgCtNTAjRpRPxZFmX6sWZ94w6Q5AO67P3AUGX
         RME/+p8+raZzNY2aRqXjjfSxS4yeu8WTeFLmIVoA4lqZyopyl8UhokfL2Aueh55BsCWK
         gkmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of moritz.fischer@ettus.com) smtp.mailfrom=moritz.fischer@ettus.com
X-Google-Smtp-Source: AIpwx49HtvWsElJ6QwRM27V2H2vfrorotIkTfRp1JtMPmRG9a5TYLnRfC6Qzn0BA6z1AQRVpGC42nA==
From: Moritz Fischer <mdf@kernel.org>
To: gregkh@linuxfoundation.org
Cc: atull@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>,
	Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 6/6] fpga-manager: altera-ps-spi: preserve nCONFIG state
Date: Thu, 29 Mar 2018 08:36:58 -0700
Message-Id: <20180329153658.11614-7-mdf@kernel.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329153658.11614-1-mdf@kernel.org>
References: <20180329153658.11614-1-mdf@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596287285023274584?=
X-GMAIL-MSGID: =?utf-8?q?1596287285023274584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anatolij Gustschin <agust@denx.de>

If the driver module is loaded when FPGA is configured, the FPGA
is reset because nconfig is pulled low (low-active gpio inited
with GPIOD_OUT_HIGH activates the signal which means setting its
value to low). Init nconfig with GPIOD_OUT_LOW to prevent this.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Signed-off-by: Alan Tull <atull@kernel.org>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/altera-ps-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index b061408bf0ae..250d9cf9bb1b 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -254,7 +254,7 @@ static int altera_ps_probe(struct spi_device *spi)
 
 	conf->data = of_id->data;
 	conf->spi = spi;
-	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_HIGH);
+	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
 	if (IS_ERR(conf->config)) {
 		dev_err(&spi->dev, "Failed to get config gpio: %ld\n",
 			PTR_ERR(conf->config));
-- 
2.16.2
