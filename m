Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74CAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D53820870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D53820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeIJVIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:08:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:57706 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbeIJVIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:08:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 09:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="255987272"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.20])
  by orsmga005.jf.intel.com with ESMTP; 10 Sep 2018 09:13:23 -0700
Message-ID: <1536596003.11460.82.camel@intel.com>
Subject: Re: [PATCH v6 5/5] x86/kvm: Avoid dynamic allocation of pvclock
 data when SEV is active
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Date:   Mon, 10 Sep 2018 09:13:23 -0700
In-Reply-To: <20180910155329.GB20286@zn.tnic>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
         <1536343050-18532-6-git-send-email-brijesh.singh@amd.com>
         <20180910122727.GE21815@zn.tnic>
         <026d5ca5-7b77-de6c-477e-ff39f0291ac0@amd.com>
         <20180910155329.GB20286@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-10 at 17:53 +0200, Borislav Petkov wrote:
> On Mon, Sep 10, 2018 at 08:15:38AM -0500, Brijesh Singh wrote:
> > 
> > > 
> > > Now, the real question from all this SNAFU is, why can't all those point
> > > to a single struct pvclock_vsyscall_time_info and all CPUs read a single
> > > thing? Why do they have to be per-CPU and thus waste so much memory?
> You forgot to answer to the real question - why do we need those things
> to be perCPU and why can't we use a single instance to share with *all*
> CPUs?

I can't speak to the actual TSC stuff, but...

The pvclock ABI includes a per-vCPU bit, PVCLOCK_GUEST_STOPPED, to indicate
that the VM has been paused by the host.  The guest uses this information to
update its watchdogs to avoid false positives.  I have no idea if there are
use cases for setting STOPPED on a subset of vCPUs, but the ABI allows it so
here we are...
