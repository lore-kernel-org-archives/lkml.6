Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BE2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2187120684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="OVu7GIIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2187120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbeGSSo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:44:26 -0400
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:10688
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733160AbeGSSoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1yXKHwXZO5ADQjCLbsrB8+8ypDBsZyEbjNT0VKuccY=;
 b=OVu7GIIP5QfN1TgaPM37hdwDkavn+r9LSteoqJnwf+p9fE/Lad2zjKcBcDNG9saLVG5dYa+WmvRgUxkiOcId0sRXfDLwCVmtThkOKDCzqT+bDWVNcWFX7yeg1SvjBiBZiwScSOall2xChNGMnYcOZTdQAJZcPFAYnDGIMEiAr9E=
Received: from SN1PR0701CA0078.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::46) by BY1PR0701MB1335.namprd07.prod.outlook.com
 (2a01:111:e400:480f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 17:59:21 +0000
Received: from DM3NAM05FT051.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::207) by SN1PR0701CA0078.outlook.office365.com
 (2a01:111:e400:52fd::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:16 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT051.mail.protection.outlook.com (10.152.98.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxARu019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:14 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:26 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:26 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAAU005694;
        Thu, 19 Jul 2018 18:59:10 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxACS005690;
        Thu, 19 Jul 2018 18:59:10 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 06/31] usb: usbssp: added template functions used by upper layer.
Date:   Thu, 19 Jul 2018 18:57:39 +0100
Message-ID: <1532023084-28083-7-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(2980300002)(189003)(199004)(36092001)(105596002)(246002)(6666003)(51416003)(26005)(48376002)(1671002)(356003)(186003)(50466002)(36756003)(106466001)(76176011)(478600001)(575784001)(26826003)(86362001)(4720700003)(87636003)(5660300001)(305945005)(16586007)(7636002)(426003)(336012)(107886003)(109986005)(50226002)(2906002)(2616005)(11346002)(446003)(126002)(476003)(8936002)(14444005)(486006)(4326008)(8676002)(47776003)(54906003)(316002)(42186006)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1335;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT051;1:xr2JvZG0xXNc29No5bZMRHaJNyf6gYnyTYhtTBTLOl8ExHD43JAKU4siy56HJ8Uk9GU2qIAOLUoCKu45Xm0E10VzMAUVft+0xZKFcTd5jdQabM+Lt7ALJ/Br6gf/cmy8
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76e619ba-e275-4abb-bada-08d5eda157cd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY1PR0701MB1335;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;3:4/ODZS2i0P3aKoTF6uJPpYsulW7KAWJ4mA0D4Vtlq/t3m+DL6lE3r1gxiH5eUWUHFnFveJ5qz1/pirqWD045GtZg3U6vzI4bDzkReUDjjjphgYMx5M4bIZ9SowTFqEKsm6lrggDtszsvQ8QGJy0YGBtLzdKG+uMU3sF9oMhmAb3e0cM7CkToJahH4bn67qi88etBt5TC2y8gB3a6mzaWSRV22G1wpl7Si+P3S3mDKZ2LWjPcPIO6i/W4xsgldu7JwOxkE5YlKi7NpeKv7+LT0YW3M6Bu6/6/IO8wu9Re0/QUQo7adJ2mUI949Ji6RtdxlThXTzcCJNOEevluOVsiIZsTunNC42mG2BXaBs3hvog=;25:oQnw13rc9+t+YhAA95/Y01ttCu5+1du7bJ78p8AqiEe8nDG+Tjc1ikMQW6h9vG9Lvep1w5vwrJ0Diotnm4mRKNCjq5DXoc8hbgJiskV1Fwgk1CDxY+TOz2qHnx1oZi2t+mJEp0Rxr9EimVG4D6WXywYDuaxwNA4JpnzC3my1jhaZLX5+GfMUqrnw2mvgL09V7gQcGAomoygVfKjMo3ZXuDPF9giRbtF827kHQoZGkSCHC4J4NUQBPqpPCrp3b5IhcE8tQ2NG518YXtZWe6rELxp/Unlqp+QKMIXwqywYnDllsjwTUzCADffyTYPUcBLkqTll0hba2J8W8So1xVZi2A==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1335:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;31:LavnoEr2XBPVylYcjKClHoARhAMfZVbTXiquZVstIfg1/U43ahFKfmd2G3G2L+RV8HKv5APyeZnHzcayZNY/8Jm0R1bIBSPPuhWPF8NdFmj/DjpQH2zQrTEMa2I7lAdZR5yujxLmn+bKUOfDdGKT5OKZRC3T/xOzoGSq+kMdWSh3vTR3fjLBUG8H0xyXFQ1+LMKabgkUGArh0tN6u63JFIde7EcBOU9xCTng8CBBQfI=;20:LbO1IA0apER73eUFmccFtoIHMY8MONSA2qtRpm0xyLvdxzjLzQG5vQ+LJexw112FeuZj00vcEvvPhveqBC378PV9Km9O36mPmqeFUHVoOQ2pPxMj6ue0k+uHmrTKxPo5m2jIeKkMeOtkSpLdopre082me5FxGEXqRPzX6HNfeWTwEglcdow3ojpZX/akw2xKDP+4RfexuySwqZGI/m/fgyoB5lCO89+Pq5oGEcEP7caYsZiUJKpOcmCyx694mOmMOeJEeCQ5EMNyVTiwrwv9c60BqfW71B55Qo7Ek8z2zpjhEl/hegbdCLsCdK8BTWGDCulyrbrKiEud/q9SAuwF1leUNAXQVob//Qw+E4XmT0RGAVO4ov2Frydo/iumLBy0n0eg9Aj/iAq2Eo53s37+4cBDHAoNXCghDZWl/dY8XEEjBCrk9Q8isuQ5c39yE+AmskAn6Nn7YXOK0EcuGtIGQsZHiqoTMZtH+f2GeEQ36AISgANOm+sPuOiMYPLZYqpW
X-Microsoft-Antispam-PRVS: <BY1PR0701MB133531AD6104A9AEF0944E72DD520@BY1PR0701MB1335.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY1PR0701MB1335;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1335;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;4:4JoBv3T5yozQkdyZmo+SYe4Shc1OhfQ4tmGueJ2P0WazNQqKF34P4uGb9mkK7pahFb8FsmpAMfKbE8tvaOqhSDNaXIUsNwR8Mg0T4oLeC72rShaRbjpPB4IvW4jH/j3jQ+6v0gJ2JEO9eZAxkgf85VqG2BG3LavpfTERv3VnVx5xdGWPDIUYqVkhkuGNDK9nu8ZHXEYvkcXXgvgOsmdmwLk283hXE4ZYJVXzY/EGaI16Y/xYSqt4xx9nPTbGmVGWqQtCfbJ5y9GdJsSL8Zv62jU9NM067Zsd4l5t5g+htHCqVHVMv5Bcf3wgZ+0AiOkLueE2Tqx4fGpmfyji4S4IBwCByAFvXG61cy/9BAzdb+g=
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1335;23:mNbqw4q0pV2/28hLP1PLNAewHCG3GT6eLDLZbyT?=
 =?us-ascii?Q?EViHoJsDunb4dgBQim9cZYeB+S6YIQRhkjS4tlF6qboJPwMInaZeVlYepvZI?=
 =?us-ascii?Q?vPFSnZeRk3BPFwQzfAtOJvNX6I4Pi9Dnjbive6Iip/8Dpsgkzr4NCDplHbC+?=
 =?us-ascii?Q?oP05k7lZoZpqRT8W4dhO+E7C175HaNvrP1yLVeMTg+JlGHqj0B9DY6vlxv0K?=
 =?us-ascii?Q?ZeaLXCWcsi4PsWBgZ/TFyqZ+pTzdaRn+evAgmZksf9ZK3lEhAHu1CFmYR+4N?=
 =?us-ascii?Q?DN4M3a+x3LTheh18CPafxQkSzkEVgc2wTLQjImagI4WTGHr1CwQ2eFxnheSJ?=
 =?us-ascii?Q?Sc9jYjhBaqJv40MjZ3lpso8bEd9XbSFqW1n1Scy6+IT3uOnRM1/3dpswIUyQ?=
 =?us-ascii?Q?yVHMBCcNaJdhyWqk0/5B7LeDsBk9wPEOWvPSLWwjnMTr+JdnJAmmH0RclB8x?=
 =?us-ascii?Q?N8h3arOVSnys4KOzFLQx0c6h/dumkFXUMZ2fbdWlym9ywx6zfRvOf+GTCSG8?=
 =?us-ascii?Q?0gDQpDo6IdZc7Tt/0xmxZlH/9JSu2QaDEgfVNLqCOj7MCdLae2Jt+qez+oXj?=
 =?us-ascii?Q?vJH2V+j5SIsFysxR204x1W0FtZQJ4DO9LBBmb7Z7BtpKduIODE5HuievDUkJ?=
 =?us-ascii?Q?+LsiR01M4k5HqkjUPb20z+oasnq/vUFkw9Wlr2YYkOgEI8sp2nDrWSgRPPrh?=
 =?us-ascii?Q?gw3E2CBFMeRvlIAqeKuOOmE/2rWyp0Ta+4J779sWYMYFrWZcbI4bNHuy1Rg5?=
 =?us-ascii?Q?Kow7bY6RSHSndaUMM9c7wbjmYHRNI/3vwvpViGNGj8ppnjRSlnHRlCXO0C6x?=
 =?us-ascii?Q?nqX9B91I/HkdNVkQiVVhFgHzgYQ6l7ruXIF8UEUWp2DuutWhOkdRrpBw6Emo?=
 =?us-ascii?Q?+8HzmB4KFbaozM760zm8HvKnPRFL2NN7MJ4cDACEY/hbX6zd65V54pDmfe0i?=
 =?us-ascii?Q?nOz0tPMW6eSAQgZiy2OgKBM7Eq1uQTiXxQ6oYKDB1Qqq2fMlirQgtdsS9GnQ?=
 =?us-ascii?Q?wpBGu1Qgx4MDE+/nN7QNZs1WXExO8Iq6C8nNHZ+bBZQ5FUQ1PIlE/0GAaolh?=
 =?us-ascii?Q?pgdj55hKXAzHpo4QdUzQ/6z65twTotqUtdfQbFsRz/KYb3/+mphhwuqIHdlR?=
 =?us-ascii?Q?BIsLr9RK7ulzrju9yZRFGQPB8qbI/d/xASuI+g64WIv0TB/kGJLvwo82m32A?=
 =?us-ascii?Q?cteu31sVxa2vtzDw=3D?=
X-Microsoft-Antispam-Message-Info: 9kBjU7iyPYTREc7vc9jQIMYvd1MkD77+tkLugKbpoL8Ik9qlD8jW4wuEy1g9AvIS5CxgTimmKD67ikCKR2ALnaEFxdgOEBkj80pUVkd1Dcq5ctbYYvjnbqarWuZq/HzNvTi3eQ2RRMxvafISpRu/8ycowVA7m67FWI7Jgh9YJyG9/D4TJ7aNvexU6LlEp8jy+1cgxpGGesWnC22kcCOmufeQCAGX/P66G89UgxV+sH92UnFKUFA+LtZxDUR48GinE+AYR51VgyMmx+JudHbitOrcyNAaGNjIprulRPHiGF2pfHlAfJRbjaLXXGrAmpOMIxAP6qrvWFTYAqQ3r3wQJ73kjlNqd2eAyLGsNZgkkHtgItxq38DYwNajm7CrNoD0z92fPaWA2D1I/1U5TaQvfw==
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;6:i1Y9lDx2fp6FvjU5c9lcyQLECB5CcKPveRf0ePWuYVbNclbcCK4d/x9BJ3j9BheGECW+2wdyMm9xdNRQe/8HEqN34dR19t+qzs6JGJXGX98drYsORJJYYUQ3R/K/koXKDTpHVmp9Apfm+WaKuERhFKYVXsHbCD3m3CqE59iKnNXIkqln9UkeJB7IJwi3EpQq01bym4Neutwu7FSxrrEFAdUNv74++Y6raxYNua2qGzjpLJhURCOj/cufRNu99qPaJBy5MgKG0buRsC1rxkuaM4KltFi3mAghYjN2dRxBCdkViWZWD2IGuA3g6XR0qsNOPIZ2nqzxlqwa6eW99xtrRGXTFhxBjHCOrLxnkR46Zs3Qco9CvATSU6H9lTz0RU40DGJTH9dX4cQdt02DZg5LqH7aXShgCTn2DZ924J/bDwwzWGYb4+LrvEKBdOqSsRHH7aC3eQKvj6Jdz2jymNkhcA==;5:Mc6Y6rX5mNfAOOnIL6uF2VoZgNbC6bnmmBzy+l/TimhdUeI7LlA/ON8xrpxww0aQXSgP7Zv6V23R3HzJKkaypkLhDLAyUI2X0QmowSHMhURPzjwfF7uh+j6C6UYtmas0OS4OtGm+1V59RV0pzqLiSErwVXnjGeRBSZ2nC+C6ysw=;7:SCMWZ5kMGJxmYf8ht5gCTDSbnTRIA3MVnzpJgy+9Dr8C2GgqW7zGIdQcuBRvcrFODhxmEwrrRShXbhIlENpe4gXKoG3jXvEQYP+Zjj1z1aTHn52HwHLvT6k3xkjPq1SQ7hSjvfTYRFVjOfrF8x4RWIN6pxiGbdwEX4ZiEcRH2VD2A3rKktCqq9Jxx6agDOn7FVf5as1idvGywQhPksyb6RNjTDnChyn5ofM2q9+D7dMyfCHQvcGi3AlDxx8P9vgF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1335;20:AVklWDpp7Ou8Pm+l5TPDwH0GP2zc1wDLlDorD74JN9ri9RRx6oLsc5K+9THsoRLb1FEfHgQmYF09iLS11vx3yJT0djOQngDegbRZy3I5pANok5qVXZIrt11rx+ece1VU3sM1eZ+XZaAuNJYet2DMVDW6RdAto7gG5OmFAVNuIigGTtca5ra8hap7RkUlHCc1ii6xt87qgW680O9NqU4Mf4kKeo26A/rQFAtRsAa6RlufXnWgcZtu3qbwq7qF+45a
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:15.8442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e619ba-e275-4abb-bada-08d5eda157cd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1335
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds some functionality for initialization process.
It adds to driver usbssp_reset and usbssp_start function.

Next elements added are objects usbssp_gadget_ep0_ops,
usbssp_gadget_ep_ops and usbssp_gadget_ops. These objects
constitute the interface used by gadget subsystem.
At this moment functions related to these objects are empty
and do nothing.

This patch also implements usbssp_gadget_init_endpoint and
usbssp_gadget_free_endpoint used during initialization.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ext-caps.h |   3 +
 drivers/usb/usbssp/gadget-if.c       | 269 ++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.c          |  84 ++++++++-
 3 files changed, 350 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-ext-caps.h b/drivers/usb/usbssp/gadget-ext-caps.h
index 2bf327046376..86c0ce331037 100644
--- a/drivers/usb/usbssp/gadget-ext-caps.h
+++ b/drivers/usb/usbssp/gadget-ext-caps.h
@@ -51,3 +51,6 @@
 #define USBSSP_CMD_EWE			BIT(10)
 
 #define USBSSP_IRQS	(USBSSP_CMD_EIE | USBSSP_CMD_HSEIE | USBSSP_CMD_EWE)
+
+/* true: Controller Not Ready to accept doorbell or op reg writes after reset */
+#define USBSSP_STS_CNR			BIT(11)
diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index d53e0fb65299..70def978b085 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -12,13 +12,278 @@
 #include <linux/usb/composite.h>
 #include "gadget.h"
 
+static int usbssp_gadget_ep_enable(struct usb_ep *ep,
+				   const struct usb_endpoint_descriptor *desc)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+int usbssp_gadget_ep_disable(struct usb_ep *ep)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+static struct usb_request *usbssp_gadget_ep_alloc_request(struct usb_ep *ep,
+							  gfp_t gfp_flags)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+
+	if (!ep_priv)
+		return NULL;
+
+	/*TODO: implements this function*/
+	return NULL;
+}
+
+static void usbssp_gadget_ep_free_request(struct usb_ep *ep,
+					  struct usb_request *request)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+
+	if (!ep_priv)
+		return;
+
+	/*TODO: implements this function*/
+}
+
+static int usbssp_gadget_ep_queue(struct usb_ep *ep,
+				  struct usb_request *request,
+				  gfp_t gfp_flags)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+static int usbssp_gadget_ep_dequeue(struct usb_ep *ep,
+				    struct usb_request *request)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+static int usbssp_gadget_ep_set_halt(struct usb_ep *ep, int value)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+static int usbssp_gadget_ep_set_wedge(struct usb_ep *ep)
+{
+	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	int ret = 0;
+
+	if (!ep_priv)
+		return -EINVAL;
+
+	/*TODO: implements this function*/
+	return ret;
+}
+
+static const struct usb_ep_ops usbssp_gadget_ep0_ops = {
+	.enable		= usbssp_gadget_ep_enable,
+	.disable	= usbssp_gadget_ep_disable,
+	.alloc_request	= usbssp_gadget_ep_alloc_request,
+	.free_request	= usbssp_gadget_ep_free_request,
+	.queue		= usbssp_gadget_ep_queue,
+	.dequeue	= usbssp_gadget_ep_dequeue,
+	.set_halt	= usbssp_gadget_ep_set_halt,
+	.set_wedge	= usbssp_gadget_ep_set_wedge,
+};
+
+static const struct usb_ep_ops usbssp_gadget_ep_ops = {
+	.enable		= usbssp_gadget_ep_enable,
+	.disable	= usbssp_gadget_ep_disable,
+	.alloc_request	= usbssp_gadget_ep_alloc_request,
+	.free_request	= usbssp_gadget_ep_free_request,
+	.queue		= usbssp_gadget_ep_queue,
+	.dequeue	= usbssp_gadget_ep_dequeue,
+	.set_halt	= usbssp_gadget_ep_set_halt,
+	.set_wedge	= usbssp_gadget_ep_set_wedge,
+};
+
+static struct usb_endpoint_descriptor usbssp_gadget_ep0_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+	.bmAttributes =		USB_ENDPOINT_XFER_CONTROL,
+};
+
+static int usbssp_gadget_start(struct usb_gadget *g,
+			       struct usb_gadget_driver *driver)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+	int ret = 0;
+
+	if (usbssp_data->gadget_driver) {
+		dev_err(usbssp_data->dev, "%s is already bound to %s\n",
+				usbssp_data->gadget.name,
+				usbssp_data->gadget_driver->driver.name);
+		ret = -EBUSY;
+	}
+
+	/*TODO: add implementation*/
+	return ret;
+}
+
+static int usbssp_gadget_stop(struct usb_gadget *g)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+
+	if (!usbssp_data)
+		return -EINVAL;
+	/*TODO: add implementation*/
+	return 0;
+}
+
+static int usbssp_gadget_get_frame(struct usb_gadget *g)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+
+	if (!usbssp_data)
+		return -EINVAL;
+
+	/*TODO: add implementation*/
+	return 0;
+}
+
+static int usbssp_gadget_wakeup(struct usb_gadget *g)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+
+	if (!usbssp_data)
+		return -EINVAL;
+
+	/*TODO: add implementation*/
+	return 0;
+}
+
+static int usbssp_gadget_set_selfpowered(struct usb_gadget *g,
+					 int is_selfpowered)
+{
+	struct usbssp_udc *usbssp_data = gadget_to_usbssp(g);
+
+	if (!usbssp_data)
+		return -EINVAL;
+
+	/*TODO: add implementation*/
+	return 0;
+}
+
+static const struct usb_gadget_ops usbssp_gadget_ops = {
+	.get_frame		= usbssp_gadget_get_frame,
+	.wakeup			= usbssp_gadget_wakeup,
+	.set_selfpowered	= usbssp_gadget_set_selfpowered,
+	.udc_start		= usbssp_gadget_start,
+	.udc_stop		= usbssp_gadget_stop,
+};
+
 int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data)
 {
-	/*TODO: it has to be implemented*/
+	int i = 0;
+	struct usbssp_ep *ep_priv;
+
+	usbssp_data->num_endpoints = USBSSP_ENDPOINTS_NUM;
+	INIT_LIST_HEAD(&usbssp_data->gadget.ep_list);
+
+	for (i = 1; i < usbssp_data->num_endpoints; i++) {
+		bool direction = i & 1; /*start from OUT endpoint*/
+		u8 epnum = (i >> 1);
+
+		ep_priv = &usbssp_data->devs.eps[i-1];
+		ep_priv->usbssp_data = usbssp_data;
+		ep_priv->number = epnum;
+		ep_priv->direction = direction; /*0 for OUT, 1 for IN*/
+
+		snprintf(ep_priv->name, sizeof(ep_priv->name), "ep%d%s", epnum,
+				(ep_priv->direction) ? "in" : "out");
+
+		ep_priv->endpoint.name = ep_priv->name;
+
+		if (ep_priv->number < 2) {
+			ep_priv->endpoint.desc = &usbssp_gadget_ep0_desc;
+			ep_priv->endpoint.comp_desc = NULL;
+		}
+
+		if (epnum == 0) {
+			/*EP0 is bidirectional endpoint*/
+			usb_ep_set_maxpacket_limit(&ep_priv->endpoint, 512);
+			dev_dbg(usbssp_data->dev,
+				"Initializing %s, MaxPack: %04x Type: Ctrl\n",
+				ep_priv->name, 512);
+			ep_priv->endpoint.maxburst = 1;
+			ep_priv->endpoint.ops = &usbssp_gadget_ep0_ops;
+			ep_priv->endpoint.caps.type_control = true;
+
+			usbssp_data->usb_req_ep0_in.epnum = ep_priv->number;
+			usbssp_data->usb_req_ep0_in.dep = ep_priv;
+
+			if (!epnum)
+				usbssp_data->gadget.ep0 = &ep_priv->endpoint;
+		} else {
+			usb_ep_set_maxpacket_limit(&ep_priv->endpoint, 1024);
+			ep_priv->endpoint.maxburst = 15;
+			ep_priv->endpoint.ops = &usbssp_gadget_ep_ops;
+			list_add_tail(&ep_priv->endpoint.ep_list,
+					&usbssp_data->gadget.ep_list);
+			ep_priv->endpoint.caps.type_iso = true;
+			ep_priv->endpoint.caps.type_bulk = true;
+			ep_priv->endpoint.caps.type_int = true;
+
+		}
+
+		ep_priv->endpoint.caps.dir_in = direction;
+		ep_priv->endpoint.caps.dir_out = !direction;
+
+		dev_dbg(usbssp_data->dev, "Init %s, MaxPack: %04x SupType:"
+				" INT/BULK/ISOC , SupDir %s\n",
+				ep_priv->name, 1024,
+				(ep_priv->endpoint.caps.dir_in) ? "IN" : "OUT");
+
+		INIT_LIST_HEAD(&ep_priv->pending_list);
+	}
 	return 0;
 }
 
 void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data)
 {
-	/*TODO: it has to be implemented*/
+	int i;
+	struct usbssp_ep *ep_priv;
+
+	for (i = 0; i < usbssp_data->num_endpoints; i++) {
+		ep_priv = &usbssp_data->devs.eps[i];
+
+		if (ep_priv->number != 0)
+			list_del(&ep_priv->endpoint.ep_list);
+	}
 }
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 338ec2ec18b1..195f5777cf8a 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -103,6 +103,83 @@ int usbssp_halt(struct usbssp_udc *usbssp_data)
 	return ret;
 }
 
+/*
+ * Set the run bit and wait for the device to be running.
+ */
+int usbssp_start(struct usbssp_udc *usbssp_data)
+{
+	u32 temp;
+	int ret;
+
+	temp = readl(&usbssp_data->op_regs->command);
+	temp |= (CMD_RUN | CMD_DEVEN);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Turn on USBSSP, cmd = 0x%x.", temp);
+	writel(temp, &usbssp_data->op_regs->command);
+
+	/*
+	 * Wait for the HCHalted Staus bit to be 0 to indicate the device is
+	 * running.
+	 */
+	ret = usbssp_handshake(&usbssp_data->op_regs->status,
+			STS_HALT, 0, USBSSP_MAX_HALT_USEC);
+
+	if (ret == -ETIMEDOUT)
+		dev_err(usbssp_data->dev, "Device took too long to start, waited %u microseconds.\n",
+			USBSSP_MAX_HALT_USEC);
+	if (!ret)
+		/* clear state flags. Including dying, halted or removing */
+		usbssp_data->usbssp_state = 0;
+
+	return ret;
+}
+
+/*
+ * Reset a halted DC.
+ *
+ * This resets pipelines, timers, counters, state machines, etc.
+ * Transactions will be terminated immediately, and operational registers
+ * will be set to their defaults.
+ */
+int usbssp_reset(struct usbssp_udc *usbssp_data)
+{
+	u32 command;
+	u32 state;
+	int ret;
+
+	state = readl(&usbssp_data->op_regs->status);
+
+	if (state == ~(u32)0) {
+		dev_warn(usbssp_data->dev, "Device not accessible, reset failed.\n");
+		return -ENODEV;
+	}
+
+	if ((state & STS_HALT) == 0) {
+		dev_warn(usbssp_data->dev, "DC not halted, aborting reset.\n");
+		return 0;
+	}
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init, "// Reset the DC");
+	command = readl(&usbssp_data->op_regs->command);
+	command |= CMD_RESET;
+	writel(command, &usbssp_data->op_regs->command);
+
+	ret = usbssp_handshake(&usbssp_data->op_regs->command,
+			CMD_RESET, 0, 10 * 1000 * 1000);
+
+	if (ret)
+		return ret;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+		"Wait for controller to be ready for doorbell rings");
+	/*
+	 * USBSSP cannot write to any doorbells or operational registers other
+	 * than status until the "Controller Not Ready" flag is cleared.
+	 */
+	ret = usbssp_handshake(&usbssp_data->op_regs->status,
+			STS_CNR, 0, 10 * 1000 * 1000);
+
+	return ret;
+}
 
 /*
  * Initialize memory for gadget driver and USBSSP (one-time init).
@@ -179,8 +256,7 @@ int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
 
 	dev_dbg(usbssp_data->dev, "Resetting Device Controller\n");
 	/* Reset the internal DC memory state and registers. */
-	/*TODO: add implementation of usbssp_reset function*/
-	//retval = usbssp_reset(usbssp_data);
+	retval = usbssp_reset(usbssp_data);
 	if (retval)
 		return retval;
 	dev_dbg(usbssp_data->dev, "Reset complete\n");
@@ -244,8 +320,7 @@ int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
 	BUILD_BUG_ON(sizeof(struct usbssp_run_regs) != (8+8*128)*32/8);
 
 	/* fill gadget fields */
-	/*TODO: implements usbssp_gadget_ops object*/
-	//usbssp_data->gadget.ops = &usbssp_gadget_ops;
+	usbssp_data->gadget.ops = &usbssp_gadget_ops;
 	usbssp_data->gadget.name = "usbssp-gadget";
 	usbssp_data->gadget.max_speed = USB_SPEED_SUPER_PLUS;
 	usbssp_data->gadget.speed = USB_SPEED_UNKNOWN;
@@ -288,6 +363,7 @@ int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
 	usbssp_halt(usbssp_data);
 	/*TODO add implementation of usbssp_reset function*/
 	//usbssp_reset(usbssp_data);
+	usbssp_reset(usbssp_data);
 	/*TODO add implementation of freeing memory*/
 	//usbssp_mem_cleanup(usbssp_data);
 err3:
-- 
2.17.1

