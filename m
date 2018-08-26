Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24574C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46672124D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 06:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U3aOHNiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46672124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeHZKBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 06:01:05 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45023 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeHZKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 06:01:04 -0400
Received: by mail-yw1-f67.google.com with SMTP id l9-v6so4510996ywc.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 23:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d2VhD7bjWKoJjh231lsAmGJVBDBfG+JBIB1aWkxk2r0=;
        b=U3aOHNiZ93WPOPIbtZf86HcC7FDaIjD7oeseNAvMRMpl2S6itYfIM8O3T3UNGLPW/E
         Pe71i/2kyKNYxiwAlTqw3nptjJYEL6sf5bWHiaO9txwk5swtxITrUnH1kodFErrxAUmp
         PzNga473YRpGAMa73rgebRA63c3GhaZQb10eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d2VhD7bjWKoJjh231lsAmGJVBDBfG+JBIB1aWkxk2r0=;
        b=VKfF0qR9miw9DrJftiRgom56fXkddlhAF+HGvFhDmrwRyYpQsKHu41/w8C9Hryl5Rc
         XMBKsiSL6+Qajv8G0XSk/laME8EGiRF/BFrWu0LEgVUGtJhF38xvpbdzEzwwVp8FHCYR
         fPnfMOQbb9SFhP/fCxvqwxoQZKJdMpZLOzT0XyxMiUGE5RQvRy/Jmgsmr9Alk0p3120C
         1OZxkowOXHgbubfGVKjCbu8utHgoPondUTIyzc9KM+ZV8zoBL1xn994C7WWNwgMUBeIp
         1BPO1OPkHBkcZmoIYawprXfJV6AIgpLmdOhwX26t+CqQiuPzRUJH+MX36AaFxb1sDvZo
         Znwg==
X-Gm-Message-State: APzg51Dn4Tl/X/1Of6K4ea82iwMrsj4qhud6HOrVETMf6QW3JeuxBxL/
        mdPxYyabLMc7tGz9eLH2HzmhHaOOt3k=
X-Google-Smtp-Source: ANB0VdZCK+4I2Jp3rKKOFFNahLsHa9dMdSaNrL/irfP7GOYikmqPJXQ1E81Z6/uA8rZXz+EFaYggcA==
X-Received: by 2002:a81:af5a:: with SMTP id x26-v6mr4299815ywj.70.1535264373198;
        Sat, 25 Aug 2018 23:19:33 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id k186-v6sm4900564ywd.106.2018.08.25.23.19.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Aug 2018 23:19:32 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id w202-v6so4523550yww.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 23:19:31 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr4595956ywr.168.1535264371192;
 Sat, 25 Aug 2018 23:19:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Sat, 25 Aug 2018 23:19:30
 -0700 (PDT)
In-Reply-To: <20180826061534.GT6515@ZenIV.linux.org.uk>
References: <20180826055801.GA42063@beast> <20180826061534.GT6515@ZenIV.linux.org.uk>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 25 Aug 2018 23:19:30 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
Message-ID: <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 11:15 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, Aug 25, 2018 at 10:58:01PM -0700, Kees Cook wrote:
>> Via u32_change(), TCA_U32_SEL has an unspecified type in the netlink
>> policy, so max length isn't enforced, only minimum. This means nkeys
>> (from userspace) was being trusted without checking the actual size of
>> nla_len(), which could lead to a memory over-read, and ultimately an
>> exposure via a call to u32_dump(). Reachability is CAP_NET_ADMIN within
>> a namespace.
>>
>> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
>> Cc: Cong Wang <xiyou.wangcong@gmail.com>
>> Cc: Jiri Pirko <jiri@resnulli.us>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: netdev@vger.kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> This should go through -stable please, but I have left off the "Cc:
>> stable" as per netdev patch policy. Note that use of struct_size()
>> will need manual expansion in backports, such as:
>>       sel_size = sizeof(*s) + sizeof(*s->keys) * s->nkeys;
>
> Saner approach would be sel_size = offsetof(struct tc_u32_sel, keys[s->nkeys])...

Either is fine by me.

>> +     sel_size = struct_size(s, keys, s->nkeys);
>> +     if (nla_len(tb[TCA_U32_SEL]) < sel_size) {
>> +             err = -EINVAL;
>> +             goto erridr;
>> +     }
>>
>> -     n = kzalloc(sizeof(*n) + s->nkeys*sizeof(struct tc_u32_key), GFP_KERNEL);
>> +     n = kzalloc(offsetof(typeof(*n), sel) + sel_size, GFP_KERNEL);
>
> ITYM
>         n = kzalloc(offsetof(struct tc_u_common, sel.keys[s->nkeys]), GFP_KERNEL);

I prefer to reuse sel_size and keep typeof() to keep things tied to
"n" more directly. *shrug*

-Kees

-- 
Kees Cook
Pixel Security
