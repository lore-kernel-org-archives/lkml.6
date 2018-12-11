Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D42DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F198720811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F198720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeLKL4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:56:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbeLKLzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:55:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1A643DE04;
        Tue, 11 Dec 2018 11:55:53 +0000 (UTC)
Received: from localhost (ovpn-116-63.gru2.redhat.com [10.97.116.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC13960C6A;
        Tue, 11 Dec 2018 11:55:49 +0000 (UTC)
Date:   Tue, 11 Dec 2018 09:55:46 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Eric Blake <eblake@redhat.com>
Subject: Re: kvm: RDTSCP on AMD
Message-ID: <20181211115546.GQ4669@habkost.net>
References: <20181210181328.GA762@zn.tnic>
 <20181210183730.GJ4669@habkost.net>
 <20181210184153.GB5482@zn.tnic>
 <20181210190600.GK4669@habkost.net>
 <20181210194258.GD5482@zn.tnic>
 <20181210200843.GN4669@habkost.net>
 <20181211103839.GC921@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181211103839.GC921@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 11 Dec 2018 11:55:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:38:39AM +0000, Daniel P. Berrangé wrote:
> On Mon, Dec 10, 2018 at 06:08:43PM -0200, Eduardo Habkost wrote:
> > On Mon, Dec 10, 2018 at 08:42:58PM +0100, Borislav Petkov wrote:
> > > On Mon, Dec 10, 2018 at 05:06:00PM -0200, Eduardo Habkost wrote:
> > > > I mean documenting it.  We already have code that will print
> > > > warnings if a feature isn't available.
> > > > 
> > > > See my previous attempt to document the minimum kernel version
> > > > at <https://www.mail-archive.com/qemu-devel@nongnu.org/msg486559.html>.
> > > 
> > > Something like this?
> > > 
> > > I still have no clue how to add RDTSCP on pc-*-4.0 and newer.
> > 
> > qemu.git master have no PC_COMPAT_3_1 and pc-*-4.0 machine-types
> > yet.  I've sent another reply with additional pointers.
> > 
> > > 
> > > Thx.
> > > 
> > > ---
> > > diff --git a/qemu-doc.texi b/qemu-doc.texi
> > > index f7ad1dfe4b69..913b2ef68d54 100644
> > > --- a/qemu-doc.texi
> > > +++ b/qemu-doc.texi
> > > @@ -37,6 +37,7 @@
> > >  * QEMU System emulator for non PC targets::
> > >  * QEMU Guest Agent::
> > >  * QEMU User space emulator::
> > > +* System requirements::
> > >  * Implementation notes::
> > >  * Deprecated features::
> > >  * Supported build platforms::
> > > @@ -2813,6 +2814,13 @@ Act as if the host page size was 'pagesize' bytes
> > >  Run the emulation in single step mode.
> > >  @end table
> > >  
> > > +@node System requirements
> > > +@chapter System requirements
> > > +
> > > +@section KVM kernel module
> > > +
> > > +On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
> > > +require the host to be running Linux v4.5 or newer.
> > >  
> > 
> > Sounds good, but it would be nice to document what exactly makes
> > Linux 4.5+ necessary.  e.g.:
> > 
> > | On x86_64 hosts, it is recommended to run Linux 4.5 or newer on
> > | the host when using the KVM accelerator.
> > | 
> > | The Opteron_G2, OpteronG3, Opteron_G4, and Opteron_G5 CPU
> > | models require KVM support for RDTSCP, which was added on
> > | Linux 4.5.
> > 
> > I'm CCing some people who may help review English grammar and
> > style.
> 
> Note that QEMU has a declared supported platform list which is used to
> set the minimum software versions required.
> 
>    https://qemu.weilnetz.de/doc/qemu-doc.html#Linux-OS
> 
> Based on that policy, the Linux distros we aim to support have the
> following kernel versions:
> 
>   - Debian Jessie: 4.5
>   - Debian Stretch: 4.5
>   - RHEL-7: 3.10
>   - Ubuntu LTS (Xenial): 4.5
>   - OpenSUSE Leap 15: 4.12.14
> 
> So we can't require Linux 4.5 as a minimum version at this time.

I'd like us to take a step back and consider what exactly
"support" means here.  QEMU will still work on older kernels if
we add RDTSCP to the CPU models, but at the same time I would
like to document that our strict runnability guarantees may not
be kept if running Linux < 4.5.

-- 
Eduardo
