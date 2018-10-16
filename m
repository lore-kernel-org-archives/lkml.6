Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35915C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95612147C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y0mi1RGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95612147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeJQG3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:29:09 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45971 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJQG3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:29:08 -0400
Received: by mail-yb1-f193.google.com with SMTP id d9-v6so9568174ybr.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U86G+ibE9JzozH+yr+YgfkA7ZqiHsJU7JPhTuy6hUpY=;
        b=Y0mi1RGk7oJ7zc80a9Zcz4EIi/bHU50eNWwU52zq5WeN1DXf5fmbQ+EmaCLiI7Qrr0
         9mvjmji1KgeBs8aDe7A/oNbWbPk96fKd3pmUkTm0uNSnuj+UQBDblJdyGuv8I9YfaH3l
         czNLa0UzeGcsGvXSmzV1z3dhSxEqxwX+S/KPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U86G+ibE9JzozH+yr+YgfkA7ZqiHsJU7JPhTuy6hUpY=;
        b=CD8MTE0uI5XgsKvl6K2+7RfLCo0zOdi9842Qk2flOSibprfidTWnUkM5AJfzkeW2nD
         z+5tDT3DoKWv95iHrdUcgsWQIEIaMO0FfgS4OifXvxtVr84wrHBHej1D/ofHmNwu82HL
         kluk6/+ZSvuSfTFviQLPljInYl/c5VPyo/OZqHaBhEmUX48Ycs+ETMIm3sx9CWXw9knk
         EGvRKcpb/rIs2sYvILDJArdc0jonbAsOUVMGs5mLuhqCc/ppwotx45EUNbvrOuN5K4Ko
         Yq8rpgUKaraMz13mGesyEJ3rMYt7/8tm0fRd73nOvBXbi6WyjEQsgVQliZqwC2MpAInX
         +GHA==
X-Gm-Message-State: ABuFfogVJYFJ3t1WUcXJcLfxvtF2+17ydTSJdAh6RPme6XJ4JIioQCbq
        CQoYx3OIM5FTb3CM17BnjGHvwJs9svM=
X-Google-Smtp-Source: ACcGV61/2pvMDEvkdvpu+gZOiv25U/ETE/sRyxu3lXuAwrLRh7WONKXvCc5qIiS6/3ZDopxDkYBeeA==
X-Received: by 2002:a25:f805:: with SMTP id u5-v6mr12403633ybd.193.1539729394009;
        Tue, 16 Oct 2018 15:36:34 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id 203-v6sm4080616ywb.58.2018.10.16.15.36.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:36:32 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id d9-v6so9568127ybr.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:36:32 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr12914175yba.410.1539729391978;
 Tue, 16 Oct 2018 15:36:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 16 Oct 2018 15:36:31
 -0700 (PDT)
In-Reply-To: <20181016223322.16844-1-christian@brauner.io>
References: <20181016223322.16844-1-christian@brauner.io>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Oct 2018 15:36:31 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ5RM6V3aS1SEznwLuDrjdYieaR3vwvgZA7nJ8i0J-Kkg@mail.gmail.com>
Message-ID: <CAGXu5jJ5RM6V3aS1SEznwLuDrjdYieaR3vwvgZA7nJ8i0J-Kkg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] sysctl: handle overflow for file-max
To:     Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 3:33 PM, Christian Brauner <christian@brauner.io> wrote:
> Hey,
>
> Here is v3 of this patchset. Changelogs are in the individual commits.

Thanks! These look good. Andrew, can you take these?

-Kees

>
> Currently, when writing
>
> echo 18446744073709551616 > /proc/sys/fs/file-max
>
> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> crashes the system.
>
> The first version of this patch intended to detect the overflow and cap
> at ULONG_MAX. However, we should not do this and rather return EINVAL on
> overflow. The reasons are:
> - this aligns with other sysctl handlers that simply reject overflows
>   (cf. [1], [2], and a bunch of others)
> - we already do a partial fail on overflow right now
>   Namely, when the TMPBUFLEN is exceeded. So we already reject values
>   such as 184467440737095516160 (21 chars) but accept values such as
>   18446744073709551616 (20 chars) but both are overflows. So we should
>   just always reject 64bit overflows and not special-case this based on
>   the number of chars.
>
> (This patchset is in reference to https://lkml.org/lkml/2018/10/11/585.)
>
> Thanks!
> Christian
>
> [1]: fb910c42cceb ("sysctl: check for UINT_MAX before unsigned int min/max")
> [2]: 196851bed522 ("s390/topology: correct topology mode proc handler")
>
> Christian Brauner (2):
>   sysctl: handle overflow in proc_get_long
>   sysctl: handle overflow for file-max
>
>  kernel/sysctl.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
