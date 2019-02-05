Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E5AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631E8217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mnEOJJBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfBEPE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:04:29 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46880 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbfBEPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:04:29 -0500
Received: by mail-vs1-f65.google.com with SMTP id n10so2289833vso.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2LY/DlEIHDPIDSnqql9VkikFZZ2vLr7H40+QeD3KwQ=;
        b=mnEOJJBG6GPhK+2hnrmAXYGQh4ioTdBoy3InU54VDjhTb6jJPzGBVLpX8AtZGhPmLm
         iXivzbtCxYHy9f5QDtEosk+vQ9E+7XCwahlq7Zj1TBlshIz0MaNN32MSjGzBCwEASlwj
         6AyCAyPMCM7Dckw5rBae/6OMb0DHUT1m1OExw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2LY/DlEIHDPIDSnqql9VkikFZZ2vLr7H40+QeD3KwQ=;
        b=rbjzPKl6evpMNqirLsiGiQCCu1W5PBpwCoKaJpSMtaer11GZ7bxL4e9YbMPRNPEDeX
         BvZBL5Dlm4hCeThZc2qEADjhLRUSD579TWkLBqZL0BqRxvIkQxY4FrCyES4NdZX7fy4p
         MBh1062IoLTkejHTzvQ+PjJl1hgZyF2TZHXknYaQjojLO0sd81pVv/SwcoK5uLaGMQ+f
         36Abg+ocqxxZDVgURyzIaw+SmWfpH/Cuf2cXhCiwDs3dcblKKCUDofayfsZUWN4mgzGx
         0WkhuJUKRcUkzzzTO+ARk+xiTdEXf5lfOzpSDa6GyOsm7IE0GaYelX4FXf+kDoytpj6J
         T0dQ==
X-Gm-Message-State: AHQUAuYFudk+dnDfBg1uzXHg3UBTUtZh47LYLjrqkgG62IEAr4SoSe8g
        lT5jz/hj8MWuc7d6iZna5sm9/UBNZoQ=
X-Google-Smtp-Source: AHgI3IYW+mIpIF2Cw2aEjty70P3jyZol9grIXQF5M3fvrsK2JwJWPx04vM53Q6woKjwXGvPCahC+mQ==
X-Received: by 2002:a67:f114:: with SMTP id n20mr2340317vsk.90.1549379067053;
        Tue, 05 Feb 2019 07:04:27 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id v79sm3529279vkv.13.2019.02.05.07.04.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 07:04:26 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id c12so1204998uas.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 07:04:25 -0800 (PST)
X-Received: by 2002:ab0:6151:: with SMTP id w17mr2048293uan.114.1549379065000;
 Tue, 05 Feb 2019 07:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20190204215219.5691-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20190204215219.5691-1-mathieu.desnoyers@efficios.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 5 Feb 2019 15:04:12 +0000
X-Gmail-Original-Message-ID: <CAGXu5j+iP7FuL8VdQMTHaUPpjxF=rhoFi_2_9w31GmFLZvTPrg@mail.gmail.com>
Message-ID: <CAGXu5j+iP7FuL8VdQMTHaUPpjxF=rhoFi_2_9w31GmFLZvTPrg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix: arm: kprobes: optimized kprobes illegal instruction
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Robert Berger <Robert.Berger@reliableembeddedsystems.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        "# v4 . 14+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 9:52 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> commit e46daee53bb5 "ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE"
> introduced a regression in optimized kprobes. It triggers "invalid
> instruction" oopses when using kprobes instrumentation through lttng and
> perf. This commit was introduced in kernel v4.20, and has been backported
> to stable kernels 4.19 and 4.14.
>
> This crash was also reported by Hongzhi Song on the redhat bugzilla
> where the patch was originally introduced.

Ew, yes. Thanks for catching this.

Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
FORTIFY_SOURCE")
Acked-by: Kees Cook <keescook@chromium.org>

Can you send this to the ARM patch tracker, please?

-Kees

>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1639397
> Link: https://bugs.lttng.org/issues/1174
> Link: https://lore.kernel.org/lkml/342740659.2887.1549307721609.JavaMail.zimbra@efficios.com
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reported-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
> Tested-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
> CC: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
> CC: Masami Hiramatsu <mhiramat@kernel.org>
> CC: William Cohen <wcohen@redhat.com>
> CC: Laura Abbott <labbott@redhat.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: Russell King <rmk+kernel@armlinux.org.uk>
> CC: <stable@vger.kernel.org> # v4.14+
> ---
>  arch/arm/probes/kprobes/opt-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> index 2c118a6ab358..0dc23fc227ed 100644
> --- a/arch/arm/probes/kprobes/opt-arm.c
> +++ b/arch/arm/probes/kprobes/opt-arm.c
> @@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
>         }
>
>         /* Copy arch-dep-instance from template. */
> -       memcpy(code, (unsigned char *)optprobe_template_entry,
> +       memcpy(code, (unsigned long *)&optprobe_template_entry,
>                         TMPL_END_IDX * sizeof(kprobe_opcode_t));
>
>         /* Adjust buffer according to instruction. */
> --
> 2.11.0
>


-- 
Kees Cook
