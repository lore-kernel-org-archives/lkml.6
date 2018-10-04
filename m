Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B6DC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B34721470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I9cmM1oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B34721470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeJDOiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:38:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeJDOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eZBDnwGr9oVNA7kA7h5byR297Q47nz9SxD+TMpGg3PE=; b=I9cmM1oyIS4RlrOx5ra2WHXbD
        Z5dpiQoxGh8ftfmtuPIdbLeJBLpIiu4l/CR8LC53OG5wmsj7qBMk37yEVpUS5kENd+a9BAEF6/seW
        I4gGZgQAsTmsz8of3K3FNSbvt0C5lMIubezIPeKvaFe0A6rZBSG/nx05KaYUSRl5aKi2BmHIy5iV1
        6cAd6fn0WWn9QxbBQEXW0p8DtYYTJ90CEpbcchf1Ds8cvGlIpJ6Hn1L0lZAc7ftXRIocJ3MgdOjZT
        Da6qRCXhFaN7rEc1faF5b20LpsCd4DW1eoOd5SWkx8OL2/plaika+zt4pWmJ39eW2bdMuhkx1OuHP
        ySWUxWiXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7yKi-00018M-E7; Thu, 04 Oct 2018 07:46:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3EFA202666EC; Thu,  4 Oct 2018 09:37:19 +0200 (CEST)
Date:   Thu, 4 Oct 2018 09:37:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC] x86/cpu_entry_area: move part of it back to fixmap
Message-ID: <20181004073719.GD19272@hirez.programming.kicks-ass.net>
References: <20181004045948.129142-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004045948.129142-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 09:59:48PM -0700, Nadav Amit wrote:
> This patch proposes to do something different: break
> it into two. One part holds code+data that is needed for the entry
> (trampoline code, entry stack and TSS), which is mapped in the fixmap.

> The other part holds the exception_stacks, debug store and buffers, and
> is left in its current (new) position.

> The name
> "cpu_entry_area_aux" for the second area is awful (ideas are welcomed),

How about: cpu_data_area ? Since none of that is required for the entry,
that should also not be part of its name.
