Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E0ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1902084E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QKTh1ZMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1902084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeGPOV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:21:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56444 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeGPOV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:21:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GDmvag171832;
        Mon, 16 Jul 2018 13:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=t5/ssnBYIU8tMrWhPhcHagIpnZ/5LhkoetL7rRHqv1g=;
 b=QKTh1ZMI+fdfNvRQFaFjw7EC4xGcop9+rFb1gjPIIhFQUzWHrJSHtp4tok3ylmpzWu/z
 e8GrhmK9ihBUl2UnlK1ycyRdyFaCjlyp/83gD41PLrwVbHQEyyz2qp/6pUmtNN1WKacd
 SsyxEr0k1antf/HewYXK1WUKEMs3kMfDJI0IgyA2N91eocw6DXupNCYU/v0Y/ZpHLZZA
 5LPQ4+1FeAE7xsTvAlkerB6XKyXcsl2ZF0a8Je2gGi2dzVu5IkCAHSIChIAcwpZWRwQX
 0dfUh9DtbOSSfxMIbFz618TKcJYUKSkzQJQs/60S4f0564UDkIemvUZsttj+w7BcC5WR rg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2k7a3jmh83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 13:53:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6GDrk8H030746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 13:53:46 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6GDrjaJ010306;
        Mon, 16 Jul 2018 13:53:45 GMT
Received: from mwanda (/105.166.134.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 06:53:45 -0700
Date:   Mon, 16 Jul 2018 16:53:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 04/18] staging: gasket: device registration error and
 unregister fixups
Message-ID: <20180716135335.hnvj5kqvsrrwzp3b@mwanda>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
 <20180714055816.223754-5-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714055816.223754-5-toddpoynor@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8955 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=793
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 10:58:02PM -0700, Todd Poynor wrote:
> @@ -376,7 +377,10 @@ int gasket_register_device(const struct gasket_driver_desc *driver_desc)
>  fail1:
>  	class_destroy(internal->class);
>  
> +fail0:

GW-BASIC sytle label names are an anti-pattern.  It's better to name the
labels after what they do, just like function names describes what the
function does.  Here it would be "goto clear_desc;" or something.  It
doesn't have to be perfect but so long as you *try* to name it something
useful that's better than not trying.

> +	mutex_lock(&g_mutex);
>  	g_descs[desc_idx].driver_desc = NULL;
> +	mutex_unlock(&g_mutex);
>  	return ret;
>  }

regards,
dan carpenter
