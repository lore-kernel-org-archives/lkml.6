Return-Path: <kkamagui@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519914164; cv=none;
        d=google.com; s=arc-20160816;
        b=ZZkgF4+HT0lgrpUUNYheVka/HUTm4H1SZxlC71gujvBJRL66qmZ2dUF3ZVZ1fNC/aK
         ZZjsy0BeDz1YUp/JRhmAdI145S998HKwgfb9QRNE/T53HxYtRU8nJJ4/sDYm8FB9maBW
         VSAzDc2yFHf8+IP4g34s0odHLqhJs5GKO5KCgXYnTZbYr9UhB43WAQhNt0WHL03lA24d
         QLoldioNqLM4WthcX8/jHS8rdP0m3VVZ7IzBJ3Jy8gMP+b7GQu6rUmxR2khXR2vrgBf7
         aXahLW/2ynf8GNErV+IBijSsmr7vRmFQPWFccDr9/J5ugidoWiIiba0SOWVafUK2IIhN
         5H/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=cJrpLNqwGcRYVsrhNYfNXb5b16jVZWO1es3FREdGne4=;
        b=Vq0q0KtmLXUnq3b7vXfNY+7gHNzUjXxjiaNy/seB4bXtiep09xbjn8r+3Rwj41k5Yi
         n1HDfY+u4PhP2wby5dSzSlZYq9skZXzYz1FCLzteGWRcpCv7/Cc4H52cktr0CdiUnT8c
         TfHMaPD6VEif4G887fADP4mbzTHZ7TY28os/bBtQYn6IgiryhJvNPr9PzY2NtkKH2QDa
         i1BplBXk03/jcrms/Mp9jOrE0dRVu79VGjge3+0s5xu2+zfPU+h/yx2OaoWoWSqP2Jnh
         zacLDihFooIOh8HWyUaWyS/w/t88rZ1o0aKahNkN7cohDmpJ28fHrk0yR3Oz2PMYjFSv
         AcHw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OEzoiwPt;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=OEzoiwPt;
       spf=pass (google.com: domain of kkamagui@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=kkamagui@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvF7evaunkgZcx7R2XqzIj5FDUp7N8h9bIPiz9D10MlfQ1lsf6fcGHgHsSeVUuGLgnulXAP0E2Mj4V4jKUl4qA=
MIME-Version: 1.0
In-Reply-To: <20180228203131.3176-1-kkamagui@gmail.com>
References: <20180228203131.3176-1-kkamagui@gmail.com>
From: Seunghun Han <kkamagui@gmail.com>
Date: Thu, 1 Mar 2018 23:22:42 +0900
Message-ID: <CAHjaAcT6QtT9t_=9qBXA2mDYrfn9LLg=HMMH3FpzVP+VDxxrUA@mail.gmail.com>
Subject: Re: [PATCH V2] x86: mce: fix kernel panic when check_interval is changed
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Seunghun Han <kkamagui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1593745514263388370?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Borislav.

I made new patch according to your advice.
The patch is here, https://lkml.org/lkml/2018/2/28/1230.

If you have any advice about it, please let me know.

Best regards.

Seunghun.

2018-03-01 5:31 GMT+09:00 Seunghun Han <kkamagui@gmail.com>:
> I am Seunghun Han and a senior security researcher at National Security
> Research Institute of South Korea.
>
> I found a security issue which can make kernel panic in userspace. After
> analyzing the issue carefully, I found that MCE driver in the kernel has a
> problem which can be occurred in SMP environment.
>
> The check_interval file in
> /sys/devices/system/machinecheck/machinecheck<cpu number> directory is a
> global timer value for MCE polling. If it is changed by one CPU, MCE driver
> in kernel calls mce_restart() function and broadcasts the event to other
> CPUs to delete and restart MCE polling timer.
>
> The __mcheck_cpu_init_timer() function which is called by mce_restart()
> function initializes the mce_timer variable, and the "lock" in mce_timer is
> also reinitialized. If more than one CPU write a specific value to
> check_interval file concurrently, one can initialize the "lock" in mce_timer
> while the others are handling "lock" in mce_timer. This problem causes some
> synchronization errors such as kernel panic and kernel hang.
>
> It is a security problem because the attacker can make kernel panic by
> writing a value to the check_interval file in userspace, and it can be used
> for Denial-of-Service (DoS) attack.
>
> To fix this problem, I added a mce_sysfs_mutex to serialize requests.
>
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>
> ---
> Changes since v1: add mce_sysfs_mutex according to review result.
>
>  arch/x86/kernel/cpu/mcheck/mce.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index 706584681a4c..bee0795a3b8c 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -55,6 +55,7 @@
>  #include "mce-internal.h"
>
>  static DEFINE_MUTEX(mce_log_mutex);
> +static DEFINE_MUTEX(mce_sysfs_mutex);
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/mce.h>
> @@ -2045,8 +2046,11 @@ static void mce_enable_ce(void *all)
>                 return;
>         cmci_reenable();
>         cmci_recheck();
> -       if (all)
> +       if (all) {
> +               mutex_lock(&mce_sysfs_mutex);
>                 __mcheck_cpu_init_timer();
> +               mutex_unlock(&mce_sysfs_mutex);
> +       }
>  }
>
>  static struct bus_type mce_subsys = {
> @@ -2132,8 +2136,14 @@ static ssize_t store_int_with_restart(struct device *s,
>                                       struct device_attribute *attr,
>                                       const char *buf, size_t size)
>  {
> +       unsigned long old_check_interval = check_interval;
>         ssize_t ret = device_store_int(s, attr, buf, size);
> +
> +       if (check_interval == old_check_interval)
> +               return ret;
> +       mutex_lock(&mce_sysfs_mutex);
>         mce_restart();
> +       mutex_unlock(&mce_sysfs_mutex);
>         return ret;
>  }
>
> --
> 2.16.2
>
