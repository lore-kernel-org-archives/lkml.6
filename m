Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F12C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B3821A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B3821A29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbeHFQWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:22:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727940AbeHFQWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:22:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA95A818A6B4;
        Mon,  6 Aug 2018 14:13:20 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 749CE101041B;
        Mon,  6 Aug 2018 14:13:20 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w76EDKpP012797;
        Mon, 6 Aug 2018 10:13:20 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w76EDJuL012793;
        Mon, 6 Aug 2018 10:13:19 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 6 Aug 2018 10:13:19 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Marcin Wojtas <mw@semihalf.com>
cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <neko@bakuhatsu.net>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAPv3WKeVkWChEE7WjKuu__bg+zvh9dTNy=U_2jiSyWxFWiatbA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808061008520.9697@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com> <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com> <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com> <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com> <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com> <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com> <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com> <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
 <CAPv3WKdxwoW5MAOvy6uEBEuMpsigMo98hyO+TpKMsFrKR9oBzg@mail.gmail.com> <CAKv+Gu8XN-vP64G_NLHFcRUJ2fptSrmxfd6CHWDgHkJj073Hbg@mail.gmail.com> <CAPv3WKeVkWChEE7WjKuu__bg+zvh9dTNy=U_2jiSyWxFWiatbA@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 14:13:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 14:13:20 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2018, Marcin Wojtas wrote:

> > Hi Marcin,
> >
> > Could you please try running his reproducer?
> 
> This is exactly what I plan to do, as soon as I can plug my GFX card
> back to the board (tomorrow). Just to remain aligned - is it ok, if I
> boot my debian with GT630 plugged, compile the program with -O2 and
> simlply run it on /dev/fb0?
> 
> Best regards,
> Marcin

Yes - when you run it, don't switch consoles (it will obviously trigger 
false warning), don't move the mouse to the upper left corner, and if you 
want to run it in the long term, turn off console blanking.

Mikulas
