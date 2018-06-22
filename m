Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA29C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A32423DF4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A32423DF4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeFVG4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:56:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40643 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeFVG4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:56:34 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWFzL-0000Z0-W9; Fri, 22 Jun 2018 08:56:08 +0200
Date:   Fri, 22 Jun 2018 08:56:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: manual merge of the tip tree with the vfs tree
In-Reply-To: <e6a26908-67b2-e32e-06b5-d2e62acce305@intel.com>
Message-ID: <alpine.DEB.2.21.1806220855090.1591@nanos.tec.linutronix.de>
References: <20180622115346.1e9cc433@canb.auug.org.au> <e6a26908-67b2-e32e-06b5-d2e62acce305@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018, Reinette Chatre wrote:
> I am the contributor of the pseudo-locking related code that caused the
> conflict.
> 
> Stephen, thank you very much for proceeding with the merge and fixing it
> up. I copied your later fix addition to this email and combined they
> look good. I did some basic smoke testing of the merged code and it works.
> 
> Thomas and David, please let me know what I can do from my side to help
> with this.

I'll have a look later today.

> 
> As summary, with the above changes combined the merge can be done using:
> 
> ->8-
> diff --cc arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> index 7b4a09d81a30,38a54f56ff40..caa2754f8948
> --- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> @@@ -1861,16 -1270,9 +1842,13 @@@ static int rdt_get_tree(struct fs_conte
>   		rdtgroup_default.mon.mon_data_kn = kn_mondata;
>   	}
> 
>  +	ret = rdt_pseudo_lock_init();
> - 	if (ret) {
> - 		dentry = ERR_PTR(ret);
> ++	if (ret)
>  +		goto out_mondata;
> - 	}
>  +
> - 	dentry = kernfs_mount(fs_type, flags, rdt_root,
> - 			      RDTGROUP_SUPER_MAGIC, NULL);
> - 	if (IS_ERR(dentry))
> + 	ret = kernfs_get_tree(fc);
> + 	if (ret < 0)
>  -		goto out_mondata;
>  +		goto out_psl;
> 
>   	if (rdt_alloc_capable)
>   		static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
> 
> Reinette
> 
> 
