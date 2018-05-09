Return-Path: <tkjos@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525889327; cv=none;
        d=google.com; s=arc-20160816;
        b=nfvodCXZBMvD6km7cd8PRvM7WXZcHjkqONvtIVYv4W++zjy4o45zPEb14vjvzdpPxN
         N27XWASQ86rd060BBn+HF3BIQdlgipGjBRw3E99+s2QaaeKiZbRXB/lC9ca4P9IkbPHp
         v2jt6+gnMh/sEArpI+0p9EHVJpOtUARosw5e44f081GLM3DAkx9wV09UZdXpeDnlscRG
         2iHm6zJ8oYmJ8mpoS132NJ0HyuczkHpplBCwkSLIIhWokfNqTWIDrYNH46hueU4cXDhB
         gwP8GaF1+sxOQ5yWUNHZu9Hf2ik4/ChM0gKkx56kOCtK9YfiW9uWSBI4AYvE/eYIsgse
         Dlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :arc-authentication-results;
        bh=XtESeSuLMSPtJg4x3MlTJnPt01ykYfeawiDaKRyqr0g=;
        b=k2pbgO84D9MMmdYL1YGhoTfqBSUBldwAyiToYOXAskNJMClD8Z40w1//U4iHSKTDqr
         g1MLu4Bm37oN7awolgWNqzB1kKhNSJsEHDc1kbXLEQ1EDFLfJKVHh16NvQ3/frlyYOnR
         5fKalIsJhQlA9lT6ydOpGTC2u2sOJzkaoxHYWKPzsH+S9TJ2eb/oMrtCJF3SXgdzwli8
         oObvSqSzJnoR0mUQ8+cCRHXFzBub8zOVHFyfioXYeMJ2U3Ow0m26WnX2XIGl+9B/qpGT
         EM8kqP0K53Mfh8UBTZzn+tEg2iE365f4Q6iTHs2AhYcuJrRbdt6w5orC9iBSjzYzZL6e
         HQNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=XyNFbstd;
       spf=pass (google.com: domain of tkjos@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=XyNFbstd;
       spf=pass (google.com: domain of tkjos@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tkjos@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZpo+WvFZxZ7rmheJTSqHitPtyvRghYrBvXvvFlQhMWbwJHhfeImx2M2kcm94ZcDN61r9hq/ZIv/am9R0Edd+7I=
MIME-Version: 1.0
References: <1525851089096.52313@xiaomi.com>
In-Reply-To: <1525851089096.52313@xiaomi.com>
From: Todd Kjos <tkjos@google.com>
Date: Wed, 09 May 2018 18:08:36 +0000
Message-ID: <CAHRSSEwjH=GyxR7E0WhpDb9so_Lc=3-M=2-zmYhptViX5=ZSTg@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: correct the cmd print for BINDER_WORK_RETURN_ERROR
To: =?UTF-8?B?5a6L6YeR5pe2?= <songjinshi@xiaomi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martijn Coenen <maco@android.com>,
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599970857323840855?=
X-GMAIL-MSGID: =?utf-8?q?1600010927899769382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 12:31 AM =E5=AE=8B=E9=87=91=E6=97=B6 <songjinshi@xia=
omi.com> wrote:

> In case of the BINDER_WORK_RETURN_ERROR the cmd is no assignment,
> so it's value will be old value or dirty value, before modifying
> e->cmd, assign the value of the e->cmd to cmd to ensure the correct
> print of binder_stat_br.


That's not the problem... the problem is that e->cmd is unconditionally set
to BR_OK prior to the call to binder_stat_br(proc, thread, e->cmd) so the
reported cmd is always BR_OK.


> Signed-off-by: songjinshi <songjinshi@xiaomi.com>
> ---

> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 4ffc84d..acd7d44a 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -4086,6 +4086,7 @@
>                          struct binder_error *e =3D container_of(
>                                          w, struct binder_error, work);

> +                       cmd =3D e->cmd;
>                          WARN_ON(e->cmd =3D=3D BR_OK);
>                          binder_inner_proc_unlock(proc);
>                          if (put_user(e->cmd, (uint32_t __user *)ptr))


Don't you also need to use cmd in the call to binder_state_br() below?

-                       binder_stat_br(proc, thread, e->cmd);
+                       binder_stat_br(proc, thread, cmd);

-Todd
