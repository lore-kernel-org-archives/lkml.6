Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5B99BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B929208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RVEx1zbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B929208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756018AbeFOIMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:12:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755847AbeFOIMc (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MWe+AXNnb/K85IU5quTuJ4mdg1eJtIwrkHg1jZwS5/Y=; b=RVEx1zbhrWlrSY2qiIzf03mRc
        FjmhO2XxqViZZ/34maHWIitu/YOP8ZKaVXbTGgnk4LXCPfSh6BUaFzTP538m2AJM3i+Zaid7pgKEr
        trXVgteUpS2HH5IrwIfIQL/TPEIDS7MYc3TGfNxTJEE4krE1JwSbOYI/ntre8JOEaNufoDZAkjJis
        r6eds0Eae1e0eUH45RUMNx4FA54NnDoXWsjiE45bobNVtvs5DKt9vpUE+d9x6XBJ2q2lfraWm5Zzf
        jfDJPjzf8CWhKKfTlAuH8RaKZrupd34XkUVdYVpGpjCB9kGdH1oZX6V9V4Iv8Hp73DeCyl9a4nASr
        1XrzIucmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTjqL-0005nb-IQ; Fri, 15 Jun 2018 08:12:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 020962029FA0D; Fri, 15 Jun 2018 10:12:23 +0200 (CEST)
Date:   Fri, 15 Jun 2018 10:12:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, me@kylehuey.com,
        Linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        will.deacon@arm.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/2] perf: Drop leaked kernel samples
Message-ID: <20180615081223.GB2458@hirez.programming.kicks-ass.net>
References: <1529057003-2212-1-git-send-email-yao.jin@linux.intel.com>
 <20180615074504.GA2458@hirez.programming.kicks-ass.net>
 <11958be5-dc05-611b-6839-f1f6903c7ca8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11958be5-dc05-611b-6839-f1f6903c7ca8@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 04:01:45PM +0800, Jin, Yao wrote:

> Bring more overhead to kernel if we zero the bits considering the number of
> leaked samples may be not too small?

Keeping the samples at least allows you to know how many samples
happened and such things.

> And the skid information may be interesting (see example of hitting on
> page_fault in previous mail). If we zero it, we will not know.

If you throw them out the window you also don't know, do you?
