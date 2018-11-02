Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A853CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6842082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWB8SZs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6842082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeKCBUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:20:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35896 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeKCBUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:20:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id o125so3894435qkf.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 09:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6Ha1cZMVPr8gFvoudGJ9sSffjKNhL5fmF725rK3/bzI=;
        b=CWB8SZs6tYb9O+UKDTofR2of9I0HHdE6unY77t5i484RGkx2zVZj2hRKzHQfhuQz6c
         38MceArkZyizJZC1MQDYkpYwPQHeCQBeXjny7caLCP64XirSWYi+UeIKaXAXPVLBpj6U
         tlFhLuR3JtSQE/oAuED6kFnlHAMgORDwDyXyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6Ha1cZMVPr8gFvoudGJ9sSffjKNhL5fmF725rK3/bzI=;
        b=m2XJWZUFrfGZBPj4/55zNH/j7DD7TM2oZCY40mExVj6ourjr5ligwSCsvEXcUxnOUz
         A4Kf9oShQrovZDiG7/xULn43+WZ15hxi/XDPDLIQlaib12miub2EpVgX440ZBKdZw711
         e2f7M4K/1iG0/HCSmp/5LO9AzZEpvh5vzDiXBo9vANVGE2yO/JGdeejZxIHOQCkW3OXR
         csZc/TEP7mR2IvNmIpYtNYPoZmE3eozD8lIkC/q5eZ6cJx3a8uqsA0JwWjsYH1w5l4eF
         03qUQ1G3hcnXVNaloeFBqu9KoG4aThIxVPPzty/+JTXcqEknhFy8zk67I1NS4n2VFpt6
         XPJg==
X-Gm-Message-State: AGRZ1gJius0XEUfvqzufHDZq/2A5YwPO0E8AWoUQ1NMxI1C7anaIdB91
        mQZ7q4oLIQ2FpGuc+JrNTxRqFg==
X-Google-Smtp-Source: AJdET5dpsU8xr/Gd1rcNh+obaGgASFgwaSVZazIfPCyetEDX0j+pcDyAeMvvmGxOTo05tuNl/sWI6g==
X-Received: by 2002:a37:54a:: with SMTP id 71mr10959064qkf.253.1541175145935;
        Fri, 02 Nov 2018 09:12:25 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id 83sm34077485qkz.73.2018.11.02.09.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 09:12:25 -0700 (PDT)
Date:   Fri, 2 Nov 2018 12:12:24 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
cc:     smuchun@gmail.com, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpiolib: Fix possible use after free on label
In-Reply-To: <CACRpkdZ_jrNNB7n0DOuL6n_JtupiwacbMxWcockTak9F8fdAjA@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1811021205400.1498@knanqh.ubzr>
References: <20181101131250.41636-1-smuchun@gmail.com> <CACRpkdaURruTj6W=ozXpKEvLpxLa=6tLdDywac1uj61Hg8ZKpA@mail.gmail.com> <CACRpkdZ_jrNNB7n0DOuL6n_JtupiwacbMxWcockTak9F8fdAjA@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018, Linus Walleij wrote:

> On Thu, Nov 1, 2018 at 4:27 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Thu, Nov 1, 2018 at 2:13 PM Muchun Song <smuchun@gmail.com> wrote:
> >
> > > gpiod_request_commit() copies the pointer to the label passed as
> > > an argument only to be used later. But there's a chance the caller
> > > could immediately free the passed string(e.g., local variable).
> > > This could trigger a use after free when we use gpio label(e.g.,
> > > gpiochip_unlock_as_irq(), gpiochip_is_requested()).
> > >
> > > To be on the safe side: duplicate the string with kstrdup_const()
> > > so that if an unaware user passes an address to a stack-allocated
> > > buffer, we won't get the arbitrary label.
> > >
> > > Also fix gpiod_set_consumer_name().
> > >
> > > Signed-off-by: Muchun Song <smuchun@gmail.com>
> >
> > I am still a bit worried about the kstrdup_const() that this
> > introduces.
> 
> Forget it. I realized after actually reading the code
> for kstrdup_const() that it really does exactly
> what we want.
> 
> I should stop assuming things are syntactic sugar
> in the kernel, we have some really smart people
> working with it...

I didn't know about kstrdup_const() either before just now.

If the device tree lands in the kernel rodata area then all is fine. I 
don't know enough about the actual DT processing to be sure though.


Nicolas
