Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F3C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CC224FB6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CC224FB6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754722AbeFXPaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:30:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeFXPad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:30:33 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D77962C;
        Sun, 24 Jun 2018 15:30:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 51/52] fs/binfmt_misc.c: do not allow offset overflow
Date:   Sun, 24 Jun 2018 23:21:44 +0800
Message-Id: <20180624142747.412490033@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142744.234164867@linuxfoundation.org>
References: <20180624142744.234164867@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

commit 5cc41e099504b77014358b58567c5ea6293dd220 upstream.

WHen registering a new binfmt_misc handler, it is possible to overflow
the offset to get a negative value, which might crash the system, or
possibly leak kernel data.

Here is a crash log when 2500000000 was used as an offset:

  BUG: unable to handle kernel paging request at ffff989cfd6edca0
  IP: load_misc_binary+0x22b/0x470 [binfmt_misc]
  PGD 1ef3e067 P4D 1ef3e067 PUD 0
  Oops: 0000 [#1] SMP NOPTI
  Modules linked in: binfmt_misc kvm_intel ppdev kvm irqbypass joydev input_leds serio_raw mac_hid parport_pc qemu_fw_cfg parpy
  CPU: 0 PID: 2499 Comm: bash Not tainted 4.15.0-22-generic #24-Ubuntu
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
  RIP: 0010:load_misc_binary+0x22b/0x470 [binfmt_misc]
  Call Trace:
    search_binary_handler+0x97/0x1d0
    do_execveat_common.isra.34+0x667/0x810
    SyS_execve+0x31/0x40
    do_syscall_64+0x73/0x130
    entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Use kstrtoint instead of simple_strtoul.  It will work as the code
already set the delimiter byte to '\0' and we only do it when the field
is not empty.

Tested with offsets -1, 2500000000, UINT_MAX and INT_MAX.  Also tested
with examples documented at Documentation/admin-guide/binfmt-misc.rst
and other registrations from packages on Ubuntu.

Link: http://lkml.kernel.org/r/20180529135648.14254-1-cascardo@canonical.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/binfmt_misc.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -387,8 +387,13 @@ static Node *create_entry(const char __u
 		s = strchr(p, del);
 		if (!s)
 			goto einval;
-		*s++ = '\0';
-		e->offset = simple_strtoul(p, &p, 10);
+		*s = '\0';
+		if (p != s) {
+			int r = kstrtoint(p, 10, &e->offset);
+			if (r != 0 || e->offset < 0)
+				goto einval;
+		}
+		p = s;
 		if (*p++)
 			goto einval;
 		pr_debug("register: offset: %#x\n", e->offset);
@@ -428,7 +433,8 @@ static Node *create_entry(const char __u
 		if (e->mask &&
 		    string_unescape_inplace(e->mask, UNESCAPE_HEX) != e->size)
 			goto einval;
-		if (e->size + e->offset > BINPRM_BUF_SIZE)
+		if (e->size > BINPRM_BUF_SIZE ||
+		    BINPRM_BUF_SIZE - e->size < e->offset)
 			goto einval;
 		pr_debug("register: magic/mask length: %i\n", e->size);
 		if (USE_DEBUG) {


