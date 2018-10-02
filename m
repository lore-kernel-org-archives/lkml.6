Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8814C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E402089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dreCrxKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E402089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJBKib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:38:31 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45305 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbeJBKib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:38:31 -0400
Received: by mail-io1-f66.google.com with SMTP id e12-v6so828042iok.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 20:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iwR0cJX/3ZWvWjoY3953+yNMah/9DD4ro3LW7xBsC50=;
        b=dreCrxKbB7DnsveSbcuC0EZKM1Nw5T+PQd93+r12ozDA1spYI3gD3bfrHScgMmP4Ft
         tP0NOiOxWA8mHdsFJU+A0CX0Jw4rapLfqwsMbi8N7zk2wZRpixrrpXWSYz4p/52wV4rl
         jF7AKaC48xjZYeebYj5uZOP3gYTxWYhq4kPDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iwR0cJX/3ZWvWjoY3953+yNMah/9DD4ro3LW7xBsC50=;
        b=fCCCkL4ocIVlYnDEe2oTzxUILlgSrRPEBRAGO6Y62gQ7nJB2G4xiiQg0ZZkKBT6wmn
         K7FoTP7+Jc/wtnejxYci8uf01z6WOm+j1sBQkXVmEZN+Nw5tyk07ilK6DHVM+tyFzRI1
         75oorLGkmlfaEmbGDC+DVKn/0plYiJVM4QAYregNMOeAHyiIeYporz5rZZ8f6TeWqq2s
         75uX8A6HRPNjRbOgwwJx+jf6P0wp3WA+XRjAlfaKFyvyCb5r8RGSycHQ0r+Mz+ucyY7z
         vvSOpg2DyiOKygfxkXLg1knf8hRK09TKAYjszlGwbuNKlEUlFZNJp3trDzrT8XnjxFL+
         vv/w==
X-Gm-Message-State: ABuFfogl+prfV45+csmJNdwaeF4T6cvqke3QwnxTHTVrr00Cd7wbtqsz
        Ac/Z6+ql9CmXJ5PqlRUmUMArMA==
X-Google-Smtp-Source: ACcGV60pWTyMSTCI11KvIyTTc9SfRMuhhxz/oxjq9JYpAlQhlNyl4yM0QfjgnLItXgWcaGXNXpnxnQ==
X-Received: by 2002:a62:70c7:: with SMTP id l190-v6mr5129614pfc.186.1538452644156;
        Mon, 01 Oct 2018 20:57:24 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d7-v6sm24524231pfm.23.2018.10.01.20.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 20:57:23 -0700 (PDT)
Date:   Mon, 1 Oct 2018 20:57:21 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, elder@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: Drop help text for QCOM_QMI_HELPERS
Message-ID: <20181002035721.GC5008@tuxbook-pro>
References: <20181001095554.23815-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001095554.23815-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Oct 02:55 PDT 2018, Niklas Cassel wrote:

> The help text is visible in menuconfig, however QCOM_QMI_HELPERS is a
> hidden kconfig, so it is not selectable in menuconfig.
> 
> Remove the help text so that it is more clear that this is intentionally
> a hidden kconfig.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/Kconfig | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 684cb51694d1..fcbf8a2e4080 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -75,11 +75,6 @@ config QCOM_QMI_HELPERS
>  	tristate
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on NET
> -	help
> -	  Helper library for handling QMI encoded messages.  QMI encoded
> -	  messages are used in communication between the majority of QRTR
> -	  clients and this helpers provide the common functionality needed for
> -	  doing this from a kernel driver.
>  
>  config QCOM_RMTFS_MEM
>  	tristate "Qualcomm Remote Filesystem memory driver"
> -- 
> 2.17.1
> 
