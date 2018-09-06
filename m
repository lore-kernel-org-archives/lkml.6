Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE58BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1A520659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1A520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeIFMoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:44:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32905 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeIFMoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:44:25 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxpMg-0000Yp-3T; Thu, 06 Sep 2018 10:10:10 +0200
Date:   Thu, 6 Sep 2018 10:10:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Prakruthi Deepak Heragu <pheragu@codeaurora.org>
cc:     linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org
Subject: Re: [PATCH] kernel: cpu: Handle hotplug failure for state
 CPUHP_AP_IDLE_DEAD
In-Reply-To: <1536174917-11408-1-git-send-email-pheragu@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1809060957540.1416@nanos.tec.linutronix.de>
References: <1536174917-11408-1-git-send-email-pheragu@codeaurora.org>
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

On Wed, 5 Sep 2018, Prakruthi Deepak Heragu wrote:

> Once the tear down hotplug handler is run, cpu is dead and enters
> into CPUHP_AP_IDLE_DEAD state. Any callbacks that fail in the state
> machine with state < CPUHP_AP_IDLE must be treated as fatal as this
> could result into timer not beig migrated away from dead cpu and run
> into issues like work queue lock ups, sched_clock timer wrapping to
> zero as sched_clock_poll which is in the hrtimer base of cpu being
> hotplugged does not get migrated.

BUG_ON() is the last resort when there is no other way out. And there is no
reason to treat such a failure as fatal unconditionally.

Why would any of those callback fail at all? And if that ever happens, then
we really can be smarter than just giving up.

Thanks,

	tglx


