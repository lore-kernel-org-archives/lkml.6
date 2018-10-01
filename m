Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E09CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086652089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086652089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbeJASNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:13:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42308 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeJASNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:13:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id z8-v6so13457372qto.9;
        Mon, 01 Oct 2018 04:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArY3BFkz0rmNWrTuNhZzYQCqSrq20jsW3WYrquudeP4=;
        b=TMFRAVgFQkePYWX1EwrpWW6z4v++rzPnoPOUPBw4aKag5G18qFDaWD6h+pSlM3ElDc
         MlYWaszO0SMeoqIfRNBJ0TfhPilNGVxl4Mhj430oNFK7xVyifCtdVGQIoTcdNa8txnK2
         SHFdr/ygOlhXGojWR2sXo8KLFxKmhHqr6JKUCINvzHMvsMHGEEovGb4LXpFSeDu3B2fM
         dEKX4PooZQiiGJrYzMdauU9jPpOBjzlwLqTvkKtmsLcGVJG/J+P4UH7F9vBRxnDlbXXR
         2e/28BOgNTKRsT5Ygq3Yzf2aDdJpkoms0D+JsbdwlgmWDIRLWpXcqO5pofAPTW7R4M5B
         WlOQ==
X-Gm-Message-State: ABuFfogVg1GWjFTqniERY6gbzvRHvT06OjDm9OA/NeUecmbeZsD9Du3b
        pAwBBuyWKDgSY5UVPa51UsAXNNQQ74GxC6iKPHw=
X-Google-Smtp-Source: ACcGV60Nu5dFx9iVySPWcbkLrXzijgwX0fAa7YfBHd0ktMtGAClNl6v1ILgJTkq08cldJhpuPokAnYbU6icQlu1gyyY=
X-Received: by 2002:aed:2bc6:: with SMTP id e64-v6mr8147114qtd.132.1538393788714;
 Mon, 01 Oct 2018 04:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org> <1538058267-3765-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1538058267-3765-4-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Oct 2018 13:36:12 +0200
Message-ID: <CAK8P3a0D2G8=weYcua7G3HmL07vrYR_iExmmjt2SuokbJ=Vvog@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] parisc: add system call table generation support
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

On Thu, Sep 27, 2018 at 4:25 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> ---
>  arch/parisc/kernel/syscalls/Makefile       |  55 +++++
>  arch/parisc/kernel/syscalls/syscall_32.tbl | 342 +++++++++++++++++++++++++++++
>  arch/parisc/kernel/syscalls/syscall_64.tbl | 342 +++++++++++++++++++++++++++++
>  arch/parisc/kernel/syscalls/syscallhdr.sh  |  35 +++
>  arch/parisc/kernel/syscalls/syscalltbl.sh  |  42 ++++

I think we absolutely want to share the .tbl files for generating all
five outputs
(32-bit unistd.h, 64-bit unistd.h, 32-bit native syscall-table.S, 64-bit native
syscall-table.S, and 32-bit compat syscall-table.S) so we only
have to modify one file when adding another syscall, and to ensure that
 32/64 are in sync.

      Arnd
