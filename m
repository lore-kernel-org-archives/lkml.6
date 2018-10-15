Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2695DC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D4820853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l2ay0zny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D4820853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJOQho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:37:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fsjYFasDVVKHJhcEP4q1Yb06CfX0mPf4bxanSXAOm9M=; b=l2ay0znyoQZRNpGnCy81MK2UQ
        V+YuZHvFBAF56/Z3IeNJMhut/KYJz9qhvyiFU1n/Rv4ZQvmQOHCa6QbSvSVG38ZKA9NDKBWnE4aGT
        BEFNTrUtMnraIYokM9I+DB/0jCeJAhgMphprJPMQBSDzaBcXduGyaDfqNKooSR7LkiBmOUyRUokeD
        VKMEQRhcQ/g1cHius7RdeXYKePqZ+xYE4je8dptrOq3HhC0u7kvoxyWQ+eEAPpJGWBqehWVpSg8Om
        6zlYyhCw4GjrwH/By0Q8Tn/fgAEXwdoUA9+lkQqrVpqShU8hh7EFRbhbMkzsHg6XAZ4wiugemHP8J
        X7iyU8p3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBycc-0005Z7-Jp; Mon, 15 Oct 2018 08:53:06 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E00AC20158F7C; Mon, 15 Oct 2018 10:53:04 +0200 (CEST)
Date:   Mon, 15 Oct 2018 10:53:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        mark.rutland@arm.com, megha.dey@intel.com, frederic@kernel.org
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181015085304.GE9885@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
 <20181015083448.GN9867@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015083448.GN9867@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:34:48AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 15, 2018 at 10:26:06AM +0300, Alexey Budankov wrote:

> > Rewrite is impressive however it doesn't result in code base reduction as it is.
> 
> Yeah.. that seems to be nature of these things ..

Note that some things did get simpler; the whole move_group case in the
syscall simplified, as well as the whole online state tracking (which
isn't completed).

But yes, overall complexity did increase by the additional data
structures and their relations.
