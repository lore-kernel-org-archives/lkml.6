Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KrJDDa9RGVsWEQAAmS7hNA
	; Thu, 07 Jun 2018 15:45:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D3C2C6089E; Thu,  7 Jun 2018 15:45:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="FGEp0fNA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 56534601B4;
	Thu,  7 Jun 2018 15:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56534601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934619AbeFGPp0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:45:26 -0400
Received: from one.firstfloor.org ([193.170.194.197]:57172 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933756AbeFGPpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:45:24 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 78FF986874; Thu,  7 Jun 2018 17:45:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1528386322;
        bh=Hv/VRsV+x5mV52wIs260++TgfF77Mi/dybxEbSOFM18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGEp0fNAmpwbYam4T9opVmwKoVCo3tAKPi6h49yrFN41E4x0TaobAhFJAFtFqFsco
         rl3AygAnFTFMDpsWS1so2zdebajQ/t1n+P1CW51EFqebNqqq3ha0xqLVNaz2RkQ03L
         Pa3cizdMVc1ubHDl7Zz4BtHRvet3Ani0EGeyKct4=
Date: Thu, 7 Jun 2018 08:45:22 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 09/10] perf/cputime: Don't stop idle tick if there's live
 cputime event
Message-ID: <20180607154522.hyjmxn3q6zgcvsnx@two.firstfloor.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
 <20180606221513.11302-10-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606221513.11302-10-jolsa@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 12:15:12AM +0200, Jiri Olsa wrote:
> Disable stopping of the idle tick when having live cputime
> event. When the tick is disabled, the idle counts are out
> of date until next tick/update and perf cputime PMU provides
> misleading counts.

I really don't like this. This can totally change performance
(e.g. less Turbo due to less idle) and performance tools shouldn't
change the performance profile drastically.

-Andi
