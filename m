Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06EDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3315E21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmiTEAmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3315E21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbeIUHvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388757AbeIUHvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:51:54 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB5A21532;
        Fri, 21 Sep 2018 02:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537495523;
        bh=zpliDfchLF3d+z1lGDo6s3Yov98/Wu1/RYyx3wjYbbA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CmiTEAmwE1KA1fZE6Qahhs0dcLEzOXHdUUIepByBS0kjWx/k4nNNGHTA29z13GMkH
         6YpRZKILhncMykdfGYHp5KAifMUhoHBZFtSw7rI8z7EY7OSSBR5aXNTUpkfiIkDakl
         BeDzgPGc/BHpkRh8zGkcMf7Cx0+Nb2W49ok7pGBI=
Subject: Re: [PATCH] gpiolib: Show correct direction from the beginning
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180914070839.4667-1-ricardo.ribalda@gmail.com>
 <20180914070839.4667-2-ricardo.ribalda@gmail.com>
 <CACRpkdbqmK=MzGsOYLdtFO3AAbKHhzy_RD=Gr6wj3WnQunyCGg@mail.gmail.com>
 <CAPybu_0iDqSn02iGLEg8Ge9EdyCCNhRVV3JgHg180qrXK+bcdw@mail.gmail.com>
 <d84ee082-f578-3ed3-32be-dbeb9562980e@kernel.org>
 <CACRpkdYGpEVG9gqPxNaOsD55k9idEfGaxOUrObbN9VZS06x5jw@mail.gmail.com>
 <bcb79947-dfe0-e5e2-fb48-3b6992720f01@kernel.org>
 <CACRpkdbz0hyjy5U3-xo8Oi-ojB_H3=DEwuJtmoqJTJQNiAYYaA@mail.gmail.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <27c8e13a-44bf-18b5-083b-25b87d7b8605@kernel.org>
Date:   Thu, 20 Sep 2018 21:05:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdbz0hyjy5U3-xo8Oi-ojB_H3=DEwuJtmoqJTJQNiAYYaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/18 5:36 PM, Linus Walleij wrote:
> What I mean is that $SUBJECT patch might not hurt Qualcomms
> GPIOs (not crash the platform) if and only if it is augmented to not
> try to get the initial direction from lines masked off in .valid_mask
> if .need_valid_mask is true.
> 
> Whether it makes sense semantically is a different debate, but it
> seems possible to reintroduce calling .get_direction() without
> hurting anyone.

That means that all the logic for checking valid_mask needs to be added 
to the chip driver's .get_direction() function.  We can add that logic 
to msm_gpio_get_direction (at one point, I had a patch that did that, 
but it was rejected).

My concern is: what if a driver depends on a .request call being made 
(in order to configure muxes, for example) before touching the hardware?

I wonder if this is something that really should be handled in the 
driver's .probe function.  The driver should collect that information 
and pass it to add_data.
