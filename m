Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730A2C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EA92075B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 01:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJi7MzSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EA92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbeGWCd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 22:33:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40068 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbeGWCd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 22:33:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id t6-v6so16235134wrn.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 18:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gayCgd6wX2rNZR9vVqGhxPy7GP/Yo6ZBqdeaCCgkTGo=;
        b=hJi7MzSps7A9Q3smUdX9GKSCT5kCYABDSNFlPrdhMJ8LSp6Il9K4U6hm4gKHfa4aag
         an4WUntvLXtQgOp8RL44ZU0ZXl9NTYdTwwZHs1XFhmupkWhUoQ8Bi9hztpPojzRM9ZAi
         dTbDWNRMa+Lw4SFrPEvinPNHpTy4MO4yZS5gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gayCgd6wX2rNZR9vVqGhxPy7GP/Yo6ZBqdeaCCgkTGo=;
        b=A0XbCetZf7MJ2+SDqsEpfzUg3No6BmyIWPTwCmqUwBGwHHeFr+mYM5YO9oBRU6KB4Q
         DPNot2VAsBpo3wpH+2VjG70Jm5ZhtlM8gUuEkOLCXH0Ta4aaxldCLVq/kNLXPyfTbWUp
         K3n9PJ/beo61bo9sNsjJbbgIx7B4rUQkaFeJ/eW/I9syvHUOgQTdkxa97EDiGekvNZBG
         gJ1odxKteKVbbMm9i6LZJYvLP5p2lAouypCa4y3LPLr5+b+F532kB0ButJ20DnDN7ODQ
         dudQtlZOQ6tKaz+qc/NUDGJhy8CVShNbhRk2TOQT3iMjEKtjz5ntVHjHIKmJ+GHq7rw8
         fR4g==
X-Gm-Message-State: AOUpUlHmRxXaj70gLKN0xd3X4yIvHXn9r/kbIsAtliGERFMH70L9RBAV
        frZIPFkkLAVR59DkEzcC5BhZCg==
X-Google-Smtp-Source: AAOMgpf6+NyG5E/NoRSmeL60FYYhhMmHWzAYoHWm23/6xRWNnFTJzO1BExdSwrnCVQz+V86JHZs+9A==
X-Received: by 2002:adf:bbd4:: with SMTP id z20-v6mr7260629wrg.183.1532309715447;
        Sun, 22 Jul 2018 18:35:15 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id w4-v6sm6151377wrt.40.2018.07.22.18.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 18:35:14 -0700 (PDT)
Date:   Mon, 23 Jul 2018 09:35:07 +0800
From:   leo.yan@linaro.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH v2 0/6] perf cs-etm: Fix tracing packet handling and
 minor refactoring
Message-ID: <20180723013507.GA27713@leoy-ThinkPad-X240s>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Jul 11, 2018 at 03:45:39PM +0800, Leo Yan wrote:

Just want to confirm, I saw the first two patches in this serise have
been merged into perf/core branch [1], but the last 4 patches are
missed.

Could I know if you have trouble when you apply them?  Or anything
need me to follow up?  Otherwise you might miss them :)

Thanks,
Leo Yan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core

> Leo Yan (6):
>   perf cs-etm: Introduce invalid address macro
>   perf cs-etm: Bail out immediately for instruction sample failure
>   perf cs-etm: Fix start tracing packet handling
>   perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
>   perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON
>     packet
>   perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet
> 
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
>  tools/perf/util/cs-etm.c                        | 71 +++++++++++++++++++++----
>  3 files changed, 68 insertions(+), 14 deletions(-)
> 
> -- 
> 2.7.4
> 
