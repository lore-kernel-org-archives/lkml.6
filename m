Return-Path: <kernel-hardening-return-12469-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELte16JWF2sn6Q9woGWjgGtSkP5nUj8Ac6Hz87Wl0Hsm37cbpPGipYyXm3/XykD/5slI7/lA
ARC-Seal: i=1; a=rsa-sha256; t=1520873466; cv=none;
        d=google.com; s=arc-20160816;
        b=DhAM8Vq5ZV0uj5QkjuQp87HHMgFTaDoWydUqdrQh77MagaHKtVOLxyeKokJeXCekOh
         QFIu5Eo9YVxAsjg31gNe8jZRVRORMDEMmogj+RCkU8cTtrohyOdR8gqPOiNUX1Y2/zZa
         QbHQwVWkGC0GWbUOh5cqeCyPnGDT51NbWVue7WiyJ9O67nw9AXUvv2H+luMJYzzFMWu3
         puEJvdf22h40pKnuiPuSZbCuTWyKlNDSrCzhoyY9h2b9AQqFx4YF1IHtGBgADOrl/EFd
         lf6hNhFFb22tgBmsZIs8tAr2WEGVGRHZYTj9sII7xlMlSV0kU85tJYqiYZ602v4U9efe
         AKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=z7T0pnBehk3jP6KztTTccwBzaB4trg6t+ncuhXNTRnk=;
        b=Kfi/kqDY6FMoD67rBua/KcbhVnvbSJdB8t9+KMWaQuwBbX8ZbVLxBsW526Sp6bH0o8
         keV+7zMxVqDCLxpVSSWo4MM7Yogr3ByJ3XO/zIvOrJKK3e6vhu1b09VDhFXogn9vBeF4
         BWTkcX5znD0tpVFd+J8n6+ORLYTKklcHMqEFBU/+cM+D1+1yi7DeEkUzONq9/VrTFTY4
         AHaj/3FOJ4qWR4ydgmUNr/8T1l6yzSRN7wZKv1NE3/NJdIjmlyWnZEg5cViSTCrjVmN+
         I/BZIemj/p4FFOOHd4FicYezebi/7NKGgxiGxSGai2SPzRDo/GpCoiHqDwHKAvvd530d
         j8OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lBxMPB9f;
       spf=pass (google.com: domain of kernel-hardening-return-12469-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12469-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lBxMPB9f;
       spf=pass (google.com: domain of kernel-hardening-return-12469-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12469-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <1520858937-3582-1-git-send-email-s.mesoraca16@gmail.com>
References: <1520858937-3582-1-git-send-email-s.mesoraca16@gmail.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Mon, 12 Mar 2018 17:50:27 +0100
Message-ID: <CAJHCu1JDLJkF1Bhg0c-GeNYBKx23o3Jry7gwehrAb_yZfssJVw@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: eata: drop VLA in reorder()
To: linux-kernel@vger.kernel.org
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-scsi@vger.kernel.org,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	"Tobin C. Harding" <tobin@apporbit.com>, Dario Ballabio <ballabio_dario@emc.com>,
	Kees Cook <keescook@chromium.org>, Salvatore Mesoraca <s.mesoraca16@gmail.com>, valdis.kletnieks@vt.edu
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594676969721761588?=
X-GMAIL-MSGID: =?utf-8?q?1594751416283975758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-12 13:48 GMT+01:00 Salvatore Mesoraca <s.mesoraca16@gmail.com>:
> Avoid 3 VLAs[1] by using a single dinamically allocated array
> and some helper variables: we don't need 3 arrays.
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
>  drivers/scsi/eata.c | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/scsi/eata.c b/drivers/scsi/eata.c
> index 6501c33..8ba44b7 100644
> --- a/drivers/scsi/eata.c
> +++ b/drivers/scsi/eata.c
> @@ -2091,12 +2091,14 @@ static void sort(unsigned long sk[], unsigned int da[], unsigned int n,
>  static int reorder(struct hostdata *ha, unsigned long cursec,
>                    unsigned int ihdlr, unsigned int il[], unsigned int n_ready)
>  {
> +       int overlap;
>         struct scsi_cmnd *SCpnt;
>         struct mscp *cpp;
>         unsigned int k, n;
>         unsigned int rev = 0, s = 1, r = 1;
> -       unsigned int input_only = 1, overlap = 0;
> -       unsigned long sl[n_ready], pl[n_ready], ll[n_ready];
> +       unsigned int input_only = 1;
> +       unsigned long *sl;
> +       unsigned long sl_zero, sl_cur, sl_prev, ll_cur, ll_prev;
>         unsigned long maxsec = 0, minsec = ULONG_MAX, seek = 0, iseek = 0;
>         unsigned long ioseek = 0;
>
> @@ -2115,6 +2117,12 @@ static int reorder(struct hostdata *ha, unsigned long cursec,
>         if (n_ready <= 1)
>                 return 0;
>
> +       overlap = -ENOMEM;
> +       sl = kcalloc(n_ready, sizeof(*sl), GFP_ATOMIC);

I should have used kmalloc_array :/
Sending v3

> +       if (!sl)
> +               goto out;
> +       overlap = 0;
> +
>         for (n = 0; n < n_ready; n++) {
>                 k = il[n];
>                 cpp = &ha->cp[k];
> @@ -2164,31 +2172,33 @@ static int reorder(struct hostdata *ha, unsigned long cursec,
>         if (!((rev && r) || (!rev && s)))
>                 sort(sl, il, n_ready, rev);
>
> +       sl_zero = sl[0];
> +
>         if (!input_only)
>                 for (n = 0; n < n_ready; n++) {
>                         k = il[n];
>                         cpp = &ha->cp[k];
>                         SCpnt = cpp->SCpnt;
> -                       ll[n] = blk_rq_sectors(SCpnt->request);
> -                       pl[n] = SCpnt->serial_number;
> +                       ll_cur = blk_rq_sectors(SCpnt->request);
> +                       sl_cur = sl[n];
> +                       sl[n] = SCpnt->serial_number;
>
> -                       if (!n)
> -                               continue;
> -
> -                       if ((sl[n] == sl[n - 1])
> -                           || (!rev && ((sl[n - 1] + ll[n - 1]) > sl[n]))
> -                           || (rev && ((sl[n] + ll[n]) > sl[n - 1])))
> +                       if (n && ((sl_cur == sl_prev)
> +                                 || (!rev && ((sl_prev + ll_prev) > sl_cur))
> +                                 || (rev && ((sl_cur + ll_cur) > sl_prev))))
>                                 overlap = 1;
> +                       ll_prev = ll_cur;
> +                       sl_prev = sl_cur;
>                 }
>
>         if (overlap)
> -               sort(pl, il, n_ready, 0);
> +               sort(sl, il, n_ready, 0);
>
>         if (link_statistics) {
> -               if (cursec > sl[0])
> -                       iseek = cursec - sl[0];
> +               if (cursec > sl_zero)
> +                       iseek = cursec - sl_zero;
>                 else
> -                       iseek = sl[0] - cursec;
> +                       iseek = sl_zero - cursec;
>                 batchcount++;
>                 readycount += n_ready;
>                 seeknosort += seek / 1024;
> @@ -2225,6 +2235,8 @@ static int reorder(struct hostdata *ha, unsigned long cursec,
>                              YESNO(overlap), cpp->din);
>                 }
>  #endif
> +       kfree(sl);
> +out:
>         return overlap;
>  }
>
> --
> 1.9.1
>
