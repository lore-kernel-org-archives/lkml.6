Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2498DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 901BE21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Dgomb94m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901BE21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeKOTTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:19:19 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35398 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeKOTTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:19:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so11338928edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UM9EjP0Hw28LqZf3C7ivhhk6R3koYbFfX0law4kebOA=;
        b=Dgomb94mdd0qdW5Fg0GrQmbQC/kG22wh8FOvovgQtTU/yY5O94HtYABv2vqefK2enC
         h3+Cst6BcmxzGNBCT0zV+wSArmHO/iH+rBQP3EDiGPiSHpGj9WVa+pTBHhLuGDH6Efnz
         GkfiFcAcbZbqAXmLAMVA/shG3CHtoTqpKMHuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UM9EjP0Hw28LqZf3C7ivhhk6R3koYbFfX0law4kebOA=;
        b=h5wVjDSL0cKwlYT08+jhz4Ht7TZyg4lwjfUPRleC5WMk8V89PlNkKFHduJ5d6jRLNv
         HE+uKKCVj6I4EwrO7upBcEoJSv44MF/wwpYjEBbRwBARWTxfM7GKzll6/ExJHwoUwPBO
         1y0Jzns1FmZ6NKcBgUIPNsmTyg13p6LEQGukiFKh02uOg/UTN1foeh7ygbKoU67tNdni
         NYhEFeeUiZhWw+LDWUmuzPP8ETDCW3vMPhGEjI2t4K5CWwb6KAMqnkjQXZipkp9cTHeC
         YBhuVU0rR4/gtKM92f3qHveRl415+5d4K/qtSbsD5ofReIpVRVAkWe3P01QbrbcK7vBB
         kUrw==
X-Gm-Message-State: AGRZ1gK0+wZ04uwihAJ81cqb0o2R868C7qhXuiBlyCunawLo40FIWYAH
        H0UBylpIKew5gxq1n9sria5zy9/yAds=
X-Google-Smtp-Source: AJdET5dFTBbM0XRCE44Rmdmmp3hAFpLP0Uias5lgY/h7WsaV3MeVwqG6TJwDl8IwEGf3wqE594krTw==
X-Received: by 2002:a17:906:6b43:: with SMTP id o3-v6mr4690073ejs.31.1542273140318;
        Thu, 15 Nov 2018 01:12:20 -0800 (PST)
Received: from [172.26.253.252] ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id f5-v6sm7164942edi.85.2018.11.15.01.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 01:12:19 -0800 (PST)
Subject: Re: [PATCH 5/8] kbuild: change if_changed_rule to accept multi-line
 recipe
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
 <1542270435-11181-6-git-send-email-yamada.masahiro@socionext.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6ee62b52-5d6d-c540-5f01-f522b6986c4d@rasmusvillemoes.dk>
Date:   Thu, 15 Nov 2018 10:12:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542270435-11181-6-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2018 09.27, Masahiro Yamada wrote:
> GNU Make supports 'define' ... 'endef' directive, which can describe
> a recipe that consists of multiple lines.
> 
>   endef
> 
> This does not actually exploit the benefits of 'define' ... 'endef'
> form. All shell commands must be concatenated with '; \' so that it
> looks like a single command from the Makefile point of view. '@' can
> only appear before the first action.
> 
> The root cause of this misfortune is the '@set -e;' in if_changed_rule.
> It is easily solvable by moving '@set -e' to the 'cmd' macro.
> 
> The combo of $(call echo-cmd,*) $(cmd_*) in rule_cc_o_c and rule_as_o_S
> were replaced with $(call cmd,*). The tailing back-slashes went away.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>  
>  define rule_cc_o_c
> -	$(call echo-cmd,checksrc) $(cmd_checksrc)			  \
> -	$(call cmd_and_fixdep,cc_o_c)					  \
> -	$(cmd_gen_ksymdeps)						  \
> -	$(cmd_checkdoc)							  \
> -	$(call echo-cmd,objtool) $(cmd_objtool)				  \
> -	$(cmd_modversions_c)						  \
> -	$(call echo-cmd,record_mcount) $(cmd_record_mcount)
> +	$(call cmd,checksrc)
> +	@$(call cmd_and_fixdep,cc_o_c)
> +	$(call cmd,gen_ksymdeps)
> +	$(call cmd,checkdoc)
> +	$(call cmd,objtool)
> +	$(call cmd,modversions_c)
> +	$(call cmd,record_mcount)
>  endef

Does this mean that Make now spawns a new shell for each of these
commands, and if so, what's the performance impact? Or am I just
misreading things? If this does change the semantics (one shell instance
versus many), I think that's worth mentioning explicitly in the
changelog, regardless of whether there's no measuarable performance impact.

Rasmus
