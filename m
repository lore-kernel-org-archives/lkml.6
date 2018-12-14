Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C19FC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D2020811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nkQGORe+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D2020811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeLNGTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:19:20 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48784 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNGTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:19:19 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBE6IfJg146018;
        Fri, 14 Dec 2018 06:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=p013JWnpjnca6mpV+iy5JtIUsLtbzpnYEmV0KlH72+k=;
 b=nkQGORe+D2uoNaKYgD6vMQ+1mfNRv8rgFcwA7qe02zIFTSVhgt9bmGmwJpz1/drQh3HV
 SzoMcOAqqpqv+qaZMmDWvxkv2AMbWW5liI2QczpYTEqbhKcVZm83uCTSORFSurdWws2b
 TCIJiLLzZZAjI6z+BG4yp2K66nW5CeXDzp5kTrWVX4/MQV40nqgh1Ffp9va8bRYrH31v
 xTh4oRMQdfEqc1FHj018TR920kfN4JlVB8A5STGwWRORznIbkINuoZDFXoUEFfMHoEiS
 z/OCAK5xpCWjLc0i4rkuJ72PYAI/V5GUB0DM+29QCfOtG4acX4ZD5O89XStOnNEoYLst LQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2pawwpbdq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 06:18:49 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBE6Imop017455
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 06:18:48 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBE6IkaO010051;
        Fri, 14 Dec 2018 06:18:47 GMT
Received: from kadam (/197.157.0.36)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Dec 2018 22:18:46 -0800
Date:   Fri, 14 Dec 2018 09:18:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 02/11] staging: iio: adt7316: invert the logic of the
 check for an ldac pin
Message-ID: <20181214061820.GV3116@kadam>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
 <20181212005503.28054-3-jeremyfertic@gmail.com>
 <20181212081949.GH3116@kadam>
 <20181213220629.GB2496@r2700x.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213220629.GB2496@r2700x.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9106 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=467
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812140058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 03:06:29PM -0700, Jeremy Fertic wrote:
> On Wed, Dec 12, 2018 at 11:19:49AM +0300, Dan Carpenter wrote:
> > On Tue, Dec 11, 2018 at 05:54:54PM -0700, Jeremy Fertic wrote:
> > > ADT7316_DA_EN_VIA_DAC_LDCA is set when the dac and ldac registers are being
> > > used to update the dacs instead of the ldac pin. ADT7516_SEL_AIN3 is an adc
> > > input that shares the ldac pin. Only set these bits if an ldac pin is not
> > > being used.
> > > 
> > > Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
> > 
> > Huh...  This bug has always been there...
> > 
> > Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
> > 
> > regards,
> > dan carpenter
> > 
> 
> Should I include this Fixes tag in v2? I wasn't sure how important this was
> in staging. I think most of the patches in this series fix bugs that date
> back to the introduction of the driver.

I was just curious to see if it was a cleanup which introduced the
inverted if statement.

I think the Fixes tag is always useful.  For example, it would be
interesting to do some data mining to see how many bugs drivers
normally have when they're first merged.

regards,
dan carpenter
