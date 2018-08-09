Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E294EC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8A821EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BV95FM0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8A821EFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbeHITnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:43:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45924 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732658AbeHITnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:43:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so3035043pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+w0FBtqbjsSFMf97cjh4a/LOshZ8wiAoBUqG1Bp5fvA=;
        b=BV95FM0b8OipL9Nw9cfpebJEyrPhUYpsThRa87bp5fzCCoki+MA/2kw9C29Q1eFMT6
         paucjFoXJKmTsxQ7hO7aB82fr0oVJTMmGOuVPl/l7/01VWEfHIHcn18NQLpl2Z2anPvp
         Pi6c+BIS0RS/0IMjaGdI8MDZK2Q4lFOqn0joE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+w0FBtqbjsSFMf97cjh4a/LOshZ8wiAoBUqG1Bp5fvA=;
        b=oNq1BQyxvcW8gBhuGxVNSXTgDtTkwx8Gur5+kDzBGkgoU9eY+rUdmmywNAzelMEmM7
         tTjU6lJdoiFfVGEjxJjw5sqaOAj2BUn+2VWT64lfzuPOOEPMxVz/9v2A7bxv/4bYT4J+
         4RBdf03aCCTkqLZGLUOVmiMJiPw/VJ+NRd0VROR4Co9V/Hqcg1Pp0FmVQdzf0cKl3z0Y
         fyDIMNoDk/4z5juT0/VRdRJg37fPmOJspkdUCEeIoQMsrtSNJyXbRNOaGshN2i5q1d90
         xJaQ17ZZMxvcHjb9Wdx/R5QU7pQeqEZmt4iIwwntjQ27L3e3pXbnj13sfiyDxYsmV5N9
         4yxw==
X-Gm-Message-State: AOUpUlEWY9QJ5RI9jwWm6nCt1/7Af09Oh75MgatvMhYlmpU/Uc7ciwlr
        uitLM8uzpmML2zR2Bu+k6NJFdg==
X-Google-Smtp-Source: AA+uWPzCl1RWbbohurYWwTP64uUZ7Eh/fNHZ8UbjoAoTzuS6/JVACTDAHhV1Pv5j6EwT/3VCiYQoXA==
X-Received: by 2002:a63:c608:: with SMTP id w8-v6mr2995194pgg.16.1533835049228;
        Thu, 09 Aug 2018 10:17:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id d75-v6sm12866009pfd.49.2018.08.09.10.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:17:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 7/7] firmware: coreboot: Request table region for exclusive access
Date:   Thu,  9 Aug 2018 10:17:22 -0700
Message-Id: <20180809171722.144325-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180809171722.144325-1-swboyd@chromium.org>
References: <20180809171722.144325-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call request_mem_region() on the entire coreboot table to make sure
other devices don't attempt to map the coreboot table in their drivers.
If drivers need that support, it would be better to provide bus APIs
they can use to do that through the mapping created in this file.

Cc: Wei-Ning Huang <wnhuang@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Cc: Samuel Holland <samuel@sholland.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/firmware/google/coreboot_table.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 814913606d22..94c41d814ea5 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -132,6 +132,7 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	struct coreboot_table_header *header;
 	struct resource *res;
 	struct device *dev = &pdev->dev;
+	const char *name;
 	void *ptr;
 	int ret;
 
@@ -153,10 +154,17 @@ static int coreboot_table_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ptr = devm_memremap(dev, res->start,
-			    header->header_bytes + header->table_bytes,
-			    MEMREMAP_WB);
+	len = header->header_bytes + header->table_bytes;
+	res->end = res->start + len - 1;
+	name = res->name ?: dev_name(dev);
 	memunmap(header);
+
+	if (!devm_request_mem_region(dev, res->start, len, name)) {
+		dev_err(dev, "can't request region for resource %pR\n", res);
+		return -EBUSY;
+	}
+
+	ptr = devm_memremap(dev, res->start, len, MEMREMAP_WB);
 	if (!ptr)
 		return -ENOMEM;
 
-- 
Sent by a computer through tubes

