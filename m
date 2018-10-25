Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F76C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBE92054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xdmr/J/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBE92054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeJZFBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:01:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41356 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeJZFBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:01:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id u21-v6so9460699lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEx6wTAtxpXIkFKcFNoT1Bo/YKcSYnIa2M4hPw7qvVo=;
        b=Xdmr/J/f+oNW1BfFZIdhjVEfgSM9RHek4iqHCMJ+vGXUUFSVs5kDoukBvxFqk87L/C
         sgsp4IkmtRWUBPApwJUPzhfAke8oDOht4pR954691+DpUfDCJdxd5UHhC17344Dm3QEK
         9Rc5F8XFP6uurHQQ9v3Rde3K7CtEXZ/7GVrSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEx6wTAtxpXIkFKcFNoT1Bo/YKcSYnIa2M4hPw7qvVo=;
        b=Fs7jL6ty3+j+xns2N/TZ9c5gxyu2LDEse1hHb0x/La6m3BjEEHGZpNFWudk5DEvW7X
         RxT6buZy2EBTpDWQivmtJNsAmBI0qNL99j9aebHCT76mbd3C/IZZ7mtD1Rfux3vP9IrA
         ex6SvevFIbVTw1YDey/nfArfNCmRjfmgdZHyBVnp9WrBcKfoEysDI6pq1zfjmKrdx+pt
         GR31G6MVcBWZuLWs1dkYFd0A5WRBNxK3xN/6C8Deb0l6x42Wat5EeVq9xFQ5Ldtc9TKa
         Bxf4fZlAAFax4/K9yeU/dW7nprjFcpFUNdXBp0mBfY9rkFcwrdXdYUmwwLMSOE3cVzi8
         HqYg==
X-Gm-Message-State: AGRZ1gJUmppwXPppeaT9YGYPwit8JWWE4xvrtrVZeSQ06jOyG+MnC+XF
        qAqtpPJRW3CnJihSkSt1olN258KUHrbVLg==
X-Google-Smtp-Source: AJdET5d/zzWuJ65cTuR0S42oBHi9CQZBkNz1YOVZfYVOZxAPRUfP1ocLbdqYsDMsAt9WeAuaBw5dLQ==
X-Received: by 2002:a2e:529d:: with SMTP id n29-v6mr456613lje.54.1540499207370;
        Thu, 25 Oct 2018 13:26:47 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id n16-v6sm1281444lji.28.2018.10.25.13.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:26:46 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id n3-v6so7824216lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:26:46 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr414428lfi.138.1540499205935;
 Thu, 25 Oct 2018 13:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1810252032230.30470@namei.org>
In-Reply-To: <alpine.LRH.2.21.1810252032230.30470@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 13:26:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyh8P4jwOoffW-2CHcuQLZuTf2+YZWnudALcxkeBUj=A@mail.gmail.com>
Message-ID: <CAHk-=wgyh8P4jwOoffW-2CHcuQLZuTf2+YZWnudALcxkeBUj=A@mail.gmail.com>
Subject: Re: [GIT PULL] security: TPM updates for v4.20
To:     jmorris@namei.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 2:35 AM James Morris <jmorris@namei.org> wrote:
>
> From Jarkko: "These are the updates to v4.20. The only new feature is
> non-blocking operation for /dev/tpm0."

Pulled,

                  Linus
