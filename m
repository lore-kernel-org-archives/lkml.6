Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859F3C67838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5475820865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 17:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5475820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeLIRNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 12:13:20 -0500
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:39333 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726100AbeLIRNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 12:13:20 -0500
Received: from [192.168.1.12] ([90.126.241.217])
        by mwinf5d71 with ME
        id 9tDD1z0094i89ZE03tDD44; Sun, 09 Dec 2018 18:13:16 +0100
X-ME-Helo: [192.168.1.12]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Dec 2018 18:13:16 +0100
X-ME-IP: 90.126.241.217
Subject: Re: [PATCH] x86/platform/olpc: remove duplicated check on node == -1
To:     Colin King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181209150142.9010-1-colin.king@canonical.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <5ec13475-37d8-01b7-e575-cd9e9f496cc3@wanadoo.fr>
Date:   Sun, 9 Dec 2018 18:13:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181209150142.9010-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

