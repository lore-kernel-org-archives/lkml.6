Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95F32086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95F32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbeKTC0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:26:02 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34584 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729920AbeKTC0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:26:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id a132so49419710qkg.1;
        Mon, 19 Nov 2018 08:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7XGE259zPHtZxyj7onWoRQ4Ox/KArkHxcJHDXcQDLk=;
        b=VfkCEjxgWwnK7ugssZwdUx7JtqXMRI4kTuu6UbiEg68bDeFJ44kb+tQ3Mbb7iFfIhD
         hyBnzoTnWqCI7GwXHDJ55hZyJMy5oA9H/myMfblCl62370Ut0NvQ4JXJzr2Xy+bj5vFW
         m/2fF/u2q97jszkqy9oxzWLwfqjY7uPhlJifJDYlofBXmHEXYTkRQB+IeXG7Z+jcCe5K
         dCVMIi7+tFP8UkgT/MdlezNsJO/K2yNVRvNKVHIScBrKHb/iqSaAkpx3FKD4RveGOq7X
         zUK/duMdt7HWTfpTp30Pnso6Gaq+TanU69+V1vcZoUN6YHbF5Tq8xqESz7pBtJe9kd4h
         MerA==
X-Gm-Message-State: AGRZ1gKOu6Ta39hdXtA+4r+eSvLurdwlyFHZO3iyfRrajOr0Ep7TRVH6
        ZfmYclTTmRMPsJjzqc1bjXc3zvpjZRHSbG0EyYA=
X-Google-Smtp-Source: AJdET5cNa0GJZ2humvx++P4L6Ki0xQCssn0DfSiMQcrhmV49lRChPLUKYP70wxb7wDe0gvNTZAVy9h87pet1DTbVl4U=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr21478459qvk.40.1542643320063;
 Mon, 19 Nov 2018 08:02:00 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org> <1542262461-29024-6-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542262461-29024-6-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Nov 2018 17:01:43 +0100
Message-ID: <CAK8P3a20MaFRNf8-umvrGNtjgNG98PkzcFGtHrnY835UEGv3tg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mips: generate uapi header and system call table files
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
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

On Thu, Nov 15, 2018 at 7:15 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> System call table generation script must be run to gener-
> ate unistd_64/n32/o32.h and syscall_table_32_o32/64_64/64-
> _n32/64-o32.h files. This patch will have changes which
> will invokes the script.
>
> This patch will generate unistd_64/n32/o32.h and syscall-
> _table_32_o32/64_64/64-n32/64-o32.h files by the syscall
> table generation script invoked by parisc/Makefile and
> the generated files against the removed files must be
> identical.
>
> The generated uapi header file will be included in uapi/-
> asm/unistd.h and generated system call table header file
> will be included by kernel/scall32-o32/64-64/64-n32/-
> 64-o32.Sfile.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Looks good to me.

      Arnd
