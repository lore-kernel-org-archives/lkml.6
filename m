Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0A797C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4505208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4505208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935140AbeFMQKd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:10:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933498AbeFMQKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:10:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8B794023334;
        Wed, 13 Jun 2018 16:10:30 +0000 (UTC)
Received: from [10.10.122.249] (ovpn-122-249.rdu2.redhat.com [10.10.122.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5635C20284D6;
        Wed, 13 Jun 2018 16:10:30 +0000 (UTC)
Subject: Re: [RESEND PATCH] target: fix potential memory leak in option
 parsing
To:     Chengguang Xu <cgxu519@gmx.com>, nab@linux-iscsi.org
References: <1528867646-138322-1-git-send-email-cgxu519@gmx.com>
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5B2141F5.5080102@redhat.com>
Date:   Wed, 13 Jun 2018 11:10:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1528867646-138322-1-git-send-email-cgxu519@gmx.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 13 Jun 2018 16:10:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Wed, 13 Jun 2018 16:10:30 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mchristi@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 12:27 AM, Chengguang Xu wrote:
> When specifying same string type option several times,
> current option parsing will cause memory leak. Hence,
> call kfree for previous one in this case.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>  drivers/target/target_core_configfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
> index 5ccef7d..5512432 100644
> --- a/drivers/target/target_core_configfs.c
> +++ b/drivers/target/target_core_configfs.c
> @@ -1661,6 +1661,7 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
>  		token = match_token(ptr, tokens, args);
>  		switch (token) {
>  		case Opt_initiator_fabric:
> +			kfree(i_fabric);

You can probably just change this one and t_fabric so we do not even do
a match_strdup since they are not used. Just let them hit the default in
the switch so if apps are still passing them in then we maintain the
same behavior from their perspective.
