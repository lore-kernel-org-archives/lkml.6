Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64BDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C060E2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfACRSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:18:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:28137 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730864AbfACRSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:18:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 09:18:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,435,1539673200"; 
   d="scan'208";a="113926122"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jan 2019 09:18:37 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id ABC33301B2E; Thu,  3 Jan 2019 09:18:38 -0800 (PST)
Date:   Thu, 3 Jan 2019 09:18:38 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Wei Wang <wei.w.wang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        like.xu@intel.com, Jann Horn <jannh@google.com>,
        arei.gonglei@huawei.com
Subject: Re: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
Message-ID: <20190103171838.GB6118@tassilo.jf.intel.com>
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-5-git-send-email-wei.w.wang@intel.com>
 <CALMp9eRPvxPCnAnWr8+U98PzZLQ8LzeBRMyPk0qROKBzSzSnRQ@mail.gmail.com>
 <5C2DB81F.3000906@intel.com>
 <CALMp9eR0rkF-DuOWyB16q5r8y9DrefsMd1h4GfDkA8nmpWjMEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eR0rkF-DuOWyB16q5r8y9DrefsMd1h4GfDkA8nmpWjMEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, but then what happens?
> 
> Fast forward to, say, 2021. You're decommissioning all Broadwell
> servers in your data center. You have to migrate the running VMs off
> of those Broadwell systems onto newer hardware. But, with the current
> implementation, the migration cannot happen. So, what do you do? I
> suppose you just never enable the feature in the first place. Right?

There would in theory ways to handle this.

LBRs are normally not required for running correctly, they're not like
instructions, so it would be actually quite reasonable to just return 0 
and ignore writes for incompatible machines for them. Your profilers might
return some bogus data, but that is normally acceptable.

In some cases it might be also possible to emulate LBRs of
different types, but I don't think it would be worth the effort.
 
Yes, but the patches don't do this, so right now you should only enable it when
all systems in your migration pool have compatible LBRs.

-Andi
