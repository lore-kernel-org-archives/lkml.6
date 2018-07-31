Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB08C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AC0208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaEPcBxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AC0208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732444AbeGaQ2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:28:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43944 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732309AbeGaQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:28:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so16961903wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JX1rFIkxl/qfmgj+om/gyrq8vcJeEApGMk7zMDnxm6k=;
        b=YaEPcBxlue8+izjRAUivrReNWG34VM1u5qAntmRD3KS4m2BiibvpiHpsFULk17BeSU
         IxK5YKoHZ7uG0jRc4fq6xn026dGwnpoohCzCmrD8IwvHljN9xJRxxyMXZ5E8iBI9inko
         VrfDDyOkcFqi4Eu6/d0KRrcyirenqSr/wMd8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JX1rFIkxl/qfmgj+om/gyrq8vcJeEApGMk7zMDnxm6k=;
        b=nxFEb0lJzYSlo4iEG+9VuM2/VLVEX2x4RE2yeUB7RRuS87n5xAR1EToXVPmhn7eZEY
         VtmcKYCvOO9iwoa3ts29sc1ilA65Xb4OTPLLHWiFMB6hLa/wawq2eWbhymgSA3eVeeTN
         LkS4nKIPBgPM94B1TEz+JrU9YDZOamz+O+Ew7LRSiBVOxcvmJJjfNPjlR+2VTBhYH3mA
         eT6atfZ/AHjR1HXKPojTuVl6fKGyoQYgvSUqw5DiXHwrPEPZZXKOtEmXm/HRrIaCL40y
         2xSGGbJgb5fp/64tpI71a7U0E8QO+rgYoDlWQknTSLVB+U5NJeiWZXDLc65gTgMGsj/a
         9jrw==
X-Gm-Message-State: AOUpUlFH/+r0r/Tufkc+gLGe0jiha1DXPafEBeYUMwnU8ftsHaqNRYuh
        jdYIsK3V6wf7WjApH70HBaw9mQ==
X-Google-Smtp-Source: AAOMgpdsYRcMx2zzp6TbnkW3eNE/dhE6qGpGBWu59aJH/gEh+41aKMqxokDbd1b3x2TqjFjhHHdBuQ==
X-Received: by 2002:adf:bc03:: with SMTP id s3-v6mr22337546wrg.211.1533048478506;
        Tue, 31 Jul 2018 07:47:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id u185-v6sm3271006wmg.25.2018.07.31.07.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 07:47:57 -0700 (PDT)
Date:   Tue, 31 Jul 2018 22:47:43 +0800
From:   leo.yan@linaro.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
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
Message-ID: <20180731144743.GA16484@leoy-ThinkPad-X240s>
References: <1531295145-596-1-git-send-email-leo.yan@linaro.org>
 <20180723013507.GA27713@leoy-ThinkPad-X240s>
 <20180731142445.GB4909@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731142445.GB4909@kernel.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:24:45AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 23, 2018 at 09:35:07AM +0800, leo.yan@linaro.org escreveu:
> > Hi Arnaldo,
> > 
> > On Wed, Jul 11, 2018 at 03:45:39PM +0800, Leo Yan wrote:
> > 
> > Just want to confirm, I saw the first two patches in this serise have
> > been merged into perf/core branch [1], but the last 4 patches are
> > missed.
> > 
> > Could I know if you have trouble when you apply them?  Or anything
> > need me to follow up?  Otherwise you might miss them :)
> 
> Just this reminder was enough, checked that it has Mathieu's reviewed-by
> tags, applied, will go thru my cross build containers, hopefully all
> will test build ok and then it'll go to Ingo's direction.

Cool!  Thanks a lot, Arnaldo.
