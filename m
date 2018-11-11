Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C947C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF5A2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF5A2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbeKLF4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52062 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727449AbeKLF43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:29 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt3-0000oO-DZ; Sun, 11 Nov 2018 19:59:13 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001X7-OO; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thadeu Lima de Souza Cascardo" <cascardo@canonical.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.842010357@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 127/366] fs/binfmt_misc.c: do not allow offset overflow
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Error label is "Einval"
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/binfmt_misc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -319,8 +319,13 @@ static Node *create_entry(const char __u
 		char *s = strchr(p, del);
 		if (!s)
 			goto Einval;
-		*s++ = '\0';
-		e->offset = simple_strtoul(p, &p, 10);
+		*s = '\0';
+		if (p != s) {
+			int r = kstrtoint(p, 10, &e->offset);
+			if (r != 0 || e->offset < 0)
+				goto Einval;
+		}
+		p = s;
 		if (*p++)
 			goto Einval;
 		e->magic = p;
@@ -341,7 +346,8 @@ static Node *create_entry(const char __u
 		if (e->mask &&
 		    string_unescape_inplace(e->mask, UNESCAPE_HEX) != e->size)
 			goto Einval;
-		if (e->size + e->offset > BINPRM_BUF_SIZE)
+		if (e->size > BINPRM_BUF_SIZE ||
+		    BINPRM_BUF_SIZE - e->size < e->offset)
 			goto Einval;
 	} else {
 		p = strchr(p, del);

