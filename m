Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADCC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFE920824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFE920824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeKXFMG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:12:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbeKXFMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:12:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91E64308624A;
        Fri, 23 Nov 2018 18:26:43 +0000 (UTC)
Received: from doriath (ovpn-116-114.phx2.redhat.com [10.3.116.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C9471850B;
        Fri, 23 Nov 2018 18:26:42 +0000 (UTC)
Date:   Fri, 23 Nov 2018 13:26:41 -0500
From:   Luiz Capitulino <lcapitulino@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, babu.moger@amd.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: VMX: re-add ple_gap module parameter
Message-ID: <20181123132641.712e2695@doriath>
In-Reply-To: <8049C3CD-E816-4270-A64F-0BB92BD56338@oracle.com>
References: <20181123120214.174457a4@doriath>
        <8049C3CD-E816-4270-A64F-0BB92BD56338@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 23 Nov 2018 18:26:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 19:42:53 +0200
Liran Alon <liran.alon@oracle.com> wrote:

> > On 23 Nov 2018, at 19:02, Luiz Capitulino <lcapitulino@redhat.com> wrote:
> > 
> > 
> > Apparently, the ple_gap parameter was accidentally removed
> > by commit c8e88717cfc6b36bedea22368d97667446318291. Add it
> > back.
> > 
> > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>  
> 
> Weird that nobody noticed this when patch was applied… Thanks.
> Reviewed-by: Liran Alon <liran.alon@oracle.com>

I forgot to mention that I noticed this because I have systems
disabling ple with ple_gap=0 in modprobe.conf. In those systems
kvm_intel won't load anymore.

> 
> > ---
> > arch/x86/kvm/vmx.c | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index 4555077d69ce..be6f13f1c25f 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -174,6 +174,7 @@ module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
> >  * refer SDM volume 3b section 21.6.13 & 22.1.3.
> >  */
> > static unsigned int ple_gap = KVM_DEFAULT_PLE_GAP;
> > +module_param(ple_gap, uint, 0444);
> > 
> > static unsigned int ple_window = KVM_VMX_DEFAULT_PLE_WINDOW;
> > module_param(ple_window, uint, 0444);
> > -- 
> > 2.17.2
> >   
> 

