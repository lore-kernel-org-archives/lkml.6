Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448D2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FCA20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S3uZCgHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfAHMyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:54:33 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36164 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfAHMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:54:33 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x08CnRMU106980;
        Tue, 8 Jan 2019 12:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=UxsG6YQtanntTpoobrn5UKm9QY/ZYn5pisnTRhY7lBg=;
 b=S3uZCgHE4sK2LT/Wb0yaZZxDH2/S8V6LEgXlqN3ZORDLipuU4VM91j57HgHa05KqRRYs
 RJWD4+way9UjLNiTj0PqzfnaMwvBBfOAb8IvWr4wuQX277lhVymn45T37NrjkISpekyv
 2zkoUYZpqswcM7H0kHYAA861bxxu47/QLfzmTIE1BeWKV0oNlSl9bnLNxApI2qYYvO69
 rNoCqGTnyhhe2a8SI/WMRaXTaEi4uzv7iUuh66cCwDOMJjT1E7LhaBcVoGVZM6WI8/15
 cmuanpyPQvfm/Y2LDNIWbhruSCK6ipEcNyrhMBYTswf22DN63HBnqyFNM055afpuXHdz 6g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ptn7qu63e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jan 2019 12:54:29 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x08CsStC030211
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jan 2019 12:54:28 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x08CsR3q024190;
        Tue, 8 Jan 2019 12:54:28 GMT
Received: from [172.16.42.110] (/123.118.59.63)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 04:54:27 -0800
Subject: Re: [PATCH] net: nvidia: forcedeth: Fix two possible concurrency
 use-after-free bugs
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, davem@davemloft.net,
        keescook@chromium.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190108124518.21986-1-baijiaju1990@gmail.com>
From:   Zhu Yanjun <yanjun.zhu@oracle.com>
Message-ID: <27392ae0-2c0f-f099-05d8-f9cdbfbd313e@oracle.com>
Date:   Tue, 8 Jan 2019 20:54:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108124518.21986-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9129 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=679
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901080106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/1/8 20:45, Jia-Ju Bai Ð´µÀ:
> In drivers/net/ethernet/nvidia/forcedeth.c, the functions
> nv_start_xmit() and nv_start_xmit_optimized() can be concurrently
> executed with nv_poll_controller().
>
> nv_start_xmit
>    line 2321: prev_tx_ctx->skb = skb;
>
> nv_start_xmit_optimized
>    line 2479: prev_tx_ctx->skb = skb;
>
> nv_poll_controller
>    nv_do_nic_poll
>      line 4134: spin_lock(&np->lock);
>      nv_drain_rxtx
>        nv_drain_tx
>          nv_release_txskb
>            line 2004: dev_kfree_skb_any(tx_skb->skb);
>
> Thus, two possible concurrency use-after-free bugs may occur.
>
> To fix these possible bugs,


Does this really occur? Can you reproduce this ?


>   the calls to spin_lock_irqsave() in
> nv_start_xmit() and nv_start_xmit_optimized() are moved to the
> front of "prev_tx_ctx->skb = skb;"
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>   drivers/net/ethernet/nvidia/forcedeth.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
> index 1d9b0d44ddb6..48fa5a0bd2cb 100644
> --- a/drivers/net/ethernet/nvidia/forcedeth.c
> +++ b/drivers/net/ethernet/nvidia/forcedeth.c
> @@ -2317,6 +2317,8 @@ static netdev_tx_t nv_start_xmit(struct sk_buff *skb, struct net_device *dev)
>   	/* set last fragment flag  */
>   	prev_tx->flaglen |= cpu_to_le32(tx_flags_extra);
>   
> +	spin_lock_irqsave(&np->lock, flags);
> +
>   	/* save skb in this slot's context area */
>   	prev_tx_ctx->skb = skb;
>   
> @@ -2326,8 +2328,6 @@ static netdev_tx_t nv_start_xmit(struct sk_buff *skb, struct net_device *dev)
>   		tx_flags_extra = skb->ip_summed == CHECKSUM_PARTIAL ?
>   			 NV_TX2_CHECKSUM_L3 | NV_TX2_CHECKSUM_L4 : 0;
>   
> -	spin_lock_irqsave(&np->lock, flags);
> -
>   	/* set tx flags */
>   	start_tx->flaglen |= cpu_to_le32(tx_flags | tx_flags_extra);
>   
> @@ -2475,6 +2475,8 @@ static netdev_tx_t nv_start_xmit_optimized(struct sk_buff *skb,
>   	/* set last fragment flag  */
>   	prev_tx->flaglen |= cpu_to_le32(NV_TX2_LASTPACKET);
>   
> +	spin_lock_irqsave(&np->lock, flags);
> +
>   	/* save skb in this slot's context area */
>   	prev_tx_ctx->skb = skb;
>   
> @@ -2491,8 +2493,6 @@ static netdev_tx_t nv_start_xmit_optimized(struct sk_buff *skb,
>   	else
>   		start_tx->txvlan = 0;
>   
> -	spin_lock_irqsave(&np->lock, flags);
> -
>   	if (np->tx_limit) {
>   		/* Limit the number of outstanding tx. Setup all fragments, but
>   		 * do not set the VALID bit on the first descriptor. Save a pointer
