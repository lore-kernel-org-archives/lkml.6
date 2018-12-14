Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D22CC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73C020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vz6aX/pJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73C020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeLNG12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:27:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33694 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNG11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:27:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBE6IhNN191044;
        Fri, 14 Dec 2018 06:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=N8Wwln5G6PBij62TYCeXG69bvcwF+NBe6v9H8nmBl4o=;
 b=vz6aX/pJRasMlJrZChKUmBR4hT/VK+e7IcPXNndFIXe/O4to1NrtDzisGBOSPJifLpn4
 CdP3sSoNDXkjiBbhf/ZRGaCvPyZpI48ornJ0Jh9AlUoh1X83XIvTF37xjcBt8zPmoVbN
 hhjqS7TEHXw2nFa9fnyTmNKGB5VUBW+AfD8TSK4OFa5MtZbE/3c2ItzQNmZ1HNxWjYrn
 ZUKcDK0/jeBtf9HbboViag2G9OHv0OCVjzKknfHGSrr5szN2+IutAAVlRO4ZaUPeopSY
 a59UM47DpE0RIXajvTpzWhsR0H4w0N4ZRloDAllPY+kKijv5RjzcP5X0ZQAmGRJ7mY2H hg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2pb3n79k9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 06:26:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBE6QrlO005359
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 06:26:53 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBE6QquI009213;
        Fri, 14 Dec 2018 06:26:52 GMT
Received: from kadam (/197.157.0.36)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Dec 2018 22:26:52 -0800
Date:   Fri, 14 Dec 2018 09:26:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 04/11] staging: iio: adt7316: fix handling of dac high
 resolution option
Message-ID: <20181214062618.GW3116@kadam>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
 <20181212005503.28054-5-jeremyfertic@gmail.com>
 <20181212082315.GI3116@kadam>
 <20181213220146.GA2496@r2700x.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213220146.GA2496@r2700x.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9106 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=878
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812140058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 03:01:46PM -0700, Jeremy Fertic wrote:
> On Wed, Dec 12, 2018 at 11:23:16AM +0300, Dan Carpenter wrote:
> > On Tue, Dec 11, 2018 at 05:54:56PM -0700, Jeremy Fertic wrote:
> > > @@ -651,10 +649,12 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
> > >  	u8 config3;
> > >  	int ret;
> > >  
> > > +	if (chip->id == ID_ADT7318 || chip->id == ID_ADT7519)
> > > +		return -EPERM;
> > 
> > return -EINVAL is more appropriate than -EPERM.
> > 
> > regards,
> > dan carpenter
> > 
> 
> I chose -EPERM because the driver uses it quite a few times in similar
> circumstances.

Yeah.  I saw that when I reviewed the later patches in this series.

It's really not doing it right.  -EPERM means permission checks like
access_ok() failed so it's not appropriate.  -EINVAL is sort of general
purpose for invalid commands so it's probably the correct thing.

> At least with this driver, -EINVAL is used when the user
> attempts to write data that would never be valid. -EPERM is used when
> either the current device settings prevent some functionality from being
> used, or the device never supports that functionality. This patch is the
> latter, that these two chip ids never support this function.
> 
> I'll change to -EINVAL in a v2 series, but I wonder if I should hold off
> on a separate patch for other instances in this driver since it will be
> undergoing a substantial refactoring.

Generally, you should prefer kernel standards over driver standards and
especially for staging.  But it doesn't matter.  When I reviewed this
patch, I hadn't seen that the driver was doing it like this but now I
know so it's fine.  We can clean it all at once later if you want.

regards,
dan carpenter

