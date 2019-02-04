Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261BBC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD76C20821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aYBnIj/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfBDHsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:48:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39912 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBDHsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:48:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x147me5F099549;
        Mon, 4 Feb 2019 07:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=P0BzeH2BgaSVXfIG0eEIpLiQD1gDn1Dzl1hU54CcepY=;
 b=aYBnIj/dUt/qw9jmt7QDP30Rvbf4/nIfJDcMh18BpMYsrDTKq9xSqIBClk229zaJGMRU
 CkgR3w56MuIKB9PPz2lOnTOC3Dgag1pSx8JQLZQIVj3Bwq5HAOy5b1oHrIR6x5EFnvE/
 jUggyg7QBu4Ahj+aYPWc0xRzlGMcgXCp+UErn75z33KOTH61cieM16+ALbtU3JZSYzIx
 0WWUKJ95d1asKYGQHiUxIr+da4VaYGbTjFntqC/kIfwDcLJuQGN+1TlcTwISnTylh1IN
 BYCCowEsicC5Qi4BojtHVS+MSeZzU28YMcZtETPBAk4V5TF//hhJlTYIM6AxJZCLK/sN Qg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qd9ar3k4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Feb 2019 07:48:40 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x147mcRZ005398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Feb 2019 07:48:38 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x147maIc007927;
        Mon, 4 Feb 2019 07:48:36 GMT
Received: from kadam (/197.157.0.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Feb 2019 07:48:35 +0000
Date:   Mon, 4 Feb 2019 10:48:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: dt2811: fix integer overflow in multiply
Message-ID: <20190204074820.GC2581@kadam>
References: <20190202215916.25753-1-colin.king@canonical.com>
 <20190203112904.GA2563@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190203112904.GA2563@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9156 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=884 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902040065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 03, 2019 at 02:29:04PM +0300, Dan Carpenter wrote:
> > diff --git a/drivers/staging/comedi/drivers/dt2811.c b/drivers/staging/comedi/drivers/dt2811.c
> > index 05207a519755..820e75f850ff 100644
> > --- a/drivers/staging/comedi/drivers/dt2811.c
> > +++ b/drivers/staging/comedi/drivers/dt2811.c
> > @@ -323,7 +323,8 @@ static unsigned int dt2811_ns_to_timer(unsigned int *nanosec,
> >  		for (_mult = 0; _mult <= 7; _mult++) {
> >  			unsigned int div = dt2811_clk_dividers[_div];
> >  			unsigned int mult = dt2811_clk_multipliers[_mult];
> > -			unsigned long long divider = div * mult;
> > +			unsigned long long divider =
> > +				(unsigned long long)div * mult;
> 
> The max "div" can be is 12.  The max "mult" can be is 10,000,000.  So
> this is a false positive because there is no overflow.  The code is not
> complicated.  Unfortunately, Smatch has the exact same problem...

Smatch actually parses this correctly, but I had a power failure over
the weekend that messed up my results.

regards,
dan carpenter

