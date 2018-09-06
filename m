Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B73C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07CB2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TDSXHUzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07CB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeIFTYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:24:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbeIFTYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:24:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w86Ehthh167936;
        Thu, 6 Sep 2018 14:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=9khlOczs2NlVbH6kN8BQIPtrIB+gLYbMAsBrgz7QaRw=;
 b=TDSXHUzileEGmOQF6amg35qlENSHZiIo/kR1fo0GrdsnJtLPmuc++nATc9DgW339JxF4
 auH7XcZ+n55krk6XmIAuvQf3jbIDgvqT25te/3wfU76MN1bUu7xQw23fv7ktA58TZOpK
 AWXc1uAMkL+mQbjz61fiqFKS7FuH+icqXlUxisQrVFeJrCJVP/O5Ut0PYgGEGHSUJ/D0
 ogQz0nfPID/89tzi979g6nkqPeL/Mw/66UPFyJ4BAQxd1TwvBPUWsDhURN9LNgke+gqJ
 24UK//SMFbYosYYNnKMHx3IWUFux12zDmmNnsubvQvNSR2tJaio/FPFIZ8s0nfxi9RQe 1A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2m7jqpvmej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 14:48:47 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w86Emkmq029126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 14:48:46 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w86Emksv010343;
        Thu, 6 Sep 2018 14:48:46 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Sep 2018 07:48:45 -0700
Date:   Thu, 6 Sep 2018 17:48:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] gpio: ep93xx: fix test for end of loop
Message-ID: <20180906144838.2dtqexjqieqjdpub@mwanda>
References: <20180906133348.brzvqt53nzukn7n2@kili.mountain>
 <21c6b967-f4b5-db68-89b4-a9caa4e76fda@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c6b967-f4b5-db68-89b4-a9caa4e76fda@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 02:50:44PM +0100, Colin Ian King wrote:
> On 06/09/18 14:33, Dan Carpenter wrote:
> > The problem is that if port == ARRAY_SIZE() and "gc == &epg->gc[port]"
> > then that should be treated as invalid.
> > 
> > Fixes: fd935fc421e7 ("gpio: ep93xx: Do not pingpong irq numbers")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
> > index 68a416fc3141..b0699f57ddf5 100644
> > --- a/drivers/gpio/gpio-ep93xx.c
> > +++ b/drivers/gpio/gpio-ep93xx.c
> > @@ -80,7 +80,7 @@ static int ep93xx_gpio_port(struct gpio_chip *gc)
> >  		port++;
> >  
> >  	/* This should not happen but is there as a last safeguard */
> > -	if (gc != &epg->gc[port]) {
> > +	if (port == ARRAY_SIZE(epg->gc)) {
> >  		pr_crit("can't find the GPIO port\n");
> >  		return 0;
> >  	}
> > 
> 
> Good catch! I overlooked that one.

It's unfortunate but I don't think any of our static checkers would have
caught it.  You found this bug because of cppcheck, right?  I know it
warns about the bounds test after use.  Does it also warn about the out
of bounds?

Smatch doesn't warn about the out of bounds read because Smatch has bad
handling of loops.  Smatch is supposed to warn about the test after use
but that code is buggy.  I will investigate what's going on.

I have an unpublished test so Smatch does warn that the port < sizeof()
means that port is in terms of bytes but we're using it as an array
offset.  That's how I noticed this code, but it only warns about the
first use, so it warns about the loop but not the post-loop test.

I should fix Smatch's handling of loops so that we know this function
originally could return 0-8 and you maybe get a warning in the caller.
Unfortunately, I'm not sure I would have paid very much attention to a
warning like that because they tend to be prone to false positives.  We
have a lot of loops that do:

	for (i = 0; i < ARRAY_SIZE(array); i++) {
		if (foo <= array[i])
			break;
	}

And the last element of the array[] is UINT_MAX so we always break.
It's a lot of work but not necessarily difficult work.

regards,
dan carpenter
