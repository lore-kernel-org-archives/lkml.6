Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9B8C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBB920693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjqkg+7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBB920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936949AbeFRV7P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755003AbeFRV7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:59:13 -0400
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com [209.85.128.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBC220874
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 21:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529359153;
        bh=d6xQiBMg3Lby3zzSeH158SbKgbuPidzY4bW3qxu7Zbk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fjqkg+7r+npot5QWaDTe6tKZoMSkpd/zUDEJ6kMmhHf4P5jZb7+/r2R1q34ycGDPa
         dJG8E1jjM+hokwhopX7Er8ZH5Ysc0T+xX9TuVYbShJGvLqtTvVwqa14q0FuOxz9elz
         Qr+TQFBzrrPqk5FJkFXH8UsE7Wd+9VdWwkZRXs58=
Received: by mail-wr0-f174.google.com with SMTP id w10-v6so18385414wrk.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 14:59:12 -0700 (PDT)
X-Gm-Message-State: APt69E3a4+w3HZgB9xx4sUrtcMVtCH/vr0fF8JTvQT1zwld+ao98dny9
        iRySyFL4ZPzJZHsDvK1z03JC8Vh1c+NiCupl2wM0pQ==
X-Google-Smtp-Source: ADUXVKJaF1jGzSz/a6gkp1W1te8Lx2SpDRL5jXrEy70MepG3kSBqKFhWLks2Btfp5W7hw7CZc/xYShp+I8vMmz+n+TE=
X-Received: by 2002:adf:b1ca:: with SMTP id r10-v6mr10992062wra.221.1529359151226;
 Mon, 18 Jun 2018 14:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com> <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org> <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org>
In-Reply-To: <20180612174535.GE19168@hmswarspite.think-freely.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 18 Jun 2018 14:58:59 -0700
X-Gmail-Original-Message-ID: <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
Message-ID: <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To:     nhorman@redhat.com
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        npmccallum@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, andy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:45 AM Neil Horman <nhorman@redhat.com> wrote:
>
> On Mon, Jun 11, 2018 at 09:55:29PM -0700, Andy Lutomirski wrote:
> > On Mon, Jun 11, 2018 at 4:52 AM Neil Horman <nhorman@redhat.com> wrote:
> > >
> > > On Sun, Jun 10, 2018 at 10:17:13PM -0700, Andy Lutomirski wrote:
> > > > > On Jun 9, 2018, at 10:39 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > > > >
> > > > > On Fri, Jun 8, 2018 at 10:32 AM Jarkko Sakkinen
> > > > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > > >>
> > > > >> The Launch Enclave (LE) generates cryptographic launch tokens for user
> > > > >> enclaves. A launch token is used by EINIT to check whether the enclave
> > > > >> is authorized to launch or not. By having its own launch enclave, Linux
> > > > >> has full control of the enclave launch process.
> > > > >>
> > > > >> LE is wrapped into a user space proxy program that reads enclave
> > > > >> signatures outputs launch tokens. The kernel-side glue code is
> > > > >> implemented by using the user space helper framework.  The IPC between
> > > > >> the LE proxy program and kernel is handled with an anonymous inode.
> > > > >>
> > > > >> The commit also adds enclave signing tool that is used by kbuild to
> > > > >> measure and sign the launch enclave. CONFIG_INTEL_SGX_SIGNING_KEY points
> > > > >> to a PEM-file for the 3072-bit RSA key that is used as the LE public key
> > > > >> pair. The default location is:
> > > > >>
> > > > >>  drivers/platform/x86/intel_sgx/sgx_signing_key.pem
> > > > >>
> > > > >> If the default key does not exist kbuild will generate a random key and
> > > > >> place it to this location. KBUILD_SGX_SIGN_PIN can be used to specify
> > > > >> the passphrase for the LE public key.
> > > > >
> > > > > It seems to me that it might be more useful to just commit a key pair
> > > > > into the kernel.  As far as I know, there is no security whatsoever
> > > > > gained by keeping the private key private, so why not make
> > > > > reproducible builds easier by simply fixing the key?
> > > >
> > > > Having thought about this some more, I think that you should
> > > > completely remove support for specifying a key. Provide a fixed key
> > > > pair, hard code the cache, and call it a day. If you make the key
> > > > configurable, every vendor that has any vendor keys (Debian, Ubuntu,
> > > > Fedora, Red Hat, SuSE, Clear Linux, etc) will see that config option
> > > > and set up their own key pair for no gain whatsoever.  Instead, it'll
> > > > give some illusion of security and it'll slow down operations in a VM
> > > > guest due to swapping out the values of the MSRs.  And, if the code to
> > > > support a locked MSR that just happens to have the right value stays
> > > > in the kernel, then we'll risk having vendors actually ship one
> > > > distro's public key hash, and that will seriously suck.
> > > >
> > > If you hard code the key pair however, doesn't that imply that anyone can sign a
> > > user space binary as a launch enclave, and potentially gain control of the token
> > > granting process?
> >
> > Yes and no.
> >
> > First of all, the kernel driver shouldn't be allowing user code to
> > launch a launch enclave regardless of signature.  I haven't gotten far
> > enough in reviewing the code to see whether that's the case, but if
> > it's not, it should be fixed before it's merged.
> >
> Ok, I agree with you here.
>
> > But keep in mind that control of the token granting process is not the
> > same thing as control over the right to launch an enclave.  On systems
> > without the LE hash MSRs, Intel controls the token granting process
> > and, barring some attack, an enclave that isn't blessed by Intel can't
> > be launched.  Support for that model will not be merged into upstream
> > Linux.  But on systems that have the LE hash MSRs and leave them
> > unlocked, there is effectively no hardware-enforced launch control.
> > Instead we have good old kernel policy.  If a user wants to launch an
> > enclave, they need to get the kernel to launch the enclave, and the
> > kernel needs to apply its policy.  The patch here (the in-kernel
> > launch enclave) has a wide-open policy.
> >
>
> Right, also agree here.  Systems without Flexible Launch Control are a
> non-starter, we're only considering FLC systems here
>
> > So, as a practical matter, if every distro has their own LE key and
> > keeps it totally safe, then a system that locks the MSRs to one
> > distro's key makes it quite annoying to run another distro's intel_sgx
> > driver, but there is no effect on the actual security of the system.
> >
> I agree that for systems that firmware-lock the msrs are annoying, but I would
> think that IHV's would want to keep those msrs unlocked specifically to allow a
> wide range of distributions to use this feature.
>
> As for benefits to security, I think there are some.  Namely, by leaving the
> MSRS unlocked, A distribution can, rather than providing their own distirbution
> key, pass the root of trust on to the end user.  I can easily envision a
> downstream customer that wants to use SGX, and do so in such a way that they are
> assured that their OS vendor doesn't have the ability to run an LE on their
> system (at least not without the visual cue of specifying a different key hash
> at the OS boot).

Which achieves what, exactly?  The launch public key hash isn't the
root of trust of anything except for a really awkward mechanism to
limit the enclaves that get run.  If there is actual demand to limit
enclaves that get run, let's do it correctly: add some code in the
kernel that enforces a policy before launching an enclave.

If the MSRs are unlocked, there is no stronger guarantee available
even if you supply your own custom LE.  If the kernel is owned, the
attacker can just change the MSRs.

--Andy
