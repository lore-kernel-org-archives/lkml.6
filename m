Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2470C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CFE218D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549965245;
	bh=5tO5qtQ//9if0d86zaM2nX5DcSQrDiXJ8YFoZXoVdMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Rh51M7lkr+7ZJ0tkOeT/0wnZkTscP40MOzG4pw3X7g9R+S8rg5RD7sppHgxkGA4i
	 RrDmK2gBUr9MvW1Rgxlb4Z/jCF8FIWKK3DpU9TGW/95wwRXbkzjvfO2iTlca0aqIw1
	 onnRlhx9+LpIms8nlnH0gor2O9RMmsJdmqArIoxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfBLJyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:54:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39505 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfBLJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:53:59 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so1623730edt.6;
        Tue, 12 Feb 2019 01:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWzlY1PPQ+/67pm+/z2QkBDdCvOyUHPQEXMFpI7S4nM=;
        b=kOFbL1iAflsYQzO1V4jwH69noGtlb2GhydHWl0tSVnGgLTpm5zPuBdWwAYEsXnjZe2
         LF/pg9Wj7ju6Ky2fR+xJJkhWP1BW7NgefSVFhHhlMddxZ35E5wIdmpq0ULcqxZKbT5B1
         IhpB1M161nj2xSsRF0g5/DUmEoj2fhpANJJxoShyq5zxYU36i1xas9oA3XWy7zJEZ0wx
         caVju/d/akun5wuFnmp6kp9uI3IZ450T9UkWFblw5pBWTW8aS+710YQwAJvVSkANVVg3
         Sc+Yr8Iy3CGj1pmcoYn2Wd3IZH3dGj5o7iri9+bgAUAc6kg1B9+YrVNKV3UuC0E4YNso
         fZXw==
X-Gm-Message-State: AHQUAub4i8dFYJfysyl3BII9NFZVXitjIoGD7QOM15zAtgUFRZaSpO0m
        k+ICvsBobL/ZkQrw2sb/NHs=
X-Google-Smtp-Source: AHgI3IaDbQaoXUddyxRvptd1P3Q3Dkjw68Kopy2TfOs74h07Sehg+Np/NzTW4ul6z23IsVehH0xtyg==
X-Received: by 2002:a17:906:18f1:: with SMTP id e17mr2093489ejf.82.1549965237531;
        Tue, 12 Feb 2019 01:53:57 -0800 (PST)
Received: from tiehlicka.microfocus.com (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i14sm2876791ejy.25.2019.02.12.01.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 01:53:56 -0800 (PST)
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
Subject: [PATCH 2/2] mm: be more verbose about zonelist initialization
Date:   Tue, 12 Feb 2019 10:53:43 +0100
Message-Id: <20190212095343.23315-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212095343.23315-1-mhocko@kernel.org>
References: <20190212095343.23315-1-mhocko@kernel.org>
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
 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e097f336126..c30d59f803fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5259,6 +5259,11 @@ static void build_zonelists(pg_data_t *pgdat)
 
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

