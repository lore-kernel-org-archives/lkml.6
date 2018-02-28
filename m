Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbeB1TFG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:05:06 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:47046 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeB1TFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:05:04 -0500
X-Google-Smtp-Source: AH8x225QcYXbyJEAcDmPp/Xjd9WzBfe2QGHsvuwvB7hTMnfDv2IdVwdLe4TD4YUVfBw2Yf5NTgKM2w==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
Date: Wed, 28 Feb 2018 11:04:14 -0800
Message-Id: <1519844656-16443-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Create a cache of the nodes that contain a phandle property.  Use this
cache to find the node for a given phandle value instead of scanning
the devicetree to find the node.  If the phandle value is not found
in the cache, of_find_node_by_phandle() will fall back to the tree
scan algorithm.

Size and performance data is in patch 1/2 comments

Changes since v3:
  - of_populate_phandle_cache(): add check for failed memory allocation
  - add patch 2/2 into series instead of as a standalone patch that was
    dependent on patch 1/2 of this series

Changes since v2:
  - add mask to calculation of phandle cache entry
  - which results in better overhead reduction for devicetrees with
    phandle properties not allocated in the monotonically increasing
    range of 1..n
  - due to mask, number of entries in cache potentially increased to
    next power of two
  - minor fixes as suggested by reviewers
  - no longer using live_tree_max_phandle() so do not move it from
    drivers/of/resolver.c to drivers/of/base.c

Changes since v1:
  - change short description from
    of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
  - rebase on v4.16-rc1
  - reorder new functions in base.c to avoid forward declaration
  - add locking around kfree(phandle_cache) for memory ordering
  - add explicit check for non-null of phandle_cache in
    of_find_node_by_phandle().  There is already a check for !handle,
    which prevents accessing a null phandle_cache, but that dependency
    is not obvious, so this check makes it more apparent.
  - do not free phandle_cache if modules are enabled, so that
    cached phandles will be available when modules are loaded



Frank Rowand (2):
  of: cache phandle nodes to reduce cost of of_find_node_by_phandle()
  of: add early boot allocation of of_find_node_by_phandle() cache

 drivers/of/base.c       | 119 ++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/of/fdt.c        |   2 +
 drivers/of/of_private.h |   5 ++
 drivers/of/resolver.c   |   3 --
 4 files changed, 122 insertions(+), 7 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>
