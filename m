Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F2A09C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D1120660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D1120660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934245AbeFLRpr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:45:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933244AbeFLRpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:45:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4EF4307D854;
        Tue, 12 Jun 2018 17:45:45 +0000 (UTC)
Received: from hmswarspite.think-freely.org (ovpn-121-97.rdu2.redhat.com [10.10.121.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0529484ED;
        Tue, 12 Jun 2018 17:45:41 +0000 (UTC)
Date:   Tue, 12 Jun 2018 13:45:35 -0400
From:   Neil Horman <nhorman@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        npmccallum@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, andy@infradead.org
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
Message-ID: <20180612174535.GE19168@hmswarspite.think-freely.org>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
 <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org>
 <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 12 Jun 2018 17:45:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 09:55:29PM -0700, Andy Lutomirski wrote:
> On Mon, Jun 11, 2018 at 4:52 AM Neil Horman <nhorman@redhat.com> wrote:
> >
> > On Sun, Jun 10, 2018 at 10:17:13PM -0700, Andy Lutomirski wrote:
> > > > On Jun 9, 2018, at 10:39 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > > >
> > > > On Fri, Jun 8, 2018 at 10:32 AM Jarkko Sakkinen
> > > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > >>
> > > >> The Launch Enclave (LE) generates cryptographic launch tokens for user
> > > >> enclaves. A launch token is used by EINIT to check whether the enclave
> > > >> is authorized to launch or not. By having its own launch enclave, Linux
> > > >> has full control of the enclave launch process.
> > > >>
> > > >> LE is wrapped into a user space proxy program that reads enclave
> > > >> signatures outputs launch tokens. The kernel-side glue code is
> > > >> implemented by using the user space helper framework.  The IPC between
> > > >> the LE proxy program and kernel is handled with an anonymous inode.
> > > >>
> > > >> The commit also adds enclave signing tool that is used by kbuild to
> > > >> measure and sign the launch enclave. CONFIG_INTEL_SGX_SIGNING_KEY points
> > > >> to a PEM-file for the 3072-bit RSA key that is used as the LE public key
> > > >> pair. The default location is:
> > > >>
> > > >>  drivers/platform/x86/intel_sgx/sgx_signing_key.pem
> > > >>
> > > >> If the default key does not exist kbuild will generate a random key and
> > > >> place it to this location. KBUILD_SGX_SIGN_PIN can be used to specify
> > > >> the passphrase for the LE public key.
> > > >
> > > > It seems to me that it might be more useful to just commit a key pair
> > > > into the kernel.  As far as I know, there is no security whatsoever
> > > > gained by keeping the private key private, so why not make
> > > > reproducible builds easier by simply fixing the key?
> > >
> > > Having thought about this some more, I think that you should
> > > completely remove support for specifying a key. Provide a fixed key
> > > pair, hard code the cache, and call it a day. If you make the key
> > > configurable, every vendor that has any vendor keys (Debian, Ubuntu,
> > > Fedora, Red Hat, SuSE, Clear Linux, etc) will see that config option
> > > and set up their own key pair for no gain whatsoever.  Instead, it'll
> > > give some illusion of security and it'll slow down operations in a VM
> > > guest due to swapping out the values of the MSRs.  And, if the code to
> > > support a locked MSR that just happens to have the right value stays
> > > in the kernel, then we'll risk having vendors actually ship one
> > > distro's public key hash, and that will seriously suck.
> > >
> > If you hard code the key pair however, doesn't that imply that anyone can sign a
> > user space binary as a launch enclave, and potentially gain control of the token
> > granting process?
> 
> Yes and no.
> 
> First of all, the kernel driver shouldn't be allowing user code to
> launch a launch enclave regardless of signature.  I haven't gotten far
> enough in reviewing the code to see whether that's the case, but if
> it's not, it should be fixed before it's merged.
> 
Ok, I agree with you here.

> But keep in mind that control of the token granting process is not the
> same thing as control over the right to launch an enclave.  On systems
> without the LE hash MSRs, Intel controls the token granting process
> and, barring some attack, an enclave that isn't blessed by Intel can't
> be launched.  Support for that model will not be merged into upstream
> Linux.  But on systems that have the LE hash MSRs and leave them
> unlocked, there is effectively no hardware-enforced launch control.
> Instead we have good old kernel policy.  If a user wants to launch an
> enclave, they need to get the kernel to launch the enclave, and the
> kernel needs to apply its policy.  The patch here (the in-kernel
> launch enclave) has a wide-open policy.
> 

Right, also agree here.  Systems without Flexible Launch Control are a
non-starter, we're only considering FLC systems here

> So, as a practical matter, if every distro has their own LE key and
> keeps it totally safe, then a system that locks the MSRs to one
> distro's key makes it quite annoying to run another distro's intel_sgx
> driver, but there is no effect on the actual security of the system.
> 
I agree that for systems that firmware-lock the msrs are annoying, but I would
think that IHV's would want to keep those msrs unlocked specifically to allow a
wide range of distributions to use this feature.

As for benefits to security, I think there are some.  Namely, by leaving the
MSRS unlocked, A distribution can, rather than providing their own distirbution
key, pass the root of trust on to the end user.  I can easily envision a
downstream customer that wants to use SGX, and do so in such a way that they are
assured that their OS vendor doesn't have the ability to run an LE on their
system (at least not without the visual cue of specifying a different key hash
at the OS boot).

> >  It was my understanding that the value of the key pair was
> > that the end user was guaranteed autonomy and security over which processes
> > could start enclaves.  By publishing a fixed key pair, it seems to remove that
> > ability.
> 
> If someone comes up with an actual machine that grants the actual end
> user (where the end user is the person who bought the thing, not the
> OEM) control over the MSRs, *and* the actual end user wants to limit
> what enclaves can be launched even if the kernel is compromised, *and*
> there is some actual argument for why this is useful (as opposed to
> some compliance checkbox), then Linux could reasonably consider adding
> support for this use case.  But that would be a separate patch.
> 
> >
> > What would be nicer (I think) would be the abilty to specify both the public and
> > the private key at run time.  the use case here is not one in which a vendor or
> > os distribution ships a key pair, but one in which a downstream user doesn't
> > want a vendor/os distribution to have any cryptographic information installed on
> > their system
> 
> For what gain?
My use case above is the primary one I was thinking of
Neil

