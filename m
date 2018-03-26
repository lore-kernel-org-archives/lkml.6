Return-Path: <kernel-hardening-return-12728-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtouAc52n59N5E2GnFrELyRhY9/2ikuuQ9MSdIDNKvkZjaz24s3DVLd63T8fqV5lJ85Xsnb
ARC-Seal: i=1; a=rsa-sha256; t=1522046027; cv=none;
        d=google.com; s=arc-20160816;
        b=hyY0DXeVGBisnMt5gRoRQzqaLqaj8Cwjgrqpk7QkZZIfhm5d0Ev5MwwK+GAD5pcdfe
         GparOLGISAJ6zhHSJQdsqDKHETF7vU8+MpjurzYw9mVPHfYvYtLuneMfvsgM5rxVHrL7
         9Ie3vXqvLegd3A87nz0jWoU/aRfKirOSymznO8dlACE72OeuMeugf2OJ/sbUciqyJnCn
         LJVeJD+NyUA1hhJi0Yv7YWAg/3daicxXlRv2DY/75rrvKpaXztMn1wDJ+BmwHXpZC86/
         aAvFO+5HVitYUEVz30tSZBTUweCHm1nM9UQWhfUBwuVbvBIBB02GeR+BxpIxSpmh1W1F
         C3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=SkA5nm/L0ZJHx3nVkwQEdRW0Dt+mqyocDBj8FQeX/gw=;
        b=D6mNU+aeOyqXwVC1Vf7+uz5RuLfS3aDhid7sRUSQaBQq2ctYFoZI/RonLXglkpHCdn
         f+ng3AZ5Q/XyvA9Tg+hcjMQ/eE9qR5LLrYR2tpb9WwDAF1mAKWtfrjD45cis26MxAc4i
         FepxT3xLgsMrmBbVkCoZEmKMgkutqkYNaO8G1JVhoKwV7y9N30zQgv+AYJWIsJnLB7xx
         +VfryDySEg029WCUXjKNN4pPaXY96r3OGI4NA7itOzgh/zm63eDEMbt9SmtF6ljcZL4z
         B3+LFtJdXH0cHRnUNC5/DbWTExLE4Epd2BOmnvT48eT0n4QA49iE9rWu3XK9Tigkgsfv
         xXuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=daFLy5mv;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ZnJvIyIe;
       spf=pass (google.com: domain of kernel-hardening-return-12728-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12728-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=daFLy5mv;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ZnJvIyIe;
       spf=pass (google.com: domain of kernel-hardening-return-12728-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12728-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:NpS4WmT1SjO94rCQVANtJODJKfDEklbgcQJRJ6cbKcP2BRh0meS2Iw>
From: "Tobin C. Harding" <me@tobin.cc>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] mmc: pwrseq: Use kmalloc_array instead of stack VLA
Date: Mon, 26 Mar 2018 17:33:14 +1100
Message-Id: <1522045994-21913-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595980934577926333?=
X-GMAIL-MSGID: =?utf-8?q?1595980934577926333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The use of stack Variable Length Arrays needs to be avoided, as they
can be a vector for stack exhaustion, which can be both a runtime bug
(kernel Oops) or a security flaw (overwriting memory beyond the
stack). Also, in general, as code evolves it is easy to lose track of
how big a VLA can get. Thus, we can end up having runtime failures
that are hard to debug. As part of the directive[1] to remove all VLAs
from the kernel, and build with -Wvla.

Currently driver is using a VLA declared using the number of descriptors.  This
array is used to store integer values and is later used as an argument to
`gpiod_set_array_value_cansleep()` This can be avoided by using
`kmalloc_array()` to allocate memory for the array of integer values.  Memory is
free'd before return from function.

>From the code it appears that it is safe to sleep so we can use GFP_KERNEL
(based _cansleep() suffix of function `gpiod_set_array_value_cansleep()`.

It can be expected that this patch will result in a small increase in overhead
due to the use of `kmalloc_array()`

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

Patch is untested.  I was not able to fully grok the call chain involved
with this change so was unable to quantify the total degradation
of performance.

Line calling to gpiod_set_array_value_cansleep() is 83 characters long,
patch attempts to leave the code as clean as possible.  Open to
suggestions for improvement.  I tried various forms of while loop and
pointer arithmetic for the setting of `values` but in the end settled
for array indexing, again open to suggestions.

thanks,
Tobin.

 drivers/mmc/core/pwrseq_simple.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 13ef162cf066..a8b9fee4d62a 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -40,14 +40,18 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
 
 	if (!IS_ERR(reset_gpios)) {
-		int i;
-		int values[reset_gpios->ndescs];
+		int i, *values;
+		int nvalues = reset_gpios->ndescs;
 
-		for (i = 0; i < reset_gpios->ndescs; i++)
+		values = kmalloc_array(nvalues, sizeof(int), GFP_KERNEL);
+		if (!values)
+			return;
+
+		for (i = 0; i < nvalues; i++)
 			values[i] = value;
 
-		gpiod_set_array_value_cansleep(
-			reset_gpios->ndescs, reset_gpios->desc, values);
+		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc, values);
+		kfree(values);
 	}
 }
 
-- 
2.7.4
