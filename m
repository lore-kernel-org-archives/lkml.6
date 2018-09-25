Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC37C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB07B214FA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB07B214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbeIYPxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:53:21 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36555 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbeIYPxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:53:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07863218|-1;CH=blue;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03272;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.CvbiEzD_1537868763;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CvbiEzD_1537868763)
          by smtp.aliyun-inc.com(10.147.40.26);
          Tue, 25 Sep 2018 17:46:04 +0800
Date:   Tue, 25 Sep 2018 17:46:03 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Greentime Hu <green.hu@gmail.com>
Subject: Re: [PATCH V7 1/2] csky/dma: bugfix dma_sync_for_cpu/device
Message-ID: <20180925094601.GA2102@guoren>
References: <cover.1537276837.git.ren_guo@c-sky.com>
 <1ccf1bed89758a5a9b57ac2ce6d11ca898a1b9ae.1537276837.git.ren_guo@c-sky.com>
 <CAK8P3a0RDiP_R8+Lo9-nwiRS3k1NrtcsCFLi0Ww0TJGoAdb3iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0RDiP_R8+Lo9-nwiRS3k1NrtcsCFLi0Ww0TJGoAdb3iQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 10:38:04PM +0200, Arnd Bergmann wrote:
> On Tue, Sep 18, 2018 at 3:48 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > ref: https://lkml.org/lkml/2018/5/18/1068
> >
> >         map             for_cpu         for_device      unmap
> > TO_DEV  writeback       none            writeback       none
> > TO_CPU  invalidate      invalidate*     invalidate      invalidate*
> > BIDIR   writeback       invalidate      writeback       invalidate
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> 
> Same comment as for the other patch: Explain why the original
> version is wrong first. When giving a reference to some other
> discussion, use the "Link" tag above your Signed-off-by line.
> To point to a discussion on lkml, lore.kernel.org is the
> recommended archive, so it would become
> 
> Link: https://lore.kernel.org/lkml/20180518215548.GH17671@n2100.armlinux.org.uk/
Ok, I'll improve the comment:

Fixup dma_mapping error in linux-4.19-rc3, and we must implement all
DMA_TO_DEVICE/FROM_DEVICE/BIDIRECTIONAL for both sync_dma_for_device/cpu.
The implementation of arch should follow the following rules:

         map             for_cpu         for_device      unmap
 TO_DEV  writeback       none            writeback       none
 TO_CPU  invalidate      invalidate*     invalidate      invalidate*
 BIDIR   writeback       invalidate      writeback       invalidate

 Link: https://lore.kernel.org/lkml/20180518215548.GH17671@n2100.armlinux.org.uk/
 Signed-off-by: Guo Ren <ren_guo@c-sky.com>

Best Regards
 Guo Ren

