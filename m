Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75522C04ABA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C252146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C252146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbeIRQGw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:06:52 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:40617 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbeIRQGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:06:52 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id A960F1E26C1FC;
        Tue, 18 Sep 2018 18:34:50 +0800 (CST)
Received: from DGGEML422-HUB.china.huawei.com (10.1.199.39) by
 DGGEML401-HUB.china.huawei.com (10.3.17.32) with Microsoft SMTP Server (TLS)
 id 14.3.399.0; Tue, 18 Sep 2018 18:34:51 +0800
Received: from DGGEML511-MBX.china.huawei.com ([169.254.1.77]) by
 dggeml422-hub.china.huawei.com ([10.1.199.39]) with mapi id 14.03.0399.000;
 Tue, 18 Sep 2018 18:34:46 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     Wei Wang <wei.w.wang@intel.com>, Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "kan.liang@intel.com" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "like.xu@intel.com" <like.xu@intel.com>
Subject: RE: [PATCH v2 7/8] KVM: PMU: support to save/restore the guest lbr
 stack on vCPU switching
Thread-Topic: [PATCH v2 7/8] KVM: PMU: support to save/restore the guest lbr
 stack on vCPU switching
Thread-Index: AQHURdllAmT0QJhl2U6encrmkRxO26T1SRnA//+bbQCAAHXJAIAAj15w
Date:   Tue, 18 Sep 2018 10:34:46 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB0F342C@dggeml511-mbx.china.huawei.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
 <1536233456-12173-8-git-send-email-wei.w.wang@intel.com>
 <33183CC9F5247A488A2544077AF19020DB0F1D5F@dggeml511-mbx.china.huawei.com>
 <20180918025616.GA10360@tassilo.jf.intel.com> <5BA0CC1E.6030202@intel.com>
In-Reply-To: <5BA0CC1E.6030202@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.18.62]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Wei Wang [mailto:wei.w.wang@intel.com]
> Sent: Tuesday, September 18, 2018 5:58 PM
> To: Andi Kleen <ak@linux.intel.com>; Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: linux-kernel@vger.kernel.org; kvm@vger.kernel.org; pbonzini@redhat.com;
> kan.liang@intel.com; peterz@infradead.org; mingo@redhat.com;
> rkrcmar@redhat.com; like.xu@intel.com
> Subject: Re: [PATCH v2 7/8] KVM: PMU: support to save/restore the guest lbr
> stack on vCPU switching
> 
> On 09/18/2018 10:56 AM, Andi Kleen wrote:
> >>> From: Like Xu <like.xu@intel.com>
> >>>
> >>> This patch adds support to KVM to save/restore the lbr stack on vCPU
> >>> context switching.
> >>>
> >>> When the guest sets the ACTIVE bit of MSR_KVM_PV_LBR_CTRL, a perf
> event
> >>> is created on the host for the related vCPU. This perf event ensures the
> >>> LBR stack to be saved/restored when the vCPU thread is scheduled out/in.
> >>> The perf event is removed and freed when the guest clears the ACTIVE
> >>> bit.
> >>>
> >> What about live migration? Does LBR stack need to be saved on the source
> side and
> >> restored on the dest side with the passthrough mode?
> > Yes it should. Either for call stack LBR, or when it is frozen/disabled.
> >
> > When it's not frozen/disabled and not in call stack LBR mode it likely doesn't
> > hurt either, but it's not strictly needed because it will
> > be replaced so quickly.
> 
> Yes, should be supported. We are working on v3 with the suggested lazy
> save approach, and will send it out shortly.
> 
Nice~ 

Thanks,
-Gonglei
