Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D19C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241D0208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241D0208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754679AbeFTIqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:46:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:34715 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932224AbeFTIqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:46:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 00:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,246,1526367600"; 
   d="scan'208";a="48473526"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.52])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jun 2018 00:23:50 -0700
Date:   Wed, 20 Jun 2018 10:23:49 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        nhorman@redhat.com, npmccallum@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, andy@infradead.org
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
Message-ID: <20180620072349.GA4329@linux.intel.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
 <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 10:17:13PM -0700, Andy Lutomirski wrote:
> > On Jun 9, 2018, at 10:39 PM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Fri, Jun 8, 2018 at 10:32 AM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> >>
> >> The Launch Enclave (LE) generates cryptographic launch tokens for user
> >> enclaves. A launch token is used by EINIT to check whether the enclave
> >> is authorized to launch or not. By having its own launch enclave, Linux
> >> has full control of the enclave launch process.
> >>
> >> LE is wrapped into a user space proxy program that reads enclave
> >> signatures outputs launch tokens. The kernel-side glue code is
> >> implemented by using the user space helper framework.  The IPC between
> >> the LE proxy program and kernel is handled with an anonymous inode.
> >>
> >> The commit also adds enclave signing tool that is used by kbuild to
> >> measure and sign the launch enclave. CONFIG_INTEL_SGX_SIGNING_KEY points
> >> to a PEM-file for the 3072-bit RSA key that is used as the LE public key
> >> pair. The default location is:
> >>
> >>  drivers/platform/x86/intel_sgx/sgx_signing_key.pem
> >>
> >> If the default key does not exist kbuild will generate a random key and
> >> place it to this location. KBUILD_SGX_SIGN_PIN can be used to specify
> >> the passphrase for the LE public key.
> >
> > It seems to me that it might be more useful to just commit a key pair
> > into the kernel.  As far as I know, there is no security whatsoever
> > gained by keeping the private key private, so why not make
> > reproducible builds easier by simply fixing the key?
> 
> Having thought about this some more, I think that you should
> completely remove support for specifying a key. Provide a fixed key
> pair, hard code the cache, and call it a day. If you make the key
> configurable, every vendor that has any vendor keys (Debian, Ubuntu,
> Fedora, Red Hat, SuSE, Clear Linux, etc) will see that config option
> and set up their own key pair for no gain whatsoever.  Instead, it'll
> give some illusion of security and it'll slow down operations in a VM
> guest due to swapping out the values of the MSRs.  And, if the code to
> support a locked MSR that just happens to have the right value stays
> in the kernel, then we'll risk having vendors actually ship one
> distro's public key hash, and that will seriously suck.
> 
> I'm going to try to get this code working tomorrow.  I'll keep you
> posted on how that goes.  Can you point me to the userspace bits (i.e.
> something buildable that will run on a kernel with your patches
> applied)?

Sorry for some delay. I was on leave last week.

The SDK supports my driver starting from 2.1 release:

  https://github.com/intel/linux-sgx

SampleCode folder contains some trivial test code to run.

/Jarkko
