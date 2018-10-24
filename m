Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2196EECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40B6207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 16:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UFk0NgDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40B6207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeJYBN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:13:56 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:36984 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJYBN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:13:56 -0400
Received: by mail-ed1-f50.google.com with SMTP id c15-v6so5706071eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=q2yGdz+mJj2rfUfrEziegu6tNONEGcD2TOJVIMOid1g=;
        b=UFk0NgDoyizIPNaBDTm5rI/EiWhwlUEJq3o9xBHnn+kD1u2tnuYITLpjeT5aeVtPoX
         ijTfGS9p36xIJ2fiR1l8tu4xEW7cJ6ufd2S/dtpYKxYQFYUJPAYOKKW+BjXIDK8ojfqk
         mkC+qjoiqbNKSBs1VxtowMoA+HI+UGz2ZHxpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=q2yGdz+mJj2rfUfrEziegu6tNONEGcD2TOJVIMOid1g=;
        b=WHDIfbB6do93iKklm6VA5lJNOsdVfIVQmkBukXA5lumQBcHdllE/adKpjCz0VPGXGM
         k313T/wkKKoyPAFe8r0JLHJJhnLoR1HpOEKBy5V8ugoQ5XjLs+jmM0ymFtu1LNtMymag
         /DaOjcIGw7xitjM1i9qNcVt3KD9mkaqISQaQw193UWPB4xCyrNRMLdYnLDfUbm7UMHp0
         tBl5HF1ExbommP57jXU/KDS2Re/j3bAXsT2mhDkP4LmJkBQiwUIba9oRv0TZQsuGpxM9
         gfe329QIqogISEBWl3//Gqc+Ko5BiH2Eq+MQJIGKZTsktRqyTe3/091QOXHbh4lAGX8C
         XCew==
X-Gm-Message-State: AGRZ1gKWmmbhyx8PD0vsNpvt9Xogx8EaF2tqU17RaS5QdtLg3+EMfKFI
        31/ZfHa5cC3hmhyXmMZ6u77kDAVaj2svl/Mu
X-Google-Smtp-Source: AJdET5fh2gqHlQk/HPk2uipBYsaNQzWvhCtW5uJ+Lg6ShDtXFgVbJt9HzF2Ni+qY9IF6WWBKp4NKJA==
X-Received: by 2002:a50:ab55:: with SMTP id t21-v6mr3217316edc.293.1540399506933;
        Wed, 24 Oct 2018 09:45:06 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id v16-v6sm1865077edm.49.2018.10.24.09.45.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 09:45:06 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id i8-v6so6096094wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 09:45:05 -0700 (PDT)
X-Received: by 2002:a1c:2351:: with SMTP id j78-v6mr439312wmj.62.1540399505529;
 Wed, 24 Oct 2018 09:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181024144735.GA28816@thunk.org>
In-Reply-To: <20181024144735.GA28816@thunk.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 17:44:47 +0100
X-Gmail-Original-Message-ID: <CAHk-=wgtz3Xamn_RT0hzBbEhsXyB2yWJ_M4vCRnJRT1du-otdw@mail.gmail.com>
Message-ID: <CAHk-=wgtz3Xamn_RT0hzBbEhsXyB2yWJ_M4vCRnJRT1du-otdw@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 updates for 4.20-rc1
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 3:47 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Further restructure ext4 documentation; fix up ext4's delayed
> allocation for bigalloc file systems; fix up some syzbot-detected
> races in EXT4_IOC_MOVE_EXT, EXT4_IOC_SWAP_BOOT, and ext4_remount; and
> a few other miscellaneous bugs and optimizations.

Thanks, pulled,

               Linus
