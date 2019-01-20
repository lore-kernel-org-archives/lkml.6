Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51BDC61CE8
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C2320883
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 01:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3O+SKi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfATBbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 20:31:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46254 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbfATBbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 20:31:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so17705324otm.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 17:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xhu316w8O2VsLVcckitjc4RYqk1mh63kjawbFkPcwcc=;
        b=A3O+SKi15tUfDYbDaJjjqKz1F31A1ivKVxhN7VDilX+PsCa6SY9Lj76REEokaJkte2
         1RZFmTRl16agmfYBvKoINVe/NpA2S7DQbLLrbiFM/qwjbbWEj0UVkJ/smgpQXpmdG99C
         eNuhJL/D6bqOMSVchbwHp3KRYkrRaHmniv/roEDh0sD9Eq+1TXqjcHSS8Plv/7eiUfN+
         LiwcbA77+bxGwrbBumUn1SFa2NGqgVr930L17ca2yiHYkaNEmlcPvneTjfx9jK+s1BUj
         KROWJ/a+0ALUZMVcgvZ+olBAORVrQ34iBqi4amKGjOe3L63hy8pOwQDWwz8SQcJ4LSTh
         Ehtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=xhu316w8O2VsLVcckitjc4RYqk1mh63kjawbFkPcwcc=;
        b=UnRN7juWv1NcRottiXgN0wEsRrQhm8i04D3CmfG1ec5p1ZSh3zEqEbmEe5XHb990h5
         I2BTvl8GekK4sVSn6D6DV92ioj7RylN/nVTg1Yt7gRj2KmYPS4fjB0LOHyokWBxo9oKs
         r6Ckj0m8Lz4OBSv0/4GlmDutmnEEH/Qjfp20A0Iw2UekHFbx467SBUbc+v1lIrHVsXUX
         qS2RkRulvrb3yGDBOBkEGZOvWMCZlgIHH7VTGfHxphZbqul1gIH9bVonjblCH4dWfQaU
         pileDRBrXZWejB6D8CiWfA7Fzc0f54abTowfP8EWZwc+a8qQpiDSvoCa1H+Us7nbFkbR
         OIFQ==
X-Gm-Message-State: AJcUukcOk9FduCh44SWVI0jZwIsw8tYOIACfOxIqjZsGg/34s6alJUPC
        U8CMLrIU48zzDZM8fVUV34pv1tY=
X-Google-Smtp-Source: ALg8bN5jObRkSYP33dvCGgOu2eHSupC2OsGG9FZfUCcRk3Ob5LB0GgECmVFgRShDaektwcdJLvzQhA==
X-Received: by 2002:a9d:491e:: with SMTP id e30mr16354699otf.131.1547947861863;
        Sat, 19 Jan 2019 17:31:01 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.64])
        by smtp.gmail.com with ESMTPSA id 30sm3856933ots.52.2019.01.19.17.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 17:31:01 -0800 (PST)
Received: from [IPv6:2001:470:b8f6:1b:6d14:52f9:ea85:e9f] (unknown [IPv6:2001:470:b8f6:1b:6d14:52f9:ea85:e9f])
        by serve.minyard.net (Postfix) with ESMTPSA id 511AC864;
        Sat, 19 Jan 2019 19:31:00 -0600 (CST)
Reply-To: minyard@acm.org
Subject: Re: [PATCH v2] ipmi: Prevent use-after-free in deliver_response
To:     Fred Klassen <fklassen@appneta.com>,
        "Arnd Bergmann (supporter:CHAR and MISC DRIVERS)" <arnd@arndb.de>,
        "Greg Kroah-Hartman (supporter:CHAR and MISC DRIVERS)" 
        <gregkh@linuxfoundation.org>,
        "moderated list:IPMI SUBSYSTEM" 
        <openipmi-developer@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
References: <A305B9C6-87C8-406A-9A9A-623BE0768FFB@appneta.com>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <3f6be669-0a5f-5b82-aa68-14c97c7df52a@acm.org>
Date:   Sat, 19 Jan 2019 19:30:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <A305B9C6-87C8-406A-9A9A-623BE0768FFB@appneta.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/19 4:28 PM, Fred Klassen wrote:
> Some IPMI modules (e.g. ibmpex_msg_handler()) will have ipmi_usr_hdlr
> handlers that call ipmi_free_recv_msg() directly. This will essentially
> kfree(msg), leading to use-after-free.
>
> This does not happen in the ipmi_devintf module, which will queue the
> message and run ipmi_free_recv_msg() later.

Yeah, this is better style, if nothing else.

I assume you want this for 5.0., right?

-corey

> BUG: KASAN: use-after-free in deliver_response+0x12f/0x1b0
> Read of size 8 at addr ffff888a7bf20018 by task ksoftirqd/3/27
> CPU: 3 PID: 27 Comm: ksoftirqd/3 Tainted: G           O      4.19.11-amd64-ani99-debug #12.0.1.601133+pv
> Hardware name: AppNeta r1000/X11SPW-TF, BIOS 2.1a-AP 09/17/2018
> Call Trace:
> dump_stack+0x92/0xeb
> print_address_description+0x73/0x290
> kasan_report+0x258/0x380
> deliver_response+0x12f/0x1b0
> ? ipmi_free_recv_msg+0x50/0x50
> deliver_local_response+0xe/0x50
> handle_one_recv_msg+0x37a/0x21d0
> handle_new_recv_msgs+0x1ce/0x440
> ...
>
> Allocated by task 9885:
> kasan_kmalloc+0xa0/0xd0
> kmem_cache_alloc_trace+0x116/0x290
> ipmi_alloc_recv_msg+0x28/0x70
> i_ipmi_request+0xb4a/0x1640
> ipmi_request_settime+0x1b8/0x1e0
> ...
>
> Freed by task 27:
> __kasan_slab_free+0x12e/0x180
> kfree+0xe9/0x280
> deliver_response+0x122/0x1b0
> deliver_local_response+0xe/0x50
> handle_one_recv_msg+0x37a/0x21d0
> handle_new_recv_msgs+0x1ce/0x440
> tasklet_action_common.isra.19+0xc4/0x250
> __do_softirq+0x11f/0x51f
>
> Fixes: e86ee2d44b44 ("ipmi: Rework locking and shutdown for hot remove")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fred Klassen <fklassen@appneta.com>
> ---
> drivers/char/ipmi/ipmi_msghandler.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 7fc9612070a1..fbf93c2d6c05 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -883,7 +883,7 @@ static int deliver_response(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
>
> 		if (user) {
> 			user->handler->ipmi_recv_hndl(msg, user->handler_data);
> -			release_ipmi_user(msg->user, index);
> +			release_ipmi_user(user, index);
> 		} else {
> 			/* User went away, give up. */
> 			ipmi_free_recv_msg(msg);


