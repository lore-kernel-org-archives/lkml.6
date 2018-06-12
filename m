Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9BBCFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5128A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IfI56sYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5128A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934294AbeFLVV3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:21:29 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46510 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932682AbeFLVV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:21:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DB0AE8EE1E9;
        Tue, 12 Jun 2018 14:21:26 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nw37WqPdzCg8; Tue, 12 Jun 2018 14:21:26 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6F4BA8EE0C8;
        Tue, 12 Jun 2018 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1528838486;
        bh=P46dzem9QUsqP5pxcvFdZcrRe70rv5guQ6CUuLeEb24=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IfI56sYjlyYrwaGVOa+uiNBoMueuGVBhfM4xa/qqtKxTj79JLk+GbIoZ3XWEucYcF
         ijbpu1qi/gqn7I3gLI71f+sIq8FmwU4Wfd1B9q993dMJ3RXoIp9Jl1hMEsFAZOLCRi
         xUbpEzudtxtqI4hgUagiIIEbt6LJuHZsG0/WEJBE=
Message-ID: <1528838485.24454.2.camel@HansenPartnership.com>
Subject: Re: [PATCH] target: add error handling for match_int
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Jun 2018 14:21:25 -0700
In-Reply-To: <1528779148-42485-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528779148-42485-1-git-send-email-jiazhouyang09@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 12:52 +0800, Zhouyang Jia wrote:
> When match_int fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling match_int.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/target/target_core_rd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_rd.c
> b/drivers/target/target_core_rd.c
> index a6e8106..7bc89ff 100644
> --- a/drivers/target/target_core_rd.c
> +++ b/drivers/target/target_core_rd.c
> @@ -573,14 +573,16 @@ static ssize_t
> rd_set_configfs_dev_params(struct se_device *dev,
>  		token = match_token(ptr, tokens, args);
>  		switch (token) {
>  		case Opt_rd_pages:
> -			match_int(args, &arg);
> +			if (match_int(args, &arg))
> +				return -EINVAL;

The first observation is that this would leak the kmalloc'd orig
variable, but the second is that I don't think terminating parsing is
the right thing to do even if match_int() returns an error: just
ignoring this option and proceed to the next seems to be the best
course because that's what we do with unrecognised options (the
default: case).

James


