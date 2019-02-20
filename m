Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D75C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995FD20859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HeSm2bBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfBTWPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:15:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39693 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBTWPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:15:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so42969873otl.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 14:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RB8Tw583ZAzw6QNzNocGv3B8bmRyv78XJQZpsCZofwc=;
        b=HeSm2bBK/dgQ1JLSmWtkJMCgPJOCCrWcreL0zacqPqTxJJsx8/PLhvATogZQO4n6fg
         hoSjHsTLekimTCrxt8xm2enfFGD+FVgzpoTzlC/XjD/qkPBYWKu2nxoqwvJch8prk7gM
         dEsBjr82OsECMDU3XXJhE2PNr6g+cVSmdu9fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RB8Tw583ZAzw6QNzNocGv3B8bmRyv78XJQZpsCZofwc=;
        b=d85VbCppwjXAZMP7N1/zC1hA8iCdKQJ+7Ts3rhb6t/u3Dn6nTsr9rmlWNXclOJdm4T
         2CrQll0zaP6M6rid1f/srLhlNlDzmKWY8pT2eIKfVORSW6qj0RQn1LKyWXpQQfDMh9lJ
         g/zz+AO2/XLPYznivx0roCrAoO85v5nJ03Zd46BVeVq9kV8F6DKaZQyj4wuWD0iNtajT
         5o1yZqAg3JkHv+7HvfIHbqBjGKsYHiVcb7gmQ//51zt3X5KZN/z04t6XeWLYKw3luXL/
         /zAoZbBqMCqQvKcv8TbwhwNoobkjgJwFKos+Gw5lPWxWWIsVBp9wzvp/Tpg6YyBOKneN
         oGyA==
X-Gm-Message-State: AHQUAuYHsK3F7r4DnqOZCduds2gi72pCnC+sL8jMJrBvNukp0HtYZa6T
        ZluRo2Njx9lopiiIeNxkrbtdM0eJhQU=
X-Google-Smtp-Source: AHgI3IaCMa+e1eCck6YwHnRX4XXMWN4ImmvwHbgtVVaPJDryUixMpvp+xvF2os2S6hf8juP0hKC+Mw==
X-Received: by 2002:aca:4008:: with SMTP id n8mr7090895oia.161.1550700931533;
        Wed, 20 Feb 2019 14:15:31 -0800 (PST)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id k16sm8521432otl.58.2019.02.20.14.15.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 14:15:30 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id v20so11007459otk.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 14:15:30 -0800 (PST)
X-Received: by 2002:a9d:7981:: with SMTP id h1mr16838655otm.80.1550700930123;
 Wed, 20 Feb 2019 14:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20190220215826.44366-1-ncrews@chromium.org> <a0cf4649-e06f-aded-55ad-893560c2414a@collabora.com>
In-Reply-To: <a0cf4649-e06f-aded-55ad-893560c2414a@collabora.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 20 Feb 2019 15:15:18 -0700
X-Gmail-Original-Message-ID: <CAHX4x87KP9QsnX-vAwyEs45tXngbiSSq+vrByj01S-LpUdO40g@mail.gmail.com>
Message-ID: <CAHX4x87KP9QsnX-vAwyEs45tXngbiSSq+vrByj01S-LpUdO40g@mail.gmail.com>
Subject: Re: [PATCH -next] platform/chrome: Fix off-by-one error in wilco_ec/debugfs.c
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Duncan Laurie <dlaurie@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Wed, Feb 20, 2019 at 3:06 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Nick,
>
> Thanks for the patch.
>
> On 20/2/19 22:58, Nick Crews wrote:
> > Before, in debugfs.c it was possible to supply only the message type,
> > and not supply any other arguments when sending raw commands. However,
> > this is never used by the EC, and it led to an underflow error. Now,
> > just don't allow too short of a command, we will never need
> > that anyways.
> >
> > Fixes: 46c7fd06f8c9 ("platform/chrome: wilco_ec: Add support for raw commands in debugfs")
>
> As this is -next material I'd like to squash the fix if you don't mind.


Please do. Fixing something after it's already in the tree was a new
process for me,
so I tried to copy other people's examples. Please let me know
if there's anything else I should do something different next time.

Nick

>
> -- Enric
>
> > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > ---
> >  drivers/platform/chrome/wilco_ec/debugfs.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
> > index 46ff3b6c46c7..c090db2cd5be 100644
> > --- a/drivers/platform/chrome/wilco_ec/debugfs.c
> > +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> > @@ -136,8 +136,8 @@ static ssize_t raw_write(struct file *file, const char __user *user_buf,
> >       ret = parse_hex_sentence(buf, kcount, request_data, TYPE_AND_DATA_SIZE);
> >       if (ret < 0)
> >               return ret;
> > -     /* Need at least two bytes for message type */
> > -     if (ret < 2)
> > +     /* Need at least two bytes for message type and one for command */
> > +     if (ret < 3)
> >               return -EINVAL;
> >
> >       /* Clear response data buffer */
> > @@ -145,7 +145,7 @@ static ssize_t raw_write(struct file *file, const char __user *user_buf,
> >
> >       msg.type = request_data[0] << 8 | request_data[1];
> >       msg.flags = WILCO_EC_FLAG_RAW;
> > -     msg.command = ret > 2 ? request_data[2] : 0;
> > +     msg.command = request_data[2];
> >       msg.request_data = ret > 3 ? request_data + 3 : 0;
> >       msg.request_size = ret - 3;
> >       msg.response_data = debug_info->raw_data;
> >
