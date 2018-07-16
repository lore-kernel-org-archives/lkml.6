Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AECDECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA8D208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AZSzerME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA8D208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbeGPRYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:24:00 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52934 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPRX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:23:59 -0400
Received: by mail-it0-f68.google.com with SMTP id p4-v6so21853165itf.2;
        Mon, 16 Jul 2018 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHhJI6npM96yHaIQsW+ffQY8pT7CrDunlm0dKYN5zco=;
        b=AZSzerMEeLxwENVW3et30BduAb5lRYZMeionZV9PtLBLaMWGvMiUUH8WJAkG2Vnk4S
         SInXtR/UIRVDP4B4XCYxJHN9vXdlZCHx2Jurj16tli/2KkrXSwPIw5cou3JZ8suTrAmN
         WVMArBd3qwHmKA8yjVKICuzIDeLXMILgz+UUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHhJI6npM96yHaIQsW+ffQY8pT7CrDunlm0dKYN5zco=;
        b=WCkpgsk/7YK2Cg9kghRTMOukDHxPD6pk4xwWNvFaBD8Gdjex3UmS2srp4IrKU5771X
         12nY0vL90hU2EHvYw2EcPwnx1OrqVkR3+xxBi0LhcgJrj3hvnJ3zZf35AWhIlIIvtfgV
         rZmKqYMQtxaeSsLzZVr5sci7uLwlh/cNcKsvlf4qvzZU9vEZGgoCpDybog4HZrxHq/bX
         /FCZBZ9IaZme9qyUDbumtyRp/7u7vYSggWih5Djnempoy/sw3GUUz67nOp9Ku0TOqOeJ
         s/9PM5oRy+H3FylLYvwDBucJbz6JngZw8aqawp/g7B2HKVgeg75k0vytPP5r9BUaGK4Z
         SDww==
X-Gm-Message-State: AOUpUlHX7XdsZTUKxnev7L/qCOZUGkrjmE2xDbWFUXVFVe3HP//u01KW
        z7YTEtM88WOCPfKfCER6PjdeT9zTogP6OzpEOCA=
X-Google-Smtp-Source: AAOMgpe5wvT5i8emsIfNN9uR/GThPqpDbiovwuOCxE2nSmpnz7mGHS2dGocnnOgwfRiSCywkAHgQkuuQ0bP64ui6WE0=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr13060683itb.16.1531760143372;
 Mon, 16 Jul 2018 09:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180716165154.58794-1-jannh@google.com>
In-Reply-To: <20180716165154.58794-1-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Jul 2018 09:55:32 -0700
Message-ID: <CA+55aFy21E78DTF-3+1P3bTtX_89-nFUSpYHUELT0WCOZ-ccjw@mail.gmail.com>
Subject: Re: [PATCH v4] bsg: mitigate read/write abuse, block uaccess in release
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 9:52 AM Jann Horn <jannh@google.com> wrote:
>
> But bsg doesn't just do it on ->write(), also on ->read() and ->release().

I think Jens already applied Christoph's patch to just remove the bsg
read/write entirely into the 4.19 tree.

                  Linus
