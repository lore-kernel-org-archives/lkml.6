Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE26ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FFB21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bmP+GiPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FFB21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbeIUGcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:32:05 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43011 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeIUGcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:32:05 -0400
Received: by mail-yw1-f66.google.com with SMTP id l189-v6so4539538ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oFFn2fddJUC7h/bsRsumKvXPCeb/oLa4VBcDP7kxCfo=;
        b=bmP+GiPVcF7sEsVo5kAw4mHKtI8HEKKeGwg3eM1j0BISBWBVxmlZgDx7E3Q1GG44In
         uAFN3k42YgvNTJNZrD8O1JqLOZL9OGjXZ0Wnu7tRqhNJbXQ3zgGqQ7tZ1SP+7Dr6TR1J
         TsFu1XFFIf/z+nKdQyNZfkA8EbLKr0Hc0hLTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oFFn2fddJUC7h/bsRsumKvXPCeb/oLa4VBcDP7kxCfo=;
        b=KQJIR2is0wE6tTy4Len2siyaV7cxCTZNEk4yodTsZP1f8wTL/OofOQocsSLFgBqsz0
         L996c3XKVvLULi2gtGTApKJ4J8PLJM1exkE1gbkjxwZe9xIxpM/LnQ4CAGnXy/m3jF4C
         LAdB0h8H8rS1uIiMSrJENPzfEAgQsaq5M9x1gbyYJOiyCy/rFB6EWTKVaDQBvvbiryyX
         OGsWulbSFa6IfmABjYO3CMJy9lrmgI3J7OuOmjHFpWdyZU+WIxwrvF9fSlNzAsuu99Z4
         0Kt63ij0eN5Z0EwNNcWZk1wsueNM0YMDayR51HIkA8oh9rt0d163GYE5oTBF/cF5heb7
         md4A==
X-Gm-Message-State: APzg51DOxLe9EUouQHllaXYPOLuC2OJEqeFHxI/QQVzXFkT+wGsUXwxS
        l9avZ0szGUEeQd53OvswP7irsVAB6S4=
X-Google-Smtp-Source: ANB0Vda7RtHWywFbr4LH5syXsIPFMssX0N+KAsPoi5RD57tfQz+mwgEMqBVjGnlYlpoVOOBJD2hB/g==
X-Received: by 2002:a81:a00a:: with SMTP id x10-v6mr3429437ywg.272.1537490752454;
        Thu, 20 Sep 2018 17:45:52 -0700 (PDT)
Received: from mail-yw1-f50.google.com (mail-yw1-f50.google.com. [209.85.161.50])
        by smtp.gmail.com with ESMTPSA id 203-v6sm3839403ywv.34.2018.09.20.17.45.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:45:49 -0700 (PDT)
Received: by mail-yw1-f50.google.com with SMTP id x83-v6so4551619ywd.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:45:48 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr19482513ywr.168.1537490747984;
 Thu, 20 Sep 2018 17:45:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 17:45:47
 -0700 (PDT)
In-Reply-To: <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
References: <20180920162338.21060-1-keescook@chromium.org> <20180920162338.21060-27-keescook@chromium.org>
 <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 17:45:47 -0700
X-Gmail-Original-Message-ID: <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
Message-ID: <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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

On Thu, Sep 20, 2018 at 5:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/20/2018 9:23 AM, Kees Cook wrote:
>>  config LSM_ORDER
>>       string "Default initialization order of builtin LSMs"
>> -     default "yama,loadpin,integrity"
>> +     default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
>
> If I want to compile all the major modules into my kernel and use
> AppArmor by default would I use
>
>         default "yama,loadpin,integrity,apparmor,selinux,smack,tomoyo"
>
> or
>
>         default "yama,loadpin,integrity,apparmor"

I was expecting the former, but the latter will have the same result.

> When we have "blob-sharing" how could I compile in tomoyo,
> but exclude it without a boot line option?

Ooh, yes, this series has no way to do that. Perhaps
CONFIG_LSM_DISABLE in the same form as CONFIG_LSM_ORDER? I would
totally remove LoadPin's CONFIG for this in favor it.

> When we have full stacking, how could I compile in selinux
> but exclude it?

Yup, same problem. Same suggested solution?

Should lsm.enable/disable= also become a comma-separated list, or
should I leave it as a multi-instance thing like I have it?

-Kees

-- 
Kees Cook
Pixel Security
