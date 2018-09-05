Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F72C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC874204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="qrOr/Q0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC874204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeIEKA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:00:29 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:56546 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeIEKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:00:29 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 8BCB85C07CF;
        Wed,  5 Sep 2018 07:32:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536125520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPBdn7SskhJdkC5bpp9RkFnTg+yDGFGeFL5tNhAq3UE=;
        b=qrOr/Q0k+AOz0JIa5LF1KLrHAxF/Lt34UUhL4MEhYW30pPSc4hW4l43z5Tycp6uiz9REy4
        Fh4/OoPbUNZDVPtpAN27RJleCeYsr4/cr6VsQKX++SDmSDrML4e9RoV0zJwCgcCPdvA+r/
        AHXbBOodErRaDX4mnW2HS5AnOozD7V0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 Sep 2018 22:32:00 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: core: fix NULL pointer dereference
In-Reply-To: <20180829152209.GA29831@embeddedor.com>
References: <20180829152209.GA29831@embeddedor.com>
Message-ID: <1b6f1722c86df1cdef59c14bfd485f0b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.2018 08:22, Gustavo A. R. Silva wrote:
> There is a NULL pointer dereference in case memory resources
> for *parse* are not successfully allocated.
> 
> Fix this by adding a new goto label and make the execution
> path jump to it in case vzalloc() fails.
> 
> Addresses-Coverity-ID: 1473081 ("Dereference after null check")
> Fixes: b2dd9f2e5a8a ("HID: core: fix memory leak on probe")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
>  drivers/hid/hid-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 4548dae..5bec924 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1000,7 +1000,7 @@ int hid_open_report(struct hid_device *device)
>  	parser = vzalloc(sizeof(struct hid_parser));
>  	if (!parser) {
>  		ret = -ENOMEM;
> -		goto err;
> +		goto alloc_err;
>  	}
>  
>  	parser->device = device;
> @@ -1049,6 +1049,7 @@ int hid_open_report(struct hid_device *device)
>  	hid_err(device, "item fetching failed at offset %d\n", (int)(end - start));
>  err:
>  	kfree(parser->collection_stack);
> +alloc_err:
>  	vfree(parser);
>  	hid_close_report(device);
>  	return ret;
