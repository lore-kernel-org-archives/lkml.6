Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E49C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1392147A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfBRKsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:48:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:36112 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730132AbfBRKsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:48:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 02:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,384,1544515200"; 
   d="scan'208";a="147738714"
Received: from lxy-dell.sh.intel.com ([10.239.159.147])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2019 02:48:39 -0800
Message-ID: <1e29ef488b637d3ddcdc02c35895e30dfece89b8.camel@linux.intel.com>
Subject: Re: [PATCH] kvm: vmx: Fix entry nubmer check for
 add_atomic_switch_msr()
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Date:   Mon, 18 Feb 2019 18:45:41 +0800
In-Reply-To: <03c21ba903c472ef64c57baca0c58217b2212d7e.camel@linux.intel.com>
References: <20190214040858.15975-1-xiaoyao.li@linux.intel.com>
         <20190215164645.GD889@char.us.oracle.com>
         <03c21ba903c472ef64c57baca0c58217b2212d7e.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-18 at 16:26 +0800, linux.intel.com wrote:
> On Fri, 2019-02-15 at 11:46 -0500, Konrad Rzeszutek Wilk wrote:
> > On Thu, Feb 14, 2019 at 12:08:58PM +0800, Xiaoyao Li wrote:
> > > Commit ca83b4a7f2d068da79a0 ("x86/KVM/VMX: Add find_msr() helper
> > > function")
> > > introduces the helper function find_msr(), which returns -ENOENT when
> > > not find the msr in vmx->msr_autoload.guest/host. Correct checking contion
> > 
> > s/not find/cannot find/
> > s/contion/condition/ ?
> > 
> 
> Hi Paolo,
> Could you correct these typos in KVM tree or when sending a PR?
> 

Please disregard this. I just noticed tha this patch had been merged into
mainline.

> > > of no more available entry in vmx->msr_autoload.
> > > 
> > > Fixes: ca83b4a7f2d0 ("x86/KVM/VMX: Add find_msr() helper function")
> > > Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
> > > ---
> > >  arch/x86/kvm/vmx/vmx.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index 95d618045001..1aaef2d536bd 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -863,7 +863,8 @@ static void add_atomic_switch_msr(struct vcpu_vmx
> > > *vmx,
> > > unsigned msr,
> > >  	if (!entry_only)
> > >  		j = find_msr(&m->host, msr);
> > >  
> > > -	if (i == NR_AUTOLOAD_MSRS || j == NR_AUTOLOAD_MSRS) {
> > > +	if ((i < 0 && m->guest.nr == NR_AUTOLOAD_MSRS) ||
> > > +		(j < 0 &&  m->host.nr == NR_AUTOLOAD_MSRS)) {
> > >  		printk_once(KERN_WARNING "Not enough msr switch entries. "
> > >  				"Can't add msr %x\n", msr);
> > >  		return;
> > > -- 
> > > 2.19.1
> > > 

