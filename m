Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 05683C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0729208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pj5OuT43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0729208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935254AbeFLQyA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935234AbeFLQx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:53:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E38EB208B7;
        Tue, 12 Jun 2018 16:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822436;
        bh=uHhsRzaeWWb8FiBsdJVn/VirD9weXpIi035Op4H7nHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pj5OuT438uIqP8ECQ4BvUvYHUMgtWdnrQCNHeqAbc9MNhMnAcU3FKeB0tRqBP0bwL
         /8i1ZpAMvJ/jonORm2re9M7lL2NZFOTJRuwPmKT3eiDH4m6bstJuHYXe04PpTvZfo/
         GpGqWQxXtx25iTSX3WQB8VuEUPoNbXRqVVY2R7Jk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: [PATCH 3.18 11/21] drm: set FMODE_UNSIGNED_OFFSET for drm files
Date:   Tue, 12 Jun 2018 18:52:08 +0200
Message-Id: <20180612164825.870196921@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
References: <20180612164825.401145490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Airlie <airlied@redhat.com>

commit 76ef6b28ea4f81c3d511866a9b31392caa833126 upstream.

Since we have the ttm and gem vma managers using a subset
of the file address space for objects, and these start at
0x100000000 they will overflow the new mmap checks.

I've checked all the mmap routines I could see for any
bad behaviour but overall most people use GEM/TTM VMA
managers even the legacy drivers have a hashtable.

Reported-and-Tested-by: Arthur Marsh (amarsh04 on #radeon)
Fixes: be83bbf8068 (mmap: introduce sane default mmap limits)
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_fops.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/drm_fops.c
+++ b/drivers/gpu/drm/drm_fops.c
@@ -155,6 +155,7 @@ static int drm_open_helper(struct file *
 		return -ENOMEM;
 
 	filp->private_data = priv;
+	filp->f_mode |= FMODE_UNSIGNED_OFFSET;
 	priv->filp = filp;
 	priv->uid = current_euid();
 	priv->pid = get_pid(task_pid(current));


