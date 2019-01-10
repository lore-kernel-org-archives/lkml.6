Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D887C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E3E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ap3OyXCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfAJP2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:28:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfAJP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2wLDVGrhNDVviljOKeJ96u35rDstOK3EWaUB6FtTgEU=; b=Ap3OyXCxVJ9Dgg+Ua4+r29aim
        mI483cjm5mHh1/LLeNmRDDfk3TV6u1TJGJRhJ0LPNhJqDhZX9aSNsj9gKCmhcqVJUWB0cDJVxkmqf
        OiF79EW5+jD9aRjFEGZPd6f2nM80EXK3wb2yMbSpQOxhUEtpPAhtD/AAVfOTljqmQAogp0i2VqahP
        pWMn+UvggmbOY4TRYFrtP9AlWB9Z5Sw+BJk3ANiYlpTTejeKLb7i5nIRQv7GNDor9TFCzKekZpu7v
        DTGtJ3l+jOw0sHT8avLgeUIXPRNEYMwppJO69EUTQxLMuU3K14zRKA3eUKNpBYgTUWg0tMPrBrbcR
        sugMG1JCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ghcFa-0007iZ-VL; Thu, 10 Jan 2019 15:28:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD2E72040B9FD; Thu, 10 Jan 2019 16:28:04 +0100 (CET)
Date:   Thu, 10 Jan 2019 16:28:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v5 07/15] locking/lockdep: Free lock classes that are no
 longer in use
Message-ID: <20190110152804.GH30894@hirez.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
 <20181217213002.73776-8-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217213002.73776-8-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 01:29:54PM -0800, Bart Van Assche wrote:
> +static bool inside_selftest(void)
> +{
> +	return current == lockdep_selftest_task_struct;
> +}

> +void lockdep_free_key_range(void *start, unsigned long size)
> +{
> +	init_data_structures_once();
> +
> +	if (inside_selftest())
> +		lockdep_free_key_range_imm(start, size);
> +	else
> +		lockdep_free_key_range_reg(start, size);
>  }

That is .... unfortunate. The whole reason that whole immediate thing
works at all is because there is no concurrency what so ever that early,
right?

Should we maybe key off of: 'system_state == SYSTEM_BOOTING' instead?
