Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C651C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E0F218A9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E0F218A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeHQMC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:02:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44168 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeHQMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:02:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so6420271wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 02:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZKTVdVzaaqaPNn6SYBmpsx/A36t/k0Cv9b+YcZO4KTE=;
        b=lc+2B+ysThKH4d2TC9reEzY1vr1BfhcpW2gc0oPAwZdjbkVZUpU7cZENZAvrt8aXOa
         SJsxT6RP6cAuLsCXFmrdQ/8rzWWx/BxdxqLB3cwJuo+XrzTN7cB7eZDbPitGHRWoupG1
         6PweGJQ5Rfo0hw3fgyzdwbqqimuwvLyeoc/eJ8G84tttE6+6Pt3DK2dQVLoJIhXZH2ab
         KAYf801Q9jjDK4WPpk+4g8mnszj4yrJm50S9EcSa8Mif5OeCK7oQ2FjjG/VZeCc0wPWh
         eHb+YjGLm0cdTQ9dldsTSYlDKt0F7gMUvHv79e2bzWCQ1pJyQ0WzFxA/McTkFkvJaOJa
         1UlA==
X-Gm-Message-State: AOUpUlFFSGfYjujR00P589Bqn87ojIZUKyTRjtIFRGlNBZw5i9uIUscG
        9ciB69hHxC8zIVeLwOnL/QE=
X-Google-Smtp-Source: AA+uWPy8bWCaoomaz6PvUCUjUE+K4Aule55qIbUWO3nfUAAYrE5JdAFVt3otQGqMKjY5UXO5fvFu2w==
X-Received: by 2002:adf:e249:: with SMTP id n9-v6mr2746375wri.205.1534496422019;
        Fri, 17 Aug 2018 02:00:22 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id o33-v6sm1362875wrf.11.2018.08.17.02.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 02:00:21 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 94CF612492D;
        Fri, 17 Aug 2018 11:00:20 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 0/4] Refactoring for remove_memory_section/unregister_mem_sect_under_nodes
Date:   Fri, 17 Aug 2018 11:00:13 +0200
Message-Id: <20180817090017.17610-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

v3 -> v4:
        - Make nodemask_t a stack variable
        - Added Reviewed-by from David and Pavel

v2 -> v3:
        - NODEMASK_FREE can deal with NULL pointers, so do not
          make it conditional (by David).
        - Split up node_online's check patch (David's suggestion)
        - Added Reviewed-by from Andrew and David
        - Fix checkpath.pl warnings

This patchset does some cleanups and refactoring in the memory-hotplug code.

The first and the second patch are pretty straightforward, as they
only remove unused arguments/checks.

The third patch refactors unregister_mem_sect_under_nodes a bit by re-defining
nodemask_t as a stack variable. (More details in Patch3's changelog)

The fourth patch removes a node_online check. (More details in Patch4's changelog)
Since this change has a patch for itself, we could quickly revert it
if we notice that something is wrong with it, or drop it if people
are concerned about it.

Oscar Salvador (4):
  mm/memory-hotplug: Drop unused args from remove_memory_section
  mm/memory_hotplug: Drop mem_blk check from
    unregister_mem_sect_under_nodes
  mm/memory_hotplug: Define nodemask_t as a stack variable
  mm/memory_hotplug: Drop node_online check in
    unregister_mem_sect_under_nodes

 drivers/base/memory.c |  5 ++---
 drivers/base/node.c   | 22 ++++++----------------
 include/linux/node.h  |  5 ++---
 3 files changed, 10 insertions(+), 22 deletions(-)

-- 
2.13.6

