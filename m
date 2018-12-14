Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12C6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FF32086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbeLNW2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:28:33 -0500
Received: from mail1.windriver.com ([147.11.146.13]:33048 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeLNW2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:28:33 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wBEMS32X002135
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 14 Dec 2018 14:28:03 -0800 (PST)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Dec 2018 14:28:03 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 8D95A2E0804; Fri, 14 Dec 2018 17:28:02 -0500 (EST)
Date:   Fri, 14 Dec 2018 17:28:02 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, James Morris <jmorris@namei.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, James Morris <jmorris@namei.org>
Subject: Re: linux-next: Tree for Dec 14 (security/integrity/ima/)
Message-ID: <20181214222802.GP11670@windriver.com>
References: <20181214181826.5775b958@canb.auug.org.au>
 <8205aafb-bbc1-2196-17d9-e70e9ac56c2e@infradead.org>
 <1544815174.3681.16.camel@linux.ibm.com>
 <20181214202650.GO11670@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181214202650.GO11670@windriver.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: linux-next: Tree for Dec 14 (security/integrity/ima/)] On 14/12/2018 (Fri 15:26) Paul Gortmaker wrote:

> [Re: linux-next: Tree for Dec 14 (security/integrity/ima/)] On 14/12/2018 (Fri 14:19) Mimi Zohar wrote:
> 
> > On Fri, 2018-12-14 at 08:25 -0800, Randy Dunlap wrote:
> > > 
> > > on i386:
> > > 
> > >   CC      security/integrity/ima/ima_main.o
> > > ../security/integrity/ima/ima_main.c: In function 'ima_load_data':
> > > ../security/integrity/ima/ima_main.c:535:3: error: implicit declaration of function 'is_module_sig_enforced' [-Werror=implicit-function-declaration]
> > >    sig_enforce = is_module_sig_enforced();
> > >    ^

[...]

> > Commit 4f83d5ea643a ("security: integrity: make ima_main explicitly
> > non-modular") just removed module.h.
> 
> Yes, unfortunately the security directory has additional confusion
> because there is name space overlap between "module" as used in Linux
> Security Module, and "module" as in "insmod foo.ko".  The ima_main
> is not modular, but it does use modular infrastructure to load others.
> 
> Fortunately this was the final commit in the series, so it can be
> removed or reverted as per maintainer's choice.  In the meantime, I'll
> look into why my "allyesconfig" build testing didn't pick up on this,
> so I can close that testing gap.

I've confirmed that most .config result in an implicit header presence
by looking at the CPP output.  Details below.

James, if your input branch to linux-next is strictly fast forward, here
is a partial revert to fix up what Randy found that you can apply.

Thanks for the report, and again - sorry for not detecting this myself.
Paul.
--

From 31081a8b46e84d64e2fbda8d0d82ba26d56cc468 Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 14 Dec 2018 16:48:07 -0500
Subject: [PATCH] security: integrity: partial revert of make ima_main
 explicitly non-modular

In commit 4f83d5ea643a ("security: integrity: make ima_main explicitly
non-modular") I'd removed <linux/module.h> after assuming that the
function is_module_sig_enforced() was an LSM function and not a core
kernel module function.

Unfortunately the typical .config selections used in build testing
provide an implicit <linux/module.h> presence, and so normal/typical
build testing did not immediately reveal my incorrect assumption.

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-ima-devel@lists.sourceforge.net
Cc: linux-security-module@vger.kernel.org
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index adaf96932237..616a88f95b92 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -21,7 +21,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/file.h>
 #include <linux/binfmts.h>
 #include <linux/mount.h>
-- 
2.7.4

