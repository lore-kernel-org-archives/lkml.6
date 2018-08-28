Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4107CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAAF20868
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 00:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PBQaCfzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAAF20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeH1EdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 00:33:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45948 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbeH1EdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 00:33:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so353918pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 17:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YdbDGglFpCwrcv2ZqvHnff9kg7tCkxXd1PBNJKfUK7M=;
        b=PBQaCfzglIxpTp6Cqr2OdOdWQMZTETPDNnBblId7ErK6uU0bRCphGzXr/UPDPoWVfd
         dIOky5n5Gnb8JsJjtuDAP7E9OBRtR7xZmN951CyMLtye9TVCIU6QPERSjK/irvFsbdp/
         jBCEewKYP2xOJfiLMZ90yyLf8gsOqzE1yhD5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YdbDGglFpCwrcv2ZqvHnff9kg7tCkxXd1PBNJKfUK7M=;
        b=mz0FJv75pzRxoG4JE0AjPYGUOm63bTPM/KAz/snI/XLnCFBmE9+esVBct0oyT20YKB
         TkrcA0xVjOcyp6Hohp/X4GWD3WWfisPdxPw1Q6NwdU5/fzgNBWcGZjgt+RdeOe6NY4bW
         r/AEjBofKeBzzQ6lOcYsicaeLbwT0vZl77JzJS1SnvicXgCnzSXuNAIXgWkrFeid9wcI
         QIViIG4FHF7UJts7NFfWIGHbugPwaGpbJY7rENTPzkVrIzSuxE8wDACMsr2ISk1y1TTF
         BoHmIZna4/xcpfWIsiv9YM26gvnsKEUakA6V3YSKkLvWlI5MMz6HzTxxrYRhdudrSM+Z
         xYAg==
X-Gm-Message-State: APzg51Ak0isWcifooKIigqfOsfteGsjvY9T7+/Zdn58h/NdyrbA9Qpyo
        /u4dKeiw9I9xNp5brfGjilyKCQ==
X-Google-Smtp-Source: ANB0VdbTiwS2pIabR3I3q9nvVhDAb+ulfZIgooxgd8X9D5fuOC452pTLenrY8sVsiy9nmQWxkVMRiQ==
X-Received: by 2002:a63:4e25:: with SMTP id c37-v6mr14157140pgb.6.1535417063632;
        Mon, 27 Aug 2018 17:44:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id d22-v6sm730906pfm.48.2018.08.27.17.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 17:44:23 -0700 (PDT)
Date:   Mon, 27 Aug 2018 17:44:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ohad@wizery.com, mark.rutland@arm.com, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH v2 3/6] dt-bindings: remoteproc: Remove additional
 definition tag
Message-ID: <20180828004422.GZ160295@google.com>
References: <20180824131900.5353-1-sibis@codeaurora.org>
 <20180824131900.5353-4-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180824131900.5353-4-sibis@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

Subject: dt-bindings: remoteproc: Remove additional definition tag

nit: the subject is a bit generic, you probably should at least add
'qcom: ' to the 'path'.

On Fri, Aug 24, 2018 at 06:48:57PM +0530, Sibi Sankar wrote:
> Remove the additional definition tag declared for WCSS sub-system
> under reset-names.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> index 601dd9f389aa..c45e4c131fa2 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
> @@ -58,7 +58,7 @@ on the Qualcomm Hexagon core.
>  	Usage: required
>  	Value type: <stringlist>
>  	Definition: must be "mss_restart" for the modem sub-system
> -	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
> +		    must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
>  		    for the wcss syb-system

Since you are already at it you might also want to fix the typo in
'wcss syb-system'.

Other than the nits:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
