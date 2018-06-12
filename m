Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 80EDAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351BE2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 23:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TA856Y4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351BE2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934883AbeFLXZ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 19:25:28 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33417 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934281AbeFLXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 19:25:25 -0400
Received: by mail-pg0-f68.google.com with SMTP id e11-v6so309472pgq.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 16:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=lukR7qenh4FYNHATEfz8ProjHeaSBEIoaJcLAtovQm4=;
        b=TA856Y4lJsjNyUXoWreHgy/lDI54MviRlxV2Cjtl47nxhwAgLphpEG2GI0xvPkz8s1
         O5ClOH8RgabBogpq+1t/1sTmq27ILlV8zPQJxNepuzpBs5eyXma0GdEJkG310+dAU+xX
         sbC5OhW9nC4k2Su/mDi7/KNmblNXr3i/e3QY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=lukR7qenh4FYNHATEfz8ProjHeaSBEIoaJcLAtovQm4=;
        b=SMWltiK3PDz3RUYULA//+IZA9JRN+/qxXbmfGrbx2ldwPI9kzvi1Y3UCXZ0T5KshXm
         0ImWNOjiT/EtpAC/ub+gEhfmcHhUHVQKqUN8GU/7hHOqvg7HInmmukF+FseNvF+PuWHs
         gEs/50rhq61AnEHr1V/AR5EADksdXElgeRLU9CQpjbcYeW+FwjRQQjzutDd/EzAqHgX8
         M17lsKi75PXDyfLKEDpMVLlPWraLXJvDCfvFZs4MEkLLhhZ9yxNZCQN4DHlLmNttBxTb
         +Ng94hc3fFU2P2uBHwuOe04RodcnCO51tpEWjSaihR7CYzNrJCjM18myPx/4A5cNUPzt
         6AeQ==
X-Gm-Message-State: APt69E3Ut7Es/BCKcu+8nFbXfFcJx85i6fHo89pjcM13VSlF5UEapq1A
        GgY40KQImEwKdJ6ETxLObrWNxg==
X-Google-Smtp-Source: ADUXVKJbPyuUK+KdU3zEc2ADMggXHJufGWOQbN4jNwbrMy5e2nqH7MQbKu3MsERKb07xnkDU4lA6aA==
X-Received: by 2002:a65:6645:: with SMTP id z5-v6mr2025195pgv.43.1528845924692;
        Tue, 12 Jun 2018 16:25:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id d15-v6sm1230299pgu.66.2018.06.12.16.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 16:25:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vijay Viswanath <vviswana@codeaurora.org>, adrian.hunter@intel.com,
        mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1527587561-27448-5-git-send-email-vviswana@codeaurora.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        vviswana@codeaurora.org, bjorn.andersson@linaro.org,
        riteshh@codeaurora.org, vbadigan@codeaurora.org,
        dianders@google.com, sayalil@codeaurora.org
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-5-git-send-email-vviswana@codeaurora.org>
Message-ID: <152884592336.16708.2751337614926643627@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 4/4] mmc: host: Register changes for sdcc V5
Date:   Tue, 12 Jun 2018 16:25:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vijay Viswanath (2018-05-29 02:52:41)
> @@ -137,6 +125,12 @@
>  /* Timeout value to avoid infinite waiting for pwr_irq */
>  #define MSM_PWR_IRQ_TIMEOUT_MS 5000
>  =

> +#define MSM_HOST_READL(msm_host, host, offset) \
> +       msm_host->var_ops->msm_readl_relaxed(host, offset)
> +
> +#define MSM_HOST_WRITEL(msm_host, val, host, offset) \
> +       msm_host->var_ops->msm_writel_relaxed(val, host, offset)

Is there a reason these macros are capitalized? We don't have READL and
WRITEL macros in the kernel because function-like macros are typically
lowercase.

> +
>  struct sdhci_msm_offset {
>         u32 core_hc_mode;
>         u32 core_mci_data_cnt;
> @@ -268,6 +262,14 @@ struct sdhci_msm_host {
>         const struct sdhci_msm_offset *offset;
>  };
>  =

> +const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *=
host)

static?

> +{
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host =3D sdhci_pltfm_priv(pltfm_host);
> +
> +       return msm_host->offset;
> +}
> +
