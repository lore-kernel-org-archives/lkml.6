Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAA6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F412146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QgyJhZuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F412146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbeLFD30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:29:26 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37581 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeLFD3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:29:25 -0500
Received: by mail-yb1-f196.google.com with SMTP id w129-v6so8462047ybe.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 19:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qz0iHDOQdmAgLsWyv26sDjQ5BsVIN1ZLYLmtT96KFM8=;
        b=QgyJhZuqxGg1/GqrMBjc3T/1RxldoBuq+JAs9SKptCM5Q1TmC2vA0JAQAJ3buOVLYV
         +KV+cdK16hPmLEsxVkFSygTv73rfH+ZtRGAPyliDLgmHgLcoyzj7ILzvssvprP+ay7vB
         fQncLYcvVOw7LInGXKSlUN5Pxyk2+MS+e/SD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qz0iHDOQdmAgLsWyv26sDjQ5BsVIN1ZLYLmtT96KFM8=;
        b=G3U2NzObLpbp88nSduy1H8Fsl/oKwW6bCEH1JjIwcs/skiML1hh0+xbV9P1OeuP476
         lK1sHcnIVnJNz7uc5IxkyTC4w/xzgUo1x7R+bfPcZU6dMdFHw+IqopmzOu+DoHSVrii4
         9qDvRuOevh1JEaxx+ibCi2oi3egjydYfiCDrh3mx4x1/ynGMBgkRzUZwumM4r7BLVLnn
         U2iDN1LyXeSbQ5jO1HPiZkRxM2jMjXU1yDu6T4MNPXbCHMff/7csOpE9PNgS3zUT5wXl
         zoxgKXvkKy6zxBWAvEOu2fs4fhuSc2dEZ/hsz5/6+hvGv9Mp6RFuFLth/RA9LUKLSr6n
         pUKw==
X-Gm-Message-State: AA+aEWaiYKJvq7WnZQTrhPHCdq+syaC+1yPZRIKB0prOFRqqpL3oIhSy
        MTZPA0Yeq1VXaZSici8Wq4Yl4nWWlBM=
X-Google-Smtp-Source: AFSGD/XbhBpqhD5i0j5mHnR5crrdH8PzXso0bw2R0p5FG61jfcziaYht94qfqISSySn1PfLY9P19Ew==
X-Received: by 2002:a81:4cd2:: with SMTP id z201mr27916563ywa.161.1544066964870;
        Wed, 05 Dec 2018 19:29:24 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id g127sm6720532ywf.38.2018.12.05.19.29.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 19:29:23 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id n134so1175963ybf.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 19:29:23 -0800 (PST)
X-Received: by 2002:a81:c446:: with SMTP id s6mr27887278ywj.237.1544066963294;
 Wed, 05 Dec 2018 19:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20181130150859.27366-1-anders.roxell@linaro.org>
 <CAGXu5j+-w1qh3Jg6u8jM0XxFS-X4qJpzOtf_HO3eEjohL1dj=w@mail.gmail.com>
 <20181205212651.488d9cd4@vmware.local.home> <20181205212945.58edee31@vmware.local.home>
In-Reply-To: <20181205212945.58edee31@vmware.local.home>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Dec 2018 19:29:11 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJeyBRHPhKKRyp1=NCCdBfrJw=mdg4+XCEL413ZtkyU1A@mail.gmail.com>
Message-ID: <CAGXu5jJeyBRHPhKKRyp1=NCCdBfrJw=mdg4+XCEL413ZtkyU1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] stackleak: mark stackleak_track_stack() as notrace
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 6:29 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 5 Dec 2018 21:26:51 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Wed, 5 Dec 2018 17:08:34 -0800
> > Kees Cook <keescook@chromium.org> wrote:
> >
>
> > I'll Ack the Makefile
> > change in the tracing directory, but the rest belongs to others.

Okay, I wasn't sure. Anders's patch was marked "1/3" so I thought it
was directed at you. :)

I'll grab this one in the gcc-plugins tree.

-Kees

-- 
Kees Cook
