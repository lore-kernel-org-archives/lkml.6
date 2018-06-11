Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MBBbOl+RHluSDgAAmS7hNA
	; Mon, 11 Jun 2018 15:12:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C5D40607A4; Mon, 11 Jun 2018 15:12:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 454EC60541;
	Mon, 11 Jun 2018 15:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 454EC60541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932699AbeFKPMu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:12:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:2109 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932298AbeFKPMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:12:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 08:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,502,1520924400";
   d="scan'208";a="207115734"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.135])
  by orsmga004.jf.intel.com with ESMTP; 11 Jun 2018 08:12:48 -0700
Message-ID: <1528729968.9779.33.camel@intel.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 09/13] x86, sgx: basic
 routines for enclave page cache
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Andy Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        nhorman@redhat.com, npmccallum@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 11 Jun 2018 08:12:48 -0700
In-Reply-To: <CALCETrVUGubKSS00aH5JJoc0vNkqLGPqCoaG2br2yn5cxWXz-Q@mail.gmail.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
         <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
         <CALCETrVUGubKSS00aH5JJoc0vNkqLGPqCoaG2br2yn5cxWXz-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-09 at 22:32 -0700, Andy Lutomirski wrote:
> On Fri, Jun 8, 2018 at 10:22 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > 
> > SGX has a set of data structures to maintain information about the enclaves
> > and their security properties. BIOS reserves a fixed size region of
> > physical memory for these structures by setting Processor Reserved Memory
> > Range Registers (PRMRR). This memory area is called Enclave Page Cache
> > (EPC).
> > 
> > 
> > +/**
> > + * sgx_einit - EINIT an enclave with the appropriate LE pubkey hash
> > + * @sigstruct:         a pointer to the enclave's sigstruct
> > + * @token:             a pointer to the enclave's EINIT token
> > + * @secs_page:         a pointer to the enclave's SECS EPC page
> > + * @le_pubkey_hash:    the desired LE pubkey hash for EINIT
> > + */
> > +int sgx_einit(struct sgx_sigstruct *sigstruct, struct sgx_einittoken *token,
> > +             struct sgx_epc_page *secs_page, u64 le_pubkey_hash[4])
> > +{
> > +       u64 __percpu *cache;
> > +       void *secs;
> > +       int i, ret;
> > +
> > +       secs = sgx_get_page(secs_page);
> > +
> > +       if (!sgx_lc_enabled) {
> I'm confused.  What does this code path do?  It kind of looks like the
> driver will load and just malfunction if we don't have write access to
> the MSRs.  What is the intended behavior?

The driver will also allow itself to load if the MSRs are read-only,
but only if the MSRs' pubkey hash matches that of its launch enclave,
i.e. the system has been pre-configured for the kernel's LE.  Whether
or not that is a valid scenario is probably a different discussion.

> > +               ret = __einit(sigstruct, token, secs);
> > +               goto out;
> > +       }
> > +
> > +       cache = per_cpu(sgx_le_pubkey_hash_cache, smp_processor_id());
> > +
> > +       preempt_disable();
> > +       for (i = 0; i < 4; i++) {
> > +               if (le_pubkey_hash[i] == cache[i])
> > +                       continue;
> > +
> > +               wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + i, le_pubkey_hash[i]);
> > +               cache[i] = le_pubkey_hash[i];
> > +       }
> > +       ret = __einit(sigstruct, token, secs);
> > +       preempt_enable();
> > +
> > +out:
> > +       sgx_put_page(secs);
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL(sgx_einit);
> > +
