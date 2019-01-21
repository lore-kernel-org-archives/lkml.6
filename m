Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5261C31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8399F20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EIJdu6Of"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfAUHSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:18:48 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:48376 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfAUHSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:18:45 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190121012212epoutp03e280f04b17b8bc05005aee9332189452~7uHppCujA1972919729epoutp035
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:22:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190121012212epoutp03e280f04b17b8bc05005aee9332189452~7uHppCujA1972919729epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548033732;
        bh=6N90+D9Kx4hm6L3DEeAsRZgnyLjoWOs+CamGvaVC6zM=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=EIJdu6OfqXF/nCLhHToLIGH+gGE2+FEmuxijqL31D9gHqjmF56HJ9/6TbTUKu/nl0
         +HFuCw6wQFLO8/QQWJflYELd64c6eaj82akH4GN7bqiFqL+KibBPMpF5liVF9KilKv
         0WHwKaJ/B1ekY2/Jhbzq1PR5e6jn5Jjt2WDbz7kI=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190121012209epcas1p428822eed32ba337e79c5b2dbf457c5e5~7uHmZ9M3e0422804228epcas1p4H;
        Mon, 21 Jan 2019 01:22:09 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-dd-5c451ec0a9c8
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.F2.04074.0CE154C5; Mon, 21 Jan 2019 10:22:09 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] PM / devfreq: fix mem leak and missing check of return
 value in devfreq_add_device()
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
CC:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190119050256.22520-1-tiny.windzz@gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190121012208epcms1p4a7d1132bcfb6cc86db294ae5c606aa8b@epcms1p4>
Date:   Mon, 21 Jan 2019 10:22:08 +0900
X-CMS-MailID: 20190121012208epcms1p4a7d1132bcfb6cc86db294ae5c606aa8b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmru5BOdcYg525Fte/PGe1ONv0ht3i
        8q45bBafe48wWsz9PYHNgdVj56y77B59W1YxenzeJBfAHJVtk5GamJJapJCal5yfkpmXbqvk
        HRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0UUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCR
        X1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnfH+wxHmgnfMFUuP7mdvYOxh7mLk
        5JAQMJHYf3YpexcjF4eQwA5GiZZrf9i6GDk4eAUEJf7uEAYxhQWyJda9UwUpFxJQkmi4uQ+s
        VVhAX6LjwTZGEJtNQFdi64a7LCC2iICaxIqJ71hBRjILnGeUuPHpONQuXokZ7U9ZIGxpie3L
        t4I1cwpYS8z+fJAVIi4qcXP1W3YY+/2x+YwQtohE672zUHMEJR783M0IM2fGlP9QM6slHvVc
        ZAZZLCHQwiixauY2JoiEvsSZuSfZQGxeAV+Jpg1dYA0sAqoSK+80Qy1zkbhz7A7YAmYBeYnt
        b+cwgzzPLKApsX6XPkSYT+Ld1x5WmF92zHsCNV5N4tDuJVBjZCROT18IdaeHxPMbIP+CwrYJ
        GLbvJjBOYJSfhQjeWUi2zULYtoCReRWjWGpBcW56arFhgSFyjG5iBKc4LdMdjFPO+RxiFOBg
        VOLh/XHPJUaINbGsuDL3EKMEB7OSCG/GcecYId6UxMqq1KL8+KLSnNTiQ4ymQE9PZJYSTc4H
        pt+8knhDUyNjY2MLE0MzU0NDJXHe9Q5ATQLpiSWp2ampBalFMH1MHJxSDYz5bbO3FQlN2LrA
        +3fV12X3v/Ivfy32R0Tsy9E7ms0z/l/1u/Vq87mp+5ofydtzPn98reGOWdvmZGsHxh2n3bje
        VJ8XmHs8y1/kmoBbxeQstY0xTJ/sjpS4BfJqbrnu9arKdvfa+X4T4/1d/Rhd5l/u2jRZ0L1s
        mtPvMs2Z2+vmCC418rvmMVlTiaU4I9FQi7moOBEAFsnZN4cDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190119050400epcas4p34ea32277236e72d4527176fd0e98bd72
References: <20190119050256.22520-1-tiny.windzz@gmail.com>
        <CGME20190119050400epcas4p34ea32277236e72d4527176fd0e98bd72@epcms1p4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 'devfreq' is malloced in devfreq_add_device() and should be freed in
> the error handling cases, otherwise it will cause memory leak.
> 
> devm_kzalloc() could fail, so insert a check of its return value. And
> if it fails, returns -ENOMEM.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Dear Yangtao,

Could you please make your patch without indentation style changes?


The label, "err_devfreq", would fit more if it's renamed "err_kzalloc".


Cheers,
MyungJoo.
