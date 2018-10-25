Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E3C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672B920848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fNCpHcsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672B920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeJZAi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:38:56 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:34670 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJZAi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:38:56 -0400
Received: by mail-lj1-f173.google.com with SMTP id c21-v6so2868657ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+KmQindPDJfQDBGESNKrogrtKZsYbgVV5EqnrMWbVc=;
        b=fNCpHcsZ7A/hOmHM5zQl74M7HAxqJoMyJzWZdC5Ky89se5qlFz16pc3UBiHj42Hch+
         QWLs5ILEobW4QlYILhNS6a4+JImlIpJjWZ5dxy3g7UY028ISB9ucae1ZCp86gLfSaZp6
         McsuJv6Fv908m8FzTwJncyDTbekhd/SXvKaEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+KmQindPDJfQDBGESNKrogrtKZsYbgVV5EqnrMWbVc=;
        b=KysdcGjsw57gPWvxSruOKKL/6HQkGwxQw8E0/XGzibjSUeadxM/idUbRpHGpLBNPLc
         AsYxR8WSlpS2zw+bNBDIaMOmzl0GTSeui6YOe7ZG0DEh/bdRTgfWDqH/8C0KO2mU8TTj
         bzOJGRrmeJrc/hyu18LzC62AmHnzsYNlC5Jq37mDSv6pSzvlnq5qLZIFYuTwS7e+mjOP
         dApWgfI6j3CTD3ntnCbsXc33RA7zn/UpfZ9aUqtnwUx98VR0hH9v85KZGSh0A970Wv5O
         sIIVam4ef/aUvGQH8ADvRoOVsax+Z1Di2/aMDBGmdvno7CIuNavG6/+uEP1BWhn7ZW4n
         /seQ==
X-Gm-Message-State: AGRZ1gJ7aX9FcteHLNHf8QVjgmJguyVGkD6fvd/jf97H20DzbVzRKQMD
        cLkGsWwhkntt25VpzU2QydG456UUOIjcrxBb
X-Google-Smtp-Source: AJdET5dgCodHuHu9d4sNtbtGfJeWtxGhlR3BvJRQumCGiSPRquKNvtj8QdkzK01kj+ePYQww0YHAAA==
X-Received: by 2002:a2e:2997:: with SMTP id p23-v6mr1724481ljp.12.1540483528818;
        Thu, 25 Oct 2018 09:05:28 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id d199-v6sm1496249lfd.20.2018.10.25.09.05.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 09:05:28 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id n26-v6so7236032lfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 09:05:27 -0700 (PDT)
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr1512061lfj.16.1540483527267;
 Thu, 25 Oct 2018 09:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <s5hk1m6o5or.wl-tiwai@suse.de>
In-Reply-To: <s5hk1m6o5or.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 09:05:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZfOtoMZoaxKFjfK1Qm8sQ7aDUjzxyu+5oYCDT2f1YmQ@mail.gmail.com>
Message-ID: <CAHk-=wjZfOtoMZoaxKFjfK1Qm8sQ7aDUjzxyu+5oYCDT2f1YmQ@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 4.20
To:     tiwai@suse.de
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:18 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> There have been little changes in ALSA core stuff, but ASoC core still
> kept rolling for the continued restructuring.  The rest are lots of
> small driver-specific changes and some minor API updates.
> Here are highlights:

Thanks, pulled,

                           Linus
