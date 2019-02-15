Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06ECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD5721B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TNPGouO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392921AbfBOWEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:04:15 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10904 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393089AbfBOWDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:03:49 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6737200001>; Fri, 15 Feb 2019 14:03:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 15 Feb 2019 14:03:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 15 Feb 2019 14:03:49 -0800
Received: from nvrsysarch5.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Feb
 2019 22:03:48 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 03/31] mm: migrate: Add tmpfs exchange support.
Date:   Fri, 15 Feb 2019 14:03:06 -0800
Message-ID: <20190215220334.29298-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215220334.29298-1-ziy@nvidia.com>
References: <20190215220334.29298-1-ziy@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550268192; bh=diqLFW2QNnU4w8AwbrLLHI+jIAOfRTJB7J6DX23hrZI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Transfer-Encoding:Content-Type;
        b=TNPGouO5nlWg/9pe/V0ZKIAiRe2RPkwjLNfb4tKTKlSwmLSAI6tkwxTsSHbrgK3em
         9lIgIxPe3xW52UImP1RcQXpij3t1nTvgfLzIb2VcLgTNyr7PgA6Jv19FJ8o7o5wm3m
         TEuF06h4KG4BglTfKWy3Rgwhtax/XYYN+hxVonRdE7YehaicjOeZ+Q4jLKApnJAzkE
         VJNWWqi68PckR0+9TCndFpK/oBN8OUX+/26Vr7GScR5K9ZjIMIDzt34IFDH4ZvzNOj
         XQXRlgiZc/afkTojNTryknrFCPq+zNenWZ2PHI0VydDOxlDj/6YlI2PN+lw0corpOu
         id6BMexbxH+Dg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tmpfs uses the same migrate routine as anonymous pages, enabling
exchange pages for it is easy.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/exchange.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/exchange.c b/mm/exchange.c
index 8cf286fc0f10..851f1a99b48b 100644
--- a/mm/exchange.c
+++ b/mm/exchange.c
@@ -466,7 +466,10 @@ static int exchange_from_to_pages(struct page *to_page=
, struct page *from_page,
 		rc =3D exchange_page_move_mapping(to_page_mapping, from_page_mapping,
 					to_page, from_page, NULL, NULL, mode, 0, 0);
 	} else {
-		if (to_page_mapping->a_ops->migratepage =3D=3D buffer_migrate_page) {
+		/* shmem */
+		if (to_page_mapping->a_ops->migratepage =3D=3D migrate_page)
+			goto exchange_mappings;
+		else if (to_page_mapping->a_ops->migratepage =3D=3D buffer_migrate_page)=
 {
=20
 			if (!page_has_buffers(to_page))
 				goto exchange_mappings;
--=20
2.20.1

