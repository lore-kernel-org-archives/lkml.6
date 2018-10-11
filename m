Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F303FC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50A52085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50A52085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeJKO7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:59:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36802 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeJKO7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:59:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34-v6so8755503qth.3;
        Thu, 11 Oct 2018 00:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99GBteRYugQWCoBAXNf0WHIsojNCC2RNChHW+6krH1I=;
        b=HsWk0oHuCUdQ06larrlBWzaFEnzszIcc0Aj25GdLsZ4fQWG8KjbC8DqdmJLLZuaP/+
         YQWkeVc73lSp2kXFobsQR87eC0KcMZ9xqMRD6hDjbPSWCDNu/LxMfYKO1hKIu/vMb3Hc
         uZeiBYKB0Kjk5Dct8XrtbJW/Gp0Hpl5O/4NCumfvd9vDcYmC3hC9DrhbxlsZeZ0ArUaf
         j2EhOC9IfpBKQqbUSa6sTLJR/VtEGmnar34qF1Fq7jqqDDAxkEBmPMaXhgZk0TWG7Iw3
         kJfcJkpT9DiEdDGD6P/34ilncjeuN1e3hi0ulsQxOTUFbNJfuhYnwCxb/m7znKK9Km2C
         S7QA==
X-Gm-Message-State: ABuFfoh3XsxDFW0HFS5ukuLitItmsnfWStQhUSdg4/ntnI/r7pjrSfLf
        osXqV8y+6lE6mpZidYEYs1aO/PVJ6pvIoNPJd48=
X-Google-Smtp-Source: ACcGV62TzYGKdYk4jB+WGI2X/NKtnPkYEv3W+CF29135HObALHTw334Vt4bplfsqTAZv0SOfa5wIlX57MLGoa1j2Jzk=
X-Received: by 2002:a0c:e150:: with SMTP id c16mr424165qvl.161.1539243193592;
 Thu, 11 Oct 2018 00:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org> <1539231895-4118-5-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1539231895-4118-5-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 09:32:57 +0200
Message-ID: <CAK8P3a2JdFnAQcZ9YSOkEC_Od4QeLLP0RcWkte5MHC6VSXi0qQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] ia64: replace the system call table entries from entry.S
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
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

On Thu, Oct 11, 2018 at 6:25 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> In IA64, system call table entries are the part of entry.S file.
> We need to keep it in a separate file so that one of the patch in
> this patch series contains a system call table generation script
> which can separately handle system call table entries.
>
> Replaced the system call table from entry.S to syscall_table.S,
> this is a new file. This change will unify the implementation
> across all the architecture and to simplify the implementation for
> system call table generation using the script.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/ia64/kernel/entry.S         | 333 +-------------------------------------
>  arch/ia64/kernel/syscall_table.S | 334 +++++++++++++++++++++++++++++++++++++++

According to the discussion we had on the same patch for parisc,
I suppose we can skip this one as well now, and just remove the
entries when the generated table is added.

       Arnd
