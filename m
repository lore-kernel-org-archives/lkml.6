Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499F8FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFBB20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFBB20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeINPMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:12:12 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:43297 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeINPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:12:12 -0400
Received: by mail-qt0-f172.google.com with SMTP id g53-v6so8123558qtg.10;
        Fri, 14 Sep 2018 02:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ByoDngbgdRqYXI3Lve5fbg6VKELAKjArTjP4KngbxL8=;
        b=BY68jy3z882ipjJnunFpnDncDAky+8u2P4GawUmXK6sqQJesd7jDicWgYnxzfspdYV
         GYadn7JgSO2tmTPAcSG9RoZf6rEPdywtT+xnFqUKAmvd3bGpTNONP2AU1IHwbuj5Qdrh
         4IBa4fgLEPm3BEbMeRI8GXh577tMncIyktuGqLfrng0vLDFR4adJdf5aPMbY2ZzCzSxD
         PpY/VdZP/6wNVqVWPmxh4m4KEbZmMOQvc2LH434oO6kPYm2giHdaPvOoCKiV20eAv/L4
         JG2dDKoVRECGJ5v2DIzxTxSr4GUodGnDHHiP7UO2Gh2Vd8V+vE6TE53nV8V1yreY0ZGO
         ZsSQ==
X-Gm-Message-State: APzg51AbmDuPkDkfTchyUh1LNzLwZyRU4tbUubYKSnVovm9VGMp/bvvP
        4lG5ElQR8vCnfU35xL3Ly/0M3CapeHJ9qQApsaE=
X-Google-Smtp-Source: ANB0Vda80WgNhoqsjnF80IfKebNPcI64np6Q5lt77wrpEaOzSm98mqkwimH2ruLk6ctY7zy4kRcGCxEbuZ6cGArAW0M=
X-Received: by 2002:a0c:fb08:: with SMTP id c8-v6mr8162127qvp.149.1536919105907;
 Fri, 14 Sep 2018 02:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org> <1536914314-5026-3-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536914314-5026-3-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 11:58:09 +0200
Message-ID: <CAK8P3a221wz4iqwoKcof2ioVWzHmUCOwt8Y5cdVPvZEEtHcycQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips: Add system call table generation support
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Fri, Sep 14, 2018 at 10:39 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The system call tables are in different format in all
> architecture and it will be difficult to manually add or
> modify the system calls in the respective files. To make
> it easy by keeping a script and which'll generate the
> header file and syscall table file so this change will
> unify them across all architectures.
>
> The system call table generation script is added in
> syscalls directory which contain the script to generate
> both uapi header file system call table generation file
> and syscall_32/64.tbl file which'll be the input for the
> scripts.

I think it would be best to name the files
o32/n64/n32 instead of 32/64/n32

It would also be helpful to mention why the n32/n64
files cannot be combined into one nfile here.


> +364     32      pkey_alloc                      sys_pkey_alloc
> +365     32      pkey_free                       sys_pkey_free
> +366     32      statx                           sys_statx

You missed the additon of rseq and io_pgetevetns here.

       Arnd
