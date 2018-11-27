Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9228C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A341721104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FzwOE9yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A341721104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbeK0TND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:13:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:32908 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeK0TNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:13:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAR89GPf021763;
        Tue, 27 Nov 2018 08:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vy+msMYosZZEARBAZymkjfR25uoUV8W0PcvTPZ7I2sM=;
 b=FzwOE9yxClf0e9XD60z33d6N0rEfDNUgy0K9xecNOIVMQL7z5Wnk+nIaqxOfIGMl70h9
 H/iJmoqMZWy13aeKgJ1ZhnIin4a9luYuLlUcxxqsn5gqVRc91wqV8mKIUOMoetZiGmtc
 ho0tGJ54Y13NXvY2pEod3zbM0D1qj17A1Nyr7L7F0nAF3B085vb8mAsj04+M2HYvWTwO
 epBdpRI5m4ETGxKvm/3XysFNeMr4XpyT+lnyF6frWEIO3CVb0fGHpcZzULLwI/l0Po/V
 SXh1jb7BAdFCfrVENcCVUDwxtEVziHyIYJgk4mhFYVkda+cDTnYAJW4+7Q+dGA0eagcO FQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nxy9r298k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 08:15:52 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAR8FpDI030434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 08:15:51 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAR8FpV9002502;
        Tue, 27 Nov 2018 08:15:51 GMT
Received: from unbuntlaptop (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 00:15:50 -0800
Date:   Tue, 27 Nov 2018 11:15:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yang Xiao <YangX92@hotmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "r.weclawski@gmail.com" <r.weclawski@gmail.com>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "santhameena13@gmail.com" <santhameena13@gmail.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "jananis37@gmail.com" <jananis37@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: rtl8188eu: Fix off-by-one in core/rtw_mlme_ext.c
Message-ID: <20181127081542.GN3088@unbuntlaptop>
References: <HK0PR01MB216364A68D785B7EBC8DD43EADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR01MB216364A68D785B7EBC8DD43EADD00@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=882
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code is OK.

On Tue, Nov 27, 2018 at 07:29:07AM +0000, Yang Xiao wrote:
> From: Young_X <YangX92@hotmail.com>
> 
>     The error at line 3267 was the result of an off-by-one error in
>     a for loop in line 3253.
>     If condition in line 3254 never satisfies, then the value of
>     pstat->aid is NUM_STA+1. This will lead to out-of-bound access
>     in line 3267.

It's best to avoid line numbers in the commit message unless you paste
the actual code, because sometimes people will be using different line
numbers from you.

> Signed-off-by: Young_X <YangX92@hotmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> index 6790b840..0854adc 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> @@ -3250,7 +3250,7 @@ static unsigned int OnAssocReq(struct adapter *padapter,
>  	if (pstat->aid > 0) {
>  		DBG_88E("  old AID %d\n", pstat->aid);
>  	} else {
> -		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
> +		for (pstat->aid = 1; pstat->aid < NUM_STA; pstat->aid++)

drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
  3249          /* get a unique AID */
  3250          if (pstat->aid > 0) {
  3251                  DBG_88E("  old AID %d\n", pstat->aid);
  3252          } else {
  3253                  for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
  3254                          if (pstapriv->sta_aid[pstat->aid - 1] == NULL)
  3255                                  break;
  3256  
  3257                  /* if (pstat->aid > NUM_STA) { */
                           ^^^^^^^^^^^^^^^^^^^^^^^^
This comment is key.  pstapriv->max_num_sta is always less than or equal
to NUM_STA.

  3258                  if (pstat->aid > pstapriv->max_num_sta) {
  3259                          pstat->aid = 0;
  3260  
  3261                          DBG_88E("  no room for more AIDs\n");
  3262  
  3263                          status = WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA;
  3264  
  3265                          goto OnAssocReqFail;
  3266                  } else {
  3267                          pstapriv->sta_aid[pstat->aid - 1] = pstat;
                                                  ^^^^^^^^^^^^^^
So this is fine.

  3268                          DBG_88E("allocate new AID=(%d)\n", pstat->aid);
  3269                  }
  3270          }
  3271  

regards,
dan carpenter
