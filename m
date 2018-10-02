Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54371C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BD22064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BD22064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbeJBUYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:24:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733104AbeJBUTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:19:45 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0FE4FB4A;
        Tue,  2 Oct 2018 13:36:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 50/94] module: exclude SHN_UNDEF symbols from kallsyms api
Date:   Tue,  2 Oct 2018 06:25:04 -0700
Message-Id: <20181002132503.973628561@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jessica Yu <jeyu@kernel.org>

[ Upstream commit 9f2d1e68cf4d641def734adaccfc3823d3575e6c ]

Livepatch modules are special in that we preserve their entire symbol
tables in order to be able to apply relocations after module load. The
unwanted side effect of this is that undefined (SHN_UNDEF) symbols of
livepatch modules are accessible via the kallsyms api and this can
confuse symbol resolution in livepatch (klp_find_object_symbol()) and
cause subtle bugs in livepatch.

Have the module kallsyms api skip over SHN_UNDEF symbols. These symbols
are usually not available for normal modules anyway as we cut down their
symbol tables to just the core (non-undefined) symbols, so this should
really just affect livepatch modules. Note that this patch doesn't
affect the display of undefined symbols in /proc/kallsyms.

Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/module.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4011,7 +4011,7 @@ static unsigned long mod_find_symname(st
 
 	for (i = 0; i < kallsyms->num_symtab; i++)
 		if (strcmp(name, symname(kallsyms, i)) == 0 &&
-		    kallsyms->symtab[i].st_info != 'U')
+		    kallsyms->symtab[i].st_shndx != SHN_UNDEF)
 			return kallsyms->symtab[i].st_value;
 	return 0;
 }
@@ -4057,6 +4057,10 @@ int module_kallsyms_on_each_symbol(int (
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


