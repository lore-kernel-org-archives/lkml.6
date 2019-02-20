Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B410AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911B32086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfBTJ6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:58:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:11945 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfBTJ6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:58:11 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 01:58:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,390,1544515200"; 
   d="scan'208";a="276434869"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.169])
  by orsmga004.jf.intel.com with ESMTP; 20 Feb 2019 01:58:07 -0800
Date:   Wed, 20 Feb 2019 11:58:06 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Zhangshaokun <zhangshaokun@hisilicon.com>,
        ard.biesheuvel@linaro.org, zohar@linux.ibm.com
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: linux-next: Tree for Feb 20
Message-ID: <20190220095806.GB9089@linux.intel.com>
References: <20190220184341.73bd2084@canb.auug.org.au>
 <1114b964-8ff8-5632-64d4-e94a9160b998@hisilicon.com>
 <20190220095252.GA9089@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190220095252.GA9089@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 11:52:52AM +0200, Jarkko Sakkinen wrote:
> On Wed, Feb 20, 2019 at 05:11:15PM +0800, Zhangshaokun wrote:
> > There is a compiler failure on arm64 platform, as follow:
> > 
> >   AS      arch/arm64/kvm/hyp.o
> >   CC      kernel/trace/ring_buffer.o
> > In file included from security/integrity/ima/ima_fs.c:30:0:
> > security/integrity/ima/ima.h:176:7: error: redeclaration of enumerator ‘NONE’
> >   hook(NONE)   \
> >        ^
> > security/integrity/ima/ima.h:188:34: note: in definition of macro ‘__ima_hook_enumify’
> >  #define __ima_hook_enumify(ENUM) ENUM,
> >                                   ^
> > security/integrity/ima/ima.h:191:2: note: in expansion of macro ‘__ima_hooks’
> >   __ima_hooks(__ima_hook_enumify)
> >   ^
> > In file included from ./arch/arm64/include/asm/acpi.h:15:0,
> >                  from ./include/acpi/acpi_io.h:7,
> >                  from ./include/linux/acpi.h:47,
> >                  from ./include/linux/tpm.h:26,
> >                  from security/integrity/ima/ima.h:25,
> >                  from security/integrity/ima/ima_fs.c:30:
> > ./include/linux/efi.h:1716:2: note: previous definition of ‘NONE’ was here
> >   NONE,
> >   ^
> > scripts/Makefile.build:276: recipe for target 'security/integrity/ima/ima_fs.o' failed
> > make[3]: *** [security/integrity/ima/ima_fs.o] Error 1
> > 
> > I dug it and it is the commit 901615cb916d ("tpm: move tpm_chip definition to include/linux/tpm.h")
> 
> This results from a new include in tpm.h:
> 
>   #include <linux/acpi.h>
> 
> Must be fixed either in include/linux/efi.h or security/integrity/ima.h as
> those files have a name collision. Makes me wonder why neither has taken
> care of prefixing the constants properly.

Preferably both subsystems should be fixed with proper 'EFI_' and 'IMA_'
prefixes. Defining a constant named as NONE in a non-generic subsystem
(e.g. not part of the core data structures of Linux) and especially
exporting it to include/linux is not too well considered act.

/Jarkko
