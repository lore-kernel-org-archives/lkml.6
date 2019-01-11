Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73628C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B4E2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216089;
	bh=p0dcsPsdPGHaiFQTv3TVWw+hfY7vThPhjpH5jn6dC+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=insZKwkxgc7gAj6ItI4eG9chcbLttgGKOjGP4AhM6wWiryU1CSc+AA7XDOaehToCq
	 fCuXj4zljia7OdNRzJ3s2fT5r9qOA/VLhMaZ4a5kacXkxfOkKAnajZHFAaoR2t1nYA
	 sKf5Gf/VfXjr9jJ2bLlR9/w3eCWH+aWOesDqPCiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfAKOOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:14:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732147AbfAKOOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:14:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E90220874;
        Fri, 11 Jan 2019 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216084;
        bh=p0dcsPsdPGHaiFQTv3TVWw+hfY7vThPhjpH5jn6dC+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uibo/4a8xzjcM7H24lWq2ZhzUVo7FVZt8bHsUw225eIA66e7x1HnXqeOYPTE1S/pK
         iC47CCmIg22TWCY88DmFneFs4eQ++MAmgXhC78xNfNgU/EteSFEeg6xL69VYn/z02G
         yIlDeon3zyFZe59DD2d2jApzbuRgv1ciI/P1qq+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tyler Hicks <tyhicks@canonical.com>, security@kernel.org
Subject: [PATCH 3.18 07/47] x86/mtrr: Dont copy uninitialized gentry fields back to userspace
Date:   Fri, 11 Jan 2019 15:07:52 +0100
Message-Id: <20190111130957.053666840@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>

commit 32043fa065b51e0b1433e48d118821c71b5cd65d upstream.

Currently the copy_to_user of data in the gentry struct is copying
uninitiaized data in field _pad from the stack to userspace.

Fix this by explicitly memset'ing gentry to zero, this also will zero any
compiler added padding fields that may be in struct (currently there are
none).

Detected by CoverityScan, CID#200783 ("Uninitialized scalar variable")

Fixes: b263b31e8ad6 ("x86, mtrr: Use explicit sizing and padding for the 64-bit ioctls")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tyler Hicks <tyhicks@canonical.com>
Cc: security@kernel.org
Link: https://lkml.kernel.org/r/20181218172956.1440-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mtrr/if.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -173,6 +173,8 @@ mtrr_ioctl(struct file *file, unsigned i
 	struct mtrr_gentry gentry;
 	void __user *arg = (void __user *) __arg;
 
+	memset(&gentry, 0, sizeof(gentry));
+
 	switch (cmd) {
 	case MTRRIOC_ADD_ENTRY:
 	case MTRRIOC_SET_ENTRY:


