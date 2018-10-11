Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABCDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8A0213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8/SrpWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8A0213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeJKXOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:14:06 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FD7A213A2;
        Thu, 11 Oct 2018 15:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272780;
        bh=G0uoaUDUxND654t5BaMUOVWvuhUdZkj8weVxmbG4gKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8/SrpWcbLbHWRg1zEa+NlYWTEaasuCrsdUw3XOSN7w3a9m5NR9eBmODrBv26e5wT
         vyZmMuisMtaLhbGtGFOffgMODJ27LVxSG7GbKmvEL12nkFGtfAocMXOR2RS+1iSZyR
         hcufMUT2gLXQ1+53eOxMSxS7JryPHFn0oJSlyNo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 35/45] powerpc/lib: fix book3s/32 boot failure due to code patching
Date:   Thu, 11 Oct 2018 17:40:02 +0200
Message-Id: <20181011152510.450697383@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152508.885515042@linuxfoundation.org>
References: <20181011152508.885515042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit b45ba4a51cde29b2939365ef0c07ad34c8321789 upstream.

Commit 51c3c62b58b3 ("powerpc: Avoid code patching freed init
sections") accesses 'init_mem_is_free' flag too early, before the
kernel is relocated. This provokes early boot failure (before the
console is active).

As it is not necessary to do this verification that early, this
patch moves the test into patch_instruction() instead of
__patch_instruction().

This modification also has the advantage of avoiding unnecessary
remappings.

Fixes: 51c3c62b58b3 ("powerpc: Avoid code patching freed init sections")
Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/lib/code-patching.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -28,12 +28,6 @@ static int __patch_instruction(unsigned
 {
 	int err;
 
-	/* Make sure we aren't patching a freed init section */
-	if (init_mem_is_free && init_section_contains(exec_addr, 4)) {
-		pr_debug("Skipping init section patching addr: 0x%px\n", exec_addr);
-		return 0;
-	}
-
 	__put_user_size(instr, patch_addr, 4, err);
 	if (err)
 		return err;
@@ -148,7 +142,7 @@ static inline int unmap_patch_area(unsig
 	return 0;
 }
 
-int patch_instruction(unsigned int *addr, unsigned int instr)
+static int do_patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	int err;
 	unsigned int *patch_addr = NULL;
@@ -188,12 +182,22 @@ out:
 }
 #else /* !CONFIG_STRICT_KERNEL_RWX */
 
-int patch_instruction(unsigned int *addr, unsigned int instr)
+static int do_patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	return raw_patch_instruction(addr, instr);
 }
 
 #endif /* CONFIG_STRICT_KERNEL_RWX */
+
+int patch_instruction(unsigned int *addr, unsigned int instr)
+{
+	/* Make sure we aren't patching a freed init section */
+	if (init_mem_is_free && init_section_contains(addr, 4)) {
+		pr_debug("Skipping init section patching addr: 0x%px\n", addr);
+		return 0;
+	}
+	return do_patch_instruction(addr, instr);
+}
 NOKPROBE_SYMBOL(patch_instruction);
 
 int patch_branch(unsigned int *addr, unsigned long target, int flags)


