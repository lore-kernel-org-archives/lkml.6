Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B81C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDF620881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 01:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDF620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754640AbeGJBR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 21:17:26 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39306 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754581AbeGJBRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 21:17:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 8708D22D6B;
        Mon,  9 Jul 2018 21:17:11 -0400 (EDT)
Date:   Tue, 10 Jul 2018 11:18:34 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Meelis Roos <mroos@linux.ee>, Mathieu Malaterre <malat@debian.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
In-Reply-To: <CAK8P3a29rNtWCcgKeJK57C5CPPi74wc1o1cnPJM=Qe+eMKFYjw@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1807101105130.12@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de> <CA+7wUsyN_gru4rW0y3ZzXzYwhfaA=uHKaOG=z5bprnYq6oVfMg@mail.gmail.com> <alpine.LRH.2.21.1807011844470.19761@math.ut.ee> <CAK8P3a29rNtWCcgKeJK57C5CPPi74wc1o1cnPJM=Qe+eMKFYjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018, Arnd Bergmann wrote:

> 
> The most likely explanation I have here is that the RTC was indeed set 
> to an incorrect date, either because of a depleted battery (not unlikely 
> for a ~15 year old box) or because it was previously stored incorrectly.

The PowerMac stores the GMT offset in NVRAM, and this gets used to 
initialize timezone_offset.

If timezone_offset was negative and now.tv_sec was zero, I think this 
could store a 1969 date in the RTC:

int update_persistent_clock64(struct timespec64 now)
{
        struct rtc_time tm;

        if (!ppc_md.set_rtc_time)
                return -ENODEV;

        rtc_time64_to_tm(now.tv_sec + 1 + timezone_offset, &tm);

        return ppc_md.set_rtc_time(&tm);
}

But maybe now.tv_sec can be shown to be greater than timezone_offset.

Then, what would happen when the timezone in /etc/localtime disagrees with 
the timezone_offset stored in NVRAM (PRAM)?

Besides that, if the battery went flat, what use is a backtrace? Why not 
scrap the WARN_ON()?

-- 
