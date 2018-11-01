Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5114DC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21E020657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="enksLmc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21E020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKBGvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:51:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46241 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeKBGvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:51:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id x3-v6so19421789lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scJLHu2TTIrq5LinSEQoVo2J6r0LzcOFa2NSAPjn1Wk=;
        b=enksLmc/Xu6FXbuWIjb8n3qOfpg3MozQSF71+v4rBIOQSm+eLltZNm+tZePaj6ru+s
         HjK+fT1lSebe7K9ox+4UXCoCQ7hWpvCSX3G+RFsBTkFc0q1/pzaBJoVCPPBhuFOBhz1l
         u4vwq8ayjuiD/KFoxJfhAfgpjFu8bZEfCz5JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scJLHu2TTIrq5LinSEQoVo2J6r0LzcOFa2NSAPjn1Wk=;
        b=bL6RdoCqPm6RX0qJTG7flA2u2XolLzcrolK0IWYXLfNZVN8/JsWPKsD6P9dXq+dc5z
         UZkyCk+sG5gybO20r1rN9j1l53uX6x7c5hasGy6p+8OXKm3UXnw3Uu8OK21bf6TTskkK
         o6DKEoVS/qypd4fkAWotc4Nr7jPx0WesPLEIRnkT4ozgVyGXMb4+2RHUgo4NzSL632YB
         2Uz6Nvi70njwXmkO/TuU7YYDWU2ylMbwwu1CtggrbSN33yQsXMJk/gU5+qmNtsaauzP2
         Ycj8rlL0j/nc6cw8uB4bg1Zf5V6tws1j86VzDaI9/6gs9D3iWknHfrEPKgp4Mxg//lQD
         B3SQ==
X-Gm-Message-State: AGRZ1gKc68Q1V21yU9co6xxluF3yqolVZpjSTVPjVQKGjzVo/gDhwyqo
        Fm4LGshsWDWvhbu2afCS0gH8Bm32h6aKKw==
X-Google-Smtp-Source: AJdET5erqZnDfqXDfuWQKvfcJg8uxdU/ZEPoy7MEbDHLUXzBl1iGsmrXk2B71k07yCm0jnbXWuhnEg==
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr5839347lji.93.1541108823845;
        Thu, 01 Nov 2018 14:47:03 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id v13-v6sm4985056lfb.70.2018.11.01.14.47.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 14:47:03 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id n3-v6so15282440lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:47:02 -0700 (PDT)
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr5076380lfj.16.1541108822210;
 Thu, 01 Nov 2018 14:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_JsqJ8tAUbbHp9Ymu3gsfSGSK=qgPDofxA9yH8T9k67QjPNQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJ8tAUbbHp9Ymu3gsfSGSK=qgPDofxA9yH8T9k67QjPNQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 14:46:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj011xVwnTcUXYGpLQh9e7h4TMwzJGNdtijpr8yzgmUjw@mail.gmail.com>
Message-ID: <CAHk-=wj011xVwnTcUXYGpLQh9e7h4TMwzJGNdtijpr8yzgmUjw@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree fixes for 4.20-rc1
To:     Rob Herring <robherring2@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, mpe@ellerman.id.au,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 2:23 PM Rob Herring <robherring2@gmail.com> wrote:
>
> Please pull a couple of fixes for rc1.

Pulled,

                  Linus
