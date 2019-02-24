Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E4C00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129A820842
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE+GB6xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfBXMe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 07:34:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41641 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfBXMe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 07:34:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id y5so3188353plk.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 04:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IofwoUpnukhHD5Lom+sSlZv54BEm4R4tYJZvLTxZCAY=;
        b=cE+GB6xtHZOovXvIRtQuHIi4BXrBkV/809xXhQhyqY+Y8dpT40VE+KkpGF3CJTn8Pb
         B3ji3dgo5mmiU6ThZgIS/VVkvGLvgx/mrqrHncYlpzPZD4O/Pf8yM3XgBcP9Ab1ldvpD
         liq0uisXEblFwagMgK0FeNQiTIU65+NpCxXOAvEe5W3scuxMhTv0mBn4WPCSlB9slsp4
         kENdWSCWZx0DjL8rrnXlKGLPO/Kxfc3glrtT46N/kwBEWHhPeIEgoshTNTddWWGXBS3W
         v5uo1b8o5UXskMju4HkwXAqi5D9kdboBZp1iVtWgJ45Dt/cDiqqGyG7OcpBzDwgTRXO2
         XNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IofwoUpnukhHD5Lom+sSlZv54BEm4R4tYJZvLTxZCAY=;
        b=I7guohIjR1klQTlwph+3ltdtd4Sd9s7zOIz8ThcRSaPJJqQdYOK1aYKRHXQhWR/wNp
         WhEMwQiQBaTL7q1Qk/bPN7JZUDXBSXWBQwJncqxa4dIV1HM0dZ+IDAQ0/8IGR2E77nxF
         NqT60+scV705Y0j4de7BwHAac7EQVD+GR/i5TUy9Wy1DgPiQcl2gN0MyU43cAvQCL7es
         RGm+5Y9yWJB0PmSYoBDMQno+ALqqlrqR7WtxiEN95qVCDAyxsAX2J2yUYcinVdyy5sX+
         bqDEOMNwKYAGhgSidKHzXoO9bTJDK5Zw2C443xSRs6KDMxHccxXaoczX9PzwjlA9PKhH
         9bDA==
X-Gm-Message-State: AHQUAubIC63J0h7PKEMwCc/BUrBY/6+EotnauRA5E0aRCIpBYrB3NpG4
        mx88UyKRTiycY/1OtJ8bEw==
X-Google-Smtp-Source: AHgI3IZtgIHa4u4QsONmKsC8s7teLj7KUuAEy8OSe7nq6FfrFdBZ9etnX7dc6bSBaVB11shNbDMJ7g==
X-Received: by 2002:a17:902:2a66:: with SMTP id i93mr13853538plb.128.1551011667204;
        Sun, 24 Feb 2019 04:34:27 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6sm9524634pgb.2.2019.02.24.04.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 04:34:26 -0800 (PST)
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
Subject: [PATCH 0/6] make memblock allocator utilize the node's fallback info
Date:   Sun, 24 Feb 2019 20:34:03 +0800
Message-Id: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are NUMA machines with memory-less node. At present page allocator builds the
full fallback info by build_zonelists(). But memblock allocator does not utilize
this info. And for memory-less node, memblock allocator just falls back "node 0",
without utilizing the nearest node. Unfortunately, the percpu section is allocated 
by memblock, which is accessed frequently after bootup.

This series aims to improve the performance of per cpu section on memory-less node
by feeding node's fallback info to memblock allocator on x86, like we do for page
allocator. On other archs, it requires independent effort to setup node to cpumask
map ahead.


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

Pingfan Liu (6):
  mm/numa: extract the code of building node fall back list
  mm/memblock: make full utilization of numa info
  x86/numa: define numa_init_array() conditional on CONFIG_NUMA
  x86/numa: concentrate the code of setting cpu to node map
  x86/numa: push forward the setup of node to cpumask map
  x86/numa: build node fallback info after setting up node to cpumask
    map

 arch/x86/include/asm/topology.h |  4 ---
 arch/x86/kernel/setup.c         |  2 ++
 arch/x86/kernel/setup_percpu.c  |  3 --
 arch/x86/mm/numa.c              | 40 +++++++++++-------------
 include/linux/memblock.h        |  3 ++
 mm/memblock.c                   | 68 ++++++++++++++++++++++++++++++++++++++---
 mm/page_alloc.c                 | 48 +++++++++++++++++------------
 7 files changed, 114 insertions(+), 54 deletions(-)

-- 
2.7.4

