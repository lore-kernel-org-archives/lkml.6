Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6475C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FD420840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SaqksBqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FD420840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeKIMOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:14:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52987 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbeKIMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:14:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so610393wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 18:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LXmm30i5UOZD3l+P9/5HOpMFPZxGHqhkK+tBkC4KKzs=;
        b=SaqksBqCCUyknsy8pVhdC03J+FmjW2F66B/QWsIgCNZg/oyNg61/njf2Dddlw9H0XC
         E1Ho5m6pqax6OCpMZVtjKbkN6uStW4qwBwz0hjyr1vbDKBRWVEBw68f+hG4H5o/wNfbz
         wiY8OmWXnDaUezfXWHG5LXRaJ9WU2rCeeSVRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LXmm30i5UOZD3l+P9/5HOpMFPZxGHqhkK+tBkC4KKzs=;
        b=tFMp073OvbptbvaBkYYQD1Fn1GDNVO2c8OMk54cPpyncGi2BofKmD9MIbxa/tJPabE
         Db3a+4adzWBFNTE5hg6J3sPPJeuciZ/wxXqTq3cn4Zc/Llq2NaRmfoBeOlcimkr+MFdD
         Or3G2clkBm252ax5+5xgHXCdkcW9k3Pi7xgkax5CXzgIdbEthY/7gd1cNz9LPrjS6NkX
         9r705mkuvlTe//CkaBEUNUtxhO51r8m00103BTP9fekRF1RNrNR5AY/31Xx9nbKI0hp8
         LhHNpVK7eMnj7YzwzWv48TuyUdtfLMnDQ/4Cbpa1AknX4dHzD1c5HKFG8D0rjVrEKPoz
         Nybg==
X-Gm-Message-State: AGRZ1gJzthc7izjkvft97tAfqfZB+DeKBJ+Y3u1PdaiklyWFQNtYu+zX
        6dX1ADyuOhJbDNhhhB6d7viShQ==
X-Google-Smtp-Source: AJdET5fRhO8lIEalOeF0fYvraL7XtIwe4i45h/PrqR9Xdw22aY4/cMTrnGAuCR5WSVpOGlpkIDGANw==
X-Received: by 2002:a1c:cf08:: with SMTP id f8-v6mr3096698wmg.56.1541730945902;
        Thu, 08 Nov 2018 18:35:45 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id a4-v6sm3166376wrs.67.2018.11.08.18.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 18:35:44 -0800 (PST)
Date:   Fri, 9 Nov 2018 10:35:37 +0800
From:   leo.yan@linaro.org
To:     Robert Walker <robert.walker@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        CoreSight@lists.linaro.org
Subject: Re: [PATCH v4] perf: Support for Arm A32/T32 instruction sets in
 CoreSight trace
Message-ID: <20181109023537.GB4219@leoy-ThinkPad-X240s>
References: <1541588652-17380-1-git-send-email-robert.walker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541588652-17380-1-git-send-email-robert.walker@arm.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 11:04:12AM +0000, Robert Walker wrote:
> This patch adds support for generating instruction samples from trace of
> AArch32 programs using the A32 and T32 instruction sets.
> 
> T32 has variable 2 or 4 byte instruction size, so the conversion between
> addresses and instruction counts requires extra information from the trace
> decoder, requiring version 0.10.0 of OpenCSD.  A check for the OpenCSD
> library version has been added to the feature check for OpenCSD.

I have applied this patch on latest mainline kernel and tested for
A64/A32/T32 insntructions.

Tested-by: Leo Yan <leo.yan@linaro.org>
