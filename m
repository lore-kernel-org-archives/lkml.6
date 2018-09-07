Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6D4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4AC20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4AC20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeIHArm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:47:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:46081 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbeIHArm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:47:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 13:05:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="86943329"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga004.fm.intel.com with ESMTP; 07 Sep 2018 13:05:11 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E3336300B65; Fri,  7 Sep 2018 13:05:10 -0700 (PDT)
Date:   Fri, 7 Sep 2018 13:05:10 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: Re: [PATCH v2 6/8] perf/x86/intel/lbr: guest requesting KVM for lbr
 stack save/restore
Message-ID: <20180907200510.GR27886@tassilo.jf.intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
 <1536233456-12173-7-git-send-email-wei.w.wang@intel.com>
 <20180907032707.GN27886@tassilo.jf.intel.com>
 <5B920B96.6080803@intel.com>
 <20180907141051.GP27886@tassilo.jf.intel.com>
 <286AC319A985734F985F78AFA26841F73978F75E@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F73978F75E@shsmsx102.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How would you realize the function of saving/restoring the lbr stack on the host?
> 
> Here, we create a perf event on the host (please see guest_lbr_event_create on patch 7), which essentially satisfies all the conditions (e.g. increases cpuc->lbr_users) that are required to have the lbr stack saved/restored on the vCPU switching.
> 
> If we want to stop the host side lbr stack save/restore for the vCPU, we need accordingly to call guest_lbr_event_release (in patch 7) to destroy that perf event (the host doesn't automatically stop saving the lbr stack for the vCPU if that perf event is still there).
> 
> When would you call that release function? (we all know that the lbr doesn't need to be saved when the guest is not using it, but we need to destroy that perf event to achieve "doesn't need to be saved")

Maybe set a timer on DEBUGCTL LBR=0 ? A timer would provide hysteresis, so that quick toggles
(like in a PMI handler) wouldn't do anything expensive.

It needs new interfaces for perf anyways because we need to access the LBR state from
the last save.

-Andi
