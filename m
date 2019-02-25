Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C155BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8593A20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131236;
	bh=EjYUUiku/L4usLkMT0OQ9f/4LaAAbeP1iZukM+LXWk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EWp3fgUnKfzyupGpKn53hrydin/wuhbryYKHyDFcIDH2IGWIEoCiveQfz10UvoRfj
	 J4H9QlkWKxgoNX7qH2W39JGmoy34OEhWj6U+JtqYqt0U/wfbn4TBzOY7dRDf9UZLNp
	 CsHtuO2zWCrYosXZiwtueL+wgZ8y1y+On4o2/lgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbfBYVrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:47:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731781AbfBYV1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:27:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB172087C;
        Mon, 25 Feb 2019 21:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130060;
        bh=EjYUUiku/L4usLkMT0OQ9f/4LaAAbeP1iZukM+LXWk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AoEUocqEFLmI4sCuUOLLtxhO0oMNL2ds2Ax9WNQxbfFTlTWGL034DUGiRYwqW7mVi
         yMnMat2NB7X64ajc1J94Vt5sJxmCz5QurzdnbmZS3mVBnLjPmdXcjQMQRXRch0nwJl
         Hggywqnel2y0Y9iELBoWYxqZauyuAT9+grmV2ENw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.19 141/152] staging: erofs: add a full barrier in erofs_workgroup_unfreeze
Date:   Mon, 25 Feb 2019 22:12:13 +0100
Message-Id: <20190225195053.944012847@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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
@@ -199,6 +199,11 @@ static inline bool erofs_workgroup_try_t
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


