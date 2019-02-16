Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDC6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAED222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 07:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkNvWLvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfBPHqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 02:46:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42044 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfBPHqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 02:46:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so6111034plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 23:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZ2lrnyrL5JE4u94qbUvHYiQRcN+mxeRBdIawqfw9lE=;
        b=TkNvWLvzi6rXdW4bbmsjyAQ+azvTiLx5vCvVDnjo4XIW4S6jJk2/WBxmpIA9X8vlYr
         q+O689VTw0rv/SWPsWJW++8x8uEjhgNZwPrSf5lHMYcjpbT9G6ePLLjMgX4BJXU9KL/t
         Bk7lv37BarXacmvhQ2gx6LIB3NzLJl69MgDAdfeqWAz3uOE7jLe64FpYi9eH2/vKntwq
         ZBDoxwHbFksTU/Yi7bgpdorivU30M60DkbRwYWGde+eDjLyGNwaJfVx2DtzBc2lqRh3R
         BjcfAy2z/mbzKaZcfSwTf944JzstOt9l4BsAoj//7UQfYXWQfRCnQv267kq8Ibo59u7f
         gdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZ2lrnyrL5JE4u94qbUvHYiQRcN+mxeRBdIawqfw9lE=;
        b=D5/K2D9kPLsI2igxvlCrFtbI7c0f7MafxSuKZcB2z328fa8LT/q4hxCltW/q78KpLM
         DXhkCOduMQHwgkNTbKUM1czkKLxyZotIV8h8dxvjk1vOlwSUpdss4tCPIRztA6nMxttA
         0Er2tDfMaycriCz83BPXvAi06DaCkiP57pC2NT95lMUgluFt9O5bjgz0zJIY7SUJ4sTw
         wodUFMeZ+4N/y5G45ygZRitW3fnXZ3mR9G6CuB4p7RmxYxbaIH2eM0rg2qV1MouBvcC6
         WxR/+TnCUKGl7Sh+T8+NeYdJYo/p9taWNkEk4K5DvdK4b2MKtUf3x/p+ghiq2nza29pV
         3/vw==
X-Gm-Message-State: AHQUAubaGieQd43vFBda0a93gzkWYnd0iJM3T0p90d9Faka0qXjWaBCm
        SdOpVf/AsLU1qQVcpJvXxBA=
X-Google-Smtp-Source: AHgI3Ia6MNcIhv+wZtPN5/q/fU0FawtRAEvEz0qV0YlUODGlryHmTBvzT7e/4Cr1EOv8+L+4zdIiXw==
X-Received: by 2002:a17:902:b609:: with SMTP id b9mr14358032pls.57.1550303181083;
        Fri, 15 Feb 2019 23:46:21 -0800 (PST)
Received: from localhost ([221.162.103.114])
        by smtp.gmail.com with ESMTPSA id z67sm13153985pfd.188.2019.02.15.23.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 23:46:20 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 16 Feb 2019 16:46:17 +0900
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Yao HongBo <yaohongbo@huawei.com>, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: possible deadlock in console_unlock
Message-ID: <20190216073856.GA9979@tigerII.localdomain>
References: <ebc01f4f-5b1d-4f8a-1d0d-463d5218ee45@huawei.com>
 <20190216072127.GA1945@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216072127.GA1945@tigerII.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/16/19 16:21), Sergey Senozhatsky wrote:
> On (02/16/19 14:36), Yao HongBo wrote:
> > hi, sergey:
> > 
> > As shown in that link, https://lkml.org/lkml/2018/6/6/397
> > 
> > On the linux kernel 5.0-rc6, Syzkaller also hit 'possible deadlock in console_unlock'
> > bug for several times in my environment.
> > 
> > This solution fixes things for me. Do you have a plan to submit patches to
> > solve this problem.
> > 
> > diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> > 	__printk_safe_enter();
> > 	kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
> > 	__printk_safe_exit();
> 
> I would probably try the following:

Yao HongBo, could you please post the lockdep splat?

GFP_NOWARN is probably the best option for now. Yes, it, maybe,
will not work for fault-injection cases; but printk_safe approach
is harder to push for, especially given that printk_safe maybe will
not even exist in the future.

	-ss
