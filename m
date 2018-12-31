Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B675C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 06:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4045B20828
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 06:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbeLaGD5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 01:03:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:17087 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeLaGD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 01:03:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2018 22:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,421,1539673200"; 
   d="scan'208";a="114385000"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 30 Dec 2018 22:03:55 -0800
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 30 Dec 2018 22:03:55 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 30 Dec 2018 22:03:54 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.63]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.160]) with mapi id 14.03.0415.000;
 Mon, 31 Dec 2018 14:03:53 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     'Halil Pasic' <pasic@linux.ibm.com>
CC:     Christian Borntraeger <borntraeger@de.ibm.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>
Subject: RE: [PATCH v1 0/2] Virtio: fix some vq allocation issues
Thread-Topic: [PATCH v1 0/2] Virtio: fix some vq allocation issues
Thread-Index: AQHUnlmk6JahV5tUvEStaso2AfS7RqWTQxYAgAG9uICAAUfbAIAAuPNQ
Date:   Mon, 31 Dec 2018 06:03:51 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73DEEC8DF@shsmsx102.ccr.corp.intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
        <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
        <286AC319A985734F985F78AFA26841F73DEEA8E9@shsmsx102.ccr.corp.intel.com>
 <20181230070600.512bbb8b@oc2783563651>
In-Reply-To: <20181230070600.512bbb8b@oc2783563651>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTM0MWM1ODctZDFiYi00NTM5LThmODctNzk4ZmZhYzlmNDQwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibkFjaU5WY0owaWxUZlcwTkZ1aDlqU0pcL0hTeHF4MlkydThBQktYXC9zcU9rUU5wNWdub3VFSnZzakRHenYxMDRcLyJ9
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

On Sunday, December 30, 2018 2:06 PM, Halil Pasic wrote:
> 
> I guess you are the first one trying to read virtio config from within interrupt
> context. AFAICT this never worked.

I'm not sure about "never worked". It seems to work well with virtio-pci.
But looking forward to hearing a solid reason why reading config inside
the handler is forbidden (if that's true).

> About what happens. The apidoc of ccw_device_start() says it needs to be
> called with the ccw device lock held, so ccw_io_helper() tries to take it (since
> forever I guess). OTOH do_cio_interrupt() takes the subchannel lock and
> io_subchannel_initialize_dev() makes the ccw device lock be the subchannel
> lock. That means when one tries to get virtio config form within a cio
> interrupt context we deadlock, because we try to take a lock we already have.
> 
> That said, I don't think this limitation is by design (i.e. intended).
> Maybe Connie can help us with that question. AFAIK we have nothing
> documented regarding this (neither that can nor can't).
> 
> Obviously, there are multiple ways around this problem, and at the moment
> I can't tell which would be my preferred one.

Yes, it's also not difficult to tweak the virtio-balloon code to avoid that issue.
But if that's just an issue with ccw itself, I think it's better to tweak ccw and
remain virtio-balloon unchanged.

Best,
Wei

