Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C2D20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WUo2nbQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C2D20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbeFTJ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:57:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56742 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFTJ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:57:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K9stCr099903;
        Wed, 20 Jun 2018 09:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=07a2GGD2mAAxXmuF1ClzdLxj0piNzUZJMamCOEYXqSo=;
 b=WUo2nbQlcciYw+88geANqBTD4VR99issxbdtEz5IQQO9uozAL9oHEiEoph92Wg3jHC0R
 DZap30uVHdsbwR0/0pFNldXfg1VLE9JtBzD+nImg/pPMcNqRlh9VA/Lbr6vVJIHOi/6t
 u3amKjXvIZylKriw4hY3yZMZD4rvSy7rebouejD146scJBU3gawEfzc2I+yhX3l4yCc8
 h1nxU5jHJ7VPWfbpgy1u28CW4hAafJdY1YagsqWme5D6obvdoF5yauNMPRFxwthvKET7
 4+4p1b9rpHubwLoV23OhhkzpYEXMtlq+USJCgkWtuMJfcmNXn+k7Ii70M1PT727QgWze yA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jmt01ksrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 09:57:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5K9v9fA022202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 09:57:09 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5K9v4jm029116;
        Wed, 20 Jun 2018 09:57:06 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 02:57:03 -0700
Date:   Wed, 20 Jun 2018 12:56:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, cocci@systeme.lip6.fr,
        Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     gregkh@linuxfoundation.org, quytelda@tamalin.org,
        Larry.Finger@lwfinger.net, harshasharmaiitr@gmail.com,
        arushisinghal19971997@gmail.com, amitoj1606@gmail.com,
        jeremy.lefaure@lse.epita.fr, teo.dacquet@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Fix two possible
 sleep-in-atomic-context bugs in translate_scan()
Message-ID: <20180620095650.fga6xi7fyjgybs76@mwanda>
References: <20180620095016.8484-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620095016.8484-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=812
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 05:50:16PM +0800, Jia-Ju Bai wrote:
> The driver may sleep with holding a spinlock.
> The function call paths (from bottom to top) in Linux-4.16.7 are:
> 
> [FUNC] kzalloc(GFP_KERNEL)
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 323: 
> 		kzalloc in translate_scan
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1554: 
> 		translate_scan in rtw_wx_get_scan
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1533: 
> 		spin_lock_bh in rtw_wx_get_scan
> 
> [FUNC] kzalloc(GFP_KERNEL)
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 455: 
> 		kzalloc in translate_scan
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1554: 
> 		translate_scan in rtw_wx_get_scan
> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c, 1533: 
> 		spin_lock_bh in rtw_wx_get_scan
> 
> To fix these bugs, GFP_KERNEL is replaced with GFP_ATOMIC.
> 
> These bugs are found by my static analysis tool (DSAC-2) and checked by
> my code review.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index b26533983864..7632b8974563 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -321,7 +321,7 @@ static char *translate_scan(struct adapter *padapter,
>  		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.Ssid.Ssid));
>  		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
>  
> -		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_KERNEL);
> +		buf = kzalloc(MAX_WPA_IE_LEN*2, GFP_ATOMIC);
>  		if (!buf)
>  			return start;

Thanks!  It occurs to me that another way to detect this bug is that
one of the allocations in this function already uses GFP_ATOMIC.  It
doesn't normally make sense to mix GFP_ATOMIC and GFP_KERNEL when there
isn't any locking in the function.

regards,
dan carpenter

