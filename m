Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD68ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A660214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 04:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="we1KrFKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A660214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeIQJ3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:29:36 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:47598 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeIQJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:29:36 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 22DC65C04F0;
        Mon, 17 Sep 2018 06:04:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537157044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ANw/I6VSw8lDKxONPj4oWozI8seOSmI+y9YixdWFC0=;
        b=we1KrFKKA/UN5H6w67gxUd9/9K94CeiPb5cMCi2GglDWqNIA2v3ix6QxX5+Vfy1yPXp3yr
        fDWE9RlUwZN59aavoD227ymbhrCxwwGkZoXU9M4joShSgsttcQfy1/10r3FZdgJqdqSoCL
        pczcJBlFLUKSzYWh0pjmWTsBKjqHFc8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 16 Sep 2018 21:04:04 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.18 082/197] block: dont warn for flush on read-only
 device
In-Reply-To: <20180913131844.815669025@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
 <20180913131844.815669025@linuxfoundation.org>
Message-ID: <c3c10b04f1576ecfa7aace3a23d92dbd@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

The follow up patch 8b2ded1c94c0 ("block: don't warn when doing fsync on read-only devices") should get applied too, since it correctly fixes what this patch tried to fix.

--
Stefan

On 13.09.2018 06:30, Greg Kroah-Hartman wrote:
> 4.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jens Axboe <axboe@kernel.dk>
> 
> [ Upstream commit b089cfd95d32638335c551651a8e00fd2c4edb0b ]
> 
> Don't warn for a flush issued to a read-only device. It's not strictly
> a writable command, as it doesn't change any on-media data by itself.
> 
> Reported-by: Stefan Agner <stefan@agner.ch>
> Fixes: 721c7fc701c7 ("block: fail op_is_write() requests to read-only partitions")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  block/blk-core.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2159,7 +2159,9 @@ static inline bool should_fail_request(s
>  
>  static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
>  {
> -	if (part->policy && op_is_write(bio_op(bio))) {
> +	const int op = bio_op(bio);
> +
> +	if (part->policy && (op_is_write(op) && !op_is_flush(op))) {
>  		char b[BDEVNAME_SIZE];
>  
>  		WARN_ONCE(1,
