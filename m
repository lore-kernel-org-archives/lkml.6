Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD296C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E512082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 22:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gdS4pZwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E512082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbeKEIEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 03:04:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40893 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbeKEIEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 03:04:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id n3-v6so4791578lfe.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 14:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1SgJTDibumrXYRseB4RkJj8JEvf4BBqgdg3+JfxBWWE=;
        b=gdS4pZwt6gZapcFa+LR74yl54PBXFftTctA9yAkf7MQLdRs4l0NeCmDMQH9rVVqXOR
         bRm9PXPVuYc8WKuN+LjwotxXmgX3NLeiw16bkSqH6iKIFH+/ZKOX9jV6oLFC91ncttFZ
         azDYVSWhodvXOhemGRVL1LEYgLXVLr5dknKJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1SgJTDibumrXYRseB4RkJj8JEvf4BBqgdg3+JfxBWWE=;
        b=Fr8IM5kYGjJiYjSnRqJznnbYOQOwXbMH0OXa/aVrhlLNKgL+xTEFodOkizl9Pl/fFe
         fKC2zrPd9v/kKjnu+TJaEDeEj/95a/j44xuvOiAgkbnT5z9aKrqvkV060zay0kL/EYyJ
         DbQrNeeCpnD+rr5sUfnNB7wmIpiygFVKkM4r36COg2rV9EdiGOnDKfUT+Zye1T6P8wwA
         ZmFU6J07VTsW3JkcWdaBh0UpCMHK05cCeRwYmjjCI+bH2Fia8l4BNPgSOPouckXdRACe
         OjbZMWeCMINdOQ0n4RpH2l6knjdrpuZDixaR/Slsi+udPpbxTIKq3mxdal5L5856o8+X
         ALwA==
X-Gm-Message-State: AGRZ1gL75dneHUH5ipmRvxPFztexGUGL5arUPIhdjcFX51Ub+WJtXmFu
        FwWMe6Rxx02JkUMtIsHWFi+nSgilMmk=
X-Google-Smtp-Source: AJdET5f3uHAuKLnD9dHXJqLiHuO3u3K1rO1UxpXb7mF13u4ZK34CptO3hpX9r4r8PeT+NPn/c43k4g==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr11838226lfb.140.1541371645649;
        Sun, 04 Nov 2018 14:47:25 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l21-v6sm3801059ljj.48.2018.11.04.14.47.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 14:47:24 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id t22-v6so6281560lji.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 14:47:24 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr13837834ljj.6.1541371644232;
 Sun, 04 Nov 2018 14:47:24 -0800 (PST)
MIME-Version: 1.0
References: <2346471.iD2boZGiFq@blindfold>
In-Reply-To: <2346471.iD2boZGiFq@blindfold>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Nov 2018 14:47:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgP_q5adR4neLe5aq+ehhpsCK88982SUODVurGuXW5=CA@mail.gmail.com>
Message-ID: <CAHk-=wgP_q5adR4neLe5aq+ehhpsCK88982SUODVurGuXW5=CA@mail.gmail.com>
Subject: Re: [GIT PULL] UBIFS updates for 4.20-rc1
To:     richard@nod.at
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 2:22 PM Richard Weinberger <richard@nod.at> wrote:
>
> This pull request contains updates for UBIFS:

Now pulled,

               Linus
