Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D044C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D111120578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130723;
	bh=6cXCHwMa7KczsnGsbZpt9TVAMfHslMfBv9Hi/prHbNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zN/b8/27q87MOhD1iQLMhLrwtK08rqKbrmHpGFdiNGYs/8MEjUDN5vw4FSDuY696y
	 Pqjqutj5Rw/j4Zn/6t4Vxgx3JLjm3Jyd4qkU18r45baFouHeGKTdu1PFV4ijEbxO7G
	 5gIb+DFoK/lYiVtlPqnanLUiLH1HnEsqerP1m13o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbfBYVim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:38:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733240AbfBYVgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0724C217F5;
        Mon, 25 Feb 2019 21:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130605;
        bh=6cXCHwMa7KczsnGsbZpt9TVAMfHslMfBv9Hi/prHbNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8o2Hzi3MSOQbthuJ8ixujHl9ukjrdDjSmg8w5YLPuoV4jlQslCWxgKAdWjO5hKuQ
         SL1LvLUepsrVVfyN44KGjI21HOnXGmq5flSk5Ufo30R4pMIpIeufBmTLEjmMK7kR9j
         4jFegmYApkwLbJeO26lwDv7PzULL47TQybY5caUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.20 173/183] staging: erofs: add a full barrier in erofs_workgroup_unfreeze
Date:   Mon, 25 Feb 2019 22:12:26 +0100
Message-Id: <20190225195124.298320355@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit 948bbdb1818b7ad6e539dad4fbd2dd4650793ea9 upstream.

Just like other generic locks, insert a full barrier
in case of memory reorder.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/internal.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -209,6 +209,11 @@ static inline bool erofs_workgroup_try_t
 static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
 					    int orig_val)
 {
+	/*
+	 * other observers should notice all modifications
+	 * in the freezing period.
+	 */
+	smp_mb();
 	atomic_set(&grp->refcount, orig_val);
 	preempt_enable();
 }


