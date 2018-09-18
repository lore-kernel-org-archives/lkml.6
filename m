Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B1BECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E5720C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 02:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E5720C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeIRI0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:26:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:17874 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbeIRI0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:26:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 19:56:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,388,1531810800"; 
   d="scan'208";a="71644801"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga008.fm.intel.com with ESMTP; 17 Sep 2018 19:56:16 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id EF1F0300F9A; Mon, 17 Sep 2018 19:56:16 -0700 (PDT)
Date:   Mon, 17 Sep 2018 19:56:16 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     Wei Wang <wei.w.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kan.liang@intel.com" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "like.xu@intel.com" <like.xu@intel.com>
Subject: Re: [PATCH v2 7/8] KVM: PMU: support to save/restore the guest lbr
 stack on vCPU switching
Message-ID: <20180918025616.GA10360@tassilo.jf.intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
 <1536233456-12173-8-git-send-email-wei.w.wang@intel.com>
 <33183CC9F5247A488A2544077AF19020DB0F1D5F@dggeml511-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB0F1D5F@dggeml511-mbx.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Like Xu <like.xu@intel.com>
> > 
> > This patch adds support to KVM to save/restore the lbr stack on vCPU
> > context switching.
> > 
> > When the guest sets the ACTIVE bit of MSR_KVM_PV_LBR_CTRL, a perf event
> > is created on the host for the related vCPU. This perf event ensures the
> > LBR stack to be saved/restored when the vCPU thread is scheduled out/in.
> > The perf event is removed and freed when the guest clears the ACTIVE
> > bit.
> > 
> 
> What about live migration? Does LBR stack need to be saved on the source side and
> restored on the dest side with the passthrough mode?

Yes it should. Either for call stack LBR, or when it is frozen/disabled.

When it's not frozen/disabled and not in call stack LBR mode it likely doesn't
hurt either, but it's not strictly needed because it will
be replaced so quickly.

-Andi
