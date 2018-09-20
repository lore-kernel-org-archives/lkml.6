Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169C2ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB8821525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB8821525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbeITXf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:35:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:44866 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeITXf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:35:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 10:50:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="74643014"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.148])
  by orsmga007.jf.intel.com with ESMTP; 20 Sep 2018 10:50:17 -0700
Date:   Thu, 20 Sep 2018 10:50:17 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Yi Wang <wang.yi59@zte.com.cn>, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, xu.xi8@zte.com.cn, peng.hao2@zte.com.cn,
        jiang.biao2@zte.com.cn
Subject: Re: [PATCH] KVM: x86: fix failure of injecting exceptions in
 x86_emulate_instruction
Message-ID: <20180920175017.GB10381@linux.intel.com>
References: <1536220964-8412-1-git-send-email-wang.yi59@zte.com.cn>
 <9835d255-dd9a-222b-f4a2-93611175b326@redhat.com>
 <a9a47c9b-c8b9-74f4-78ef-fb54c7fe806d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9a47c9b-c8b9-74f4-78ef-fb54c7fe806d@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Peng Hao and Jiang Biao

On Thu, Sep 20, 2018 at 06:53:55PM +0200, Paolo Bonzini wrote:
> On 20/09/2018 18:30, Paolo Bonzini wrote:
> > On 06/09/2018 10:02, Yi Wang wrote:
> >> In order to fix a page table walk issue, commit 6ea6e84309ca
> >> ("KVM: x86: inject exceptions produced by x86_decode_insn") check
> >> if variable ctxt->have_exception true and inject the exception.
> >> Unfortunately, ctxt->have_exception is set to true only in function
> >> x86_emulate_insn(), which won't be called before invoking
> >> inject_emulated_exception() in the 6ea6e84309ca.
> >> This patch fix this issue.
> >>
> >> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> >> Reviewed-by: Xi Xu <xu.xi8@zte.com.cn>
> > 
> > Queued, thanks.  Do you have a testcase for this?
> 
> Unqueued, sorry.  The hypercall test from kvm-unit-tests fails.  A
> VMCALL on the "edge" of canonical address space, i.e. at 0x7ffffffffffd,
> raises a general protection fault before this patch and a double fault
> afterwards.

Peng Hao submitted a very similar patch[1], the difference being that
it also modified x86_emulate_instruction() to ignore the result of
inject_emulated_exception().  I have no idea if that change is correct
but it may be related to the aforementioned unit test failing.

[1] https://lkml.org/lkml/2018/9/19/38
