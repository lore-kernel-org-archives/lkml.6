Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD41C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B36821773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfAJNcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:32:42 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:49858 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728733AbfAJNcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:32:42 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0ADJXdH031611;
        Thu, 10 Jan 2019 07:32:38 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2pu19vsa6k-1;
        Thu, 10 Jan 2019 07:32:37 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id CDED8611C8B5;
        Thu, 10 Jan 2019 07:36:47 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 10 Jan 2019
 13:32:36 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x0ADWaWZ024648; Thu,
 10 Jan 2019 13:32:36 GMT
Date:   Thu, 10 Jan 2019 13:32:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Yauhen Kharuzhy <jekhor@gmail.com>
CC:     <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Message-ID: <20190110133236.GC3837@imbe.wolfsonmicro.main>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
 <20190109214756.GA18115@jeknote.loshitsa1.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190109214756.GA18115@jeknote.loshitsa1.net>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=488 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901100108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:47:56AM +0300, Yauhen Kharuzhy wrote:
> On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> > The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> > i2c_device_remove does not clear this. When rebinding an I2C device,
> > whos IRQ provider has also been rebound this means that an IRQ mapping
> > will never be created, causing the I2C device to fail to acquire its
> > IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> > forcing i2c_device_probe to lookup the mapping again.
> 
> Hi.
> 
> I found  driver i2c/busses/i2c-cht-wc.c which instantiates I2C device
> (battery charger) and passes IRQ to driver not using standard I2C IRQ mapping code.
> So if we reprobe I2C device (by reloading I2C device driver module or by
> manipulations with sysfs), we get invalid IRQ number for client:
> 
>  adap->client_irq = irq_create_mapping(adap->irq_domain, 0);
>  ...
>  irq_set_chip_data(adap->client_irq, adap);
>  irq_set_chip_and_handler(adap->client_irq, &adap->irqchip, handle_simple_irq);
>  ...
>  board_info.irq = adap->client_irq;
>  adap->client = i2c_new_device(&adap->adapter, &board_info);
> 
> 
> adap->client->irq will be reset after device removing here.
> 
> 
> Any advice to fix this? Maybe move initial i2c_client->irq value to new field
> like client->init_irq and copy it to client->irq at probing, for example?
> 

Could you be a little more specific here, are you saying if you
reprobe the battery charger device or if you reprobe the I2C
controller itself?

Apologies but I am having a little difficulty working out the
path through which the IRQ is not reinitialised. As I would have
through the battery chargers probe would have reset up the IRQ
then the core would pick it up again from there.

Thanks,
Charles
