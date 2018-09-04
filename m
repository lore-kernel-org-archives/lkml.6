Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6F0C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B78206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B78206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeIDWPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:15:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:61320 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeIDWPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:15:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 10:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="259781815"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.20])
  by fmsmga005.fm.intel.com with ESMTP; 04 Sep 2018 10:49:14 -0700
Date:   Tue, 4 Sep 2018 10:49:14 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, nhorman@redhat.com,
        npmccallum@redhat.com, linux-sgx@vger.kernel.org,
        serge.ayoun@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, suresh.b.siddha@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 07/13] x86/sgx: Add data structures for tracking the
 EPC pages
Message-ID: <20180904174914.GA5690@linux.intel.com>
References: <20180827185507.17087-1-jarkko.sakkinen@linux.intel.com>
 <20180827185507.17087-8-jarkko.sakkinen@linux.intel.com>
 <CAHp75VcjKkJR4_H-acbVm3BwA4tVR8gUtkg9STqOK2UG20Tvgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcjKkJR4_H-acbVm3BwA4tVR8gUtkg9STqOK2UG20Tvgg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 05:41:53PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 27, 2018 at 9:58 PM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> 
> > +       va = ioremap_cache(addr, size);
> > +       if (!va)
> > +               return -ENOMEM;
> 
> I'm not sure this is a right API. Do we operate with memory? Does it
> have I/O side effects?
> If no, memremap() would be better to use.

Preserving __iomem is desirable.  There aren't side effects per se,
but direct non-enclave accesses to the EPC get abort page semantics so
the kernel shouldn't be directly dereferencing a pointer to the EPC.
Though by that argument, sgx_epc_bank.va, sgx_epc_addr's return and
all ENCLS helpers should be tagged __iomem.

For documentation purposes, maybe it would be better to use __private
or "#define __sgx_epc __iomem" and use that?
