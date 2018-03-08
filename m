Return-Path: <kernel-hardening-return-12266-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtAEk+ILYl3Noatx5IsLWbjL+J1/1kXsTnxbdXFiXOpMlILC7s6zs4bSy1b46yI//xvJpQ9
ARC-Seal: i=1; a=rsa-sha256; t=1520545407; cv=none;
        d=google.com; s=arc-20160816;
        b=RsSemnYjipXcbHTWmdkzNquqcbqMEyGDZe+uj47i6yNNJe5w9U7qcHp69UwGPEIP6G
         boePqwGpFOrl84K1YZsl3qz3oduncEtBZXApB6BwAEiajtmIN9MYq1HwkrblmL43rR34
         qqGHpWD7DEU587f/Gp6Phw5ScDv+F2lTvOriJ/kKs430+M1RPRU2J9Vd2U64tZFIKkQK
         6uIo92qw+wjH6zTMAXYCOsnbGvuAMaPVXiSAlW32PAT0RyOyC6nGCbNXXit2rUUc2c5P
         UYo2yweKV2kGMEJv9yGLnmL36jp6oIv5Z+jU917eK5oo+OcBfv8Tb7zzXGc45hLkpFYd
         71Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=FsgCRzrIT2zTu3rBsE1PDyKJ4oK45bQI+ULBde645QE=;
        b=eNwNIxmQZ2eEMys0bc2keDIrCElYSl5SLFFn2kL5L0kUmu0ulRe3Qni3Zw2lDh5JZ7
         UNx+qzZ4of+ln/ywXMb9yoYYxKja67n/q5WQApBGQSTv7HrMibtcs4kT7t+s0zS31b3k
         jW0mhMrJ2COPFe5rAQ3q5sEq4iNvQrPsWyMkG0WT+q4dIOPP4Z2xd3LmP0fkPIQ4J4td
         0xwKF8aQ0dud3MQSeL9y2t4gqRosonR8OloJjIARSjKeXL6j0gFsIM4aJtDauuzN45O5
         oCkzw114p8QksrFy/XeJYI5D1O1QDL5CnTseXHO22srKsa4s36VxscR6YktOZ6gdsTUu
         Ofww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=VSdPPLNy;
       dkim=pass header.i=@chromium.org header.s=google header.b=g4xQG4iV;
       spf=pass (google.com: domain of kernel-hardening-return-12266-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12266-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=VSdPPLNy;
       dkim=pass header.i=@chromium.org header.s=google header.b=g4xQG4iV;
       spf=pass (google.com: domain of kernel-hardening-return-12266-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12266-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180308213841.13807-1-steve@sk2.org>
References: <20180308213841.13807-1-steve@sk2.org>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 8 Mar 2018 13:43:07 -0800
X-Google-Sender-Auth: gaD_F1DaqU4mzYsnTZZfLhCshzw
Message-ID: <CAGXu5j+_DvU4jNESxO2zBvP_VrTxOwVzh_NXqdw+S5amQukNjg@mail.gmail.com>
Subject: Re: [PATCH] bfa: remove VLA
To: Stephen Kitt <steve@sk2.org>
Cc: hare <hare@suse.com>, linux-scsi@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594407144538028292?=
X-GMAIL-MSGID: =?utf-8?q?1594407421298299403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 1:38 PM, Stephen Kitt <steve@sk2.org> wrote:
> In preparation to enabling -Wvla, remove VLAs and replace them with
> fixed-length arrays instead.
>
> bfad_bsg.c uses a variable-length array declaration to measure the
> size of a putative array; this can be replaced by the product of the
> size of an element and the number of elements, avoiding the VLA
> altogether.
>
> This was prompted by https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/scsi/bfa/bfad_bsg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/bfa/bfad_bsg.c b/drivers/scsi/bfa/bfad_bsg.c
> index 3976e787ba64..7c884f881180 100644
> --- a/drivers/scsi/bfa/bfad_bsg.c
> +++ b/drivers/scsi/bfa/bfad_bsg.c
> @@ -891,7 +891,7 @@ bfad_iocmd_fabric_get_lports(struct bfad_s *bfad, void *cmd,
>
>         if (bfad_chk_iocmd_sz(payload_len,
>                 sizeof(struct bfa_bsg_fabric_get_lports_s),
> -               sizeof(wwn_t[iocmd->nports])) != BFA_STATUS_OK) {
> +               sizeof(wwn_t) * iocmd->nports) != BFA_STATUS_OK) {
>                 iocmd->status = BFA_STATUS_VERSION_FAIL;
>                 goto out;
>         }
> --
> 2.11.0
>



-- 
Kees Cook
Pixel Security
