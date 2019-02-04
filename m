Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C9FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626452184B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277391;
	bh=GayiLoJ1no55LrFB6L81/39cwR45NXNLv/8dG/Q+tKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mXPVQ/clm6U+wlm4YuISdXZMXwV2TILWr7MwIaSQKwlvbOWR409FotYqclap66Iji
	 k79PTo4KucvVVdNdv3fR4PIyjiSELh2Wn08ugESsYiQVJD0PKq7TkZqym5Xeqoqk32
	 SgHNzjVAymMiLreTZASHNTojbPS8iZhSJa7g41v8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfBDKtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732084AbfBDKtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:49:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9412E2070C;
        Mon,  4 Feb 2019 10:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277386;
        bh=GayiLoJ1no55LrFB6L81/39cwR45NXNLv/8dG/Q+tKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/YM0QRHuPxfWQ9+YXlLGgMlTzSWcZgpYXgYsqD+LTQbzsZj6DW4YfzMTgns+DkoA
         11Ye4FL5qbrldyP2uKUaBOOR/3PL6KqKpk1vKSNI/dOT5/Jy3CBbwTbXwxmu0kgB4z
         WHsPsxEUDMmqIv1MbH2fer4JMd3VoDqLpx5pkJmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Tull <atull@kernel.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 70/74] of: overlay: add missing of_node_get() in __of_attach_node_sysfs
Date:   Mon,  4 Feb 2019 11:37:23 +0100
Message-Id: <20190204103629.071635521@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

From: Frank Rowand <frank.rowand@sony.com>

commit 5b2c2f5a0ea3a43e0dee78059e34c7cb54136dcc upstream.

There is a matching of_node_put() in __of_detach_node_sysfs()

Remove misleading comment from function header comment for
of_detach_node().

This patch may result in memory leaks from code that directly calls
the dynamic node add and delete functions directly instead of
using changesets.

This commit should result in powerpc systems that dynamically
allocate a node, then later deallocate the node to have a
memory leak when the node is deallocated.

The next commit will fix the leak.

Tested-by: Alan Tull <atull@kernel.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/dynamic.c |    3 ---
 drivers/of/kobj.c    |    4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -275,9 +275,6 @@ void __of_detach_node(struct device_node
 
 /**
  * of_detach_node() - "Unplug" a node from the device tree.
- *
- * The caller must hold a reference to the node.  The memory associated with
- * the node is not freed until its refcount goes to zero.
  */
 int of_detach_node(struct device_node *np)
 {
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -133,6 +133,9 @@ int __of_attach_node_sysfs(struct device
 	}
 	if (!name)
 		return -ENOMEM;
+
+	of_node_get(np);
+
 	rc = kobject_add(&np->kobj, parent, "%s", name);
 	kfree(name);
 	if (rc)
@@ -159,6 +162,5 @@ void __of_detach_node_sysfs(struct devic
 		kobject_del(&np->kobj);
 	}
 
-	/* finally remove the kobj_init ref */
 	of_node_put(np);
 }


