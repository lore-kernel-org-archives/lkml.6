Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E1AC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 17:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD791206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 17:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LO9vwx2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD791206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeI3XmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 19:42:20 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41667 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbeI3XmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 19:42:19 -0400
Received: by mail-yb1-f194.google.com with SMTP id d14-v6so4667747ybs.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6CQNURMYAT7I1fWXPU3pC/e50rp/jv2fWdgEqarYD/8=;
        b=LO9vwx2d8xoRY/WWFNcI3PUsw84pjIN+fACo++nowB5K7y248a+YNURNY7gSIl3Dez
         loAOor7q0kYo6UaKzYfSlaG6UbKQYuBwKgXGXvFPPuK2llm3ZMGUpe3mPpJf79rf8xew
         IdMOFE626K9EHN0hMxMkPOY9FVvBtB46FfAP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6CQNURMYAT7I1fWXPU3pC/e50rp/jv2fWdgEqarYD/8=;
        b=TBvq3QvEXxhVOQRVvdbg+LiPz3kYXjO49W2hIZYp+kimKZIU5/srGEkt1uSrNWJ+TX
         fUgTC4+XJp24Ds/9L+jm1iSqiUEe/NQmDKJ35pnYspVB/7QUNkJ8JViGYx+R54ScTbZ0
         SduYWXZD+QY0M4AURsk1kHI6azlcREju0BRlql0LfHNdsh+EZElLOqZltAVWeU36IAsZ
         9M349+f0DQBBtMmszo1YTZeLFId7jlhqlMu7fa56mehFU0+0JWi01SfXKBKDEgSKQ5B1
         cYxJgVQPSaYSpjA8EYTt2u9OUUfK5vzs3SqCw00kGGORhIK3PXqWlZxVPJAvNMbbQ2Jq
         D+Rg==
X-Gm-Message-State: ABuFfohoRsFCfImBS7+j1/OjSGL9zfLoHgvkmoQuC9FGliswNxKYiYHi
        TVnCMHoZcvJ/1rXSfM2VdeoYlQ==
X-Google-Smtp-Source: ACcGV61TlOprfCSaW/Okkd6EwUZs8qMuvHFUNcFGmGRtT/ZPvyJFLpqw3RlC2bUDAT6+/s6t8EaPOA==
X-Received: by 2002:a25:cec9:: with SMTP id x192-v6mr4168122ybe.319.1538327309379;
        Sun, 30 Sep 2018 10:08:29 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:b19b:8662:2992:bdd8])
        by smtp.gmail.com with ESMTPSA id w201-v6sm1346247ywa.79.2018.09.30.10.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 10:08:28 -0700 (PDT)
Date:   Sun, 30 Sep 2018 12:08:26 -0500
From:   Andy Gross <andy.gross@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-soc@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        David Brown <david.brown@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        Qiang Zhao <qiang.zhao@nxp.com>
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
Message-ID: <20180930170826.GA2955@hector.attlocal.net>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:52:44PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Andy Gross <andy.gross@linaro.org>
