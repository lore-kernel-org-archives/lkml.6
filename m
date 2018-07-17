Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A12ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B3720852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EJ/kEE4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B3720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbeGQKCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:02:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57602 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeGQKCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:02:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6H9SQBp051439;
        Tue, 17 Jul 2018 09:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=qyw7GgYzDnI6cjF9CHBup6wYpg/31ndRkHA/9Yv+bDU=;
 b=EJ/kEE4rqHKPyzrl5EqLWTxKAHsiN5KRL+EukeOMbR7yyHa+G1KU715uy9KiDcJZXILV
 T45PtSJxjEch16pLpPMebWkUKZqOJp8AJrz94Xx97z437KntcSLcmAkd0AqPt2oX9SIX
 68eLJYEQJ0ul0DOw29Nak/mGgcllBC6/sbJiK8QvZwBEqqTvPX+YD702TWCaLqVA2isq
 dkzIb8RpM1Zk1+UHd7sqMcpHJOXSm00/xdfZuWU1IXwkn3CLC2aD/KDRvmjv54k0RnXq
 JQzB/8XmvP8I/5CRmaPqcXCzgDNOw8bg+eEuSdK6DFJ6Sg/2fcVXI0qeG4KdvmEvIPmp CA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2k7a3sywrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 09:30:15 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6H9UEPI003369
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 09:30:14 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6H9UD3R017895;
        Tue, 17 Jul 2018 09:30:13 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 02:30:13 -0700
Date:   Tue, 17 Jul 2018 12:30:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix memory leak of async_copy
Message-ID: <20180717093005.3ggy24fskb3bxtni@mwanda>
References: <20180716120954.6720-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716120954.6720-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=887
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 01:09:54PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where async_copy is successfully allocated but
> the call to nfs4_init_cp_state fails, async_copy is not
> currently freed and the memory is leaked. Fix this by kfree'ing
> it before returning.
> 
> Detected by CoverityScan, CID#1471823 ("Resource leak")
> 
> Fixes: beb1814d5a8a ("NFSD create new stateid for async copy")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/nfsd/nfs4proc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 8f3368353aaf..3fb96a2708b9 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1295,8 +1295,10 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
>  		if (!async_copy)
>  			goto out;
> -		if (!nfs4_init_cp_state(nn, copy))
> +		if (!nfs4_init_cp_state(nn, copy)) {
> +			kfree(async_copy);
>  			goto out;

It really feels like both this and the kzalloc() failure should be doing
an of fput() of copy->file_src and copy->file_dst.  The goto out_err
does an list_del(&copy->copies); but it happens before the
"list_add(&async_copy->copies ..." so that's likely wrong as well.

regards,
dan carpenter

