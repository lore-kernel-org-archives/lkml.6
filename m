Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EDCC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A817720685
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c/UIEtt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A817720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeKDDBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:01:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42488 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbeKDDBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:01:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id q6-v6so3400608lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfQZQNNDFPmOm/50cz/yR6zG+3Lj0nXWSn0gXjhxuUk=;
        b=c/UIEtt1PZRhizUf+ycDR9haY1tE70kw6WLx2a4r3kGg8vFfz8nK8oC+B/4S3ohIan
         uvwjMIm3a3ALmIFotwShrpqQePgS3JmZ4jz4UqkMGl0YXTYFQI1VZGQDmuzpaoqbOxPo
         8kbCuXxBCFXnk0KZYBbCUx61WjcfReNBAEGKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfQZQNNDFPmOm/50cz/yR6zG+3Lj0nXWSn0gXjhxuUk=;
        b=KdrMosOdzpjinh7nUm83D18KzwPnqcq8oh1TL6YjoYtyoeiiSxRhdce+AgXeNh9Cgs
         /KMMpG5Bohy+Dfer+hAqYJwkinqBQ7jcus+lzr7fiprxzePnp7Q711ONrcxcqUEpzSPm
         XGCQ7jM21qW9AKRmmJw5LbbO3LGfR39ee2RoXWNHTjBZUVfUw1SfTKMMRg+sbLCnhy3f
         eg367plcJE6MrJR+PbnfCEztIedvQZA5yC2/dIa41uM5mbXGKrIRzGrCTLpF3YRfl2eu
         NPicZv7TeApBnb0TJApd5bPUfxGs6TcMI8Sc8L6kJh8yynma7repaOTCHJgw2EwCr5Nf
         aVhQ==
X-Gm-Message-State: AGRZ1gKuL8BJmicIlpYC5ixdmyLeWpKDUKqMcfzxO4exIAFdYXYul/oN
        +OurLwhwt3J/mtFqm3mxouDc3PHi16af9w==
X-Google-Smtp-Source: AJdET5fEefOmUeB/X3Obq/woeZzoHbeYpuvZ/I0BbYKRqjvaJ9Oj+nEJ0NVxWwCCqDQzwsvidrEUyA==
X-Received: by 2002:a19:a9d2:: with SMTP id s201mr9008241lfe.154.1541267390251;
        Sat, 03 Nov 2018 10:49:50 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id r22-v6sm2681459ljg.82.2018.11.03.10.49.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 10:49:49 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id e5-v6so326770lja.4
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 10:49:49 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr10638084ljh.118.1541267388773;
 Sat, 03 Nov 2018 10:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATzERTiys46vFOTLWBbZ8TXOdT-EojWW7aKZxWwahkTpg@mail.gmail.com>
In-Reply-To: <CAK7LNATzERTiys46vFOTLWBbZ8TXOdT-EojWW7aKZxWwahkTpg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 3 Nov 2018 10:49:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqJZEWGy74NtGiAmuQqxUQULFHh=VVSKpSxPQrMs=CTw@mail.gmail.com>
Message-ID: <CAHk-=wgqJZEWGy74NtGiAmuQqxUQULFHh=VVSKpSxPQrMs=CTw@mail.gmail.com>
Subject: Re: [GIT PULL] more Kbuild updates for v4.20
To:     yamada.masahiro@socionext.com
Cc:     linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 12:58 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Please pull a little more Kbuild updates.

Pulled,

                 Linus
