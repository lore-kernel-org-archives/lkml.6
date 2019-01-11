Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3C521841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219494;
	bh=OPxcUoiHXeVLNVDh8vmEtIvJou7Y0spdCALi8/Wc3wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nUBABncwXjDZt5UYjDEWCorDJ9jD4Fsr2etFScZUC0obA4IcuqMNalbqrvYpY7B/u
	 8umitA7L+Y1ArsOQwTao1RiboOVbMKtIwbYlVvfILW+E4x9imsCLIebffskobtpZAu
	 wWX1R1Kn4X+fhzCcd4rZ3wjCn8wVc/HfePTM1C2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388433AbfAKPLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732220AbfAKOP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:15:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7243F20874;
        Fri, 11 Jan 2019 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216158;
        bh=OPxcUoiHXeVLNVDh8vmEtIvJou7Y0spdCALi8/Wc3wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nuJOJKsLnbzS5Yh9FVUnQoK3fvL+HTo15lqJPF06/ZyqrmCAWF9V7XYFRMhofBpDN
         Ox52D7vycPZBjbEHEQfYLudP3Nf0qcEXxNSAPx4xUxtmEGeRJQ2QEPi2BT3K/EN4po
         xVbVgQtNjhVZCDn1cQh07bsPoPCqmzZOyQb7X9l0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH 3.18 42/47] gfs2: Fix loop in gfs2_rbm_find
Date:   Fri, 11 Jan 2019 15:08:27 +0100
Message-Id: <20190111131001.562236476@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 2d29f6b96d8f80322ed2dd895bca590491c38d34 upstream.

Fix the resource group wrap-around logic in gfs2_rbm_find that commit
e579ed4f44 broke.  The bug can lead to unnecessary repeated scanning of the
same bitmaps; there is a risk that future changes will turn this into an
endless loop.

Fixes: e579ed4f44 ("GFS2: Introduce rbm field bii")
Cc: stable@vger.kernel.org # v3.13+
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/rgrp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1671,9 +1671,9 @@ static int gfs2_rbm_find(struct gfs2_rbm
 			goto next_iter;
 		}
 		if (ret == -E2BIG) {
+			n += rbm->bii - initial_bii;
 			rbm->bii = 0;
 			rbm->offset = 0;
-			n += (rbm->bii - initial_bii);
 			goto res_covered_end_of_rgrp;
 		}
 		return ret;


