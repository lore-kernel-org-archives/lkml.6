Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F0C677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 15:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE6A2075C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 15:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f0Q3hESC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE6A2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJFWzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 18:55:09 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:32845 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJFWzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 18:55:09 -0400
Received: by mail-yb1-f195.google.com with SMTP id u88-v6so6694151ybi.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 08:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bmFMEimcDp6LzqpSOyheFQhmOL9UyZ3qqCUzq3ySe1U=;
        b=f0Q3hESCIwuYHqU6qh/8Kpf3r2PsI8QtJBsJgfw+zS4t9uLMd+somkEK6EQkT+ZYcP
         YX9NvU4qNvb4lzUnX3/4pdaZu9A6GuW9M1vW6I+0p78FeNjFJBNrvySVDiQXO4sgaMSu
         fOXlMGjKz/zFXgja5GpLLX6kLdJx4wLDOwBTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bmFMEimcDp6LzqpSOyheFQhmOL9UyZ3qqCUzq3ySe1U=;
        b=ifqQypv1J1YAggnE8zXfEwdcAtjtsRuD/quwwZkWykV3AjBKbPDWhmMOFom8Rt2mfY
         Lw9U3kwkjuZGuEuUdSzyU8jbHUULVTG5En9I/pUZbCov5l5ppbpZlyzvDQoiOfAuKPJb
         LjaygD+4yECSj5YrkgONg3TKwbCsJ3A7dzAssiRQmgPjaAHYAj0gvJUqTeROvLwihG5G
         q1kZmUwOtRPCrjt7QSaXcyyZVZBORO1IoKFS1u5QgYs3dpBIf/sC0+pJjIlf2AdhUV4j
         5Li71TSTo/gPypSH5CaHSyJzwvin43jlyhftks5aoh0rrhprZhRNowyT+GUyxdXFwkXG
         cqJA==
X-Gm-Message-State: ABuFfohSxDi12OO5ADON24UmbOMQiyBqWCKBzx+vILVGqySOKQC2cSZC
        2fqpNDyCwu/t0qUrC1vx8LuR5hlK4uk=
X-Google-Smtp-Source: ACcGV616w0AfU+y9YcApNtGV6i9dWkkH9ZiuIPP5MI7YvPRzZPCIMozhP4zP78b7XjyWNoe048Wp+g==
X-Received: by 2002:a25:2d09:: with SMTP id t9-v6mr9113656ybt.108.1538841079194;
        Sat, 06 Oct 2018 08:51:19 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id k2-v6sm12525334ywh.52.2018.10.06.08.51.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 08:51:17 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id j202-v6so6454981ywa.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 08:51:17 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr8931987ywg.353.1538841077125;
 Sat, 06 Oct 2018 08:51:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Sat, 6 Oct 2018 08:51:16 -0700 (PDT)
In-Reply-To: <20181006084922.xq5bxpghyvbq4tao@wfg-t540p.sh.intel.com>
References: <20181005233559.GA37919@beast> <20181005235131.GA27193@kroah.com>
 <CAGXu5jJfs0KpRa6yag=ud0sJVW-tM-E4xuvgCMnBdFfDck5E1g@mail.gmail.com>
 <20181006002235.GA18415@kroah.com> <20181006031434.GA224454@joelaf.mtv.corp.google.com>
 <20181006084922.xq5bxpghyvbq4tao@wfg-t540p.sh.intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 6 Oct 2018 08:51:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKftdZdGxkxv6t_maoG2uDqCdBJHvzZoM=Noiakrkyb6Q@mail.gmail.com>
Message-ID: <CAGXu5jKftdZdGxkxv6t_maoG2uDqCdBJHvzZoM=Noiakrkyb6Q@mail.gmail.com>
Subject: Re: [PATCH v4.19-rc7] treewide: Replace more open-coded allocation
 size multiplications
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 1:49 AM, Fengguang Wu <fengguang.wu@intel.com> wrote:
> On Fri, Oct 05, 2018 at 08:14:34PM -0700, Joel Fernandes wrote:
>>
>> On Fri, Oct 05, 2018 at 05:22:35PM -0700, Greg KH wrote:
>>> And do we have a way to add a rule to 0-day to catch these so that they
>>> get a warning when they are added again?
>>
>>
>> They could just be added to scripts/coccinelle and 0-day will report them?
>>
>> For example, 0-day ran scripts/coccinelle/api/platform_no_drv_owner.cocci
>> on
>> a recently submitted patch and reported it here:
>>
>> https://lore.kernel.org/lkml/201808301856.vMNJerSs%25fengguang.wu@intel.com/
>>
>> But I'm not sure if 0-day runs make coccicheck on specific semantic
>> patches,
>> or runs all of them (CC'd Fengguang).
>
> 0-day runs all coccinelle scripts. However only auto report out
> warnings that are known to have low false positives.
>
> So if you add new coccinelle scripts that emit accurate enough
> warnings, it'd be good to inform the LKP team to add the new
> warnings to our auto-report-out white list.

It runs with MODE=report by default, yes? I'd need to expand the cases
to cover that (it is patch-only currently) so that would be a roughly
10,000 line Coccinelle script. :)

-Kees

-- 
Kees Cook
Pixel Security
