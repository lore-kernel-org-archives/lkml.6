Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0860AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA4620844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbfBENHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:07:38 -0500
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:13623 "EHLO
        mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfBENHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:07:38 -0500
X-Greylist: delayed 672 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Feb 2019 08:07:37 EST
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [192.168.231.131]) by mgwkm02.jp.fujitsu.com with smtp
         id 24f1_25cb_8164ddb1_ce26_48c2_bc08_dab2ac880630;
        Tue, 05 Feb 2019 21:56:20 +0900
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
        by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id C8073AC013C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Feb 2019 21:56:20 +0900 (JST)
Received: from G01JPEXCHYT18.g01.fujitsu.local (G01JPEXCHYT18.g01.fujitsu.local [10.128.194.57])
        by g01jpfmpwyt03.exch.g01.fujitsu.local (Postfix) with ESMTP id BBD3546E683;
        Tue,  5 Feb 2019 21:56:19 +0900 (JST)
Received: from localhost (10.17.204.234) by G01JPEXCHYT18.g01.fujitsu.local
 (10.128.194.57) with Microsoft SMTP Server id 14.3.408.0; Tue, 5 Feb 2019
 21:56:19 +0900
X-SecurityPolicyCheck: OK by SHieldMailChecker v2.5.2
X-SHieldMailCheckerPolicyVersion: FJ-ISEC-20170217-enc
X-SHieldMailCheckerMailID: 2f5c2cdb5aed4922b1b5e740c2cf4f28
Date:   Tue, 5 Feb 2019 21:56:05 +0900
From:   Takao Indoh <indou.takao@fujitsu.com>
To:     Keith Busch <keith.busch@intel.com>
CC:     Takao Indoh <indou.takao@jp.fujitsu.com>, <axboe@fb.com>,
        <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
Message-ID: <20190205124757.GA28465@esprimo>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190201145414.GA22199@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 07:54:14AM -0700, Keith Busch wrote:
> On Fri, Feb 01, 2019 at 09:46:15PM +0900, Takao Indoh wrote:
> > From: Takao Indoh <indou.takao@fujitsu.com>
> > 
> > Fujitsu A64FX processor has a feature to accelerate data transfer of
> > internal bus by relaxed ordering. It is enabled when the bit 56 of dma
> > address is set to 1.
> 
> Wait, what? RO is a standard PCIe TLP attribute. Why would we need this?

I should have explained this patch more carefully.

Standard PCIe devices can use Relaxed Ordering (RO) by setting Attr
field in the TLP header, however, this mechanism cannot be utilized if
the device does not support RO feature. Fujitsu A64FX processor has an
alternate feature to enable RO in its Root Port by setting the bit 56 of
DMA address. This mechanism enables to utilize RO feature even if the
device does not support standard PCIe RO.

The data packet with its DMA address bit 56 is set, is transferred from
the device to the PCI root port with Strong Ordering (SO), and then it
is transferred with RO to the host memory.

This patch adds new code into NVMe driver to set bit 56 of DMA address
to utilize this feature. The reason why I do this in NVMe driver is that
here is an only place where we can traverses a sgl list to update the
DMA addresses. We can transfer data buffers with RO, but we cannot use
RO as for writes to the admin completion queue and the I/O completion
queue from the NVMe controller to the host. These writes need to be done
with SO to avoid data corruption. This patch scans data buffers queued
in the sgl list and update their DMA addresses to send data buffers with
RO.

Thanks,
Takao Indoh

