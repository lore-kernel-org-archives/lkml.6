Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9806C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7E720869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7E720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbeIGUBr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:01:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:40776 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbeIGUBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:01:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 08:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,342,1531810800"; 
   d="scan'208";a="78751049"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Sep 2018 08:20:24 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 08:20:24 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 08:20:23 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.226]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.240]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 23:20:22 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>
Subject: RE: [PATCH v2 6/8] perf/x86/intel/lbr: guest requesting KVM for lbr
 stack save/restore
Thread-Topic: [PATCH v2 6/8] perf/x86/intel/lbr: guest requesting KVM for
 lbr stack save/restore
Thread-Index: AQHURdld+pMdNtUyy0Sd+7QREiMBLqTjo3+AgACm8gCAAAzqgIAAkzuQ
Date:   Fri, 7 Sep 2018 15:20:21 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73978F75E@shsmsx102.ccr.corp.intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
 <1536233456-12173-7-git-send-email-wei.w.wang@intel.com>
 <20180907032707.GN27886@tassilo.jf.intel.com> <5B920B96.6080803@intel.com>
 <20180907141051.GP27886@tassilo.jf.intel.com>
In-Reply-To: <20180907141051.GP27886@tassilo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmRmYWU5YmEtNDQwYi00MGU2LTkyZWEtOTY4NDJmMzVlNjhmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMEp6U2FEbW5sWHdreHdIazNxYzhFTFhoVkE2RDhoeXF4SzJtVFAzZEhMNVh3MTkzVHRCQnB3XC9CMVpYSytleU0ifQ==
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

On Friday, September 7, 2018 10:11 PM, Andi Kleen wrote:
> > This could achieve the above #1, but how would it solve #2 above? That
> > is, after the guest uses the lbr feature for a while, the lbr stack
> > has been passed through, then the guest doesn't use lbr any more, but
> > the vCPU will still save/restore on switching?
> 
> If nothing accesses the MSR LBRs after a context switch in the guest nothing
> gets saved/restored due to:
> 
> > > Also when the LBRs haven't been set to direct access the state
> > > doesn't need to be saved.

How would you realize the function of saving/restoring the lbr stack on the host?

Here, we create a perf event on the host (please see guest_lbr_event_create on patch 7), which essentially satisfies all the conditions (e.g. increases cpuc->lbr_users) that are required to have the lbr stack saved/restored on the vCPU switching.

If we want to stop the host side lbr stack save/restore for the vCPU, we need accordingly to call guest_lbr_event_release (in patch 7) to destroy that perf event (the host doesn't automatically stop saving the lbr stack for the vCPU if that perf event is still there).

When would you call that release function? (we all know that the lbr doesn't need to be saved when the guest is not using it, but we need to destroy that perf event to achieve "doesn't need to be saved")

Best,
Wei


