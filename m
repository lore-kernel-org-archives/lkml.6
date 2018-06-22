Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FA7C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660982246A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660982246A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbeFVGNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:13:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:2713 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbeFVGNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:13:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 23:13:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,255,1526367600"; 
   d="scan'208";a="66274145"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.80.177]) ([10.254.80.177])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jun 2018 23:13:33 -0700
Subject: Re: linux-next: manual merge of the tip tree with the vfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
References: <20180622115346.1e9cc433@canb.auug.org.au>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <e6a26908-67b2-e32e-06b5-d2e62acce305@intel.com>
Date:   Thu, 21 Jun 2018 23:13:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180622115346.1e9cc433@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All,

On 6/21/2018 6:53 PM, Stephen Rothwell wrote:
> Today's linux-next merge of the tip tree got a conflict in:
> 
>   arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> 
> between commit:
> 
>   58e4e43911f8 ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")
> 
> from the vfs tree and commit:
> 
>   a3dbd01e6c9d ("x86/intel_rdt: Create character device exposing pseudo-loc=
> ked region")
> 
> from the tip tree.
> 
> I fixed it up (I think - see below) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> --
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> index 38a54f56ff40,7b4a09d81a30..000000000000
> --- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> @@@ -1270,9 -1861,16 +1842,15 @@@ static int rdt_get_tree(struct fs_conte
>   		rdtgroup_default.mon.mon_data_kn = kn_mondata;
>   	}
>  
> + 	ret = rdt_pseudo_lock_init();
> + 	if (ret) {
> + 		dentry = ERR_PTR(ret);
> + 		goto out_mondata;
> + 	}
> +
>  -	dentry = kernfs_mount(fs_type, flags, rdt_root,
>  -			      RDTGROUP_SUPER_MAGIC, NULL);
>  -	if (IS_ERR(dentry))
>  +	ret = kernfs_get_tree(fc);
>  +	if (ret < 0)
> - 		goto out_mondata;
> + 		goto out_psl;
>  
>   	if (rdt_alloc_capable)
>   		static_branch_enable_cpuslocked(&rdt_alloc_enable_key);


>> + 	ret = rdt_pseudo_lock_init();
>> + 	if (ret) {
>> + 		dentry = ERR_PTR(ret);
>
> Actually I have removed the above line as well.

I am the contributor of the pseudo-locking related code that caused the
conflict.

Stephen, thank you very much for proceeding with the merge and fixing it
up. I copied your later fix addition to this email and combined they
look good. I did some basic smoke testing of the merged code and it works.

Thomas and David, please let me know what I can do from my side to help
with this.

As summary, with the above changes combined the merge can be done using:

->8-
diff --cc arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 7b4a09d81a30,38a54f56ff40..caa2754f8948
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@@ -1861,16 -1270,9 +1842,13 @@@ static int rdt_get_tree(struct fs_conte
  		rdtgroup_default.mon.mon_data_kn = kn_mondata;
  	}

 +	ret = rdt_pseudo_lock_init();
- 	if (ret) {
- 		dentry = ERR_PTR(ret);
++	if (ret)
 +		goto out_mondata;
- 	}
 +
- 	dentry = kernfs_mount(fs_type, flags, rdt_root,
- 			      RDTGROUP_SUPER_MAGIC, NULL);
- 	if (IS_ERR(dentry))
+ 	ret = kernfs_get_tree(fc);
+ 	if (ret < 0)
 -		goto out_mondata;
 +		goto out_psl;

  	if (rdt_alloc_capable)
  		static_branch_enable_cpuslocked(&rdt_alloc_enable_key);

Reinette

