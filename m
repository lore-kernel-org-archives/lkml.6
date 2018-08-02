Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E94C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5432154D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5432154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeHBVXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:23:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbeHBVXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:23:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A0DDF2B54;
        Thu,  2 Aug 2018 19:31:18 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30E9F100708A;
        Thu,  2 Aug 2018 19:31:18 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w72JVILG032049;
        Thu, 2 Aug 2018 15:31:18 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w72JVG7b032045;
        Thu, 2 Aug 2018 15:31:17 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 2 Aug 2018 15:31:15 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
Message-ID: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 19:31:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 19:31:18 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I tried to use a PCIe graphics card on the MacchiatoBIN board and I hit a 
strange problem.

When I use the links browser in graphics mode on the framebuffer, I get 
occasional pixel corruption. Links does memcpy, memset and 4-byte writes 
on the framebuffer - nothing else.

I found out that the pixel corruption is caused by overlapping unaligned 
stp instructions inside memcpy. In order to avoid branching, the arm64 
memcpy implementation may write the same destination twice with different 
alignment. If I put "dmb sy" between the overlapping stp instructions, the 
pixel corruption goes away.

This seems like a hardware bug. Is it a known errata? Do you have any 
workarounds for it?

I tried AMD card (HD 6350) and NVidia (NVS 285) and both exhibit the same 
corruption. OpenGL doesn't work (it results in artifacts on the AMD card 
and lock-up on the NVidia card), but it's quite expected if even simple 
writing to the framebuffer doesn't work.

Mikulas
