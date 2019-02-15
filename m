Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CA1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB26E2190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391532AbfBOIt4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:49:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:13290 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfBOItz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:49:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 00:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="299965621"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2019 00:49:53 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 15 Feb 2019 00:49:53 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 15 Feb 2019 00:49:52 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.207]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.102]) with mapi id 14.03.0415.000;
 Fri, 15 Feb 2019 16:49:51 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     'Andi Kleen' <ak@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "Xu, Like" <like.xu@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
        "jmattson@google.com" <jmattson@google.com>
Subject: RE: [PATCH v5 07/12] perf/x86: no counter allocation support
Thread-Topic: [PATCH v5 07/12] perf/x86: no counter allocation support
Thread-Index: AQHUxEm4aMj8uXAS1U2LrKLEAi//waXe9VCAgAEv1yA=
Date:   Fri, 15 Feb 2019 08:49:49 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DF71EAF@shsmsx102.ccr.corp.intel.com>
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
 <1550135174-5423-8-git-send-email-wei.w.wang@intel.com>
 <20190214162613.GK16922@tassilo.jf.intel.com>
In-Reply-To: <20190214162613.GK16922@tassilo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2MxOTRhNzMtMjg0MC00YzRiLTkyYzktYmI2NGY4NDJhZGFiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiNDBtcmlDS1wvN3dDcTROMjNaWVo4REYxK2ZTR2o3cDZnV1Y0YzlxR1ZIY3FLXC9IVnRpaEttK0p1RjJidEwwR1Q0In0=
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

On Friday, February 15, 2019 12:26 AM, Andi Kleen wrote:
> > diff --git a/include/uapi/linux/perf_event.h
> > b/include/uapi/linux/perf_event.h index 9de8780..ec97a70 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -372,7 +372,8 @@ struct perf_event_attr {
> >  				context_switch :  1, /* context switch data */
> >  				write_backward :  1, /* Write ring buffer from
> end to beginning */
> >  				namespaces     :  1, /* include namespaces
> data */
> > -				__reserved_1   : 35;
> > +				no_counter     :  1, /* no counter allocation */
> 
> Not sure we really want to expose this in the user ABI. Perhaps make it a
> feature of the in kernel API only?

OK. I plan to move it to the perf_event struct.

Best,
Wei
