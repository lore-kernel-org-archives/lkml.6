Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923FBC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DE220839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RSSwmyA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DE220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeILUBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:01:36 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51409 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeILUBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:01:35 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so3435323itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+nLwE+05HPlow49c8NsY3uomOHVHwOHp6XcBes9vnO8=;
        b=RSSwmyA4TSzzZmmBwDdVqcv19sTxX7dX1hYJD7ydL9eZE1oMKgaIoymamsvOGkxfaS
         Ue5Qlkue8E7cAHcltDt/K31dzYD6yANwcman1EWjUDu71jT8amFIdqh2LuNBuL4Rgv37
         2w/cUXDBTLC11NAqXsRd/9ZjNDB6yd7Dp66Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+nLwE+05HPlow49c8NsY3uomOHVHwOHp6XcBes9vnO8=;
        b=ajJuQzeETKmkRsTKkzk6gmdLXEcvNeXyyBbDLY3KjLHure48x9HV3mXFJJitRtrUzj
         nv3HnaTHsRZ/+i75mprlOEyVMJ3SCj9JYjc7oKnSVpr88nlbc1qg3vShTF2hnKiBuEyc
         TZ9l/WNg1O3pz/qU6+Dd6JRRUPntlzrTj054FNfrnh4o048K/XQ6eHC5g/4PBUIdJ+hc
         oy3DrWwcGt39xZtn2RTQGXmVcfk0Uiy+9br/yodhLeyjpO4xmMRNkMChfVh8Sg1IHiWb
         jjv4Jl2P47SMtygtvjL/5r8HQ79F4/2x948v+xkhigyxyeDntsqKhRSIL6Jrezch88hg
         TUWw==
X-Gm-Message-State: APzg51AVnUQyIGl5SPgTkcYFzy6elicyMwXDzMUpkv4d05A4NHL1/B0M
        UC61OzEk6OPwTGQKUVIiVsIe/5L/t9mo2PIs1zM+Bg==
X-Google-Smtp-Source: ANB0VdYj8AM7N/ILT+8UblqHxcpYN/9fJOiauSBTRrSAiyURRAShYCk6j5WCIQbj5wL3ZAJthpoyXnwZsodawTF5OWU=
X-Received: by 2002:a24:d104:: with SMTP id w4-v6mr2331522itg.29.1536764202143;
 Wed, 12 Sep 2018 07:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180912091309.7551-1-quentin.perret@arm.com> <20180912091309.7551-3-quentin.perret@arm.com>
In-Reply-To: <20180912091309.7551-3-quentin.perret@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 12 Sep 2018 16:56:31 +0200
Message-ID: <CAKfTPtA1BDHNnadZ4a3F+ZGt_GbM825P91toMdCimsMdu7q0Ew@mail.gmail.com>
Subject: Re: [PATCH v7 02/14] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Cc: Steve Muckle" <smuckle@google.com>, adharmap@codeaurora.org,
        Saravana Kannan <skannan@codeaurora.org>,
        pkondeti@codeaurora.org, Juri Lelli <juri.lelli@redhat.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        currojerez@riseup.net, Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Wed, 12 Sep 2018 at 11:13, Quentin Perret <quentin.perret@arm.com> wrote:
>
> Schedutil requests frequency by aggregating utilization signals from
> the scheduler (CFS, RT, DL, IRQ) and applying and 25% margin on top of

quite a minor thing but s/and 25%/a 25%/

> them. Since Energy Aware Scheduling (EAS) needs to be able to predict
> the frequency requests, it needs to forecast the decisions made by the
> governor.
>
> In order to prepare the introduction of EAS, introduce
> schedutil_freq_util() to centralize the aforementioned signal
> aggregation and make it available to both schedutil and EAS. Since
> frequency selection and energy estimation still need to deal with RT and
> DL signals slightly differently, schedutil_freq_util() is called with a
> different 'type' parameter in those two contexts, and returns an
> aggregated utilization signal accordingly. While at it, introduce the
> map_util_freq() function which is designed to make schedutil's 25%
> margin usable easily for both sugov and EAS.
>
> As EAS will be able to predict schedutil's frequency requests more
> accurately than any other governor by design, it'd be sensible to make
> sure EAS cannot be used without schedutil. This will be done later, once
> EAS has actually been introduced.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
