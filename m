Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A58EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5232A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZ9+SmRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5232A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030330AbeFSRqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:46:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50944 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966706AbeFSRqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:46:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so1769152wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mnDocBGrNeqamPyawGilKONTZ8iPB/knSpT49vpqSL8=;
        b=OZ9+SmRtWSf4idihK1PMh3e0G2gt0kIkFmOF548gAWqqFIt00h3PLgKXxaQ7MbD9Fe
         XCx03on/EcOSW3DZ2pyPi0wxmGHM+UZUlgUUHx0IVdjIUv6IUPhAZE38TOttLEy/igRi
         Cn+Wg46QK1fpyHx5b/EUSJtis0uSnlQXzkeWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mnDocBGrNeqamPyawGilKONTZ8iPB/knSpT49vpqSL8=;
        b=nSzgeoPtTSSeclcAuEGGeKNgLIkP1Il6EIT+0nUz/OXH6x2tziS+dNNp5hiM4iJ5e8
         Ae4Q67YZBtJPFYLHxm1l/I903EgjRcps0OY3BIFWJ44PXP4Vmj7apT8gzNjsiWnbocJq
         ooIyAMQIR+620L8Kx628sNzvLZ58ZupVXvr5UwADhLSMju3Dle4tblFUKyiObGDeMA9W
         Zr7mo+HOpYGH2yWVx53MlqJQ1a2TUvl+8OLab2J/eke8GCOUMP3Qwiuj+ixavJ5y+Aa7
         JPZ4Lu3wmmvbfR4Z7thuSB42xCL2ENywdLkfX5blYuHDpwkLc2J0aR9DndFmmAa2fSAa
         /Yjg==
X-Gm-Message-State: APt69E2ysFlGXLjxNuui3pRcHiUk2A8WnUWaogK/rTTtDGL34trUfsU7
        0DuIN7RIfRaWLJEa9oKs0JDxSAuqN4jN8N+3VhNuzupZ
X-Google-Smtp-Source: ADUXVKLAIYe2mgMW2p3YxINBluy27/lGcRITouQS4FrapzeZ7A92qGPU9BE820iY0VzOQXQdHQ2gQeBiUhBuHgoXiyc=
X-Received: by 2002:a50:b376:: with SMTP id r51-v6mr15687199edd.145.1529430373413;
 Tue, 19 Jun 2018 10:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
In-Reply-To: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 19 Jun 2018 11:46:02 -0600
Message-ID: <CANLsYkyxuz+tPrC7wb1omsw+qj=7ZB5t6FRbqZz54994g62q6g@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] perf cs-etm: Fix tracing packet handling and minor refactoring
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2018 at 23:10, Leo Yan <leo.yan@linaro.org> wrote:
>
> Due the current code is missing to handle cs-etm start tracing packet
> and CS_ETM_TRACE_ON packet, we fail to generate branch sample for them.
>
> This patch series is to fix cs-etm tracing packet handling:
>
> Patch 0001 is to add invalid address macro for readable coding;
>
> Patch 0002 is one minor fixing to return error code for instruction
> sample failure;
>
> Patches 0003~0006 are fixing patches for start tracing packet
> and CS_ETM_TRACE_ON packet.
>
> This patch series is applied on acme tree [1] on branch perf/core with
> latest commit: e238cf2e3d2e ("perf intel-pt: Fix packet decoding of CYC
> packets").  Also applied successfully this patch series on Linus tree
> on 4.18-rc1.
>
> This patch series has been verified on Hikey620 platform with below two
> commands:
> perf script --itrace=i10000il128 -F cpu,event,ip,addr,sym -k ./vmlinux
> perf script -F cpu,event,ip,addr,sym -k ./vmlinux
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
>
>
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

Good day Arnaldo,

I am good with this set:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Please consider for inclusion in your tree if you are satisfied with the work.

Regards,
Mathieu

>
> --
> 2.7.4
>
