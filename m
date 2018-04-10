Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523347068; cv=none;
        d=google.com; s=arc-20160816;
        b=xgv2y3GktRGBy/HzoaV3+P29D8sODlKMsozgW6Lxk6jXCqc9mAcaNWCJ2ci35Yb6kp
         C8onkeJcFb4nm7WQoNsC8l3MPAdKvGsvsmDto/BpDR4FkFEVDgWPoGgmr3KkIVYULba8
         eRYLM0Ydxq8PV6gh9WyvAQOOtxr1uvOOGESGk/Q4Q2CoLRyYZaSkbbUU4KIY/1U7qLCb
         i2f12noxL86AiNzUrYoCotC9L2beuQJxdOuHo85Wz5KqJivhs+f+pZvD1t0gQhsQ4WMY
         onUkQq5w/R6Qwl9g3pZRIj2e/mEta7Qequ7EgbyQ/eGu+UXzbfbp9LQJsXKL9zihCWpZ
         ra/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=T1OL7LXZRIPwKb37obrWR4yvuSZLsPiM8G7GBsLiJtw=;
        b=iI5DQZVHZebA5I32Lby/87jz1Bn0ob/XY44iAa9DuwWODvCV0KUutZpzeE8pbIiuLP
         tUzskb5BnSSPO3VpcKyi86dkL4GzYljRTPdkK262D2OiJvhgDuom7TisG4pn/uB2nGFC
         2TAMn9zJpwPSjJ/JgCXCd3GfCKK4XpMyNhbvJhNKxHnlDq1CAqPlV2LNGNQq15a2/vwa
         Y6kqjdA0O2W8NCFc1UnaGaec0K74A+2lrZ+waaPbFrX++ozt9TiJjsc8FHtm3CTeIZVW
         CgsO1VLAUwNadrstZigzfuq6cAqhwx8WM6WXPn3Jnp54/leFFXJokzvqbRZfJjTJG/Ap
         xKZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r/IrHuU6;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=r/IrHuU6;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AIpwx4+BreXcDJGrmwUf5tdRYl+fmqsgkTpdcbGgyG0EBD44t7+WFmeRyLh/Vb5fDUIzSDuhS1VNRGTbENtWlDhsbCk=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180409210732.3919-1-labbott@redhat.com>
References: <20180409210732.3919-1-labbott@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 10 Apr 2018 09:57:46 +0200
X-Google-Sender-Auth: -3gO0PhR0vUxZ7mASjyFwWOUdPU
Message-ID: <CAK8P3a3Yo0riMroM3x4EVz8FkMakdPkkJ-mCTYW0qOji+MCCiQ@mail.gmail.com>
Subject: Re: [PATCH] misc: tifm: Remove VLA
To: Laura Abbott <labbott@redhat.com>
Cc: Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304272703650108?=
X-GMAIL-MSGID: =?utf-8?q?1597345175143511741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 9, 2018 at 11:07 PM, Laura Abbott <labbott@redhat.com> wrote:
> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
> turn on -Wvla. The single VLA can either take a value of 2 or 4 so switch
> to the upper bound.
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  drivers/misc/tifm_7xx1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
> index e5f108713dd8..690eaaea5ce4 100644
> --- a/drivers/misc/tifm_7xx1.c
> +++ b/drivers/misc/tifm_7xx1.c
> @@ -239,7 +239,8 @@ static int tifm_7xx1_resume(struct pci_dev *dev)
>         unsigned long timeout;
>         unsigned int good_sockets = 0, bad_sockets = 0;
>         unsigned long flags;
> -       unsigned char new_ids[fm->num_sockets];
> +       /* Maximum number of entries is 4 */
> +       unsigned char new_ids[4];
>         DECLARE_COMPLETION_ONSTACK(finish_resume);
>

I like the idea of removing all the VLAs, but this one appears to make
the code less robust rather than more: In case of an unexpected
fm->num_sockets value, we now not only overflow the kernel stack
area but also the local variable into the neighboring stack slots.

Maybe add an extra overflow check?

       Arnd

diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
index e5f108713dd8..c702cd92d396 100644
--- a/drivers/misc/tifm_7xx1.c
+++ b/drivers/misc/tifm_7xx1.c
@@ -239,9 +239,12 @@ static int tifm_7xx1_resume(struct pci_dev *dev)
        unsigned long timeout;
        unsigned int good_sockets = 0, bad_sockets = 0;
        unsigned long flags;
-       unsigned char new_ids[fm->num_sockets];
+      /* Maximum number of entries is 4 */
+       unsigned char new_ids[4];
        DECLARE_COMPLETION_ONSTACK(finish_resume);

+       if (WARN_ON(fm->num_sockets > ARRAY_SIZE(new_ids)))
+               return -ENXIO;
+
        pci_set_power_state(dev, PCI_D0);
        pci_restore_state(dev);
        rc = pci_enable_device(dev);
