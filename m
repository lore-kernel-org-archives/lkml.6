Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE00020856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE00020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbeGXNSP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:18:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:44564 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388241AbeGXNSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:18:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 05:12:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,397,1526367600"; 
   d="scan'208";a="69801999"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2018 05:11:22 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 24 Jul 2018 05:11:22 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 24 Jul 2018 05:11:21 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.124]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.100]) with mapi id 14.03.0319.002;
 Tue, 24 Jul 2018 20:11:20 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Jacopo Mondi <jacopo@jmondi.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>
Subject: RE: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
Thread-Topic: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
Thread-Index: AQHUI0M6y+yhFL0AT06pZrXfSGf336SeRmEQ
Date:   Tue, 24 Jul 2018 12:11:18 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662494CC41594@shsmsx102.ccr.corp.intel.com>
References: <20180719130516.1989-1-hch@lst.de>
 <20180719130516.1989-5-hch@lst.de> <20180723084207.GI6784@w540>
 <CAMuHMdX=b0iAnDw1=85MXNBSMD=MxZb27QrO3rEWHYq0vB+3ow@mail.gmail.com>
 <20180724114334.GA21973@lst.de>
In-Reply-To: <20180724114334.GA21973@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTFkNTQ4Y2QtYjg5MS00YjRmLWFmZjctMmMwMTkzZmI0YmY4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVkdnc1puQndEd1wvMWhLVTNwNXRMUVFFMVJVcFc3YmRWNzJwU2FKN2JiSXUxVzRFWURHOVZ0eWFLUkFsXC9ja2hsIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
> 
> On Mon, Jul 23, 2018 at 10:49:39AM +0200, Geert Uytterhoeven wrote:
> > > > +     *dma_handle = virt_to_phys(ret);
> > > > +     if (!WARN_ON(!dev))
> > > > +             *dma_handle - PFN_PHYS(dev->dma_pfn_offset);
> > > vs
> > > > -     *dma_handle = virt_to_phys(ret);
> > > > -     if (!WARN_ON(!dev))
> > > > -             *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
> >
> > Doesn't look right to me, neither.
> >
> > No complaints for 0day? My gcc says:
> >
> >     error: statement with no effect [-Werror=unused-value]
> 
> For some reason 0day has failed me multiple times for sh.  Does the
> 0day bot even cover sh at all?
yes, we do cover the sh arch. Sorry for missing the reports for sh arch.

After check, for unknown reason, certain commit leads to large build error and makes
disc full, so that other sh builds are impacted (blocked). I will follow up this to see
how to solve the issue.

kernel/sh-allnoconfig/gcc-7# find -mindepth 1 -maxdepth 1|xargs -i du -sh {}
30G     ./f41ccf64b487381388c2b5ef8c13d79509dde76e
kernel/sh-rsk7269_defconfig/gcc-7# find -mindepth 1 -maxdepth 1|xargs -i du -sh {}
32G     ./f41ccf64b487381388c2b5ef8c13d79509dde76e

kernel/sh-rsk7269_defconfig/gcc-7/f41ccf64b487381388c2b5ef8c13d79509dde76e/build-error# ls
make-oldnoconfig
make-prepare
make-prepare.0
make-prepare.1
make-prepare.10
make-prepare.100
make-prepare.1000

Thanks
