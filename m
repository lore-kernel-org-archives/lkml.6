Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A72C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C95120645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEx+v9d7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C95120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeICUQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:16:34 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34810 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeICUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:16:34 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so1748637ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t5xY7Vae4HKvINYsvO3fZQP8lgiWdqs2dqQFegZ4IiU=;
        b=BEx+v9d7ep2jl6xpOT4tZEvz2R28GzNAyJx7lSVK4J0Jn+jwXjcEBwilKJqf8AVEtF
         DNj4JR6Vy9ySLywm0rX1jt0NIr1blSGDbJNpzqbBENzsW3m4RSLVm3ACHwYYqqIkVHty
         5HjUUphSEvGCZrR7LLIf3Jhxsq46BLsnk8ZInmbxNigLG8ovAdINiGsnjp6MOwV6dunZ
         to5ijbNH5BZBX1IzxlUvWjxJVCKGrsqOAhZWIHPmRRGCwbGUMq397UfaZj9SPnpBCakc
         +GVWh9OgOar2dLBlhZLTLa+GzuZh7QWBeBPfGcjn/HyRdQdYUjzrr8NWavUCwuYksJiL
         ENpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t5xY7Vae4HKvINYsvO3fZQP8lgiWdqs2dqQFegZ4IiU=;
        b=Ur6INZFaQZ57sVyUfD45IcApFBUrfTXm+tUimjnoD3BYwb89f5n9Gcc6UafoarFGr4
         HcmdeXg5FdreYh32yv6+bSpFofbB2vLZCsudmSGaRfh/KKB4Bzg3JAdEZff3JsMIegCi
         6Hwa6k/m6xPgTFucY7VGjAEvoipvbO0RMjXvj3FZPCkayK4Bpu2JX3OrvtPAcKzUwedv
         FgKNiY30Bvlk+f+T5F3A7Sr2T3E8kdcZBrwEm5i4eEZ3VdRsVSQ894eSMJbv5WY2Dcx5
         wakUvmumCY+rKbm1zoHi509Y4aKcODcKVk/a0I18BZBb45hBkW9RKMvcpipyqw9hlinL
         tMPA==
X-Gm-Message-State: APzg51BNb1tLPQOwUI1qTXKstQ+AXIg2xLZrnjr9Ry329rK37co1HtXS
        4VeZ07DbVayEfzlDZDH/y/jb2G3H74ppPa4sNGu8j2yn
X-Google-Smtp-Source: ANB0VdaM+ZBCcTKlVKDmhTqTdXHL1SpR80DRyhCQYfDMMpnIOYcyug81sfuyXqCyKXh/NJNOB7kTuS7KO7oQv1C6fdA=
X-Received: by 2002:aca:4784:: with SMTP id u126-v6mr20906606oia.229.1535990149369;
 Mon, 03 Sep 2018 08:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180706151649.31119-1-jannh@google.com>
In-Reply-To: <20180706151649.31119-1-jannh@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 3 Sep 2018 17:55:23 +0200
Message-ID: <CAG48ez1etiHmD-e9szTEApia9YhUFomCcZM3Yp9wj9xrDWKmzg@mail.gmail.com>
Subject: Re: [PATCH] firewire: nosy: don't read packets bigger than requested
To:     stefanr@s5r6.in-berlin.de, linux1394-devel@lists.sourceforge.net
Cc:     kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 5:16 PM Jann Horn <jannh@google.com> wrote:
> In general, accessing userspace memory beyond the length of the supplied
> buffer in VFS read/write handlers can lead to both kernel memory corruption
> (via kernel_read()/kernel_write(), which can e.g. be triggered via
> sys_splice()) and privilege escalation inside userspace.
>
> Fixes: 286468210d83 ("firewire: new driver: nosy - IEEE 1394 traffic sniffer")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> No CC stable because this device shouldn't be available to unprivileged
> code by default and should be pretty rare.
>
>  drivers/firewire/nosy.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
> index a128dd1126ae..732075fc312e 100644
> --- a/drivers/firewire/nosy.c
> +++ b/drivers/firewire/nosy.c
> @@ -161,11 +161,12 @@ packet_buffer_get(struct client *client, char __user *data, size_t user_length)
>         if (atomic_read(&buffer->size) == 0)
>                 return -ENODEV;
>
> -       /* FIXME: Check length <= user_length. */
> -
>         end = buffer->data + buffer->capacity;
>         length = buffer->head->length;
>
> +       if (length > user_length)
> +               return -EINVAL;
> +
>         if (&buffer->head->data[length] < end) {
>                 if (copy_to_user(data, buffer->head->data, length))
>                         return -EFAULT;

Ping. I sent this about two months ago, I haven't received a reply,
and from what I can tell, it hasn't landed in any tree so far...
