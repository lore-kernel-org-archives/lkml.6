Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80EC218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fOxssP5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfAGRLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:11:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfAGRLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uRkjJxjV/WgS4eUCRtQonlei5iRDdbZzr4L4TH1FUTo=; b=fOxssP5OmGTIGUjgLPVYndcBY
        QQm5rpMleiJWqcuX0VsokRrQ5bIq4wOK5QZIramzmb3MYUN95v0GK1pPL86gM2ke3ffXY552ltLro
        0QcXrbL+wUSIZyiMMBUNehcg8p9CF/GVkhuX30K2x5zM6igHqvfqiU5Tv3xpFiSZeIiGvXlIHgLAt
        Hv6KdxWoFJo4AMYwyxJjeRrS019zLasmYE8REj+N7rsu6AyIkY7SbkidhLIDsv1U2b9zAWy3FX+9K
        HPS2xbhpLMTNfAlGgW8dodqVUnbKaE07L14YIGIA5VLBHuTc6Z7B9ODblAB2Vu6ZV+vdZJrAgSlrR
        tNgxbkWSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggYQa-0007KA-L2; Mon, 07 Jan 2019 17:11:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B0F6201411A4; Mon,  7 Jan 2019 18:11:01 +0100 (CET)
Date:   Mon, 7 Jan 2019 18:11:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: fix a potential double-fetch bug in
 sched_copy_attr
Message-ID: <20190107171101.GI14122@hirez.programming.kicks-ass.net>
References: <20181225221648.70069-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181225221648.70069-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 04:16:47PM -0600, Kangjie Lu wrote:
> "uattr->size" is copied in from user space and checked. However, it is
> copied in again after the security check. A malicious user may race to
> change it. The fix checks if uattr->size is ever changed after the
> check.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---

> +	/* Sanity check if size was changed in user space */
> +	if (attr->size != size)
> +		return -EINVAL;
> +

What perf_copy_attr() does (from whence we copied this code) is:

	attr->size = size;

Would that not also fix things?
