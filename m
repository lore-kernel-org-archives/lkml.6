Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759F8C67863
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 00:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379A4215EC
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 00:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379A4215EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeJUI1g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 04:27:36 -0400
Received: from linode.aoot.com ([69.164.194.13]:42582 "EHLO linode.aoot.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbeJUI1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 04:27:36 -0400
Received: from stevoacer (47-221-137-213.gtwncmta03.res.dyn.suddenlink.net [47.221.137.213])
        by linode.aoot.com (Postfix) with ESMTP id CECB6821C;
        Sat, 20 Oct 2018 19:15:18 -0500 (CDT)
From:   "Steve Wise" <swise@opengridcomputing.com>
To:     "'Wenwen Wang'" <wang6495@umn.edu>
Cc:     "'Kangjie Lu'" <kjlu@umn.edu>, <swise@chelsio.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>,
        "'open list'" <linux-kernel@vger.kernel.org>
References: <1540072741-18856-1-git-send-email-wang6495@umn.edu> <038301d468ca$9d30ca90$d7925fb0$@opengridcomputing.com> <CAAa=b7fPLM-kF+VyZhhj2tzhzuFNnXpv=gPVJ2mCcfQyToew0Q@mail.gmail.com>
In-Reply-To: <CAAa=b7fPLM-kF+VyZhhj2tzhzuFNnXpv=gPVJ2mCcfQyToew0Q@mail.gmail.com>
Subject: RE: [PATCH] iw_cxgb4: fix a missing-check bug
Date:   Sat, 20 Oct 2018 19:15:17 -0500
Message-ID: <000401d468d3$259c3790$70d4a6b0$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHGM3QZHxRys26vq/PiwJXt1dGVDQG9X7blAxkWL/alHotKoA==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wenwen Wang <wang6495@umn.edu>
> Sent: Saturday, October 20, 2018 6:56 PM
> To: swise@opengridcomputing.com
> Cc: Kangjie Lu <kjlu@umn.edu>; swise@chelsio.com; dledford@redhat.com;
> jgg@ziepe.ca; linux-rdma@vger.kernel.org; open list <linux-
> kernel@vger.kernel.org>; Wenwen Wang <wang6495@umn.edu>
> Subject: Re: [PATCH] iw_cxgb4: fix a missing-check bug
> 
> On Sat, Oct 20, 2018 at 6:41 PM Steve Wise
> <swise@opengridcomputing.com> wrote:
> >
> > Hey Wenwen,
> >
> > > Subject: [PATCH] iw_cxgb4: fix a missing-check bug
> > >
> > > In c4iw_flush_hw_cq, the next CQE is acquired through
> t4_next_hw_cqe(). In
> > > t4_next_hw_cqe(), the CQE, i.e., 'cq->queue[cq->cidx]', is checked to see
> > > whether it is valid through t4_valid_cqe(). If it is valid, the address of
> > > the CQE is then saved to 'hw_cqe'. Later on, the CQE is copied to the
> > local
> > > memory in create_read_req_cqe(). The problem here is that the CQE is
> > > actually in a DMA region allocated by dma_alloc_coherent() in
> create_cq().
> > > Given that the device also has the permission to access the DMA region, a
> > > malicious device controlled by an attacker can modify the CQE in the DMA
> > > region after the check in t4_next_hw_cqe() but before the copy in
> > > create_read_req_cqe(). By doing so, the attacker can supply invalid CQE,
> > > which can cause undefined behavior of the kernel and introduce
> potential
> > > security risks.
> > >
> >
> > If the dma device is malicious, couldn't it just dma some incorrect CQE but
> > still valid in the first place?  I don't think this patch actually solves
> > the issue, and it forces a copy of a 64B CQE in a critical data io path.
> 
> Thanks for your response! If the malicious dma device just dma some
> incorrect CQE, it will not be able to pass the verification in
> t4_valid_cqe().
> 

As long as the gen bit is correct, the CQE is considered valid.  You cannot protect against a malicious dma device.  Or at least not with the current driver/device contract.

Steve.




