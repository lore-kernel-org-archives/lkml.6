Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081F2C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A7D27C92
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="oFUVXtm5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B/Wj4vdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A7D27C92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755288AbeF2UTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:19:50 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35017 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbeF2UTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:19:49 -0400
Received: by mail-yw0-f193.google.com with SMTP id t18-v6so4065867ywg.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xKDHyge0SetWzPGRJaOPaJpeSJuDxMEGysqfmfCEBpE=;
        b=oFUVXtm54wwUsy1ZPXvbMq7FabJzgi1Vto8racM2sIFB0aDMztptbUZGze9s+VwRiM
         wftsx/Cjzq+4xVEDCVL5r4P3k5OiCA3cNqkw9N2DZ8mmJ6BbBP9QGQB8pOvtDqGpGTHT
         Kq18bE6+jXiaxcJOWbyRfgN3+s9baqFEzvsAEnJU0PoVm1rDL6wPdrRFj9hoOZPLdyha
         Yy6rjz4y8LxM3BXm5yChOYxOPmv1n7U9EHXkrp+8WivpEWSJmmuKTy5hr3oakBlTuZBu
         SZPvNfbCAQ37JVwDzXzwzAAVjbhXqEj6Q6lI6s1GCFfVdE3sFC2fMPtxnh2Qy6iTfTDz
         PfQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xKDHyge0SetWzPGRJaOPaJpeSJuDxMEGysqfmfCEBpE=;
        b=B/Wj4vdBftLsmtRgJCIYbqlzAJiI2NX3IFlsSFMzivsknJXr2zSwVW+NMnTZ8XgREs
         kGP/jWtw5a0FOhzWCZITso7sn5Gp/lgMGcqMkZbHDeYJbrh5i0/k62mhDIeXfyd33TnA
         B1nvqtBG7z/jhcgVKs2/20UVk78OBcGvpv+O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xKDHyge0SetWzPGRJaOPaJpeSJuDxMEGysqfmfCEBpE=;
        b=perIBQkHK6YzhrMIm8JUZdSILvNuuJz0J1jaaOMUDgYgENO6Fwwpes39X2X7rvVK4P
         zJk4SuAWc7N9en+w9aRUtjJlGAKCkKZFoxL2FCrnvgSGhhpiEac2J3Snu+xf/+qOVrY2
         iP6VfBtBv3hwnwss361skgaeOzqRou7DVg+T7LQzhiPXJYl1KokKFDdjcOt8DuApYXed
         qK1NUhVtQRw9TFBhsqLqkpkEFuDfaztwIi0hqu2ZIlW3hAImotXLYVtwytqfMOzNNIgw
         pfe4M3OdlYwKQ9cYrRZqqjPYYsFugOKxPRF5O+6gnU7BVXWukjMRXDLdH5BvZjNRjBp4
         g5cg==
X-Gm-Message-State: APt69E3RGvkS3aQg++Hjqt6N1qVihtEu/3ngHQW50JzP8Nce+tLUMxjZ
        KXVnfzp9yTa8cle8saOxL2ujunCRNeRmCtbLpQb85Q==
X-Google-Smtp-Source: ADUXVKLa/mfvoWVFTvrtOjKSBOeRELavnRGCaN69b9JTPcZqcNSeCxMeXCrNKGD12kOFKNk6HoBJjaxZtBgNFBEPO4I=
X-Received: by 2002:a25:ce8b:: with SMTP id x133-v6mr8269666ybe.118.1530303588523;
 Fri, 29 Jun 2018 13:19:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:19:47
 -0700 (PDT)
In-Reply-To: <20180629190553.7282-1-labbott@redhat.com>
References: <20180629190553.7282-1-labbott@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 29 Jun 2018 13:19:47 -0700
X-Google-Sender-Auth: uJGVsMv0IkPSJKDGaq4doRbVzBY
Message-ID: <CAGXu5jL8kZHtg-MdScZ5m_6xH_Ho4TsdKGWH83zEL9Y5rutncw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Clear the stack
To:     Laura Abbott <labbott@redhat.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 12:05 PM, Laura Abbott <labbott@redhat.com> wrote:
> Implementation of stackleak based heavily on the x86 version
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> [...]
> +#define current_top_of_stack() (task_stack_page(current) + THREAD_SIZE)
> +#define on_thread_stack()      (on_task_stack(current, current_stack_pointer))

nit on types here. I get some warnings:

kernel/stackleak.c:55:12: warning: assignment makes integer from
pointer without a cast [-Wint-conversion]
   boundary = current_top_of_stack();
            ^
kernel/stackleak.c:65:24: warning: assignment makes integer from
pointer without a cast [-Wint-conversion]
  current->lowest_stack = current_top_of_stack() - THREAD_SIZE / 64;
                        ^

So I think this needs to be:

+#define current_top_of_stack() ((unsigned long)task_stack_page(current) + \
+                                THREAD_SIZE)

> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index a535742a1c06..972ce4ca7f6a 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -37,11 +37,14 @@ ifdef CONFIG_GCC_PLUGINS
>
>    gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKLEAK)    += stackleak_plugin.so
>    gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)     += -DSTACKLEAK_PLUGIN -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_STACKLEAK_TRACK_MIN_SIZE)
> +  ifdef CONFIG_GCC_PLUGIN_STACKLEAK
> +    DISABLE_STACKLEAK_PLUGIN           += -fplugin-arg-stackleak_plugin-disable
> +  endif
>
>    GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
>
>    export PLUGINCC GCC_PLUGINS_CFLAGS GCC_PLUGIN GCC_PLUGIN_SUBDIR
> -  export SANCOV_PLUGIN DISABLE_LATENT_ENTROPY_PLUGIN
> +  export SANCOV_PLUGIN DISABLE_LATENT_ENTROPY_PLUGIN DISABLE_STACKLEAK_PLUGIN
>
>    ifneq ($(PLUGINCC),)
>      # SANCOV_PLUGIN can be only in CFLAGS_KCOV because avoid duplication.

If there is a v14, I think this hunk should be taken there, since it's
part of the common code.

Otherwise, this works for me and passes the lkdtm tests.

-Kees

-- 
Kees Cook
Pixel Security
