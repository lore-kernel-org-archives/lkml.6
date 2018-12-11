Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC86DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A259A20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544529698;
	bh=kC6rcTcQTNHu3fiYUVe3T6AMIjaDqbpl37+WfNkHT8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ndBt23O/E5uU6OVcT2PYptdnZmB3F8z7QO/9nZeaXkt8Qv/5ri958B6UosjqiaiDv
	 E78sNB5fbJJaUZ/gqsdyamHFx8mHMdgAYwHPxbGAORyT6OXoIwEVrdZu62fXOTWxvU
	 XZFYATlKMoJ9iktiC8QOegKTD/56MPc+oVLjuvHI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A259A20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeLKMBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:01:37 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39591 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLKMBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:01:37 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so11772170oia.6;
        Tue, 11 Dec 2018 04:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9R7kYIs00E3HzyVWYgkKORnnr1uEQvNh2bgTIpwBAk=;
        b=npVo9BcMZ9EgbfjPT+Tj7Ip8BdyebyFXuDYtvYRxI4MXJkkPHu47BHLpy+exjxj5QU
         96K8iZFO1PoRJjrKlFF0muEuSPos9NXRJ2neoPkYB+2cMMEBYEFGux/ww9ot1gaW6vg8
         XewoWF5n6bhMR5oNQAvrwZzUDMLfj87REPK+nnYQI3/YaF6kpPGEPs9QDtiX0rSkKR6J
         XSQIth247qaY/aFMBE9JTBxFuh6qPDJuTkgZ1RJQpC7bS3+HK81MbnhOcyvcBGMncIMp
         X6HHwRxl4IU27xwq1UTFs3XT/pipxJvV/3ZfsVka3Ms80AJr45ICLlEX6kSTvB1TKuSH
         +1dw==
X-Gm-Message-State: AA+aEWbIuhZ5U5HESKC6i7qsESPxNYFh6vLqIZ9ptBFr44OEXEyB27RQ
        1TpF9gDXVdX/oV/L1E52ZC2uMhAhfHjtLyM1lHw=
X-Google-Smtp-Source: AFSGD/VKEBab/Vw9U8z338/Q/ohpVD9FzLyVj636F1/WuMD2qyOhkX+p2mtku5V+e3Rv06ar/KQ4ee3PbV+fqtZ/rhQ=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr1055045oix.246.1544529696047;
 Tue, 11 Dec 2018 04:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20181203095628.11858-1-quentin.perret@arm.com> <20181203095628.11858-3-quentin.perret@arm.com>
In-Reply-To: <20181203095628.11858-3-quentin.perret@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Dec 2018 13:01:24 +0100
Message-ID: <CAJZ5v0iygh1Kh4FnOE=2GzcUHW+FBV+9ZrotAfmXtgdk==6tNg@mail.gmail.com>
Subject: Re: [PATCH v10 02/15] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 10:56 AM Quentin Perret <quentin.perret@arm.com> wrote:

[cut]

>  #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> +/**
> + * enum schedutil_type - CPU utilization type
> + * @FREQUENCY_UTIL:    Utilization used to select frequency
> + * @ENERGY_UTIL:       Utilization used during energy calculation
> + *
> + * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
> + * need to be aggregated differently depending on the usage made of them. This
> + * enum is used within schedutil_freq_util() to differentiate the types of
> + * utilization expected by the callers, and adjust the aggregation accordingly.
> + */
> +enum schedutil_type {
> +       FREQUENCY_UTIL,
> +       ENERGY_UTIL,
> +};

Why not to use bool instead of this?  Do you expect to have more than
just two values in the future?  If so, what would be the third one?
