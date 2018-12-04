Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089E0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAD22087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxO3AlJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAD22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbeLDFZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:25:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46527 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLDFZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:25:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so7678886ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 21:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zMjbNwai4X5aZOzNZudXvxQgZyFoEC0QJfTVp1MiBi8=;
        b=dxO3AlJSUCM5dyyBrRVxh0UvSAOBd6M9NLvMDfJVPefxNjlxbaVjddUnA8zzgs69gs
         PT1M5byVWdl0YW1UbOcm9cEeRRDVUr+PwqKeM6iLvRwagdc8tJIGO+0zvXSzAWRsZhL+
         7PUCRfgpj9k3YSjM9W8FhW0uupdgx9TZUsYYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zMjbNwai4X5aZOzNZudXvxQgZyFoEC0QJfTVp1MiBi8=;
        b=YSuIU7vFqBC/O+FEnAGLZ44Ui4OzRRxsJvb8WfFp9y1uvN3zwCiBoMuCKPDhxJXWco
         Ey2ziwmNAr+ZD0SmFJDXgaKtmn0Xt83RHliTQ9af5qGYt1je3E4/TcVR3uxGKD8A1zcV
         rX87ZYU7IRMVKr76xqpz7JALz7uH/H4HLiLXacOBhjE3AYemj3tqcKhJzKBKf4mlmJR1
         xejJ/zroXPwRBA3I33+p2FO11tFN9bs3tesU+RRuEJagbn+05JFLI0enHyphVEpSSbR8
         +NaszeVWh36z4gOrbMl74bGLfl5TKQaNWatVfvFZWeBSHt0bjTl3Z9ulNSV1VXi/pyCX
         lkmA==
X-Gm-Message-State: AA+aEWb/O3FVfLr8VuDJxSIC7AAoclKrOwKMyEDL5AANi6l6rcc1zKKu
        T7Lf2IVLMfSk9sa3zTbNX6U0zQ==
X-Google-Smtp-Source: AFSGD/XsprKJmjqmezQSeRibNlhH6yj7jFt1YCKe37l96Jla0hz7OKwpdm9PaiVHCSLTFZ+KQ70+ng==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr19032295pla.131.1543901156723;
        Mon, 03 Dec 2018 21:25:56 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id k15sm23912701pfb.147.2018.12.03.21.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 21:25:56 -0800 (PST)
Date:   Tue, 4 Dec 2018 10:55:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     robh@kernel.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/8] arm64: dts: sdm845: Add rpmh powercontroller node
Message-ID: <20181204052553.shutq6azgl2bqc5v@vireshk-i7>
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-8-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204052119.806-8-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-12-18, 10:51, Rajendra Nayak wrote:
> Add the DT node for the rpmhpd powercontroller.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 51 ++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
