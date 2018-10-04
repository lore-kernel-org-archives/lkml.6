Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC50BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A346E2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i3CBSemw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A346E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJDVbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:31:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60138 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeJDVbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:31:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w94EYH8v090817;
        Thu, 4 Oct 2018 14:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=3zAwkcCqsiJJ3tf4fDUCP8h5IpJmykzD0Smpt5CumTM=;
 b=i3CBSemwUW/9qWBIil8nUkq9cFzwriFnJQ8mTPe5poKPjYoQqGokTy/dOeKPEOMy5mkN
 u9t30YcaVeSyuHgNHdO5xktLnqaivihYbgecYVvUc5GjB39wQWnbUQdtLfEhFaNPezm6
 iLgWOApEkvv+s1cWqNgqT75z7BJZ0JcUQL9RQNnPAR4nurmsg72Q2RaQajaW3BzU6EIa
 c+GXhzrFtxFaacVlKwRrzHSYYAN9KXmuOpKV6ktiddR2fxOuyV7m5sfxl5K+3nsUB7dC
 tMN8x4LHT64HiBDhaCiIVO0vjYqcFT31OU2/0L43XTu76dCpuXAUJLGpFqUofuxwwkt5 Cg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mt0tu4r43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Oct 2018 14:35:54 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w94EZsnx018685
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Oct 2018 14:35:54 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w94EZnbE016456;
        Thu, 4 Oct 2018 14:35:49 GMT
Received: from oracle.com (/10.39.202.251)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Oct 2018 14:35:48 +0000
Date:   Thu, 4 Oct 2018 10:35:08 -0400
From:   Sowmini Varadhan <sowmini.varadhan@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        gregkh <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        naren.kernel@gmail.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        ivan.khoronzhuk@linaro.org, svendev@arcx.com, pabeni@redhat.com,
        Alban Bedel <albeu@free.fr>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 00/29] at24: remove at24_platform_data
Message-ID: <20181004143508.GG13299@oracle.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180831194643.GA62862@ban.mtv.corp.google.com>
 <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
 <a4c2e6cf-749a-83a1-0bda-43ddb7e744cd@gmail.com>
 <CAMRc=MfwM7vODsnuV9eKS4Uf7M5ac59u7ao7KvyaxKzPv5FRvw@mail.gmail.com>
 <CAK8P3a1LufzR1_6mXH=1zDb34VQStLywGM1w5x5CDAMh_7uMyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1LufzR1_6mXH=1zDb34VQStLywGM1w5x5CDAMh_7uMyA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9035 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810040137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just catching up on this thread, so please excuse any unintentional
misquotes here.

> > > > David: I couldn't find a place in sparc code where any ethernet device
> > > > would be registered, so is there a chance that nobody is using it?
> > >
> > > SPARC uses a true Open Firmware implementation, so it would register
> > > drivers through the CONFIG_OF infrastructure.

correct

> The calls are not even that old, and clearly added intentionally for sparc,
> see commit ba94272d08a7 ("i40e: use eth_platform_get_mac_address()")
> which added the first one.

Yes, correct again. Wouldn't PPC also end up doing the same thing?

See also commit c762dff24c06 (for ixgbe) - without this fix sparc systems
will come up with a bogus mac address and then you end up having to
manually fix this in ugly ways.

--Sowmini


