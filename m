Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A5BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E464218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfABQdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:33:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:21804 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbfABQdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:33:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 08:33:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,431,1539673200"; 
   d="scan'208";a="288320204"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 02 Jan 2019 08:33:12 -0800
Received: from [10.251.9.84] (kliang2-mobl1.ccr.corp.intel.com [10.251.9.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 724ED58056E;
        Wed,  2 Jan 2019 08:33:11 -0800 (PST)
Subject: Re: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
To:     Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com, ak@linux.intel.com,
        peterz@infradead.org
Cc:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, jannh@google.com, arei.gonglei@huawei.com
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-5-git-send-email-wei.w.wang@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5a04d8ea-b788-6018-8b34-ebd528578916@linux.intel.com>
Date:   Wed, 2 Jan 2019 11:33:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1545816338-1171-5-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/26/2018 4:25 AM, Wei Wang wrote:
> +
> +	/*
> +	 * It could be possible that people have vcpus of old model run on
> +	 * physcal cpus of newer model, for example a BDW guest on a SKX
> +	 * machine (but not possible to be the other way around).
> +	 * The BDW guest may not get accurate results on a SKX machine as it
> +	 * only reads 16 entries of the lbr stack while there are 32 entries
> +	 * of recordings. So we currently forbid the lbr enabling when the
> +	 * vcpu and physical cpu see different lbr stack entries.

I think it's not enough to only check number of entries. The LBR from/to 
MSRs may be different even the number of entries is the same, e.g SLM 
and KNL.

> +	 */
> +	switch (vcpu_model) {

That's a duplicate of intel_pmu_init(). I think it's better to factor 
out the common part if you want to check LBR MSRs and entries. Then we 
don't need to add the same codes in two different places when enabling 
new platforms.

Actually, I think we may just support LBR for guest if it has the 
identical CPU model as host. It should be good enough for now.

Thanks,
Kan
> +	case INTEL_FAM6_CORE2_MEROM:
> +	case INTEL_FAM6_CORE2_MEROM_L:
