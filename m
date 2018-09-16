Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D488AECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 12:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2632087B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 12:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2632087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deneb.enyo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeIPRop convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 13:44:45 -0400
Received: from albireo.enyo.de ([5.158.152.32]:53230 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbeIPRoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 13:44:44 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Sep 2018 13:44:43 EDT
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1g1VyT-0007lT-HN; Sun, 16 Sep 2018 12:16:25 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.89)
        (envelope-from <fw@deneb.enyo.de>)
        id 1g1VyT-0006uT-AF; Sun, 16 Sep 2018 14:16:25 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Rich Felker <dalias@libc.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-man@vger.kernel.org,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Subject: Re: futex_cmpxchg_enabled breakage
References: <20180829222221.GA22017@brightrain.aerifal.cx>
Date:   Sun, 16 Sep 2018 14:16:25 +0200
In-Reply-To: <20180829222221.GA22017@brightrain.aerifal.cx> (Rich Felker's
        message of "Wed, 29 Aug 2018 18:22:21 -0400")
Message-ID: <87fty9hc2u.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rich Felker:

> I just spent a number of hours helping someone track down a bug that
> looks like it's some kind of futex_cmpxchg_enabled detection error on
> powerpc64 (still not sure of the root cause; set_robust_list producing
> -ENOSYS), and a while back I hit the same problem on sh2 due to lack
> of EFAULT on nommu, leading to commit 72cc564f16ca. I think the test
> (introduced way back in commit a0c1e9073ef7) is fundamentally buggy;
> if anything, it should be checking for !=-ENOSYS, not ==-EFAULT.
> Presumably it could also fail to produce -EFAULT if mmap_min_addr is 0
> and page 0 is mapped (a bad idea, but maybe someone does it...). And
> of course other nommu archs are possibly still broken.

Maybe it was related to this (“Kernel 4.15 lost set_robust_list
support on POWER 9”):

<https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-February/168570.html>

The Kconfig change you suggest was explicitly rejected as the fix.

I believe the expected userspace interface is that you probe support
with set_robust_list first, and then start using the relevant futex
interfaces only if that call succeeded.  If you do that, most parts of
a typical system will work as expected even if the kernel support is
not there, which is a bit surprising.  It definitely makes the root
cause harder to spot.
