Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05726C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6532083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CzR9n/da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6532083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJYVyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:54:10 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:36686 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeJYVyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:54:09 -0400
Received: by mail-lj1-f178.google.com with SMTP id s15-v6so8208252lji.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u84YuxG0qsepQ+OAH1YrPHS+zxp2d+oy7f4Ep7QIlLg=;
        b=CzR9n/da/6PChr7RgZxMvgefViRaCO/Eik8ztx6ksISwQ3LZvve4BX/s6kMpqMzn8Z
         8hHHFxuy3Ecq3s9swKBQJ7Yc8MZtcDpRVqHy0IoguqA1v99CCSXFoi/d60OnFGyG+skw
         /U0UHhvwtZvUmJrCDsdxvq2fms8M/rcqSmPE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u84YuxG0qsepQ+OAH1YrPHS+zxp2d+oy7f4Ep7QIlLg=;
        b=MRcEDtds5WPOk3TDOFb3jnvFTuam8CNApvGl8n/+prUNsiww6grpAFmUOYgrVSxT62
         agEM7B4HuV+mrApPDOfpV5UYSWqXWY4Vq0GBJrksEJl9uGk0PxUly/8AxC8lpHYYikH8
         MgXBHvC6Svcg562ZY6beBp6vq8XFYV/vloS/BvR1EvROq7YZokcchXkR95xsN9RwQIA3
         pNwEd2mp85R4WJosvHbzPpaDjD2GKayAhkyXxeFbpRRqpLTHksSU+z/GIQxe/TKisvwm
         /b2u2pjCJddoHnhYzOVFrbXPmF8G85dPiNxivBxQ7O701BDRqi+w/2n9Idy6B3Bjh0pu
         85pQ==
X-Gm-Message-State: AGRZ1gIhqnJRPY2mbS1Ut0MM43AA305niFkgdKQH6PfUOLCpDtltuFhb
        ZKtwhGJt/lIZgntgJS3jVjwou2zWQmJ9Quhx
X-Google-Smtp-Source: AJdET5dpJa9DFDCTLQ6CPZV3476PIla2WyrSYcfPLY/6DzVkrBed/Al8mPJP/GCYjMEqRjj0yPp/gA==
X-Received: by 2002:a2e:501c:: with SMTP id e28-v6mr1262236ljb.45.1540473683735;
        Thu, 25 Oct 2018 06:21:23 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q2-v6sm1227288lfc.67.2018.10.25.06.21.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:21:22 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id c21-v6so2314489ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:21:22 -0700 (PDT)
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr1355387ljj.80.1540473682329;
 Thu, 25 Oct 2018 06:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181023104616.GX4939@dell>
In-Reply-To: <20181023104616.GX4939@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 06:21:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjooEEnj+wS3gEqA8XfzWyZKC4P0j5Rby5zcUV6NZg-bw@mail.gmail.com>
Message-ID: <CAHk-=wjooEEnj+wS3gEqA8XfzWyZKC4P0j5Rby5zcUV6NZg-bw@mail.gmail.com>
Subject: Re: [GIT PULL] MFD for v4.20
To:     lee.jones@linaro.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 3:46 AM Lee Jones <lee.jones@linaro.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-4.20

Pulled,

                   Linus
