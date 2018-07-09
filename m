Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CF9C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A1520878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CU++987Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A1520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932225AbeGIIn7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:43:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44226 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754528AbeGIIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id d17-v6so1198636eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7WccuFXkkMDrR/QjpKmJWMzoePgpqLAnBtoCNqeveoE=;
        b=CU++987Zjo7X8tMHm+JPncByfR+PfpeF+4o7XFClY9F/IunwWA5Ra5/GHCDHe8j69G
         lSBTbVgHXRnA5MbwRE85UWXFfu33LdeXkCydiBD79iu43hW5htPTP/WVDbLJ7sAKa9Yw
         b+/Q7FtNq0OPU3wiYYvRfKKeVmDQfUa+f+vjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7WccuFXkkMDrR/QjpKmJWMzoePgpqLAnBtoCNqeveoE=;
        b=XvhtNNWZRsxegma5ThkdRmAYSY66YDMfdMqo5RiK0ZMMPperOdKS0i59iNKnnN4pMg
         0zkeEskogHHuG2/IKGLAf+IF/m6H6+GLEhEzfIqp1fEnWu0GuLTyVfNn/gx78vWICypD
         qzCLQLDSfrc2D9ghwz7OrySMtZAk9H3epUrhsVULJ9319UPnhlB6J9+DLR7CmFO1xs45
         s5jG+XlSOBDZYXggZRPEmtAFOOJJw2Lg1zhkAmKoEr/gplEq3KZKG0oG/OnAwCPOF2mV
         C0/fD+ef2IzQqH2cdxo3ilcj9N4t3PmzYhkoRouYt4RLXi484Rw8u9UZMik0vWjQQVhG
         gErA==
X-Gm-Message-State: APt69E3Dj+v7EMgMjgO93IHKWKKDgJAIgpbLRWokCOTT+B4xUK6BqlWQ
        kkj/aONy9fQC1vjYESXlJ5uvkq5+
X-Google-Smtp-Source: AAOMgpe7w4I7bWD2HolPeXTnUCCRKxjnku+0YERJUQd3WhbmbwZMnfzq58+SsRfrCTMErmUY0PXGCw==
X-Received: by 2002:a50:e718:: with SMTP id a24-v6mr1676706edn.278.1531125422554;
        Mon, 09 Jul 2018 01:37:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:37:01 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 05/12] dmar: Use for_each_If
Date:   Mon,  9 Jul 2018 10:36:43 +0200
Message-Id: <20180709083650.23549-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids the inverted conditions compared to the open coded version.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Joerg Roedel <jroedel@suse.de>
---
 include/linux/dmar.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e2433bc50210..99397504e75e 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -85,15 +85,15 @@ extern struct list_head dmar_drhd_units;
 
 #define for_each_active_drhd_unit(drhd)					\
 	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
-		if (drhd->ignored) {} else
+		for_each_if (!drhd->ignored)
 
 #define for_each_active_iommu(i, drhd)					\
 	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
-		if (i=drhd->iommu, drhd->ignored) {} else
+		for_each_if ((i=drhd->iommu, !drhd->ignored))
 
 #define for_each_iommu(i, drhd)						\
 	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
-		if (i=drhd->iommu, 0) {} else 
+		for_each_if ((i=drhd->iommu, true))
 
 static inline bool dmar_rcu_check(void)
 {
@@ -108,7 +108,8 @@ static inline bool dmar_rcu_check(void)
 			NULL, (p) < (c)); (p)++)
 
 #define	for_each_active_dev_scope(a, c, p, d)	\
-	for_each_dev_scope((a), (c), (p), (d))	if (!(d)) { continue; } else
+	for_each_dev_scope((a), (c), (p), (d))	\
+		for_each_if (d)
 
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
-- 
2.18.0

