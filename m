Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CCBC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD1421700
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diFYTH07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD1421700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeHHLoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:44:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36604 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeHHLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:44:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so1392629wro.3;
        Wed, 08 Aug 2018 02:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zxse+zc9z65NaeMAMz7lunMRHw8n7CK/Braa7puNL9c=;
        b=diFYTH07YNcZH3ywPMzHKWqWsXPKekJJUI9lQhgSm83FgKU6FY2CHzcLsVEmfoanU2
         HFtNovljHPth2gQ8FvSL20edYoSnCYq3lBlJNkFcwa0VU9gUPhSlW7TShMSTQ5QOMkxX
         ZXY+oTGoH+l+TsSt+yJJGDeoa61LNc9vsuC+p6T84T9Xz/6yiVfvkHw0xuv3Ka2VFxwE
         jXt4DB0u0knbH2OS39j2luuMo5Y0ZWAEWrJRIMZMk1uQIV9ego7LEldPheLz4rb4GSpH
         +vrjGbMyuIpmvyXOfQ+5nScll0OOBJTiKjVv/fJYpJbHHYWEVrQ4dSk9NKKdM7eZEcGp
         eRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zxse+zc9z65NaeMAMz7lunMRHw8n7CK/Braa7puNL9c=;
        b=XaRsVVSSHvMCSbdFsXCrjc6/QsIA/TPnKwMjJEWKPFMqa/RdayPKzhO57FW+9SAgbR
         NKBb628weBQDz5fK35es7vwJA1vFtYYpJlE42aqlMHp1m4+N9zAu9f1ap4okOdcBC1qZ
         MnXW0zBoikcEdkL92/l9JFM/eBo5ByM5YBmixzhxlbBQqCFU6bubEYzms8qlAZKkUlLr
         iRFq6bJpsr9dpAE5Hb4Nr888+imqv6u9uez/a0DWzoSVkCT7KCn7nWRN2EejX8issTOg
         bkYys8KaCko+6A7/wcAPWZkND/1y1v+ztAnqA+9y2tCDozxRr8Rr+tH+PwpQ8YRKhpMJ
         MaGw==
X-Gm-Message-State: AOUpUlHJKeW+ncsK76V8HocXmIMJLgm/gxyYA6OzwhRb8YNdkLvhR9AB
        d/LIvc56pKEdSYShQZrMwU0CqhDxSPLqmqzCU4E=
X-Google-Smtp-Source: AA+uWPwIiuNdYRQLBFkQ824EQTOe25ZuXDMIxTw76RKz2/cLd98Mxt82+yplHE5iRvua1+zZyNcUnwBL8EjROh29Us4=
X-Received: by 2002:a5d:5201:: with SMTP id j1-v6mr1328014wrv.198.1533720332055;
 Wed, 08 Aug 2018 02:25:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9c8:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 02:25:31 -0700 (PDT)
In-Reply-To: <1533709499-1661-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1533709499-1661-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 8 Aug 2018 17:25:31 +0800
Message-ID: <CACVXFVMCgHRKwMvELQwx71ju2pNoVBDXS=nRHAS8uu_d7e4A1Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: use blk_mq_run_hw_queues in scsi_kick_queue
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 2:24 PM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> We don't use blk-mq start/stop hw queue any more, so no reason to
> use blk_mq_start_hw_queues which does clear_bit, replace it with
> blk_mq_run_hw_queues.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/scsi/scsi_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 41e9ac9..7de0f26 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -371,7 +371,7 @@ void scsi_device_unbusy(struct scsi_device *sdev)
>  static void scsi_kick_queue(struct request_queue *q)
>  {
>         if (q->mq_ops)
> -               blk_mq_start_hw_queues(q);
> +               blk_mq_run_hw_queues(q, false);
>         else
>                 blk_run_queue(q);
>  }

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming Lei
