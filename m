Return-Path: <kernel-hardening-return-12263-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtsT8cTGbsix9C0Exw7QvvqYgmq+59PO6xldlfhSozxIS1kiZTE4b5hyWoVB8+OzVlBWG2z
ARC-Seal: i=1; a=rsa-sha256; t=1520543076; cv=none;
        d=google.com; s=arc-20160816;
        b=sj0fxJBUq+XpdNhl3gNZ7jskP9CJxnnjz3C2mPBAC1HLUVrEh/mqHAxYSzPeVBuB2d
         IH3+S+WPoXAuBm2HAZ0+4zZDGgt2ezxuoV8FetOtmXxDLEje5Fq2EFLESWqhyXOF1lDQ
         pLuCZUZeDcuz7ztuHiWsY4c0iyaagX7/GT2ZaDzcpL3J7oR4O0dxfVesunrt6fNm1QhJ
         zmzuIDCgbgvZPQiNn9FPd+OHXpzcbKKi3BRuW1U7weL8cHe9y+Kun3Wm7OvOcxgBHNpa
         cdfDHejXcNYITHD0M11XWemdmdNY1BLAf5s+VLrMgoGSFXYjZDb4m5r6jkEqQY3mR3C7
         yLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=nkMydW90jqy7Wjaiptus6u2nLIsSiAKrExZvyRn16Vg=;
        b=P0Ca1AYiKLhH6ahajBiuSeCLT2h3rBkW1L9hxbESThJ8WMCK2LDnGbxInQag+Fz3CA
         A8f+uVvPiR5UCBis0YObNwqLj9IXzQRvz74Ecsl16xmjV/LIR88XU7btTwKBS+Qc9zbM
         avUGJlKoqhCvGOiQjRvmQ7CTbw3c0B2XGEMznOGvT4zDerrVOG010cDBsoEEyJuAWNDh
         8Dd0/bPDFd71Mipl4/g6HxI0QxXnD7QwxdK6agVZ8YD7IaU0tOOkY9w1F+esQknfbLiE
         yYGMk93ZUwFWd5/Lb9o71xEmynhTJroaa1oQBeH0IjmVO7KaeuTsrSQy/8RHr+Ud/4W9
         dg0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eLD52diV;
       dkim=pass header.i=@chromium.org header.s=google header.b=dM//aTf8;
       spf=pass (google.com: domain of kernel-hardening-return-12263-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12263-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eLD52diV;
       dkim=pass header.i=@chromium.org header.s=google header.b=dM//aTf8;
       spf=pass (google.com: domain of kernel-hardening-return-12263-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12263-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180308205158.5130-1-steve@sk2.org>
References: <CAGXu5jK=JhBFHBGpbWF46DC3-QMruiB0qqz1z+njcK2h7jVU9w@mail.gmail.com>
 <20180308205158.5130-1-steve@sk2.org>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 13:04:15 -0800
X-Google-Sender-Auth: jR81QcLgZUXH7Qj0nOYQSTywHeI
Message-ID: <CAGXu5jL+9PUEs=Fz-ApuS5Z+oou1jA2X-uYDPBzd44hgmZ2Kpg@mail.gmail.com>
Subject: Re: [PATCH v2] aic7xxx/aic79xx: remove VLAs
To: Stephen Kitt <steve@sk2.org>
Cc: hare <hare@suse.com>, linux-scsi@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594376653072055099?=
X-GMAIL-MSGID: =?utf-8?q?1594404977601903014?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 12:51 PM, Stephen Kitt <steve@sk2.org> wrote:
> In preparation to enabling -Wvla, remove VLAs and replace them with
> fixed-length arrays instead.
>
> The arrays fixed here, using the number of constant sections, aren't
> really VLAs, but they appear so to the compiler. Replace the array
> sizes with a pre-processor-level constant instead using ARRAY_SIZE.
>
> This was prompted by https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/scsi/aic7xxx/aic79xx_core.c        | 8 ++++----
>  drivers/scsi/aic7xxx/aic79xx_seq.h_shipped | 3 +--
>  drivers/scsi/aic7xxx/aic7xxx_core.c        | 8 ++++----
>  drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped | 3 +--
>  drivers/scsi/aic7xxx/aicasm/aicasm.c       | 3 +--
>  5 files changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
> index b560f396ee99..034f4eebb160 100644
> --- a/drivers/scsi/aic7xxx/aic79xx_core.c
> +++ b/drivers/scsi/aic7xxx/aic79xx_core.c
> @@ -9338,9 +9338,9 @@ ahd_dumpseq(struct ahd_softc* ahd)
>  static void
>  ahd_loadseq(struct ahd_softc *ahd)
>  {
> -       struct  cs cs_table[num_critical_sections];
> -       u_int   begin_set[num_critical_sections];
> -       u_int   end_set[num_critical_sections];
> +       struct  cs cs_table[NUM_CRITICAL_SECTIONS];
> +       u_int   begin_set[NUM_CRITICAL_SECTIONS];
> +       u_int   end_set[NUM_CRITICAL_SECTIONS];
>         const struct patch *cur_patch;
>         u_int   cs_count;
>         u_int   cur_cs;
> @@ -9456,7 +9456,7 @@ ahd_loadseq(struct ahd_softc *ahd)
>                  * Move through the CS table until we find a CS
>                  * that might apply to this instruction.
>                  */
> -               for (; cur_cs < num_critical_sections; cur_cs++) {
> +               for (; cur_cs < NUM_CRITICAL_SECTIONS; cur_cs++) {
>                         if (critical_sections[cur_cs].end <= i) {
>                                 if (begin_set[cs_count] == TRUE
>                                  && end_set[cs_count] == FALSE) {
> diff --git a/drivers/scsi/aic7xxx/aic79xx_seq.h_shipped b/drivers/scsi/aic7xxx/aic79xx_seq.h_shipped
> index 4b51e232392f..fd64a950ee44 100644
> --- a/drivers/scsi/aic7xxx/aic79xx_seq.h_shipped
> +++ b/drivers/scsi/aic7xxx/aic79xx_seq.h_shipped
> @@ -1186,5 +1186,4 @@ static const struct cs {
>         { 759, 763 }
>  };
>
> -static const int num_critical_sections = sizeof(critical_sections)
> -                                      / sizeof(*critical_sections);
> +#define NUM_CRITICAL_SECTIONS ARRAY_SIZE(critical_sections)
> diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
> index 6612ff3b2e83..e97eceacf522 100644
> --- a/drivers/scsi/aic7xxx/aic7xxx_core.c
> +++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
> @@ -6848,9 +6848,9 @@ ahc_dumpseq(struct ahc_softc* ahc)
>  static int
>  ahc_loadseq(struct ahc_softc *ahc)
>  {
> -       struct  cs cs_table[num_critical_sections];
> -       u_int   begin_set[num_critical_sections];
> -       u_int   end_set[num_critical_sections];
> +       struct  cs cs_table[NUM_CRITICAL_SECTIONS];
> +       u_int   begin_set[NUM_CRITICAL_SECTIONS];
> +       u_int   end_set[NUM_CRITICAL_SECTIONS];
>         const struct patch *cur_patch;
>         u_int   cs_count;
>         u_int   cur_cs;
> @@ -6915,7 +6915,7 @@ ahc_loadseq(struct ahc_softc *ahc)
>                  * Move through the CS table until we find a CS
>                  * that might apply to this instruction.
>                  */
> -               for (; cur_cs < num_critical_sections; cur_cs++) {
> +               for (; cur_cs < NUM_CRITICAL_SECTIONS; cur_cs++) {
>                         if (critical_sections[cur_cs].end <= i) {
>                                 if (begin_set[cs_count] == TRUE
>                                  && end_set[cs_count] == FALSE) {
> diff --git a/drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped b/drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped
> index 07e93fbae706..f37362bc8ece 100644
> --- a/drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped
> +++ b/drivers/scsi/aic7xxx/aic7xxx_seq.h_shipped
> @@ -1304,5 +1304,4 @@ static const struct cs {
>         { 875, 877 }
>  };
>
> -static const int num_critical_sections = sizeof(critical_sections)
> -                                      / sizeof(*critical_sections);
> +#define NUM_CRITICAL_SECTIONS ARRAY_SIZE(critical_sections)
> diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm.c b/drivers/scsi/aic7xxx/aicasm/aicasm.c
> index 21ac265280bf..5f474e490f3e 100644
> --- a/drivers/scsi/aic7xxx/aicasm/aicasm.c
> +++ b/drivers/scsi/aic7xxx/aicasm/aicasm.c
> @@ -451,8 +451,7 @@ output_code()
>         fprintf(ofile, "\n};\n\n");
>
>         fprintf(ofile,
> -"static const int num_critical_sections = sizeof(critical_sections)\n"
> -"                                     / sizeof(*critical_sections);\n");
> +       "#define NUM_CRITICAL_SECTIONS ARRAY_SIZE(critical_sections)\n");
>
>         fprintf(stderr, "%s: %d instructions used\n", appname, instrcount);
>  }
> --
> 2.11.0
>



-- 
Kees Cook
Pixel Security
