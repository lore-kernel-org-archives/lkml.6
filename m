Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE0C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCD72086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="feNHiWxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCD72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeJHN0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:26:09 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34353 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJHN0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:26:09 -0400
Received: by mail-yb1-f193.google.com with SMTP id 184-v6so7865997ybg.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wNVhQqVbQgEBQtlDgi+QNKVQFKPTvC+rqcKN23OWqUY=;
        b=feNHiWxt84X6fT1yae0YcyrDsOR5Lj04RkHZfsl3ve1z8bDlVgVvPTVWdQ4IzmmeLA
         bcAIYrQElNy4ZfIuVs630zo1WesbyMchmloTimmaW1kkWSa1fbsoqRyO7KyLeMcNTYWC
         iIm/DE2ghu7GQRaGp18QG8Nw/y0ViZSxb9uD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wNVhQqVbQgEBQtlDgi+QNKVQFKPTvC+rqcKN23OWqUY=;
        b=uib2gLuKlXT39EXDphl+MRWLhbVZa9fx1qWIAdOVr1Yj3IzpbQVtcGExuuY/CIMSO4
         KUKTMpQnP/JG+0c0niQacHilaK47z4qq2cQGFxhjDj4V0QZfajfOe/AALpIeN30ZPH6x
         tzV6u3yZdDoyQiIf07fL5/nvZ/QOsJ6ivCGhZExiAlrsrvlxkFR1gsRI7SyHfFLH01io
         UCqRLOUs0jeGUwUPLX1GNVgBIHJ81iB8RzYZJ7iItsCy6QbA1+7W3vVDEkwiZIZuJqBV
         ZFvFo4tF8K1RnzRBX9pnMnkSggtgnT020+k1yNvWl6L0goXmHMjhSd+JRv1EFfzEoiuu
         Cn5Q==
X-Gm-Message-State: ABuFfohgiGKDQNXGZKbMevO/bx5bkTuwtK2UBKH5mjnVpFQPIqzioGSf
        RtkHWqBn1EpW4riPdgmtt0g8Q5R5/iQ=
X-Google-Smtp-Source: ACcGV62EC/BOgP4AkTEgvWBIXzDM4ywbNIO2g66pOCI+z/pcn0T2HQTy1O914Z1qEeYVqhFivA3wdw==
X-Received: by 2002:a25:1342:: with SMTP id 63-v6mr12170841ybt.495.1538979364544;
        Sun, 07 Oct 2018 23:16:04 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id m1-v6sm7591754ywf.96.2018.10.07.23.16.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 23:16:03 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id y14-v6so7621455ywa.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 23:16:03 -0700 (PDT)
X-Received: by 2002:a81:2908:: with SMTP id p8-v6mr12598104ywp.407.1538979362558;
 Sun, 07 Oct 2018 23:16:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Sun, 7 Oct 2018 23:16:01 -0700 (PDT)
In-Reply-To: <CAGXu5jJ-Hbj143Sv7ikxmLnBPyvcd1cGoT5fSbwG21LomnsORw@mail.gmail.com>
References: <20180906000926.GA18830@beast> <CAGXu5jJ-Hbj143Sv7ikxmLnBPyvcd1cGoT5fSbwG21LomnsORw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 7 Oct 2018 23:16:01 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKV3eLJJsemxNEjZuANRd8-TnRkMSmiztVyY5mgC2ySHw@mail.gmail.com>
Message-ID: <CAGXu5jKV3eLJJsemxNEjZuANRd8-TnRkMSmiztVyY5mgC2ySHw@mail.gmail.com>
Subject: Re: [PATCH] sunvdc: Remove VLA usage
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 8:19 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Sep 5, 2018 at 5:09 PM, Kees Cook <keescook@chromium.org> wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> moves the math for cookie calculation into macros and allocates a fixed
>> size array for the maximum number of cookies and adds a runtime sanity check.
>> (Note that the size was always fixed, but just hidden from the compiler.)
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Friendly ping. Jens, can you take this?

Dave, should this go via you instead? I'll take it via my tree if no
one else wants it...

Thanks,

-Kees

>
> Thanks!
>
> -Kees
>
>> ---
>>  drivers/block/sunvdc.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
>> index 5ca56bfae63c..f68e9baffad7 100644
>> --- a/drivers/block/sunvdc.c
>> +++ b/drivers/block/sunvdc.c
>> @@ -36,6 +36,10 @@ MODULE_VERSION(DRV_MODULE_VERSION);
>>  #define VDC_TX_RING_SIZE       512
>>  #define VDC_DEFAULT_BLK_SIZE   512
>>
>> +#define MAX_XFER_BLKS          (128 * 1024)
>> +#define MAX_XFER_SIZE          (MAX_XFER_BLKS / VDC_DEFAULT_BLK_SIZE)
>> +#define MAX_RING_COOKIES       ((MAX_XFER_BLKS / PAGE_SIZE) + 2)
>> +
>>  #define WAITING_FOR_LINK_UP    0x01
>>  #define WAITING_FOR_TX_SPACE   0x02
>>  #define WAITING_FOR_GEN_CMD    0x04
>> @@ -450,7 +454,7 @@ static int __send_request(struct request *req)
>>  {
>>         struct vdc_port *port = req->rq_disk->private_data;
>>         struct vio_dring_state *dr = &port->vio.drings[VIO_DRIVER_TX_RING];
>> -       struct scatterlist sg[port->ring_cookies];
>> +       struct scatterlist sg[MAX_RING_COOKIES];
>>         struct vdc_req_entry *rqe;
>>         struct vio_disk_desc *desc;
>>         unsigned int map_perm;
>> @@ -458,6 +462,9 @@ static int __send_request(struct request *req)
>>         u64 len;
>>         u8 op;
>>
>> +       if (WARN_ON(port->ring_cookies > MAX_RING_COOKIES))
>> +               return -EINVAL;
>> +
>>         map_perm = LDC_MAP_SHADOW | LDC_MAP_DIRECT | LDC_MAP_IO;
>>
>>         if (rq_data_dir(req) == READ) {
>> @@ -984,9 +991,8 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>>                 goto err_out_free_port;
>>
>>         port->vdisk_block_size = VDC_DEFAULT_BLK_SIZE;
>> -       port->max_xfer_size = ((128 * 1024) / port->vdisk_block_size);
>> -       port->ring_cookies = ((port->max_xfer_size *
>> -                              port->vdisk_block_size) / PAGE_SIZE) + 2;
>> +       port->max_xfer_size = MAX_XFER_SIZE;
>> +       port->ring_cookies = MAX_RING_COOKIES;
>>
>>         err = vio_ldc_alloc(&port->vio, &vdc_ldc_cfg, port);
>>         if (err)
>> --
>> 2.17.1
>>
>>
>> --
>> Kees Cook
>> Pixel Security
>
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
