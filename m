Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A55C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DE82173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391564AbfBRRyK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:54:10 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32895 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733043AbfBRRyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:54:10 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id CBF65D11A3DBBEF6AE31;
        Mon, 18 Feb 2019 17:54:08 +0000 (GMT)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 18 Feb 2019 17:54:08 +0000
Received: from lhreml702-chm.china.huawei.com (10.201.108.51) by
 lhreml703-chm.china.huawei.com (10.201.108.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 18 Feb 2019 17:54:08 +0000
Received: from lhreml702-chm.china.huawei.com ([10.201.68.197]) by
 lhreml702-chm.china.huawei.com ([10.201.68.197]) with mapi id 15.01.1591.008;
 Mon, 18 Feb 2019 17:54:08 +0000
From:   Salil Mehta <salil.mehta@huawei.com>
To:     John Garry <john.garry@huawei.com>,
        Huang Zijiang <huang.zijiang@zte.com.cn>,
        "Zhuangyuzeng (Yisen)" <yisen.zhuang@huawei.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "lipeng (Y)" <lipeng321@huawei.com>,
        liuyonglong <liuyonglong@huawei.com>,
        yuehaibing <yuehaibing@huawei.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "wangxi (M)" <wangxi11@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH] net: hns: Fix object reference leaks in
 hns_dsaf_roce_reset()
Thread-Topic: [PATCH] net: hns: Fix object reference leaks in
 hns_dsaf_roce_reset()
Thread-Index: AQHUxDBEhCVMlZMv6EeAXB5DT3ZcMKXgsKCAgAAGiyCAAAx1gIAFGOMA
Date:   Mon, 18 Feb 2019 17:54:08 +0000
Message-ID: <961cf1cfaf05448092e517f4058ea062@huawei.com>
References: <1550126505-28394-1-git-send-email-huang.zijiang@zte.com.cn>
 <b20d235c-779c-77bd-e69f-2d63ffd79ec1@huawei.com>
 <11b3bcdf50ee435587fbfad6043e49bc@huawei.com>
 <4ca251e6-22a1-a792-bb64-2498d8cb6fcd@huawei.com>
In-Reply-To: <4ca251e6-22a1-a792-bb64-2498d8cb6fcd@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: John Garry
> Sent: Friday, February 15, 2019 12:00 PM
> 
> On 15/02/2019 11:25, Salil Mehta wrote:
> >> From: John Garry
> >> Sent: Friday, February 15, 2019 10:52 AM
> >>
> >> On 14/02/2019 06:41, Huang Zijiang wrote:
> >>> The of_find_device_by_node() takes a reference to the underlying device
> >>> structure, we should release that reference.
> >>
> >> of_find_device_by_node() is not called for every path, so is this change proper:
> >
> >
> > It looks okay to me and with the suggested device reference is being
> > released from every possible error leg in the function. Could you be
> > more specific which error path is not being addressed?
> >
> >> 	/* find the platform device corresponding to fwnode */
> >> 	if (is_of_node(dsaf_fwnode)) {
> >> 		pdev = of_find_device_by_node(to_of_node(dsaf_fwnode));
> >
> >
> > This will get the reference to the device, which needs to be
> > released later.
> >
> >
> >> 	} else if (is_acpi_device_node(dsaf_fwnode)) {
> >> 		pdev = hns_dsaf_find_platform_device(dsaf_fwnode);
> >
> >
> > This will also get the reference to the device when bus_find_device()
> > gets called and returns the 'device'. Therefore, this needs to be
> > released as well using put_device()
> 
> OK, I see. That's non-obvious.
> 
> And so the commit message was simply incomplete.
> 
> So who finally drops this reference? This patch only seems to release on
> error path. I checked the callers and they don't seem to.


Yes, in the positive leg the put_device() was missing. Thanks for identifying!
I have floated the patch to fix it https://www.lkml.org/lkml/2019/2/18/1161


Salil.

