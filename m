Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CF0C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6F520847
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 19:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zra/xcu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6F520847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeKDE2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 00:28:05 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39553 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbeKDE2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 00:28:05 -0400
Received: by mail-lj1-f182.google.com with SMTP id t9-v6so1370561ljh.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LZ6K0dmY7ACMCIl9X3j8a+UjIOd+aMHXlnK2hzy6V8Y=;
        b=Zra/xcu/OY9dLbHciAadPA0HWMhocoT7y4r8JNzQuGbV9mEPCDWsL9ajj0ndyOTFEa
         J7wypPv3i1zygh6LhObczAPFW9fZXvIFVKDCq6aH6cIFpRKqwyTGL923xGCq1Q1y90Z1
         Xp2QZJAlxabe4viItRhnOxylBwKcJIBs5qpPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LZ6K0dmY7ACMCIl9X3j8a+UjIOd+aMHXlnK2hzy6V8Y=;
        b=Z48YLLfovnSZEXFexPUcY5RZRCf3UTE543xnzsN4VQ3JGWm3/0jI52Ksxph92eQNTy
         RsoZ6a3CUTaI6HjQIaeSpUaBYtDc9jafvJF8g7PkUu0Wkp5kQDq0JKYQKXwBoEf6qL+P
         9ovlproAlwsrXW+jUzSpwq/6igzsEGpDHtro+9buFJ8NwW+iM9LENIghT1QHkp2CgMVK
         faW9pTUb4/TpXkFY//rSWlDJpMyRt3wZTqGmhE31PtWAYiTmVTOnTOUOz1CyY61/d86g
         VCqXWMMKA8c0hFLcvJFxPINGr9ma2oExCMKr/XdDrnoBYnZFcd3cyg+b/w1eqbxAe0Fn
         HrMg==
X-Gm-Message-State: AGRZ1gINvZerFpwNTNRTX/6ygyofEVloNvz2yfKGGu0hORfl2Rp1Nf0q
        JOYGMtL99aB4M7pMJtc+qsbpkzMleRg=
X-Google-Smtp-Source: AJdET5dkc7yn/E/kWm2gk9yxt9PSTQKKQYQr6gknYF/Ef5p9tOw2RwHqzQCNpOxcHeCeVNdbf7A02Q==
X-Received: by 2002:a2e:478f:: with SMTP id u137-v6mr10510975lja.142.1541272552723;
        Sat, 03 Nov 2018 12:15:52 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id g73-v6sm1755531lje.24.2018.11.03.12.15.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 12:15:51 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id h192so3486365lfg.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 12:15:51 -0700 (PDT)
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr8837907lfj.16.1541272550897;
 Sat, 03 Nov 2018 12:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181103184528.apzyn447zjk27dat@localhost>
In-Reply-To: <20181103184528.apzyn447zjk27dat@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Nov 2018 12:15:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrhLR2Qumk=spSxqhTsr=iUmdJgWvN4GfTmY+R7-kifA@mail.gmail.com>
Message-ID: <CAHk-=whrhLR2Qumk=spSxqhTsr=iUmdJgWvN4GfTmY+R7-kifA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC fixes
To:     olof@lixom.net
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 11:45 AM Olof Johansson <olof@lixom.net> wrote:
>
> ARM: SoC fixes

Pulled,

                 Linus
