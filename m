Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A341C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9393216F5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9393216F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbeHNEc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 00:32:58 -0400
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:60577 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725829AbeHNEc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 00:32:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4F025181D340F;
        Tue, 14 Aug 2018 01:48:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: balls99_296431b65a958
X-Filterd-Recvd-Size: 2368
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Aug 2018 01:48:04 +0000 (UTC)
Message-ID: <a7a81091a1856bcd2ec7dd6a17270dd999058475.camel@perches.com>
Subject: Re: [PATCH 6/9] platform: goldfish: pipe: Fail compilation if
 structs are too large
From:   Joe Perches <joe@perches.com>
To:     rkir@google.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com
Date:   Mon, 13 Aug 2018 18:48:02 -0700
In-Reply-To: <20180813233839.190855-6-rkir@google.com>
References: <20180813233839.190855-1-rkir@google.com>
         <20180813233839.190855-6-rkir@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-13 at 16:38 -0700, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> Since the driver provides no workaround prevent in cases if structs do
> no fit into a memory page, it is better to fail complation to find about
> the issue earlt instead of returning errors at runtime.

Minor earlt/early typo

> diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
[]
> @@ -797,9 +798,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
>  	 * needs to be contained in a single physical page. The easiest choice
>  	 * is to just allocate a page and place the buffers in it.
>  	 */
> -	if (WARN_ON(sizeof(*dev->buffers) > PAGE_SIZE))
> -		return -ENOMEM;
> -
> +	BUILD_BUG_ON(sizeof(*dev->buffers) > PAGE_SIZE);
>  	page = (char *)__get_free_page(GFP_KERNEL);
>  	if (!page) {
>  		kfree(dev->pipes);
> @@ -842,8 +841,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
>  	struct resource *r;
>  	struct goldfish_pipe_dev *dev = pipe_dev;
>  
> -	if (WARN_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE))
> -		return -ENOMEM;
> +	BUILD_BUG_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE);
>  
>  	/* not thread safe, but this should not happen */
>  	WARN_ON(dev->base != NULL);

Why separate these BUILD_BUG_ONs into 2 different functions?

Why not just
	BUILD_BUG_ON(sizeof(struct goldfish_pipe_command) > PAGE_SIZE);
	BUILD_BUG_ON(sizeof(struct goldfish_pipe_dev_buffers) > PAGE_SIZE);

