Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B39C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DE721783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216394;
	bh=wYsmSn2ouCW37Wts34VwFxpgEAybPpet+HuvSvQPf/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FzlESpTcZqzBfIDSzOMCoOK9HCl9YqNADhEN4u1jw2LOy/jOjErS5uhFAPQ1oHUJO
	 o3wKoFHiLcGAsWwoQgd+YOjq6i3eLFTmqJNF8iTjCGnKvSk1Df9ZR3VxFoos1TQLYX
	 DCbNYxYopyKPXqvQdVk0/11yGdnZgilfWyKSyNlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbfAKOTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:19:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732470AbfAKOTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:19:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1CE821783;
        Fri, 11 Jan 2019 14:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216387;
        bh=wYsmSn2ouCW37Wts34VwFxpgEAybPpet+HuvSvQPf/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gLE1o7x6zBj099sjN/3HD3EM99F7vu15j9LQLqIc044B7s/6dnQqp7t1cJGxkMMdh
         LrcQZSSaf6L2Sr7fGeZIT+YGZGNrakx2UKUxykliGWfz1VfUiCno83fjUsfUxT+b1N
         vLWu+WiikFbUyD88E1SPaQOLhZPTSlT5qqPIKxg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Subject: [PATCH 4.4 80/88] gfs2: Fix loop in gfs2_rbm_find
Date:   Fri, 11 Jan 2019 15:08:49 +0100
Message-Id: <20190111131059.165494874@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1720,9 +1720,9 @@ static int gfs2_rbm_find(struct gfs2_rbm
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


