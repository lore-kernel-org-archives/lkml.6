Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701F0C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 05:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7932075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 05:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H000R2Nu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7932075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeJXOKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 10:10:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44230 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeJXOKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 10:10:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so3543979ljc.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 22:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qcyfqJzo2NenbeqgDvzT9jcFct8Gulmfdvw+ZWRTyI=;
        b=H000R2Nuxos7OpdhWAURbr2vl/jsF5fwkBZDlHMbRsRd4pIkk1YTSU0wB/hyLaMG90
         y6dhF7lVNZRoA0xDeckawzw9hD4HMqVlOkKrn8ohXCICcFLbG/q4+drTwdVTbew7g9a6
         d/Gp+wcBHg08jE6KHTMl4639AuLCeRPePNOrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qcyfqJzo2NenbeqgDvzT9jcFct8Gulmfdvw+ZWRTyI=;
        b=gQb6dADFK/HrZWtaJT/kXWkaERdL6g1EJI06UKHFeP5Q+03rnu3YCkQXrlHatq6VJb
         tTxOD+0HU/X6jy0DwjTrsM2ZjSMmkS1egb+EZhe/egoPNjkt8OkMtiAlUu76Mb3KIjS2
         iVBAQZkx8g+byD4xbiT9cgmsB9RhApIgKbr6s8BIicoz+3AVwDExnAp/K4XUeUTehYtv
         FtfcfOPEClMcXwmQ7R30t3DjFb5unLU892eGYzj/7UJ9pBnu/HSZrBg1YjmLr4cZLzVW
         mrFjhWi4nKe4BwRx2rbwM89r3G/iQB0gVBEMhU7GrW4ZagtkRA2pU5bja9AQuAPv/n/k
         Xz1w==
X-Gm-Message-State: AGRZ1gJroCuGhXvAVIqYP6CoQ6LovC+QG5dS8IETsXospe4aLi8np9Kx
        yH6qTPdTsn8pbmf97EczabMMVNbT7Zr5vRRX
X-Google-Smtp-Source: AJdET5cwszkBp0e59lKXcgNzmqh/BnYJBR2tAMdzwtlJ/ndeE8Pou55k/4PbsriOWAG0nV+VxBIyPg==
X-Received: by 2002:a2e:94c4:: with SMTP id r4-v6mr725048ljh.68.1540359827718;
        Tue, 23 Oct 2018 22:43:47 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 10sm530193lff.62.2018.10.23.22.43.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 22:43:46 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id t22-v6so3551523lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 22:43:46 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr710258ljh.118.1540359826280;
 Tue, 23 Oct 2018 22:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181023.203148.123764172393516338.davem@davemloft.net>
In-Reply-To: <20181023.203148.123764172393516338.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Oct 2018 06:43:30 +0100
X-Gmail-Original-Message-ID: <CAHk-=whQt6eebqAehB2HceVsNgx=RXthm1pWWm82tqyDt1uL=g@mail.gmail.com>
Message-ID: <CAHk-=whQt6eebqAehB2HceVsNgx=RXthm1pWWm82tqyDt1uL=g@mail.gmail.com>
Subject: Re: [GIT] Sparc
To:     davem@davemloft.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        sparclinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 4:31 AM David Miller <davem@davemloft.net> wrote:
>
> Mostly VDSO cleanups and optimizations.

Pulled,

                  Linus
