Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbeFBRch (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 13:32:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750892AbeFBRcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 13:32:35 -0400
Date: Sat, 2 Jun 2018 12:32:33 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jessica Yu <jeyu@kernel.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: /proc/kallsyms shows undefined symbols for livepatch modules
Message-ID: <20180602173209.merjb4o5a3wsdnbh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

I found a bug:

  [root@f25 ~]# modprobe livepatch-sample
  [root@f25 ~]# grep ' u ' /proc/kallsyms
  ffffffff81161080 u klp_enable_patch	[livepatch_sample]
  ffffffff81a01800 u __fentry__	[livepatch_sample]
  ffffffff81161250 u klp_unregister_patch	[livepatch_sample]
  ffffffff81161870 u klp_register_patch	[livepatch_sample]
  ffffffff8131f0b0 u seq_printf	[livepatch_sample]

Notice that livepatch modules' undefined symbols are showing up in
/proc/kallsyms.  This can confuse klp_find_object_symbol() which can
cause subtle bugs in livepatch.

I stared at the module kallsyms code for a bit, but I don't see the bug.
Maybe it has something to do with how we save the symbol table in
copy_module_elf().  Any ideas?

-- 
Josh
