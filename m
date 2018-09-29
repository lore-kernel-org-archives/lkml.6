Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6071C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828872084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiT22jiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828872084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeI2OGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:06:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33335 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeI2OGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:06:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id r1-v6so3266016wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3xWJbrkAwQbOZ2fSmdDqusZU/qJkPqi6CfB3i3athyA=;
        b=OiT22jiXxdL5R2H0l8lsuBXAoGanTppaIxFEECS4X4dyhtkxTylYLqPX1Zxqmjthst
         O3DHKFvr/dQdwh0JE3K8gjEgdagvnMP2eFHEQZcmJTznpwmBG5SZuhaGmpk1XFfwd5sG
         kHH+y9HSn2ug65nQtk50R6NtXhcxWTC1TNIqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3xWJbrkAwQbOZ2fSmdDqusZU/qJkPqi6CfB3i3athyA=;
        b=hBR1bbHx8g92AUrXEyyGLa/EYBo8ItEEp6J7lHzYF4cxtBMVc8e6uej7YmN0R3roRH
         SkgHneNDoZ09+tMV7morwQCQs40cL8+3Wk57BKBwByh/dFcIADXAT4YohJ92q3CAOye4
         hkU+J0D/iEGz4LZCsoVyjllKU9IRcPn+jfGgUsSy0Ll1r/YA+dfNW1GDEjsvFx3swPmh
         X1UvVBMBWkeYyypmbGu54T6d9DeWfoScfgyUn6C65k5psV9ySDMCybIH5G3/PhxZHG5r
         +9MxqacFOSBXBNZRkKRj61OA4WX1SSaNZhLvEbmDQFyepvbIX5AnxIloGMIkmIrdS9a8
         ot2g==
X-Gm-Message-State: ABuFfogU/0zRenvmRuRjwk4btC9clPWIhoUzrIYu4oRPRNhZWD0NMSKx
        MR3JhZ393UZZ1yJPIMdReMB0Sum878ysJw==
X-Google-Smtp-Source: ACcGV63qM9EHqYUlm7GBh6Ly+QroXFaT54YGetDM3ANuhH2wrhBj1/UgolTIABfvpikUM7OANZGH5g==
X-Received: by 2002:a1c:d00c:: with SMTP id h12-v6mr3627290wmg.107.1538206751606;
        Sat, 29 Sep 2018 00:39:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id r140-v6sm5064027wmd.7.2018.09.29.00.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 00:39:10 -0700 (PDT)
Date:   Sat, 29 Sep 2018 15:39:03 +0800
From:   leo.yan@linaro.org
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 3/5] tools, perf, script: Add --call-trace and
 --call-ret-trace
Message-ID: <20180929073903.GB4089@leoy-ThinkPad-X240s>
References: <20180920180540.14039-1-andi@firstfloor.org>
 <20180920180540.14039-4-andi@firstfloor.org>
 <20180928102331.GA15533@leoy-ThinkPad-X240s>
 <20180928171944.sdejhgyqka4p3kc3@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928171944.sdejhgyqka4p3kc3@two.firstfloor.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:19:44AM -0700, Andi Kleen wrote:
> > Seems to me, these two features are _NOT_ only benefit for intel_pt,
> > other hardware tracing (e.g. Arm CoreSight) can enable these features
> > as well.  This patch is to document only for intel_pt, later if we
> > enable this feature on Arm platform we need to change the doc;
> > alternatively we can use more general description for these two options
> > at the first place.  How about you think for this?
> 
> Likely it already works for CoreSight

I think Kim played with this patch series and he also pointed me for
this series.

> I specified intel_pt, because if we just say traces the users won't
> know what PMU to specify for record. Being too abstract is
> often not helpful.
> 
> If someone successfully tests it on CoreSight they could submit
> a patch to the documentation to add "or <coresightpmu>" to these
> two cases. That would make it then clear for those users too.

Okay, agree.

Actually I applied your patch series v6 on the perf latest core branch
and tested on Arm Juno board, I observed there have couple issues, one
is CoreSight trace data doesn't support timestamp so I need to use
'-F,-time' to workaround the command failure; another issue is now
CoreSight is absent to set sample flags so perf fails to resolve
symbols [1]; these two issues are only related with CoreSight decoder
and it's no matter with this patch, so I didn't mention in my previous
replying.

I need a bit more time to work out more formal CoreSight fixing patches
and will send for reviewing (also will include one patch to clarifying
Arm Coresight support in doc as suggested).

Thanks,
Leo Yan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/builtin-script.c?h=perf/core#n1128
