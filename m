Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D614C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5609E2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfBURAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:00:45 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:43221 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBURAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:00:45 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gwriD-00075H-7D; Thu, 21 Feb 2019 17:00:41 +0000
Message-ID: <1550768440.2925.259.camel@codethink.co.uk>
Subject: Re: [PATCH stable-4.4.y] KVM: VMX: Fix x2apic check in
 vmx_msr_bitmap_mode()
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Date:   Thu, 21 Feb 2019 17:00:40 +0000
In-Reply-To: <20190221162032.GF25800@kroah.com>
References: <20190221135213.23926-1-joro@8bytes.org>
         <20190221141530.GA18436@kroah.com> <20190221144701.GB8380@suse.de>
         <20190221162032.GF25800@kroah.com>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-21 at 17:20 +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 21, 2019 at 03:47:01PM +0100, Joerg Roedel wrote:
> > On Thu, Feb 21, 2019 at 03:15:30PM +0100, Greg Kroah-Hartman wrote:
> > > Ugh, good catch!
> > > 
> > > Any hint as to what type of testing that you did that caught this?  I
> > > keep asking people to run some kvm tests, but so far no one is :(
> > 
> > We caught this at SUSE while testing candidate kernel updates for one of
> > our service packs using a 4.4-based kernel and debugging turned
> > out that this is issue came in via stable-updates. We also build a
> > vanilla-flavour of the kernel which is nearly identical to the upstream
> > stable tree, but what usually ends up in testing is the full tree with
> > other backports.
> > 
> > This particular issue was found by updating some openstack machines with
> > the candidate kernel, which then triggered the problem in some guests.
> > It is also a very special one, since I was only able to trigger the
> > problem on Westmere-based machines with a specific guest-config.
> 
> Nice work.  Any chance that "test" could be added to the kvm testing
> scripts that I think are being worked on somewhere?  Ideally we would
> have caught this before it ever hit the stable tree.

If I understood correctly, the bug is specific to my backport.

> Due to the lack of
> good KVM testing, that's one of the areas I am always most worried about
> :(

Since the behaviour in this area depends on the host CPU model this
might not help much.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
