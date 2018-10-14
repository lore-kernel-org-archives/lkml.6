Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBB2C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8FC20659
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8FC20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeJNPWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 11:22:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41396 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeJNPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 11:22:49 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1FC8F13D36D29;
        Sun, 14 Oct 2018 00:42:42 -0700 (PDT)
Date:   Sun, 14 Oct 2018 00:42:38 -0700 (PDT)
Message-Id: <20181014.004238.292485794143606801.davem@davemloft.net>
To:     acme@redhat.com
CC:     linux-kernel@vger.kernel.org
Subject: perf's handling of unfindable user symbols...
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 14 Oct 2018 00:42:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Perf has this hack where it uses the kernel symbol map as a backup
when a symbol can't be found in the user's symbol table(s).

This causes problems because the tests driving this code path use
machine__kernel_ip(), and that is completely meaningless on Sparc.  On
sparc64 the kernel and user live in physically separate virtual
address spaces, rather than a shared one.  And the kernel lives at a
virtual address that overlaps common userspace addresses.  So this
test passes almost all the time when a user symbol lookup fails.

The consequence of this is that, if the unfound user virtual address
in the sample doesn't match up to a kernel symbol either, we trigger
things like this code in builtin-top.c:

	if (al.sym == NULL && al.map != NULL) {
		const char *msg = "Kernel samples will not be resolved.\n";
		/*
		 * As we do lazy loading of symtabs we only will know if the
		 * specified vmlinux file is invalid when we actually have a
		 * hit in kernel space and then try to load it. So if we get
		 * here and there are _no_ symbols in the DSO backing the
		 * kernel map, bail out.
		 *
		 * We may never get here, for instance, if we use -K/
		 * --hide-kernel-symbols, even if the user specifies an
		 * invalid --vmlinux ;-)
		 */
		if (!machine->kptr_restrict_warned && !top->vmlinux_warned &&
		    __map__is_kernel(al.map) && map__has_symbols(al.map)) {
			if (symbol_conf.vmlinux_name) {
				char serr[256];
				dso__strerror_load(al.map->dso, serr, sizeof(serr));
				ui__warning("The %s file can't be used: %s\n%s",
					    symbol_conf.vmlinux_name, serr, msg);
			} else {
				ui__warning("A vmlinux file was not found.\n%s",
					    msg);
			}

			if (use_browser <= 0)
				sleep(5);
			top->vmlinux_warned = true;
		}
	}

When I fire up a compilation on sparc, this triggers immediately.

I'm trying to figure out what the "backup to kernel map" code is
accomplishing.

I see some language in the current code and in the changes that have
happened in this area talking about vdso.  Does that really happen?

The vdso is mapped into userspace virtual addresses, not kernel ones.

More history.  This didn't cause problems on sparc some time ago,
because the kernel IP check used to be "ip < 0" :-) Sparc kernel
addresses are not negative.  But now with machine__kernel_ip(), which
works using the symbol table determined kernel address range, it does
trigger.

What it all boils down to is that on architectures like sparc,
machine__kernel_ip() should always return false in this scenerio, and
therefore this kind of logic:

		if (cpumode == PERF_RECORD_MISC_USER && machine &&
		    mg != &machine->kmaps &&
		    machine__kernel_ip(machine, al->addr)) {

is basically invalid.  PERF_RECORD_MISC_USER implies no kernel address
can possibly match for the sample/event in question (no matter how
hard you try!) :-)

At the very least there should be an arch way to disable this logic,
or even formalize in some way the situation.  Have some kind of
"user_kernel_shared_address_space" boolean, and then
machine__kernel_ip() can take a cpumode parameter and it can thus say:

	if (cpumode == PERF_RECORD_MISC_USER &&
	    !user_kernel_shared_address_space)
		return false;

Comments?
