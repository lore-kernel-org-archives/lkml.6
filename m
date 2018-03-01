Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163315AbeCAXjQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:39:16 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52507 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163360AbeCAXhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:37:34 -0500
X-Google-Smtp-Source: AG47ELvG5CAzDigVDFnhL9LJ11L4TERcM+gY0LdLo1IAJ//EA89f/I3RPhi3dqZW9Rvm4ePaudojXQ==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC 3/5] powerpc/pseries: use seq_open_data in hcall_inst_seq_open
Date: Fri,  2 Mar 2018 00:37:22 +0100
Message-Id: <20180301233724.20440-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
References: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code should check the return value of seq_open(); if it failed,
file->private_data is NULL. But we can avoid the issue entirely and
simplify the code by letting seq_open_data() set the ->private member.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/pseries/hvCall_inst.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index 89b7ce807e70..05990c9fe264 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -92,14 +92,7 @@ static const struct seq_operations hcall_inst_seq_ops = {
 
 static int hcall_inst_seq_open(struct inode *inode, struct file *file)
 {
-	int rc;
-	struct seq_file *seq;
-
-	rc = seq_open(file, &hcall_inst_seq_ops);
-	seq = file->private_data;
-	seq->private = file_inode(file)->i_private;
-
-	return rc;
+	return seq_open_data(file, &hcall_inst_seq_ops, file_inode(file)->i_private);
 }
 
 static const struct file_operations hcall_inst_seq_fops = {
-- 
2.15.1
