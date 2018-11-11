Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD8DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545A2214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFCE5yEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545A2214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404320AbeKLIXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404230AbeKLIXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:15 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EBFA208A3;
        Sun, 11 Nov 2018 22:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975598;
        bh=61PNrZ4E5WYtSKWPUsX/RdkGQgXelbZgb9dk+luOO7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFCE5yEI3/ie/InW66yTMe9w13sPv6qIQyxlyMAtWx25T2RQxAlojUC94JRhgCNqj
         661I1UVWa2GIv+kPiVcenF6e84+PsejVvTojd/Q+Qhb6AYrfjWiGqbDihnDyVQtUwB
         Kv1S5Ww2SCrJ2mxqKwWrVfTEjyGzZ4Eem9fmXxM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.14 183/222] xen-blkfront: fix kernel panic with negotiate_mq error path
Date:   Sun, 11 Nov 2018 14:24:40 -0800
Message-Id: <20181111221703.369541857@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manjunath Patil <manjunath.b.patil@oracle.com>

commit 6cc4a0863c9709c512280c64e698d68443ac8053 upstream.

info->nr_rings isn't adjusted in case of ENOMEM error from
negotiate_mq(). This leads to kernel panic in error path.

Typical call stack involving panic -
 #8 page_fault at ffffffff8175936f
    [exception RIP: blkif_free_ring+33]
    RIP: ffffffffa0149491  RSP: ffff8804f7673c08  RFLAGS: 00010292
 ...
 #9 blkif_free at ffffffffa0149aaa [xen_blkfront]
 #10 talk_to_blkback at ffffffffa014c8cd [xen_blkfront]
 #11 blkback_changed at ffffffffa014ea8b [xen_blkfront]
 #12 xenbus_otherend_changed at ffffffff81424670
 #13 backend_changed at ffffffff81426dc3
 #14 xenwatch_thread at ffffffff81422f29
 #15 kthread at ffffffff810abe6a
 #16 ret_from_fork at ffffffff81754078

Cc: stable@vger.kernel.org
Fixes: 7ed8ce1c5fc7 ("xen-blkfront: move negotiate_mq to cover all cases of new VBDs")
Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/xen-blkfront.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1910,6 +1910,7 @@ static int negotiate_mq(struct blkfront_
 	info->rinfo = kzalloc(sizeof(struct blkfront_ring_info) * info->nr_rings, GFP_KERNEL);
 	if (!info->rinfo) {
 		xenbus_dev_fatal(info->xbdev, -ENOMEM, "allocating ring_info structure");
+		info->nr_rings = 0;
 		return -ENOMEM;
 	}
 


