Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83337C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D642133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbfAKUGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:06:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730271AbfAKUGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:06:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E46490C7A;
        Fri, 11 Jan 2019 20:06:05 +0000 (UTC)
Received: from [10.10.125.65] (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AF0326368;
        Fri, 11 Jan 2019 20:06:03 +0000 (UTC)
Subject: Re: [PATCH] target: fix a missing check for match_int
To:     Kangjie Lu <kjlu@umn.edu>
References: <20181226064818.75984-1-kjlu@umn.edu>
Cc:     pakki001@umn.edu, "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5C38F72B.5000203@redhat.com>
Date:   Fri, 11 Jan 2019 14:06:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20181226064818.75984-1-kjlu@umn.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 11 Jan 2019 20:06:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/2018 12:48 AM, Kangjie Lu wrote:
> When match_int fails, "arg" is left uninitialized and may contain random
> value, thus should not be used.
> The fix checks if match_int fails, and if so, break.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/target/target_core_rd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/target/target_core_rd.c b/drivers/target/target_core_rd.c
> index a6e8106abd6f..3138123143e8 100644
> --- a/drivers/target/target_core_rd.c
> +++ b/drivers/target/target_core_rd.c
> @@ -573,7 +573,8 @@ static ssize_t rd_set_configfs_dev_params(struct se_device *dev,
>  		token = match_token(ptr, tokens, args);
>  		switch (token) {
>  		case Opt_rd_pages:
> -			match_int(args, &arg);
> +			if (match_int(args, &arg))
> +				break;

I think if this fails you would want to return an error.

Also, I think you want to add a similar check for the Opt_rd_nullio call
below this chunk because arg may initialized to junk.


>  			rd_dev->rd_page_count = arg;
>  			pr_debug("RAMDISK: Referencing Page"
>  				" Count: %u\n", rd_dev->rd_page_count);
> 

