Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71C4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F0F216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ev12lJN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F0F216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeI0Umy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:42:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39892 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeI0Umy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:42:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8RENYDV143083;
        Thu, 27 Sep 2018 14:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=WLkSrQL9kXCIjWXvXwjG8Xv9eP9VVsuWbdNe+2emr3c=;
 b=ev12lJN1JZs6FXNANMvEis2TLABga9obKMRV/YW6W4wJrRxBSdvOAlJaSKNYEQGdEPT8
 2gCR9YQ364CqtfVm/8XetsgyaLQ6cT3QXbvKJ6zf+lzT9Bx4y0eHyqzmF3jm5EUVTXhx
 vww/YYFHsGwJvEVJcsgzWitbWW3iYgz5hSxmV83ASba/VN3WlJnula8CnWAb14IKLV+c
 vlME1E+63b0OdQsJJh1+j+oqvKv/M4uzXN6k9f9qFghzvtmDq8NGLBjDDiSjSLRakLKM
 Wr2HHqrNz53d0fPaG3IhTqRdyLI09YIxE5nlMPSR93OAD4uvb0j6jCIvb3MFbICpIIEX sg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mnvtv15ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 14:24:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8REODLb019825
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 14:24:13 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8REOBUn003061;
        Thu, 27 Sep 2018 14:24:12 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Sep 2018 07:24:11 -0700
Date:   Thu, 27 Sep 2018 17:24:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, John Whitmore <arigead@gmail.com>,
        Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] fix error handling in
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
Message-ID: <20180927142403.z27x6wvq54ealwwt@mwanda>
References: <13450.1537984337@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13450.1537984337@turing-police.cc.vt.edu>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9028 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=848
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809270138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:52:17PM -0400, valdis.kletnieks@vt.edu wrote:
> John notes that if the kzalloc of ieee->pHTInfo fails, we fail to call
> ieee80211_networks_free().  In addition, that function has an un-needed check
> before kfree().
> 
> Reported-by: John Whitmore <arigead@gmail.com>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> ---
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
> index 90a097f2cd4e..97ff0371b5bb 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
> @@ -78,8 +78,6 @@ static inline int ieee80211_networks_allocate(struct ieee80211_device *ieee)
>  
>  static inline void ieee80211_networks_free(struct ieee80211_device *ieee)
>  {
> -	if (!ieee->networks)
> -		return;
>  	kfree(ieee->networks);
>  	ieee->networks = NULL;
>  }
> @@ -180,6 +178,7 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
>  	return dev;
>  
>   failed:
> +	ieee80211_networks_free(ieee);
>  	if (dev)
>  		free_netdev(dev);

When there is a "goto failed;" then it's called "one err style" error
handling and we're just asking for bugs...  In this case the bug is that
we're not allowd to call ieee80211_networks_free() with a NULL
"ieee" parameter.  The right thing to do is to only call
ieee80211_networks_free() if we know that ieee80211_networks_allocate()
succeeded.

regards,
dan carpenter

