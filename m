Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0414CC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51CE20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7WRkS09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51CE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeLLSp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:45:57 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50296 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbeLLSp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:45:57 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so10647889iti.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4w6cnngQONcEaZHQonIAO2XA4e1xiIW1455RBSKyJcE=;
        b=J7WRkS09oZNB+d4IyMaq4Qou01ZZX4URlAAGzAEDNhnNtMP93BRafpxN7hWcAQB161
         G4cs+UhUa6UIdFX+8kwNT04A+2eS+X4h6agFPqR5bQE7Sl8N9Dom78xhZFslfxbo2jnm
         XIgyk/oc5XAHNEMW/9oQe8nvg13DhofbCB/Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4w6cnngQONcEaZHQonIAO2XA4e1xiIW1455RBSKyJcE=;
        b=kZOaaay4QyQdz77NBxvPsKIg+stpg5dEZsc+LMPJ0Vq95a6zotduYJ+BYbSIpy8NVV
         9yN6PKe2rTFPamU3RL9j5a3asAKYzsiuSlPvGTxyV/E5WxMEQHuK2vUkhqL4AxmxEF3y
         lLWXgXiUuOxngUt9B38YvuFFwtVHh8PDt/sQjB+APYS7N7uhvzGwkti4FrPzNX5Hwfjn
         NNINsuSQca9w4JpQZLA7bGYM1pDmdNUUdVizddXhSJA25NO1zuddbYt0bJfUsE81IPIK
         Ko0tqij7msO2jMK0e8+h1pHy+vxI3cYY74rzWyTcmrIJfHqNI5NIBrLvcFCqb4YSGFlP
         Sj4A==
X-Gm-Message-State: AA+aEWY3KQPZ93hNBYD5NXJ8Qn7EpGD1Nb8NeLSdqKLhAkmp9GbNYTkH
        7igdytIujwtllDg5ya1uCJ33J5OVVlDh9IZAUcPS+w==
X-Google-Smtp-Source: AFSGD/X8rJE4ZgFQiaR8ze20bK2wBuLiuYIfCz9IO+oVXyUfiRLeeBA2/vemQeGax0qqddvlGSLEiaDo90PzbetlcuQ=
X-Received: by 2002:a05:660c:34f:: with SMTP id b15mr7137137itl.146.1544640355933;
 Wed, 12 Dec 2018 10:45:55 -0800 (PST)
MIME-Version: 1.0
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
In-Reply-To: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 12 Dec 2018 11:45:44 -0700
Message-ID: <CANLsYkyFZqUYghGmSS-j50EaOvce57CP+Y737xRF3HjPrHDVqw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] perf cs-etm: Correct packets handling
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 at 00:40, Leo Yan <leo.yan@linaro.org> wrote:
>
> perf cs-etm module converts decoder elements to packets and then we have
> more context crossing packets to generate synthenize samples, finally
> perf tool can faciliate samples for statistics and report the results.
>
> This patch series is to address several issues found related with
> packets handling and samples generation when worked firstly on branch
> sample flags support for Arm CoreSight trace data, so this patch series
> is dependency for sample flags setting, will send another dedicated
> patch series for sample flags later.
>
> In this patch series, the first two patches are mainly to fix issues in
> cs_etm__flush(): patch 0001 corrects packets swapping in cs_etm__flush()
> and this can fix the wrong branch sample caused by the missed packets
> swapping; patch 0002 is to fix the wrong samples generation with stale
> packets at the end of trace block.
>
> Patch 0003 and 0004 are for minor fixing; patch 0003 removes unused field
> 'cs_etm_decoder::trace_on', this can simplize the switch-case code for all
> discontinuity packet generation by using one code block; patch 0004 is to
> refactor enumeration cs_etm_sample_type.
>
> Patch 0005 is to rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY, we use
> a more general packet type to present trace discontinuity, so it can be
> used by TRACE_ON event, and also can be used by NO_SYNC and EO_TRACE
> elements.
>
> Patch 0006 is used to support NO_SYNC packet, otherwise the trace
> decoding cannot reflect the tracing discontinuity caused by NO_SYNC
> packet.
>
> Patch 0007 is used to support EO_TRACE packet, which also introduces
> the tracing discontinuity at the end of trace and we should save last
> trace data for it.
>
> Patch 0008 is used to generate branch sample for exception packets.
>
> Credit to Mike Leach and Robert Walker who made me clear for underlying
> mechanism for NO_SYNC/EO_TRACE elements, Mike also shared the detailed
> explanation for why we can treat NO_SYNC and TRACE_ON elements as the
> same, so except following Mike & Rob suggestion for trace discontinuity
> consolidation, most commit log of patches 0006/0007 also come from
> Mike's explanation.
>
> This patch series is applied directly on the acme's perf/core branch [1]
> with latest commit aaab25f03e9e ("perf trace: Allow selecting use the
> use of the ordered_events code").
>
> With applying the dependency patch, this patch series has been tested
> for branch samples dumping with below command on Juno board:
>
>   # perf script -F,-time,+ip,+sym,+dso,+addr,+symoff -k vmlinux

Good day Arnaldo,

I have reviewed all the changes in this set - please consider adding
to your next branch.  Let me know if you want a pull request.

Regards,
Mathieu

>
> Changes from v2:
> * Addressed Mathieu's comments and suggestions for minor refactoring
>   for removing unused field 'cs_etm_decoder::trace_on' and added one
>   dedicated patch to refactor enumeration cs_etm_sample_type.
> * Added Mathieu's 'reviewed' tags;  Very appreciate Mathieu's many
>   suggestion for crossing several patch series.
>
> Changes from v1:
> * Synced the consistent code in patch 0001 for condition checking.
> * Introduced new function cs_etm__end_block() for flushing packet
>   at the end of trace block.
> * Added new patch 0003 to rename CS_ETM_TRACE_ON to
>   CS_ETM_DISCONTINUITY.
> * Used the same one packet type CS_ETM_DISCONTINUITY for all
>   trace discontinuity (include support TRACE_ON/EO_TRACE/NO_SYNC
>   packets).
> * Removed tracking exception number patch, which will be added in
>   sample flag patch series.
>
>
> Leo Yan (8):
>   perf cs-etm: Correct packets swapping in cs_etm__flush()
>   perf cs-etm: Avoid stale branch samples when flush packet
>   perf cs-etm: Remove unused 'trace_on' in cs_etm_decoder
>   perf cs-etm: Refactor enumeration cs_etm_sample_type
>   perf cs-etm: Rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY
>   perf cs-etm: Treat NO_SYNC element as trace discontinuity
>   perf cs-etm: Treat EO_TRACE element as trace discontinuity
>   perf cs-etm: Generate branch sample for exception packet
>
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 42 +++++++++-----
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 10 ++--
>  tools/perf/util/cs-etm.c                        | 77 ++++++++++++++++++++++---
>  3 files changed, 100 insertions(+), 29 deletions(-)
>
> --
> 2.7.4
>
