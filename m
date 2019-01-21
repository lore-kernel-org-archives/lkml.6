Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6531EC31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B1520823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dJ8utWdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfAUHXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:23:47 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:51786 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfAUHXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:23:46 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190121012358epoutp0323462fd38b9b32698e0af494ebf618ae~7uJL6LKNR2070220702epoutp03d
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:23:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190121012358epoutp0323462fd38b9b32698e0af494ebf618ae~7uJL6LKNR2070220702epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548033838;
        bh=wUoKP7HmrawMJwkdmht0fjJJqjkQkO/cE4wFGiifKIY=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=dJ8utWdyx6XXyCK0Hh61z4s8Zq3AXfQ7fpL7YKeRmYs+aVfLUP68noG8HZFisT0Km
         whLQz7sX0QlbwS33gpqhWPLBZeld/2V+07c3zd4lZ5BSV4Y2UES2XJwIZSMod55bBF
         rRAMHe+pAZpLPxDjDsxBJgxLF0dB2qJC3Ag/dIEc=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190121012356epcas1p34d8e33353906f0165ba937858212656a~7uJKK98351948319483epcas1p3e;
        Mon, 21 Jan 2019 01:23:56 +0000 (GMT)
X-AuditID: b6c32a36-5c1ff7000000104d-c9-5c451f27b186
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.B3.04173.72F154C5; Mon, 21 Jan 2019 10:23:51 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 3/3] PM / devfreq: fix mem leak in devfreq_add_device()
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>
CC:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190119160454.23151-3-tiny.windzz@gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190121012351epcms1p59b810ea2b6ebdaf80a85fbe17b60d1bf@epcms1p5>
Date:   Mon, 21 Jan 2019 10:23:51 +0900
X-CMS-MailID: 20190121012351epcms1p59b810ea2b6ebdaf80a85fbe17b60d1bf
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmvq66vGuMwb3vahbXvzxntTjb9Ibd
        4vKuOWwWn3uPMFrM/T2BzYHVY+esu+wefVtWMXp83iQXwByVbZORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYquUWpCSU2BZoFecmFtcmpeul5yfa2VoYGBkClSYkJ1xoLmLvaCJreLAR5UGxibWLkZO
        DgkBE4kVb96zdTFycQgJ7GCU2NK/lqmLkYODV0BQ4u8OYZAaYQFviZbfk5hBbCEBJYmGm/uY
        IeL6Eh0PtjGC2GwCuhJbN9xlAbFFBOIlPp0+ATaTWWAao8THWXsYIZbxSsxof8oCYUtLbF++
        FSzOKWAt0XzhLdRBohI3V79lh7HfH5sP1Ssi0XrvLDOELSjx4OduRpg5M6b8h5pZLfGo5yIz
        yGIJgRZGiVUztzFBJPQlzsw9yQZi8wr4Srz4eABsEIuAqsSUu1ehhrpInL94AGwQs4C8xPa3
        c5hBAcEsoCmxfpc+RJhP4t3XHlaYX3bMewI1Xk3i0O4lUDfLSJyevhBqpIfE6kWvGSGBu5lR
        YmNTJ+sERvlZiPCdhWTbLIRtCxiZVzGKpRYU56anFhsWGCHH6CZGcJLTMtvBuOiczyFGAQ5G
        JR7eH/dcYoRYE8uKK3MPMUpwMCuJ8GYcd44R4k1JrKxKLcqPLyrNSS0+xGgK9PREZinR5Hxg
        As4riTc0NTI2NrYwMTQzNTRUEudd7wDUJJCeWJKanZpakFoE08fEwSnVwFhu/m/3beHk/ac+
        nX4kl3SqadYxX8uOy9nbWtlPtPPttpBYId97+pfEseJYlVtHhSyOZs0VFcz3n+0fv2/auilc
        T7qfTyjpPH/9E+8d3xrbtidmYRuXvNuyICA5XlqqjH/Sub+FCxflSdziuXZMm3HH/LLEmZuP
        ilow7PR3vhf45aCb3xKrGAUlluKMREMt5qLiRABdrDTQiAMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190119183505epcas1p15efda0795b3c94601bcb2f442ab15232
References: <20190119160454.23151-3-tiny.windzz@gmail.com>
        <20190119160454.23151-1-tiny.windzz@gmail.com>
        <CGME20190119183505epcas1p15efda0795b3c94601bcb2f442ab15232@epcms1p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>'devfreq' is malloced in devfreq_add_device() and should be freed in
>the error handling cases, otherwise it will cause memory leak.
>
>Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


>---
> drivers/devfreq/devfreq.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>index 923889229a0b..fe6c157cb7e0 100644
>--- a/drivers/devfreq/devfreq.c
>+++ b/drivers/devfreq/devfreq.c
>@@ -651,7 +651,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
> 		mutex_unlock(&devfreq->lock);
> 		err = set_freq_table(devfreq);
> 		if (err < 0)
>-			goto err_out;
>+			goto err_dev;
> 		mutex_lock(&devfreq->lock);
> 	}
> 
