Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EA4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6997A2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5jSTP5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfBSS4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:56:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44615 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBSS4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:56:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id y1so10536884pgk.11;
        Tue, 19 Feb 2019 10:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xWdFlFRv4CzxDczg5CgOrkaqhJptQj2iz77qch1CTNA=;
        b=J5jSTP5V8Qp/mD44DZH/iqDa8KIA28fLtIjcvmY5vFkIwvOhgiB+wCoUTDsybaZ5rw
         HwbKx43Ov1cwsu6ZySr+Lq1RWrtBbK4xs2P/1mSInPZEFUvBsh59KJli/lOsewz5hwLE
         VGE2KLCir57nwtCgqTCmY264DpytD9pzl5skIq+3xbbzwvVsvOhkG2rW5V4gpu4MHHYU
         BbitI1PlZmzGIHsz5p9xifE6kLnmL53ziRwfkinzAxOz5Bqdvq4VddqmL1u+uy9Bqy0U
         f0kpNmzH+tGsHQNFcnmg6QYxXRV5iyMXlb6nDxf5swJS6abdz53NIF7JDpyt/moSZdEC
         jhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xWdFlFRv4CzxDczg5CgOrkaqhJptQj2iz77qch1CTNA=;
        b=r+DYgJORod3i2/lEfqA2Z8aRa/xBk13eZ5ubIF3IvQrdAYmlxlP1wSkfFiYdW2Ut/Q
         kqAffyx42BkQJJtc+WnlX1mf80g7Kl9SZUwTBI8ekw4BI2fGeLF5fVUt5BN0N3R5Eiow
         lmLtcSGfD2sSX/gOELR3oIplRcJ4HyU5o4mKeT9HtuShPS/de0EBVgdS3+nPxdEMQ/4i
         olrLLaY8gncB2Ec6nHTVPp1xoyy/yPO33q6HdKYz+NaWvHJbiMPcPz4ZtEbOphLraha2
         DlHuU0plhjbZ/mD/tKwmu0fxUYWOwnNRH+Po77Ue2cWY6X11I+HcNJ/A+H5tov+xc8QW
         GNIA==
X-Gm-Message-State: AHQUAuZ94YmIHb2Zv98RM4OcAr/OQ1vIXWt9Rwme1f0MSqxVaMNQrDXx
        nZfG0rY64fi1s6qeGiL1s5I=
X-Google-Smtp-Source: AHgI3IbaoyeDCvGVYSzGPwgAgYDzWv5ya7biryNFY1ZZGRN2WnbZgGtCDNm4/hmPzMcIFjoSrQOLqg==
X-Received: by 2002:a62:1d0c:: with SMTP id d12mr30915525pfd.126.1550602561138;
        Tue, 19 Feb 2019 10:56:01 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id q18sm5533208pgv.9.2019.02.19.10.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 10:56:00 -0800 (PST)
Date:   Tue, 19 Feb 2019 10:55:58 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Kay Sievers <kay@vrfy.org>,
        syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Subject: Re: [PATCH] input : avoid too late kobject_uevent(KOBJ_REMOVE) call
Message-ID: <20190219185558.GA210481@dtor-ws>
References: <1550484563-13217-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550484563-13217-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo,

On Mon, Feb 18, 2019 at 07:09:23PM +0900, Tetsuo Handa wrote:
> syzbot is hitting use-after-free bug in uinput module [1]. This is because
> kobject_uevent(KOBJ_REMOVE) is called again due to commit 0f4dafc0563c6c49
> ("Kobject: auto-cleanup on final unref") after memory allocation fault
> injection made kobject_uevent(KOBJ_REMOVE) from device_del() from
> input_unregister_device() fail, while uinput_destroy_device() is expecting
> that kobject_uevent(KOBJ_REMOVE) is not called after device_del() from
> input_unregister_device() completed.
> 
> Fix this problem by pretending as if kobject_uevent(KOBJ_REMOVE) from
> device_del() from input_unregister_device() did not fail.
> 
> [1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d
> 
> Reported-by: syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
> Analyzed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Kay Sievers <kay@vrfy.org>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/input/input.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 3304aaaffe87..6df3c33ef3aa 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2032,6 +2032,19 @@ static void __input_unregister_device(struct input_dev *dev)
>  	mutex_unlock(&input_mutex);
>  
>  	device_del(&dev->dev);
> +	/*
> +	 * Regarding input subsystem, we always take care of sending uevent at
> +	 * "unregister" time, and we do not expect to have uevent sent out at
> +	 * the final "put" time. Therefore, if we failed to send uevent at
> +	 * "unregister" time (due to e.g. fault injection), complain it and
> +	 * do not allow the final "put" time to send the remove uevent again.
> +	 */
> +	if (dev->dev.kobj.state_add_uevent_sent &&
> +	    !dev->dev.kobj.state_remove_uevent_sent) {
> +		dev->dev.kobj.state_remove_uevent_sent = 1;
> +		pr_warn("Failed to send remove uevent for %s\n",
> +			dev_name(&dev->dev));

Input has no business reaching into kobj internals. This should be
solved in lib/kobject_uevent.c, not anywhere else.

Thanks.

-- 
Dmitry
