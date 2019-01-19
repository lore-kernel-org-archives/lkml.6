Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5BBC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A912086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfASTGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:06:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbfASTGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:06:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D95DD9FDF9;
        Sat, 19 Jan 2019 19:06:32 +0000 (UTC)
Received: from [10.10.120.4] (ovpn-120-4.rdu2.redhat.com [10.10.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA432611A1;
        Sat, 19 Jan 2019 19:06:31 +0000 (UTC)
Subject: Re: [PATCH v2] target: fix a missing check of match_int
To:     Kangjie Lu <kjlu@umn.edu>
References: <5C38F72B.5000203@redhat.com>
 <20190112053159.99406-1-kjlu@umn.edu>
Cc:     pakki001@umn.edu, "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5C437537.8010304@redhat.com>
Date:   Sat, 19 Jan 2019 13:06:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190112053159.99406-1-kjlu@umn.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 19 Jan 2019 19:06:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2019 11:31 PM, Kangjie Lu wrote:
> When match_int fails, "arg" is left uninitialized and may contain random
> value, thus should not be used.
> The fix checks if match_int fails, and if so, returns its error code.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/target/target_core_rd.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/target/target_core_rd.c b/drivers/target/target_core_rd.c
> index a6e8106abd6f..3b7657b2f2f1 100644
> --- a/drivers/target/target_core_rd.c
> +++ b/drivers/target/target_core_rd.c
> @@ -559,6 +559,7 @@ static ssize_t rd_set_configfs_dev_params(struct se_device *dev,
>  	char *orig, *ptr, *opts;
>  	substring_t args[MAX_OPT_ARGS];
>  	int arg, token;
> +	int ret;
>  
>  	opts = kstrdup(page, GFP_KERNEL);
>  	if (!opts)
> @@ -573,14 +574,24 @@ static ssize_t rd_set_configfs_dev_params(struct se_device *dev,
>  		token = match_token(ptr, tokens, args);
>  		switch (token) {
>  		case Opt_rd_pages:
> -			match_int(args, &arg);
> +			ret = match_int(args, &arg);
> +			if (ret) {
> +				kfree(orig);
> +				return ret;

Just set ret to the return value and then break, so all the error and
success paths are going through the same code path.
