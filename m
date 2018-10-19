Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C3CECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E9021476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 13:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIrpvLVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E9021476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJSVhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 17:37:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43454 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJSVhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 17:37:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id 30-v6so15863029plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=DmkUxFq3alZDvZbpJ1QQSc40LH+wBpGLOfjZWg+ByqE=;
        b=sIrpvLVnssP31UMCplWHDry1uuQXCivPNXFp3wm8rbLSfQVq/y6/WxZ1gPtk7SDrtZ
         kt7quGQLkcOfThg301xF1D7Xz/nywZFBjX6Q3nwwbOVcthYYYrWf1vqAU1C8McbMo3My
         tnSdSUPdUWeHJsNN3A5wMuo+akyr5FhQqV5ExXR8vUDvCC/WnWdBufGDXG5jUQfBvyJj
         PINPAUMMoSYnMsV1On9zblFUi4613jgYnVFgs1w/LxIAnvJn7h+Aob/SctIhleHTGQKH
         qnVdnOdfngYkph3eGWvCoHCGvMRFIY81OfX9iyaAxz49jOXmeQWYLrrmDlltMITNZFGW
         xavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=DmkUxFq3alZDvZbpJ1QQSc40LH+wBpGLOfjZWg+ByqE=;
        b=JlW0nOkBD81r/cDRPlQjc5imkRKsnzTeMJ8w1KnE0MPIT1Jw4qQKKL7QLmwlQTr9vj
         BVTeCruhbM/fAOeSoTbr5OaYWSmBblOPPkaBOpgNDYESDkXNJFCNjpgYta0eK3T4FPGE
         aIM+RvO4zWCMSrn5OPEhjiNyq0UVmc5h648BdDi0mGwREu+sQAViFiPmBEqgyL/W0dXl
         hff0OHGedUwbSfk81ThUKWTYkvgjK79zurX5M3deCWdUQQhgqAMqTwOcUBJZEv2sySqn
         CJaVqj2UjRNz4+LcHTYbsX2haaMzKtv6zmOitz3LmhRs8W1msS6oFVFGqgxGdM85Du90
         jIvg==
X-Gm-Message-State: ABuFfoiUxFnqzTYcCvubkVXJTs/rkXuzS18DANaMnexHdSwj3sg7MIIX
        WCIG2ULu4BcBmiSM6Bd5c0o=
X-Google-Smtp-Source: ACcGV60ygsm6R2/TRoV6HPJqRm9ughm9BZ5EP0OP8iFgE91oZf/02/FGnLAfedOUqSyXlhH7NsaCbg==
X-Received: by 2002:a17:902:74c4:: with SMTP id f4-v6mr449320plt.52.1539955885801;
        Fri, 19 Oct 2018 06:31:25 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id t184-v6sm25224782pfd.14.2018.10.19.06.31.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 06:31:24 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2] cacheinfo: Keep the old value if of_property_read_u32 fails
Date:   Fri, 19 Oct 2018 21:31:29 +0800
Message-Id: <1539955889-9968-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 448a5a552f336bd7b847b1951 ("drivers: base: cacheinfo: use OF
property_read_u32 instead of get_property,read_number") makes cache
size and number_of_sets be 0 if DT doesn't provide there values. I
think this is unreasonable so make them keep the old values, which is
the same as old kernels.

Fixes: 448a5a552f33 ("drivers: base: cacheinfo: use OF property_read_u32 instead of get_property,read_number")
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/cacheinfo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 5d5b598..dd6a685 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -79,8 +79,7 @@ static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].size_prop;
 
-	if (of_property_read_u32(np, propname, &this_leaf->size))
-		this_leaf->size = 0;
+	of_property_read_u32(np, propname, &this_leaf->size);
 }
 
 /* not cache_line_size() because that's a macro in include/linux/cache.h */
@@ -114,8 +113,7 @@ static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].nr_sets_prop;
 
-	if (of_property_read_u32(np, propname, &this_leaf->number_of_sets))
-		this_leaf->number_of_sets = 0;
+	of_property_read_u32(np, propname, &this_leaf->number_of_sets);
 }
 
 static void cache_associativity(struct cacheinfo *this_leaf)
-- 
2.7.0

