Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C2BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD02C214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pZB34al7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD02C214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeJQORb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:17:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbeJQORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:17:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9H6K9UG185971;
        Wed, 17 Oct 2018 06:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6NBj2FvtP0VbXCOsgRrzb+EdswCfR1Z3Uof+XO8bYoQ=;
 b=pZB34al7ioyQoDrAmXtWNtAQVSq8PXhBK3tfo55UvKuAtDM/Td6DTHZnsnAuz/mMYnwW
 rmNubIbOUpTUj3rYcsdnEafYARZhbK59wH6fORAwL55jOmmk2+oXbkuVP84kUKSsF3US
 UUnatWHCAGIaqm30xZwFNLdXoInTCZ3DXPsYRFRUWqTiPKmk3+FFemoHiO0Po/G6Wkpb
 2t0jopUtTZYjXlL0fnEsKX2zlvjuO36urgsjrw4m33N09lHAoTOrFtNvvOdhoRCd5oq9
 j8ALGRM+ZnthvMmpLykPKD4gC/8QcTcEgOlExx7ZqznK95IVb3jxTqgmzfk82AcZE7P4 Sw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n38nq4u65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 06:23:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9H6N8Wd026788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 06:23:09 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9H6N6Wg014223;
        Wed, 17 Oct 2018 06:23:06 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 23:23:06 -0700
Date:   Wed, 17 Oct 2018 09:22:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kys@microsoft.com, olaf@aepfle.de, sthemmin@microsoft.com,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        Stable@vger.kernel.org, Michael.H.Kelley@microsoft.com,
        apw@canonical.com, devel@linuxdriverproject.org,
        vkuznets@redhat.com, Haiyang Zhang <haiyangz@microsoft.com>
Subject: Re: [PATCH 3/5] Drivers: hv: kvp: Fix the recent regression caused
 by incorrect clean-up
Message-ID: <20181017062255.oiu44y4zuuwilan3@mwanda>
References: <20181017031241.669-1-kys@linuxonhyperv.com>
 <20181017031406.773-1-kys@linuxonhyperv.com>
 <20181017031406.773-3-kys@linuxonhyperv.com>
 <20181017050705.GE22447@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017050705.GE22447@kroah.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810170057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 07:07:05AM +0200, Greg KH wrote:
> On Wed, Oct 17, 2018 at 03:14:04AM +0000, kys@linuxonhyperv.com wrote:
> > From: Dexuan Cui <decui@microsoft.com>
> > 
> > In kvp_send_key(), we do need call process_ib_ipinfo() if
> > message->kvp_hdr.operation is KVP_OP_GET_IP_INFO, because it turns out
> > the userland hv_kvp_daemon needs the info of operation, adapter_id and
> > addr_family. With the incorrect fc62c3b1977d, the host can't get the
> > VM's IP via KVP.
> > 
> > And, fc62c3b1977d added a "break;", but actually forgot to initialize
> > the key_size/value in the case of KVP_OP_SET, so the default key_size of
> > 0 is passed to the kvp daemon, and the pool files
> > /var/lib/hyperv/.kvp_pool_* can't be updated.
> > 
> > This patch effectively rolls back the previous fc62c3b1977d, and
> > correctly fixes the "this statement may fall through" warnings.
> > 
> > This patch is tested on WS 2012 R2 and 2016.
> > 
> > Fixes: fc62c3b1977d ("Drivers: hv: kvp: Fix two "this statement may fall through" warnings")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Cc: <Stable@vger.kernel.org>
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> >  drivers/hv/hv_kvp.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> > index a7513a8a8e37..9fbb15c62c6c 100644
> > --- a/drivers/hv/hv_kvp.c
> > +++ b/drivers/hv/hv_kvp.c
> > @@ -353,6 +353,9 @@ static void process_ib_ipinfo(void *in_msg, void *out_msg, int op)
> >  
> >  		out->body.kvp_ip_val.dhcp_enabled = in->kvp_ip_val.dhcp_enabled;
> >  
> > +		__attribute__ ((fallthrough));
> 
> The comment should be sufficient for this, right?  I haven't seen many
> uses of this attribute before, how common is it?
>

It's not common at all.  It should be wrapped in a macro and put into
compiler.h.

But I hope it does become adopted.  It's better than randomly grepping
for non-standard comments.

regards,
dan carpenter

