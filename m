Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BA72183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216384;
	bh=g8IHlEkKhRm9L39tQ5LCJnnWQon4hnMMuaR4yvB9/ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v0Yj1DRTk1RZ6a9xcw2hJ5+vnposSJiR/0+BLjR7C7dFUvaxbiXM/09h8HckBeeP8
	 EwelHpWcGGUMPsyTPmqh9rHeG/r6FTpegmD6soIrIuaHQICf1C6Tk9+gAXeeeburGp
	 Wvv0Xsm12geyj6LxtZDzXVLLPzzMs3TGnSICLQys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbfAKOTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:19:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:36774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbfAKOTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:19:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D3B62177B;
        Fri, 11 Jan 2019 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216378;
        bh=g8IHlEkKhRm9L39tQ5LCJnnWQon4hnMMuaR4yvB9/ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g51ZgZtcZZHKho6sUbnQxLHsEu2r6TCt7I5FjwO16tXesEb1qRMTKUwKuYWAJmPSt
         oSMs65KqDjIS1T8fqAMwayKE7WLTJYCA+fUbJkL3N7UAnfJIK775zquhAiz3/F8CLh
         YLj6/e+/oY1T8fYCRHaDn/QGX/IE9Vg3ZnLWFAog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 4.4 77/88] dlm: possible memory leak on error path in create_lkb()
Date:   Fri, 11 Jan 2019 15:08:46 +0100
Message-Id: <20190111131058.791734972@linuxfoundation.org>
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

From: Vasily Averin <vvs@virtuozzo.com>

commit 23851e978f31eda8b2d01bd410d3026659ca06c7 upstream.

Fixes 3d6aa675fff9 ("dlm: keep lkbs in idr")
Cc: stable@kernel.org # 3.1

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dlm/lock.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1210,6 +1210,7 @@ static int create_lkb(struct dlm_ls *ls,
 
 	if (rv < 0) {
 		log_error(ls, "create_lkb idr error %d", rv);
+		dlm_free_lkb(lkb);
 		return rv;
 	}
 


