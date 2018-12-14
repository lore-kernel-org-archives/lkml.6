Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC044C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418692080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbeLNU1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:27:21 -0500
Received: from mail.windriver.com ([147.11.1.11]:56121 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbeLNU1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:27:21 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wBEKQpDS027546
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 14 Dec 2018 12:26:51 -0800 (PST)
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Dec 2018 12:26:51 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 D25572E0804; Fri, 14 Dec 2018 15:26:50 -0500 (EST)
Date:   Fri, 14 Dec 2018 15:26:50 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, James Morris <jmorris@namei.org>
Subject: Re: linux-next: Tree for Dec 14 (security/integrity/ima/)
Message-ID: <20181214202650.GO11670@windriver.com>
References: <20181214181826.5775b958@canb.auug.org.au>
 <8205aafb-bbc1-2196-17d9-e70e9ac56c2e@infradead.org>
 <1544815174.3681.16.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544815174.3681.16.camel@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: linux-next: Tree for Dec 14 (security/integrity/ima/)] On 14/12/2018 (Fri 14:19) Mimi Zohar wrote:

> [Cc'ing Paul Gortmaker]
> 
> On Fri, 2018-12-14 at 08:25 -0800, Randy Dunlap wrote:
> > On 12/13/18 11:18 PM, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20181213:
> > > 
> > 
> > on i386:
> > 
> >   CC      security/integrity/ima/ima_main.o
> > ../security/integrity/ima/ima_main.c: In function 'ima_load_data':
> > ../security/integrity/ima/ima_main.c:535:3: error: implicit declaration of function 'is_module_sig_enforced' [-Werror=implicit-function-declaration]
> >    sig_enforce = is_module_sig_enforced();
> >    ^
> > 
> > 
> > Needs:
> 
> Commit 4f83d5ea643a ("security: integrity: make ima_main explicitly
> non-modular") just removed module.h.

Yes, unfortunately the security directory has additional confusion
because there is name space overlap between "module" as used in Linux
Security Module, and "module" as in "insmod foo.ko".  The ima_main
is not modular, but it does use modular infrastructure to load others.

Fortunately this was the final commit in the series, so it can be
removed or reverted as per maintainer's choice.  In the meantime, I'll
look into why my "allyesconfig" build testing didn't pick up on this,
so I can close that testing gap.

Randy, if you were using one of your usual "randconfig" builds, maybe
you can mail me the .config out of band - no need spamming the lists.

Thanks, and sorry for the undetected fallout.
Paul.
--

> 
> Mimi 
> 
> 
> > 
> > ---
> >  security/integrity/ima/ima_main.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > --- linux-next-20181214.orig/security/integrity/ima/ima_main.c
> > +++ linux-next-20181214/security/integrity/ima/ima_main.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/init.h>
> >  #include <linux/file.h>
> >  #include <linux/binfmts.h>
> > +#include <linux/module.h>
> >  #include <linux/mount.h>
> >  #include <linux/mman.h>
> >  #include <linux/slab.h>
> > 
> > 
> > 
> 
