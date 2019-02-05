Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735DFC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471DC217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goUvsaNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfBERdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:33:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41686 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfBERds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:33:48 -0500
Received: by mail-pl1-f193.google.com with SMTP id k15so1785240pls.8;
        Tue, 05 Feb 2019 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNQagI56FhFMGw2jj9w/A3InPy4o/Of7r+lJTHvTlB8=;
        b=goUvsaNPbVQb5VZzWq/gsEdaaaZIi9TAzh4jq2+OUTykkHLwXmcWetIIMJ5JbQQ01H
         D3lEH5J6BgoXcpIK9se4qnJ6C9sE//WcwokQ2JV2ofgCZQoJzmi77bAExcOE/q9MTMjx
         C15yBqPXwxhTHC2T2JKbDRYfEVyfk+WebChts7ela8nokTxgIRlIg23GVaeBJnuT520M
         PxXsXAYfqTDtlFUGKe48iL0baOEAdv/4fI6n3nugTSzc4FZgnuGrTFSBmVMCIWrcuWHk
         e7JjVxF7BU/PEYF2tsyO7miVxbFCKEbyIGymc8kJ2Jn7ZfGLZWwAeTozooMH9kusfZ8Y
         Yg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNQagI56FhFMGw2jj9w/A3InPy4o/Of7r+lJTHvTlB8=;
        b=HK0qCAqNtqOu0mDQOuuz0omo+FhHk6b3azUc56504XpRG12n42Ef0TKxZINjDo+mjy
         FLVhRTLFLYBKJFA0JqFELI+Ccx26o1cgw2uiTn2u1O1fn6JDHVHSjnGIjSOQprVrnc+Q
         tBT+wIzQ/tI4tJL9BmrjcQkGGUUZfaCSpJ7+UIf/tv3OBQrKgqbUsju2WH6JpzcEy3Qd
         GuGXM2JOXj2V1j1y4mvLwyrkCV+sYuwIAaOALteo9D+++uvbPb18kvlQPQ9B8xpOboPI
         X3wltOS7h4ML1OawgNF6cFVzDDao6bzPNwAni3JaN5hMewFoXfQSrj1/liZ4kR8EvmGI
         qE2g==
X-Gm-Message-State: AHQUAubiBaMjfzyNearRW4Ozff6x3pK3DZv/Dk+pAiu3ndUIr2SbYXm2
        N5SIsGHXYL1NAF3JBbjrdL4FhykdLtdqz9ppInI=
X-Google-Smtp-Source: AHgI3IZyIh34/8JHnT9Qx4VFHWJqJqyVObO0dI94QJUAa7yvkGU0fw1HbwfuY0WYAzqOk7R8dH58xeO89mSQGhIfuwE=
X-Received: by 2002:a17:902:1a2:: with SMTP id b31mr6270531plb.87.1549388027999;
 Tue, 05 Feb 2019 09:33:47 -0800 (PST)
MIME-Version: 1.0
References: <20181225193611.69216-1-kjlu@umn.edu>
In-Reply-To: <20181225193611.69216-1-kjlu@umn.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Feb 2019 19:33:37 +0200
Message-ID: <CAHp75Vd9fg0BsWj+VUj3-QRvCNZXRjtXuTiH8tpAyjz4ZEgReA@mail.gmail.com>
Subject: Re: [PATCH] wmi: avoid a double-fetch issue in wmi_ioctl
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 9:37 PM Kangjie Lu <kjlu@umn.edu> wrote:
>
> buf->length is first copied in from user space and security-checked. The
> second copy issued by copy_from_user copies it again. The data in user
> space may have been modified by malicious users.

So, we already did a check and copied not more than we would expect.

> filter_callback()
> further uses the potentially modified data.

How?

> The fix avoids the
> double-fetch that overwrites buf->length.

NAK.

> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/platform/x86/wmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index bea35be68706..93cab9a70ad7 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -850,7 +850,8 @@ static long wmi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                         buf->length, wblock->req_buf_size);
>
>         /* copy the structure from userspace */
> -       if (copy_from_user(buf, input, wblock->req_buf_size)) {
> +       if (copy_from_user(buf->data, input->data,
> +                               wblock->req_buf_size - sizeof(buf->length))) {
>                 dev_dbg(&wblock->dev.dev, "Copy %llu from user failed\n",
>                         wblock->req_buf_size);
>                 ret = -EFAULT;
> --
> 2.17.2 (Apple Git-113)
>


-- 
With Best Regards,
Andy Shevchenko
