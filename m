Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791FFC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423F620827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423F620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJ3Uoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:44:37 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:36798 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727669AbeJ3Uoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:44:37 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9UBmxcj020658;
        Tue, 30 Oct 2018 06:51:21 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ncne2udkj-1;
        Tue, 30 Oct 2018 06:51:21 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 43BC4650F636;
        Tue, 30 Oct 2018 06:54:23 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 30 Oct 2018
 11:51:20 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w9UBpKBa020708; Tue,
 30 Oct 2018 11:51:20 GMT
Date:   Tue, 30 Oct 2018 11:51:20 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Message-ID: <20181030115120.GI16508@imbe.wolfsonmicro.main>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
 <20181028223116.GJ1882@kunai>
 <CAO-hwJLw74k+jBnDuQ7OrVzJOy8i82OXKNWuNhxNqUj+8nzwhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAO-hwJLw74k+jBnDuQ7OrVzJOy8i82OXKNWuNhxNqUj+8nzwhg@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=791 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810300103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:15:47AM +0100, Benjamin Tissoires wrote:
> On Sun, Oct 28, 2018 at 11:31 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> >
> > On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> > > The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> > > i2c_device_remove does not clear this. When rebinding an I2C device,
> > > whos IRQ provider has also been rebound this means that an IRQ mapping
> > > will never be created, causing the I2C device to fail to acquire its
> > > IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> > > forcing i2c_device_probe to lookup the mapping again.
> > >
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> >
> > Adding Benjamin here again. Also, should there be a Fixes: tag?
> 
> Not sure if the circumstances are preventing me to think straight, but
> how can you reprobe the i2c_device?

You just head into /sys/bus/i2c/drivers/<the_driver> and use the
unbind file to remove the driver. You can then probe the driver
again using the bind file.

> And in all cases, for the Host notify part, having the IRQ already set
> shouldn't be an issue.

To be clear this isn't a theoretical issue this is something I
can replicate very easily. The problem comes in when you unbind
both the I2C device and the device that is providing its IRQ. In
my case the I2C device is a speaker amp and the device providing
IRQs is an audio CODEC.

When the device providing the IRQ is unbound it will delete the
IRQ mapping. For the I2C device to acquire its IRQ something
needs to recreate that mapping, this would normally happen (in a
DT system) as a result of the of_irq_get/_by_name. But as
client->irq is already set this doesn't happen, causing the I2C
device to fail probe because it couldn't locate its IRQ.

I can provide some stack traces or something if that would help
to clarify the issue?

Thanks,
Charles
