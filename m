Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6083FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CF820652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BJWkFf+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CF820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJYHEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:04:47 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41913 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeJYHEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:04:47 -0400
Received: by mail-yw1-f68.google.com with SMTP id 135-v6so2772531ywo.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 15:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6ANNM4CK+o4++gTDNibM1c+Y7POTejQXLCymkEuMr64=;
        b=BJWkFf+m/AYc4RgUvfApNmmwmpZZ/x7d/vMB1j8X5lSoQ8ASrXf7aIsD5DwhLODC7t
         5mkJwtaADV3gE17XdNOJLSIxYwk7jDx7n7tySGv7DjgqGPeVWnxujomwQ+hWZyiGJijQ
         fNdf3d4SPbe/pERzqrXkjqr4RDIUA7BmcIkw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6ANNM4CK+o4++gTDNibM1c+Y7POTejQXLCymkEuMr64=;
        b=NmRoq42U/WCuKkj3U+I6vzyWKdeCz9/jwkSmAmcxHj044EJ2+EBsKJTRzXSN6um5Wt
         RUpYNjG1ji8mJn4k9P2GTOVaAz8kMjuorH0HrXQSgozPHX5jqQQB5ychI056mDf+cvGS
         c72zmUg76NRiSKi7lE6tB6KjzDzbbJjgmHZhcV7b3Z+wNjO079w+CuqNeeEsUb+H0Rd8
         392hBVNfyRaVJ9yfl3KEPOxQL66l3M1hyKwiT/WcNel75KIHanWLwdg4nf01XFpKazpd
         oArwHgB1HIMghflpHIkU8ak+i8tFXBO9EwSvSSOB4bR2p4iKkO7sruoTbbWQgIGneWn3
         B36w==
X-Gm-Message-State: AGRZ1gIZZQXJvwMLSS0t9ECl3C9+IWGlfQ+7twb2zWERUb6D3wtOBSZG
        aSq54PSlYjWoNyL3J2BxVaCrB47nOCg=
X-Google-Smtp-Source: AJdET5cjuPF94RIdQNmuYd+3C7ZdQetx1tdBgWOu1YOLGDk947QFnUKvseKitkx/PR7As8gnkxhU2A==
X-Received: by 2002:a81:4901:: with SMTP id w1-v6mr3970169ywa.86.1540420490275;
        Wed, 24 Oct 2018 15:34:50 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id 207-v6sm1505549yww.21.2018.10.24.15.34.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 15:34:47 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id j75-v6so2774575ywj.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 15:34:46 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr4287649yws.168.1540420485724;
 Wed, 24 Oct 2018 15:34:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Wed, 24 Oct 2018 15:34:45
 -0700 (PDT)
In-Reply-To: <CAGXu5jJ7gmVXZE+iksW99c6bHEV2rSOG+boQDRGmMSDa9HOh_A@mail.gmail.com>
References: <CAEn-LTqbEmWovu4t7Rs4C211+GRRU4V3B=+WmW0SOhX_b8db5Q@mail.gmail.com>
 <20181024204036.8799-1-palmer@sifive.com> <20181024204036.8799-3-palmer@sifive.com>
 <CAGXu5jJ7gmVXZE+iksW99c6bHEV2rSOG+boQDRGmMSDa9HOh_A@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 24 Oct 2018 15:34:45 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+N5Du=c-dfGd-_rLjE3NEeN+MXTsKjt2APA1U1xwwSag@mail.gmail.com>
Message-ID: <CAGXu5j+N5Du=c-dfGd-_rLjE3NEeN+MXTsKjt2APA1U1xwwSag@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: Add support for SECCOMP
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Wesley Terpstra <wesley@sifive.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Audit <linux-audit@redhat.com>,
        david.abdurachmanov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 2:42 PM, Kees Cook <keescook@chromium.org> wrote:
> config HAVE_ARCH_SECCOMP_FILTER
>         bool
>         help
>           An arch should select this symbol if it provides all of these things:
>           - syscall_get_arch()
>           - syscall_get_arguments()
>           - syscall_rollback()
>           - syscall_set_return_value()
>           - SIGSYS siginfo_t support
>           - secure_computing is called from a ptrace_event()-safe context
>           - secure_computing return value is checked and a return value of -1
>             results in the system call being skipped immediately.
>           - seccomp syscall wired up

Oh, and I should add to this list, "passes
tools/testing/selftests/seccomp/seccomp_bpf test". :)

-- 
Kees Cook
