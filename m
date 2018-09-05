Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F2BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D47D20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D47D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeIEMhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:37:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50796 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbeIEMhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:37:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14669AE9E;
        Wed,  5 Sep 2018 08:08:52 +0000 (UTC)
Date:   Wed, 5 Sep 2018 10:08:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
cc:     Stefan Agner <stefan@agner.ch>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: core: fix NULL pointer dereference
In-Reply-To: <20180829152209.GA29831@embeddedor.com>
Message-ID: <nycvar.YFH.7.76.1809051008420.15880@cbobk.fhfr.pm>
References: <20180829152209.GA29831@embeddedor.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018, Gustavo A. R. Silva wrote:

> There is a NULL pointer dereference in case memory resources
> for *parse* are not successfully allocated.
> 
> Fix this by adding a new goto label and make the execution
> path jump to it in case vzalloc() fails.
> 
> Addresses-Coverity-ID: 1473081 ("Dereference after null check")
> Fixes: b2dd9f2e5a8a ("HID: core: fix memory leak on probe")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
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

Queued in for-4.19/fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

