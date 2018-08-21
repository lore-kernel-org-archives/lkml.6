Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C6C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7888A20661
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="lIs6V7te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7888A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ucsc.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeHVAqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:46:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36914 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeHVAqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:46:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so17007944wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z410QeI9xStMbX3pyICN17asT3/ywjL4aa6wXQOzhm4=;
        b=lIs6V7tel5YmPobUC5jT0ksCZ02hI+eKsiEgGJRRfAdJCGsjNeRmgukAU55A6fmHfP
         +a/GjPywHFuZg0fKCruYGfCFp05BLJam2G3lGqWO2+7YN6Vtx2VD5/5EVbOpNJqEDc4g
         ucm3fQ5YX4hmAS0mFy7Q8qXhL3xo+F9ifV5cQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z410QeI9xStMbX3pyICN17asT3/ywjL4aa6wXQOzhm4=;
        b=YBvhyDOh4XMwc2IKgG9Yn+VWce59jKQSplz1LiIH+drCyXCDQSxYMk83M0E19LXPCf
         5UzbtDOxDgrGaAXbdE9soAYPSxP4ODdSWVTpjbntCEwgrz0NNHnXZAZMnBBiExNY1urp
         YyIRnONQqe4kCq5S55BD8LOV+M81UnfDKFna+ETJLnGHoQg/sTU+mwOpYf2RsqoqFZqy
         SKuaAw97XGu1RPL3xPo/u0f9BWXLQE9gRPTkFDwHzSy0cys+VZdPRzS0skpqw8+zeelw
         /KBeXhm61LSm2BxnEThUQxSMJMd3SfzgEaymo2Q2ujx5jmZ1ShZ+XyRCu4E5YdubfZBU
         hIRQ==
X-Gm-Message-State: APzg51AIwuI88lMg9MFil1O5GOdf0cQuoLMcZDw8Cpe7FVbZY3eC049R
        ckUbSAT+HW8u0jNkBnjAICEJ0SyYxGKeacCas58qFA==
X-Google-Smtp-Source: ANB0VdZTte+oIErsoECwLaHH6FwkLyz1NRbIOsLsSApsseGWZik0+j7Ds7gwXaMuNw/9wBH3nLCGZDVDiNaNyUybBYg=
X-Received: by 2002:adf:9281:: with SMTP id 1-v6mr4839135wrn.69.1534886672897;
 Tue, 21 Aug 2018 14:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180821114441.23147-1-mb@lightnvm.io>
In-Reply-To: <20180821114441.23147-1-mb@lightnvm.io>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Tue, 21 Aug 2018 23:24:01 +0200
Message-ID: <CAJbgVnWYr6HMjO_gnQpyhrZ0cT5G9e-TPjqtRpaao0dW7rvEXg@mail.gmail.com>
Subject: Re: [PATCH v2] lightnvm: pblk: refactor put line fn on read completion
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        Javier Gonzalez <javier@cnexlabs.com>,
        hans.holmberg@cnexlabs.com, youngtack.jin@circuitblvd.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Matias!

LGTM

On Tue, Aug 21, 2018 at 1:44 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> The read completion path uses the put_line variable to decide whether
> the reference on a line should be released. The function name used for
> that is pblk_read_put_rqd_kref, which could lead one to believe that it
> is the rqd that is releasing the reference, while it is the line
> reference that is put.
>
> Rename and also split the function in two to account for either rqd or
> single ppa callers and move it to core, such that it later can be used
> in the write path as well.
>
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
> Reviewed-by: Heiner Litz <hlitz@ucsc.edu>
>
> Changes since v1:
>
>   Moved into core for Heiner to later integrate with his RAIL
>   patches.
> ---
>  drivers/lightnvm/pblk-core.c | 19 +++++++++++++++++++
>  drivers/lightnvm/pblk-read.c | 18 +-----------------
>  drivers/lightnvm/pblk.h      |  2 ++
>  3 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index e0b513d07e14..5f99cf396072 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1426,6 +1426,25 @@ struct pblk_line *pblk_line_get_first_data(struct =
pblk *pblk)
>         return line;
>  }
>
> +void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa)
> +{
> +       struct pblk_line *line;
> +
> +       line =3D &pblk->lines[pblk_ppa_to_line(ppa)];
> +       kref_put(&line->ref, pblk_line_put_wq);
> +}
> +
> +void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd)
> +{
> +       struct ppa_addr *ppa_list;
> +       int i;
> +
> +       ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
> +
> +       for (i =3D 0; i < rqd->nr_ppas; i++)
> +               pblk_ppa_to_line_put(pblk, ppa_list[i]);
> +}
> +
>  static void pblk_stop_writes(struct pblk *pblk, struct pblk_line *line)
>  {
>         lockdep_assert_held(&pblk->l_mg.free_lock);
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 1ad501721d0f..dc8233f3fd6c 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -165,22 +165,6 @@ static void pblk_read_check_rand(struct pblk *pblk, =
struct nvm_rq *rqd,
>         WARN_ONCE(j !=3D rqd->nr_ppas, "pblk: corrupted random request\n"=
);
>  }
>
> -static void pblk_read_put_rqd_kref(struct pblk *pblk, struct nvm_rq *rqd=
)
> -{
> -       struct ppa_addr *ppa_list;
> -       int i;
> -
> -       ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
> -
> -       for (i =3D 0; i < rqd->nr_ppas; i++) {
> -               struct ppa_addr ppa =3D ppa_list[i];
> -               struct pblk_line *line;
> -
> -               line =3D &pblk->lines[pblk_ppa_to_line(ppa)];
> -               kref_put(&line->ref, pblk_line_put_wq);
> -       }
> -}
> -
>  static void pblk_end_user_read(struct bio *bio)
>  {
>  #ifdef CONFIG_NVM_PBLK_DEBUG
> @@ -208,7 +192,7 @@ static void __pblk_end_io_read(struct pblk *pblk, str=
uct nvm_rq *rqd,
>                 bio_put(int_bio);
>
>         if (put_line)
> -               pblk_read_put_rqd_kref(pblk, rqd);
> +               pblk_rq_to_line_put(pblk, rqd);
>
>  #ifdef CONFIG_NVM_PBLK_DEBUG
>         atomic_long_add(rqd->nr_ppas, &pblk->sync_reads);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 64ae0c7ed3bb..be67bbfa3d0a 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -787,6 +787,8 @@ struct bio *pblk_bio_map_addr(struct pblk *pblk, void=
 *data,
>  struct pblk_line *pblk_line_get(struct pblk *pblk);
>  struct pblk_line *pblk_line_get_first_data(struct pblk *pblk);
>  struct pblk_line *pblk_line_replace_data(struct pblk *pblk);
> +void pblk_ppa_to_line_put(struct pblk *pblk, struct ppa_addr ppa);
> +void pblk_rq_to_line_put(struct pblk *pblk, struct nvm_rq *rqd);
>  int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line);
>  void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line);
>  struct pblk_line *pblk_line_get_data(struct pblk *pblk);
> --
> 2.11.0
>
