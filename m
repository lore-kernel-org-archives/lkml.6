Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA0DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3892152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vdTtmjLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3892152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbeITX6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbeITX6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:58:39 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B19D21531;
        Thu, 20 Sep 2018 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537467236;
        bh=0nEB1sye4ilDKbgLaeGRHrlmAQSzZit+V0Z6kRZn1dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdTtmjLX/Id9+wr8YSlMZf+AUT4eCO6pm9T5dr136uHmwSXmCf0mYj3E8MInfilK8
         ZhDXSlKZYvIc1kCRIY40lHdky+Pw09lDfH82Rwoo/j4VA8GT7byBplDKibVG8muofD
         T4Euhv+pLBBokLSn4bqnsfbAZp4i0lmjYtJ9koWw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id DD54F1401A1; Thu, 20 Sep 2018 15:13:52 -0300 (-03)
Date:   Thu, 20 Sep 2018 15:13:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: RFC/error: Re: [PATCH 3/6] perf tools: Improve thread_stack__event()
 for trace begin / end
Message-ID: <20180920181352.GA9919@kernel.org>
References: <20180919112338.20347-1-adrian.hunter@intel.com>
 <20180919112338.20347-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919112338.20347-4-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 19, 2018 at 02:23:35PM +0300, Adrian Hunter escreveu:
> +		return thread_stack__push(thread->ts, ret_addr,
> +					  flags && PERF_IP_FLAG_TRACE_END);
> +	} else if (flags & PERF_IP_FLAG_TRACE_BEGIN) {

Some of the build containers caught this:

util/thread-stack.c:274:14: error: use of logical '&&' with constant operand [-Werror,-Wconstant-logical-operand]
                                          flags && PERF_IP_FLAG_TRACE_END);
                                                ^  ~~~~~~~~~~~~~~~~~~~~~~
util/thread-stack.c:274:14: note: use '&' for a bitwise operation
                                          flags && PERF_IP_FLAG_TRACE_END);
                                                ^~
                                                &
util/thread-stack.c:274:14: note: remove constant to silence this warning
                                          flags && PERF_IP_FLAG_TRACE_END);
                                               ~^~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.


--------------------------

Should be a '&' as suggested by: 

  16   146.45 debian:9                      : FAIL gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  17   138.35 debian:experimental           : FAIL gcc (Debian 8.2.0-4) 8.2.0


I'm changing this here, please Ack.

- Arnaldo
