Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 390DBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00C220693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiYbY8X+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00C220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754148AbeFLEzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752583AbeFLEzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:55:43 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A43208B5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 04:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528779343;
        bh=1nA/EydfIx4cyZfBdRcBXI/SyF9lGTrH5yKeP/1XhbE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DiYbY8X+2z+RBrgasHsDtVeCf3oye2SgajJDzwcarUbgtsVkfoCM53HeEoQmlAGP9
         aeThQ7nyFQTxLbrP00GUdHgWJhf/ZBrr00rSAogk3bmwgdmTlEq3VG1O/8ZyU33zpG
         5n6UwPS9KfRNqlLyCrO4yV0WBRn6FGgv1l30A0zI=
Received: by mail-wm0-f51.google.com with SMTP id l15-v6so13416401wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 21:55:42 -0700 (PDT)
X-Gm-Message-State: APt69E1GZ6IQbBexdlDr6LCVt+wVAXbIMVY6lLjZs5AQmU/ijDU+28Gf
        RBXMMRubJkD0GReJWBbUGFicQbCctja/nWGW5pX/7Q==
X-Google-Smtp-Source: ADUXVKK9BLe5rWHX+DBHLpjsWtVizlwDlFikm1nYmd1o4GjKohA7p99kGXmwNAVghGV1ZAd1Ht9XXMGjWVYmYuIONys=
X-Received: by 2002:a1c:b947:: with SMTP id j68-v6mr910926wmf.144.1528779341100;
 Mon, 11 Jun 2018 21:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com> <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com> <20180611115255.GC22164@hmswarspite.think-freely.org>
In-Reply-To: <20180611115255.GC22164@hmswarspite.think-freely.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 11 Jun 2018 21:55:29 -0700
X-Gmail-Original-Message-ID: <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
Message-ID: <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
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

On Mon, Jun 11, 2018 at 4:52 AM Neil Horman <nhorman@redhat.com> wrote:
>
> On Sun, Jun 10, 2018 at 10:17:13PM -0700, Andy Lutomirski wrote:
> > > On Jun 9, 2018, at 10:39 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On Fri, Jun 8, 2018 at 10:32 AM Jarkko Sakkinen
> > > <jarkko.sakkinen@linux.intel.com> wrote:
> > >>
> > >> The Launch Enclave (LE) generates cryptographic launch tokens for user
> > >> enclaves. A launch token is used by EINIT to check whether the enclave
> > >> is authorized to launch or not. By having its own launch enclave, Linux
> > >> has full control of the enclave launch process.
> > >>
> > >> LE is wrapped into a user space proxy program that reads enclave
> > >> signatures outputs launch tokens. The kernel-side glue code is
> > >> implemented by using the user space helper framework.  The IPC between
> > >> the LE proxy program and kernel is handled with an anonymous inode.
> > >>
> > >> The commit also adds enclave signing tool that is used by kbuild to
> > >> measure and sign the launch enclave. CONFIG_INTEL_SGX_SIGNING_KEY points
> > >> to a PEM-file for the 3072-bit RSA key that is used as the LE public key
> > >> pair. The default location is:
> > >>
> > >>  drivers/platform/x86/intel_sgx/sgx_signing_key.pem
> > >>
> > >> If the default key does not exist kbuild will generate a random key and
> > >> place it to this location. KBUILD_SGX_SIGN_PIN can be used to specify
> > >> the passphrase for the LE public key.
> > >
> > > It seems to me that it might be more useful to just commit a key pair
> > > into the kernel.  As far as I know, there is no security whatsoever
> > > gained by keeping the private key private, so why not make
> > > reproducible builds easier by simply fixing the key?
> >
> > Having thought about this some more, I think that you should
> > completely remove support for specifying a key. Provide a fixed key
> > pair, hard code the cache, and call it a day. If you make the key
> > configurable, every vendor that has any vendor keys (Debian, Ubuntu,
> > Fedora, Red Hat, SuSE, Clear Linux, etc) will see that config option
> > and set up their own key pair for no gain whatsoever.  Instead, it'll
> > give some illusion of security and it'll slow down operations in a VM
> > guest due to swapping out the values of the MSRs.  And, if the code to
> > support a locked MSR that just happens to have the right value stays
> > in the kernel, then we'll risk having vendors actually ship one
> > distro's public key hash, and that will seriously suck.
> >
> If you hard code the key pair however, doesn't that imply that anyone can sign a
> user space binary as a launch enclave, and potentially gain control of the token
> granting process?

Yes and no.

First of all, the kernel driver shouldn't be allowing user code to
launch a launch enclave regardless of signature.  I haven't gotten far
enough in reviewing the code to see whether that's the case, but if
it's not, it should be fixed before it's merged.

But keep in mind that control of the token granting process is not the
same thing as control over the right to launch an enclave.  On systems
without the LE hash MSRs, Intel controls the token granting process
and, barring some attack, an enclave that isn't blessed by Intel can't
be launched.  Support for that model will not be merged into upstream
Linux.  But on systems that have the LE hash MSRs and leave them
unlocked, there is effectively no hardware-enforced launch control.
Instead we have good old kernel policy.  If a user wants to launch an
enclave, they need to get the kernel to launch the enclave, and the
kernel needs to apply its policy.  The patch here (the in-kernel
launch enclave) has a wide-open policy.

So, as a practical matter, if every distro has their own LE key and
keeps it totally safe, then a system that locks the MSRs to one
distro's key makes it quite annoying to run another distro's intel_sgx
driver, but there is no effect on the actual security of the system.

>  It was my understanding that the value of the key pair was
> that the end user was guaranteed autonomy and security over which processes
> could start enclaves.  By publishing a fixed key pair, it seems to remove that
> ability.

If someone comes up with an actual machine that grants the actual end
user (where the end user is the person who bought the thing, not the
OEM) control over the MSRs, *and* the actual end user wants to limit
what enclaves can be launched even if the kernel is compromised, *and*
there is some actual argument for why this is useful (as opposed to
some compliance checkbox), then Linux could reasonably consider adding
support for this use case.  But that would be a separate patch.

>
> What would be nicer (I think) would be the abilty to specify both the public and
> the private key at run time.  the use case here is not one in which a vendor or
> os distribution ships a key pair, but one in which a downstream user doesn't
> want a vendor/os distribution to have any cryptographic information installed on
> their system

For what gain?
