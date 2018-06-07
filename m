Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YQZtKr6AGVtPAgAAmS7hNA
	; Thu, 07 Jun 2018 19:00:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 37630608B8; Thu,  7 Jun 2018 19:00:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvNRToF7"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B5D06601C3;
	Thu,  7 Jun 2018 19:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5D06601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753696AbeFGTAe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753561AbeFGTAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:00:32 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02D6D2089C;
        Thu,  7 Jun 2018 19:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528398032;
        bh=BQMc5sMqMKztIbFDCNkEdoG6LWICUUd74SuCF05sNUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvNRToF7/wXsTnUqE/KukOWgJRckDjSGsLeZ2wccmIFbeuBFmoDuaYrKzZVL9F56Y
         CjLy6GRNsIinQ/3UB1emJb8suuVKoMBA4fMR2ckyVpPJKd6rfYUuMdpRjuBIYMf0Gk
         ZJSFw2ScGwa5/yAcRTpTY/EZKIgpa8Swz9bgTkHw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id E0FF91468B9; Thu,  7 Jun 2018 16:00:29 -0300 (-03)
Date: Thu, 7 Jun 2018 16:00:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 05/10] perf stat: Fix metric column display
Message-ID: <20180607190029.GD17292@kernel.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
 <20180606221513.11302-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606221513.11302-6-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 07, 2018 at 12:15:08AM +0200, Jiri Olsa escreveu:
> Make the metric only display aligned.
> 
> Before:
>   # perf stat --topdown -I 1000
>   #           time core         cpus retiring             bad speculation      frontend bound       backend bound
>        1.000394323 S0-C0           2     37.4%               12.0%               31.4%               19.2%
>        1.000394323 S0-C1           2     25.1%                9.2%               43.8%               21.9%
>        2.001521204 S0-C0           2     36.4%               11.4%               32.4%               19.8%
>        2.001521204 S0-C1           2     26.2%                9.4%               43.1%               21.3%
>        3.001930208 S0-C0           2     35.1%               10.7%               33.6%               20.6%
>        3.001930208 S0-C1           2     28.9%               10.0%               40.0%               21.1%
> 
> After:
>   # perf stat --topdown -I 1000
>   #           time core         cpus             retiring      bad speculation       frontend bound        backend bound
>        1.000303722 S0-C0           2                34.2%                 7.6%                34.2%                24.0%
>        1.000303722 S0-C1           2                33.1%                 6.4%                36.9%                23.6%
>        2.001281055 S0-C0           2                34.6%                 6.7%                36.8%                21.8%
>        2.001281055 S0-C1           2                32.8%                 7.1%                38.1%                22.0%
>        3.001546080 S0-C0           2                39.3%                 5.5%                32.7%                22.5%
>        3.001546080 S0-C1           2                37.8%                 6.0%                33.1%                23.1%

Thanks, tested, applied.

- Arnaldo
