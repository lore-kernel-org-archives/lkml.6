Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689B6C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F812083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F812083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeJAPHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:07:35 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:56405 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728806AbeJAPHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:07:34 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 6tbSg4BF1w2L86tbVgX5pc; Mon, 01 Oct 2018 10:30:58 +0200
Subject: Re: [PATCH] media: cx18: Don't check for address of video_dev
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Andy Walls <awalls@md.metrocast.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20180921195736.7977-1-natechancellor@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <440b7ec3-b0b6-c96b-93de-4b6a3be44eac@xs4all.nl>
Date:   Mon, 1 Oct 2018 10:30:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180921195736.7977-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNGR1rXmRDRvy0e6hufnxnrkETMp9bWUiWNoSsPg2Nzaf0gb52eGInRt8JIXeCR8kgGepUmFQhXDvcHlp66JlJHrBf0aNGRq4facart5p2t0+FKBh9G0
 1oSiIoat4QcggmMWS44EiNET3VZqHnq4G1V8/C0WPaTENaJfmMIE5PdEW4/XXyhxsl801adhCMatvN2LgqO6NKkCXEFXaTkitTWVtcViOhe2mXTe+dcqOk93
 Rp8doccdwW9urY6xcjdh2Mc+QBZLn6hKkRtWwn/34hCs5PHXWzaDbl1OmJl7UGRtETDqNBPhquUHE4dKxmXu7jaVdTU4cAntlQ2zBzS7Qlu1NWZuXBBeBOmz
 TxI4Dnjz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/2018 09:57 PM, Nathan Chancellor wrote:
> Clang warns that the address of a pointer will always evaluated as true
> in a boolean context.
> 
> drivers/media/pci/cx18/cx18-driver.c:1255:23: warning: address of
> 'cx->streams[i].video_dev' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>                 if (&cx->streams[i].video_dev)
>                 ~~   ~~~~~~~~~~~~~~~^~~~~~~~~
> 1 warning generated.
> 
> Presumably, the contents of video_dev should have been checked, not the
> address. This check has been present since 2009, introduced by commit
> 21a278b85d3c ("V4L/DVB (11619): cx18: Simplify the work handler for
> outgoing mailbox commands")
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Alternatively, this if statement could just be removed since it has
> evaluated to true since 2009 and I assume some issue with this would
> have been discovered by now.
> 
>  drivers/media/pci/cx18/cx18-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
> index 56763c4ea1a7..753a37c7100a 100644
> --- a/drivers/media/pci/cx18/cx18-driver.c
> +++ b/drivers/media/pci/cx18/cx18-driver.c
> @@ -1252,7 +1252,7 @@ static void cx18_cancel_out_work_orders(struct cx18 *cx)
>  {
>  	int i;
>  	for (i = 0; i < CX18_MAX_STREAMS; i++)
> -		if (&cx->streams[i].video_dev)
> +		if (cx->streams[i].video_dev)

This should read:

		if (cx->streams[i].video_dev.v4l2_dev)

If cx->streams[i].video_dev.v4l2_dev == NULL, then the stream is not in use
and there is no need to cancel any work.

Can you post a v2?

>  			cancel_work_sync(&cx->streams[i].out_work_order);
>  }
>  
> 

Regards,

	Hans
