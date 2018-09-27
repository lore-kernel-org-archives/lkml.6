Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B976C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29439216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 13:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29439216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeI0UGL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:06:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:14554 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbeI0UGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:06:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 06:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,310,1534834800"; 
   d="scan'208";a="94305070"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2018 06:45:35 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 27 Sep 2018 06:45:34 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 27 Sep 2018 06:45:34 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.140]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.37]) with mapi id 14.03.0319.002;
 Thu, 27 Sep 2018 21:45:32 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>
Subject: RE: [PATCH v3 4/5] KVM/x86/vPMU: Add APIs to support host
 save/restore the guest lbr stack
Thread-Topic: [PATCH v3 4/5] KVM/x86/vPMU: Add APIs to support host
 save/restore the guest lbr stack
Thread-Index: AQHUUM3pU3aoeAw5SE6eJtMPeYOl0qT4lD2AgAuXxtA=
Date:   Thu, 27 Sep 2018 13:45:31 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397FD362@shsmsx102.ccr.corp.intel.com>
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com>
 <1537437959-8751-5-git-send-email-wei.w.wang@intel.com>
 <20180920123223.GS24124@hirez.programming.kicks-ass.net>
In-Reply-To: <20180920123223.GS24124@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzQwMmY5NjItMjZjYi00OTYxLWJkMzQtZWI2MDkzMzViMWRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibEhxU3NpcENyalg2RGZiY1BocENDcFZ0dDYxcGUwclRyd3EzSll4U0c3cTQ0dDdwNnlHcUFVanNpRktQNTB2TCJ9
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

On Thursday, September 20, 2018 8:32 PM, Peter Zijlstra wrote:
> On Thu, Sep 20, 2018 at 06:05:58PM +0800, Wei Wang wrote:
> How do you deal with that situation, where the LBR is in use by a host event?

I guess you were referring to this use case: "perf record -b qemu-system-x86_64..", where the qemu process also needs lbr.

I also discussed with Andi about this in v1, where we switch the lbr state on VMX transitions. That could achieve the above, but adds too much overhead to VMX transitions, which are frequent. Considering the above usage is not common (it's more common to just have the task in the guest use the lbr feature), we decided to not take that usage into account, and switch lbr state only on the vCPU switching.

Best,
Wei
