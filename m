Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46955C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174C82081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174C82081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeLJShd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:37:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeLJShd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:37:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15AF530014CC;
        Mon, 10 Dec 2018 18:37:33 +0000 (UTC)
Received: from localhost (ovpn-116-63.gru2.redhat.com [10.97.116.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48054600D7;
        Mon, 10 Dec 2018 18:37:32 +0000 (UTC)
Date:   Mon, 10 Dec 2018 16:37:30 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: kvm: RDTSCP on AMD
Message-ID: <20181210183730.GJ4669@habkost.net>
References: <20181210181328.GA762@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210181328.GA762@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 10 Dec 2018 18:37:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 07:13:28PM +0100, Borislav Petkov wrote:
> Reviving an old thread here.
> 
> On Wed, Jul 06, 2016 at 11:27:16PM +0200, Paolo Bonzini wrote:
> > On 06/07/2016 19:34, Eduardo Habkost wrote:
> > >> > Nothing is needed in the kernel actually.  You can skip the intercept
> > >> > by running the guest with MSR_TSC_AUX set to the guest's expected value.
> > >> >  Which KVM does, except that it's botched so I need to apply the
> > >> > patch in https://lkml.org/lkml/2016/4/13/802.
> > > Do you mean -cpu Opteron_G*,+rdtscp will be buggy on Linux v4.5?
> > > (v4.5 reports rdtscp as supported in GET_SUPPORTED_CPUID)
> > > 
> > > Can we do something to make QEMU detect the buggy kernel before
> > > allowing rdtscp to be enabled, or should we just tell people to
> > > upgrade their kernel?
> > 
> > We usually just tell people to use the latest stable kernel.
> > 
> > Adding new CPU models is not a big deal, in fact it's almost easier than
> > getting compat properties right. :)
> 
> Ok, can we finally revert
> 
>   33b5e8c03ae7 ("target-i386: Disable rdtscp on Opteron_G* CPU models")
> 
> in the qemu tree?
> 
> Three years should be enough by now for
> 
>   46896c73c1a4 ("KVM: svm: add support for RDTSCP")
> 
> to have percolated downstream.

That's Linux v4.5, released in March 2016.

It isn't as simply as reverting commit 33b5e8c03ae7, but we can
surely re-add RDTSCP on pc-*-4.0 and newer.

I thought we added documentation mentioning the minimum kernel
version required by QEMU, but I can't find it.  In either case,
it seems reasonable to require Linux 4.5 or newer on newer
machine-types.

-- 
Eduardo
