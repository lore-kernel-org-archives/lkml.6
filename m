Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F483C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD0520811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IK1OG0ML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD0520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeLNBpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:45:41 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:32432 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbeLNBpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:45:40 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181214014538epoutp0248a309586c940fff090add7530dcc5d7~wD7QH5R1l0423504235epoutp02e
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 01:45:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181214014538epoutp0248a309586c940fff090add7530dcc5d7~wD7QH5R1l0423504235epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544751938;
        bh=m5R9DYpdA/fD3xy1WsedCf0wxsYDJpMjYfrDa/HmZgM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=IK1OG0ML6jQy7zw7bJOqbUKyma337Vpax0mNKNfhaeK79MOWPln+ZvtK0HZI6vXkr
         QygUg4J8POixa4gA4gAqh4iIrWfsG5xKRJaNV5XBdp3AsHnB5QpU9m7m6oAxAtxhFq
         rJNeVRbEnbl9WXxVlRZSb1sEW5kDKXRaDz02boVk=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181214014534epcas1p3565e9b7c481ba442c12b250d276a68dd~wD7MuNOzU1567815678epcas1p3i;
        Fri, 14 Dec 2018 01:45:34 +0000 (GMT)
X-AuditID: b6c32a36-d19ff70000000fd9-5c-5c130b371962
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.A5.04057.73B031C5; Fri, 14 Dec 2018 10:45:27 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v4] PM / devfreq: Restart previous governor if new
 governor fails to start
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm-owner@vger.kernel.org" 
        <linux-arm-msm-owner@vger.kernel.org>,
        "skannan@codeaurora.org" <skannan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20181212135313.30268-1-sibis@codeaurora.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181214014527epcms1p6c783b4cd1602bbcbcb6e725f840db479@epcms1p6>
Date:   Fri, 14 Dec 2018 10:45:27 +0900
X-CMS-MailID: 20181214014527epcms1p6c783b4cd1602bbcbcb6e725f840db479
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmrq45t3CMwcPlRhbXvzxntTjb9Ibd
        4vfiCewWl3fNYbP43HuE0eLawvesFgcuTmRzYPe43NfL5NG3ZRWjx+dNcgHMUdk2GamJKalF
        Cql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUDLlRTKEnNKgUIBicXF
        Svp2NkX5pSWpChn5xSW2SqkFKTkFlgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGdeXr2EpaGet
        +D/hI0sDYytLFyMnh4SAicSij4sZuxi5OIQEdjBKzP+1k72LkYODV0BQ4u8OYZAaYYEEiabb
        E9lBbCEBJYmGm/uYIeL6Eh0PtjGC2GwCuhJbN9wFmykCZD/avZMNZCazwCkmiY7T15ghlvFK
        zGh/CrVYWmL78q2MILs4BawkpnySgQiLStxc/ZYdxn5/bD4jhC0i0XrvLNQYQYkHP3dDxaUk
        nrxdCFVfL3H98yImkL0SAhMYJX7f+A+V0Jd4dGU2G8RfvhJnn4WDhFkEVCX2L1wCdoKEgIvE
        6o92IGFmAXmJ7W/nMIOEmQU0Jdbv0ocI80m8+9rDCvPIjnlPmCBsNYlDu5dALZKROD19ITPE
        RA+JxvkikEBrZJTYc658AqP8LETQzkKyaxbCrgWMzKsYxVILinPTU4sNC4yQY3MTIzjhaZnt
        YFx0zucQowAHoxIPb8YkoRgh1sSy4srcQ4wSHMxKIryPowRjhHhTEiurUovy44tKc1KLDzGa
        An08kVlKNDkfmIzzSuINTY2MjY0tTAzNTA0NlcR5n0jNjRYSSE8sSc1OTS1ILYLpY+LglGpg
        9Nl9rvurmcWdqT/UJr+7Ys4f/bfoufAhP8UrGWLCrNy/iviNpuudFOmqkvW+En/uSHvhmifT
        /vhlbA9R28wb2/i9oGGyeumfuctP6dx6/OtczXMjPZNlk+oMCt+c3WHKY7v6y+Iy04019xZ/
        mLfpvdFPE26GJuf0Pab755w8e3PDO9masKvCF5RYijMSDbWYi4oTAV0S/S+OAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181212135338epcas5p12f7a8cd1c7aab5d5c936cbc5c33eee07
References: <20181212135313.30268-1-sibis@codeaurora.org>
        <CGME20181212135338epcas5p12f7a8cd1c7aab5d5c936cbc5c33eee07@epcms1p6>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Saravana Kannan <skannan@codeaurora.org>
> 
> If the new governor fails to start, switch back to old governor so that the
> devfreq state is not left in some weird limbo.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Hello,

In overall, the idea and the implementation looks good.

However, I have a question:

What if the following line fails?

+		df->governor->event_handler(df, DEVFREQ_GOV_START,
+					    NULL);

Don't we still need something to handle for such events?

Cheers,
MyungJoo

