Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B479C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EAD2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216951;
	bh=IB/ZMhD12UTPdiYCk306BqaKB8gl7TFw2uvgaLCll3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tF7HX+YBFFv2zf9JHIYthYDCv+MJNMf3JIF6alUdwq0eIMC7YrDUQbh2n9IbwRriU
	 ZDrRcQM3xWn4hqrYl0j03MZE4RIydaK4Cv0RPQtXUpS93dKaPDcgM5bQ9F/oVNEVNC
	 6ROd+VvWzJJFIqungOgJNzxo0i4NzRDjWhep0yW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbfAKO3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388647AbfAKO3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:29:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D64282177B;
        Fri, 11 Jan 2019 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216944;
        bh=IB/ZMhD12UTPdiYCk306BqaKB8gl7TFw2uvgaLCll3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8xAQ2Lornsz/7/mWtZ4rgJymo4loFrvBnqlBx3bu8VlGdIziC2KPfIR1aPNGACVd
         AQ9e/Y/G9L1ZJnnBaIhwmDEp58q8fVOx2NJiHoJ6awiI3e5vhwEZZNeT5PtlCTJ97q
         CMnOnDhvv9vRJug9YEIsxeEEuoCa4zg7Yignw/p8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 4.9 48/63] dlm: fixed memory leaks after failed ls_remove_names allocation
Date:   Fri, 11 Jan 2019 15:14:51 +0100
Message-Id: <20190111131053.424691682@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit b982896cdb6e6a6b89d86dfb39df489d9df51e14 upstream.

If allocation fails on last elements of array need to free already
allocated elements.

v2: just move existing out_rsbtbl label to right place

Fixes 789924ba635f ("dlm: fix race between remove and lookup")
Cc: stable@kernel.org # 3.6

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dlm/lockspace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -673,11 +673,11 @@ static int new_lockspace(const char *nam
 	kfree(ls->ls_recover_buf);
  out_lkbidr:
 	idr_destroy(&ls->ls_lkbidr);
+ out_rsbtbl:
 	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++) {
 		if (ls->ls_remove_names[i])
 			kfree(ls->ls_remove_names[i]);
 	}
- out_rsbtbl:
 	vfree(ls->ls_rsbtbl);
  out_lsfree:
 	if (do_unreg)


