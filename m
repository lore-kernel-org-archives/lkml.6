Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C4BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88003219FC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gnmed0EE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392250AbeLVQy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:54:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34723 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732861AbeLVQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:54:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so3908324plz.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 08:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Am2wUODHH0JsEj7SXIZCLf5E3+sl55uz+ynr3m0M9Nw=;
        b=gnmed0EEX62vcIGeZntu9yWGS9IcOPbrLKx2pElcsezpP9VBv9RlKrHI7LsRlewzkj
         TioKp5ipzJvBiJICtlAFHtI3XjL+j9WVA/BRSLqvxmnWCq/ZeMFpa2pZB+pIjN4cH+Jc
         m7TCbrbgFHnm6TtC+LqzMUPj9bD21l1hd4zx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Am2wUODHH0JsEj7SXIZCLf5E3+sl55uz+ynr3m0M9Nw=;
        b=jjey6xa1A2MEl2SCDsDLUHDDvtjUc3aA37jWF97n5tqk275b2eWt+UukzlHf8hAwJl
         Wn/eQvciyxKjdo2LglO4qVxT9P8hhh1HAW0WiIhhn3CrF3w5LiE7uoBHTAht6/yAsyXs
         Y6vysuUsODdbibibcsJMy4dpz3miB5fKQD/JlB8JqURu9ehw0+j7TEyZsESsEb3Ax7TC
         Px6xivj+h9oQM5+PkV9b8Jw/M1OX8AP3vURLAgS05G7YLKtMRdv9WQ/sSFeO23IyfHoY
         gVOBpL6UhltuqGjXOyHyKTvGEVTAfD+ByFn+xUgmE/ycUIB1ENcjLIeE37DhAMP99Yzi
         cr1Q==
X-Gm-Message-State: AJcUukcoSQr71q6qtmzju4l5bkCECnEbYBiNn21Bpq0hLRc86yStKtYd
        pb9so/jCrkK+hKVz9MoJN0fDmf7n+wswZA==
X-Google-Smtp-Source: ALg8bN4FuIBvdD6+z/okD6bFYs9tJf1Y1GhHqzXObzUinfzP3bwU67uQDiPmHbo6oLTZ7FDpWdxKEA==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr5694497plb.306.1545463494906;
        Fri, 21 Dec 2018 23:24:54 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 186sm53825350pga.36.2018.12.21.23.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 23:24:54 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     robh@kernel.org
Cc:     a.hajda@samsung.com, andy.shevchenko@gmail.com,
        b.zolnierkie@samsung.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, javierm@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, m.szyprowski@samsung.com, rafael@kernel.org
Subject: [PATCH] driver core: platform: Add an error message to platform_get_irq*()
Date:   Fri, 21 Dec 2018 23:24:52 -0800
Message-Id: <20181222072452.186726-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
References: <CABGGisxcHWwhUcQML7XmriK_DLFGjmud3cKt8yp+K4G2CAL=9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A grep of the kernel shows that many drivers print an error message if
they fail to get the irq they're looking for. Furthermore, those drivers
all decide to print the device name, or not, and the irq they were
requesting, or not, etc. Let's consolidate all these error messages into
the API itself, allowing us to get rid of the error messages in each
driver.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Rob Herring wrote:
> Shouldn't platform_get_irq (or what it calls) print the error message
> (like we do for kmalloc), rather than every driver? We could get rid
> of lots of error strings that way. I guess there are cases where no
> irq is not an error and we wouldn't want to always print an error. In
> some cases like that, we have 2 versions of the function.

Yes it should. Just by coincidence, I got around to implementing this
patch yesterday after I bemoaned this on the list a few months ago[1].

> Not what you're addressing here exactly, but what I'd like to see is
> the ability to print the exact locations generating errors in the
> first place. That would require wrapping all the error code
> assignments and returns (or at least the common sources). 

That could be done with some macro magic to add __line__ and __FILE__
into a definition of the "important" functions. In that sense nothing
would really need to change besides the implementation, right?

I also started working on a cocci script to fix up the call sites to
drop the extra prints, but I'm really bad at writing semantic patches so
please help improve the below. My simple grep shows that we can remove
~500 error prints out of the 1500 places the platform_get_irq()
functions are called.

	@@
	expression ret;
	struct platform_device *E;
	@@

	ret =
	(
	platform_get_irq(E, ...)
	|
	platform_get_irq_byname(E, ...)
	);

	if ( \( ret < 0 \| ret <= 0 \) )
	{
	(
	-if (ret != -EPROBE_DEFER)
	-{ ...
	-dev_err(...);
	-... }
	|
	...
	-dev_err(...);
	)
	...
	}

[1] https://lkml.kernel.org/r/153911433511.119890.17831207059115471972@swboyd.mtv.corp.google.com

 drivers/base/platform.c | 52 +++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4..75ceda9f452a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -79,23 +79,18 @@ struct resource *platform_get_resource(struct platform_device *dev,
 }
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
-/**
- * platform_get_irq - get an IRQ for a device
- * @dev: platform device
- * @num: IRQ number index
- */
-int platform_get_irq(struct platform_device *dev, unsigned int num)
+static int __platform_get_irq(struct platform_device *dev, unsigned int num, bool warn)
 {
+	int ret = -ENXIO;
+
 #ifdef CONFIG_SPARC
 	/* sparc does not have irqs represented as IORESOURCE_IRQ resources */
 	if (!dev || num >= dev->archdata.num_irqs)
-		return -ENXIO;
+		goto error;
 	return dev->archdata.irqs[num];
 #else
 	struct resource *r;
 	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
-		int ret;
-
 		ret = of_irq_get(dev->dev.of_node, num);
 		if (ret > 0 || ret == -EPROBE_DEFER)
 			return ret;
@@ -104,11 +99,11 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 	r = platform_get_resource(dev, IORESOURCE_IRQ, num);
 	if (has_acpi_companion(&dev->dev)) {
 		if (r && r->flags & IORESOURCE_DISABLED) {
-			int ret;
-
 			ret = acpi_irq_get(ACPI_HANDLE(&dev->dev), num, r);
-			if (ret)
+			if (ret > 0 || ret == -EPROBE_DEFER)
 				return ret;
+			if (ret)
+				goto error;
 		}
 	}
 
@@ -122,13 +117,32 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 		struct irq_data *irqd;
 
 		irqd = irq_get_irq_data(r->start);
-		if (!irqd)
-			return -ENXIO;
+		if (!irqd) {
+			ret = -ENXIO;
+			goto error;
+		}
+
 		irqd_set_trigger_type(irqd, r->flags & IORESOURCE_BITS);
 	}
 
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
 #endif
+error:
+	if (warn)
+		dev_err(&dev->dev, "IRQ%d not found\n", num);
+
+	return ret;
+}
+
+/**
+ * platform_get_irq - get an IRQ for a device
+ * @dev: platform device
+ * @num: IRQ number index
+ */
+int platform_get_irq(struct platform_device *dev, unsigned int num)
+{
+	return __platform_get_irq(dev, num, true);
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
@@ -142,7 +156,7 @@ int platform_irq_count(struct platform_device *dev)
 {
 	int ret, nr = 0;
 
-	while ((ret = platform_get_irq(dev, nr)) >= 0)
+	while ((ret = __platform_get_irq(dev, nr, false)) >= 0)
 		nr++;
 
 	if (ret == -EPROBE_DEFER)
@@ -195,7 +209,11 @@ int platform_get_irq_byname(struct platform_device *dev, const char *name)
 	}
 
 	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
-	return r ? r->start : -ENXIO;
+	if (r)
+		return r->start;
+
+	dev_err(&dev->dev, "IRQ %s not found\n", name);
+	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(platform_get_irq_byname);
 
-- 
Sent by a computer through tubes

