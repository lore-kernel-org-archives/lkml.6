Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99812ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534702075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YToJQCb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534702075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJYVzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 17:55:24 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:43736 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbeJYVzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 17:55:23 -0400
Received: by mail-lf1-f53.google.com with SMTP id p34-v6so6761563lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKReeOsO9rTSX2/+HD0dTwfMN38P7ZVcm3lVI26+qyI=;
        b=YToJQCb5jrdKGWvooa6wDyqoNJSoDRE0RGoAXcj5Ibq/g4xl26amIml3MDOxMatYa9
         D14N0NgSlmNVpOHGKAAvFF7e1YKPwKEcnvt78rv68x6YEULulRmL6Qlc+I+QLU++3rhN
         xIbV7O6E9FPf0N4ydqpPwDsT+F6vpbHxOjxzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GKReeOsO9rTSX2/+HD0dTwfMN38P7ZVcm3lVI26+qyI=;
        b=UsMZ0CPfdiIPs1UsL3e1zVeWDj3T+EnQyg8forMG+VkyOqYbRoI7E5STpLf0iVTgU0
         VIii51x4oRL9DKkjcxDuxX3xf4A4vxZL7VXsx4GHMv928f72bbKYNwwJJw8eaLoguhH9
         tD3Ddh11gw38GVfGMpc15l8RrTUPlmyI+0etwu/1T7zQdSkvQNyiir+3nl2XwinCCdZ8
         plmiIBrtjK1g6HHdtIkweDyqk/zFSwl+z0MhN540BkaLpbXPNh+qd6hLRfhA6extE5g2
         ccpVWXSufq8KF0tWr3Zp9TQWkTVfYXiTgu1l2rEUq0D6NNPtk+Q5WDrS1syU9cTOOPqQ
         Y4Dg==
X-Gm-Message-State: AGRZ1gJ6g/oMi5KodHTBM1jdzOSp+lwzYYibDlRVp+TQJe9l1fHD3J+L
        VKWQ++6tmejFxCeTOqTsRlIRgM2ff1ABGPRD
X-Google-Smtp-Source: AJdET5fZPx3oKh/cYFKq2Rw/XY4O+r3nnlo0KfJyiRtg4Y0bpPR/6ciHUgJ4pURn12xEEWq+SuB9eQ==
X-Received: by 2002:a19:d155:: with SMTP id i82-v6mr1155006lfg.127.1540473757455;
        Thu, 25 Oct 2018 06:22:37 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id i11-v6sm257782ljg.84.2018.10.25.06.22.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:22:36 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id z9-v6so3356990ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 06:22:36 -0700 (PDT)
X-Received: by 2002:a2e:9d89:: with SMTP id c9-v6mr1175083ljj.120.1540473756147;
 Thu, 25 Oct 2018 06:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181023111355.GY4939@dell>
In-Reply-To: <20181023111355.GY4939@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 06:22:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whdOoh6WueWuZc+==jP1geZLNdXaCyPcMfs=BFW=WUi-Q@mail.gmail.com>
Message-ID: <CAHk-=whdOoh6WueWuZc+==jP1geZLNdXaCyPcMfs=BFW=WUi-Q@mail.gmail.com>
Subject: Re: [GIT PULL] Backlight for v4.20
To:     lee.jones@linaro.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 4:14 AM Lee Jones <lee.jones@linaro.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-4.20

Pulled,

               Linus
