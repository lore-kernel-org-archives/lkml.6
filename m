Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC8AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AB02083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bS2m9YSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AB02083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933706AbeFTVbq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:31:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46705 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933346AbeFTVbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:31:44 -0400
Received: by mail-pl0-f66.google.com with SMTP id 30-v6so448659pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=UhpVuMgoqVvFrbt0HrzAdI5S1YVDUhT5oNJIYqoXqEo=;
        b=bS2m9YSfWGmFLdD7DZ6sP29UK3lusNpm8aYZDLcMYdyIQuHrOJWVaYgjfqk7AuUkIN
         ZtfXrq6sXV6o9d1zaZgrxBowBvVFtqkaL+fD8dom+A7f8EvimVKhXEBQhUCc1HJeFB/4
         XEaIZ5LCT+L4LzgpVMRyPuzhDMpOsIf7lF6gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=UhpVuMgoqVvFrbt0HrzAdI5S1YVDUhT5oNJIYqoXqEo=;
        b=Db2pTFeno73KmqpC+5LQPdqKu3CxpsDLyhWa4YL3vPqZutV4SDof5oRIDt6ApZuO+Z
         qlvfW4bP2k/Jv4NZzxNb+oG/kjPgYFMdxBgOiz9hglRoQ0olOkEJwFFm5TLQ8YXW6yAN
         G96sqtECYMXyKJXK3bKa5t93TKR4+gxWEL+LNy2R1YnMlWIXtxWRVLZZiR/cSlrMA8mb
         REvmoKzXb8/X9/qt0CmLIahdrNMCVx/YIzGZxj+Hlyg4EtZwSO0h8V2egKdhyF4Z3THp
         jRA2G/d4ERReKVGnIcPFNUdsIBHFsWdOK60JvlUv6AFq8pE8e6c/iUJgk0fgWbE7aiIz
         aK5Q==
X-Gm-Message-State: APt69E1mAairZO4JbVfgZcW3y6SHPKATv1xTPC4OcPWY6C9m70VrY1nO
        /P/j3U4nvV/xdnM90ErebEg4wA==
X-Google-Smtp-Source: ADUXVKJSD50TbCkGrrEzgYofXo9NhiQKOX3+KV88Z/pNyXeeYkrwURid4AU2MBMJJPCf2bf5w3/cUg==
X-Received: by 2002:a17:902:aa98:: with SMTP id d24-v6mr25974409plr.185.1529530303833;
        Wed, 20 Jun 2018 14:31:43 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j21-v6sm4780258pfn.121.2018.06.20.14.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 14:31:42 -0700 (PDT)
Date:   Wed, 20 Jun 2018 14:31:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Darren Hart <dvhart@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Mihai =?utf-8?B?RG9uyJt1?= <mihai.dontu@gmail.com>,
        Mario.Limonciello@dell.com
Subject: [PATCH] platform/x86: wmi: Do not mix pages and kmalloc
Message-ID: <20180620213141.GA8957@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe handler_data was being allocated with __get_free_pages()
for no reason I could find. The error path was using kfree(). Since
other things are happily using kmalloc() in the probe path, switch to
kmalloc() entirely. This fixes the error path mismatch and will avoid
issues with CONFIG_HARDENED_USERCOPY_PAGESPAN=y.

Reported-by: Mihai Donțu <mihai.dontu@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/platform/x86/wmi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 8e3d0146ff8c..04791ea5d97b 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -895,7 +895,6 @@ static int wmi_dev_probe(struct device *dev)
 	struct wmi_driver *wdriver =
 		container_of(dev->driver, struct wmi_driver, driver);
 	int ret = 0;
-	int count;
 	char *buf;
 
 	if (ACPI_FAILURE(wmi_method_enable(wblock, 1)))
@@ -917,9 +916,8 @@ static int wmi_dev_probe(struct device *dev)
 			goto probe_failure;
 		}
 
-		count = get_order(wblock->req_buf_size);
-		wblock->handler_data = (void *)__get_free_pages(GFP_KERNEL,
-								count);
+		wblock->handler_data = kmalloc(wblock->req_buf_size,
+					       GFP_KERNEL);
 		if (!wblock->handler_data) {
 			ret = -ENOMEM;
 			goto probe_failure;
@@ -964,8 +962,7 @@ static int wmi_dev_remove(struct device *dev)
 	if (wdriver->filter_callback) {
 		misc_deregister(&wblock->char_dev);
 		kfree(wblock->char_dev.name);
-		free_pages((unsigned long)wblock->handler_data,
-			   get_order(wblock->req_buf_size));
+		kfree(wblock->handler_data);
 	}
 
 	if (wdriver->remove)
-- 
2.17.1


-- 
Kees Cook
Pixel Security
