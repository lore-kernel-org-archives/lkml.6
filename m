Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C31C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CE82150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tuOrx+7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CE82150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390081AbeIUTMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:12:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40031 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeIUTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:12:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17-v6so5969247plp.7;
        Fri, 21 Sep 2018 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I/ct2eM+xSAblEWuL0Nwa99KusCwKhX+9t913VuxWyw=;
        b=tuOrx+7mJTcN6Daeaf0fm+5Ppe5VH4XPR/XgKkBZpf7vhC5SiY1RDTmrORwd76OwfT
         t2jIXtBPluRcu1zTN8mwNvnB0jcp76aDa13W8uRXK1A/l/Oho4paSwNIpw4np7FNDMP4
         Ygg7UR66PYdvOhW21MYQazQLn4cNh4E5+mth6DAWRgr6abn9g6/DuI3huuqnNtdnHUGL
         S8lZwvn5NLWihLcqIKPYfRXJlwK8BfVY17apiWsMO7kC9ssUH03QPuaUgEGPpmFlQPiM
         5b2tOk+H9WXpdO/sm74ysEuohKlT1jrFHWG3xZtkN1ZDPUQJrgJXpjFQl+DYWJeDjfN0
         2qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I/ct2eM+xSAblEWuL0Nwa99KusCwKhX+9t913VuxWyw=;
        b=gUCzagH7th6HK8EvyCSs4DuuKd4MWItNz+tyXXXRfgBYqvw5Ye1TQ+9NygZWdbKN8U
         BJkgbhdtp1t3vu5YO5TovJvUzDo7ZPB27VC+RZQLcI4F0zt1wS0tz6KlHutwYAkFjS/E
         325L/zIHi1xmf7rthHKgbPe3a/9duAFaXOl6knxknN2LpV1mDY72XS09vaITmB5tyf3N
         jWIKYTc+5E+mTocGUz3Tf5OQc7SR+r+hpXOdQ/ocAZrawdUyRaACzPpnc0AZwrV8kJAy
         sYvpGG8b7XaKzbm1os1WZUKMPmtOOyQWxLI8Ter/RScHNKF/dYb4bSb7SK9XzOwPpWDD
         0+fA==
X-Gm-Message-State: APzg51Bil6zPlCMMGQHQVn8ScooM7mmiGncJVgGGYa7LspJ1PrHI2ioW
        TodPJnWmMMn5WR6LRfYz2ic=
X-Google-Smtp-Source: ANB0VdZ/hXve9JEyTyKT6Zv/b9X595whzf1wLxIEUeVC9wN1izv27NAL22xWSQHT//CodKFEl0ermA==
X-Received: by 2002:a17:902:820a:: with SMTP id x10-v6mr44592502pln.261.1537536236262;
        Fri, 21 Sep 2018 06:23:56 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o21-v6sm45500764pfa.54.2018.09.21.06.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:23:55 -0700 (PDT)
Date:   Fri, 21 Sep 2018 06:23:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: pwm-fan: Set fan speed to 0 on suspend
Message-ID: <20180921132354.GA16764@roeck-us.net>
References: <20180921101048.11679-1-thierry.reding@gmail.com>
 <20180921101048.11679-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921101048.11679-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 12:10:48PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Technically this is not required because disabling the PWM should be
> enough. However, when support for atomic operations was implemented in
> the PWM subsystem, only actual changes to the PWM channel are applied
> during pwm_config(), which means that during after resume from suspend
> the old settings won't be applied.
> 
> One possible solution is for the PWM driver to implement its own PM
> operations such that settings from before suspend get applied on resume.
> This has the disadvantage of completely ignoring any particular ordering
> requirements that PWM user drivers might have, so it is best to leave it
> up to the user drivers to apply the settings that they want at the
> appropriate time.
> 
> Another way to solve this would be to read back the current state of the
> PWM at the time of resume. That way, in case the configuration was lost
> during suspend, applying the old settings in PWM user drivers would
> actually get them applied because they differ from the current settings.
> However, not all PWM drivers support reading the hardware state, and not
> all hardware may support it.
> 
> The best workaround at this point seems to be to let PWM user drivers
> tell the PWM subsystem that the PWM is turned off by, in addition to
> disabling it, also setting the duty cycle to 0. This causes the resume
> operation to apply a configuration that is different from the current
> configuration, resulting in the proper state from before suspend getting
> restored.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied.

Thanks,
Guenter
