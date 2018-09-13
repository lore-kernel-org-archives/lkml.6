Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1F5C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C3320652
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C3320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbeIMTLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:11:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35068 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbeIMTLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:11:15 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 31D5DD27;
        Thu, 13 Sep 2018 14:01:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 141/197] btrfs: Fix a C compliance issue
Date:   Thu, 13 Sep 2018 15:31:30 +0200
Message-Id: <20180913131847.197346476@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

[ Upstream commit edf57cbf2b030781885e339f32e35a470d2f8eba ]

The C programming language does not allow to use preprocessor statements
inside macro arguments (pr_info() is defined as a macro). Hence rework
the pr_info() statement in btrfs_print_mod_info() such that it becomes
compliant. This patch allows tools like sparse to analyze the BTRFS
source code.

Fixes: 62e855771dac ("btrfs: convert printk(KERN_* to use pr_* calls")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/super.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2370,7 +2370,7 @@ static __cold void btrfs_interface_exit(
 
 static void __init btrfs_print_mod_info(void)
 {
-	pr_info("Btrfs loaded, crc32c=%s"
+	static const char options[] = ""
 #ifdef CONFIG_BTRFS_DEBUG
 			", debug=on"
 #endif
@@ -2383,8 +2383,8 @@ static void __init btrfs_print_mod_info(
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 			", ref-verify=on"
 #endif
-			"\n",
-			crc32c_impl());
+			;
+	pr_info("Btrfs loaded, crc32c=%s%s\n", crc32c_impl(), options);
 }
 
 static int __init init_btrfs_fs(void)


