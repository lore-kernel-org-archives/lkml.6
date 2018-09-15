Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E050FECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B015208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 17:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B015208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeIOWrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 18:47:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51974 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbeIOWrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 18:47:53 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1EMW-00039t-D4; Sat, 15 Sep 2018 19:28:04 +0200
Date:   Sat, 15 Sep 2018 19:28:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
In-Reply-To: <20180915164731.3zrdxijuwkgdi25p@shbuild888>
Message-ID: <alpine.DEB.2.21.1809151923270.1650@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1808301523510.1210@nanos.tec.linutronix.de> <20180831061519.3zbxsjs4rd6mmsuo@shbuild888> <alpine.DEB.2.21.1808311328260.2208@nanos.tec.linutronix.de> <20180831133659.pkmscqpudjnkujbg@shbuild888> <20180907081716.bxw3hmcl6w7gqvax@shbuild888>
 <alpine.DEB.2.21.1809071250240.1402@nanos.tec.linutronix.de> <20180910093938.ka732apzy3d3a5ip@shbuild888> <alpine.DEB.2.21.1809101147500.1402@nanos.tec.linutronix.de> <20180911061413.redy4oxia3hqifkh@shbuild888> <alpine.DEB.2.21.1809151226130.1650@nanos.tec.linutronix.de>
 <20180915164731.3zrdxijuwkgdi25p@shbuild888>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2018, Feng Tang wrote:
> I have tried to change some header files incluing fixmap.h/apicdef.h/
> vsyscall.h, and most of the .c files compile fine now, but I can not
> use the "__end_of_permanent_fixed_addresses" in head_64.S as it is a 
> enum type, and could not be recognized by assembly code.

Hrmm. I did not think about the enum. So we have two possibilities:

1) Have some preprocessing which provides the info for the assembler

2) Use a constant for the number of PMDs which is defined in a header and
   then compile time checked against the size of the fixmap in a C-file.

#1 would be preferred, but for a quick fix #2 is okay as well.

Thanks,

	tglx


