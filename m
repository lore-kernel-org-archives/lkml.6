Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA2BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438C02174C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="Bhbsm2qN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438C02174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbeHGRHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:07:30 -0400
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com ([104.47.32.64]:44835
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728167AbeHGRH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkZZcdrvJoPDmuXFzK50/o/LsCX8DlpAttDmnMJSymo=;
 b=Bhbsm2qNRUFbyhhYAWuAGBbRoCH+6HPdgL20WT0hGOslLovjsSGDQvTzoAOzpFwN+p0RuamkTO+8Ot3v1ipJHG83ON4ffrymxSIMDY6NwFNWcMnwKtvhnKh+EDztl7RNcDNLYjGWgP5//fvPm8V/dV6Nhq41QI0aYIVoNL2CWys=
Received: from BN3PR03CA0096.namprd03.prod.outlook.com (2603:10b6:400:4::14)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Tue, 7 Aug
 2018 14:52:43 +0000
Received: from BL2FFO11FD015.protection.gbl (2a01:111:f400:7c09::118) by
 BN3PR03CA0096.outlook.office365.com (2603:10b6:400:4::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.15 via Frontend Transport; Tue, 7 Aug 2018 14:52:43 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD015.mail.protection.outlook.com (10.173.160.223) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1038.13 via Frontend Transport; Tue, 7 Aug 2018 14:52:42 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w77Eqfk9017129
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Tue, 7 Aug 2018 07:52:41 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 7 Aug 2018
 10:52:41 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/6] iio: accel: Add adxl372 driver
Date:   Tue, 7 Aug 2018 17:52:14 +0300
Message-ID: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(72206003)(48376002)(7696005)(336012)(4326008)(2616005)(50226002)(44832011)(51416003)(476003)(7416002)(478600001)(316002)(486006)(8936002)(186003)(126002)(5660300001)(77096007)(26005)(966005)(426003)(2906002)(16586007)(6306002)(110136005)(54906003)(36756003)(6666003)(7636002)(356003)(8676002)(106002)(47776003)(50466002)(53416004)(14444005)(246002)(305945005)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD015;1:yosfo08JllvB1bG1LycYUdH0ED7n8/Oy6HBntb4QsdrrMOTVTEX6KWHKLrlz49BHpRejQIbRK0MIm3iS6PgjeXh7lvPq/8/Bf1fcKnj2h6Dl+M6qRz7WHAFZEsdH52ZG
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a859da14-11ff-433b-ac0e-08d5fc756df3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;3:lBRQhTI0Pks8DP6xzDC6HMhkmL7i36jjOBPpzvhCj9RmTwm8iK4LkPPN2GGshg5nrB5wj2Ao7NxvXwlmweHFoFWl81jpGJjRLW2kwY07gWiUrJ2UvWd48p3O4q7mAL698jLk/RMVIbuwPiq0JB2VHDoPxHsHpJCcd/EUPVQzqjNDzcMWgR6DQYFCVg2IiIV4oFXxdpuLQsqTTBcEAxSfJ2DSLIaoP4QO1fVwCBUMtjWQBRNu8ItSrRt58Rmn+4074wZS5bSS+WuttVaT4VZQM4gE59eMrgKjHsD6qbAwx0po5+p6ZtX9I9l7TyfPwr90AeyOB+KZUNdSkiI1gLVrv9+KdoeNKzBZ0Q+lL/SHrPc=;25:hy8I/fmDcXURbdqeDq0GHgX6pQ0mOhN/tQ0EgHE7qw6MJiVC/ehCVHj3M9oKDnoshwuCGLnhUTcyzmbECWL2JCsocVz7cc6I1jpCPFtAUYVgd0azx9wrHzkH/R2LWkJSvn3Nrx6LVV4MeaNnK9BgxHc/0VvkaYETc6vRydDVRUUMH7OeHUSt8gV4KD4perD7XH9ZBbwsLYFtYrbz9cUixeoXy9UMbwfsIHC1mFrAbPu4C5Z8/bcc3G3P0O5FiNjxL1JEBzbbESpbGlLNFNIpaDzktJU9IcWarhc9zJ+O3/Ha6jzDnzW6lFvUJQ8za5iox+MMu0rv5epJUYtwgmLUcg==
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;31:U6XbuW5f36Ps02eyU6004sM7QpN+0nGMlWM9L4GavabtOEqb2w82OgYNK048adrPeVB0fjd3SsN6YIWnbIOyzfglA3cp5nHMN7940NFzGr6HmDBKFcLWfZ3W+Yg70mdm731fX8uA9iwiLbLOhM9U0XP6W2fMp6Fswx3RpeduHdHpaLjHwgmQ8tfH0x32Qf85QxTcbHWeDsCwM4g1emAkRqJW88p3EOR+oz0w7AY2bYo=;20:ZuiGO3NFEE/jGGPP64FI4Mwva5C3tDuXFYeR42VRgcHWLLlB7BP2FnsZylS6ovhvScASu8+FJ0DcfxMuk2fxVi94ZJIMt3hmKWfYkLhh+RCx7lbrxARX22sW5t1H5tmu6XLO0++YGaGe91YCnZe9USZEzI9xbLTTTRx8GHM1Amd5idq2zMIcs6x9LAB94IcOf04crsVNaMbTFOOC+ZGN7Lxbq6gGLbVuMro+t/H0JHmNFzJiEOcyd9kktwxj2bkTaceXMvZG3iXTJbB9ZpMO5tEfnaKg92avoudO16M/7f5AbxKl3ANRjLaDq/4VN1R3cCZ3T+39tVJ2s/BsmHx1n1fpBltb4GAI6IdOCs/5fmzSSDeeZn825H/QS7E31LQcEgXpMURVlO+w/hn6/UECvV2drSjzl0urJZsdvKg5DaPRbb676CVZGo89QW4s95TL9AY/GnJXXty0jPbzRHahANtaZtEx63rVu7Ka0xXIgFWFmYiQQsJnutdx/A4BUa1w
X-Microsoft-Antispam-PRVS: <BY2PR03MB5537B15652366F0BAE82A3F9D270@BY2PR03MB553.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR03MB553;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;4:g6EoleSZsZEa8Mb9uEBtNUQ5wK4l5nBN4HKlMLxZpjUiDs/ry3f+vYD516SL9rsaFjALEGb75QFynfTepkbm3cD1k+IFlvPMelIl2CzPjFjFVvKkwlRJ7CuBqbrNS9ZZ7y1kDS9qSzgL8ck2X7qpAPb6/qNlW43E9pkS3iE+AvAt7Tot37FzUpTRFn4fiPq/Qp41XIM2ckPiOvXFsWvvcWbzK6QlIG+NgMeR/fdm9OnTCtTG1qiXKjFLyMep3AZmuRSD9FU/JAMzbKGaVYZJ575CwIyXYuPe3NlewBJtoWy5JQ0NxY8rJbkynDOBCuc7
X-Forefront-PRVS: 0757EEBDCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR03MB553;23:/85WL0aMSXLueQZHtPRWIRQwm8MgOX2KuGgBnbJKxs?=
 =?us-ascii?Q?O7XkQhiRJtyG/b8Yr0O2qgk9guN+SV+vRLHFFXCqPgsb1WzaVCSQEs2JzoUY?=
 =?us-ascii?Q?k/FZU0h7GXHzJ1iaTHGuh2VOddSugwrwx7esBvWhHmw4Fki+gcbZ6Ulm43Xn?=
 =?us-ascii?Q?F20m0cOHpatyMJHW+a8Sh1xCvRZomQevm5QUCPpbij3oLEuzuuTCoYD6yZ98?=
 =?us-ascii?Q?uOBOGq1ImAO2H1GElrOrq7bWB9kw3pgVQpiAayucWQJzAyKElB/AYluVzzIv?=
 =?us-ascii?Q?ddEAZh5d5T+eOihPUCAMSbLinDg7KmoWCRiKBsK+z75IzmML93mW81lgImIX?=
 =?us-ascii?Q?qstIJ/thJ/HblkhNkL7VY9/tNjD2kL5x66xtNeLRs/I7hvBUgyTdhe1GgtJA?=
 =?us-ascii?Q?WRVnWBZ5FEJWhG8XOYDNPhBJuj2FGI58qTDnzq5F51HksYE7cG2huzsJcWwP?=
 =?us-ascii?Q?QAd0V5iaU5hu2vSJc7kOfS2QGLOKxINOzRSuj7C7XqFjDHkG+Bo+8f7yUeE+?=
 =?us-ascii?Q?UEKwHDN/dz6juOFm+IkEfLOl0aS/fj7Rg8+0UKG3rrGJ1INebwJNt+IR8QHM?=
 =?us-ascii?Q?FaAS0KiJFATY0KwCLkPndta7GR0tV6OVJvYNaod6mpotzunBAoqaNskhrOVA?=
 =?us-ascii?Q?RopPUiEpufscUcpXQOavcs4KlrTbfPtnTONcxSEe5pygZplRFf+9CSFe6q+o?=
 =?us-ascii?Q?HLBLItlucXub/IRx7xbSBcLUryl2/PDlS2XzJlpjrxpUyTgCj3jDENo/I/aZ?=
 =?us-ascii?Q?IYqMqJzZfo6vJdvh+1T0f/aM/fbxSZuqGi0GB+EAsW8VAyJ1oIcYVMA+Ty60?=
 =?us-ascii?Q?fPvihOB/B1o1k2lfvk6uOxl6FqHhdT38we5aX206dlKYwqMkk4I38glz9YiS?=
 =?us-ascii?Q?VmcS+D7w6vooduDxfrybUEK+T384GxkoszEf1RCbXJQtqwDXL72RcZI3zuZF?=
 =?us-ascii?Q?M6vKVzS8TOoeo430n+lgOBk7eE2DVi4Vzl7d3xSj5FWW5rSKtlq/7CmYX8rf?=
 =?us-ascii?Q?U3v09Zbx2CbSSl0gKM4aw3QO625wXHNvF7QQJ9AJ++FmzbtkdPyuxjVITiP8?=
 =?us-ascii?Q?kNFwX16WaQbjc2SjBwXcqYRACh?=
X-Microsoft-Antispam-Message-Info: nCCBAJWwr5u6EKlzm56O3D0bdWdrRSxx1BT6sYc1bxrJffngRbgp35uFX9/3b1zSjdMCEpWfmKJo1Gk1qpdZ0gIB55JmERFNJOReozvTTPsela4GZwlDUWcpqP0Q/U4Jaoiuc2ievZXQjRJPqbER+sZLT3ZLrVD1W4dW6Lyjlw/uVUEWynaScZFkk2zi+ctkTVc4fL70UAZQJx/JxQQlyVWEyevMu8RLl0psJGLaMUOa7Rf/EwnEcNAPNKcxVLj6N1WbE3IWy/tt+RAjw7YDb/CwflI6pyEqp9BqMzBFDd+793Y4B1lv+i/nTAYNoVSwbycKrZMqq6ggR+Aq8Ohe3N7HNEFZpgFtYm/uVk3mr/M=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;6:UYWHnMiqKm6isGPqFnKR9Ng1iZomDycz0eDuwb2QFAnqJyf3efpoXp2BHU/EsoHQzQBhibYXkw9UOHDCtQoQZGFTD0FZYv8QgBvLm1LenqZRuKqzeNafpFUziPqU8crLBgIz6ZWmHcZGrUyzrRZhjgRk/m6WPMGmGyWUTwjwgBBtPWXVl3lFNnMOC1as3EQyGhPVCaY4Yo3/PNREhBAm+VX5BWdsl9W02a4RWtChZUEe67N75kzXtBwv7PWtc8CkeV2lOvUuIdkXTnuW3IaPjxLuhhHnQY5S4BPjwcpn97uiqn84G+2Hm3E9YE8KnqTSC0AJ+QO935NTQy//rc9pPIh/20YnRQ4J7tcCf1jH0wkEnpMAw0HhGpjXlHnKk2tF5ZQ4ZVzL6jekBMGfB7RkVUrv6c+x/0D0I8lW5LxasNkTMhq8zGijYEqttWUeTBrTZujVrYT5YLM5SKqtzIoGVw==;5:m2+3b9U9Tl4UgMgvuyUVifpIyC1gcyA8nZD0HwWjlz8G4xQv7SDUoGzt8a68yysVrV+gHt8VegVz/6/fAgE+XSTrEhWSG4g6RM4dXLYTC5zEvHi6BD2GY7peXypxNqwBWLA1MnmHJL0MmZfV5sNfIX40xGurlJJXROklyjacX0c=;7:ka55tcrZf83EVjXDIPcdSk6Bw5jUwVB3IcQGEwVvtfsmJMkWJ7GYWKQjU+flAnMkJBwRk69UJCuxCUV7IEz/niSr3x1xqgxcCVdZIhoaFOjT+62IPhMHsqk3fWAlm+mq7AgP/ugnsj1p8WcyyoTw02hllN+zauAHbExPNuo2+ayWRSs6SW5sYWLWBebZVo2OakxqQvUa+8TeF6Z1ly/Z/ksvOdgNYuX6wE3cRk8fsJ7SfQeWvC5jMPWTrX4k8o1R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 14:52:42.7758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a859da14-11ff-433b-ac0e-08d5fc756df3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:
Patch 1, 2:
	- nothing changed
Patch 3:
	- added a new readable_noinc operation based on feedback from
	  Mark Brown
Patch 4:
	- added a readable_noinc callback based on the changes from the
	  previous patch.
Patch 5, 6:
	- nothing changed

Changes in v4:
Patch 1:
	- used a lookup table in adxl372_set_activity_threshold() instead
	  of a switch(case).
Patch 2: 
	- removed the interrupt-parent from the bindings.
Patch 3:
	- renamed regmap_pipe_read() stub to regmap_noinc_read().
Patch 4:
	- removed the adxl372_read_fifo() wrapper and directly called
	  regmap_noinc_read().
	- called iio_triggered_buffer_predisable() before doing the local
	  changes.
Patch 5:
	- nothing changed.
Patch 6:
	- nothing changed.

Changes in v3:
Patch 1, 2:
	- nothing changed
Patch 3:
	- changed the name from regmap_pipe_read() to regmap_noinc_read()
	- added a check for readable registers
Patch 4:
	- dropped the fifo peak mode
	- corrected the patch based on feedback from Peter Meerwald-Stadler.
Patch 5 and 6:
	- nothing changed

Changes in v2:
Patch 1:
	- removed ADXL372_RD_FLAG_MSK and ADXL372_WR_FLAG_MSK macros.
	- handled regmap read/write by setting reg_bits and pad_bits
	  fields in regmap_config struct.
	- removed the buffer specifications when defining the channels.
	- changed the activity and inactivity thresholds.
	- added two new functions for setting the activity and inactivity
	  timers: adxl372_set_inactivity_time_ms() and
	  adxl372_set_activity_time_ms().
Patch 2:
	- introduced all the DT bindings in a single patch.
Patch 3:
	- backported the patch based on this discussion: 
          https://lkml.org/lkml/2016/6/16/548.
	- this patch is required as the regmap_pipe_read() API will be used 
	  to read the data from the FIFO.
Patch 4:
	- removed DT bindings changes from this patch.
	- removed the linux/gpio/consumer.h header.
	- used regmap_pipe_read() instead of regmap_bulk_read() when
	  reading data from the FIFO.
	- used multiple regmap_write() calls instead of a single
	  regmap_bulk_write() if there is no fast path.
	- used be32_to_cpu() inside the adxl372_get_status() function.
	- added a new in_accel_x&y&z_peak scan element which allows the
	  user to set the FIFO into XYZ peak mode.
	- used a adxl372_axis_lookup_table() to determine the fifo format
	  from the active_scan_mask.
	- made IRQ optional.
Patch 5 and 6:
	- nothing changed


Crestez Dan Leonard (1):
  regmap: Add regmap_noinc_read API

Stefan Popa (5):
  iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
  dt-bindings: iio: accel: Add docs for ADXL372
  iio:adxl372: Add FIFO and interrupts support
  iio:adxl372: Add sampling frequency support
  iio:adxl372: Add filter bandwidth support

 .../devicetree/bindings/iio/accel/adxl372.txt      |  22 +
 MAINTAINERS                                        |   7 +
 drivers/base/regmap/internal.h                     |   3 +
 drivers/base/regmap/regmap.c                       |  79 +-
 drivers/iio/accel/Kconfig                          |  11 +
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/adxl372.c                        | 983 +++++++++++++++++++++
 include/linux/regmap.h                             |  19 +
 8 files changed, 1124 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
 create mode 100644 drivers/iio/accel/adxl372.c

-- 
2.7.4

