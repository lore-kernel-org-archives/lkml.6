Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D7DC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7576520652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7576520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeIHR5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 13:57:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbeIHR5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 13:57:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DFF7BAECE;
        Sat,  8 Sep 2018 13:11:31 +0000 (UTC)
Date:   Sat, 8 Sep 2018 15:11:30 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <schwidefsky@de.ibm.com>, <heiko.carstens@de.ibm.com>,
        <jwi@linux.ibm.com>, <ubraun@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] s390: qeth_core_mpc: Use ARRAY_SIZE instead of
 reimplementing its function
Message-ID: <20180908151130.3504d838@endymion>
In-Reply-To: <1536402388-23872-3-git-send-email-zhongjiang@huawei.com>
References: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
        <1536402388-23872-3-git-send-email-zhongjiang@huawei.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Sep 2018 18:26:28 +0800, zhong jiang wrote:
> ARRAY_SIZE has implemented its function. we prefer to use the function
> rather than the open code.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/s390/net/qeth_core_mpc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/s390/net/qeth_core_mpc.c b/drivers/s390/net/qeth_core_mpc.c
> index 5bcb8da..e8263de 100644
> --- a/drivers/s390/net/qeth_core_mpc.c
> +++ b/drivers/s390/net/qeth_core_mpc.c
> @@ -222,8 +222,7 @@ struct ipa_rc_msg {
>  char *qeth_get_ipa_msg(enum qeth_ipa_return_codes rc)
>  {
>  	int x = 0;
> -	qeth_ipa_rc_msg[sizeof(qeth_ipa_rc_msg) /
> -			sizeof(struct ipa_rc_msg) - 1].rc = rc;
> +	qeth_ipa_rc_msg[ARRAY_SIZE(qeth_ipa_rc_msg) - 1].rc = rc;
>  	while (qeth_ipa_rc_msg[x].rc != rc)
>  		x++;
>  	return qeth_ipa_rc_msg[x].msg;
> @@ -270,9 +269,7 @@ struct ipa_cmd_names {
>  char *qeth_get_ipa_cmd_name(enum qeth_ipa_cmds cmd)
>  {
>  	int x = 0;
> -	qeth_ipa_cmd_names[
> -		sizeof(qeth_ipa_cmd_names) /
> -			sizeof(struct ipa_cmd_names)-1].cmd = cmd;
> +	qeth_ipa_cmd_names[ARRAY_SIZE(qeth_ipa_cmd_names) - 1].cmd = cmd;
>  	while (qeth_ipa_cmd_names[x].cmd != cmd)
>  		x++;
>  	return qeth_ipa_cmd_names[x].name;

Reviewed-by: Jean Delvare <jdelvare@suse.de>

BTW, this code looks racy. It is modifying a global array member
without any locking. If there is any chance that two instances of
qeth_check_ipa_data() are running in parallel and both have unknown
command (or unknown rc), we could end up overrunning either
qeth_ipa_rc_msg[] or qeth_ipa_cmd_names[]. OK, that's unlikely to
happen in practice (I suppose unknown command and unknown rc are not
supposed to happen in the first place), but that's still bad programming
style. I'll try to come up with something better...

-- 
Jean Delvare
SUSE L3 Support
