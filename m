Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD67C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFE920857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFE920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeIGIFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:05:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:6360 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbeIGIFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:05:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 20:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,340,1531810800"; 
   d="scan'208";a="88381685"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga001.jf.intel.com with ESMTP; 06 Sep 2018 20:27:07 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 276F0300B65; Thu,  6 Sep 2018 20:27:07 -0700 (PDT)
Date:   Thu, 6 Sep 2018 20:27:07 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, kan.liang@intel.com, peterz@infradead.org,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com
Subject: Re: [PATCH v2 6/8] perf/x86/intel/lbr: guest requesting KVM for lbr
 stack save/restore
Message-ID: <20180907032707.GN27886@tassilo.jf.intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
 <1536233456-12173-7-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536233456-12173-7-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 07:30:54PM +0800, Wei Wang wrote:
> This patch adds an interface to enable a guest to request KVM to save
> and restore the lbr stack on vCPU context switching.
> 
> KVM couldn't capture the info about whether the guest is actively using
> the lbr feature via the lbr enable bit in the debugctl MSR, because that
> control bit is frequently enabled and disabled by the guest, and in some
> csaes, it is disabled even when the guest is actively using the lbr
> feature. For example, perf_pmu_sched_task in the guest disables the bit
> before reading out the lbr stack. In this case, the bit is disabled though
> the guest is still using the lbr feature.
> 
> So, a KVM-specific MSR, MSR_KVM_PV_LBR_CTRL, is used by the guest at a
> proper place to tell KVM if the LBR is actively in use or not. Basically,
> the lbr user callstack mode needs the lbr stack to be saved/restored on a
> context switching, so we set the ACTIVE bit of MSR_KVM_PV_LBR_CTRL only
> when the user callstack mode is used. The KVM hypervisor will add the lbr
> stack save/restore support on vCPU switching after the ACTIVE bit is set.

PV is difficult because it requires changing all the users.

Maybe a better approach would be a lazy restore of the LBRs:

Don't restore the LBRs on context switch, but set the LBR MSRs to intercept.
Then on the first access restore the LBRs and allow direct access to the
MSRs again.

Also when the LBRs haven't been set to direct access the state doesn't
need to be saved.

-Andi

