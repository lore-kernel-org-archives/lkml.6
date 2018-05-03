Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525323478; cv=none;
        d=google.com; s=arc-20160816;
        b=qfgv0AJ6fy97Kiaj26A+dQMFkcomllK4xX2x8JWT3TjOq0zOkg1IkwNtBfyE8tMYf6
         5yJq+qNxF5m8QFakq2bKc49IO7IYkbjKA9HP+UyxB8GulwDCHKkIrNq5+Y8gpAmDDQBk
         8B9XLxX9YpLdTGrA4OonFkLNP9zlsG6HbELRfIT1W7H+2UD0+9BFYx94K9svi4xyLwDN
         gl5npBgrhZqcoW0koBxVBMdFfPlgqkvhD8InLUYTFpwP8ck4aCbtcp7A9kOyI/1ACwWf
         ymFAdDOHZB6xn7VLpDROo1Q642C7IHnKnJkAncOV+Ni8/nTby7hpMi4mQRAEOjw4WtLg
         E1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=7nX5fWrtEHK9aVp+gnI4jBekb8xkrvYySGqt7Hl3h2c=;
        b=knea97VX7GH552IZU7UMConk7JdUvekwBsYNVWyRkpN8t7dAh9jylTDmEEXgH2/ufM
         DHwglyQ4r4yKqKE6z0+/M0DhYIbjwZTrYaXWQDdxAU7JfZx5fw0/zorax19qe+9XJbVs
         uoixXIUcxABX5J6lJQKWwki9BbPo9/7ri20A+FDDigEkBk/LMvkSsf9CCltA1Ht5MU+d
         kV/ZOOG16/8Y3Bw/kkzGAsKEi2mMnPXc7p81tqXXsJVDstC5wrYlsAnr9b0KeBgZqdMw
         VAqG4IUJW79euAGUZL0d7w/SC8N7yaKKhM7+i9h7PGy96jUgWnTIo/bg/sA5OlzXHLyE
         HVzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=f13/Leyr;
       dkim=pass header.i=@chromium.org header.s=google header.b=CqKWkN5j;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=f13/Leyr;
       dkim=pass header.i=@chromium.org header.s=google header.b=CqKWkN5j;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZoeTLbhbo0OTTTRlaFzRSfuixOIsCMhKjeNas929tNNXxKXde6OT9GfSHd8IDL5mhhML2gX1ubknKOuCp0bDyU=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1525301426-23543-5-git-send-email-me@tobin.cc>
References: <1525301426-23543-1-git-send-email-me@tobin.cc> <1525301426-23543-5-git-send-email-me@tobin.cc>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 2 May 2018 21:57:57 -0700
X-Google-Sender-Auth: rKVG_jfSENz1QBwgTffkz5Nen4E
Message-ID: <CAGXu5jKQbyBAD733Xyy94yMa0rQ=yRV4smXr+YHbeBGMxdChgQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] vsprintf: Add command line option debug_early_boot
To: "Tobin C. Harding" <me@tobin.cc>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599394508196651405?=
X-GMAIL-MSGID: =?utf-8?q?1599417591444886845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 3:50 PM, Tobin C. Harding <me@tobin.cc> wrote:
> Currently printing [hashed] pointers requires either a hw RNG or enough
> entropy to be available.  Early in the boot sequence these conditions
> may not be met resulting in a dummy string '(____ptrval____)' being
> printed.  This makes debugging the early boot sequence difficult.  We
> can relax the requirement to use cryptographically secure hashing during
> debugging.  This enables debugging while keeping development/production
> kernel behaviour the same.
>
> If new command line option debug_early_boot is enabled use
> cryptographically insecure hashing and hash pointer value immediately.
>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
>  lib/vsprintf.c                                  | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b8d1379aa039..ab619c4ccbf2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -748,6 +748,14 @@
>
>         debug           [KNL] Enable kernel debugging (events log level).
>
> +       debug_early_boot
> +                       [KNL] Enable debugging early in the boot sequence.  If
> +                       enabled, we use a weak hash instead of siphash to hash
> +                       pointers.  Use this option if you need to see pointer
> +                       values during early boot (i.e you are seeing instances
> +                       of '(___ptrval___)') - cryptographically insecure,
> +                       please do not use on production kernels.
> +
>         debug_locks_verbose=
>                         [KNL] verbose self-tests
>                         Format=<0|1>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3697a19c2b25..6c139b442267 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1654,6 +1654,18 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>         return widen_string(buf, buf - buf_start, end, spec);
>  }
>
> +/* Make pointers available for printing early in the boot sequence. */
> +static int debug_early_boot;

Please make this __ro_after_init too.

-Kees

> +EXPORT_SYMBOL(debug_early_boot);
> +
> +static int __init debug_early_boot_enable(char *str)
> +{
> +       debug_early_boot = 1;
> +       pr_info("debug_early_boot enabled\n");
> +       return 0;
> +}
> +early_param("debug_early_boot", debug_early_boot_enable);
> +
>  static bool have_filled_random_ptr_key __read_mostly;
>  static siphash_key_t ptr_key __read_mostly;
>
> @@ -1707,6 +1719,12 @@ static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
>         const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
>         unsigned long hashval;
>
> +       /* When debugging early boot use non-cryptographically secure hash */
> +       if (unlikely(debug_early_boot)) {
> +               hashval = hash_long((unsigned long)ptr, 32);
> +               return pointer_string(buf, end, (const void *)hashval, spec);
> +       }
> +
>         if (unlikely(!have_filled_random_ptr_key)) {
>                 spec.field_width = 2 * sizeof(ptr);
>                 /* string length must be less than default_width */
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
