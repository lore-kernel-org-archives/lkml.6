Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3631AC7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080DF2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfATQCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:02:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:18727 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfATQCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:02:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2019 08:02:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,499,1539673200"; 
   d="scan'208";a="137292600"
Received: from smartikx-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.134])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jan 2019 08:02:06 -0800
Date:   Sun, 20 Jan 2019 18:02:04 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
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
Subject: Re: [PATCH 1/5 v2] PM / hibernate: Create snapshot keys handler
Message-ID: <20190120160204.GA30478@linux.intel.com>
References: <4499700.LRS4F2YjjC@tauon.chronox.de>
 <20190108050358.llsox32hggn2jioe@gondor.apana.org.au>
 <1565399.7ulKdI1fm5@tauon.chronox.de>
 <D70458DE-712B-4767-8143-7DC9107689C3@amacapital.net>
 <1546994671.6077.10.camel@HansenPartnership.com>
 <CALCETrWTAYpWv73MgAz=NUfvJSLq965fWMYvJnDepJoRBsgt6Q@mail.gmail.com>
 <20190111140226.GA6448@linux.intel.com>
 <1547220538.2793.6.camel@HansenPartnership.com>
 <20190118143348.GB4080@linux.intel.com>
 <1547845146.2794.69.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547845146.2794.69.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 12:59:06PM -0800, James Bottomley wrote:
> On Fri, 2019-01-18 at 16:33 +0200, Jarkko Sakkinen wrote:
> > On Fri, Jan 11, 2019 at 07:28:58AM -0800, James Bottomley wrote:
> > > On Fri, 2019-01-11 at 16:02 +0200, Jarkko Sakkinen wrote:
> > > > On Tue, Jan 08, 2019 at 05:43:53PM -0800, Andy Lutomirski wrote:
> > > > > (Also, do we have a sensible story of how the TPM interacts
> > > > > with hibernation at all?  Presumably we should at least try to
> > > > > replay the PCR operations that have occurred so that we can
> > > > > massage the PCRs into the same state post-hibernation.  Also,
> > > > > do we have any way for the kernel to sign something with the
> > > > > TPM along with an attestation that the signature was requested
> > > > > *by the kernel*?  Something like a sub-hierarchy of keys that
> > > > > the kernel explicitly prevents userspace from accessing?)
> > > > 
> > > > Kernel can keep it is own key hierarchy in memory as TPM2 chips
> > > > allow to offload data in encrypted form and load it to TPM when
> > > > it needs to use it.
> > > > 
> > > > The in-kernel resource manager that I initiated couple years ago
> > > > provides this type of functionality.
> > > 
> > > Actually, the resource manager only keeps volatile objects
> > > separated when in use not when offloaded.  The problem here is that
> > > the object needs to be persisted across reboots, so either it gets
> > > written to the NV area, bypassing the resource manager and making
> > > it globally visible or it has to get stored in TPM form in the
> > > hibernation image, meaning anyone with access to the TPM who can
> > > read the image can extract and load it. Further: anyone with access
> > > to the TPM can create a bogus sealed key and encrypt a malicious
> > > hibernation image with it.  So there are two additional problems
> > > 
> > >    1. Given that the attacker may have access to the binary form of
> > > the
> > >       key, can we make sure only the kernel can get it released?
> > >    2. How do we prevent an attacker with access to the TPM from
> > > creating a
> > >       bogus sealed key?
> > > 
> > > This is why I was thinking localities.
> > 
> > Why you would want to go for localities and not seal to PCRs?
> 
> Because the requested functionality was a key that would be accessible
> to the kernel and not to user space and also guaranteed created by the
> kernel.  The only discriminator we have to enforce that is the locality
> (assuming we reserve a locality as accessible to the kernel but
> inaccessible to userspace).  PCRs alone can't restrict where the key is
> accessed or created from.

OK, locality would probably make sense, assuming that the key is stored
in nvram.

/Jarkko

/Jarkko
