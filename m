Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6516FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D82521871
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n0Y/Wd4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfABK2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:28:47 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48922 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfABK2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:28:46 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x02AJ3cd162598;
        Wed, 2 Jan 2019 10:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=fxXZeFmf/hUwfiqSPA4f8xhJ3/kqz5vs9+XKAQOe/z4=;
 b=n0Y/Wd4Fl33fMyic2LaD7ni5/1EpXhMfy5FiuXHKERQgfId/NRX6MFZxOeL+nlUiVGbT
 k3OVeg/chXwMSI175kSxkTa2sQBrLMM17CTZh4m0GYaCfC71Gyh6kNy3sNOH0ykXTDbA
 e95NBpWl0nglBUbPtpAIymWLcuB45sRgVYtuQ4gwoajtlC7aduAFSyf1weA1UW6tQ50o
 BqoFBa4FglVHbGqm+d8+Qza9gO4WCIFrQ4Oo6dzuWeAAkxFBR5N0mXVhoRNvdf7uWfUh
 ysbT23GE2Es/B9lRBXV9y8k5nHjHDdq3OqofQoQkM363qLu6yjl05AGg3Va/H0Biw17z qg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2pnxee1kbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Jan 2019 10:28:35 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x02ASYeo028972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jan 2019 10:28:34 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x02ASWMs011298;
        Wed, 2 Jan 2019 10:28:33 GMT
Received: from kadam (/197.157.0.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Jan 2019 02:28:32 -0800
Date:   Wed, 2 Jan 2019 13:28:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     devel@driverdev.osuosl.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, pakki001@umn.edu,
        Colin Ian King <colin.king@canonical.com>,
        Aymen Qader <qader.aymen@gmail.com>
Subject: Re: [PATCH] rts5208: fix a missing check of the status of
 sd_init_power
Message-ID: <20190102102814.GF3781@kadam>
References: <20181225083334.68473-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181225083334.68473-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9123 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901020094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 02:33:32AM -0600, Kangjie Lu wrote:
> sd_init_power() could fail. The fix inserts a check of its status. If it
> fails, returns STATUS_FAIL.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/staging/rts5208/sd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
> index ff1a9aa152ce..8c3fd885a4f3 100644
> --- a/drivers/staging/rts5208/sd.c
> +++ b/drivers/staging/rts5208/sd.c
> @@ -2352,7 +2352,9 @@ static int reset_sd(struct rtsx_chip *chip)
>  				break;
>  			}
>  
> -			sd_init_power(chip);
> +			retval = sd_init_power(chip);
> +			if (retval != STATUS_SUCCESS)
> +				goto status_fail;

Are you able to test this?

I don't think you appreciate the risk of applying this patch.  We are
taking code which succeeds and making it fail.  That's a risky thing.
The benefit is just that it makes a static analysis tool happy?

It would be different if the benefit were that it improves security or
prevents a crash.  Or if you could test it.

This is the reset_sd() function.  It always feels a bit hacky to me to
even have a reset function.  It basically means you know you have messed
up but you don't know where or how so let's just try scrub everything
and go back to the start.  Maybe the driver is trying to work around a
firmware bug.  I often find bugs in reset functions which show they have
not been tested...  It's so tricky for me to do a cost benefit analysis
here, but I sort of think we should leave the code as-is.

It's frustrating because the static analysis tool is probably right, but
maybe the code only works because two bugs cancel each other out?  We
can't know without testing.

In a more ideal world we would do the static analysis on patches before
they are applied and refuse to apply them until the maintainer explains
why the function is not checked.

regards,
dan carpenter

