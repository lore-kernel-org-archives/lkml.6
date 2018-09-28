Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30723C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3ED21528
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIumgnbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3ED21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbeI1UYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:24:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36366 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbeI1UYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:24:25 -0400
Received: by mail-lf1-f67.google.com with SMTP id v17-v6so5099408lfe.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PfS9hn2ETIY7Lc2efy3a6BRaviijwcRWt/Kxru3B74M=;
        b=PIumgnbtLvByGMoQZuQJMyk2HMKFwPFIqXKcEa/NvXt2t1Tvz7kQlc0f78IeYrRvRp
         yh0GrNt2+QQzGvR85kM0Auz3Q1qEv8VUxwqnaZjZFjyww1i/Gpy1ajWZuzJzmCwavz6S
         awfPTGrWIX0W2ITt/94/tG/EsEaDNhIDrgiWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PfS9hn2ETIY7Lc2efy3a6BRaviijwcRWt/Kxru3B74M=;
        b=mrwR5L5X4iajaWgnml4gla9GpJO3MA0yKoDdP3veLrtnI7OcPVEkvhDZF3qon4AWpg
         oxOnN5hvUAD3RkFY9YdSc3BGcXbrf6b1YeZKPr5433N5ORix2G50YFYsowdAcqnHl02D
         8gNbkdkisSgb9pqVIEFoSr4L9bQIp4IMLO76M6DZgukqhPqxrkW32YHa6XUjrTwfWSeV
         rLiL7pqkpxhmbWgEiRk7cZs04/MirYWisYHcxyDbHg3gyaHMB9mqrE7tmyR8WFnZD+YJ
         QkPu51nYMiEpaGfPJCFYkn25EuaFtSBEEEYpCtTyWUSi6yV+Bm26j1l/hPpqft+Jk7Bs
         Wfpg==
X-Gm-Message-State: ABuFfogOm3ygMut4/hywUAuJa7TiF8NhFPk7G5ZsSP4Y6fA+5SXIpyIL
        YmNtC6JgIOi1BrQm3u9ARRW3nA==
X-Google-Smtp-Source: ACcGV63c6ut7ur+UHMuPJMuEZQ+lpW69cNAKs2l4VVQAxOL9AynNE+RFMKQJ7DqsZoQ1UbNKepVfsg==
X-Received: by 2002:a19:5d56:: with SMTP id p22-v6mr10575665lfj.34.1538143227730;
        Fri, 28 Sep 2018 07:00:27 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id k19-v6sm1055068lfi.51.2018.09.28.07.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 07:00:27 -0700 (PDT)
Date:   Fri, 28 Sep 2018 16:00:25 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Alex Elder <elder@linaro.org>, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: qmi: add a prompt to QCOM_QMI_HELPERS
Message-ID: <20180928140025.GB5610@centauri.lan>
References: <20180427140358.30839-1-elder@linaro.org>
 <ec0e7861-4bf0-f135-a881-1a1de4579277@linaro.org>
 <20180928122616.GA5249@centauri.lan>
 <4025f206-631a-55e9-9b7a-89dcf3370284@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4025f206-631a-55e9-9b7a-89dcf3370284@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 08:23:03AM -0500, Alex Elder wrote:
> On 09/28/2018 07:26 AM, Niklas Cassel wrote:
> > On Fri, Sep 28, 2018 at 06:41:11AM -0500, Alex Elder wrote:
> >> Was there something wrong with this patch?  I sent it a long time
> >> ago but it still applies cleanly.  I can re-send if you like.
> > 
> > Hello Alex,
> > 
> > This patch does not apply on top of
> > https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next
> 
> Sorry, I sent this before I tracked down where Andy's for-next
> tree was.  It applied OK to linus/master.
> 
> > When you don't specify a string for a Kconfig, then you won't be able to
> > select it via menuconfig, only through other Kconfigs, e.g.:
> > $ git grep QCOM_QMI_HELPERS
> > drivers/remoteproc/Kconfig:     select QCOM_QMI_HELPERS
> > 
> > What Kconfig is it that needs QCOM_QMI_HELPERS?
> 
> IPA, which is not yet merged.
> 
> The entry in "drivers/soc/qcom/Kconfig" for this option includes
> help text, so I presume it was an oversight not to include a
> string (prompt).  It is the only non-trivial entry in that file
> that does not include one.  Why should this entry not be listed
> in menus?

I see. Indeed it is a bit confusing that it has a help text.

> 
> > Why do you need to make is selectable via menuconfig?
> > Isn't it sufficient to add a "select QCOM_QMI_HELPERS" to that Kconfig?
> 
> I have CONFIG_IPA dependent on CONFIG_QCOM_QMI_HELPERS.  I could
> change that to select it instead but I still think this entry
> should be changed.
> 
> I'll mention that SLIM_QCOM_NGD_CTRL in drivers/slimbus/Kconfig
> also depends on--rather than selects--QCOM_QMI_HELPERS.

I would have expected SLIM_QCOM_NGD_CTRL to select rather than depend.
But then it is also weird that QCOM_QMI_HELPERS has a help text.

I guess Bjorn should answer how this Kconfig was intended to
be used, because right now it is kind of ambiguous.


Kind regards,
Niklas

> 
> 					-Alex
> 
> > 
> > Kind regards,
> > Niklas
> > 
> >>
> >> 					-Alex
> >>
> >> On 04/27/2018 09:03 AM, Alex Elder wrote:
> >>> Add a prompt to the "tristate" attribute in the Kconfig file in
> >>> which QCOM_QMI_HELPERS is defined; I find it doesn't get selected
> >>> without it.
> >>>
> >>> Signed-off-by: Alex Elder <elder@linaro.org>
> >>> ---
> >>>  drivers/soc/qcom/Kconfig | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> >>> index 5c4535b545cc..81a501765cd9 100644
> >>> --- a/drivers/soc/qcom/Kconfig
> >>> +++ b/drivers/soc/qcom/Kconfig
> >>> @@ -36,7 +36,7 @@ config QCOM_PM
> >>>  	  low power modes.
> >>>  
> >>>  config QCOM_QMI_HELPERS
> >>> -	tristate
> >>> +	tristate "Qualcomm QMI Helpers"
> >>>  	depends on ARCH_QCOM && NET
> >>>  	help
> >>>  	  Helper library for handling QMI encoded messages.  QMI encoded
> >>>
> >>
> 
