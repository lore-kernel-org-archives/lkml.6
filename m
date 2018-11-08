Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D6BC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2777A2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TE6fvYu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2777A2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeKIJYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:24:42 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44789 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeKIJYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:24:41 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so25015lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 15:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMbNgAy6tnz7L3/0PYJoNQolToVAAZXDDpQR3KdbVvw=;
        b=TE6fvYu6kA6Ot5eAYJGObqp+nU/t8motbrCndH911baqtqF0er5/2GULDG2kSP7jWN
         jGiYSjarSnMUXrqyQr1/AzJ46qzCFBZEsPqYYhQYQXIkAe6sQdIqsnRkfBp2g3BKuNHq
         TMTbEN4F4/q4GOCxxvO3qxqW4uRBmKonjsJhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMbNgAy6tnz7L3/0PYJoNQolToVAAZXDDpQR3KdbVvw=;
        b=Mp9y+X8qaWPCInw1pUSFusaIHBfoX4WLtpYcl88gCIbL4k54J31daS6joOwMAK1u/L
         c4kFfzY4KpNvrBGaepktecqWGGoJ2aRuAUJuYBDHXdouqRDV5phdTDbvx4tE31uglmVL
         7nhmxeozl6O8MPOkgSJxJnnFiuwLKeA+RTRlIo6jcLV+pTZTi21FYCHFI5eEZw5scdHt
         dIDRHmmnpqlmLV+949qfGo3hUkJsmECjMBOBswdUsIFUWXLhxhjBUB0tMTQwukRX0qYw
         vcM1/4AXKyXdN6NqNpPButJeLxVn5Bxec+OAZPeKrUQA9tn1K6TNxg+c1WHaK1BC9TD2
         fSTw==
X-Gm-Message-State: AGRZ1gLLBojx1k12A+dgoWcUQ3WSbpE37VtnZBJ/HXWZ3NjN1ZMVHgjW
        uXLwCRcj2CKpFbEB162AtRZp4n1P/LQ=
X-Google-Smtp-Source: AJdET5f/O8bW8TsxUIssB94bNsxMr+bKU2pZknYsR/VUWLU3s10pO2Vh+7hHTV+NPvxQYYCSjLoctw==
X-Received: by 2002:a2e:3218:: with SMTP id y24-v6mr473263ljy.157.1541720803653;
        Thu, 08 Nov 2018 15:46:43 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q30sm932824lfi.94.2018.11.08.15.46.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 15:46:42 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id t9-v6so42308ljh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 15:46:42 -0800 (PST)
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr3699189ljj.120.1541720801987;
 Thu, 08 Nov 2018 15:46:41 -0800 (PST)
MIME-Version: 1.0
References: <s5hsh0b1rnj.wl-tiwai@suse.de>
In-Reply-To: <s5hsh0b1rnj.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Nov 2018 17:46:24 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgmyV_FKqWEUGxgHNzGSC_t=D2ivdvsKd476kswh=nXnA@mail.gmail.com>
Message-ID: <CAHk-=wgmyV_FKqWEUGxgHNzGSC_t=D2ivdvsKd476kswh=nXnA@mail.gmail.com>
Subject: Re: [GIT PULL] sound fixes for 4.20-rc2
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 10:05 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> sound fixes for 4.20-rc2
>
> Two small regression fixes for HD-audio: one about vga_switcheroo and
> runtime PM, and another about Oops on some Thinkpads.

Pulled,

              Linus
