Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB9BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A94520892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hzMk8ZUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A94520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbeLFSbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:31:23 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37349 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeLFSbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:31:22 -0500
Received: by mail-yb1-f196.google.com with SMTP id f4so666526ybq.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kTx26BkB0ZFxwyDFWFYU+PHdQctX1gqC06dfakZ1KY=;
        b=hzMk8ZUrY3I06XRjfjOUQnO34ZgyRpK6OU1TDiwdUe94pEswZHBk+CShiVcp/sJqpV
         HAR8lD2Q8tqac69qTbX6I9zUFr8gUbNYIjLtNoG4nACeurO0ml1Ftvf926p+kok2ljl2
         27b0uEChHG5aLgVG88d5btahnZK5zA9iOxd5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kTx26BkB0ZFxwyDFWFYU+PHdQctX1gqC06dfakZ1KY=;
        b=WsVUvFCTX3C0S/GZ5g1IOmS2yjXvhBVqmhfKTddUg3TcJn5HDc+kYzb4CUh2rKEB0L
         +/h8BptSdis7vLnZCZfTCHqTQkKMopN0BB0Ab0/G1TL3s8Q7BETxkrPg+a19i/omQOal
         JBcHfVWsFw0Qx3DshTI56NzUOtByT/PhWz5p1aFmDBSBSkz88eip+cW/o3AcKHnZQgjI
         bSAOXhEXKiFvCcyCDPJARwCA80MoTxZhwxaiAGaAsCZiahPxZWelayKc9kJdk1VWHbe9
         QtHELvpuscR59mfCy8BAezP1xTBV5P4FcT6wbIL0AlrYHrE3oxqssQAIM33z0d2bDzoG
         WZnw==
X-Gm-Message-State: AA+aEWZKFwgJPmShtyZ0Rz5pejjMTUDA4D2yVBaDSHpqJ5DIgJm9h8+A
        MVSuEMo1MMvuCtAYomr5hmSktvzC8HI=
X-Google-Smtp-Source: AFSGD/UEQEQNXpWZ5V5unAoxkskFQvyczV+4bHRUXxhzBrzgK8OgARnmfMbSZ0dn9+DhqvM3osZ8nQ==
X-Received: by 2002:a81:4f15:: with SMTP id d21mr30260352ywb.451.1544121081098;
        Thu, 06 Dec 2018 10:31:21 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id i21sm460059ywg.5.2018.12.06.10.31.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 10:31:20 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id x144so1194744ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:31:20 -0800 (PST)
X-Received: by 2002:a81:2f0f:: with SMTP id v15mr30881844ywv.124.1544120729343;
 Thu, 06 Dec 2018 10:25:29 -0800 (PST)
MIME-Version: 1.0
References: <1544109187-13805-1-git-send-email-alex.popov@linux.com>
In-Reply-To: <1544109187-13805-1-git-send-email-alex.popov@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Dec 2018 10:25:17 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKPTaomgyBiSFCYJDFqGaVd=sWpXnjHpT-7YDmk1AVVyg@mail.gmail.com>
Message-ID: <CAGXu5jKPTaomgyBiSFCYJDFqGaVd=sWpXnjHpT-7YDmk1AVVyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] stackleak: Register the 'stackleak_cleanup' pass
 before the '*free_cfg' pass
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        amonakov@ispras.ru, Tycho Andersen <tycho@tycho.ws>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Emese Revfy <re.emese@gmail.com>,
        Thomas Garnier <thgarnie@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        gcc@gcc.gnu.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 7:13 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> Currently the 'stackleak_cleanup' pass deleting a CALL insn is executed
> after the 'reload' pass. That allows gcc to do some weird optimization in
> function prologues and epilogues, which are generated later [1].
>
> Let's avoid that by registering the 'stackleak_cleanup' pass before
> the '*free_cfg' pass. It's the moment when the stack frame size is
> already final, function prologues and epilogues are generated, and the
> machine-dependent code transformations are not done.
>
> [1] https://www.openwall.com/lists/kernel-hardening/2018/11/23/2
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Alexander Popov <alex.popov@linux.com>

Thanks! I've applied this to me tree and I'll send a pull request soon.

-Kees

> ---
>  scripts/gcc-plugins/stackleak_plugin.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> index 2f48da9..dbd3746 100644
> --- a/scripts/gcc-plugins/stackleak_plugin.c
> +++ b/scripts/gcc-plugins/stackleak_plugin.c
> @@ -363,10 +363,12 @@ __visible int plugin_init(struct plugin_name_args *plugin_info,
>                                                 PASS_POS_INSERT_BEFORE);
>
>         /*
> -        * The stackleak_cleanup pass should be executed after the
> -        * "reload" pass, when the stack frame size is final.
> +        * The stackleak_cleanup pass should be executed before the "*free_cfg"
> +        * pass. It's the moment when the stack frame size is already final,
> +        * function prologues and epilogues are generated, and the
> +        * machine-dependent code transformations are not done.
>          */
> -       PASS_INFO(stackleak_cleanup, "reload", 1, PASS_POS_INSERT_AFTER);
> +       PASS_INFO(stackleak_cleanup, "*free_cfg", 1, PASS_POS_INSERT_BEFORE);
>
>         if (!plugin_default_version_check(version, &gcc_version)) {
>                 error(G_("incompatible gcc/plugin versions"));
> --
> 2.7.4
>


-- 
Kees Cook
