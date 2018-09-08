Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0D2C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 01:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D661920855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 01:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D661920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeIHGRy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:17:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:61549 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725731AbeIHGRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:17:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 18:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,344,1531810800"; 
   d="scan'208";a="81822586"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2018 18:34:03 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 18:34:02 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.226]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.150]) with mapi id 14.03.0319.002;
 Sat, 8 Sep 2018 09:34:01 +0800
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
Thread-Index: AQHURdld+pMdNtUyy0Sd+7QREiMBLqTjo3+AgACm8gCAAAzqgIAAkzuQ///PwwCAANSrMA==
Date:   Sat, 8 Sep 2018 01:34:00 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397924CB@shsmsx102.ccr.corp.intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
 <1536233456-12173-7-git-send-email-wei.w.wang@intel.com>
 <20180907032707.GN27886@tassilo.jf.intel.com> <5B920B96.6080803@intel.com>
 <20180907141051.GP27886@tassilo.jf.intel.com>
 <286AC319A985734F985F78AFA26841F73978F75E@shsmsx102.ccr.corp.intel.com>
 <20180907200510.GR27886@tassilo.jf.intel.com>
In-Reply-To: <20180907200510.GR27886@tassilo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmFkOTRkYTMtMWU5ZS00OWZkLTgzZTQtZThmYTViMGVlNzhmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiakFzaytjRzR5Q3FKY3FwMzhpMWVCWmdzOFhUMFl3UXVCd2EwbzFMZ0hTS1RVT054UEo1Um5IVXBFbUtjUTZFeiJ9
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

On Saturday, September 8, 2018 4:05 AM, Andi Kleen wrote:
> > How would you realize the function of saving/restoring the lbr stack on the
> host?
> >
> > Here, we create a perf event on the host (please see
> guest_lbr_event_create on patch 7), which essentially satisfies all the
> conditions (e.g. increases cpuc->lbr_users) that are required to have the lbr
> stack saved/restored on the vCPU switching.
> >
> > If we want to stop the host side lbr stack save/restore for the vCPU, we
> need accordingly to call guest_lbr_event_release (in patch 7) to destroy that
> perf event (the host doesn't automatically stop saving the lbr stack for the
> vCPU if that perf event is still there).
> >
> > When would you call that release function? (we all know that the lbr
> > doesn't need to be saved when the guest is not using it, but we need
> > to destroy that perf event to achieve "doesn't need to be saved")
> 
> Maybe set a timer on DEBUGCTL LBR=0 ? A timer would provide hysteresis,
> so that quick toggles (like in a PMI handler) wouldn't do anything expensive.

I'm not sure if this would solve the key problem. What would be the frequency to have the timer fired?

- Let's say every 10ms, for example. The guest is disturbed by a timer interrupt (cause VMExit) every 10ms, though the guest doesn't use the lbr any more after the first use. The problem is switched to when do we call the release function to cancel the timer if we want to avoid that unnecessary disturbance to the guest.

- When the timer fires, and it finds "DEBUGCTL LBR=0", it destroys the host side perf event, then the lbr stack isn't saved when the vCPU is scheduled out. As also mentioned in the commit log, perf_pmu_sched_task in the guest disables that bit before reading out the lbr stack (pmi is another example). Now, DEBUGCTL LBR=0", and before the guest read out the lbr stack, the vCPU may happen to be scheduled out, and another thread on the host is scheduled in and will get the lbr stack overwritten. So, before the guest reads out the lbr stack, the stack has already been polluted in this case.

Best,
Wei
