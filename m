Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BEBC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835D423F82
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JOPJP26P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835D423F82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753750AbeGERXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:23:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753213AbeGERXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E331Esi3pQZQOW78mdfcyYXHpZG60BWd9YL5WNgzLQk=; b=JOPJP26P/OUza5Om3NSLV0b3O
        YCmdvOzMfonvCHHPhvPk53gYkhJVZQiyfbFzog79ZNcDhXh0LrGqmBM02MufW1V8xpHYWpKJW/YSq
        cQKy1RbI0d3iZhlUUrlpLEsG7aP6NUSdCkl0Nv+9ThXlY298zz+dCHCdpx1rveUINobLW7tFivNaS
        5tGEwRhwBI7WYBVv86J3zhSCeFExfI/pHqwkQr9FFXsXKc2jm4zXifP7DGPP2blhmOoQoi1Ho0dCb
        nI3YF2Gd9pc0dk5J7VWaM1lO458jyp4MSv60pWAl4yohbjnULyIidqB+JDLMh9qVhTRSm+aOVbqdf
        uH2Z44cow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fb7yG-0002hK-G6; Thu, 05 Jul 2018 17:23:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 394E720298BAE; Thu,  5 Jul 2018 19:23:06 +0200 (CEST)
Date:   Thu, 5 Jul 2018 19:23:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will.deacon@arm.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        aryabinin@virtuozzo.com, boqun.feng@gmail.com,
        catalin.marinas@arm.com, dvyukov@google.com, glider@google.com,
        hpa@zytor.com, linuxdrivers@attotech.com, mingo@kernel.org,
        mingo@redhat.com, parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de
Subject: Re: [PATCHv3 08/12] atomics: switch to generated fallbacks
Message-ID: <20180705172306.GG2494@hirez.programming.kicks-ass.net>
References: <20180705164053.10073-1-mark.rutland@arm.com>
 <20180705164053.10073-9-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705164053.10073-9-mark.rutland@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:40:49PM +0100, Mark Rutland wrote:

> * The fallbacks are not expected to change very often, and are not
>   affected by machine details or configuration options, so regenerating
>   them for *every* build is somewhat wasteful.

Except of course, your last patch in this series now does exactly that
:-)
