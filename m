Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F20C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA571222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550165528;
	bh=6qzA0i82kOwiXiTayEl//aH+DvPHkg2miMI2zWqe+Kk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cax5mGU0S5uxNGqR+gw7R7rZCoyrKsGGbWiRV8W8LAmBWsETGJZf6CVoI5CfoTtw0
	 BwbFocoWtEuqgo9iZZZChujfbBiOpXtddHty7VryZi4BLuv/2OZcsaOR35rHQ7BwLN
	 5wCdbriiYaxCN2s9f79F7c9NWkudp/XccuavJQLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393146AbfBNRcH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:32:07 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44297 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbfBNRcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:32:06 -0500
Received: by mail-ot1-f65.google.com with SMTP id g1so11799502otj.11;
        Thu, 14 Feb 2019 09:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6NPf9aTa9rw4N4lV2BGoilbb6b1HvdpLFOOPQe5o0Rg=;
        b=iypIpPxG9pCfW7gIZnMRpBUfntiQ7Z4qQLoDiYuT8n+0IDgZfvZCGG8J+ynGlgtZC+
         yN2DwlsFx/FM5sYMEPhZ3VxJNH2pyz9J5I2nsOPazYuYXC+Ut7Fvw/DIEmLrAy8DEcHU
         lPmWg1H7etE7v0NI678FJ9wYeNtaBtstBPx8v8YTEn/XljFHSbvZqsZDkSi8inNYQ6GY
         TsJQ+aPPW+mVYsxyEpqAPCxplHlwFPqOIHP5+bGg9h/Y0QCcRCgpri/KPGWQaLrZC2ut
         IwTHCUyk9WwbKG5qjxXOWvCgFCFxgr64BO8fENPtvycyXxEZ9Wyg5DVHuA6DwRvKcfI6
         qxSQ==
X-Gm-Message-State: AHQUAuaJwJ69/8QnQoFL+2CE2y7jyaBeI12c8uEBgHYjPNwlnVhAuHFG
        2ApgEx0yoZps1MgCQirDgMg2oAUVAusgPkH809g=
X-Google-Smtp-Source: AHgI3Ibs9UmTfun9qspW6z8OxWXxsWaXfntcxvbVcQnToBvqkPkPJTXyuvgbPYHyvZeX2yHuL/nSoK9PPBKapUOXNnY=
X-Received: by 2002:a9d:5a09:: with SMTP id v9mr2913189oth.244.1550165525961;
 Thu, 14 Feb 2019 09:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20190213122105.14270-1-e.velu@criteo.com> <ae38f70b-f352-8567-2dac-5f6c7723a668@criteo.com>
 <CAJZ5v0geHMDMLqg98BZEGLjNrSRy3juB9y54ots357wVeK-shQ@mail.gmail.com> <8158d558-bbcd-fabe-6c8a-8de840807dc0@criteo.com>
In-Reply-To: <8158d558-bbcd-fabe-6c8a-8de840807dc0@criteo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Feb 2019 18:31:54 +0100
Message-ID: <CAJZ5v0gHvZwUuhOepgsUZ3OZZ4X4iGTA3LXOwMi3SYVj7F=iYA@mail.gmail.com>
Subject: Re: [PATCH v6] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
To:     Erwan Velu <e.velu@criteo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Erwan Velu <erwanaliasr1@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 5:42 PM Erwan Velu <e.velu@criteo.com> wrote:
>
>
> Le 14/02/2019 à 11:22, Rafael J. Wysocki a écrit :
> > I've queued it up with some manual changes.  No need to update.
>
> As this could help troubleshooting platforms and as some commits like
> the PSS one on Proliant servers were backported to stable, I would
> surely make sense to backport it to the other stable.
>
> I know this is only a trivial print patch but as my initial issue
> started with some of the 4.14 serie, it could be nice to have it too.

You can always request -stable to pick up a patch once it's got to the mainline.

I'm not going to mark it as -stable material, though, as it is not a
fix strictly speaking.
