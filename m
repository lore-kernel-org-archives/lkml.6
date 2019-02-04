Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ACFC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3842F217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277133;
	bh=/If/3fFglARPr5GQYTcNFZuTsuG4TFboK0r/oA4FSKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pMG23AS1cBekjyXU7/CJZ8MqygGk1rsxf5ZDl+bLNhrnoSLlc1OGUVKrLbnklvOIs
	 tc4+huuV1h835Ha3A6WU61/U0IAXntcmA6q14v2djEQuYbHfc/26APWIuc8ajxfbmp
	 DFjE/SSW+n4198YYKrByl1ctU0CxhUS/hz4bp6Ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfBDKpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731190AbfBDKp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:45:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 801062176F;
        Mon,  4 Feb 2019 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277127;
        bh=/If/3fFglARPr5GQYTcNFZuTsuG4TFboK0r/oA4FSKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gV5g4ATWiIYHEvE6AcFlouVZLGqIfUPJwk2YTRPt8zmvP5BSgqyAlUPBTYkmAbuop
         Xb+ilxAZ74veYKtaoXcfga7V+5Sh6jy8u21SqbB6zlBw52LMvD6nWj83aiEyPTqyGO
         g8mOTNw2/5CO4F7Z0RijatyiFDIAM6Fp4xnI41eM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 31/46] gfs2: Revert "Fix loop in gfs2_rbm_find"
Date:   Mon,  4 Feb 2019 11:37:02 +0100
Message-Id: <20190204103614.150474944@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

commit e74c98ca2d6ae4376cc15fa2a22483430909d96b upstream.

This reverts commit 2d29f6b96d8f80322ed2dd895bca590491c38d34.

It turns out that the fix can lead to a ~20 percent performance regression
in initial writes to the page cache according to iozone.  Let's revert this
for now to have more time for a proper fix.

Cc: stable@vger.kernel.org # v3.13+
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/rgrp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1695,9 +1695,9 @@ static int gfs2_rbm_find(struct gfs2_rbm
 			goto next_iter;
 		}
 		if (ret == -E2BIG) {
-			n += rbm->bii - initial_bii;
 			rbm->bii = 0;
 			rbm->offset = 0;
+			n += (rbm->bii - initial_bii);
 			goto res_covered_end_of_rgrp;
 		}
 		return ret;


