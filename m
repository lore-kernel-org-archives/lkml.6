Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FD8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EB221726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548190112;
	bh=/XvGFU6QBSeUrZkfs0UomTtvYGR47cxPWqpY36biYSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tryjLXjzHMQbRmdRD4PcPoJqNphkah7coVtArX7cLt+PVLr+HhSzW2tRaax0Su3uj
	 UCFUxOsCDWeDxB9Zlit4sH5GRWkyn9Hl+wOkFgAA/WmlvuBU4DDc2PkNhY/f6JMBrf
	 CJhjzi6PcUlFhNw54wvwgZ23TEmLwW/7O2vRYEAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfAVUsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:48:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:32984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAVUsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:48:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0115521726;
        Tue, 22 Jan 2019 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548190110;
        bh=/XvGFU6QBSeUrZkfs0UomTtvYGR47cxPWqpY36biYSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmLkpQlwJmEyiwBArRPO+LMzG93T37FWJ4PNE8ja9iU3U3QGHW9NMPOf72Jl0N8kM
         whiSnXZXP2bB8vessiRxMAc4AKlG+8kbI0jdKEMFusAyQe5i3tB2hvmRucvIWHUyT/
         pehSEzRNzPCBQp3BHOFFI6XR91c6mjkaj4BSuJPA=
Date:   Tue, 22 Jan 2019 21:48:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH] kvm: no need to check return value of debugfs_create
 functions
Message-ID: <20190122204828.GA30805@kroah.com>
References: <20190122152151.16139-51-gregkh@linuxfoundation.org>
 <69eee5dd-5893-c93a-a9df-036f02dfbc1c@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69eee5dd-5893-c93a-a9df-036f02dfbc1c@de.ibm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 09:39:24PM +0100, Christian Borntraeger wrote:
> 
> 
> On 22.01.2019 16:21, Greg Kroah-Hartman wrote:
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  virt/kvm/kvm_main.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 5ecea812cb6a..4f96450ecdfc 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2528,9 +2528,7 @@ static int kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
> > 
> >  	snprintf(dir_name, sizeof(dir_name), "vcpu%d", vcpu->vcpu_id);
> >  	vcpu->debugfs_dentry = debugfs_create_dir(dir_name,
> > -								vcpu->kvm->debugfs_dentry);
> > -	if (!vcpu->debugfs_dentry)
> > -		return -ENOMEM;
> > +						  vcpu->kvm->debugfs_dentry);
> > 
> >  	ret = kvm_arch_create_vcpu_debugfs(vcpu);
> >  	if (ret < 0) {
> > 
> 
> 
> The interesting part of these debugfs entries is that they export an interface that is used
> by the kvm_stat tool. (and all distributions that I checked have debugfs enabled).
> 
> I think it is pretty unlikely that things will fail, but the question is: do we want to reject
> VM creation if that VM cannot be observed by instrumentation or not? No idea.

No you should not as any other part of the kernel can randomly create
the same debugfs files and keep your code from being able to create
them :)

> This also brings the question: shall we move these counters out of debugfs into something else?

If you have code that relies on debugfs, yes, you need to move that out
of debugfs because more and more systems are trying to disable it due to
the obvious problems with it (i.e. leaking tons of debugging
information).

debugfs is for DEBUG information, not for "statistics about how my VM is
working".  That sounds like something you need to rely on, so debugfs is
not the place for it.

thanks,

greg k-h
