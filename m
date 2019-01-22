Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3B6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD71217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548167796;
	bh=7Ikb7d8ZJtpAzTVdGdnLPM/m5/2Th+slVTRWBhBI3zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OK7fB/767APCz/oR0bhJmRzttYIY3QZgjeZU07Ip4CzPvlGUrWKELDX2baJGCJO9i
	 8hOMltTmxPuqjheDAkPiR/7FQYUuXd4YsmLvOZmFV6ogkMTnS/zkPsTvW1lXK1wMVk
	 Ch5b83G0691Ju5vZ3v4yzMFmJKjLc4WbRvTlUYws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfAVOgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:36:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbfAVOgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:36:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD85620854;
        Tue, 22 Jan 2019 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548167791;
        bh=7Ikb7d8ZJtpAzTVdGdnLPM/m5/2Th+slVTRWBhBI3zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+iMHHAXY6u6zzIS4RFdyYMZp7B6V6pTcmXiVojnnRBmejN9Y4FZJ6/AYaYDUDOWc
         kUc+tP/Pd7BTpvrrrutKYBmg90kZTUV+bNem1qK8q2LKFgEMBSwxLNqr2TMJUvjJ4f
         OBzCN+7L0XV1ULFKgU2kt5uahy5KWcdo5d4x25bs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
Subject: [PATCH 6/6] x86: xen: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:35:42 +0100
Message-Id: <20190122143542.8816-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122143542.8816-1-gregkh@linuxfoundation.org>
References: <20190122143542.8816-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: <xen-devel@lists.xenproject.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/xen/debugfs.c | 7 +------
 arch/x86/xen/p2m.c     | 3 ---
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/xen/debugfs.c b/arch/x86/xen/debugfs.c
index 13da87918b4f..532410998684 100644
--- a/arch/x86/xen/debugfs.c
+++ b/arch/x86/xen/debugfs.c
@@ -9,13 +9,8 @@ static struct dentry *d_xen_debug;
 
 struct dentry * __init xen_init_debugfs(void)
 {
-	if (!d_xen_debug) {
+	if (!d_xen_debug)
 		d_xen_debug = debugfs_create_dir("xen", NULL);
-
-		if (!d_xen_debug)
-			pr_warning("Could not create 'xen' debugfs directory\n");
-	}
-
 	return d_xen_debug;
 }
 
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 055e37e43541..9d3e29805b73 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -810,9 +810,6 @@ static int __init xen_p2m_debugfs(void)
 {
 	struct dentry *d_xen = xen_init_debugfs();
 
-	if (d_xen == NULL)
-		return -ENOMEM;
-
 	d_mmu_debug = debugfs_create_dir("mmu", d_xen);
 
 	debugfs_create_file("p2m", 0600, d_mmu_debug, NULL, &p2m_dump_fops);
-- 
2.20.1

