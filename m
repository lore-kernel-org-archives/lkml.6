Return-Path: <kernel-hardening-return-12742-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuy157IbqiP7Z4ayd0iOpq/F4fP/C/Jfd/7kLdSwebtDLteIrHOtZP+p7RqJ+tTVL4E6O38
ARC-Seal: i=1; a=rsa-sha256; t=1522106203; cv=none;
        d=google.com; s=arc-20160816;
        b=yHWZ/jwLs1b7jx8/KQkbPF86XfgXLrlec4wwmxY+aI5zp1WG2CYKcTeFAA71ij5awd
         oMA6cPbZbpfQZBK5SydPdZ+aPSAToAO4Faeb0cBVEZT5u7bPVSGJu2VlMSDJrineutzz
         ouwJ+3qskuIB2UfnqIF8R76ivntPnPc3twumYeCpyLfU9E6APjm5ICZD60RbD6E5LMkP
         FzpTFAOkQC2MEcRxnCFrdWeZt7VKU+8iJOzstgInDuJl/uRC45pMyM1soFNEHUCCmtmX
         uO7sFqBdW5Bx81woLp3X2vtXFy6CJHZE0vNeGipisUmKsM7h8/sMpRwW5ho9QYqNyfPc
         TEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=FIuMprzPsEdNdCUKxSDFvBN/cqAk864S7FPZb8OE4E8=;
        b=XfLF08dHAI2UsEm3qyQ56sae087IXXCx6u7gAH/AlOiuBE/Y9l/kjiUoCvYhZ7OHqr
         fjYnpvjuGF66TtO76OezNkvSwsUAW8+llol9F3kiGXlI5a8rRbqDW1zNnPNb0m6cNu/s
         nHfWlEMEGhbOdxHHkl6QStLKcYacFWFPdcz5fEiqzWEMU13+D4Jv2Zv5mZfSLeQuD4Oy
         0sk5qeF9WrsOzQhQiuXdBdIuOolDBFE5Ex92AuP8cCqW6WVGkVq2p8wKfjV0WFqhEZi7
         dUWrYvaTNyIptH0+UxqMYwqwIcY/PRkvR3/x4umMQFtzpE7/mgt9KBepsdjDmEWMBSkZ
         WPDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BxjOb/O/;
       dkim=pass header.i=@chromium.org header.s=google header.b=KvmFXrQj;
       spf=pass (google.com: domain of kernel-hardening-return-12742-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12742-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=BxjOb/O/;
       dkim=pass header.i=@chromium.org header.s=google header.b=KvmFXrQj;
       spf=pass (google.com: domain of kernel-hardening-return-12742-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12742-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1520970663-19633-1-git-send-email-s.mesoraca16@gmail.com>
References: <1520970663-19633-1-git-send-email-s.mesoraca16@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 26 Mar 2018 16:16:23 -0700
X-Google-Sender-Auth: _8K3e66a94EiWfBIweteKPD8o5U
Message-ID: <CAGXu5jJ=46_1DiWg=0aKzOo1+kxL9vemLFi11brn-+iY6cgZMw@mail.gmail.com>
Subject: Re: [PATCH] ftrace: drop a VLA in module_exists()
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853368165293411?=
X-GMAIL-MSGID: =?utf-8?q?1596044034788673802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 12:51 PM, Salvatore Mesoraca
<s.mesoraca16@gmail.com> wrote:
> Avoid a VLA[1] by using a real constant expression instead of a variable.
> The compiler should be able to optimize the original code and avoid using
> an actual VLA. Anyway this change is useful because it will avoid a false
> positive with -Wvla, it might also help the compiler generating better
> code.
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
>  kernel/trace/ftrace.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index eac9ce2..adebb92 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3902,14 +3902,13 @@ static bool module_exists(const char *module)
>  {
>         /* All modules have the symbol __this_module */
>         const char this_mod[] = "__this_module";
> -       const int modname_size = MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 1;
> -       char modname[modname_size + 1];
> +       char modname[MAX_PARAM_PREFIX_LEN + sizeof(this_mod) + 1];

Actually, I think this needs to be "+ 2" (":" and NULL).

>         unsigned long val;
>         int n;
>
> -       n = snprintf(modname, modname_size + 1, "%s:%s", module, this_mod);
> +       n = snprintf(modname, sizeof(modname), "%s:%s", module, this_mod);
>
> -       if (n > modname_size)
> +       if (n > sizeof(modname) - 1)
>                 return false;
>
>         val = module_kallsyms_lookup_name(modname);

Otherwise, looks good!

-Kees

-- 
Kees Cook
Pixel Security
