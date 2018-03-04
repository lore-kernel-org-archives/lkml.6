Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELv/8exZOna5IWipF9ycWu2p1+prg7dGPWo+XdkEW2qlKFXjR04cy4t0/V85tjejtlY3StXw
ARC-Seal: i=1; a=rsa-sha256; t=1520128193; cv=none;
        d=google.com; s=arc-20160816;
        b=c0nR3/p/M3fDFs6SbmML6bdixN7tTGOaWn9W1j2WAQjOkFxWJSbDdt6KkWpQ4uvQ9c
         gLfbzAI2dsE907FBmNrhkaH8Sq+XHUZDd9Eqv+N0a7XlKQpq7OCmkYJtHbXmLnqC+p/j
         N1AUmqAYHD3LuPNfq/f731rh9xh7NtMbD0Fiy1GDbAclYqlHU757zNUdC3R5tyXjm7xN
         Q5iFW7jP2EmyiSKIcYgcRuoLIiD2ThowYwuCOQ2MdtfZXeRqmRPQ79llFTb4fwQtH3jj
         it7S1i78RPP2bzHNEb4Ov2ikcqdUl/7xLgPf7JnqmabY2ENvqv7adpe4Vo6kb00Z4Kuj
         RhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=gNYtfTAUN6Si4uOYm+MTow8Vs8s5YTKqiZLOAf1hDQY=;
        b=FSb0E2J3TWnH4yVzXiUgcyHm798B9Ob/jA9+ahQ4LAIukgWixH2jl37EA/CBAEan9k
         75s+LktxXoyG1WJu76fhHOakOiN0Hq1HpQJb9uF9LD8Ggd+ureB8HyTlSJDjG5FvELvc
         SiVEcZGil8OHXiXDUnR3NEeugq787Zm5/k3nehpw7xM6DvCBddK7TGIcdU1UvKFgT9IP
         CyKxTGAHP/ghTdetIW+IhPlr8mO+ipnfDaqgIaho0HvkFcFT4UVf/Pp2xUGJhZ58fKvD
         gH89aV2Uw+NqXGnz2o1y0vDjAEhoFuMD+HLggS424fslAcFdRAnBr+XxTaVun93/rZAw
         GPkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=T+EcX9Y9;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=T+EcX9Y9;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 06/12] staging: iio: tsl2x7x: correctly return errors in tsl2x7x_get_prox()
Date: Sat,  3 Mar 2018 20:49:36 -0500
Message-Id: <20180304014942.18727-7-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969940405002754?=
X-GMAIL-MSGID: =?utf-8?q?1593969940405002754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Not all errors that occurred in tsl2x7x_get_prox() were correctly
reported in the return value. This patch changes the error handling
so that errors are now returned properly.

Note that the ret variable is from the call to tsl2x7x_read_status(),
and it already has the correct error check. The -EINVAL error code is
for an unexpected value in the register.

This patch also corrects an unnecessary word wrap in the call to
le16_to_cpup() while changes are being made to this code.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 5c611250127f..cc209b64ed5a 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -489,16 +489,20 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 	case tmd2671:
 	case tsl2771:
 	case tmd2771:
-		if (!(ret & TSL2X7X_STA_ADC_VALID))
+		if (!(ret & TSL2X7X_STA_ADC_VALID)) {
+			ret = -EINVAL;
 			goto prox_poll_err;
+		}
 		break;
 	case tsl2572:
 	case tsl2672:
 	case tmd2672:
 	case tsl2772:
 	case tmd2772:
-		if (!(ret & TSL2X7X_STA_PRX_VALID))
+		if (!(ret & TSL2X7X_STA_PRX_VALID)) {
+			ret = -EINVAL;
 			goto prox_poll_err;
+		}
 		break;
 	}
 
@@ -512,14 +516,13 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 		chdata[i] = ret;
 	}
 
-	chip->prox_data =
-			le16_to_cpup((const __le16 *)&chdata[0]);
+	chip->prox_data = le16_to_cpup((const __le16 *)&chdata[0]);
+	ret = chip->prox_data;
 
 prox_poll_err:
-
 	mutex_unlock(&chip->prox_mutex);
 
-	return chip->prox_data;
+	return ret;
 }
 
 /**
-- 
2.14.3
