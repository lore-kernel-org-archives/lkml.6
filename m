Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB92C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9065F20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gx2T63Ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9065F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbeKGMw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:52:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36895 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeKGMw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:52:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id o15-v6so12181383wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 19:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ImL7x6tAbC9KafSE4YGoOInmvHYlXGIZ1JlveBOmkbo=;
        b=Gx2T63CkCd4Maku8kUN6V1oVH90ojCVFPO2hCUFg4qVkMMHQaLFC5349fBRm7T8W/D
         R8HyEgqzTPVa29hWvf4mURAlnKUS82pjmAXmyVZ6uDXTj8V1fLN4kS++Td9AF2aIZ+OI
         H0BwgFI9L+Vi5ZyYQG4gLzflH59U6VFH6KKiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ImL7x6tAbC9KafSE4YGoOInmvHYlXGIZ1JlveBOmkbo=;
        b=hNWuZReNI7A0EHrV2SRnKIDvJhc08nLdCCt8zMT70ZaA9qfD95MZBzUCVSktUlJMjy
         nUOepaVcPMnEKKVcLkfmKOO8vlgeDqQc88kpHweCb7HnrYQAPRCRI7rLujv+oQi9NPw7
         vXIhU2mG+M5wENFyFAtXLFHfD4VDHon8zekdhevRVYY0ubUXVqhQJSlFWURYSG/kapRV
         l9w4IFN06AAguJQMGrMwMrsujZfH8vUO/vL3Zu8lGgvuWQkGjp3SfLFix8VbVSkbphW3
         ZUVF7Z6zFnlS+GsAfF0BBO6fw4Ib41u6tmjzJXznLK/82KdZQsQt/RRYjgJmwDoiiPBP
         DMEg==
X-Gm-Message-State: AGRZ1gKHH/13bIWI5RTc47Vda9ltFFDMoy2fPqX9xBmH8bNXWrWh7xDe
        WqGd9vfE8bnEaGnBiKsP0EgGDDW1h7mOxX2R
X-Google-Smtp-Source: AJdET5fiTiis53kSEaAk1z8IliT+bpKigFJzMlWqMcVYRvsRChtzijxYxA4H7IXwzRjZxYY6Xz64Mw==
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr153001wrw.136.1541561038168;
        Tue, 06 Nov 2018 19:23:58 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id t198-v6sm6187002wmd.9.2018.11.06.19.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 19:23:57 -0800 (PST)
Date:   Wed, 7 Nov 2018 11:23:50 +0800
From:   leo.yan@linaro.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] coresight: etm3x: Release CLAIM tag when operated
 from perf
Message-ID: <20181107032350.GH3983@leoy-ThinkPad-X240s>
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
 <1541456790-28282-4-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541456790-28282-4-git-send-email-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Mon, Nov 05, 2018 at 03:26:30PM -0700, Mathieu Poirier wrote:
> This patch deals with the release of the CLAIM tag when the ETM is
> operated from perf.  Otherwise the tag is left asserted and subsequent
> requests to use the device fail.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index fd5c4cca7db5..000796394662 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -603,6 +603,8 @@ static void etm_disable_perf(struct coresight_device *csdev)
>  	 */
>  	etm_set_pwrdwn(drvdata);
>  
> +	coresight_disclaim_device_unlocked(drvdata->base);
> +

Just remind, this isn't consistent with the sequency in function
etm_disable_hw(), which has the reversed sequence between
etm_set_pwrdwn() and coresight_disclaim_device_unlocked().

Not sure which one sequence is more suitable, at the first glance,
accessing register after pwrdwn related operation might have risk for
deadlock?

Thanks,
Leo Yan

>  	CS_LOCK(drvdata->base);
>  }
>  
> -- 
> 2.7.4
> 
