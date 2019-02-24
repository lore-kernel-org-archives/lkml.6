Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92601C10F19
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FFA20842
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2Y9Cztq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfBXMew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 07:34:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41319 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfBXMev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 07:34:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id d25so3184484pfn.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 04:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6zZP7jJIxHvkxThoQW962w7WsAbjwnHfV/pBRova8jw=;
        b=d2Y9CztqZjtQy4UJJ2JLeCM2Nx1Rp0TIqG0sLvJJYN5BBmdxAbZAT0PO0MGPvOBgPJ
         cFZu9aubJse8xqxOe5l1Xl2/EALdbw0IPYh+iY2GImLvNo17BST6hP7RynsjNDzhyddH
         qhfJhKoAKpiJWnJVa0Oi8kx8W14Zsu9Ye++4TnFw3j7YP0wdp7mEHEnsoSYRSFEJBAq8
         R17q+wTIJus3kgWzBtoUF3/LA8pksbAMFTZIRJqyk3BMnu+WvqepNntYMwrzyM8gA9Lz
         nVlGBNhhPVlsG25Vr3nRF3eng/nAEOfwSucaWWiO2sKlf5YFM0rt/ikuWtVDmVvfA7tO
         Q3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6zZP7jJIxHvkxThoQW962w7WsAbjwnHfV/pBRova8jw=;
        b=iddDFSEvmb7LsTCbkVP6Q10rju8s8RfbfXi2uUAfrGGQcPslfqF2rX9EctMBK0QkpB
         yOHfcKsHKiRrBe9PGJo2nP4poYnEF63S+a2JAgLnFXX7FLzpgzUEUegxp7YNSkUAfV89
         52tsTltpPHs8hq/jIfk7ywe7lqoyrLGSL75sGUl1cqFeCKZ8ijn+3FrhIIreDdVtviOj
         PJ44opyXiDXcE3d+N3nhRZ7BEHeYWQhp9YCXAV15HSaUct7jfyAur1vMgMj8JQsPlHOI
         2nIMFc2834Am8NAp0HYC/XIvenYDIWO1LoS+/c6RH5WaRYTyFniQU+bYkgLO5Snpz3cw
         i2zQ==
X-Gm-Message-State: AHQUAuYtfENs7B1n5eLB8wXxEX6gTkXeLJB3GOvbx4Kfb7tyj6uAC3br
        o3RUjePpsztTZjcqOaeyhQ==
X-Google-Smtp-Source: AHgI3Ia8g+BD78ii73yBVfLkrh2EIZUmMEN2tSL9/vXwv/TCm70uYK4mRBtcqN5KpkpAfPfIcCdM4w==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr13978322pfc.135.1551011690757;
        Sun, 24 Feb 2019 04:34:50 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6sm9524634pgb.2.2019.02.24.04.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 04:34:50 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org, linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] x86/numa: define numa_init_array() conditional on CONFIG_NUMA
Date:   Sun, 24 Feb 2019 20:34:06 +0800
Message-Id: <1551011649-30103-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For non-NUMA, it turns out that numa_init_array() has no operations. Make
separated definition for non-NUMA and NUMA, so later they can be combined
into their counterpart init_cpu_to_node().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mel Gorman <mgorman@suse.de>
CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Andi Kleen <ak@linux.intel.com>
CC: Petr Tesarik <ptesarik@suse.cz>
CC: Michal Hocko <mhocko@suse.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Daniel Vacek <neelx@redhat.com>
CC: linux-kernel@vger.kernel.org
---
 arch/x86/mm/numa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1308f54..bfe6732 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -599,6 +599,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 	return 0;
 }
 
+#ifdef CONFIG_NUMA
 /*
  * There are unfortunately some poorly designed mainboards around that
  * only connect memory to a single CPU. This breaks the 1:1 cpu->node
@@ -618,6 +619,9 @@ static void __init numa_init_array(void)
 		rr = next_node_in(rr, node_online_map);
 	}
 }
+#else
+static void __init numa_init_array(void) {}
+#endif
 
 static int __init numa_init(int (*init_func)(void))
 {
-- 
2.7.4

