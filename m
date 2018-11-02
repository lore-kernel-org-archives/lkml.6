Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CB4C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C202081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D49Kcllf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C202081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeKCD3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:29:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36011 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKCD3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:29:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id s15-v6so2564308lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tVKxXjtO0N2eG+gOTEhMqEDOrh2nIc46X9zeyrMPN1o=;
        b=D49KcllfBWArAiGeErutjRmhs0g0+DuP/tlnIOytn5xFaSgo0HlaqhlGrBV5gtj/jF
         YnwLI0uwOLwE3lnpmKbwd6k4UW+pBSU2Bwx5UbGlMkfXfdUXzR9fOhcEOKSlALF4gcdw
         FE57dEYQL9d1y8hECBTqcQOPVNiAEIVfFKS8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVKxXjtO0N2eG+gOTEhMqEDOrh2nIc46X9zeyrMPN1o=;
        b=DTAwsK4uH7R1A6rK0T4qIn6N2kSFybXtFdh+OP8q5Rn7ZMmMT7ZdoS4ZOLXBrug4M4
         a3lnZP60Lexy7YpY2fTgmaKxR6E3SGmq/AEuuws8XCb4rpQw/oDRjUjiPqKTyQzjzxde
         pdAvgWotY+5AsXyrk8tlO+dKcGrqe9kjCYsSyXs/xOPWfP7Fix3VtlpgAccxqJcVTYVF
         r3Ss1pep1gwmaANHSVZTHI9jjuxDzGZjBp+9NNrtysfGFZ7pE8eWOFjtv17cTi56zYgZ
         wYAAaDIBZZDKldWoGQlQshbgTz4Xdn1bCWC35SSMiZNqhlYhwfdvS5VXObG/zEDdMDGU
         NRUw==
X-Gm-Message-State: AGRZ1gLfJbDb+U/xC78pMEq6M0qC012PUlwip1IOeJywDV/xz0EA1Rhl
        ndTL18WAB2va53pUSwt/UYGbPizhuVJ5xQ==
X-Google-Smtp-Source: AJdET5fqfnlgDp6P9QtpxfKuLcdGTXtN5DUWjIJk+BBc96ZiAraT0lkRY84oV5/fVaRwcQQKrLoSqQ==
X-Received: by 2002:a2e:63cd:: with SMTP id s74-v6mr8057790lje.117.1541182856168;
        Fri, 02 Nov 2018 11:20:56 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id l8-v6sm2611546ljb.44.2018.11.02.11.20.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 11:20:55 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id u6-v6so2569342ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 11:20:54 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr8491719ljh.118.1541182853821;
 Fri, 02 Nov 2018 11:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20181102105749.GA16067@zn.tnic>
In-Reply-To: <20181102105749.GA16067@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 11:20:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_vH2iMeXjpY9D7CPh2ERd4MtssxO9XvP=svXUEdXB1g@mail.gmail.com>
Message-ID: <CAHk-=wj_vH2iMeXjpY9D7CPh2ERd4MtssxO9XvP=svXUEdXB1g@mail.gmail.com>
Subject: Re: [GIT PULL] EDAC updates for 4.20, part 2
To:     bp@suse.de
Cc:     qiuxu.zhuo@intel.com, rjw@rjwysocki.net, tglx@linutronix.de,
        tony.luck@intel.com, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 3:57 AM Borislav Petkov <bp@suse.de> wrote:
>
> here's the second part of the EDAC pile which contains the ADXL user
> and a build fix which addresses a not-so-sensical .config but fixes
> randconfig builds people do.

Pulled,

                   Linus
