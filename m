Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B71C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C687A20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfA3SBg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:01:36 -0500
Received: from mga14.intel.com ([192.55.52.115]:10892 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfA3SBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:01:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 10:01:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,541,1539673200"; 
   d="scan'208";a="112386287"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2019 10:01:35 -0800
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 30 Jan 2019 10:01:34 -0800
Received: from crsmsx152.amr.corp.intel.com (172.18.7.35) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 30 Jan 2019 10:01:34 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.57]) by
 CRSMSX152.amr.corp.intel.com ([169.254.5.81]) with mapi id 14.03.0415.000;
 Wed, 30 Jan 2019 12:01:33 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     'Jason Gunthorpe' <jgg@ziepe.ca>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jack@suse.de" <jack@suse.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: RE: [PATCH 3/6] drivers/IB,qib: do not use mmap_sem
Thread-Topic: [PATCH 3/6] drivers/IB,qib: do not use mmap_sem
Thread-Index: AQHUt2Gl37+5b+zRw0atYrNw3MHiB6XGEOqAgABlsYCAANFCgP//rILg
Date:   Wed, 30 Jan 2019 18:01:33 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E79BA6A27@CRSMSX101.amr.corp.intel.com>
References: <20190121174220.10583-1-dave@stgolabs.net>
 <20190121174220.10583-4-dave@stgolabs.net> <20190128233140.GA12530@ziepe.ca>
 <20190129044607.GL25106@ziepe.ca>
 <20190129185005.GC10129@iweiny-DESK2.sc.intel.com>
 <20190129231903.GA5352@ziepe.ca>
In-Reply-To: <20190129231903.GA5352@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWIyZWE0MzUtMzA2OS00NmE5LTkyMDgtODAwZDFjNTRiZGMxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicmRSckVBakdiVzVYZ2k5Y3JFVCtETWc1Z2M4QWp1TFhLaVwvTmNnaXhjNXVYSW1hcGcrS0hDK2JGRFdYb2JpZVcifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, Jan 29, 2019 at 10:50:05AM -0800, Ira Weiny wrote:
> > > .. and I'm looking at some of the other conversions here.. *most
> > > likely* any caller that is manipulating rlimit for get_user_pages
> > > should really be calling get_user_pages_longterm, so they should not
> > > be converted to use _fast?
> >
> > Is this a question?  I'm not sure I understand the meaning here?
> 
> More an invitation to disprove the statement

Generally I agree.  But would be best if we could get fast GUP for performance.  I have not worked out if that will be possible with the final "longterm" solutions.

IRa

> 
> Jason
