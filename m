Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0F14CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE84B208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wBW7cjBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE84B208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934825AbeFLRAF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935142AbeFLQxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:53:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F021208B9;
        Tue, 12 Jun 2018 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822411;
        bh=hGAXu7Ax8YZFOxKss6hLyBlYNn6p8xmt1Ac4qIJIIiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wBW7cjBml0BHguiDxPl4+ypa645n8Iqxzg6MS7QOeItgXc/ZCkieGb33WPnTFav3f
         idNXcCAYdqIuM1C0nZtm2u98A4S7J1/mRmP3W/5aGWKC7J6hLRHeq5uSnKkoQmYz5U
         8mkAnFeH6zPrOX38IVi47zUwNiKM1u5nqFeylWTo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: [PATCH 4.4 07/24] drm: set FMODE_UNSIGNED_OFFSET for drm files
Date:   Tue, 12 Jun 2018 18:51:51 +0200
Message-Id: <20180612164816.903425656@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
References: <20180612164816.587001852@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -209,6 +209,7 @@ static int drm_open_helper(struct file *
 		return -ENOMEM;
 
 	filp->private_data = priv;
+	filp->f_mode |= FMODE_UNSIGNED_OFFSET;
 	priv->filp = filp;
 	priv->uid = current_euid();
 	priv->pid = get_pid(task_pid(current));


