Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D8EA2C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4FA208B5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IQmyaO/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4FA208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755450AbeFNUDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:03:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755392AbeFNUDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oig3U8tPfOJUkkGI3MQeH3SS37M7wVP482x9oGTfrjc=; b=IQmyaO/DqCjfX0/2C9XY3TLPY
        a3pfNUiBd6w7wgN59bEaj5soYMFsr7GMkfbOz5tFcYRImGv7LsmFQy0rymZAg2GDp8NcF29eV05BR
        87QBEqG9EW67afaUWRn36KgVdiq24lbLctAKsN0IVSX5vOiV+LyXF8lTtXGwu78d/YCQkzeCzld1o
        kULjB8/n1ctvHxWRCvIPZQzYqLYtEwVbGTXDDGU8JS+jkV7+YUAKokSpT3FuatyjGiyg0bjtQsTgg
        IRQrMrRCBbzOBtAVB5+FiYwoVw2SImD5XmTGqcbGcsDNo/WwIn246KtIrL8GfRmFLVo7gaedD7jYF
        NTfhkJUiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTYT5-0007jY-SB; Thu, 14 Jun 2018 20:03:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28A81201EA7C9; Thu, 14 Jun 2018 22:03:38 +0200 (CEST)
Date:   Thu, 14 Jun 2018 22:03:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 4/6] perf: Allow using AUX data in perf samples
Message-ID: <20180614200338.GB12217@hirez.programming.kicks-ass.net>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
 <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612075117.65420-5-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:51:15AM +0300, Alexander Shishkin wrote:
> +	ret = rb_output_aux(rb, data->aux.from, data->aux.to,
> +			    (aux_copyfn)perf_output_copy, handle);

If you look closely, you'll find that perf_output_copy() as 'unsigned
int' return type and your aux_copyfn has 'unsigned long'.

I'm thinking that the compiler is entirely in its right to make that
explode at random points in time.
