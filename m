Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED449C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF2B21762
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF2B21762
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeHHQGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:06:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727087AbeHHQGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:06:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40C564023444;
        Wed,  8 Aug 2018 13:46:38 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D73CE2166BA0;
        Wed,  8 Aug 2018 13:46:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w78DkbuD004942;
        Wed, 8 Aug 2018 09:46:37 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w78DkYvf004938;
        Wed, 8 Aug 2018 09:46:35 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 8 Aug 2018 09:46:34 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     David Laight <David.Laight@ACULAB.COM>
cc:     "'Catalin Marinas'" <catalin.marinas@arm.com>,
        Matt Sealey <neko@bakuhatsu.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <b1de49af14d941979977af07dc81e1c2@AcuMS.aculab.com>
Message-ID: <alpine.LRH.2.02.1808080939180.3325@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com> <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com> <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com> <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com> <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com> <20180808121641.GB24736@iMac.local> <b1de49af14d941979977af07dc81e1c2@AcuMS.aculab.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 08 Aug 2018 13:46:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 08 Aug 2018 13:46:38 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Aug 2018, David Laight wrote:

> From: Catalin Marinas
> > Sent: 08 August 2018 13:17
> ...
> > I think hazarding is what goes wrong here, especially since with
> > overlapping unaligned addresses. However, I disagree that it is
> > impossible to implement this properly on a platform with PCIe so that
> > Normal NC mappings can be used.
> 
> I've been trying to follow this discussion...
> 
> Is the problem just that reads don't snoop/flush the write-combining buffer?

No. The pixel corruption is permanently visible on the monitor (even if 
there are no reads from the framebuffer at all). So it can't be explained 
as mishandling read-after-write hazard.

> Aligned writes that end on an appropriate boundary will leave the write
> combining buffer empty.
> But if the buffer isn't emptied the PCIe read gets ahead of the PCIe write.
> 
> ISTR even x86 requires a fence instruction in some sequence associated
> with write-combining writes.

Other x86 cores may observe wc writes out of order - but a single x86 
core is self-consistent - i.e. if you do
movl $0x00000000, (%ebx)
movl $0xFFFFFFFF, 3(%ebx)
then the byte at ebx+3 will always contain 0xFF. The core can't just 
corrupt data while doing reordering.

The problem on ARM is that I see data corruption when the overlapping 
unaligned writes are done just by a single core.

> 	David

Mikulas
