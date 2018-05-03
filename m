Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525386689; cv=none;
        d=google.com; s=arc-20160816;
        b=gzhvprPjGMuuTW+1dfrJKjwpUK21RrKUxSVF26N/lPVMRtPgSPRz3Ozb/wvJSbAsiA
         lUZQPRYFiZwCrmTbQ4yikk3CtisfMSlc/Kzm1isqaP2fbtmTmdDaQW0ZVOQgj1AWhptG
         whj4nxfrKJNxCwBZWGCrJB8hotis2RqpP3amA620lhx81mMqkJuJyjMCTgVUlV8TW/fw
         nBuS6aVl6BUp1RBkuUBKIZjdXjiPFu8oGpZcD9kzJIV4HbYGt+RpEeyx7oC5zRPTO2JP
         ZUbumgTK1X9lAxr4Z2WkaRutAaCaoHTun7Kaf3PGSx2TN5PsNVCyxgzDC/TEzpnUj/6y
         2ARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=m5rk9vTTU41Y0eqMpzeo3pDtUzA9CWj3UspDYvs6hRQ=;
        b=FcULNtk0BFt+fF48ok7uH34CFvPlyK9ITw/zST/OqtQP7lVj6+gz3o0XG11jBrcUEB
         UFRdz27j6E5U4AJZuLXwOp7kkhLhqHhlhWeAHwR5hCGeNRQ0kgKnTn692O5305dyqp4Q
         GWuOOVMsehHIu7yqRpb170VYPOML+7/PsVNyVGikGb5sZjR9HV6QHCJoDNIDX5Fpcmd/
         vvqsPXmli7WxIMAM5YFysZTZiKVMec9HuVLXR0QS4gM8+3VtpRZCJ8lrl6+a5+5SEuXT
         f8gRFw+zmc/Fm1QhRVfkDgrlK447PI7INzMpL+5WUoqSiMEKYtlCNWUN+Zq/q2dUUFLX
         JLlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J7vVvaRP;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=J7vVvaRP;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZrOjKPgiVbQN5BN3iWX7B+ZBRnNiW74v49MC/AnCtB1rDfspA3iB4k6Q8zo9F/saVucxiN78dScw0XLyRVNjj8=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <e8ddeeea84626e43dcac4f0731992cbad932ce7a.1525262725.git.baolin.wang@linaro.org>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
 <e8ddeeea84626e43dcac4f0731992cbad932ce7a.1525262725.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 3 May 2018 18:31:28 -0400
X-Google-Sender-Auth: W2IBI1tieqmu0oFICq5qaf0B3Cg
Message-ID: <CAK8P3a3TJ-5+22_CSYjdtL3pXEVHC7t_KzaOX6PG4X_1R1bMxQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: Convert update_persistent_clock() to update_persistent_clock64()
To: Baolin Wang <baolin.wang@linaro.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
	James Hogan <jhogan@kernel.org>, chenhc@lemote.com,
	Kate Stewart <kstewart@linuxfoundation.org>, gregkh <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>,
	Mark Brown <broonie@kernel.org>, Paul Burton <paul.burton@mips.com>,
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599409843687594194?=
X-GMAIL-MSGID: =?utf-8?q?1599483873898066890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 10:53 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
> diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
> index 17d4cd2..c4e2a1a 100644
> --- a/arch/mips/include/asm/time.h
> +++ b/arch/mips/include/asm/time.h
> @@ -27,8 +27,8 @@
>   *     rtc_mips_set_mmss - similar to rtc_set_time, but only min and sec need
>   *                     to be set.  Used by RTC sync-up.
>   */
> -extern int rtc_mips_set_time(unsigned long);
> -extern int rtc_mips_set_mmss(unsigned long);
> +extern int rtc_mips_set_time(time64_t);
> +extern int rtc_mips_set_mmss(time64_t);
>

I think these should just get removed, and each implementation replaced
with a direct update_persistent_clock64() function.

> -int update_persistent_clock(struct timespec now)
> +int update_persistent_clock64(struct timespec64 now)
>  {
>         return rtc_mips_set_mmss(now.tv_sec);
>  }

And this one also removed

> @@ -69,7 +69,7 @@ int proc_dolasatrtc(struct ctl_table *table, int write,
>                 if (rtctmp < 0)
>                         rtctmp = 0;
>         }
> -       r = proc_dointvec(table, write, buffer, lenp, ppos);
> +       r = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>         if (r)
>                 return r;
>
> @@ -224,7 +224,7 @@ int proc_lasat_prid(struct ctl_table *table, int write,
>         {
>                 .procname       = "rtc",
>                 .data           = &rtctmp,
> -               .maxlen         = sizeof(int),
> +               .maxlen         = sizeof(time64_t),
>                 .mode           = 0644,
>                 .proc_handler   = proc_dolasatrtc,
>         },

Something seems wrong here: time64_t is not the same as 'unsigned long',
and the 'rtctmp' variable is still 'unsigned int'. Not sure what the right fix
would be (we don't seem to have a sysctl helper for s64), but the change
here makes it worse.

       Arnd
