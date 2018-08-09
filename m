Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FC2C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2E721C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+IhOH8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2E721C16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeHIExZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:53:25 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44438 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeHIExZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:53:25 -0400
Received: by mail-wr1-f42.google.com with SMTP id r16-v6so3704163wrt.11;
        Wed, 08 Aug 2018 19:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BrnraowXgwPei0cTHdOcDicNFkPP7bEiFOsc0duLjfw=;
        b=C+IhOH8jCu5OKvycTPXHmPXLtvf2BWuhKR0Gfej8Kzbh/T6q0ko6k8n2O6gccTxDiZ
         0Ln227clb2JudgAnG1fEGnYMx7fdViL6zoO45wspYxhgyy3lNDmgxF0Sh/4Ydoy5WeZl
         z99+g38GNk1WIAzp8zDs4RsIqCfh2cTZ8D6IoKgRQUGFl+5mMdn3ToaHRtxbmekR03pP
         fTV1+aMaKLqwp+AWXE4v25hgspb9I4km+iM3RAsyFB9POuiQlynyRmC/qB2/QOqQsDsY
         zjFNCXFYnK20useLfuWp+sqzlhsNLqYhIIyS3BSW1XCIpKPsemKMxXbLv7y15hjR0r89
         X6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BrnraowXgwPei0cTHdOcDicNFkPP7bEiFOsc0duLjfw=;
        b=FN/ZmC4vP2y4q7BO4DjK7KF2f+NWujBbJfCfCQek4hp3z1PyWnNgTQsBVq/sjtK9mg
         uirjQ7fJ42u9t7u3Qok4aERg5xEq/IdJaMACuVyVvmoA6XEiYHtrmuDAoVc6b0KsgpNa
         dukGvSB82z4TQOaKTbZTCp2Pw/Ok/uf+p6MFJ+EMU/j6/KQgEEl0IHpobXnliZETTwR4
         k9LwlipKDFhw1mv/lZNU7yZcHQHgH1ZpyfPw46Ab9HfliTX1RKNc27jZrpwGu3Qq+YQt
         fm5KOPX3AG48B2bYdLu1zix0AO2Vtx7hW5w4Y/5wgLi4iZLS9E/JimxEfJ47cec7qW6l
         rsmQ==
X-Gm-Message-State: AOUpUlFl9LcIxbkJ0eykBOsxtLtnqnx6qPcyLkakOBs+eCSnMSOWYPT6
        qHEm94bh0QUCiTzmYoFVXzcGghR3iVrOUJ6zLww=
X-Google-Smtp-Source: AA+uWPyI5oEw3vGdwUoTdLDWmo3tJDGMnOUSUMglHzZcv/rSagzEUKtvdJvJR/FsPk5AIZ+0i4tOLdmRgxSLg4SnhSg=
X-Received: by 2002:adf:adc9:: with SMTP id w67-v6mr113021wrc.135.1533781856026;
 Wed, 08 Aug 2018 19:30:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9c8:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 19:30:54 -0700 (PDT)
In-Reply-To: <1533780598-23972-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1533780598-23972-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 9 Aug 2018 10:30:54 +0800
Message-ID: <CACVXFVNLu+fDK3UKhVpWYe_+bZN9LQqcib5q=TkqcvgMZ9EQNw@mail.gmail.com>
Subject: Re: [PATCH V3] blk-mq: count the hctx as active before allocate tag
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 10:09 AM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> Currently, we count the hctx as active after allocate driver tag
> successfully. If a previously inactive hctx try to get tag first
> time, it may fails and need to wait. However, due to the stale tag
> ->active_queues, the other shared-tags users are still able to
> occupy all driver tags while there is someone waiting for tag.
> Consequently, even if the previously inactive hctx is waked up, it
> still may not be able to get a tag and could be starved.
>
> To fix it, we count the hctx as active before try to allocate driver
> tag, then when it is waiting the tag, the other shared-tag users
> will reserve budget for it.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>
> V3:
>   add more detailed comment
>
> V2:
>   only invoke blk_mq_tag_busy w/o io scheduler in blk_mq_get_request
>
>  block/blk-mq-tag.c | 3 +++
>  block/blk-mq.c     | 8 ++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 09b2ee6..a8ebcbd 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -23,6 +23,9 @@ bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
>
>  /*
>   * If a previously inactive queue goes active, bump the active user count.
> + * We need to do this before try to allocate driver tag, then even if fail
> + * to get tag when first time, the other shared-tag users could reserve
> + * budget for it.
>   */
>  bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>  {
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ae44e85..75ac3fbd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -285,7 +285,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>                 rq->tag = -1;
>                 rq->internal_tag = tag;
>         } else {
> -               if (blk_mq_tag_busy(data->hctx)) {
> +               if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
>                         rq_flags = RQF_MQ_INFLIGHT;
>                         atomic_inc(&data->hctx->nr_active);
>                 }
> @@ -367,6 +367,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>                 if (!op_is_flush(op) && e->type->ops.mq.limit_depth &&
>                     !(data->flags & BLK_MQ_REQ_RESERVED))
>                         e->type->ops.mq.limit_depth(op, data);
> +       } else {
> +               blk_mq_tag_busy(data->hctx);
>         }
>
>         tag = blk_mq_get_tag(data);
> @@ -972,6 +974,7 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
>                 .hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu),
>                 .flags = wait ? 0 : BLK_MQ_REQ_NOWAIT,
>         };
> +       bool shared;
>
>         might_sleep_if(wait);
>
> @@ -981,9 +984,10 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
>         if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
>                 data.flags |= BLK_MQ_REQ_RESERVED;
>
> +       shared = blk_mq_tag_busy(data.hctx);
>         rq->tag = blk_mq_get_tag(&data);
>         if (rq->tag >= 0) {
> -               if (blk_mq_tag_busy(data.hctx)) {
> +               if (shared) {
>                         rq->rq_flags |= RQF_MQ_INFLIGHT;
>                         atomic_inc(&data.hctx->nr_active);
>                 }
> --
> 2.7.4
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming Lei
