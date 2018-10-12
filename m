Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF14C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C232087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C232087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeJLR2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:28:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42228 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeJLR2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:28:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id j46-v6so13199316qtc.9;
        Fri, 12 Oct 2018 02:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFrLitvFg/SUyZV6CcC+XcOsTS0Y5sOEqTVSA2lo1HA=;
        b=ET+otUW3w2z9yysMZomouSMbbihowI8ZWMSeTaKovl6kKLdq5E4l6YSlXyk00bnByp
         dRQez4x/q+rfgquwRU0lgFkuQeZ7Z3rg2rT/359YJ7bKXulLJpuWBvkrbNOAHql748Ly
         CYYrQeoF3aF2aTC9BJPgFWkHREYPqOk6s69Ai3eN/dtltKFxOKGs3mOLkyMGl5gnAa5g
         TfLFC7eYzT2AnkGmXUOQ5nk/l1cy604YZNUT8PgsqvT5LSsRzChp94slZhBMwm0G1EDi
         RFn13dc6blHN/3xshAVsRdgtlNLOl4Lr5gQKzJ1O71fdVTtaj2ZA/91D4XiFfAMHlEub
         IKRA==
X-Gm-Message-State: ABuFfoizjzrYIx6YX6qi6UH4exY3J14i0ZB3CXGzflIQWxSXw2hM3mgT
        +LQb26BDHxO0/anyQ6pQDo1dtZUQ64jH/PKBCJ0=
X-Google-Smtp-Source: ACcGV62app08hTC/bIEJGwnZpFkSSjR2RIWJAXp1wqRoGJrQvBbu18RzyRgpa1Gag1PGSbGovi/6icsA6TzfZ4S6UnA=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr4868757qtd.319.1539338183342;
 Fri, 12 Oct 2018 02:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org> <1539337442-3676-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1539337442-3676-6-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Oct 2018 11:56:06 +0200
Message-ID: <CAK8P3a1gsuM7mBGm9hx-BTs=HAG3cSjB6M7N-kpMmPy3kixeCQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] parisc: wire up rseq system call
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:45 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> Wire up rseq system call requires an architecture specific
> implementation as it not present now.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Didn't we conclude that this should be skipped?

       Arnd
