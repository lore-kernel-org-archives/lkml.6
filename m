Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E232C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADD4214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfAJXkL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:40:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:11649 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729424AbfAJXkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:40:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 15:40:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,463,1539673200"; 
   d="scan'208";a="309411675"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2019 15:40:07 -0800
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 10 Jan 2019 15:40:02 -0800
Received: from fmsmsx121.amr.corp.intel.com ([169.254.6.18]) by
 fmsmsx124.amr.corp.intel.com ([169.254.8.80]) with mapi id 14.03.0415.000;
 Thu, 10 Jan 2019 15:40:02 -0800
From:   "Chen, Tim C" <tim.c.chen@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
CC:     "Huang, Ying" <ying.huang@intel.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "daniel.m.jordan@oracle.com" <daniel.m.jordan@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v5 PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
Thread-Topic: [v5 PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
Thread-Index: AQHUo5qpOoFpUagMFk+moCKgkvnZWaWpuDWA//96P7A=
Date:   Thu, 10 Jan 2019 23:40:01 +0000
Message-ID: <045D8A5597B93E4EBEDDCBF1FC15F5097E16F8E2@fmsmsx121.amr.corp.intel.com>
References: <1546543673-108536-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190110153147.1baf4c88bf0dd3b8a78aad08@linux-foundation.org>
In-Reply-To: <20190110153147.1baf4c88bf0dd3b8a78aad08@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODIzZjViMTAtMjQzZi00MGZhLWFhOTgtZWViNjllOWUxZjAwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMTVpdFVMTFR1QlNObVcrNUlHRUZPZTNOaWpNakhmc0xiXC83dE1yRWlES21cLzBHYlwvMHhrd09JUG9NSGl3Y0FKUyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > +	if (si->flags & (SWP_BLKDEV | SWP_FS)) {
> 
> I re-read your discussion with Tim and I must say the reasoning behind this
> test remain foggy.

I was worried that the dereference

inode = si->swap_file->f_mapping->host;

is not always safe for corner cases.

So the test makes sure that the dereference is valid.

> 
> What goes wrong if we just remove it?

If the dereference to get inode is always safe, we can remove it.


Thanks.

Tim
