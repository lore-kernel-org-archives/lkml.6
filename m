Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF64CECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EFC206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHIEdSrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EFC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbeGSDVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:21:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46241 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731336AbeGSDVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:21:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id p23-v6so2866768pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 19:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5jux5lG9GO/5upVklzCiE1SivQxEdyzu+CHTJ5LJ1Go=;
        b=RHIEdSrOe8lfWC2cGEG7taRnjw6je0I+h+zgGam+rgUAxwFMQoySSmiwzJgknGCfOb
         7XU0np2UVqv2jzRjeDaF/1gcb2cxIzOlEaa0nt+OGIdcPEyp5ZyVlqhje8g1EurSyBQv
         c0a3RSmC6FqR9oJ/NbgN535aeesZ8pdaFGgCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5jux5lG9GO/5upVklzCiE1SivQxEdyzu+CHTJ5LJ1Go=;
        b=o0FHQqSSvQEo6B95YZmXsTH7VzTURxkvu/yn+aZSJvnmS5WtGRylt5BjDfSFFWMF/H
         f6iJdIEzpgvuP0nkoJh/5AidyMcLnufs4/khgwAGdpuZE3wYPWMBh8BIydXGGqhPep0t
         bhYO+ZoLPiGjo9Tz7VTyeBz+Nu6Us2XAZEfMEJgJKIvz4gzjl+0tO3VntloQE7hSDnoR
         e8fd82T4vFo1xACxk/j+qu7jG2jlWMeCpurrQfb+5UpwffKwK20opuC78Dd5XHhj3iUL
         aAgaoCPvTNBqnT8iXaDRcCfU+yzxB5/QV882kqm53IoKIADxdN7dQ8uqmU1WUO/S8AYa
         aFZw==
X-Gm-Message-State: AOUpUlHNXgVG6iO3jkz5l6RXJohuyEYTiV8/yuUx1H4NcHvbmhzYz+1C
        jB10rER8PPrbtdHQ3ydVddLkZg==
X-Google-Smtp-Source: AAOMgpf/clZ7O7QrnCZj0OPYkfUjcaobWvsdqdOuPSjduSqARrzRkDe9qiaZNLoxYtaUykjl77eu0w==
X-Received: by 2002:a63:be4a:: with SMTP id g10-v6mr7988027pgo.378.1531968033313;
        Wed, 18 Jul 2018 19:40:33 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id h24-v6sm11078684pfk.113.2018.07.18.19.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 19:40:32 -0700 (PDT)
Date:   Thu, 19 Jul 2018 08:10:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dt: thermal: Fix broken cooling-maps
Message-ID: <20180719024028.vudrlpgxiz6accky@vireshk-i7>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
 <5B4F5E00.5050800@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B4F5E00.5050800@hisilicon.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-07-18, 16:34, Wei Xu wrote:
> Hi Viresh,
> 
> On 2018/7/5 6:09, Viresh Kumar wrote:
> > Hi,
> > 
> > This is an attempt to fix the broken or partially defined DT bindings
> > for cooling-maps. We should list every device that participates in
> > cooling down at a certain trip point, instead of just the first in the
> > list as that depends on certain ordering of events to work properly.
> > 
> > The first patch extends the binding to allow a list of phandles in
> > "cooling-device" property and the second patch fixes one of the
> > platform's DT.
> > 
> > This will be followed up by fixing all platform DT bindings that have
> > these issues after this set is accepted.
> > 
> > The kernel also requires some changes to handle the phandle list, but
> > wouldn't break with these changes as it reads the first phandle in the
> > list for now. We can update that separately.
> > 
> > --
> > viresh
> > 
> > Viresh Kumar (2):
> >   dt-bindings: thermal: Allow multiple devices to share cooling map
> >   arm64: dts: hi6220: Add all CPUs in cooling maps
> > 
> >  Documentation/devicetree/bindings/thermal/thermal.txt | 11 +++--------
> >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi             |  9 ++++++++-
> >  2 files changed, 11 insertions(+), 9 deletions(-)
> > 
> 
> Thanks!
> Applied both to the hisilicon dt tree.

Hi Wei,

I expected the first patch to go via the thermal tree as it is for the
thermal core maintainers. Second patch can very well go from your
tree, but only after the 1st one is applied by thermal maintainers.

-- 
viresh
