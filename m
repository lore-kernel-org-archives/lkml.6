Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284EDC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38B920837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38B920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLGPoo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:44:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeLGPoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:44:44 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E09E43082142;
        Fri,  7 Dec 2018 15:44:43 +0000 (UTC)
Received: from localhost (ovpn-200-34.brq.redhat.com [10.40.200.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B58B82785;
        Fri,  7 Dec 2018 15:44:36 +0000 (UTC)
Date:   Fri, 7 Dec 2018 16:44:35 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, tariqt@mellanox.com,
        ilias.apalodimas@linaro.org, toke@toke.dk,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        brouer@redhat.com
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Message-ID: <20181207164435.18f8ffed@redhat.com>
In-Reply-To: <20181207012141.GA4256@lst.de>
References: <20181206153720.10702-1-hch@lst.de>
        <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com>
        <20181206184330.GB30039@lst.de>
        <173bfba7-033d-93c4-6ef1-48c9e39c9efc@arm.com>
        <20181206200006.GA31548@lst.de>
        <e3e4c17e-ba6d-d743-04e5-7f240211b9bc@arm.com>
        <20181207012141.GA4256@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 07 Dec 2018 15:44:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018 02:21:42 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Dec 06, 2018 at 08:24:38PM +0000, Robin Murphy wrote:
> > On 06/12/2018 20:00, Christoph Hellwig wrote:  
> >> On Thu, Dec 06, 2018 at 06:54:17PM +0000, Robin Murphy wrote:  
> >>> I'm pretty sure we used to assign dummy_dma_ops explicitly to devices at
> >>> the point we detected the ACPI properties are wrong - that shouldn't be too
> >>> much of a headache to go back to.  
> >>
> >> Ok.  I've cooked up a patch to use NULL as the go direct marker.
> >> This cleans up a few things nicely, but also means we now need to
> >> do the bypass scheme for all ops, not just the fast path.  But we
> >> probably should just move the slow path ops out of line anyway,
> >> so I'm not worried about it.  This has survived some very basic
> >> testing on x86, and really needs to be cleaned up and split into
> >> multiple patches..  
> >
> > I've also just finished hacking something up to keep the arm64 status quo - 
> > I'll need to actually test it tomorrow, but the overall diff looks like the 
> > below.  
> 
> Nice.  I created a branch that picked up your bits and also the ideas
> from Linus, and the result looks reall nice.  I'll still need a signoff
> for your bits, though.
> 
> Jesper, can you give this a spin if it changes the number even further?
> 
>   git://git.infradead.org/users/hch/misc.git dma-direct-calls.2
> 
>   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-calls.2

I'll test it soon...

I looked at my perf stat recording on my existing tests[1] and there
seems to be significantly more I-cache usage.

Copy-paste from my summary[1]:
 [1] https://github.com/xdp-project/xdp-project/blob/master/areas/dma/dma01_test_hellwig_direct_dma.org#summary-of-results

* Summary of results

Using XDP_REDIRECT between drivers RX ixgbe(10G) redirect TX i40e(40G),
via BPF devmap (used samples/bpf/xdp_redirect_map) . (Note choose
higher TX link-speed to assure that we don't to have a TX bottleneck).
The baseline-kernel is at commit https://git.kernel.org/torvalds/c/ef78e5ec9214,
which is commit just before Hellwigs changes in this tree.

Performance numbers in packets/sec (XDP_REDIRECT ixgbe -> i40e):
 - 11913154 (11,913,154) pps - baseline compiled without retpoline
 -  7438283  (7,438,283) pps - regression due to CONFIG_RETPOLINE
 -  9610088  (9,610,088) pps - mitigation via Hellwig dma-direct-calls

From the inst per cycle, it is clear that retpolines are stalling the CPU
pipeline:

| pps        | insn per cycle |
|------------+----------------|
| 11,913,154 |           2.39 |
| 7,438,283  |           1.54 |
| 9,610,088  |           2.04 |


Strangely the Instruction-Cache is also under heavier pressure:

| pps        | l2_rqsts.all_code_rd | l2_rqsts.code_rd_hit | l2_rqsts.code_rd_miss |
|------------+----------------------+----------------------+-----------------------|
| 11,913,154 | 874,547              | 742,335              | 132,198               |
| 7,438,283  | 649,513              | 547,581              | 101,945               |
| 9,610,088  | 2,568,064            | 2,001,369            | 566,683               |
|            |                      |                      |                       |


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
