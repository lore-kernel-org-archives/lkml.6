Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4998FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095C7224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGSMrb72"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095C7224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbeKMCbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:31:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbeKMCbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:31:25 -0500
Received: from jouet.infradead.org (d66-183-243-195.bchsia.telus.net [66.183.243.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A168F2241E;
        Mon, 12 Nov 2018 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542040645;
        bh=N7BMNsdZicdRqjC94IQ6YRaNnFZ2e2dDeQEuNOUUxQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGSMrb72SNu/1MXMR5JR1vZ8+lgQBMqop8rDbfnXtmHx4BjXgGWnlGXWiwUMT7oNz
         Juc/jfDglKpCcPMWqptnNu9hRIIdv9BKd/G65S645zMM2++U1UpnSrDQoohLOcgM25
         QkYAe3oxXeqlKZJ1zjoShuXzLZWK/NlqoHxVNOKw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 5A0F81443D0; Mon, 12 Nov 2018 08:37:20 -0800 (PST)
Date:   Mon, 12 Nov 2018 08:37:20 -0800
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Suppress potential format-truncation warning
 in util/pmu.c
Message-ID: <20181112163720.GE1111@kernel.org>
References: <20181111184524.fux4taownc6ndbx6@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111184524.fux4taownc6ndbx6@decadent.org.uk>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Nov 11, 2018 at 06:45:24PM +0000, Ben Hutchings escreveu:
> Depending on which functions are inlined in util/pmu.c, the
> snprintf() calls in perf_pmu__parse_{scale,unit,per_pkg,snapshot}()
> might trigger a warning:
> 
> util/pmu.c: In function 'pmu_aliases':
> util/pmu.c:178:31: error: '%s' directive output may be truncated writing up to 255 bytes into a region of size between 0 and 4095 [-Werror=format-truncation=]
>   snprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
>                                ^~
> 
> I found this when trying to build perf from Linux 3.16 with gcc 8.
> However I can reproduce the problem in mainline if I force
> __perf_pmu__new_alias() to be inlined.
> 
> Suppress this by using scnprintf() as has been done elsewhere in
> perf.

Thanks, applied.

- Arnaldo
