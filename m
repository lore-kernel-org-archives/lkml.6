Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28374C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5C9218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151319;
	bh=7+Xw7OcwMQqMxSnvHhTnNkjVWal3MVc38LVt8DzSjxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tiSOJumtH/BdChZi1kF1fSo9UWaKJyWMexg4ihzVd7Z6VoQR+VM1vL2kY1vl1byh8
	 FJR0ttjXPx94s7Hx8tVOIXrCZsysCQofOshPcgvbb1TSwHuvn15vbe+hY2J+rJqOoR
	 RQe6lke8ZdIiiFAFhHTbnsnni6dihrRNVi2Sehy0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeLRQl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbeLRQly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FF35218CD;
        Tue, 18 Dec 2018 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151314;
        bh=7+Xw7OcwMQqMxSnvHhTnNkjVWal3MVc38LVt8DzSjxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQFEBiSulTGm0FM83GmProL9vQk7L8anbeqSW13oDzU9RWRGkMOZ34mA0G0l5/E/Q
         s4r4ga01lSrmS0IFQMIX8jy1pYWzvfbU4NYShJWFq8PALWAlysi6HQX0wx1zwI7Hqg
         Ky+i2Mp4I0lf/VbRvuA2vCjfwTMnYnTh1oVPFpa8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.19 33/44] drm/nouveau/kms: Fix memory leak in nv50_mstm_del()
Date:   Tue, 18 Dec 2018 17:39:45 +0100
Message-Id: <20181218163931.324359708@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
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

From: Lyude Paul <lyude@redhat.com>

commit 24199c5436f267399afed0c4f1f57663c0408f57 upstream.

Noticed this while working on redoing the reference counting scheme in
the DP MST helpers. Nouveau doesn't attempt to call
drm_dp_mst_topology_mgr_destroy() at all, which leaves it leaking all of
the resources for drm_dp_mst_topology_mgr and it's children mstbs+ports.

Fixes: f479c0ba4a17 ("drm/nouveau/kms/nv50: initial support for DP 1.2 multi-stream")
Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/dispnv50/disp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1226,6 +1226,7 @@ nv50_mstm_del(struct nv50_mstm **pmstm)
 {
 	struct nv50_mstm *mstm = *pmstm;
 	if (mstm) {
+		drm_dp_mst_topology_mgr_destroy(&mstm->mgr);
 		kfree(*pmstm);
 		*pmstm = NULL;
 	}


