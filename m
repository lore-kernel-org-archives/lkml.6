Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688E9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3236D20862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2pOX2/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3236D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbeKFAHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:07:42 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:50393 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKFAHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:07:42 -0500
Received: by mail-wm1-f54.google.com with SMTP id 124-v6so3713620wmw.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dqaJLLM2Uv9rjRy6dTULwVbagVHBNmf0kKByQF5wo0Q=;
        b=M2pOX2/c85kodXWTosqdCeihCn/y3jbBwHgos10BELzKxyg3tDnBMCZ3E4yt9EDSc+
         3y7d8nDUkqCGBp3O9kN8xmJj8HaBsh4G74xJ+U8zQOSHm49dQvEWrLJST9DX/dCFu8Kx
         bt+omX66Y79HFfOaUfAlaj/olqLD97/nTEpRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dqaJLLM2Uv9rjRy6dTULwVbagVHBNmf0kKByQF5wo0Q=;
        b=rIQ9qQfveq3ywpVcG1yIeEPg9+qYHug2H5s+T7flURHVa3EzoOBLvgNgG/+a3pbvRK
         IsLFjbFNq694hPG9zgQvlg4PM7/m3jU/9IDoXwtHPZKQdKwJIJH2uhVj7ns8gvrPBL/k
         FqMddheVAfRg2+Yu4UsWrmUmXYCpGSuSavYKTctV8W2iQGJxBulygoc2YLkPShJs4jjk
         ick9e5feirCCBLXCe2zvG3PSLSKr/19nVmy5O2H2Trx3jZo9gXvIIYOTdPpB0YW1zQ3c
         53mxmqVjEPdrlSW3DK7G2LL9JAWBjseogYpKa2BH3c3hGbwMS3grNUvrVI2bB9b+AzSU
         N+cA==
X-Gm-Message-State: AGRZ1gKAFniN655xCVR9yMO1ayWkL2XgPV/X/5Jee9KlkVT+dpn9tcu7
        hjG20tooQyNg1fAox+oXFH5ENrAY6ck=
X-Google-Smtp-Source: AJdET5c6C3tllr1pAilAUaaku5EHIhikvJd6cI8yleFkCcS2Kpp0+YphDCkB77umN13xyQ43WgL2Fw==
X-Received: by 2002:a1c:8197:: with SMTP id c145-v6mr6659842wmd.0.1541429256965;
        Mon, 05 Nov 2018 06:47:36 -0800 (PST)
Received: from [192.168.0.40] (119.151.136.77.rev.sfr.net. [77.136.151.119])
        by smtp.googlemail.com with ESMTPSA id t66-v6sm29433281wmt.5.2018.11.05.06.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 06:47:36 -0800 (PST)
Subject: Re: [PATCH] sched: Create task_has_idle_policy() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <ce3915d5b490fc81af926a3b6bfb775e7188e005.1541416894.git.viresh.kumar@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5fd19e86-fa5d-e179-47eb-aed4d9a62ab8@linaro.org>
Date:   Mon, 5 Nov 2018 15:47:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ce3915d5b490fc81af926a3b6bfb775e7188e005.1541416894.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 12:21, Viresh Kumar wrote:
> We already have task_has_rt_policy() and task_has_dl_policy() helpers,
> create task_has_idle_policy() as well and update sched core to start
> using it.
> 
> While at it, use task_has_dl_policy() at one more place.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

