Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9906C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2B5206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2B5206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeIERrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:47:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59578 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeIERra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:47:30 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxXgA-0004V8-PZ; Wed, 05 Sep 2018 15:17:06 +0200
Date:   Wed, 5 Sep 2018 15:17:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
cc:     josh@joshtriplett.org, peterz@infradead.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dzickus@redhat.com,
        brendan.jackman@arm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpu/hotplug: Fix rollback during error-out in
 takedown_cpu()
In-Reply-To: <5b0e528f-e597-9598-3ff6-b9e08ddb8165@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1809051514070.1416@nanos.tec.linutronix.de>
References: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org> <alpine.DEB.2.21.1809051244500.1416@nanos.tec.linutronix.de> <alpine.DEB.2.21.1809051419580.1416@nanos.tec.linutronix.de> <5b0e528f-e597-9598-3ff6-b9e08ddb8165@codeaurora.org>
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

On Wed, 5 Sep 2018, Neeraj Upadhyay wrote:
> On 09/05/2018 05:53 PM, Thomas Gleixner wrote:
> >
> > And looking closer this is a general issue. Just that the TEARDOWN state
> > makes it simple to observe. It's universaly broken, when the first teardown
> > callback fails because, st->state is only decremented _AFTER_ the callback
> > returns success, but undo_cpu_down() increments unconditionally.
> >
>
> As per my understanding, there are 2 problems here; one is fixed with your
> patch, and other is cpuhp_reset_state() is used during rollback from non-AP to
> AP state, which seem to result in 2 increments of st->state (one increment
> done by cpuhp_reset_state() and another by cpu_thread_fun()) .

And how did your hack fix that up magically? I'll have a look later today.

Thanks,

	tglx
