Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEB0C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4167B20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fSZRqt8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4167B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbeG0JLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:11:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729420AbeG0JLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/nQPEsmRZE4tPQGkH8NSkbI3bVNYbOe4WCsjrObt5jo=; b=fSZRqt8UnYTREQzSv4zoEwTJr
        idZrKpXD6R5UewT70OqXx+niK9OprKHMxE1oefuK3dQjxo/iItkc+DcF29pQ+9mVDM51eW3R/oTmD
        HorTJHo2TUTe3D3l5M0t9DXIMSwT6ogXJw7QKijluhrBZhJYzRaNFDj+yRwZ/+nLPjDXBWFqeSgdo
        N8x2FD7tLrYxKbGDk4c4P1AHzuTAOwfW8gZiE4X1xS6fqxLXm4d3UnIXnrl9bnrCTHGUafyPbVdaU
        U+av5prXQp+gMsOXFpTEzIPDFqkT4/6zFu7stLUttc/t2vLugJECVoXRzMDI7BI/68vuD9jS13Bn5
        DplvFmXEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fixWf-0005hg-Ty; Fri, 27 Jul 2018 07:51:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69A2D2040AE9C; Fri, 27 Jul 2018 09:51:00 +0200 (CEST)
Date:   Fri, 27 Jul 2018 09:51:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: tsc: avoid system instability in hibernation
Message-ID: <20180727075100.GZ2494@hirez.programming.kicks-ass.net>
References: <20180725181846.1817-1-eduval@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725181846.1817-1-eduval@amazon.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:18:46AM -0700, Eduardo Valentin wrote:
> System instability are seen during resume from hibernation when system
> is under heavy CPU load. This is due to the lack of update of sched
> clock data, and the scheduler would then think that heavy CPU hog
> tasks need more time in CPU, causing the system to freeze
> during the unfreezing of tasks. For example, threaded irqs,
> and kernel processes servicing network interface may be delayed
> for several tens of seconds, causing the system to be unreachable.

> +static int tsc_pm_notifier(struct notifier_block *notifier,
> +			   unsigned long pm_event, void *unused)
> +{
> +	switch (pm_event) {
> +	case PM_HIBERNATION_PREPARE:
> +		clear_sched_clock_stable();
> +		break;
> +	case PM_POST_HIBERNATION:
> +		/* Set back to the default */
> +		if (!check_tsc_unstable())
> +			set_sched_clock_stable();
> +		break;
> +	}

I've not looked at this in detail yet, but this is an absolute no go,
not going to happen, full stop.

If we _ever_ mark the thing unstable, that's it, the end. Allowing it to
go back to stable is a source of utter fail.
