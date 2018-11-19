Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F0CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5441C20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5441C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbeKTFaZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:30:25 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:38315 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbeKTFaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:30:24 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wAJJ4cJu008801;
        Mon, 19 Nov 2018 20:05:01 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nt9b24d1n-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 19 Nov 2018 20:05:01 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 304F13A;
        Mon, 19 Nov 2018 19:04:59 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AEC3A53E5;
        Mon, 19 Nov 2018 19:04:59 +0000 (GMT)
Received: from SFHDAG2NODE1.st.com (10.75.127.4) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 19 Nov
 2018 20:04:59 +0100
Received: from SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90]) by
 SFHDAG2NODE1.st.com ([fe80::4413:c8c:992b:bb90%20]) with mapi id
 15.00.1347.000; Mon, 19 Nov 2018 20:04:59 +0100
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dominique Martinet" <asmadeus@codewreck.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>
Subject: RE: [PATCH] iio: st_sensors: Fix the sleep time for sampling
Thread-Topic: [PATCH] iio: st_sensors: Fix the sleep time for sampling
Thread-Index: AQHUf87jF996TGSh6kGbSgzQPMw9KKVXc4KA
Date:   Mon, 19 Nov 2018 19:04:59 +0000
Message-ID: <04d0345d6c6c4ac0950ab0676ffd7689@SFHDAG2NODE1.st.com>
References: <20181119061219.14238-1-jian-hong@endlessm.com>
In-Reply-To: <20181119061219.14238-1-jian-hong@endlessm.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian,

Not clear to me why should be + instead of *.

ODR is expressed in Hz, so (1/Hz) = period in seconds (1 sample sampling time) [s]
1000 * (1/Hz) = period in milliseconds (1 sample sampling time) [ms]
n * 1000 * (1/Hz) = n times period in milliseconds (n times sample sampling time) [ms]

In your case you assume bootime is in milliseconds. Maybe we can change the comment and use 'number of samples ...'.

Br,
Denis



-----Original Message-----
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On Behalf Of Jian-Hong Pan
Sent: Sunday, November 18, 2018 10:12 PM
To: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Dominique Martinet <asmadeus@codewreck.org>
Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; linux@endlessm.com; Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] iio: st_sensors: Fix the sleep time for sampling

According to the description of st_sensor_settings and st_sensor_data structures' comments:
- bootime: samples to discard when sensor passing from power-down to power-up.
- odr: Output data rate of the sensor [Hz].

The sleep time should be
sdata->sensor_settings->bootime + 1000 / sdata->odr ms.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 26fbd1bd9413..6b87ea657a92 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -594,7 +594,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 		if (err < 0)
 			goto out;
 
-		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
+		msleep(sdata->sensor_settings->bootime + 1000 / sdata->odr);
 		err = st_sensors_read_axis_data(indio_dev, ch, val);
 		if (err < 0)
 			goto out;
--
2.11.0

