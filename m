Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854AEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494822086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494822086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeKHHRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:17:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46743 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbeKHHRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:17:19 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so23088616qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 13:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bl4XBzChAiSJPUt2k5QMhkayMvCShYfg/vrTQSrWxCc=;
        b=FkUcJ5L7cLRfFdmLPtTiggzxzR7VmjZzi3eQq+4WVP1nIX9p6nywW2VIiIlvD711TT
         9VlCtDmo1UqNjJ95/depACgqUskDmE8/Pia0TOTtH81XWPBD3ePHAQD2Z0M/oa5u3iqB
         0+fPJ7pbWUVgZMDm2vvFCB+D2GD1gfBnGVbzvUur7ANK2wbu5EkRaT/wITIbxPxE/r6v
         BcK69TiHXtOd8e8a/CU89eIjAAieY5jeaKatAyxRHoup/ZBdLRPOBNd/RjfWtiE5O3QB
         MeZX85QAD2qBs8EOAlt5ZKxuI5f10UDFMv/L95WrrBvkFMNraemejY8qfLfIzDN8/0Xg
         hGPQ==
X-Gm-Message-State: AGRZ1gIaW1TUlHG72c5N24JVuO8GitD7mbcQMcT+NeBHJXIIAN65FusF
        g+VyMCbAeRcdaCirCJY/RN64C0WOb/54ExWhYS7WDg==
X-Google-Smtp-Source: AJdET5cKSGdqm9pAsI6W09yvnZ3pdpzBlroHEPRcEncDlbsNX5MyWrTuWdtqmRzR67PglfqVXO2kndXGn6621CwKOgA=
X-Received: by 2002:ac8:410a:: with SMTP id q10-v6mr1919392qtl.96.1541627102347;
 Wed, 07 Nov 2018 13:45:02 -0800 (PST)
MIME-Version: 1.0
References: <CAOesGMi-vkYPDrL2drJ70zf3_xTMWrsfPoW68TkiRJCj8uWBLg@mail.gmail.com>
 <20181107144516.4587-1-aryabinin@virtuozzo.com> <20181107125517.b5677f03a9a1978a5d179c9a@linux-foundation.org>
In-Reply-To: <20181107125517.b5677f03a9a1978a5d179c9a@linux-foundation.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 22:44:46 +0100
Message-ID: <CAK8P3a23=C7joXFNr6P-1ap7Fkpz=umTAtHBH++YJ5VNC7AzzQ@mail.gmail.com>
Subject: Re: [PATCH v2] ubsan: don't mark __ubsan_handle_builtin_unreachable
 as noreturn
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  7 Nov 2018 17:45:16 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
> > From: Arnd Bergmann <arnd@arndb.de>

> > --- a/lib/ubsan.c
> > +++ b/lib/ubsan.c
> > @@ -427,8 +427,7 @@ void __ubsan_handle_shift_out_of_bounds(struct shift_out_of_bounds_data *data,
> >  EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
> >
> >
> > -void __noreturn
> > -__ubsan_handle_builtin_unreachable(struct unreachable_data *data)
> > +void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
> >  {
> >       unsigned long flags;
>
> This code has been here since 2016 and presumably people will want to
> build older kernels with newer gcc's.  So I'll add cc:stable, OK?
>

Yes, sounds good. Thanks,

      arnd
