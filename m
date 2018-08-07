Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F288FC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD2821757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyTsao16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD2821757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389652AbeHGQwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:52:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38218 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbeHGQwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:52:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so16023519wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b+iB/8EI3i1p728Kt6jArTWEKOAcPxcetnbvxk3lHD4=;
        b=iyTsao16wESuXsjzFhYFlSxQd8ZAloYG9aJ/E1WZFGnB07+Rwk0xeboHyaENXn70QA
         grpErOAGzHqhVJkXWHy7uB8JHFkqYt1ZHPiWwQI0xS22q3Vr5aBWC3Frjg7qQaitex+G
         a2+DQ/7IwbjXBYbbkOCKy/gNJZPvWCEy3t2Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b+iB/8EI3i1p728Kt6jArTWEKOAcPxcetnbvxk3lHD4=;
        b=BhHltfmoXSjUIxTbMOAel1a0Dx6Yk/hqAfKw80L8nEUETEayaTO+LynCPvKjqcGkdM
         b1v11wEZiP+ejhgNTKnvP2xF14ekvG7wFCfDIg10oo6bMoy1ekKsbDen9PyL9gKiUJZZ
         6PkDfUCA7gWKCXlIqj2BcJRB0uVMaz1D9JwBHjIOWlG8dMe3Hme35tVGDMctwWSOLZg1
         fgrUeg/XnnJ7DtwcezofJUztOdWIcilHntMs6blHsviPeaeCA5NYBpFqk1fFWzCnkckf
         V1LrxUCXWxrN8BNreouLIvQT+VmwcRNCyyeXbRd1cG3CUi4xzrYDcgeV/eeQN0tJlKSg
         RE+Q==
X-Gm-Message-State: AOUpUlG4mm2lJQszv7u7JT4dpIUPt0+hmGRljBWeYJKrNZ1EpfvE6/Rd
        PDq58FoQwAIJmns7Ah9kNvVcMQ==
X-Google-Smtp-Source: AAOMgpdnQ7tNj+R4j2VQLegII9cEPJIyJCqAvr4vSdc33SwosZzim/JPMOYXms+6DuOswLh1MojaxA==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr13387749wrq.61.1533652692978;
        Tue, 07 Aug 2018 07:38:12 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id i125-v6sm3255662wmd.23.2018.08.07.07.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 07:38:12 -0700 (PDT)
Date:   Tue, 7 Aug 2018 22:38:05 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Optimization CPU idle state impacted by tick
Message-ID: <20180807143805.GB6785@leoy-ThinkPad-X240s>
References: <1533652024-19078-1-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533652024-19078-1-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 10:27:02PM +0800, Leo Yan wrote:
> After Rafael's patch series 'sched/cpuidle: Idle loop rework' has been
> merged in mainline kernel, it perfectly resolved the Powernightmares
> issue [1] with not stopping the tick during the idle loop; we verified
> this patch series on Arm platform (96boards Hikey620 with octa CA53
> CPUs) with the rt-app [2] program to generate workloads: a single task
> with below combinded configurations with period 5ms and duty cycle
> 1%/3%/5%/10%/20%/30%/40%.

Oops, I missed the two reference links, for complete info so list here:

[1] https://tu-dresden.de/zih/forschung/ressourcen/dateien/projekte/haec/powernightmares.pdf?lang=en
[2] https://git.linaro.org/power/rt-app.git

Thanks,
Leo Yan
