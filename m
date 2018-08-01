Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE20C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719FD20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719FD20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbeHAPoI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:44:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389234AbeHAPoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:44:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 598E64021703;
        Wed,  1 Aug 2018 13:58:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7720D2026D68;
        Wed,  1 Aug 2018 13:58:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        sfr@canb.auug.org.au, nico@linaro.org, linux-kernel@vger.kernel.org
Subject: Can we fix samples/ dependency on headers please?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31060.1533131891.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 01 Aug 2018 14:58:11 +0100
Message-ID: <31061.1533131891@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 01 Aug 2018 13:58:14 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 01 Aug 2018 13:58:14 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently having to mark various userspace programs I've added to the
samples/ directory as BROKEN in samples/Kconfig because the root Makefile
mucks up the dependencies between building samples and headers_install.

The main culprit seems to be:

	commit dd92478a15fa3bfd746ee08b4ef59401c1537804
	Author: Nicolas Pitre <nicolas.pitre@linaro.org>
	Date:   Sun Feb 28 22:00:00 2016 -0500
	kbuild: build sample modules along with the rest of the kernel
 
which make the samples build in parallel with the build, thereby voiding the
explicit dependency:

	Documentation/ samples/: headers_install

and thereby breaking:

	commit ddea05fa148b4d8e66498e522a616d87f9cf81e3
	Author: Arnd Bergmann <arnd@arndb.de>
	Date:   Mon Jul 4 16:39:35 2016 +0200
	kbuild: make samples depend on headers_install

The obvious fix is to revert commit dd92478a15fa3bfd746ee08b4ef59401c1537804
(see attached patch).

David
---
commit 5c186b58db93e2644012e2fcb4c6ca2e74c6754b
Author: David Howells <dhowells@redhat.com>
Date:   Wed Aug 1 14:48:22 2018 +0100

    Revert "kbuild: build sample modules along with the rest of the kernel"
    
    This reverts commit dd92478a15fa3bfd746ee08b4ef59401c1537804.
    
    The problem with this commit is that some of the samples require the header
    installation to occur first, but building them in parallel with the rest of
    the build breaks that requirement.
    
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/Makefile b/Makefile
index ca2af1ab91eb..30fc0a37ad41 100644
--- a/Makefile
+++ b/Makefile
@@ -1009,16 +1009,14 @@ vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
 ifdef CONFIG_HEADERS_CHECK
 	$(Q)$(MAKE) -f $(srctree)/Makefile headers_check
 endif
+ifdef CONFIG_SAMPLES
+	$(Q)$(MAKE) $(build)=samples
+endif
 ifdef CONFIG_GDB_SCRIPTS
 	$(Q)ln -fsn $(abspath $(srctree)/scripts/gdb/vmlinux-gdb.py)
 endif
 	+$(call if_changed,link-vmlinux)
 
-# Build samples along the rest of the kernel
-ifdef CONFIG_SAMPLES
-vmlinux-dirs += samples
-endif
-
 # The actual objects are generated when descending,
 # make sure no implicit rule kicks in
 $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
