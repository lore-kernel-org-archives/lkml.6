Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68181C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FBC222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550051008;
	bh=Kx/lPmqfaKbuUi8+R+pluUKxUMk7XrEfuD5x/lNXBEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XoOIMc3UZAP2lZLzX30DRMxsvtkLjcj2kMGZxZepQ6LXEMsSUWCqMalXyQQ/QJjUf
	 Ij6K0B+tO/fdUPkVkwTdOs0jj0xgzk4J6HdKA9NC+wgEl41fwJw3Xs+saEAsnD0UGR
	 aW4U1iIG1Ve+qyhKiCStT/2QIA4vACsTrNu46uME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbfBMJn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:43:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41509 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfBMJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:43:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so1675516wrs.8;
        Wed, 13 Feb 2019 01:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kk/GG3OgbzX8YIM46cZBNoZxrXJT1E5EGBKwMDd7vXI=;
        b=Bz3r7hwg/pS4VBpQCDU42VsFGdVTUqAjmUX+w61pcuFzNKqLImgTNZjuO6BUKak0WY
         Revm3qcWMjbRcupEOfcrLeM/ev8WVZJOXW0j/NU7soxx3P8cqNfpZ/VGI+7ACFzrIboV
         9hc+Ew6DAyorCBPAmR8Vp6XJjEc4dI0N+wa+gSTOaHK4b7QpBRAzXUySTxb3gsUmm7w8
         MNNx/jdrNXFSOfQ32OcekZXg+YoYy7NqXGDexNJ5pDGPxGSeNkqv61TrdyLl7pHTq3G8
         sESUyJToUNKMje680ICa4/rTL8GDfMVy+VfNqErO7O1w5w/LfzuAXOtiNqlFs9A6tOE7
         E8yg==
X-Gm-Message-State: AHQUAuZ3+sbSNBT/nDjWSLrhKGxOTVVarK5sFwutVRM6MxkejuQ25i9N
        fvtkbz41jin9tSL1yoHoaSQ=
X-Google-Smtp-Source: AHgI3IZGZGyJI5vbywvzsWNw+C5pG4oYQrFxR54toXy/PK1qWoOPyoC6Bgzg4NOhsQ5CAtgQdn/loQ==
X-Received: by 2002:a5d:4b07:: with SMTP id v7mr6179697wrq.281.1550051004381;
        Wed, 13 Feb 2019 01:43:24 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-151-205.eurotel.cz. [37.188.151.205])
        by smtp.gmail.com with ESMTPSA id x21sm6111396wmi.28.2019.02.13.01.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 01:43:23 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 2/2] mm: be more verbose about zonelist initialization
Date:   Wed, 13 Feb 2019 10:43:15 +0100
Message-Id: <20190213094315.3504-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212095343.23315-3-mhocko@kernel.org>
References: <20190212095343.23315-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

We have seen several bugs where zonelists have not been initialized
properly and it is not really straightforward to track those bugs down.
One way to help a bit at least is to dump zonelists of each node when
they are (re)initialized.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Sorry for spamming. I have screwed up ammending the previous version.

 mm/page_alloc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e097f336126..52e54d16662a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5234,6 +5234,8 @@ static void build_zonelists(pg_data_t *pgdat)
 	int node, load, nr_nodes = 0;
 	nodemask_t used_mask;
 	int local_node, prev_node;
+	struct zone *zone;
+	struct zoneref *z;
 
 	/* NUMA-aware ordering of nodes */
 	local_node = pgdat->node_id;
@@ -5259,6 +5261,11 @@ static void build_zonelists(pg_data_t *pgdat)
 
 	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
 	build_thisnode_zonelists(pgdat);
+
+	pr_info("node[%d] zonelist: ", pgdat->node_id);
+	for_each_zone_zonelist(zone, z, &pgdat->node_zonelists[ZONELIST_FALLBACK], MAX_NR_ZONES-1)
+		pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
+	pr_cont("\n");
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
2.20.1

