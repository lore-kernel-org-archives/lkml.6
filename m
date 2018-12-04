Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFABAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740C52146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gPfU2k/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740C52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLDF0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:26:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43026 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeLDF0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:26:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so7687550plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 21:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/nTLIgGseWOiQFnfJ2urYFhfk+Cnu3uIXaabzTdR4g0=;
        b=gPfU2k/T9XvE2bCzWh/EvSCqBUqc/RZAMXtLNvt+/eY1Q2Ju2Jhd4lTUugRp8VDLgm
         f1b+x9ozhbIsOWu098aqk7ITH2vkKqxrBhL+bl0dZx7MwWm2l47tINLfmzhpx99X/1gX
         PqCTtmRidntuQa2k3Fhq1x5zFZ3h8G6SK7bv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/nTLIgGseWOiQFnfJ2urYFhfk+Cnu3uIXaabzTdR4g0=;
        b=VlUEq0fc+KPxrHdrXERjb9wxQV6taGAoFQadLDe/kaeatACsZu2SjYX5aedxUC48tf
         DU8MBTAzKodIbsxFSW52iXfK8s1ML5y2GNdIkBMze4ck88JXqAxEmU3i+WCLFyXeMRoX
         3ouV45PunBfc2EjzlGrT/hHLi5En+YpvgN9+c1uBEcjo7CN1Mit9ypUxIp7IsEeLzDfH
         aEgvx5W2aLsf5R0W4X1u+cHrO+a7q1+6mVrEuAGYVF+rEKaPdmnWY7QYWyYpB1s9/5dV
         RdXkXa4JydjBOSt0gGnu/gtGACB4erijuZM6b1Sq/qZ7rHIpBFoZAzyVbQaY2ugPTSGm
         rJnQ==
X-Gm-Message-State: AA+aEWa91uucYEpspqcxwgBC7jyWJOIqPWA1aus/qWDIRR4bM7/AniTU
        KTnrsPDlvZqj7ZT6NZAUAGB0rA==
X-Google-Smtp-Source: AFSGD/USd2gi+wFlRoCufS6Pv5zNFyt8QgVHYDkuOvo7gqI+BL2XViE5YqDo/PMj3agyASisODeoQQ==
X-Received: by 2002:a17:902:4c85:: with SMTP id b5mr17914640ple.226.1543901203288;
        Mon, 03 Dec 2018 21:26:43 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id z62sm23509917pfi.4.2018.12.03.21.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 21:26:42 -0800 (PST)
Date:   Tue, 4 Dec 2018 10:56:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     robh@kernel.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 8/8] soc: qcom: rpmhpd: Mark mx as a parent for cx
Message-ID: <20181204052640.ix2tschgffhy3tp7@vireshk-i7>
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-9-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204052119.806-9-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-12-18, 10:51, Rajendra Nayak wrote:
> Specify the active + sleep and active-only MX power domains as
> the parents of the corresponding CX power domains. This will ensure that
> performance state requests on CX automatically generate equivalent requests
> on MX power domains.
> 
> This is used to enforce a requirement that exists for various
> hardware blocks on SDM845 that MX performance state >= CX performance
> state for a given operating frequency.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
> This patch is dependent on the series from
> Viresh [1] which adds support to propogate performance states across the
> power domain hierarchy which is still being reviewed.
> 
> [1] https://lkml.org/lkml/2018/11/26/333
> 
>  drivers/soc/qcom/rpmhpd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
