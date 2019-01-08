Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22BBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEF52087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r6tYESJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfAHJoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:44:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57020 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfAHJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:44:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x089hpVx156378;
        Tue, 8 Jan 2019 09:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=uZ587fcjhZ8NOLszjusqcUyELM0LPFeexQDtVZY8iM4=;
 b=r6tYESJGFXDO3SWSV0llMW4RcZt2A9mPkU2Kl/MlxFuIwIgPJpJ3G9bJSOM+pMHh6me3
 /OdMAiMXcWMwmsoYszSIYTMAcYZtq9X/Ajwljj9MjvzeaMF9Yza6zsC1jZEpZntShVrQ
 V3/NO5zXHnmxQvkgdr5YGGJ6RDJ7P+gG+ji20awB01LG4WcDhAXyR092Uh79XTMivvvo
 Xw5B+aECY+4BnjrW3Ue3aelx2TJz+/u4XsSRHVgLHPdyzAwcFjicIdsz2ZibDo/ZGmAE
 YHojRyYuAyGD0KW7VBIoQ+ig9zNZY0+VKqoX/oDPuwskwbhkZbXpGL6enF5rSWWnKIlZ Ag== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2ptn7qtbjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Jan 2019 09:44:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x089iENN030800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jan 2019 09:44:14 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x089iDNJ002040;
        Tue, 8 Jan 2019 09:44:13 GMT
Received: from kadam (/197.157.0.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 01:44:11 -0800
Date:   Tue, 8 Jan 2019 12:42:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: fix memory leak of an allocated cifs_ntsd structure
Message-ID: <20190108094249.GF3200@kadam>
References: <20190107171515.4537-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107171515.4537-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9129 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=959
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901080080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 05:15:15PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to SMB2_queary_acl can allocate memory to pntsd and also
> return a failure via a call to SMB2_query_acl (and then query_info).
> This occurs when query_info allocates the structure and then in
> query_info the call to smb2_validate_and_copy_iov fails. Currently the
> failure just returns without kfree'ing pntsd hence causing a memory
> leak.  Fix this by kfree'ing pntsd before returning.
> 
> Detected by CoverityScan, CID#1457059 ("Resource Leak")
> 
> Fixes: 2f1afe25997f ("cifs: Use smb 2 - 3 and cifsacl mount options getacl functions")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/cifs/smb2ops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index cf7eb891804f..6d71958ad2cb 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -2238,8 +2238,10 @@ get_smb2_acl_by_fid(struct cifs_sb_info *cifs_sb,
>  	cifs_put_tlink(tlink);
>  
>  	cifs_dbg(FYI, "%s: rc = %d ACL len %d\n", __func__, rc, *pacllen);
> -	if (rc)
> +	if (rc) {
> +		kfree(pntsd);
>  		return ERR_PTR(rc);
> +	}

This is a layering violation.  The memory was allocated in query_info()
so it should be freed there instead.  Also if the kmalloc() fails in
query_info() then it should return -ENOMEM instead of success.

This only affects code which calls SMB2_query_acl().  There are two
callers.  You have fixed one but the other is also buggy because we're
returning uninitialized memory in get_smb2_acl_by_path().

regards,
dan carpenter

