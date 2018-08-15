Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B81C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CAE20C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CAE20C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeHORe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:34:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47064 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbeHORez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:34:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id h14-v6so1331175wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HKTu6y7RFvN/c9bNONpAZT5RMhKAMFpnA8OBIKrulj4=;
        b=XvDXDrlJajZDyKgGCTjhnXatCVuKoA62YqVwpwZtLyJ/DNMe+DhhND8IkeSsNvMOFr
         iB1ggn+/Gin/oJXP5K2zaO4xrh4wRFpEcHzI4FVsjI2AdtDxgd2aNhD+K4C20eUgCDjt
         6mpYFvjYT4+1ivCwJfRkbyciaz3jmxWScWTYw20V5EQwP8yvxlseSZG5OSGTXtRVufsl
         xQKkf4YwP/n+SfYN/WT5P71El2BrxB+YMNDSXy0KYxmG+dJLXXLZl9OMQqv679rtn/jv
         W1oyRDisSgW45tKpqY7QwCDDLnOuWMJ6thZeG1p0GmUyqFoGIzdQhKExUbjf4BrnAWyU
         nP8Q==
X-Gm-Message-State: AOUpUlHKh+BG/sQ6JnJUqkVXs7NfUvyA1ReYShrpFS9HKzs3TYpK5BTs
        RFida8vq4NkV9B2aI4eJSgU=
X-Google-Smtp-Source: AA+uWPyVMqcDc0hq5aVceYRpuuHsQsIQqvGeStNN7n2rWVKCmxP/V0BfsIC5ZJfGyGcKL4M7qwB9bg==
X-Received: by 2002:adf:97cf:: with SMTP id t15-v6mr16509928wrb.283.1534344149128;
        Wed, 15 Aug 2018 07:42:29 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id p11-v6sm16189775wrs.51.2018.08.15.07.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:42:28 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id AAFB312489C;
        Wed, 15 Aug 2018 16:42:27 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, dan.j.williams@intel.com,
        yasu.isimatu@gmail.com, jonathan.cameron@huawei.com,
        david@redhat.com, Pavel.Tatashin@microsoft.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v3 0/4] Refactoring for remove_memory_section/unregister_mem_sect_under_nodes
Date:   Wed, 15 Aug 2018 16:42:15 +0200
Message-Id: <20180815144219.6014-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

v2 -> v3:
        - NODEMASK_FREE can deal with NULL pointers, so do not
          make it conditional (by David).
        - Split up node_online's check patch (David's suggestion)
        - Added Reviewed-by from Andrew and David
        - Fix checkpath.pl warnings

This patchset does some cleanups and refactoring in the memory-hotplug code.

The first and the second patch are pretty straightforward, as they
only remove unused arguments/checks.

The third one refactors unregister_mem_sect_under_nodes.
This is needed to have a proper fallback in case we could not allocate
memory. (details can be seen in patch3).

The fourth patch removes a node_online check.
We are getting the nid from pages that are yet not removed, but a node
can only be offline when its memory/cpu's have been removed.
Therefore, we do not really need to check for the node to be online here.
Since this change has a patch for itself, we could quickly revert it
if we notice that something is wrong with it, or drop it if people
are concerned about it.

Oscar Salvador (4):
  mm/memory-hotplug: Drop unused args from remove_memory_section
  mm/memory_hotplug: Drop mem_blk check from
    unregister_mem_sect_under_nodes
  mm/memory_hotplug: Refactor unregister_mem_sect_under_nodes
  mm/memory_hotplug: Drop node_online check in
    unregister_mem_sect_under_nodes

 drivers/base/memory.c |  5 ++---
 drivers/base/node.c   | 29 +++++++++++++++--------------
 include/linux/node.h  |  5 ++---
 3 files changed, 19 insertions(+), 20 deletions(-)

-- 
2.13.6

