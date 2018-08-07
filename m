Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9501C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C69021477
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="rT+T+aaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C69021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flowbird.group
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbeHGLby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:31:54 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36641 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeHGLbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:31:53 -0400
Received: by mail-wm0-f41.google.com with SMTP id w24-v6so17234960wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 02:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nHBB1ieJms544607CR4nPIWKqqaclU3eAACV5U7SvbM=;
        b=rT+T+aaB7vK8g4yTeFWuDx/Awzeg6fE22CSmnp9f1IjimxlYq7+usETo+F8/7MsAix
         6XDBEFOyROFjEnq3RxTHXszxlTzv5x4RfB0MGjRtct02WLG7uadJ320+GOEFbc0gvHil
         iMYkgTyDeMOAyWiNKPTGScoL4/9FL2a3ZDgbsRh0l8OsUOuJJHANGgeovWJbhGr4Sis7
         Ow1apufm4OnUMsx8v/I16YlcZh128LyN8hNhn/RDtOVBUMK8Fwlj+Zs5RW91mzgINlAD
         tJptEqfKti+ptqHOZ7ow8cdzj6us4rcIWrR96C/IWoEdG/OCTT7ZFvcLqUT+kJzg1pX1
         8+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nHBB1ieJms544607CR4nPIWKqqaclU3eAACV5U7SvbM=;
        b=m1G1vO3nvQUKu57AKOmLd+18cJYEIphwN4KkuEpZnf1ixQTGwxJqbbdQAw5quiv1c0
         qusldheeoXmZUXraUrp9enkx7Kb8eWurpVmtDcYttc4UZjL0NJzS3Cmzoxt4Hbhb07Cv
         Z9XK/Z32nMRumJCowJT9Brjd0X7AIZO7dENzrSF8dtdGL0xsjb8VrRvzmZidLnbO9CSY
         62ISbAS8OLwed8hQHZZDakxps1CgunU5eybkkdRGM5diJXVkjzLQ6PjEqeowfxN6EJA3
         JF7yiyJbB4BmjBVeGCCgKyCLmh0VqQ8UmqHgiJR1J39f/rFDu7ja4nK7ucK52rnFPc+/
         hdEw==
X-Gm-Message-State: AOUpUlHNOtCzXcG2P+pumuRDtzBkjEC23ZswuNGuv/0PYQPVOtmZuGbz
        27WVwOXtoY8y7aHWdc5mtVUoYg==
X-Google-Smtp-Source: AA+uWPxqCmQ7MBEBtRRglSiYvCgcYNx/hVbmtKYsaP0+JVQvxN0NFkHiADhBPDqLsIF6pMu/ry36eA==
X-Received: by 2002:a1c:aa0c:: with SMTP id t12-v6mr1044883wme.109.1533633508130;
        Tue, 07 Aug 2018 02:18:28 -0700 (PDT)
Received: from [10.32.50.237] ([185.149.63.251])
        by smtp.gmail.com with ESMTPSA id h14-v6sm1268989wro.15.2018.08.07.02.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 02:18:27 -0700 (PDT)
Subject: Re: [RFC] drm: Allow DRM_IOCTL_MODE_MAP_DUMB for render nodes
To:     Rob Herring <robh@kernel.org>, Sean Paul <seanpaul@chromium.org>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Robert Foss <robert.foss@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Brian Paul <brianp@vmware.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        eric.engestrom@intel.com, Gustavo Padovan <gustavo@padovan.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        norvez@chromium.org, Tomasz Figa <tfiga@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
References: <20180724082213.25677-1-robert.foss@collabora.com>
 <f718f3ec-3726-3f51-6756-80b357fc23c9@flowbird.group>
 <CACvgo53h=8q-xuJBPP1T2JWkb7SffXas94=moS1x76=BejyVJA@mail.gmail.com>
 <c05f1d94-bf9e-cf9b-e575-dc220b9ca163@flowbird.group>
 <CACvgo50u--YAxwG-cEhgj5AagOcz9oyaX2YC52Gp6324c8mNEQ@mail.gmail.com>
 <20180803195025.GO20303@art_vandelay>
 <CAL_JsqJaciQ1297kT85c4EESFD=x-Se=fRxYcr3oZJ7xNaiGmg@mail.gmail.com>
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
Message-ID: <86334106-46d3-9d77-4c65-a1437e0454e5@flowbird.group>
Date:   Tue, 7 Aug 2018 11:18:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJaciQ1297kT85c4EESFD=x-Se=fRxYcr3oZJ7xNaiGmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/18 21:05, Rob Herring wrote:
> On Fri, Aug 3, 2018 at 1:50 PM Sean Paul <seanpaul@chromium.org> wrote:
>> Fwiw, I'd lean towards allowing DUMB allocation from the render nodes. I
>> understand it limits use cases that are undesirable, but it is also limiting
>> usecases that are desirable. So, given that people are going to get "creative"
>> regardless of how many safety railings we put up, we shouldn't make things
>> unnecessarily hard on other trying to Get Work Done.
> The problem with using render nodes is what if there isn't one? We
> require VGEM (and make VGEM allow dumb buffers) in that case?

Try to open the render node and fall back to the card node if it doesn't 
exist?

AFAICT VGEM doesn't provide contiguous buffers so it won't work for the 
imx-drm case.


Regards,

Martin

