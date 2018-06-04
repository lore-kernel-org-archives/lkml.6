Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeFDIFd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeFDIFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:05:32 -0400
Date: Mon, 4 Jun 2018 10:05:28 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: /proc/kallsyms shows undefined symbols for livepatch modules
Message-ID: <20180604080528.4z6rbhapbhn7xf5e@d217.suse.de>
References: <20180602173209.merjb4o5a3wsdnbh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180602173209.merjb4o5a3wsdnbh@treble>
X-OS: Linux d217 4.12.14-lp150.10-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Josh Poimboeuf [02/06/18 12:32 -0500]:
>Hi Jessica,
>
>I found a bug:
>
>  [root@f25 ~]# modprobe livepatch-sample
>  [root@f25 ~]# grep ' u ' /proc/kallsyms
>  ffffffff81161080 u klp_enable_patch	[livepatch_sample]
>  ffffffff81a01800 u __fentry__	[livepatch_sample]
>  ffffffff81161250 u klp_unregister_patch	[livepatch_sample]
>  ffffffff81161870 u klp_register_patch	[livepatch_sample]
>  ffffffff8131f0b0 u seq_printf	[livepatch_sample]
>
>Notice that livepatch modules' undefined symbols are showing up in
>/proc/kallsyms.  This can confuse klp_find_object_symbol() which can
>cause subtle bugs in livepatch.
>
>I stared at the module kallsyms code for a bit, but I don't see the bug.
>Maybe it has something to do with how we save the symbol table in
>copy_module_elf().  Any ideas?

Hi Josh!

This is because we preserve the entire symbol table for livepatch
modules, including the SHN_UNDEF symbols. IIRC, this is so that we can
still apply relocations properly with apply_relocate_add() after a
to-be-patched object is loaded. Normally we don't save these SHN_UNDEF
symbols for modules so they do not appear in /proc/kallsyms.

I think I see how this can cause bugs, since if we're searching for
seq_printf we want the real seq_printf and not the undef symbol from
the livepatch module. But I thought we renamed these symbols with some
.klp prefix? Or is the livepatch bug you're running into something else?

Thanks,

Jessica
