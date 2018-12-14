Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E46C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6AA20645
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbeLNWW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:22:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46592 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeLNWW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:22:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so4136419qkf.13;
        Fri, 14 Dec 2018 14:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptzu5u6SzlU1qt1JMcYLoIwHmQdgxDtWqilLc56jRmc=;
        b=HWs/Qw29j3ofPYO8UiZOFGqypA5h4B8YqGXeBdob4JwXe+ZVo00ZCdUun0HdjdROBZ
         AcQN9QgRPbUjzhLJfK0/OgA1oqN9hhApr9P+nGTLUvybjn1EIAW3rZwtds0jipV2pJ1G
         GHhxqbsL+JimmcmMPLBm1VpzBz3Vb1JdQfoy5NdurGl86RPyFm95EExtqWogb9IpyQWt
         FujyYW3Pq1O3kmnj7RejRg7Msh+l3H5f53+HMmA7CymPukohNsr12QcSUUX0NvWbE3NB
         ylaKgIsxWV9gqz4jFfuu4WIUH/B4rF/+JYC2tMrUTN8POzT7KQKGtwrTnIpiCbyrkmw7
         Nz1w==
X-Gm-Message-State: AA+aEWbCg7kxYzJ5otpPwJJSx2pbGPzKgMfuf196FJvBTG4XGqEVaMsI
        XHdRkAGcntBN2zZZlKvdsa1a+IothwJuKBuJsDE=
X-Google-Smtp-Source: AFSGD/VNxDhP/5SWny1TsvNxUKuV1SOSu6cpl1vLFvguSsHzC7BVl2iaSU58ea0QpA14FwkTOayszKjV1n2MVdOQ6fU=
X-Received: by 2002:a37:9a89:: with SMTP id c131mr4391181qke.173.1544826148019;
 Fri, 14 Dec 2018 14:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20181210204514.2362328-1-arnd@arndb.de> <20181214.132300.832860946069084294.davem@davemloft.net>
In-Reply-To: <20181214.132300.832860946069084294.davem@davemloft.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Dec 2018 23:22:10 +0100
Message-ID: <CAK8P3a3ZC_1C2pVYcLEe1y0=__YsapF+rZWKjLZ9hyUucyLT+A@mail.gmail.com>
Subject: Re: [PATCH] w90p910_ether: remove incorrect __init annotation
To:     David Miller <davem@davemloft.net>
Cc:     Wan ZongShun <mcuos.com@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:23 PM David Miller <davem@davemloft.net> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Mon, 10 Dec 2018 21:45:07 +0100
>
> > The get_mac_address() function is normally inline, but when it is
> > not, we get a warning that this configuration is broken:
> >
> > WARNING: vmlinux.o(.text+0x4aff00): Section mismatch in reference from the function w90p910_ether_setup() to the function .init.text:get_mac_address()
> > The function w90p910_ether_setup() references
> > the function __init get_mac_address().
> > This is often because w90p910_ether_setup lacks a __init
> >
> > Remove the __init to make it always do the right thing.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Actually I think we can validly mark w90p910_ether_setup() and
> w90p910_probe() with appropriate init tagging.  None of these
> functions are invoked outside of the probing paths.

But then we have to change the driver to use
module_platform_driver_probe(), to ensure we cannot
unbind/rebind the device. I usually don't like doing that,
unless the device can never be stopped after it has
been initialized.

       Arnd

       Arnd
