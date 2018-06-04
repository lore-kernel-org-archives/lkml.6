Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753179AbeFDNBf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753147AbeFDNBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:01:34 -0400
Date: Mon, 4 Jun 2018 15:01:31 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [PATCH] module: exclude SHN_UNDEF symbols from kallsyms api
Message-ID: <20180604130131.slyhtgyywffusf67@d217.suse.de>
References: <20180602173209.merjb4o5a3wsdnbh@treble>
 <20180604080528.4z6rbhapbhn7xf5e@d217.suse.de>
 <20180604095416.rlthplerswzznyoc@d217.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180604095416.rlthplerswzznyoc@d217.suse.de>
X-OS: Linux d217 4.12.14-lp150.10-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Jessica Yu [04/06/18 11:54 +0200]:
>+++ Jessica Yu [04/06/18 10:05 +0200]:
>>+++ Josh Poimboeuf [02/06/18 12:32 -0500]:
>>>Hi Jessica,
>>>
>>>I found a bug:
>>>
>>>[root@f25 ~]# modprobe livepatch-sample
>>>[root@f25 ~]# grep ' u ' /proc/kallsyms
>>>ffffffff81161080 u klp_enable_patch	[livepatch_sample]
>>>ffffffff81a01800 u __fentry__	[livepatch_sample]
>>>ffffffff81161250 u klp_unregister_patch	[livepatch_sample]
>>>ffffffff81161870 u klp_register_patch	[livepatch_sample]
>>>ffffffff8131f0b0 u seq_printf	[livepatch_sample]
>>>
>>>Notice that livepatch modules' undefined symbols are showing up in
>>>/proc/kallsyms.  This can confuse klp_find_object_symbol() which can
>>>cause subtle bugs in livepatch.
>>>
>>>I stared at the module kallsyms code for a bit, but I don't see the bug.
>>>Maybe it has something to do with how we save the symbol table in
>>>copy_module_elf().  Any ideas?
>>
>>Hi Josh!
>>
>>This is because we preserve the entire symbol table for livepatch
>>modules, including the SHN_UNDEF symbols. IIRC, this is so that we can
>>still apply relocations properly with apply_relocate_add() after a
>>to-be-patched object is loaded. Normally we don't save these SHN_UNDEF
>>symbols for modules so they do not appear in /proc/kallsyms.
>
>Hm, if having the full symtab in kallsyms is causing trouble, one
>possibility would be to just have the module kallsyms code simply
>skip/ignore undef symbols. That's what we technically do for normal
>modules anyway (we normally cut undef syms out of the symtab). Haven't
>tested this idea but does that sound like it'd help?

See if the following patch (untested) helps. It does not fix the
/proc/kallsyms lookup, that requires a separate patch. But it should
exclude the undef symbols from module_kallsyms_on_each_symbol() and
thus also from klp_find_object_symbol().

>From 9cfd14675206adf55a85e5f5322b36ea89a523e4 Mon Sep 17 00:00:00 2001
From: Jessica Yu <jeyu@kernel.org>
Date: Mon, 4 Jun 2018 14:35:56 +0200
Subject: [PATCH] module: exclude SHN_UNDEF symbols from kallsyms api

---
 kernel/module.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index c9bea7f2b43e..dfa61490b37d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4070,7 +4070,7 @@ static unsigned long mod_find_symname(struct module *mod, const char *name)
 
 	for (i = 0; i < kallsyms->num_symtab; i++)
 		if (strcmp(name, symname(kallsyms, i)) == 0 &&
-		    kallsyms->symtab[i].st_info != 'U')
+		    kallsyms->symtab[i].st_shndx != SHN_UNDEF)
 			return kallsyms->symtab[i].st_value;
 	return 0;
 }
@@ -4116,6 +4116,10 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
 		for (i = 0; i < kallsyms->num_symtab; i++) {
+
+			if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
+				continue;
+
 			ret = fn(data, symname(kallsyms, i),
 				 mod, kallsyms->symtab[i].st_value);
 			if (ret != 0)
-- 
2.12.3
