Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BE5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C16208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C16208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbeHAVvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:51:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbeHAVvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:51:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DBBC7A9;
        Wed,  1 Aug 2018 13:04:20 -0700 (PDT)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC2093F5BA;
        Wed,  1 Aug 2018 13:04:19 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, mhocko@suse.com,
        vbabka@suse.cz, Punit.Agrawal@arm.com, Lorenzo.Pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 0/2] harden alloc_pages against bogus nid
Date:   Wed,  1 Aug 2018 15:04:16 -0500
Message-Id: <20180801200418.1325826-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thread "avoid alloc memory on offline node"

https://lkml.org/lkml/2018/6/7/251

Asked at one point why the kzalloc_node was crashing rather than
returning memory from a valid node. The thread ended up fixing
the immediate causes of the crash but left open the case of bad
proximity values being in DSDT tables without corrisponding
SRAT/SLIT entries as is happening on another machine.

Its also easy to fix that, but we should also harden the allocator
sufficiently that it doesn't crash when passed an invalid node id.
There are a couple possible ways to do this, and i've attached two
separate patches which individually fix that problem.

The first detects the offline node before calling
the new_slab code path when it becomes apparent that the allocation isn't
going to succeed. The second actually hardens node_zonelist() and
prepare_alloc_pages() in the face of NODE_DATA(nid) returning a NULL
zonelist. This latter case happens if the node has never been initialized
or is possibly out of range. There are other places (NODE_DATA &
online_node) which should be checking if the node id's are > MAX_NUMNODES.

Jeremy Linton (2):
  slub: Avoid trying to allocate memory on offline nodes
  mm: harden alloc_pages code paths against bogus nodes

 include/linux/gfp.h | 2 ++
 mm/page_alloc.c     | 2 ++
 mm/slub.c           | 2 ++
 3 files changed, 6 insertions(+)

-- 
2.14.3

