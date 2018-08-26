Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D71C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7A1208E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 13:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QE1l4Crp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7A1208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeHZR2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 13:28:02 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:55739 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeHZR2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 13:28:02 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3203a612;
        Sun, 26 Aug 2018 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=USyCIm/yqR5pkX63+CRdyQGd8Zg=; b=QE1l4C
        rpeDQVubhuXvHmVOlErM35Xz835RPcBUK+Ur3fcO4UPHttDh1jIrZl/NmLCkOi6b
        UaZE94VKp7RWEY00eW/G1FVTtW9K3cxrTJ7UGuK5FjqlKltKtqeinfPdT2PUpNpF
        RkiIGvdF9zAbRqA5x6RXUUWL09YrzPGc5OlXQ41+Z5aowseVdzSz4Z+RxIlBM3GD
        WfgSwOBhG7SiOwoRj0w/CZTRvSQlHcxRZIww4snDEhYi6OJGN5evZOO55mH7Z3gL
        DdXB9qwCveR6nOZUvmXhJy238Cc2md/qc6Uiq4wklwY5Z+XIfjobNPDc+a20U0Zu
        CXjL5HK0fgv0s8zQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 447f664a (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 26 Aug 2018 13:30:45 +0000 (UTC)
Received: by mail-oi0-f50.google.com with SMTP id p84-v6so22943474oic.4;
        Sun, 26 Aug 2018 06:45:23 -0700 (PDT)
X-Gm-Message-State: APzg51Blg4IFGb186cdu/Xge+OWmlq0bZX79wKHa2ZBo0zaYanALoVW2
        4l1W2+wNc0rskw15Q3A8vRqMWn2EN8P+Gcc/g4Q=
X-Google-Smtp-Source: ANB0VdaJmphpXSwfpVr5asM+b1CP53ZHQ7xnEolIzWkLXzVtDeY7CRMSBDRn5ztK22Sn9eMCkr8kKJdOpdCEKpZpt40=
X-Received: by 2002:aca:e6d4:: with SMTP id d203-v6mr9199096oih.311.1535291122371;
 Sun, 26 Aug 2018 06:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
 <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 26 Aug 2018 07:45:10 -0600
X-Gmail-Original-Message-ID: <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
Message-ID: <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,

On Sun, Aug 26, 2018 at 6:10 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> I'm not too fond of this simply because it requires that relax() step in
> all code pathes. I'd rather make that completely transparent by just
> marking the task as FPU using and let the context switch code deal with it
> in case that it gets preempted. I'll let one of my engineers look into
> that next week.

Do you mean to say you intend to make kernel_fpu_end() and
kernel_neon_end() only actually do something upon context switch, but
not when it's actually called? So that multiple calls to
kernel_fpu_begin() and kernel_neon_begin() can be made without
penalty? If so, that'd be great, and I'd certainly prefer this to the
simd_context_t passing. I consider the simd_get/put/relax API a
stopgap measure until something like that is implemented.

Jason
