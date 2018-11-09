Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF87C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF0E2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="HM6B6V2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF0E2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeKJBWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:22:41 -0500
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:35616
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727802AbeKJBWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9WGURcCdIqdhb8UxhR6h+ivoMZXGQsMWRcq4NCw2N8=;
 b=HM6B6V2DrpPSUSQVkSfrhQkwvDn3IfdXW8D9yMwlqwL23jfgMFJmu3PN478eJD89K8IAgORR3037rYvx/tKnfN8Z7MPGpne2v3I63q7NcCmgiH5Rkttco5yMptbAlAnZ9e83kUwPbmov4OYzEHTxVPNMYSNdMpBgnDjvzRHzQ5s=
Received: from CY4PR03CA0082.namprd03.prod.outlook.com (2603:10b6:910:4d::23)
 by SN2PR03MB2272.namprd03.prod.outlook.com (2603:10b6:804:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.20; Fri, 9 Nov
 2018 15:41:13 +0000
Received: from BN1AFFO11FD021.protection.gbl (2a01:111:f400:7c10::129) by
 CY4PR03CA0082.outlook.office365.com (2603:10b6:910:4d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.23 via Frontend Transport; Fri, 9 Nov 2018 15:41:13 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD021.mail.protection.outlook.com (10.58.52.81) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.12
 via Frontend Transport; Fri, 9 Nov 2018 15:41:12 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id wA9FfCgd017688
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 9 Nov 2018 07:41:12 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.301.0; Fri, 9 Nov 2018 10:41:12 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v4 2/4] dt-bindings: iio: adc: Add common ADCs properties to a separate file
Date:   Fri, 9 Nov 2018 17:40:55 +0200
Message-ID: <1541778055-7629-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(438002)(199004)(189003)(50466002)(51416003)(16586007)(305945005)(2616005)(106466001)(106002)(7696005)(486006)(5660300001)(476003)(126002)(48376002)(356004)(2906002)(6666004)(107886003)(316002)(54906003)(110136005)(26005)(77096007)(44832011)(7636002)(36756003)(426003)(47776003)(7416002)(478600001)(4326008)(8936002)(336012)(72206003)(50226002)(186003)(246002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2272;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD021;1:sqf0sQnm3YJ8HgT1/lo7rn+CrsPbPRCDsG6dkB3KDzZM8ZZSbMAcohaQPBGvh34CXCxfCQKeMaQJkMAUEMrVyUMY+3uPwzNaVfRx/n2maRp3yiDnKHTdnR6gfixwD2ou
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 673799a8-2951-463a-9d61-08d64659c737
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN2PR03MB2272;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2272;3:YXcfusQewXP2e0Jwnzn4ySQKKCn2IZehdkks2vS9icZ/gNfAY7iEtgq07d0l0LLEnTtrXrOg+l1B54s4taqv6bSYpvWKCXOX+Z1q873gbnU4idybL3kPKB1b+eGXj++d56ColYPVre5KjAOmoZxbwbpamwo4U2jZ+tfGQ81a0aWr5N47tYgmf9jcwJ2QLQWpgvxBjotUEiUZ841nRxuB/W7ZRLm0hnK4Pwozx4jwlPEK7f5bzIOLIEGuu2qYfcArnHuQhp7trmXQFd4qDADY5xZdQ4WdkoWq4reE0Wl+7KwhhZu/K9HMP1XAanPeIRA/MRrOYATMUWJfJWEorJ3jKdixBlRJgxr6+IUYkijxrkk=;25:YjuZfSxTGKXbvc88nocXkFy4GTdiroxtLvnqK8sD0g0w8lOskedhHg6HYJ1RjAo14YSbe61IbJoW4Rj8MuY78LFZk4NJUIXDsrD5rypfrGD4wa5aGL4kxjw0S/7sJ+vzxA+hRwfsSYIrkWCLWINH8Igsnv82x3vuy/YpB81F2w4vgwp5E4E6VBC1SctWbYKXcZ0jj/sz88jQ0tkdA7+C5I3len0gkR0v7VN/aiI+sCWVh8z6lj4Mtus5dSO+gYK/RH/fwiLd7QV76iEf13hm2Ph59VrxPP2bbCc9UB7BNPQ7Ku3u2wBExOXHGhFERO1QLVBrfzHzqeEJx7GcdiwgVQ==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2272:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2272;31:pQENZVnGr+7CIVM5xs2ZR7a/fJt0Z4bMNmPIDYE2gab8/qnvlcVnhQLB0/DveylQT7VFOvLvvYpGOVncNUsI5eU8H6ogQsNgeQPQM1bEgRkgndiM+9Qjsbhwpa9yYnH5Q63bVRR0tWn+kSE3MNIU23S+uSpK8plZnwGaUhSj1L6KIeYMVSDchTzk+vVpjrHIDsXAZbKg6e8PfNc5zAZmSJJ5FbJr20mM+5rgVB0yDN4=;20:t6U1DW358X+rWE3WMgckCYRRvoqfxNctBr8MM6WvTYw3lwfAyeVH6T4PRCQGalgKJF78s2p+vINu+1krBhfYQOq+7xKgyYllpEIJPKRNZF1rpBQbAH8ky398Yfa6szskBXKzlH5Hs8gBeuS5zSFoHf/WlYspzFKu0xQzRMndJb77UkLUnNpsu1G96rvcIYcGKzpUOGNonv7EdSgjomaROpPS0IOkApa4h+2dXOCzpM7LGnHDnQ07YiDqCQf329AhpVg41fQQQULYBu32kka8FNzgWVIxX7fyWWH4wl/0P1Nkng2NdnVAnXaMFrOL9Kx1eBKvPfyau0PrxkzKYpD/w5/y+OM0b1AXnNwu9SrmFj9zwucKSG5iCej2afFONVDZi1u6QBz/Eo+D7F/brFP/y63IJ7q/NiUfgLIiE/Hpy4cQYMo9Mv8AMPFO9eJxzR41IaQKxKM6MBK5PzR6XRAKDYVdqyRue86YAkx9cu7fYC3bN1UmbEXVeF5DJsc3kivA
X-Microsoft-Antispam-PRVS: <SN2PR03MB227255B06E3F7A50E5DFD44C9DC60@SN2PR03MB2272.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231382)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN2PR03MB2272;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2272;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2272;4:xylqlANS7uP9IthhPmFLEYrY9Z/o09FKYipG44df99hdvGaPtRntBYybAZJgDf0tChF59F1iujOOslsQ/tmLL+wBtFttAF0cSE8g4WwOyAb5H5o6RlJZbW05clxsKjZBga/4WFY6gSgcu+r12Q8Z77xEREURiKIOE6kcYhbs1E70eSLnF6HIa+7Ed7EeEtl1KBwtCfZv2IP/oK1mr+aeoSv5j+mC+Xy6Mow9Q5lGMMg//U2g9qB6YM84bKHVcXW8UjHaRm/9hLLatZ4ws2DPjyhLkhHAGKgyYGcm93+EMlb716K9S6L6b4UCf1MRRSGr
X-Forefront-PRVS: 08512C5403
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2272;23:bw3qtzevSij4PN75F+4q1rTLtH3ie5p3GgejntUEh?=
 =?us-ascii?Q?v1Xoh+JKwbmLc/e/0ZjobM3cR4mTx9KYyD2SdXS9/JXqAdkqHmgUa1yjwDXZ?=
 =?us-ascii?Q?w0DChM1u4Wpvcx48dAv6JG1NPti7qv5KTeKs1hit0nTjc8Aq7mGfq1eKyi4k?=
 =?us-ascii?Q?KMmlYNIs8B/FAefoAagd/USFjNY8tfc6RZMXCfpxa6Esjvoy1oRJDgBLp3Va?=
 =?us-ascii?Q?pNHu57TfRMX2MApTTVZUZWLiExiqoRrR7//dPzttXI6gZQWdAKJXi+pxvTU8?=
 =?us-ascii?Q?8myXgHT9fEXqFnmuAXa8CJccOJ5GSo36MeuzcRy4M6/4z9Fh9bbdIEKDDuVD?=
 =?us-ascii?Q?WqTFgJFhgAuvtb68txKywg84KEhML71X8TuE0pPAwbV4ghxPJdgSFTv2rVaL?=
 =?us-ascii?Q?hGgYIiVESDC7gCEqWZUuZL1L62l2zjHPKz6HcwFIyhQGCfEWUt5FnnwO80vs?=
 =?us-ascii?Q?704XaCzEU623j3WvJl0gJF1YfBjEiaarL9oGTiqMJULfM9gUXSH51OSueHT5?=
 =?us-ascii?Q?AJnlmjXdGqXF0jqEYjW39tllKL9heg2oFuOuFIXmKsACVbWft2NzcTHwVEWI?=
 =?us-ascii?Q?mM09zdwYsm/wgQx0O22qGfkMXDUHQRqpHmiruzFQec9K7TPLXX+97aqgpfuT?=
 =?us-ascii?Q?g6+4OE51lxIKJhJ1HNtPz9UPBufcN4R8GHZfzGSDef5rkJvzxSrJXckxtJ2l?=
 =?us-ascii?Q?lgbZ+6U1Alj+fhjODl95kK4pqT9kVMweuTZq+FZ6tshWqh27WlKgFIOC+NQg?=
 =?us-ascii?Q?h4yYBEuhEvCnB+gA0qBw7YWQSmGje3AAWMEatcIpQbX86fq4yCL3gRMa5MAy?=
 =?us-ascii?Q?lYxm4sN4kM5IFC9jZQmXqspYiw+oGmET+N/WPDdMDETMLdG2KFhg8lSdVCxi?=
 =?us-ascii?Q?u8iWZ5752Yy0rOZbRpjPEOuUG8WJGcGFdOe+oyC7E3Cj2kmXur35MPzNvW+I?=
 =?us-ascii?Q?6OEHuTRaKLhv0T+E46JbGf9Jl+5EGJh6dCoBiq37ZN8wakWcPMQIAGOq3ma6?=
 =?us-ascii?Q?kfG1q3HqPkPW+hmkiTSyiAv?=
X-Microsoft-Antispam-Message-Info: Vhi8LKGqRmpTae6TDsds5+hjWCo6fLqy5pB7nLfXmqq668vV9DMEczcNLCdn0zzERtdNDGHvQfWv9QG1JiFzfQUO8YRDSGIDe3WJ5mQdB+x+vQueguL8oqOVkfF/A1lwEIUe8gtaebUlxgzKERZqx09Ot0mg4oi8ZSY5/+FFSmAgzxkYFupOyCkHED6hkFjeKK6nZwJLNu8WJC+PAQH9VhPGza9xYd3dRi9perRjf9yxzuuSRG5eYwoD6YG4FGqrS5NGXVHa1x7/cPM6EsYC15m6X5aSI9NvJ6VYgHih+5gjCFbLGVqEeWHS+R3iZW8BZ7dznxTLnEbIy4hpPhiqp0GY3G17TcCL78/COZJxBQ8=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2272;6:EK7XCQ1r1MI4BB6OnzQOFVpi/osDHUsrypkG4zyfNXM4YofNwOhefkUzUwrqMMxXnrmIwKH1FpQUzyg7ZwpkP8IKDYOaPOGiJiIY12VvpdysI07RC/Thh3Fle8gNfMOdTWJN1UxGl8Z5Ux3eQ8Nj78GQWQgbAbPQi/i30bxnlo3zul0flxcX3f0qjP9v1+iyUapCQ9EcYyB7wE0Paig3pBju+hCMk0D/L6M5Rb2n/8j0Ylq6m+OnPTpeL//yu/zLSJrbYoVcOaNkxeZQNsMGg46s6QPqAOojSLswRW07434dJ48FXVbiSjsx/R7siJpEiUdopYzqJl0cUn6GMrC1G5x77EhHF6PODXk/2DjV3dcX76mmqaVcPQY4Qa2GCKmM52V618twcPdzjoi78OjKZIfhF8BZmXJx46GHPq6bxsU0vFaeFOzP5iE4G0MEb8leVtFTEUxLINfUD7ad4NxeZA==;5:i5Xg6N9VLJXFX4SdHlExjgy/aatZ2Klvqt625ib9qqOy9YyOQixQWvV3ko5EpnjBdEP0QCxCqPwauFzknPGMOo2004lnaSXUSZ+ifW20AnDPj6jk8C6VsOJEaZaHXrGeiINsCI1zxUVO7bMsVl2UNLf26DH2JAii6SoAwnBSRCY=;7:iZcGBFKlEJ/EAitytUJS02rU6cJ7uCP/PGUVK8ZcWbSuSmSLfWAFk0zCMp4Ev2UaSoCZcg2fZ5JoS2/Txkz4YMJI4pJMrXn1yUw+l5LLBkXG+8A9zqahgo6B2iFh3NkZbJ5T3FkuaridcshLxu0Gqw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2018 15:41:12.6754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 673799a8-2951-463a-9d61-08d64659c737
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several ADC drivers that depend on the same device tree
bindings. Rather than continue to duplicate the properties, this patch
adds a common adc binding document that can be referenced. For beginning,
only two properties are documented.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2, v3:
	- N/A.
Changes in v4:
	- Added this commit.

 Documentation/devicetree/bindings/iio/adc/adc.txt | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.txt b/Documentation/devicetree/bindings/iio/adc/adc.txt
new file mode 100644
index 0000000..1e3cc21
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adc.txt
@@ -0,0 +1,25 @@
+Common ADCs properties
+
+This binding is a work-in-progress
+
+Optional properties for child nodes:
+- bipolar : Boolean, if set the channel is used in bipolar mode.
+- diff-channels : Differential channels muxed for this ADC. The first value
+		specifies the positive input pin, the second value the negative
+		input pin.
+
+Example:
+	adc@0 {
+		compatible = "some,adc";
+		...
+		channel@0 {
+			bipolar;
+			diff-channels = <0 1>;
+			...
+		};
+
+		channel@1 {
+			diff-channels = <2 3>;
+			...
+		};
+	};
-- 
2.7.4

