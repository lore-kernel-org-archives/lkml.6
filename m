Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7D5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AED20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AED20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757170AbeFSKTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:19:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38633 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756548AbeFSKTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:19:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so20959872wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 03:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PB2EbKXB9DEsvRNJ7ll+FIVhxw6CbwWtN75AQs/yNFQ=;
        b=GOSYDsUcALlVqMglQOiUs4TFVgJeCgCoBHoSCaQUZStEOF5n0fKHDG/VpppQYnph5f
         hv6G5pv2yb9z3ceLsqlr4ZXXTvIc8eR0q521gYITMfJmwck9BGd/zNSG6DTUvsUw6Oxz
         G7SK8sq43Iijht5WjnSqDLO8h9E6dugsG26ci6YsPpDyC0XalXl8dIB1jft7ERuTEp16
         yppcke/ZEPkUXJj3Sc4Qb5k8Aw1Wd8vElKTGui+t1yTIqLfpQV+zku5EkZ0cEmyUNMXE
         DgIFJf37sknvO5PIW6sal9GBIp27FXhwJkqd5JqNWAfZg2RAJNZETV/ECA1k5f5ejH7K
         lxvw==
X-Gm-Message-State: APt69E1qf3uBf36VIoTKYOigmKzZRXRu/6KeeLpzU7LLPo8lj8Jn6/c4
        COnsFt18QccmxNYc5fDUlzsLdQ==
X-Google-Smtp-Source: ADUXVKIkZzuBckQuO+afgI4hGVqE8bbBn6a4lNCqyXwTacYaPgS9Kin3hkn/I/Ix+Xt7Mc/U2OdNAg==
X-Received: by 2002:a1c:c90:: with SMTP id 138-v6mr10673335wmm.110.1529403544759;
        Tue, 19 Jun 2018 03:19:04 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id c18-v6sm16211202wrq.17.2018.06.19.03.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 03:19:04 -0700 (PDT)
Date:   Tue, 19 Jun 2018 12:19:01 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Pavan Kondeti <pkondeti@codeaurora.org>, peterz@infradead.org,
        rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 10/10] arch_topology: Start Energy Aware Scheduling
Message-ID: <20180619101901.GC13617@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-11-quentin.perret@arm.com>
 <20180619091841.GD9208@codeaurora.org>
 <20180619094002.GR17720@e108498-lin.cambridge.arm.com>
 <20180619094714.GA13617@localhost.localdomain>
 <20180619100224.GT17720@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619100224.GT17720@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/18 11:02, Quentin Perret wrote:
> On Tuesday 19 Jun 2018 at 11:47:14 (+0200), Juri Lelli wrote:
> > On 19/06/18 10:40, Quentin Perret wrote:
> > > Hi Pavan,
> > > 
> > > On Tuesday 19 Jun 2018 at 14:48:41 (+0530), Pavan Kondeti wrote:
> > 
> > [...]
> > 
> > > > There seems to be a sysfs interface exposed by this driver to change cpu_scale.
> > > > Should we worry about it? I don't know what is the usecase for changing the
> > > > cpu_scale from user space.
> > > 
> > > This is something I've been wondering as well. TBH, I'm not sure what to
> > > do in this case. And I'm not sure to know what is the use-case either.
> > > Debugging purpose I assume ?
> > > 
> > > Juri, did you have a specific use-case for this feature when the
> > > arch_topology driver was first introduced ? Or was it just to align
> > > with the existing arm/arm64 code ?
> > 
> > It was requested (IIRC) because DT might have bogus values and not be
> > easily modifiable. So, this is another way to get things right for your
> > platform at runtime.
> 
> Right, but that also allows you to set different capacities to CPUs
> inside the same freq domain, which isn't supported by the EM framework,
> at least for now. So I would prefer to assume that your values in DT must
> to be correct to use EAS, and leave the code as-is for now.

It's actually built on the (current) assumption that siblings share
capacity [1], so it seems to align with what EM requires.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/base/arch_topology.c#L71
