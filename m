Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519773653; cv=none;
        d=google.com; s=arc-20160816;
        b=DP6qJWAsDlobt6InrFup5+ZGhSLRjPRAWKRJGa9XUj4dTljFJvwEYYYBZ22OqA7d2r
         jgjLkpMqoWDFqih7C6FHn28V+jy/u0ZRjSbYa7R0dNv+c1Ie5vpcz5TLA6mjigsAcbzx
         2maaenMUz9AJIqqkDHzz3bjASxY072GzemGa14/VvRGDaBrhdFE4MNo4j0nzWTd+SDB4
         +wmedI3LdKHeGCLXPxaj96v2XiL6i0fQFJxrbTlKITLAr7aYKonIyEp9Ybkimsc74gCc
         vY+AquOHfCvoTdrdMpzPlw63N4dSurA2CNnVinj8OjwSM1rabQYUsrARzKy/Lg4P2Wep
         8V7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=mtAsFo0sZfdeeeFgQpkFjrxjb6y1B/6ZvVKwvjmmwPw=;
        b=EdpANIlfwHKJRdafoqRVoaKzTCzn/YpmC75Z8O8Mia2waUGaRZdN/kDwumUyBuFVq2
         wOsYkJ1kSvFTN3iEStYLgT5aQBhpftjABMhhKNpTz+VwotRYGu7WPzZPoP9a+dT0MUoV
         QkLL2yqo8kOSFnzHgIajytsPoNZ2e14VY0lECH6M2cHDXqXa3yq+RXPx3akH9nKiy3RF
         0uFAT6MZi1dYubpeqxuIAzGEHLZUUptXXnno1GlgmiFkvRszxbiCpd4qGcV2yoAbUN/T
         9zotMj4e8l9qAaqHnTnqNTU1VF00cshnq3r/UprUDVEuyX94cPpXq1IFi6j9y8CfZRhM
         OKdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mSBWNSZ2;
       dkim=pass header.i=@chromium.org header.s=google header.b=oYEORbt2;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=mSBWNSZ2;
       dkim=pass header.i=@chromium.org header.s=google header.b=oYEORbt2;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELvANXzQLWpysg5H3mpKK+MXU7pdKMWlMrFHobJSIh+m8W2S1qUBPalLSVWkLeqbSI3uHetp0t2/u4ZQ9sMX7pE=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180224024613.24078-6-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org> <20180224024613.24078-6-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:20:51 -0800
X-Google-Sender-Auth: 0v6JhHxvLQn495FZb4Vzu1jAiS4
Message-ID: <CAGXu5jJZu40vs877NbUZ61O4R5RcutiR1ngtSRJWvdK7AO2+Og@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] firmware: use helpers for setting up a temporary
 cache timeout
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, nbroeking@me.com,
	Vikram Mulukutla <markivx@codeaurora.org>, stephen.boyd@linaro.org,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248717688632914?=
X-GMAIL-MSGID: =?utf-8?q?1593598178252577048?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> We only use the timeout for the firmware fallback mechanism
> except for trying to set the timeout during the cache setup
> for resume/suspend. For those cases, setting the timeout should
> be a no-op, so just reflect this in code by adding helpers for it.
>
> This change introduces no functional changes.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/base/firmware_loader.c | 49 ++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
> index 59dba794ce1a..2d819875348d 100644
> --- a/drivers/base/firmware_loader.c
> +++ b/drivers/base/firmware_loader.c
> @@ -191,13 +191,6 @@ static inline bool fw_is_builtin_firmware(const struct firmware *fw)
>  }
>  #endif
>
> -static int loading_timeout = 60;       /* In seconds */
> -
> -static inline long firmware_loading_timeout(void)
> -{
> -       return loading_timeout > 0 ? loading_timeout * HZ : MAX_JIFFY_OFFSET;
> -}
> -
>  static void fw_state_init(struct fw_priv *fw_priv)
>  {
>         struct fw_state *fw_st = &fw_priv->fw_st;
> @@ -282,6 +275,32 @@ static const struct firmware_fallback_config fw_fallback_config = {
>         .force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK),
>  };
>
> +static int old_timeout;
> +static int loading_timeout = 60;       /* In seconds */
> +
> +static inline long firmware_loading_timeout(void)
> +{
> +       return loading_timeout > 0 ? loading_timeout * HZ : MAX_JIFFY_OFFSET;
> +}
> +
> +/*
> + * use small loading timeout for caching devices' firmware because all these
> + * firmware images have been loaded successfully at lease once, also system is
> + * ready for completing firmware loading now. The maximum size of firmware in
> + * current distributions is about 2M bytes, so 10 secs should be enough.
> + */
> +static void fw_fallback_set_cache_timeout(void)
> +{
> +       old_timeout = loading_timeout;
> +       loading_timeout = 10;
> +}
> +
> +/* Restores the timeout to the value last configured during normal operation */
> +static void fw_fallback_set_default_timeout(void)
> +{
> +       loading_timeout =  old_timeout;
> +}
> +
>  static inline bool fw_sysfs_done(struct fw_priv *fw_priv)
>  {
>         return __fw_state_check(fw_priv, FW_STATUS_DONE);
> @@ -1206,6 +1225,8 @@ static int fw_sysfs_fallback(struct firmware *fw, const char *name,
>  }
>
>  static inline void kill_pending_fw_fallback_reqs(bool only_kill_custom) { }
> +static inline void fw_fallback_set_cache_timeout(void) { }
> +static inline void fw_fallback_set_default_timeout(void) { }
>
>  static inline int register_sysfs_loader(void)
>  {
> @@ -1752,7 +1773,6 @@ static void __device_uncache_fw_images(void)
>  static void device_cache_fw_images(void)
>  {
>         struct firmware_cache *fwc = &fw_cache;
> -       int old_timeout;
>         DEFINE_WAIT(wait);
>
>         pr_debug("%s\n", __func__);
> @@ -1760,16 +1780,7 @@ static void device_cache_fw_images(void)
>         /* cancel uncache work */
>         cancel_delayed_work_sync(&fwc->work);
>
> -       /*
> -        * use small loading timeout for caching devices' firmware
> -        * because all these firmware images have been loaded
> -        * successfully at lease once, also system is ready for
> -        * completing firmware loading now. The maximum size of
> -        * firmware in current distributions is about 2M bytes,
> -        * so 10 secs should be enough.
> -        */
> -       old_timeout = loading_timeout;
> -       loading_timeout = 10;
> +       fw_fallback_set_cache_timeout();
>
>         mutex_lock(&fw_lock);
>         fwc->state = FW_LOADER_START_CACHE;
> @@ -1779,7 +1790,7 @@ static void device_cache_fw_images(void)
>         /* wait for completion of caching firmware for all devices */
>         async_synchronize_full_domain(&fw_cache_domain);
>
> -       loading_timeout = old_timeout;
> +       fw_fallback_set_default_timeout();
>  }
>
>  /**
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security
