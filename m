Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132DDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB8D2156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB8D2156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeI0U3u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:29:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:17787 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbeI0U3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:29:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 07:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,310,1534834800"; 
   d="scan'208";a="266315642"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2018 07:11:11 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 27 Sep 2018 07:11:11 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 27 Sep 2018 07:11:10 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.140]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.27]) with mapi id 14.03.0319.002;
 Thu, 27 Sep 2018 22:11:08 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
CC:     "Liang, Kan" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>,
        "jannh@google.com" <jannh@google.com>
Subject: RE: [PATCH v3 5/5] KVM/x86/lbr: lazy save the guest lbr stack
Thread-Topic: [PATCH v3 5/5] KVM/x86/lbr: lazy save the guest lbr stack
Thread-Index: AQHUUM3r0paOOfw3cUyiMvfFvyNRYKT4jVyAgAuiBxA=
Date:   Thu, 27 Sep 2018 14:11:08 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397FD491@shsmsx102.ccr.corp.intel.com>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-6-git-send-email-wei.w.wang@intel.com>
 <33183CC9F5247A488A2544077AF19020DB0F7483@dggeml511-mbx.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DB0F7483@dggeml511-mbx.china.huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODIwNDUwN2EtYzFjMi00ZjA0LWE0MzYtNTYwYjJjNDU2ZjZmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ2VCOWo4eVk0Wlk2SXNaN1lJQzNYRmd2YjJQY29walQySVZINGZHZzhSVGhENEJRV2xpMUtUSytGb25HeGd6dyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 20, 2018 8:08 PM, Gonglei (Arei) wrote:
> > +static bool guest_access_lbr_msr(struct kvm_vcpu *vcpu,
> > +				 struct msr_data *msr_info,
> > +				 bool set)
> > +{
> > +	bool ret = false;
> > +
> > +	if (!vcpu->kvm->arch.guest_lbr_enabled)
> > +		return false;
> > +
> > +	if (set)
> > +		ret = guest_set_lbr_msr(vcpu, msr_info);
> > +	else
> > +		ret = guest_get_lbr_msr(vcpu, msr_info);
> > +
> > +	if (ret) {
> > +		vcpu->arch.lbr_used = true;
> > +		vmx_set_intercept_for_lbr_msrs(vcpu, false);
> 
> You can use if (!vcpu->arch.lbr_used) as the condition of assign values.
> They are need only once.

Thanks, I think it would be better to use

If (ret && !vcpu->arch.lbr_used)
(we need to make sure that the guest is accessing one of the LBR related MSRs via ret=true)

Best,
Wei
