Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39257C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02394222B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VF5uumri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbfBMNNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:13:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42650 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbfBMNNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OrDra6RN/nWg7yjMYeikrCFx5quEOnHc3L9yCfDUMu4=; b=VF5uumriixGCW2D/9JGZ+0itT
        mYX905LLNIna/dqB+eZD3nQepPjnzqgAM9dNnS0pZM9l5rw7mhhEF/uDNyjhEva+MunpBjnWk0hQ3
        5XDJGCEVYmwENk7xueaXjZr/aFOs0aS4ctbsapyf/J66Ef2eUzJ2zxYxWoKy72mHKaqeSOjQlZ0zF
        bArf8l/J+fiS/m0JK3/NbqCFdR6NARor4yG93rbdEaYCHv9eZ9PKuqLwv7kalQWYYXMobaf99H7cb
        sh3KoRC/bZ1TN1n21n627fWWIUa2pdzwodPpJyAiYuYgiaGsBwy3J9aGpMbAOr2pxKuyuIQNCgFpv
        gnp07uaIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtuM2-0007xB-RH; Wed, 13 Feb 2019 13:13:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E9B720F51B12; Wed, 13 Feb 2019 14:13:33 +0100 (CET)
Date:   Wed, 13 Feb 2019 14:13:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>
Subject: Re: [PATCH 4.14 198/205] perf/core: Dont WARN() for impossible
 ring-buffer sizes
Message-ID: <20190213131333.GT32494@hirez.programming.kicks-ass.net>
References: <20190211141827.214852402@linuxfoundation.org>
 <20190211141841.367111122@linuxfoundation.org>
 <1eb319822aa9f75f423a7790e78315e7672036b9.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb319822aa9f75f423a7790e78315e7672036b9.camel@nokia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:03:39PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> Changing the patch like this fixes it...
> 
> -       if (order_base_2(size) >= MAX_ORDER)
> +       if (order_base_2(size) > MAX_ORDER)

That's wrong too..

There is this queued:

  http://lkml.kernel.org/r/tip-528871b456026e6127d95b1b2bd8e3a003dc1614@git.kernel.org
