Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id T39cK+X6GFuzBAAAmS7hNA
	; Thu, 07 Jun 2018 09:30:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 158F3607DC; Thu,  7 Jun 2018 09:30:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8E7AE606DD;
	Thu,  7 Jun 2018 09:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E7AE606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeFGJ3y (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:29:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:54601 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751491AbeFGJ3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:29:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3C9A0ABF1;
        Thu,  7 Jun 2018 09:29:51 +0000 (UTC)
From: Miroslav Benes <mbenes@suse.cz>
To: jikos@kernel.org, jpoimboe@redhat.com, jeyu@kernel.org
Cc: pmladek@suse.com, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 0/3] Deny the patched modules to be removed
Date: Thu,  7 Jun 2018 11:29:46 +0200
Message-Id: <20180607092949.1706-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting the second patch's changelog:

    Josh reported a bug:
    
      When the object to be patched is a module, and that module is
      rmmod'ed and reloaded, it fails to load with:
    
      module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 2, loc 00000000ba0302e9, val ffffffffa03e293c
      livepatch: failed to initialize patch 'livepatch_nfsd' for module 'nfsd' (-8)
      livepatch: patch 'livepatch_nfsd' failed for module 'nfsd', refusing to load module 'nfsd'
    
      The livepatch module has a relocation which references a symbol
      in the _previous_ loading of nfsd. When apply_relocate_add()
      tries to replace the old relocation with a new one, it sees that
      the previous one is nonzero and it errors out.
    
      On ppc64le, we have a similar issue:
    
      module_64: livepatch_nfsd: Expected nop after call, got e8410018 at e_show+0x60/0x548 [livepatch_nfsd]
      livepatch: failed to initialize patch 'livepatch_nfsd' for module 'nfsd' (-8)
      livepatch: patch 'livepatch_nfsd' failed for module 'nfsd', refusing to load module 'nfsd'
    
    He also proposed three different solutions. We could remove the error
    check in apply_relocate_add() introduced by commit eda9cec4c9a1
    ("x86/module: Detect and skip invalid relocations"). However the check
    is useful for detecting corrupted modules.
    
    We could also reverse the relocation patching (clear all relocation
    targets on x86_64, or return back nops on powerpc) in
    klp_unpatch_object(). The solution is not universal and is too much
    arch-specific.
    
    We decided to deny the patched modules to be removed. If it proves to be
    a major drawback for users, we can still implement a different approach.

There were many subtle details to check, so it may be broken somewhere.
Hopefully it is not, but please review carefully.

Miroslav Benes (3):
  livepatch: Nullify obj->mod in klp_module_coming()'s error path
  livepatch: Deny the patched modules to be removed
  module: Remove superfluous call to klp_module_going()

 kernel/livepatch/core.c | 25 +++++++++++++++++++++++--
 kernel/module.c         |  1 -
 2 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.17.0
