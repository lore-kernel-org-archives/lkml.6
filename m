Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEFDC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A3220880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="k01reNPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A3220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbeLMMrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:47:43 -0500
Received: from mail-eopbgr690080.outbound.protection.outlook.com ([40.107.69.80]:52444
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729325AbeLMMrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIuDc2p4Wg6155HhYi/duNdPe4tKG9vvVS0ahAu1iDs=;
 b=k01reNPbDRBnHI6Hyj7fkvWd2dsS75TeVDCorzMhm0bW2iAAbOXvDwEZ4qvmP37UtzG9MCwXYb4vnr34A5G81U9XO266Vmiv2uffFL8IpyGDKMWA2SHpy1FkCMDl7+bM3Sqzsn79fZempg59rLjJ3qMc3n0DaMA3iIML/fRYr0s=
Received: from CY4PR03CA0097.namprd03.prod.outlook.com (2603:10b6:910:4d::38)
 by BN6PR03MB3122.namprd03.prod.outlook.com (2603:10b6:405:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.20; Thu, 13 Dec
 2018 12:47:37 +0000
Received: from BN1AFFO11FD017.protection.gbl (2a01:111:f400:7c10::125) by
 CY4PR03CA0097.outlook.office365.com (2603:10b6:910:4d::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1425.18 via Frontend Transport; Thu, 13 Dec 2018 12:47:36 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BN1AFFO11FD017.mail.protection.outlook.com (10.58.52.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1425.16
 via Frontend Transport; Thu, 13 Dec 2018 12:47:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id wBDClalS004268
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 13 Dec 2018 04:47:36 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 13 Dec 2018 07:47:36 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     Stefan Popa <stefan.popa@analog.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: [PATCH 09/11] staging: iio: adc: ad7606: Misc style fixes (no functional change)
Date:   Thu, 13 Dec 2018 14:46:21 +0200
Message-ID: <1544705183-13288-10-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(3190300001)(189003)(199004)(305945005)(336012)(575784001)(14444005)(110136005)(47776003)(106466001)(186003)(72206003)(2906002)(6666004)(4326008)(426003)(356004)(478600001)(44832011)(26005)(5660300001)(50226002)(7416002)(486006)(106002)(116002)(126002)(2616005)(77096007)(476003)(50466002)(48376002)(76176011)(51416003)(8936002)(36756003)(316002)(54906003)(11346002)(16586007)(446003)(7696005)(7636002)(8676002)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3122;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD017;1:qVM9zPHB2CkCBoxrehLwOW3op3TbBlnZMZg63vyK3I/UUIIaA8mJtXBSvVgOTktuTt3T3lB+HU912mGjNIZLPNgmJ1wtpi9gUWdcS2IHlM/Rqvq+BwtTeQWb7HGjUV3S
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bc93bc5-bd6a-4167-9850-08d660f928e3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN6PR03MB3122;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3122;3:euoxyid9AAwzY5Z7p7of7BP+HfXEOXNB4AVP+W7c5VG3kVEOkuHzSoInbaY9FngvqAZvMkXf1fR/Cg5k75MbK6gP5yAeWaFGUvizjdYVzoj+b950GQ1WjvUYouUqzQhtu0ZBMcWjx1MfR7E0J/vS1eq5beHYbDtSCWN87NlnB+C+79plTqLgscuy3FRn+igkW7673C1wQ1J0Cl3bS0gkAGZ4JJ47ZdS67v921WTiMuOL6+jlwxAbHMdp29/WtZKQMRz0Vcvwn6jNPi+qXMgOgvaLk1xlKZdRczwb7tXsLW/3c3vTyFbo7hlRs8c8xmZyxne3kno/30HRf1HZBp78rzS2U2LjnJpAsATzJdUE6Mo=;25:6IEVBm0EOMUJqk6SO4d2ux7qnG7dqr5Seq5vEi/nkvtKgLbCgQnLZ06gft+a1CcuhDqU3QDQy6/vZWN8h1qzpEGb/NDijhmYVJ4eDWXDr8Y984Xxxn2DJtwbrqamGYnPsQNTb2r9OLgyEwXjJKh9gZU/Vzi+8dSJxXQdZNfwWwj8s88E6xr/kr1ktHcbQs2sEF6iDohtjrmPJdQQS5ItAoy7m+0u0Iu+rYqnnS0SJnf/IWeHWHchs0pkELJHI+iI/y71dYOPJxBNYhKZvjhGzqCqE2cmNIWjfwWFXQmihM+q3aQaq4qXVscleEsPh3Hog7C5nejaY+nGEKMgsTRqQg==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3122:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3122;31:YcwWHVQUaZMqD1ecuJUBDgJ1OxUcO/okFnc/JDm6xh9LH2QQLh+obuAUA5jxVVwT+WGG57obLs2MX0JCjEthMEUc/HBFCVtn/h7r3S1JcrovkQm3UXsqaa8K59xRoOzfKnklF1H3vIQ4PI+ciYWJ798Zvrak2QPur8nORRViE1PoTcFXwYOnI/Eqev67D2PSHY1j5g1ErEUahtx8iZSQHRJqli9/SSntWJ6ASVCYfXA=;20:Fd+Rm6TIEnlDIO+Ywuc/ngAP4TMysB6HYVynDx/0x1L93m9Q6oPdrW+CB98wdgzgWN3NubXyZb8xc1v+sLynjyxK8g7zyKOM/W+jZzr1pDoNMO8WIT4Hj4FFKjNK9/gQttDRNS+WKwij8LN2ncCqUPK0S92cRHG4ypU+DreDj4eHdcWziGDt7+sBQhgaxt1Ra5ypeJk5Z+pK5ClXQFOP9MFJZK2G0cdgyX/SZlgcQR/ED8c5H5nIi3WPy4I9giEuB3NngaPYuwzHryy2n0GA7S1WFV73rwpjALbGNm9b6J7OTTLRdY9U5J3TbPaIYXmsdiVdteQuncV3JtSBA4INJkC+k+HmxeO0YOvxy41fLP3rJZqEOYIT0M9zOU+3N2VMSfubPBjcfdhtiGImE7oAVdMvf2nEKeSHqEHpksQfZIoSzy8wB9yYntuFNhSx/IruSSgTYVuqtXD1Fp77w6NGpdyGRYVfykrEAWhw5RGRyRrujm/p5iwYEh17MLjCFJHu
X-Microsoft-Antispam-PRVS: <BN6PR03MB3122C42B4D412847F4F786FB9DA00@BN6PR03MB3122.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN6PR03MB3122;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3122;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3122;4:Y9yd8ICbS/NoniyKtx+y26oSPw90um4UPq/jiLYn7/rCPG8io0+1QavJmcGmin+YMyNAuAykBkJZ4c3wpnBbcTH+5orZ4DKBHTGTJAdnDhbyTvKn6Xzb+ILsV+1V/PpAO6eJNVL31WzrJq8Sevuq19Tc7xcWwfq65S04lIZlRz5ViA82PYKgEcpnqXW7ewBWlpiwQeTCdgSG4tLigPyzEtFGDXPIBljcX3M+GQvagvHqluif6StZ74XIGTa9wuNDl9Qb6kyzOAhA42/jljnRSQ==
X-Forefront-PRVS: 088552DE73
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB3122;23:ExawDKdVzD/aUYrynpCl6bHAYTPyMvTVgOWq/CT1J?=
 =?us-ascii?Q?2I8OJFUVz/BKeEFp7MFluUj1zShHDts0LkSBG2ZXfml1TFhUeuxNp436bhoN?=
 =?us-ascii?Q?0GgzJZHPYPxQA6LapG05PaA9HsoFLwYW8JaQglDGFRAQ7/MdOJBSPWYVeb7t?=
 =?us-ascii?Q?ayosSrq/cqU2yACix5vFovIc3I5/a7C554nE1az4htNfaEHi6k4alBq/mXpP?=
 =?us-ascii?Q?IXNyax3efMTuw7TgCPcT+dlUHfiRoJbaH4jwlqZ0Ut9JpOEIOiQg1Z4+ona5?=
 =?us-ascii?Q?Fe3U9+MTev9Cd9aHZbn+/ugXyTiK7xaZFNOIoqwzCi3SYhubcKkvnvaLIoWu?=
 =?us-ascii?Q?+8y9DoCJ9U4S0JePx5ngBnxx14XWl8SDUJ0/d1L8BjFgJJjkcGVcJlsJMHe1?=
 =?us-ascii?Q?xMqCSdmCwffl/5ujmeH4cyQEloA9Fvl5OLNfSZQ4lRUsQVtwLjJmamZvAFqp?=
 =?us-ascii?Q?pJ4ERiQ6YmxLF9H+UwxuLS2VHf8kNGY2d+lqSh5IRXQAPRS4Vgh6AInYsbHi?=
 =?us-ascii?Q?JOWEJA5MPGjxv4ljnpthLC8JqRqzYgSMugvrsN4S0IwK1B6ZAtfBVGejjp0g?=
 =?us-ascii?Q?SrecHhNqoFXuWoEK5XZUTNNUGiFyFNWckGPTlAAorjjj6hhyy3V1IQVapKXn?=
 =?us-ascii?Q?qb8vOu9DP3YSOFMeSOyKwSw3fN6kU8TgC1ImMfgd6d0siIkF/TrmL5HK2kaC?=
 =?us-ascii?Q?Iw7oqfrlGN0vdkg04P7264UFNi/HGxTiefSqx/YjOQBHfnH/D64Kz8tX4vJ+?=
 =?us-ascii?Q?0mLAFzvUZdOe6YPQatbYvvMzO4EQhap16Br71rAXE5nN+3XnvZb4qUOaH0cW?=
 =?us-ascii?Q?XSdbFzJyxjYX/EgxzeXga/439xiYCwYhXdquISduvbHtcnAa4KHa5LL1LJh0?=
 =?us-ascii?Q?qLbQRq3olhFD9NT6LeHsAPDtn5JXPt1KOyKX8ohlbmr63g7m50K4F8MEbNY0?=
 =?us-ascii?Q?VfHSsVZUolgSoXGAm/0kKbDgjZm0gu+jh/GEo4yLdFzLZJMR/yZZ3YWbjiXJ?=
 =?us-ascii?Q?JOJVCCKyxi0L47hNnm/AT3art04sBn27fuwqS8hIRMYJCEeXP8Srk/LyuuW9?=
 =?us-ascii?Q?fAGSuHe2qAE2r299JbHo9XKtyLKyWe4wgG/A3QxUZZwUsq0t1NzUd1rGaa8S?=
 =?us-ascii?Q?sDatGB8n8s=3D?=
X-Microsoft-Antispam-Message-Info: MAVrkgGRiyZE1iIZmiQqPWFQA0SJCKCi9r4JnmqqbZTkRDEdEseVBvgeDTw2Ajhk2nSsbWMJZQv709L2Z6rLd09Kx4w5VFj9HKgIETzTtgW8BQywOWUSNzRYmr9xVvs6vcqjMC48J4aXnOXaHH7/6NpDeypcckbVDCVTNcuqa62GWfeI4iZBijmS83ivdrlRa34WJTIcY8CMGFuL2/jj3ZKcYdSeHUV4AbRKyiZpSdRbJn4t4Vn4UG4tBL+KGG53HokQo1W0Tc01S+IgLzklQUjJq70aIYItrOXXiRmyO/oOj0VYypvT7Pwhs7mVqT6J
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3122;6:X2cExL446kCIMm+w+XQHMZMH+ZkwLJKQDAE2X1+oGjAHejriCCkSQWicvhemi0qop0rN02Q0QnvGiGDT6u4/ZTWcmTLaN4CXg1vn4HVrbYNDurG6PwzNxy+csQMPQuuYZF+J3XsOOeuVXo4Od1cO7KMuHSltaNw6XpgtklX43wtvNP5CD6q46EkQqnJbUx7SB9akj4d+a8lgbas3oLAG9S9AJj3OCFnfwUgyDMfJcUco49JemWtf6s2NT4ejr4GcS0I1+nqMyX1aghCbRJA+Nc/0m63SFchfz9VTZ0Yr1XJ4uGiSa+xSD52rCCuVu65kXFZ7bT5w7VNaA4rNJjgjVoX1mDyhnn0w++TN/jPPBaQZ+AD3tSb5YUB1JrCUGZsIJeEUPb9gG27KGfSJejJ6kIiVXPypArUAXo3IfAjDf4smo7Xp5yAbJz4YfltMTl0Nw9M2Wjajkv1Ye7kVc5J4BQ==;5:6kDIMJZNFyImPeES4Nk8dMZtiCtXIKZcIK6C1gX7ruqqufrvBSzD56KfoW99oZpoNmBrGdUOknMQ5hCZKMgPz/SEYyDRM29Z/RCRmFavHrfw51kipQpYO7pbG9RrHZhvuz1fnNA5vuF3yvpwQWCW2+BMkLzPCDoyxqY5VUPtOq8=;7:sQxchNN9jDpe50eBXrcX5GjArgnTRz9lqUXyX1pzZiwvsUXO2uHHqZoer2/80xOxzq37P9awvUDJp2mGBpb321196+ZuAwLBA6KQ4L4jB7xZMl6HUStaFvnziLWKf0eiXjErnHmt9k5LYz3IJG3MWw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2018 12:47:36.7537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc93bc5-bd6a-4167-9850-08d660f928e3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Placed includes in alphabetical order
* Added brackets around num and mask through out for AD760X_CHANNEL
* Used single line comments where needed
* Removed extra lines and spaces

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/staging/iio/adc/ad7606.c     | 27 ++++++++++++---------------
 drivers/staging/iio/adc/ad7606.h     |  1 -
 drivers/staging/iio/adc/ad7606_par.c | 27 ++++++++-------------------
 drivers/staging/iio/adc/ad7606_spi.c | 16 ++++++++--------
 4 files changed, 28 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 3355301..5733760 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -5,25 +5,25 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
-#include <linux/delay.h>
-#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/util_macros.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #include "ad7606.h"
 
@@ -249,8 +249,7 @@ static const struct attribute_group ad7606_attribute_group_range = {
 	.attrs = ad7606_attributes_range,
 };
 
-#define AD760X_CHANNEL(num, mask)				\
-	{							\
+#define AD760X_CHANNEL(num, mask) {				\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = num,					\
@@ -265,7 +264,7 @@ static const struct attribute_group ad7606_attribute_group_range = {
 			.storagebits = 16,			\
 			.endianness = IIO_CPU,			\
 		},						\
-	}
+}
 
 #define AD7605_CHANNEL(num)	\
 	AD760X_CHANNEL(num, 0)
@@ -294,9 +293,7 @@ static const struct iio_chan_spec ad7606_channels[] = {
 };
 
 static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
-	/*
-	 * More devices added in future
-	 */
+	/* More devices added in future */
 	[ID_AD7605_4] = {
 		.channels = ad7605_channels,
 		.num_channels = 5,
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index b238e9b..40433af 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -14,7 +14,6 @@
  * @num_channels:	number of channels
  * @has_oversampling:   whether the device has oversampling support
  */
-
 struct ad7606_chip_info {
 	const struct iio_chan_spec	*channels;
 	unsigned int			num_channels;
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index ac0c7b0..32c7069 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -26,7 +26,7 @@ static int ad7606_par16_read_block(struct device *dev,
 }
 
 static const struct ad7606_bus_ops ad7606_par16_bops = {
-	.read_block	= ad7606_par16_read_block,
+	.read_block = ad7606_par16_read_block,
 };
 
 static int ad7606_par8_read_block(struct device *dev,
@@ -41,7 +41,7 @@ static int ad7606_par8_read_block(struct device *dev,
 }
 
 static const struct ad7606_bus_ops ad7606_par8_bops = {
-	.read_block	= ad7606_par8_read_block,
+	.read_block = ad7606_par8_read_block,
 };
 
 static int ad7606_par_probe(struct platform_device *pdev)
@@ -72,22 +72,12 @@ static int ad7606_par_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id ad7606_driver_ids[] = {
-	{
-		.name		= "ad7605-4",
-		.driver_data	= ID_AD7605_4,
-	}, {
-		.name		= "ad7606-8",
-		.driver_data	= ID_AD7606_8,
-	}, {
-		.name		= "ad7606-6",
-		.driver_data	= ID_AD7606_6,
-	}, {
-		.name		= "ad7606-4",
-		.driver_data	= ID_AD7606_4,
-	},
+	{ .name	= "ad7605-4", .driver_data = ID_AD7605_4, },
+	{ .name	= "ad7606-4", .driver_data = ID_AD7606_4, },
+	{ .name	= "ad7606-6", .driver_data = ID_AD7606_6, },
+	{ .name	= "ad7606-8", .driver_data = ID_AD7606_8, },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
 
 static const struct of_device_id ad7606_of_match[] = {
@@ -103,12 +93,11 @@ static struct platform_driver ad7606_driver = {
 	.probe = ad7606_par_probe,
 	.id_table = ad7606_driver_ids,
 	.driver = {
-		.name	 = "ad7606",
-		.pm	 = AD7606_PM_OPS,
+		.name = "ad7606",
+		.pm = AD7606_PM_OPS,
 		.of_match_table = ad7606_of_match,
 	},
 };
-
 module_platform_driver(ad7606_driver);
 
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index 2608d34..b628389 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -36,7 +36,7 @@ static int ad7606_spi_read_block(struct device *dev,
 }
 
 static const struct ad7606_bus_ops ad7606_spi_bops = {
-	.read_block	= ad7606_spi_read_block,
+	.read_block = ad7606_spi_read_block,
 };
 
 static int ad7606_spi_probe(struct spi_device *spi)
@@ -48,14 +48,14 @@ static int ad7606_spi_probe(struct spi_device *spi)
 			    &ad7606_spi_bops);
 }
 
-static const struct spi_device_id ad7606_id[] = {
-	{"ad7605-4", ID_AD7605_4},
-	{"ad7606-8", ID_AD7606_8},
-	{"ad7606-6", ID_AD7606_6},
-	{"ad7606-4", ID_AD7606_4},
+static const struct spi_device_id ad7606_id_table[] = {
+	{ "ad7605-4", ID_AD7605_4 },
+	{ "ad7606-4", ID_AD7606_4 },
+	{ "ad7606-6", ID_AD7606_6 },
+	{ "ad7606-8", ID_AD7606_8 },
 	{}
 };
-MODULE_DEVICE_TABLE(spi, ad7606_id);
+MODULE_DEVICE_TABLE(spi, ad7606_id_table);
 
 static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7605-4" },
@@ -73,7 +73,7 @@ static struct spi_driver ad7606_driver = {
 		.pm = AD7606_PM_OPS,
 	},
 	.probe = ad7606_spi_probe,
-	.id_table = ad7606_id,
+	.id_table = ad7606_id_table,
 };
 module_spi_driver(ad7606_driver);
 
-- 
2.7.4

