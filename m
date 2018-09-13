Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED3BC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3832220853
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3832220853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeIMX6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:58:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46321 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeIMX6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:58:25 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0WeM-0000Gc-BM; Thu, 13 Sep 2018 20:47:34 +0200
Date:   Thu, 13 Sep 2018 20:47:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v7 0/5] x86: Fix SEV guest regression
In-Reply-To: <43c95311-dd8b-77c7-0949-28fc3f961bef@amd.com>
Message-ID: <alpine.DEB.2.21.1809132042100.1473@nanos.tec.linutronix.de>
References: <1536616151-16738-1-git-send-email-brijesh.singh@amd.com> <alpine.DEB.2.21.1809131622180.1473@nanos.tec.linutronix.de> <43c95311-dd8b-77c7-0949-28fc3f961bef@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018, Brijesh Singh wrote:
> On 09/13/2018 11:22 AM, Thomas Gleixner wrote:
> > I really have to ask why this whole change to sme_encrypt_kernel() is
> > required at all.
> 
> The main reason behind making the changes in sme_encrypt_kernel() was
> to perverse the initialized values (if any). Since we are adding
>  __decrypted attribute hence I thought it would make sense to support
> the usecase where in future someone may use this attribute on initialized
> variables.
> 
> Now the question is, do we really need this to fix the regression? the
> answer is NO. Since there is only one user of this new attribute and
> lucky it does not initialize the variables hence it is safe to move the
> variable in .bss..decrypted section and memset(0).

And even if it would it usually trivial enought to make it run time
initialized.

> > 1) Add a .bss..decrypted section which is PMD aligned and mark the
> >     kvmclock hv_clock_boot and wallclock struct with __bss_decrypted.
> >  > 2) Fixup the .bss..decrypted section PMD in the SEV case at the end of
> >     sme_encrypt_kernel() and do a memset(0) on that. That does not require
> >     any of the restructuring, really.
> > 
> 
> Somewhere during the discussion, I was asked to make sure that
>  __decrypted attribute can be used by others in future and don't tie it
> with just the kvmclock.

Well, .bss..decrypted can be used by other things and we really only want
to do the .data..decrypted thing when there is a fundamental reason to do
so.

> To fix the regression we don't need to have this complexity. I am okay
> to implement your proposal. I would like to fix this regression sooner
> than later ;)
> 
> 
> > 3) Have a function which is called after the page allocator is up which
> >     does:
> > 
> 
> I am glad you are pointing this one. In my initial patch I was doing a
> kmalloc() of page-size, during review we did discussed to do allocation
> once using num_possible_cpus()[like what you have proposed]. But then
> discussion moved towards saving memory and that when the secondary array
> concept came into the picture. Since .data..decrypted has some unused memory
> hence we were getting creative in reusing it.

Sorry I didn't pay attention to that, was busy with other urgent stuff.

> > That should be a halfways slim sized and non instrusive changeset.
> > 
> 
> I am okay to implement and test your recommendation, if anyone
> disagree then please let me know. thanks

It results in simpler code and if the whole thing ends up allocating a few
KB too much due to the page allocations then so be it. It's not going to
waste 256K in one go.

Thanks,

	tglx
