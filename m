Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D405AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 01:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869B22075E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 01:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869B22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeIHG3r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:29:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:41323 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeIHG3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:29:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 18:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,344,1531810800"; 
   d="scan'208";a="84088773"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga002.fm.intel.com with ESMTP; 07 Sep 2018 18:46:05 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 18:46:05 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 18:46:05 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.226]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.205]) with mapi id 14.03.0319.002;
 Sat, 8 Sep 2018 09:46:03 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        "riel@redhat.com" <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v36 0/5] Virtio-balloon: support free page reporting
Thread-Topic: [PATCH v36 0/5] Virtio-balloon: support free page reporting
Thread-Index: AQHUIAglrybJe3xqWk2ztdP0qZFBfKScVseAgAAIBYCARxh+gIABD4EAgAFjRrA=
Date:   Sat, 8 Sep 2018 01:46:02 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7397924FE@shsmsx102.ccr.corp.intel.com>
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com>
 <20180723122342-mutt-send-email-mst@kernel.org>
 <20180723143604.GB2457@work-vm> <5B911B03.2060602@intel.com>
 <20180907122955.GD2544@work-vm>
In-Reply-To: <20180907122955.GD2544@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTdlZmRkZjMtYWU3MS00Yzc0LTk5NWYtM2JiMTgxMWMyMzQ3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ2RHNFVrbktjWXVvRVpMRWo4K1BDWTcrenpXUmNTb2p2dmtNeTF1K1VkSExyVVRSdHM3UXNJSVh1SmZpbWJrciJ9
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

On Friday, September 7, 2018 8:30 PM, Dr. David Alan Gilbert wrote:
> OK, that's much better.
> The ~50% reducton with a 8G VM and a real workload is great, and it does
> what you expect when you put a lot more RAM in and see the 84% reduction
> on a guest with 128G RAM - 54s vs ~9s is a big win!
> 
> (The migrate_set_speed is a bit high, since that's in bytes/s - but it's not
> important).
> 
> That looks good,
> 

Thanks Dave for the feedback.
Hope you can join our discussion and review the v37 patches as well.

Best,
Wei
