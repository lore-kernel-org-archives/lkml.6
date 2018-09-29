Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856A2C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2632A2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aw7LOBlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2632A2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeI3AsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 20:48:09 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42999 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeI3AsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 20:48:08 -0400
Received: by mail-yb1-f194.google.com with SMTP id p74-v6so4019843ybc.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=was+uRWAqpm9gQzap61cLsWwW3x6Tph2Eq+orYTfcUw=;
        b=Aw7LOBlmhS51Eg+gIwJC41hvWLpbtD58tOk/ZyW8YE89sNay89KHgK6EHODChdBIR0
         wrSE/rFpM7/BkIvvAxNU764fFC95h3dBzhvfhYUMGm4razQbHQ6AfGuqku59psbEpF+F
         BuzUmsJneBrK3aVUH4DOfoAeL2gar3TENzDXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=was+uRWAqpm9gQzap61cLsWwW3x6Tph2Eq+orYTfcUw=;
        b=ra8Txerorvdar9w/jj8FJaVffbhH0ZIfIFyBx5QjUHCP7LpzPHgiiiMijbKz+tcaQo
         dZPZXifQqpMI3BdnZSRU3QjWeBDoeG0O2FJ1yZiYXmUdiVVEe9o1MDS6LCoeFB6BZnly
         5LLrOFaiuPKVGwyp7otNL0HVAL6MvAMAQUwtm3G8oRFHZakndyPvjDESqwHziMyIdQCY
         NyXQ8qUpgbD+lYQlpJUI4urvt1FOy/vemTQLJnaXnH/1kmj2REwJdQfgK2sM5ZCc9o94
         N7H70AqYaDgan4DS9a67IPctHb+IDCjgrhTRZtevmbdNLxdLL67zV1DINOUeBGPbFoek
         wQfA==
X-Gm-Message-State: ABuFfogkgXHBR3DnJKXlAxUzSONTboiwcLp8u7nx+sVWGL6Oz/yJ5v3g
        lI9SUI73XsaCbMU4CJPCCCIS/k5n4I0=
X-Google-Smtp-Source: ACcGV62zWyWjjFw4a8pQXzl4iOlcu+hLOq4d68AIlrCU7CBGRKYxu6dqnWUCV5bkXWFIuF6VXF2YOA==
X-Received: by 2002:a25:dccf:: with SMTP id y198-v6mr2141020ybe.389.1538245123533;
        Sat, 29 Sep 2018 11:18:43 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id 137-v6sm4614821ywo.54.2018.09.29.11.18.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 11:18:41 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id s73-v6so3954113ywg.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 11:18:41 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr2258624ywr.168.1538245120949;
 Sat, 29 Sep 2018 11:18:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Sat, 29 Sep 2018 11:18:40
 -0700 (PDT)
In-Reply-To: <eda428eb-f6e1-f048-a394-251953c388b6@i-love.sakura.ne.jp>
References: <20180925001832.18322-1-keescook@chromium.org> <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
 <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com> <eda428eb-f6e1-f048-a394-251953c388b6@i-love.sakura.ne.jp>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 29 Sep 2018 11:18:40 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLUaFX_jPHoOq1abEAjJdLo29Hr2q=sk07yj4KytW6psQ@mail.gmail.com>
Message-ID: <CAGXu5jLUaFX_jPHoOq1abEAjJdLo29Hr2q=sk07yj4KytW6psQ@mail.gmail.com>
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 3:48 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/09/29 5:01, Kees Cook wrote:
>> On Fri, Sep 28, 2018 at 8:55 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 9/24/2018 5:18 PM, Kees Cook wrote:
>>>> v3:
>>>> - add CONFIG_LSM_ENABLE and refactor resulting logic
>>>
>>> Kees, you can add my
>>>
>>>         Reviewed-by:Casey Schaufler <casey@schaufler-ca.com>
>>>
>>> for this entire patch set. Thank you for taking this on, it's
>>> a significant and important chunk of the LSM infrastructure
>>> update.
>>
>> Thanks!
>>
>> John, you'd looked at this a bit too -- do the results line up with
>> your expectations?
>>
>> Any thoughts from SELinux, TOMOYO, or IMA folks?
>
> I'm OK with this approach. Thank you.

Thanks for looking it over!

> Just wondering what is "__lsm_name_##lsm" for...
>
> +#define DEFINE_LSM(lsm)                                                        \
> +       static const char __lsm_name_##lsm[] __initconst                \
> +               __aligned(1) = #lsm;                                    \
> +       static struct lsm_info __lsm_##lsm                              \
> +               __used __section(.lsm_info.init)                        \
> +               __aligned(sizeof(unsigned long))                        \
> +               = {                                                     \
> +                       .name = __lsm_name_##lsm,                       \
> +
> +#define END_LSM          }

I wasn't super happy with the END_LSM thing, but I wanted to be able
to declare the name as __initconst, otherwise it needlessly stays in
memory after init. That said, it's not a huge deal, and maybe
readability trumps a tiny meory savings?

> We could do something like below so that funny END_LSM is not required?
> I felt } like a typo error at the first glance. What we need is to
> gather into one section with appropriate alignment, isn't it?
>
> #define LSM_INFO                                                        \
>         static struct lsm_info __lsm_                                   \
>                 __used __section(.lsm_info.init)                        \
>                 __aligned(sizeof(unsigned long))                        \
>
> LSM_INFO = {
>         .name = "tomoyo",
>         .flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>         .init = tomoyo_init,
> };

I thought the structure instances would need a unique name, but it
seems the section naming removes that requirement. This seems only to
be needed if we had multiple LSMs defined in the same source file.
Though I wonder if this would be a problem for LTO in the future?

I'm happy to do whatever.

-Kees

-- 
Kees Cook
Pixel Security
