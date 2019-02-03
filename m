Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B8FC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 11:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB3F217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 11:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FrMU2H0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfBCLb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 06:31:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35990 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfBCLb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 06:31:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x13BSx2P136783;
        Sun, 3 Feb 2019 11:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=cCW6rrXke5H5SbyTmzky8yXoIYBWRUZNY/kL8yV8K3k=;
 b=FrMU2H0TJfKAJ1p+jEIib4MFkEc12CDKdxFYZoqTTzxOi+EOz2TQOU58+46b9bcxBEer
 oJ/c3AWYLRHgYzr0QP4YizK7R8PYWEDzFRUOojA3Kl437GZAfFBLzn07WDvfK0LFYrqY
 i//4yOvXm2au1nvm698ufwHyckxMbFDLRAzGVFTok8mnY/sC4g8uwVp1YV1xMJPYWe86
 5B17YCdKwv5ugfdprFnODqbmXJIZHPpIO3QoKRAsZA47qLIIN4V+n+ir5BcPEoCeIBUw
 aoDpgsp9ITtTK/ilIyUnvvdXQFUp6s1/QWxTgR7NXrsjAY2uQ4LNzzaaDwxWWeIs+nZw Rw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qd98mst8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Feb 2019 11:31:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x13BVlKH011368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 3 Feb 2019 11:31:47 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x13BVlEt019025;
        Sun, 3 Feb 2019 11:31:47 GMT
Received: from kadam (/197.157.34.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 03 Feb 2019 11:31:46 +0000
Date:   Sun, 3 Feb 2019 14:31:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: fix a null pointer dereference on a
 null dev pointer
Message-ID: <20190203113137.GB2563@kadam>
References: <20190202225627.27116-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202225627.27116-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9155 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902030098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 10:56:27PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is an earlier null check on pointer dev which implies it may be null,
> however the assignment of pointer pref and the call to free_ieee82011 on
> a null dev can cause null pointer dereference errors.  Fix this by moving
> the assignment of priv and the the call to free_ieee80211 into the block of
> code that performs the null dev sanity check.
> 
> Detected by CoverityScan, CID#143078 ("Dereference after null check")
> 
> Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 0ac0bbf7d923..4741a29326ea 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -4955,9 +4955,10 @@ static void rtl8192_cancel_deferred_work(struct r8192_priv *priv)
>  static void rtl8192_usb_disconnect(struct usb_interface *intf)
>  {
>  	struct net_device *dev = usb_get_intfdata(intf);
> -	struct r8192_priv *priv = ieee80211_priv(dev);
>  
>  	if (dev) {
> +		struct r8192_priv *priv = ieee80211_priv(dev);

"dev" can't actually be NULL.  Look how we call usb_set_intfdata() in
probe().  It's better to remove the check instead.

regards,
dan carpenter

