Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B052C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C78D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Hlc0xl77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfAXNEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:04:22 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:55061 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfAXNEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1548335060; x=1579871060;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=FrgTHUoj3KbWXf09V9cpupPy1pP3D/bnzKeOE5hntdU=;
  b=Hlc0xl77eXYVaiIFaU4Cb8hcyZvPT4PtUaCVYM6j0FymtsaxWR9BP2Y8
   HcXi7679/yY2QmcFbpnav1urM8H2V7YTWZfEWSLoAqGlKKOpsOj2sjmae
   K4pB6uc7NepA2IVf1bX4/S7O7mXkUZ/XGRIC9oQImByG8WDHwah/OUDg9
   s=;
X-IronPort-AV: E=Sophos;i="5.56,516,1539648000"; 
   d="scan'208";a="778314670"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 24 Jan 2019 13:04:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 9FF2AA241D;
        Thu, 24 Jan 2019 13:04:17 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Jan 2019 13:04:17 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 24 Jan 2019 13:04:17 +0000
Received: from u908889d5e8f057.ant.amazon.com (10.28.86.17) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 24 Jan 2019 13:04:12 +0000
From:   <vrd@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Nicolas Pernas Maradei <npernas@amazon.de>,
        Varad Gautam <vrd@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Maximilian Heyne <mheyne@amazon.de>,
        Stefan Nuernberger <snu@amazon.de>, Amit Shah <aams@amazon.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "# 4 . 9+" <stable@vger.kernel.org>
Subject: [PATCH] fs/devpts: always delete dcache dentry-s in dput()
Date:   Thu, 24 Jan 2019 14:03:06 +0100
Message-ID: <1548334986-28667-1-git-send-email-vrd@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varad Gautam <vrd@amazon.de>

d_delete only unhashes an entry if it is reached with
dentry->d_lockref.count != 1. Prior to commit 8ead9dd54716 ("devpts:
more pty driver interface cleanups"), d_delete was called on a dentry
from devpts_pty_kill with two references held, which would trigger the
unhashing, and the subsequent dputs would release it.

Commit 8ead9dd54716 reworked devpts_pty_kill to stop acquiring the second
reference from d_find_alias, and the d_delete call left the dentries
still on the hashed list without actually ever being dropped from dcache
before explicit cleanup. This causes the number of negative dentries for
devpts to pile up, and an `ls /dev/pts` invocation can take seconds to
return.

Provide always_delete_dentry() from simple_dentry_operations
as .d_delete for devpts, to make the dentry be dropped from dcache.

Without this cleanup, the number of dentries in /dev/pts/ can be grown
arbitrarily as:

`python -c 'import pty; pty.spawn(["ls", "/dev/pts"])'`

A systemtap probe on dcache_readdir to count d_subdirs shows this count
to increase with each pty spawn invocation above:

probe kernel.function("dcache_readdir") {
    subdirs = &@cast($file->f_path->dentry, "dentry")->d_subdirs;
    p = subdirs;
    p = @cast(p, "list_head")->next;
    i = 0
    while (p != subdirs) {
      p = @cast(p, "list_head")->next;
      i = i+1;
    }
    printf("number of dentries: %d\n", i);
}

Fixes: 8ead9dd54716 ("devpts: more pty driver interface cleanups")
Signed-off-by: Varad Gautam <vrd@amazon.de>
Reported-by: Zheng Wang <wanz@amazon.de>
Reported-by: Brandon Schwartz <bsschwar@amazon.de>
Root-caused-by: Maximilian Heyne <mheyne@amazon.de>
Root-caused-by: Nicolas Pernas Maradei <npernas@amazon.de>
CC: David Woodhouse <dwmw@amazon.co.uk>
CC: Maximilian Heyne <mheyne@amazon.de>
CC: Stefan Nuernberger <snu@amazon.de>
CC: Amit Shah <aams@amazon.de>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Al Viro <viro@ZenIV.linux.org.uk>
CC: Christian Brauner <christian.brauner@ubuntu.com>
CC: Eric W. Biederman <ebiederm@xmission.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Eric Biggers <ebiggers@google.com>
CC: <stable@vger.kernel.org> # 4.9+
---
 fs/devpts/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index c538145..553a3f3 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -455,6 +455,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	s->s_blocksize_bits = 10;
 	s->s_magic = DEVPTS_SUPER_MAGIC;
 	s->s_op = &devpts_sops;
+	s->s_d_op = &simple_dentry_operations;
 	s->s_time_gran = 1;
 
 	error = -ENOMEM;
-- 
2.7.4
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
