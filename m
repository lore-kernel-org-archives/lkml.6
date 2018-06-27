Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69186C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D5625CF0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yeo2ergC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D5625CF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965089AbeF0OqL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:46:11 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33582 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933080AbeF0OqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:46:09 -0400
Received: by mail-qk0-f195.google.com with SMTP id c131-v6so1172868qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZJ2uetk9Jjb96gqgpah9GrmvQLR3FdgYG7Nm7CZKMIw=;
        b=Yeo2ergC/SEj/CWQ/SlEm+8/se4AqyTGS/vi/AZ18zyYlQTzkJvRog1r+jnc3m+dZp
         IVXvNR+rE5AGZ2Uu/0t/t+Ag9YdQEuHnniMBx0E9xdnlocpyjtmBAoOvL6z3MFcZbGQl
         gtABnC9WoEpKZpzqi+I3PLIjR2Epp47iluxaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZJ2uetk9Jjb96gqgpah9GrmvQLR3FdgYG7Nm7CZKMIw=;
        b=lLj41rPE6p2MqUmrkxz003UXPguvEzF8pcdafg2C9jZFpALghUMqVmmvMpjUHb7HJ0
         gcLGeLjOwa2ImdROQS2vDNu5p1LeZl36GbRFu7DdA6EpOSXXgePArDe0Vn10/JmKYKb8
         p3NPkdcdDCgmJePztFYxHY2qu7qMXTDQHTrsxYaTd0VMJb1DqbtGc0NUQModJK0qm/jc
         mcrAuxHmKT8xrjOkXSnFw+koyUTUC7Bs/3DPynEjg3Qv2sutlmOVIe6RWkM2mjg/2Alh
         MeYnG3de6THKrMxRBylSh6Cd+mD11pYaVbnMNhqADqAtobIp81Go9Sh3cpMV/7M81X5e
         /xUg==
X-Gm-Message-State: APt69E2X4POC3H45ruHZ4L0Vk5vIiMDr4x9/Cu9bU2dCIAP4zwssXKT+
        eObWTGC7Ps8FOwsv5/AkJAVsaDOkHhjbWQm8e7gWnw==
X-Google-Smtp-Source: AAOMgpcKK6UT4YYHrYN4FO5oSSwphbs9Wcj0FnqWdgr3v1sxJ93ZJM06KxL5KM7r2ZCd2RzIVG4vgJnSYkAlVUmMjI8=
X-Received: by 2002:a37:5bc6:: with SMTP id p189-v6mr5428549qkb.212.1530110768999;
 Wed, 27 Jun 2018 07:46:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3267:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 07:46:08
 -0700 (PDT)
From:   Siva Reddy Kallam <siva.kallam@broadcom.com>
Date:   Wed, 27 Jun 2018 20:16:08 +0530
Message-ID: <CAMet4B6zN2Arm+RSctSmkdmhhOtnjUpiCbBgK0NPwaQoC+NGxA@mail.gmail.com>
Subject: Re: [BUG] net: tg3: two possible data races
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 7:17 AM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> The call paths in Linux 4.16.7 that may raise the first data race:
>
> CPU0:
> tg3_open
>     tg3_start
>         line 11611: spin_lock_bh()
>         tg3_enable_ints
>             line 1023: tp->tnapi->last_tag [READ]
>
> CPU1:
> tg3_poll
>     line 7341: tnapi->last_tag [WRITE]
>
> The READ operation in CPU0 is performed with holding a spinlock (line
> 11611), but the WRITE operation in CPU1 is performed without holding this
> spinlock, so it may cause a data race here.
> A possible fix may be to add spin_lock_bh() in tg3_poll().
>
> -----------------------------------------------------------------------
>
> The call paths in Linux 4.16.7 that may raise the second data race:
>
> CPU0:
> tg3_open
>     tg3_start
>         line 11611: spin_lock_bh()
>         tg3_enable_ints
>             line 1023: tp->irq_sync [WRITE]
>
> CPU1:
> tg3_interrupt_tagged
>     tg3_irq_sync
>         line 7341: tp->irq_sync [READ]
>
> The WRITE operation in CPU0 is performed with holding a spinlock (line
> 11611), but the READ operation in CPU1 is performed without holding this
> spinlock, so it may cause a data race here.
> A possible fix may be to add spin_lock_bh() in tg3_irq_sync().
>
> I am not sure that whether the possible fixes are correct, so I only report
> the data races.
>
>
> Best wishes,
> Jia-Ju Bai
>
>
We will evaluate this and provide an update on this.
