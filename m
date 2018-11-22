Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17BDC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC30A206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qjZqmRKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC30A206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406343AbeKWEjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:39:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49106 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395487AbeKWEjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:39:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAMHsPuE139291;
        Thu, 22 Nov 2018 17:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=MYQJ3thfqfrQsVqKqPBv6usVwInkE53yWo7sK5wTLuc=;
 b=qjZqmRKlOtPe04CuAPnOsPeId3EBBQbx+WR76I0Kkxutrv/SVhPDnB7CCEbY5b4nPysX
 23CMbqs30LcZszuQrOSeo7ikaw+ZQxSAIksBQzM6U/8lL5fdkjcN/6Ptq6kBSupgL26M
 s8cNdeHlFp3wbsKM31gWjo6H/CX73buxBs2KBIohB5iY5RuuWpgIWB6d4iwkr0laPEGy
 T3OlkrUHydRh+cMC2jgpCzry5Rbj6C540J54gYn0BcF2Rqy91Qe11UEU+iT9d1q6etRn
 eJvArPnrHkQOwSnP6rbvW+2xvQQMjvmMK4fuQEEbTlLonPb6M5axcwIXbP7nd4YTRiGu eA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2ntadu82as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Nov 2018 17:58:04 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAMHw3wN013964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Nov 2018 17:58:03 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAMHw2pr000592;
        Thu, 22 Nov 2018 17:58:02 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Nov 2018 09:58:02 -0800
Date:   Thu, 22 Nov 2018 09:58:01 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     =?utf-8?B?ZGJ5aW4o5bC554OoKQ==?= <dbyin@tencent.com>
Cc:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/xfs: fix f_ffree value for statfs when project quota
 is set
Message-ID: <20181122175801.GV6792@magnolia>
References: <6EC51EE77FA0264BB8DAD779E0C341C9014BD77C91@EXMBX-SZMAIL003.tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6EC51EE77FA0264BB8DAD779E0C341C9014BD77C91@EXMBX-SZMAIL003.tencent.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9085 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811220160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 01:28:04PM +0000, dbyin(尹烨) wrote:
> When project is set, we should use inode limit minus the used count
> 
> Signed-off-by: Ye Yin <dbyin@tencent.com>

This makes sense to me, but ... it's been broken like this since 2006.
Is there a reason why (someone named Glen) wrote it this way?

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_qm_bhv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_qm_bhv.c b/fs/xfs/xfs_qm_bhv.c
> index 73a1d77ec187..3091e4bc04ef 100644
> --- a/fs/xfs/xfs_qm_bhv.c
> +++ b/fs/xfs/xfs_qm_bhv.c
> @@ -40,7 +40,7 @@ xfs_fill_statvfs_from_dquot(
>                 statp->f_files = limit;
>                 statp->f_ffree =
>                         (statp->f_files > dqp->q_res_icount) ?
> -                        (statp->f_ffree - dqp->q_res_icount) : 0;
> +                        (statp->f_files - dqp->q_res_icount) : 0;
>         }
>  }
>  
> -- 
> 2.16.2
