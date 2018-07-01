Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4622DC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E5D25818
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 19:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rty/ndzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E5D25818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeGATVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 15:21:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41082 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeGATV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 15:21:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w61JIu8C035629;
        Sun, 1 Jul 2018 19:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=kYFdrM3I/qUjI6ETb1/c1kGjhf/b8yOcMSICIsFUzpI=;
 b=rty/ndziA03YFVZLs/+K/x298lm9BapmqIz05FmpBF08o1gaymO4xfquwR1Hd4gmv7Xy
 Bk6Q22HoKmNodNofX6UyrzQMhtU+wlDmf8EkPmi0cjUMDQRQWbCu6dSNROERlZSfQi7p
 ZW91awNOeUurAPKWYnvonjwDce0YhlPxdbdJkETt+UfbMIVwFcds/6R498l7QM/0K9kI
 h477ZYMcXoSjlw0xuFG7jL8TpF24VLDm3UGvRofKGuxokMxiMvtfHKYALq4/TTH7urFj
 5NbGfoKenW0Jx96DG4fKNLVQklDFVb8muDilW5V1gaQbvMBHmWxxwC+yChW+EZUNISO+ Eg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jx19sj9r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 Jul 2018 19:21:23 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w61JLM3f023749
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 1 Jul 2018 19:21:22 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w61JLLHp021391;
        Sun, 1 Jul 2018 19:21:21 GMT
Received: from [10.159.233.190] (/10.159.233.190)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Jul 2018 12:21:20 -0700
Subject: Re: [PATCH][next] netdevsim: fix sa_idx out of bounds check
To:     Colin King <colin.king@canonical.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180630203924.5121-1-colin.king@canonical.com>
From:   Shannon Nelson <shannon.nelson@oracle.com>
Organization: Oracle Corporation
Message-ID: <8bfbcc6a-eed8-c5fd-17a9-35fcf5f94b57@oracle.com>
Date:   Sun, 1 Jul 2018 12:21:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180630203924.5121-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8941 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807010231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/2018 1:39 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if sa_idx is equal to NSIM_IPSEC_MAX_SA_COUNT then
> an out-of-bounds read on ipsec->sa will occur. Fix the
> incorrect bounds check by using >= rather than >.
> 
> Detected by CoverityScan, CID#1470226 ("Out-of-bounds-read")
> 
> Fixes: 7699353da875 ("netdevsim: add ipsec offload testing")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/net/netdevsim/ipsec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
> index ceff544510b9..2dcf6cc269d0 100644
> --- a/drivers/net/netdevsim/ipsec.c
> +++ b/drivers/net/netdevsim/ipsec.c
> @@ -249,7 +249,7 @@ bool nsim_ipsec_tx(struct netdevsim *ns, struct sk_buff *skb)
>   	}
>   
>   	sa_idx = xs->xso.offload_handle & ~NSIM_IPSEC_VALID;
> -	if (unlikely(sa_idx > NSIM_IPSEC_MAX_SA_COUNT)) {
> +	if (unlikely(sa_idx >= NSIM_IPSEC_MAX_SA_COUNT)) {
>   		netdev_err(ns->netdev, "bad sa_idx=%d max=%d\n",
>   			   sa_idx, NSIM_IPSEC_MAX_SA_COUNT);
>   		return false;
> 

Good catch - thanks!

Acked-by: Shannon Nelson <shannon.nelson@oracle.com>
