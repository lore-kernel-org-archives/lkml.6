Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6070CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289D72084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550766038;
	bh=g8a0jQRoJWFhN0EfdgP0DOOdrmeOSpezIEfnelfCx+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d+n7XZ0LNmnwjQOQ1silu5/cJOHUyUCDFeYxufAMsa4ixy2eHchVRiQ9O0pbfB58h
	 b6TOldD96iaV7koCcwNqblS+VSit+Q+Y3/8BLvFCOFGP5ibGERd+Q5Uqk5ibQ+WuA9
	 e++FKCWL8aTAxB1N24WYY78kKbjmTp9nfIcGzvTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfBUQUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfBUQUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:20:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2C120836;
        Thu, 21 Feb 2019 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550766035;
        bh=g8a0jQRoJWFhN0EfdgP0DOOdrmeOSpezIEfnelfCx+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtgTiVIC1pHAiBwVhwx5wMQ3tqZuPVdMp8qu9rgeLVu6Gi0jTwWKu4ktFrU8y1Opn
         zdcGfUE1+nkuOUJqN9wCKf/a/rpX8OLT1jDX51uow8CI+8XzFl5/J9txgPYxiWVcik
         D1NWTaRslj8o0VE7EisFN/YKPNvBN/VFajJ4gAMc=
Date:   Thu, 21 Feb 2019 17:20:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable-4.4.y] KVM: VMX: Fix x2apic check in
 vmx_msr_bitmap_mode()
Message-ID: <20190221162032.GF25800@kroah.com>
References: <20190221135213.23926-1-joro@8bytes.org>
 <20190221141530.GA18436@kroah.com>
 <20190221144701.GB8380@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221144701.GB8380@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:47:01PM +0100, Joerg Roedel wrote:
> On Thu, Feb 21, 2019 at 03:15:30PM +0100, Greg Kroah-Hartman wrote:
> > Ugh, good catch!
> > 
> > Any hint as to what type of testing that you did that caught this?  I
> > keep asking people to run some kvm tests, but so far no one is :(
> 
> We caught this at SUSE while testing candidate kernel updates for one of
> our service packs using a 4.4-based kernel and debugging turned
> out that this is issue came in via stable-updates. We also build a
> vanilla-flavour of the kernel which is nearly identical to the upstream
> stable tree, but what usually ends up in testing is the full tree with
> other backports.
> 
> This particular issue was found by updating some openstack machines with
> the candidate kernel, which then triggered the problem in some guests.
> It is also a very special one, since I was only able to trigger the
> problem on Westmere-based machines with a specific guest-config.

Nice work.  Any chance that "test" could be added to the kvm testing
scripts that I think are being worked on somewhere?  Ideally we would
have caught this before it ever hit the stable tree.  Due to the lack of
good KVM testing, that's one of the areas I am always most worried about
:(

thanks,

greg k-h
