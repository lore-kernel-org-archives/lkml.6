Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850D4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C060218FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 04:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeL2EZQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 23:25:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:30037 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeL2EZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 23:25:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 20:25:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,412,1539673200"; 
   d="scan'208";a="112760798"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 28 Dec 2018 20:25:15 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 28 Dec 2018 20:25:14 -0800
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 28 Dec 2018 20:25:14 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.63]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.45]) with mapi id 14.03.0415.000;
 Sat, 29 Dec 2018 12:25:12 +0800
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
        "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>
Subject: RE: [PATCH v4 10/10] KVM/x86/lbr: lazy save the guest lbr stack II
Thread-Topic: [PATCH v4 10/10] KVM/x86/lbr: lazy save the guest lbr stack II
Thread-Index: AQHUniYnosbASFYAAUWmc2TR8BYeAaWTpJng
Date:   Sat, 29 Dec 2018 04:25:12 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DEEAFE6@shsmsx102.ccr.corp.intel.com>
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-11-git-send-email-wei.w.wang@intel.com>
 <20181227205258.GH25620@tassilo.jf.intel.com>
In-Reply-To: <20181227205258.GH25620@tassilo.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2FjYjc2ZjgtYjBlZC00N2JmLTg3OTgtNjNiMzFjYWU5ZGY1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN3hoSU8rXC8ydks3MGxWaDBGOHBMN3plOVRCc2pJcGNVNG1nK1FkVzZIXC9jZVRRUDhkZjE4NnlqYlBnU2V2d1lJIn0=
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

On Friday, December 28, 2018 4:53 AM, Andi Kleen wrote:
> Actually forgot one case.
> 
> In Arch Perfmon v4 the LBR freezing is also controlled through a
> GLOBAL_CTRL bit.
> I didn't see any code handling that bit?

That GLOBAL_STATUS.LBR_FRZ bit hasn't been supported yet. I'll add that, thanks.

Best,
Wei


