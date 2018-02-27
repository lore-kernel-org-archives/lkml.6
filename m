Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519773680; cv=none;
        d=google.com; s=arc-20160816;
        b=a4O9SWc+NAd/wjejxpnu8W7nlLjB3eSICnMZfaw9RzS8/II0MEocWSCbMBtJCTJJI6
         +kCBkZhJiKxIMgn7qWjl7Bwd3yWruZusjjMDEbOl+nmKrddcx8G3pf5Ix1ge+bF2k+wt
         EU2Rvm6333ICgGMQoBSLrXehCyHuYm05OdLhZv/Sjf8HU82SRTgpQKOSDxA0+phH7ZFa
         +KhPJBOp1gzncs6ZxoICIMGvX3Y1B5qaXAqQOs9e11ZK8oa6CRHU1VkdEDYQgjjoJlZ6
         W/DbiQsl5X6Zbgw40lTiBagbSJbsEY+EpKmPzuDW5qkIiXtJm07URBwJhDMTKg9zmRED
         LJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=3RdfTT0amCvM3dUUgFKv5Cy0oZtGWGG9SFiXUlMMigw=;
        b=m5rFbZ0xbJ8a0+kXu9COiwYPM1quBWZthMc9Djb1b1IkwUUccrh0qNili7WFi1YjEm
         L/Fpqcof9jTP/MixpZ5uyQRFG//3cYvwh3WJ1pXy2dWX7xsfb5vUpfeKBvLUR3YBT+IJ
         4H7EIc9wr+zbw75/GuQqPzM7y2ji28p4mmI/TqraEEdE0U9yS6QQ4pQm7WJHDYHT3qgn
         p7VBeTElCCHEOCty9aSSXw/cig0xeubCkFYA8sKmPHd/IpXqhNsKT55FAn8G6GDnpO9n
         x36X5b8E40teryDD6D1QzUhZCzclcapsuGvIVwyjwNq3PBcbN1s6JEzYG6gYXYJA/KbB
         u9Zw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cPeheTA1;
       dkim=pass header.i=@chromium.org header.s=google header.b=neN/Z0FH;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=cPeheTA1;
       dkim=pass header.i=@chromium.org header.s=google header.b=neN/Z0FH;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELuQiFiqtZbiyAOf0uoDh9cwprepJMxDrjGiPpUtKSiZiN1WprXVUVYtGUAmQjB1yPqbtN/KWqBOfsbd3RQHJxQ=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180224024613.24078-7-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org> <20180224024613.24078-7-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:21:19 -0800
X-Google-Sender-Auth: ziddqQ88V5-aQCBQ3qP0_9iAENA
Message-ID: <CAGXu5jK-S=LsDZgzemHREC_bf99xWXqZtr25CDrEL-QgW=1Ziw@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] firmware: move loading timeout under struct firmware_fallback_config
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
X-GMAIL-THRID: =?utf-8?q?1593248718555025145?=
X-GMAIL-MSGID: =?utf-8?q?1593598206910340884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 6:46 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> The timeout is a fallback construct, so we can just stuff the
> timeout configuration under struct firmware_fallback_config.
>
> While at it, add a few helpers which vets the use of getting or
> setting the timeout as an int. The main use of the timeout is
> to set a timeout for completion, and that is used as an unsigned
> long. There a few cases however where it makes sense to get or
> set the timeout as an int, the helpers annotate these use cases
> have been properly vetted for.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/base/firmware_loader.c | 46 ++++++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
> index 2d819875348d..9757f9fff01e 100644
> --- a/drivers/base/firmware_loader.c
> +++ b/drivers/base/firmware_loader.c
> @@ -266,21 +266,38 @@ static inline bool fw_state_is_aborted(struct fw_priv *fw_priv)
>   *
>   * @force_sysfs_fallback: force the sysfs fallback mechanism to be used
>   *     as if one had enabled CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y.
> + * @old_timeout: for internal use
> + * @loading_timeout: the timeout to wait for the fallback mechanism before
> + *     giving up, in seconds.
>   */
>  struct firmware_fallback_config {
> -       bool force_sysfs_fallback;
> +       const bool force_sysfs_fallback;
> +       int old_timeout;
> +       int loading_timeout;
>  };
>
> -static const struct firmware_fallback_config fw_fallback_config = {
> +static struct firmware_fallback_config fw_fallback_config = {
>         .force_sysfs_fallback = IS_ENABLED(CONFIG_FW_LOADER_USER_HELPER_FALLBACK),
> +       .loading_timeout = 60,
> +       .old_timeout = 60,
>  };
>
> -static int old_timeout;
> -static int loading_timeout = 60;       /* In seconds */
> +/* These getters are vetted to use int properly */
> +static inline int __firmware_loading_timeout(void)
> +{
> +       return fw_fallback_config.loading_timeout;
> +}
> +
> +/* These setters are vetted to use int properly */
> +static void __fw_fallback_set_timeout(int timeout)
> +{
> +       fw_fallback_config.loading_timeout = timeout;
> +}
>
>  static inline long firmware_loading_timeout(void)
>  {
> -       return loading_timeout > 0 ? loading_timeout * HZ : MAX_JIFFY_OFFSET;
> +       return __firmware_loading_timeout() > 0 ?
> +               __firmware_loading_timeout() * HZ : MAX_JIFFY_OFFSET;
>  }
>
>  /*
> @@ -291,14 +308,14 @@ static inline long firmware_loading_timeout(void)
>   */
>  static void fw_fallback_set_cache_timeout(void)
>  {
> -       old_timeout = loading_timeout;
> -       loading_timeout = 10;
> +       fw_fallback_config.old_timeout = __firmware_loading_timeout();
> +       __fw_fallback_set_timeout(10);
>  }
>
>  /* Restores the timeout to the value last configured during normal operation */
>  static void fw_fallback_set_default_timeout(void)
>  {
> -       loading_timeout =  old_timeout;
> +       __fw_fallback_set_timeout(fw_fallback_config.old_timeout);
>  }
>
>  static inline bool fw_sysfs_done(struct fw_priv *fw_priv)
> @@ -677,7 +694,7 @@ static void kill_pending_fw_fallback_reqs(bool only_kill_custom)
>  static ssize_t timeout_show(struct class *class, struct class_attribute *attr,
>                             char *buf)
>  {
> -       return sprintf(buf, "%d\n", loading_timeout);
> +       return sprintf(buf, "%d\n", __firmware_loading_timeout());
>  }
>
>  /**
> @@ -696,9 +713,12 @@ static ssize_t timeout_show(struct class *class, struct class_attribute *attr,
>  static ssize_t timeout_store(struct class *class, struct class_attribute *attr,
>                              const char *buf, size_t count)
>  {
> -       loading_timeout = simple_strtol(buf, NULL, 10);
> -       if (loading_timeout < 0)
> -               loading_timeout = 0;
> +       int tmp_loading_timeout = simple_strtol(buf, NULL, 10);
> +
> +       if (tmp_loading_timeout < 0)
> +               tmp_loading_timeout = 0;
> +
> +       __fw_fallback_set_timeout(tmp_loading_timeout);
>
>         return count;
>  }
> @@ -721,7 +741,7 @@ static int do_firmware_uevent(struct fw_sysfs *fw_sysfs, struct kobj_uevent_env
>  {
>         if (add_uevent_var(env, "FIRMWARE=%s", fw_sysfs->fw_priv->fw_name))
>                 return -ENOMEM;
> -       if (add_uevent_var(env, "TIMEOUT=%i", loading_timeout))
> +       if (add_uevent_var(env, "TIMEOUT=%i", __firmware_loading_timeout()))
>                 return -ENOMEM;
>         if (add_uevent_var(env, "ASYNC=%d", fw_sysfs->nowait))
>                 return -ENOMEM;
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security
