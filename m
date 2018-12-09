Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61902C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0425020855
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0425020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeLIRKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 12:10:12 -0500
Received: from [195.159.176.226] ([195.159.176.226]:49387 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeLIRKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 12:10:11 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1gW2Yh-00066f-3W
        for linux-kernel@vger.kernel.org; Sun, 09 Dec 2018 18:07:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] x86/platform/olpc: remove duplicated check on node == -1
Date:   Sun, 9 Dec 2018 18:10:02 +0100
Message-ID: <puji58$mag$1@blaine.gmane.org>
References: <20181209150142.9010-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
In-Reply-To: <20181209150142.9010-1-colin.king@canonical.com>
Content-Language: en-US
Cc:     kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/12/2018 à 16:01, Colin King a écrit :
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the node == -1 check is being performed twice, the
> second check is redundant and can be removed.  Fix this by
> removing the redundant second check and moving the first check
> into a combined check with the result from the olpc_ofw call.
>
> Detected by cppcheck:
> Identical condition '(s32)node==-1', second condition is always false
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   arch/x86/platform/olpc/olpc_dt.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/x86/platform/olpc/olpc_dt.c b/arch/x86/platform/olpc/olpc_dt.c
> index b4ab779f1d47..658363ec3ff3 100644
> --- a/arch/x86/platform/olpc/olpc_dt.c
> +++ b/arch/x86/platform/olpc/olpc_dt.c
> @@ -28,10 +28,7 @@ static phandle __init olpc_dt_getsibling(phandle node)
>   	const void *args[] = { (void *)node };
>   	void *res[] = { &node };
>   
> -	if ((s32)node == -1)
> -		return 0;
> -
> -	if (olpc_ofw("peer", args, res) || (s32)node == -1)
> +	if (((s32)node == -1) || olpc_ofw("peer", args, res))
>   		return 0;
>   
>   	return node;

'res' is { &node }

Could 'node' be modified by 'olpc_ofw(..., res)' and set to -1?

In other words, I'm not sure that the 2nd check is a redundant here.

Just my 2c,

CJ


