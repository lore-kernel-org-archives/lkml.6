Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6405FC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9AE20880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="bSzpmlMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9AE20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeLMMq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:46:59 -0500
Received: from mail-eopbgr820074.outbound.protection.outlook.com ([40.107.82.74]:55616
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728517AbeLMMq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayEU6NiaIT69vb/chRt3TnZDCi2qpL/AsJFl0NdvSbg=;
 b=bSzpmlMjPNY/FJP+5qio0ysgyCg7XkH3FRJmSNJrw+UN43ii3N+p9H3LicH9Ex+b2c5WpctQ3/7WgR+iL8POeGjGp37VDXt0Vo0WyXI4Bybx+JdJK9qEY+GN1oKoKZYt+aJiYPeysnSdd8Hj0AcjNcwYxVPNHpNhzUKpTXE5Kbc=
Received: from DM5PR03CA0032.namprd03.prod.outlook.com (2603:10b6:4:3b::21) by
 BN3PR03MB2260.namprd03.prod.outlook.com (2a01:111:e400:7bba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.18; Thu, 13 Dec
 2018 12:46:53 +0000
Received: from BN1AFFO11FD026.protection.gbl (2a01:111:f400:7c10::153) by
 DM5PR03CA0032.outlook.office365.com (2603:10b6:4:3b::21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.20 via Frontend Transport; Thu, 13 Dec 2018 12:46:53 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BN1AFFO11FD026.mail.protection.outlook.com (10.58.52.86) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Thu, 13 Dec 2018 12:46:53 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wBDCkq1Q004050
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Dec 2018 04:46:52 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 13 Dec 2018 07:46:51 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: [PATCH 00/11] staging: iio: ad7606: Move out of staging
Date:   Thu, 13 Dec 2018 14:46:12 +0200
Message-ID: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(2980300002)(3190300001)(199004)(189003)(36756003)(50226002)(478600001)(51416003)(14444005)(2906002)(47776003)(77096007)(8676002)(48376002)(305945005)(16586007)(246002)(7696005)(316002)(26005)(8936002)(110136005)(186003)(54906003)(106466001)(7636002)(7416002)(2616005)(44832011)(426003)(106002)(336012)(5660300001)(50466002)(6666004)(356004)(72206003)(4326008)(476003)(116002)(126002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2260;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD026;1:yO35ZhvdnfGMxw1D0FLgZT0fOuXRHfd6p2e8nu9BV0thz8BVR9ltCTBt6uHuQMkYCJi6JuyAkAW5VILj07CrpxN0321g9JMt9FbcUjWBrJzSPQ8pL4gFmpIR4oUt4zv7
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53bc8258-f548-491a-0926-08d660f90eec
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN3PR03MB2260;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2260;3:g635I+4nO7O0gqDfYYygRxPmME8KrdyhiT5ATBGDkg222KkqzXqrNWzJNilEZMVYcv8Scbsm4VpJyaqIJu8xQE5KgqKIukzROVZHD4Zqjn/WJoycsonk6oZlR7mHu/1dKaanbraN+qFGQ6mlkjXFFDfQFRjBvCXuAjleM39U0QAgHGMOa4GUnqcKOUn7d/JzGytNt/hhJkDH1trv4sXTUuBbyIvYpGbaLVhE2t311rOCV2hAh0dcqbQRMl7VXPM8rWFZ51w5Bkm3teyJTOK2IXetB5ycw/Qc1jnBd8HYIWfKUopnLWgBUmUM5cBFYqLxS1Dl+G2vSwyRAo47/cVXQZs5KGjpeB2fbv1flDkStNU=;25:LIGkl9EvHvmasqiCBE5aGrqnFOIwxLSucbevpoeBpdbpJnDXuZZkNRTUju1505GRjfU3mtEakSBdoOefj8whY0DY+BtZP66U4ts/TDiuvAboaoW9Be1HqDrtlysc4OJydUzxr6MIdhoJ87yu0XHaS3P5InRQGhrMzfpKrPoHgE7mSB6n+jROMsz3g2+9vrs3e72wkUfd+81dsDxHwpLozKoIh2rgkyswnNdKjqCaBheyQnrSNomiW7PqiLBasCD3EqnJe+aPVm8rwpOqD0bidYOPXXlpts5cI1ciaq51Eel4cF7ONWEuJ8gaFW2fZb4JALgWICGzwhDINUGWzpevIw==
X-MS-TrafficTypeDiagnostic: BN3PR03MB2260:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2260;31:s2E7ulbX7zUfuKwzySIaMrrQlMseMrikeUzTw5xbZ7YlF8iigeQ7ukN/DJgECiVS+6YbFyGu2IMvGNG0yi1qm7tfnvx1cjv2cXKSqaNu6TyG2scPbo0d70s7lwG+8ZIcREfkGFr0wOEUG23rFSwZ66TqDvTs0Kg/gUJAuXcGlDDcwc1jYvYDS3g6FolSLdbOfNiohJZi0lNPtcCgZRK8Jeg/dkNBw5uIKW536ZvN2f4=;20:5lMXsDy+MIh+wTo5oeDTlKNaUNjZWiItM1JjhI9wmythr3q8m2OMlePF9ool3A+Kwgp2XzZP8lYmjbpqSIkTjksMmxV0cqcDlN8TDk8UryNq9TNBou09kOLOWIiFtcNg5yt7WW+j7bS2fqIO/+jtXuWeRG3LfhtlCSUhpoAEHHmMsRwMBfU54uI0P07DADZH22ZysVgOZdgrkAekLvG8+pR2oM0ZCsKn5favYdfNqWR0/0JKBBe0pHm5NTzBnXeWntjJl2kJ8thClFgWB/jZLgUyDB6j3nPlXD8iZN0gBmrP0Mto/Urjg6SFZzzwpF3+L7eJKMUvMq5JsY57zpvAzL8yAL8jiLjxYGf5xwITa6t6lEUZN7FZ9yAzIU3GkTWmnHfPjOFfpmZIDWedPuZfYdEfq9plUfDHld1OXk35UCGekp+aX3+TiBsbNstVhHSOQFRGRw76qQUtOLCMZc35qtvsC75XkQeSYByMS0Gc/WExTl8pJCshwiO0El4jvn1T
X-Microsoft-Antispam-PRVS: <BN3PR03MB226023CE9980EEABBC7010CC9DA00@BN3PR03MB2260.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231475)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN3PR03MB2260;BCL:0;PCL:0;RULEID:;SRVR:BN3PR03MB2260;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2260;4:9uGNmEJjkVWzR3nSBSKVDA7DffzywPuigwDL0fKwmfvfz9veKoyD9Q/Zxi/G9TUR8m+rIxSbnaMipvvCnyyKajn023ku9uJLjw6AhTHSy8+kkb3Ew8CyYyRcw3cGDlWYavn30CJf3RJEvEupU4wrK+lVDhBXBmWzoNCU8Y1ZMeXbgX2vgR4p4rH/IhGo5fV50ouR7vjJw9eoePnNC2Xfu/xCDnGNIUUIzX8iL6HeMINTP8yqiPWXrJW/4y+stnh9yTokc4k1QZ5T1G8HVEPhCw==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR03MB2260;23:fAET9C1LfN5p9WTfbgnFmjfZ9x098I6hjpgZ5E1QQ?=
 =?us-ascii?Q?4iO8wC8I7TKBGAqJcrAwOgilfiUPvdDKC7LUCgng5IyoRWYlxV0HIzNCV4Dv?=
 =?us-ascii?Q?8f6jDYI9nF3AzEk2P9hJqi4hv8iPvV+ktel4si6qYKc4VgaonB/3NI+mDSJc?=
 =?us-ascii?Q?8eCov4vj9BOPcyJ5jev/hCQcSjWTh4EL5V8DG0N94AqV1dXJMwxrlLsK7Art?=
 =?us-ascii?Q?LsoO3VchFi+zP5u6X92n1VlptpvZs/6O9NJ4bWmrdi7Kz+9b9Dny29+9AH2j?=
 =?us-ascii?Q?8XrjHvoceHp+LYXmncwbg82vNiwgSKAM3QY9bN3B7Ld2Pcrx5dibcHtDEWAW?=
 =?us-ascii?Q?gTtk35o+fIY9O8HVHuIUvAEhm3lY63GkybGY3/x0hdlGam44KL36U1ot0rFd?=
 =?us-ascii?Q?+5L+oanNcO0gV81tb3YWb2gSuteHrj1eSkuACOcfYv/0+a/Tkng50J87uBAn?=
 =?us-ascii?Q?3yOV9bDNbMwNf/YFgpNWz0wK5emTCNNiugIHdsRMsiMtYxDJBklKVSPRKtUK?=
 =?us-ascii?Q?RkEC6q1FbvYJWmxj/3zDdBrF51FarX+3kgSrYAKqzXxdbXMbUlq6KUcrzgJz?=
 =?us-ascii?Q?sdQu7umdRkr2pBwNuOhg+nrSt0eWjMjefnfFijya7BAjvkky9lAi20PVdBrD?=
 =?us-ascii?Q?wuyGPtKbQxKQ4tdhW3XMhX8rUMvjayZBZreNKp2OI9ENe9EIhC2eoFECQK0A?=
 =?us-ascii?Q?+AJq+PRF7X7qYZH/XMGH8wlKLWPDMQsRRhSyHXmVGPZQHuDr0kHColD7Ruqc?=
 =?us-ascii?Q?xVjBoO9uaEA5XXV/tWNooKcfnYrVI0h+qcaJy8Yz/QRyjtynVkXT4u+ccSzt?=
 =?us-ascii?Q?D+CRXG6d5zH80Tbm0/yWbEEaXt5RxYvFtE1Y2DOU53yQI1rTxU7QegqZOtVO?=
 =?us-ascii?Q?TO2e43kI515kPmn4SGgmXJqtkZnA5dd5Z5Vq2BuH6R0Da5ztQKv8SN7loNOf?=
 =?us-ascii?Q?XblF7uT0+u+YetO9UQqd8AxcjbM1N//9PkveSR4FE3pprsRrtIxKCKH+Os9R?=
 =?us-ascii?Q?VPuOa1wUEZ4+6Ryjz4oc4F7sPBTFKpMywhLZHYxlHQtHg=3D=3D?=
X-Microsoft-Antispam-Message-Info: bhuOYG7KqdhAjdqEbXW4buZHu/LvKzDcQWEdEgCaLvxUA9GyaaATCIzMzxIz5A2Pc7yEs+0+mJqbRqJ/dYwbiCmED/LA5L+fmdP0SUkttLznm+KGzWpckIYB7fckUiKtMliJYUNtAqscc8b4UKvNR5+2jliEWGD5JCwwKT5n2tQnMvpeYUQaBoVaKSuSROUxZvp0nUCPmxghUPF6leoxx4rTjKGIF4XPijYjIVUmV2IwTagjY39eNuhOrjA+EiamPnqgJIspICxhW+g4e3FOPPoAxyEfKx38AJ+NxzA2YtikRv4GX5cIjqOYNIqBU24+
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2260;6:UNMd2gFWQAdlYT3bZTh25R9pWTrMUuPFARD3ti8F5guvWrxMvkvDVaiI92hipl/KI5/SK1bV2C40gb2N3BlbIpcNkRUmmeTZpwOV70Ciz5u5qPBTmAU3zivvqpOz1D3MEhaMPxmOVjRr3/vV4GmqL9+SmDvu97RhGTKfx9+i0oJrwgDGvIfMqXpZET0WJAmfUwmPBOykMi37fDUPFG0tonNiFhNcZXOv1xr6x8vO0v5rUGzfPI+7B7jimYw7uyxmJ5Vmy7TyIULp0DPa8NJwMSzcpV47YiRt7+rIsEVgrePdbFxYsLJykbrulgOtfzqudMnszzsXQUt0GV27mpsKQYWgggQ72fUfPXqLejo90ZuxyAISN+Ca6XwbubKl6FeZrYrwL6wOvQptwfpr/gxqjQuGWQl/ChMtOO2RhU60+wxlW7Y6wsDN8IueyMaClS+3EDI4d2cenPApKT+zcnbQCg==;5:3LJoOBZ/QLbva/fhHfyHhJfMY8ANpPnCMko20k+GbHM4C+F/BOv0sc39lvgSS1iCHYzUAOSZx+EyGoWDiRgcQahERJJvFyvlfBZaa8korxtt5tnNsLsBLN31ge4N8rX+klNn7ze1X/s5pucYc6PhP5CNSWCUTK2qp4V2Mr19xGA=;7:n1KdkSVw0EDqpZc+71fSSNdIVkRAu1U4jGqvzCtOvBvotX7iYgMdcPKG2hdk6WEJr1OPd+jl9ZGKVhyRcm7WmLkyjR4s1FNS81MRBmyF1OneUlfIsu4TgRDLnUYqhpfuAgQrXyNk9DVmnom1uQWFIA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 12:46:53.1882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bc8258-f548-491a-0926-08d660f90eec
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to clean up the driver according to the feedback
received during review and finally moves it out of staging.

Stefan Popa (11):
  staging: iio: adc: ad7606: Simplify the Kconfing menu
  staging: iio: adc: ad7606: Use SPDX identifier
  staging: iio: adc: ad7606: Use wait-for-completion handler
  staging: iio: adc: ad7606: Use devm functions in probe
  staging: iio: adc: ad7606: Add support for threaded irq
  staging: iio: adc: ad7606: Use find_closest() macro
  staging: iio: adc: ad7606: Use vendor prefix for DT properties
  staging: iio: adc: ad7606: Add OF device ID table
  staging: iio: adc: ad7606: Misc style fixes (no functional change)
  staging: iio: adc: ad7606: Move out of staging
  dt-bindings: iio: adc: Add docs for AD7606 ADC

 .../devicetree/bindings/iio/adc/adi,ad7606.txt     |  65 +++
 MAINTAINERS                                        |   8 +
 drivers/iio/adc/Kconfig                            |  28 +
 drivers/iio/adc/Makefile                           |   3 +
 drivers/iio/adc/ad7606.c                           | 588 +++++++++++++++++++++
 drivers/iio/adc/ad7606.h                           |  99 ++++
 drivers/iio/adc/ad7606_par.c                       | 105 ++++
 drivers/iio/adc/ad7606_spi.c                       |  82 +++
 drivers/staging/iio/adc/Kconfig                    |  34 --
 drivers/staging/iio/adc/Makefile                   |   4 -
 drivers/staging/iio/adc/ad7606.c                   | 563 --------------------
 drivers/staging/iio/adc/ad7606.h                   | 106 ----
 drivers/staging/iio/adc/ad7606_par.c               | 113 ----
 drivers/staging/iio/adc/ad7606_spi.c               |  79 ---
 14 files changed, 978 insertions(+), 899 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
 create mode 100644 drivers/iio/adc/ad7606.c
 create mode 100644 drivers/iio/adc/ad7606.h
 create mode 100644 drivers/iio/adc/ad7606_par.c
 create mode 100644 drivers/iio/adc/ad7606_spi.c
 delete mode 100644 drivers/staging/iio/adc/ad7606.c
 delete mode 100644 drivers/staging/iio/adc/ad7606.h
 delete mode 100644 drivers/staging/iio/adc/ad7606_par.c
 delete mode 100644 drivers/staging/iio/adc/ad7606_spi.c

-- 
2.7.4

