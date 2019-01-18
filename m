Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6F6C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3C220657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 20:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="MhZZaBG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfARU7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 15:59:11 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44806 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729438AbfARU7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 15:59:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 72CBD8EE390;
        Fri, 18 Jan 2019 12:59:09 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gWpT6TjEA-uz; Fri, 18 Jan 2019 12:59:09 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 454F98EE10C;
        Fri, 18 Jan 2019 12:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1547845148;
        bh=dmI/Oc23LdJh4fCwzCDnymAt9XHQbvrq1W62yochkx8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MhZZaBG61xodxKv1R0jt1qqJTXQMPH7Er0EOZ3hK1PChXehIqGSd6oVQrpK7D6pS2
         tDT5Gcphttu5MDUp4lOvtDTEp6im86tqC83IB2IRVz0rtVujMDMe55U1A0FgM+8FhN
         n26N/3DrFXqPN+9LeE+rPT2a2cyLlTbod1Xdhgj0=
Message-ID: <1547845146.2794.69.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Ryan Chen <yu.chen.surf@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>
Date:   Fri, 18 Jan 2019 12:59:06 -0800
In-Reply-To: <20190118143348.GB4080@linux.intel.com>
References: <20190103143227.9138-1-jlee@suse.com>
         <4499700.LRS4F2YjjC@tauon.chronox.de>
         <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
         <1565399.7ulKdI1fm5@tauon.chronox.de>
         <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
         <1546994671.6077.10.camel@HansenPartnership.com>
         <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
         <20190111140226.GA6448@linux.intel.com>
         <1547220538.2793.6.camel@HansenPartnership.com>
         <20190118143348.GB4080@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-01-18 at 16:33 +0200, Jarkko Sakkinen wrote:
> On Fri, Jan 11, 2019 at 07:28:58AM -0800, James Bottomley wrote:
> > On Fri, 2019-01-11 at 16:02 +0200, Jarkko Sakkinen wrote:
> > > On Tue, Jan 08, 2019 at 05:43:53PM -0800, Andy Lutomirski wrote:
> > > > (Also, do we have a sensible story of how the TPM interacts
> > > > with hibernation at all?  Presumably we should at least try to
> > > > replay the PCR operations that have occurred so that we can
> > > > massage the PCRs into the same state post-hibernation.  Also,
> > > > do we have any way for the kernel to sign something with the
> > > > TPM along with an attestation that the signature was requested
> > > > *by the kernel*?  Something like a sub-hierarchy of keys that
> > > > the kernel explicitly prevents userspace from accessing?)
> > > 
> > > Kernel can keep it is own key hierarchy in memory as TPM2 chips
> > > allow to offload data in encrypted form and load it to TPM when
> > > it needs to use it.
> > > 
> > > The in-kernel resource manager that I initiated couple years ago
> > > provides this type of functionality.
> > 
> > Actually, the resource manager only keeps volatile objects
> > separated when in use not when offloaded.  The problem here is that
> > the object needs to be persisted across reboots, so either it gets
> > written to the NV area, bypassing the resource manager and making
> > it globally visible or it has to get stored in TPM form in the
> > hibernation image, meaning anyone with access to the TPM who can
> > read the image can extract and load it. Further: anyone with access
> > to the TPM can create a bogus sealed key and encrypt a malicious
> > hibernation image with it.  So there are two additional problems
> > 
> >    1. Given that the attacker may have access to the binary form of
> > the
> >       key, can we make sure only the kernel can get it released?
> >    2. How do we prevent an attacker with access to the TPM from
> > creating a
> >       bogus sealed key?
> > 
> > This is why I was thinking localities.
> 
> Why you would want to go for localities and not seal to PCRs?

Because the requested functionality was a key that would be accessible
to the kernel and not to user space and also guaranteed created by the
kernel.  The only discriminator we have to enforce that is the locality
(assuming we reserve a locality as accessible to the kernel but
inaccessible to userspace).  PCRs alone can't restrict where the key is
accessed or created from.

James

