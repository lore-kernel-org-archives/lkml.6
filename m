Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36193C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0A121726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359741;
	bh=4HW7rPqgB6v3jN170n6vdMFJV9KnYSxVlOzMFSVe5Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ua+gpBOVy3vQh5vYsi4e0OUtAigBR3q5H7Bd7ZVW+rFZ0ABDOxlVdI/0/SeEeMj3B
	 oEaruWDsRcI72xEyWq5LPWWI7ShYJ/4xP7NN2dShrSmWV5H8uB+0JM2vcXcsJKhmg7
	 DYPes1SwY5rWJ87tKA29I5mi+MftApX/bsXN28u4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbfAXTzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:55:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730856AbfAXTgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:36:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB72B21905;
        Thu, 24 Jan 2019 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358602;
        bh=4HW7rPqgB6v3jN170n6vdMFJV9KnYSxVlOzMFSVe5Hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPc8F0tOEGGyN6iKnQiwrMANghovEXnYD8Sabn+Z0lquImv0zzxd53eOIjRaVmEHA
         9NvnnHSz938FZO1Xd6f0QMcl5ury0zS43rTttC+ytHYEz0zM8xTqLUn2NpE2bbdhon
         lP6MTYkRGYyVYzA8yxhkOPYZAZtOEjkiWhdiNIws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Tull <atull@kernel.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 019/106] of: overlay: add missing of_node_put() after add new node to changeset
Date:   Thu, 24 Jan 2019 20:19:36 +0100
Message-Id: <20190124190207.596759845@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7c528e457d53c75107d5aa56892316d265c778de ]

The refcount of a newly added overlay node decrements to one
(instead of zero) when the overlay changeset is destroyed.  This
change will cause the final decrement be to zero.

After applying this patch, new validation warnings will be
reported from the devicetree unittest during boot due to
a pre-existing devicetree bug.  The warnings will be similar to:

  OF: ERROR: memory leak before free overlay changeset,  /testcase-data/overlay-node/test-bus/test-unittest4

This pre-existing devicetree bug will also trigger a WARN_ONCE() from
refcount_sub_and_test_checked() when an overlay changeset is
destroyed without having first been applied.  This scenario occurs
when an error in the overlay is detected during the overlay changeset
creation:

  WARNING: CPU: 0 PID: 1 at lib/refcount.c:187 refcount_sub_and_test_checked+0xa8/0xbc
  refcount_t: underflow; use-after-free.

  (unwind_backtrace) from (show_stack+0x10/0x14)
  (show_stack) from (dump_stack+0x6c/0x8c)
  (dump_stack) from (__warn+0xdc/0x104)
  (__warn) from (warn_slowpath_fmt+0x44/0x6c)
  (warn_slowpath_fmt) from (refcount_sub_and_test_checked+0xa8/0xbc)
  (refcount_sub_and_test_checked) from (kobject_put+0x24/0x208)
  (kobject_put) from (of_changeset_destroy+0x2c/0xb4)
  (of_changeset_destroy) from (free_overlay_changeset+0x1c/0x9c)
  (free_overlay_changeset) from (of_overlay_remove+0x284/0x2cc)
  (of_overlay_remove) from (of_unittest_apply_revert_overlay_check.constprop.4+0xf8/0x1e8)
  (of_unittest_apply_revert_overlay_check.constprop.4) from (of_unittest_overlay+0x960/0xed8)
  (of_unittest_overlay) from (of_unittest+0x1cc4/0x2138)
  (of_unittest) from (do_one_initcall+0x4c/0x28c)
  (do_one_initcall) from (kernel_init_freeable+0x29c/0x378)
  (kernel_init_freeable) from (kernel_init+0x8/0x110)
  (kernel_init) from (ret_from_fork+0x14/0x2c)

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/overlay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index eda57ef12fd0..baa9cee6fa2c 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -378,7 +378,9 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 		if (ret)
 			return ret;
 
-		return build_changeset_next_level(ovcs, tchild, node);
+		ret = build_changeset_next_level(ovcs, tchild, node);
+		of_node_put(tchild);
+		return ret;
 	}
 
 	if (node->phandle && tchild->phandle)
-- 
2.19.1



