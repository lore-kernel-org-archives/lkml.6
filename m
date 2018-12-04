Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A31C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BE020834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iIY1WzCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BE020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLDAnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:43:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45016 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeLDAnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:43:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so6498339pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 16:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2KQNJO8uFkDQm49FDynLRoSgm5JYnbeN3mqYf/XYMRY=;
        b=iIY1WzCkG7EL2UBPkpKpeI5ri9n2f/UzUpLsQlRLY3UDMThHLmja1whxyEn4ysQ6DE
         NJLBXTZfR7Zg/nOYVJ3IULdI95lNagbSPIsXB/ifeNeO7G2U/XsFOKdn1pTb2SStiUTj
         hgaKcgauhxhy5lvMUB0XLqyI+JfXtfLLCk1jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2KQNJO8uFkDQm49FDynLRoSgm5JYnbeN3mqYf/XYMRY=;
        b=hQOheSwgq7+MdC9scuS1CdS/eSXoUu+96IIC9QVQy7KR+qXNqJCI2UZF8apTb8GRQ8
         4GTR2P+bY2GEaAqpSbYNagWrV/lLyoK7Jai7Yb93QHtMJgG0PaDVH1Kf7Sc7q7XTEoIK
         qv8H/UV2B0VOh8fZgmYD5zBiuAIrw0gdPBi8fLQbbzc9PnoAJcXbRceiy/RkH5vq5Fky
         x9jFTDvtfl9EvcbPlsXPco103TsB/HkurYaPpgcY+FtuNy4mIXDHs4aHpA5yuhJbwaUC
         PKy7s96j5GIp7i4JmW/AbMJbjXN50augoqltAK6QQTyatH87R4gV3V1sZlqf3rE3Sgkm
         HDig==
X-Gm-Message-State: AA+aEWYUj9U3oh1CT5c/0I/dSAKULAuWH0c8Ka+tKA6CyNc+PhHJAjiD
        jQzd5vWYd+LusnE4Aj8g25Sg8w==
X-Google-Smtp-Source: AFSGD/W/E9nCmWDZPFBVgs+3o4K5zFb9/NfpH2z1WeK+C/+Mdbm3zKm8ERTWyGJ/Ap3pbqgwS8IKbA==
X-Received: by 2002:a65:60c2:: with SMTP id r2mr14030930pgv.393.1543884227492;
        Mon, 03 Dec 2018 16:43:47 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id z62sm21483133pfl.33.2018.12.03.16.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 16:43:46 -0800 (PST)
Date:   Mon, 3 Dec 2018 16:43:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] pstore/ram: Avoid NULL deref in ftrace merging failure path
Message-ID: <20181204004345.GA48115@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given corruption in the ftrace records, it might be possible to allocate
tmp_prz without assigning prz to it, but still marking it as needing to
be freed, which would cause at least a NULL dereference.

smatch warnings:
fs/pstore/ram.c:340 ramoops_pstore_read() error: we previously assumed 'prz' could be null (see line 255)

https://lists.01.org/pipermail/kbuild-all/2018-December/055528.html

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 2fbea82bbb89 ("pstore: Merge per-CPU ftrace records into one")
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index e6d9560ea455..96f7d32cd184 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -291,6 +291,7 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 					  GFP_KERNEL);
 			if (!tmp_prz)
 				return -ENOMEM;
+			prz = tmp_prz;
 			free_prz = true;
 
 			while (cxt->ftrace_read_cnt < cxt->max_ftrace_cnt) {
@@ -309,7 +310,6 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
 					goto out;
 			}
 			record->id = 0;
-			prz = tmp_prz;
 		}
 	}
 
-- 
2.17.1


-- 
Kees Cook
