Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FEDC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB2920875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YxMsD2OC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB2920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeGLF4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:05 -0400
Received: from mail-eopbgr720067.outbound.protection.outlook.com ([40.107.72.67]:16928
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732341AbeGLF4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEmFkskWXXHaB65ByRuB/JD9wRG0VEqhePhRIoTWHHM=;
 b=YxMsD2OCF5WMR1Ed9qwJAU0/tz66dJOlqwVmwLD/B3rJtJL/8Ymkn4rH8Vxu5Qs+8qRQ0G7cjFbXJC7FUR55Sv7ziedOJ/tnunlyFpkti/lYdePc4DHHmXp1xbYspwVOqQ5V4nxRGzOVicTKAHsTiMLsosF1t12aZKeLwEx/6wM=
Received: from SN1PR0701CA0001.namprd07.prod.outlook.com
 (2a01:111:e400:5173::11) by BYAPR07MB4712.namprd07.prod.outlook.com
 (2603:10b6:a02:f0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 05:48:06 +0000
Received: from DM3NAM05FT009.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::209) by SN1PR0701CA0001.outlook.office365.com
 (2a01:111:e400:5173::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:05 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT009.mail.protection.outlook.com (10.152.98.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUZ017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:48:04 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:09 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:09 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lrmW029914;
        Thu, 12 Jul 2018 06:47:53 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lrBT029913;
        Thu, 12 Jul 2018 06:47:53 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 29/31] usb: usbssp: added support for LPM.
Date:   Thu, 12 Jul 2018 06:47:26 +0100
Message-ID: <1531374448-26532-30-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(189003)(199004)(36092001)(76176011)(7636002)(42186006)(86362001)(575784001)(316002)(305945005)(16586007)(54906003)(426003)(186003)(246002)(8936002)(8676002)(336012)(50226002)(47776003)(109986005)(356003)(26005)(2906002)(486006)(476003)(126002)(107886003)(446003)(2616005)(11346002)(478600001)(5660300001)(4326008)(14444005)(4720700003)(1671002)(26826003)(87636003)(6666003)(106466001)(105596002)(48376002)(50466002)(36756003)(51416003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4712;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT009;1:XRHI1FAWwUzWCwNQluxFEi6NNY+0oRU5h1NS7w8AZY8jd44aBTh/9doExlPCMA3tLvqTkRZa1UMAi44O6k1vTiqWa3FJPZICMB1dTwh+cYBCEQgqTknvTMIkYrgFw6EF
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db362113-1771-4401-d2fc-08d5e7bb0a0b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;3:Q+YAG4rLBVhxywVKsu0EHu7bHyk5F0oe/Oj4n4j64fMNUs8uCdebWaC+2Z0vj0EEXOQpPcFtZJVGvX7RiJCUo04uSNnsP/5M+wgdEbo1DRLRzmgtalfGiT/bM6s449/4f3DVq5hNjwpEB0QDdpw1xirpNKqwP2IXYPD2BK2xcFKqt3SuNHc7tBWgrDUU57i3QtmVLQMZQffUAcaEFB4Eql2+PYGe58yt0hshGz+O5PaiWJ/wGNCOAthH/6vaaXM9e654VIkjiFtzv/ldRNK5mux5p0sVOoGnn6GLVXwa6jSK0Man2Bg8goJgTlUiYPodLu6Ag3TfU6MasfIN9f8faVbpLGrhKvRYB58JS+wAckc=;25:OgWlTdWR2p6kbOeN8gzOi7Cy66/HeIs/qtmE5pi+BBIIqodsYcnhT382ZCPyUhGSaeItA0R4fqmT5KMibN42llSYhWxiLmC8XxegfA23jIEe48sYJWFaWXHD1CZXzyHKElpjZ8k0/XqVKCV/QahBjRNokW+BjAQWaSyqeRNjqOX+iLdtYZZbcBFskd3fvZCEYht6q6bndDDYx+y6G4FyitE1PXpvTt+AioKTRFzs57QXXwPCKoRWxy4ta6dlg7KVeZAWT1TLdz4c/spcLbnCGZ8HRXXeb+DiOuUS+VX0fQOirYWxpm96zhph1arwdqSXqFB6WS8mn3bsJ8xTmroR0Q==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4712:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;31:uBB0QXrQc5dJ7nNodkA7VQOiQ2jXZdzhH//g6DJiTsh0gSeGdiq5Z/lc44TcxiLFWXcUkU3cHlROwp3epmJCDYPWa+ApejgtSFcxqBK6/RFha8PjlKKDWyyrEqJ719oM9I6eu0opW3tUodPQTBsQLKuKWj42HDtoP+02Fi4EE0cY9vGK3s34o4omAtY5S6EKocb/zLd2XjxpZkgaiKr0+D1XbbDw41qGZ47R6RoRc94=;20:RH2PxWN9JkN15QWToltmq4RSfZJlmGNnf0/X69gxP0p/q4xPDmk6m7KcmTV2AV0H0YBpUB0PxzZvddt9UMMhJdkLZ4daTpw3/asiX7ykt2thOMZ93siojgZhRHU4s38lC7XRa177LbssXD7a9+vPTPynm7MMv8egn2UDppubS3Q8puBuxn/5su48gxddPxxZHRKwqsSVhEitKgxQxNQKgiYBg1vY26E3hOFnJSlFG44lM0/J4iWRLB0sBuQ0b5JgaT799GolXfeogK6Y0icUXo9j0RGyEIhInaVx4xYGpT6ZgEdxphXRi3Z5HncwauJ4pf+MXyy6MWH6UJYyl4J1srXFoI14o0U03sihBuhIg81qaIIvGch8MinpVz8BI7WwOuWlv3HmLqiF7CZHBV0LGzWhq/3dbZIRTqKLdlRsn/03CxuiPc+QyWOBPJ2yyWiw/6JjjC5xF9xi68sSsYcI8YrWuHdHiQuAxCju94mvDz95xOwpW4RCdtBwnhkmE1OE
X-Microsoft-Antispam-PRVS: <BYAPR07MB47123116CE026232F2D10C53DD590@BYAPR07MB4712.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4712;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;4:pBH8elXGd4ox4ErSgR0xyYLEO+PAbBVEco+yc7jHkDKwdPpDBWnPCigmOQ8PwUzLlHSCLS65px2bWBN+vy4q7JXysbbk1tvk+Rexjx1e7m88xLW9l06lukHvxfhgPiXaLYqxn41X596Jw2e51E2M1c1KbtuTdPAlFUddpIAtzErOznRRKlyY5TAehCL07QKDi+OEbC3HlYynQ4CZ8t1beFcRwbdEMRbTjK7xoiMDVnaUnbR2oOVyNVJNqlUvi8+i5p7CUqRJzUnpkfr1GzhzWI3DC5FENiFOL30Y8hzrsaEPLzCciZxPxU6m8u181oRe
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4712;23:7Btp0KQqGymcrldcsZbCWuFI3bfecs4bWpDoudKpf?=
 =?us-ascii?Q?R5oBHuVHigwFS5eVx9aVkNzTu17N3YDKppBiqGwdjBfKIrBA7dB8jiShyV4h?=
 =?us-ascii?Q?k6Z69JU0k4vIoXbsjHchWDns9HjFoogi1cWsMxvjkYhJIN/Iko+VaN0ezzzX?=
 =?us-ascii?Q?FIJxQIOugLU8uJJUgKQTyF8DRO3vU76+x4pASna2hxAiSlF3wbugbKvLBjwB?=
 =?us-ascii?Q?1r9Uj57PQKP0APEW08eKRtkxWD/UAp4EqMucyT7fiq2v/pKxt/Uvg91ZkkFp?=
 =?us-ascii?Q?zxXqVuJVz9WYzz2J6tEDrUu8IrdnEF8D/AXnZT4VnwPwzT7elkw62V7wWWDA?=
 =?us-ascii?Q?BQKL2FW5K3BFxYxw233MzxvWDqO9pp3Yhp0U4oh9EDTofkLXdmJbeNDbF/0J?=
 =?us-ascii?Q?2638yRPYwzpkaCXnE36D0NaVCSUdPdaSTNI1hYOpHAFWSMrkKAKJqoMXNuf6?=
 =?us-ascii?Q?3UAcqUt73fVf/qYY4aR8SeZw8Pcc4czyg9DYzNXiE1uBSDOtM/vRzLSoWeX6?=
 =?us-ascii?Q?9PL7ZHcaDnOQ4IrCijFlV7D2SEBUISA2H4Dm6rM9rWU8JsG4YVjqs0yPjc+3?=
 =?us-ascii?Q?0W3c84lRa4N9BYA51+tC56cTAdpq/xUutsiN2ZtroRdU6mD34jbk1huxH+KY?=
 =?us-ascii?Q?tMsmeVd+nox4u8CGuUjenq7mupZymB75NWXpyHtpK1sVovkPjbve/l01tQBP?=
 =?us-ascii?Q?EaBOXXXZXkysQDJSIelCmV15kI+frd5UpZSVuOwt6wHSD4eFFq1VUvovQIiD?=
 =?us-ascii?Q?zZp0s+N44bs29RRG3a3KWCX8HmmIxRU2LlAyndx+X7i8XGGj4Rgr8beiVruY?=
 =?us-ascii?Q?y8tglpR8mESdzyH1ZnvM/984VjhoxHMq713xyhcgjuZ+NS5zSGX1ygTDHMSP?=
 =?us-ascii?Q?QByQaVG3a9zCtIgfW/rhh+mNGbL7Hk5ncMmzSMfAYRxr6VZRD/exjdqoTn6e?=
 =?us-ascii?Q?E63j680dZmOmdMg8tub/Smu+ZnCLcqhb+Tq8fzTHXYqMcHSmmbNHRBRBj667?=
 =?us-ascii?Q?Q3dgn5yqemRE7cMGwN4iyfV5wgyLS0rdkpu3YXaEQizq24qVsgYVLPEDYAIR?=
 =?us-ascii?Q?C3q0OQ2CKWieXtZsT/yfI1QcGJSYvtclrMJNH0Igo7ZSh8fXAHsuwK/EZEtl?=
 =?us-ascii?Q?Vs4wvzGxolulpHjd1TrazxX+DgT1Q5YDD1FxMkId78NC7GG22cNoTctzm1P7?=
 =?us-ascii?Q?YIxVDP5ygLtLtw=3D?=
X-Microsoft-Antispam-Message-Info: 3ALB3HakRaBRxLAumC6I0wRWF3seCCfEYphMmi6hDSJs437BjmpBxHQqj60jUGFCh79xqEvWkKOzCvW60pevBoMJSu41Sog75TTx8XQTG1bVKng++yDnSQL0h9DjG8l/o9gl+kxC08pWoTirROroLYb53ODNaJGkqGGh5lw6tt9udE7mXjsWAuI80wjbBkh9y1PTALvrAmof996/i1r4VdDHjasPs75iZcnuZ0+hnkkNlUSFnAojlH5H6pfFEOs+PxKFOWWPqWv/DyLBfXC9nScbxwYk1Y9u5S6/Fc3zcNPbovYoelh+38v9N8oXR4clBjPl6VcbK2eFGhErtMgbe0/S3vBmoGgrZgMHNqwrolA+G8gLX/7rY5Lj0oKCEKlmcQJeSnM3lASgwuk6+1NNWQ==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;6:lWcNk0LXt7VMDifRZ5E69chTVHvSbg24ckYqw+szpzld3bHiu8A8HH1Xn9u6oqwzdRBE50s/8VSDwARQtX3ZTI+0fwtyeZjASaaHVYHvExCBKNOIOMyKmazHPHCOKEE/dmvol6sBKqX3Jo27kW+gM4xMYvBBMNlAOFOfQj8Wdt5Wm04irDL2Gq8C82QY4HwDrtEBoiIVmxXGdtf+0aA8IZvFM39tf710GxIHyWt9C9k8xGe3OBHCx13FFTRUHYELVa1A8tn/l6g3OH2QyDHjjvw3d1Qh0tEIfFzz+Rp1EUKMt6/D7r7eq/86Di6Gpzq8x8eCTCKFiS6vD/P3p/MMaTKpAtQ9GEZksOOZN5C/bdL9HElx4+hNwKaTR1fiXSGx9F3gaVRinHi1t2pE9XAHniFXcHML62ugfr66l7uPvqfyeFWQPhkVPDo/p3bZoio3TDZz4Ul7UJBDg4OdVFmW/Q==;5:Bvn9R9y3n6lFHPoVaOJpQwC0AhJPOtwgEHbz8EsNWnolx1zgzcYMYqYhhj63l/qD7Tb9XnZEhQL0wpGVAmYBqOGn/H4mVjHNH8JoVNe5ShRKSig9Qcm2qLYJrvFquj2C87rzx9/inO4k7+QqZj8ndBSvGDSDnBEGFq6NRSqcaD4=;24:j6TkMKlRqLL8PPpBwpdczsvtuyzBmadr8db3f8DLXFsRlJyVNCQje/e2MQds2huqZJ9xpjiJOuE5RAK3YoZsuSccdRhzPzTe2FPo47ezyA0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;7:ghuDwc16sjwUa5Fwfqsm/Nm33bXVUrYEU1MkyivZhvpHnaPlkJaF8RPYzEx5vjTLUl0LLVQLTPbvUv98xMeuFed5NX3PHwlx0MP00/qfIYNC+PbCatDFpxoKnugzUcaj9CPzP9vI0VD5epwcZOZ6suXf4kqcQS0ceqMTQKcXCy1PYx9NXXIPq+HQXpYpK0Jh/2d4GvXypKiE9pNoDmgQatN5hC/n1/jA2hyxqDLbk+OuRcLyz31e9ZrvE0by0UH3;20:XsO4lE7Z8PzpriDWoDM9vnQFJy2RQfaIclmVsWaVNgKjI8pCAd/c8APPd9b0LC8z6jjuI9aAxLdRcEXcZQKJFVMJxohcJwTt/nisfr0La0N2YNJD5bXAsydRS1x1b3cIg+S8oCRkgVEhL5cZ7KCgIlleoSNVHZK/7eWacAunMk/rf8wOG7U9gMI5gq3sGKY+3ioATcVzUNdILrwOXvWuHAA4lPrZpp5dOkAgB5Y/KjzGGm5CHmtM7JctTHWm5JFm
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:05.3740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db362113-1771-4401-d2fc-08d5e7bb0a0b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4712
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements LPM functionality for port working in HS mode.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 11 ++++++++
 drivers/usb/usbssp/gadget.c      | 48 ++++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.h      |  4 +++
 3 files changed, 63 insertions(+)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index f942c19fdfc4..fc9bbce2b755 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -3018,6 +3018,17 @@ int usbssp_queue_ctrl_tx(struct usbssp_udc *usbssp_data,
 				USB_STATE_CONFIGURED);
 	}
 
+	if (usbssp_data->bos_event_detected) {
+		usbssp_data->bos_event_detected = 0;
+		usb_gadget_unmap_request_by_dev(usbssp_data->dev,
+				&req_priv->request,
+			dep->direction);
+		usbssp_set_usb2_hardware_lpm(usbssp_data,
+				&req_priv->request, 1);
+		ret = usb_gadget_map_request_by_dev(usbssp_data->dev,
+				&req_priv->request, dep->direction);
+	}
+
 	/* 1 TRB for data, 1 for status */
 	if (usbssp_data->three_stage_setup)
 		num_trbs = 2;
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index bf6a147e2a16..e95ba0f22809 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -1701,6 +1701,54 @@ int usbssp_enable_device(struct usbssp_udc *usbssp_data)
 	return usbssp_setup_device(usbssp_data, SETUP_CONTEXT_ONLY);
 }
 
+int usbssp_set_usb2_hardware_lpm(struct usbssp_udc *usbssp_data,
+		struct usb_request *req, int enable)
+{
+	__le32 __iomem	*pm_addr;
+	u32		pm_val, field;
+	int		besl;
+
+	struct usb_ext_cap_descriptor *usb_ext = req->buf + USB_DT_BOS_SIZE;
+
+	if (usbssp_data->port_major_revision >= 3 ||
+	   !usbssp_data->hw_lpm_support
+	   /*|| !usbssp_data->gadget->lpm_capable*/)
+		return -EPERM;
+
+	if (usb_ext->bDescriptorType != USB_DT_DEVICE_CAPABILITY ||
+	    usb_ext->bDevCapabilityType != USB_CAP_TYPE_EXT) {
+		return -EPERM;
+	}
+	pm_addr = usbssp_data->usb2_ports + PORTPMSC;
+	pm_val = readl(pm_addr);
+	field = le32_to_cpu(usb_ext->bmAttributes);
+
+	usbssp_dbg(usbssp_data, "%s port %d USB2 hardware LPM\n",
+		enable ? "enable" : "disable", usbssp_data->devs.port_num);
+
+	if (enable) {
+		/* if device doesn't have a preferred BESL value use a
+		 * default one . See USBSSP_DEFAULT_BESL definition in gadget.h
+		 */
+		if ((field & USB_BESL_SUPPORT) &&
+		    (field & USB_BESL_BASELINE_VALID))
+			besl = USB_GET_BESL_BASELINE(field);
+		else
+			besl = USBSSP_DEFAULT_BESL;
+
+		pm_val &= ~(PORT_BESL_MASK | PORT_HLE_MASK);
+		pm_val |= PORT_RBESL(besl) | PORT_HLE | 3 /*L1S set to 3*/;
+		pr_err("usbssp_set_usb2_hardware_lpm7 %08x\n", pm_val);
+		writel(pm_val, pm_addr);
+		/* flush write */
+		readl(pm_addr);
+	} else {
+		pm_val &= ~(PORT_HLE | PORT_BESL_MASK | PORT_L1S_MASK);
+		pm_val |= PORT_L1S_HLE0_STALL;
+		writel(pm_val, pm_addr);
+	}
+	return 0;
+}
 
 int usbssp_get_frame(struct usbssp_udc *usbssp_data)
 {
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index cc826255593f..ff10b70b3906 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1740,6 +1740,10 @@ int usbssp_alloc_dev(struct usbssp_udc *usbssp_data);
 void usbssp_free_dev(struct usbssp_udc *usbssp_data);
 int usbssp_address_device(struct usbssp_udc *usbssp_data);
 int usbssp_enable_device(struct usbssp_udc *usbssp_data);
+
+int usbssp_set_usb2_hardware_lpm(struct usbssp_udc *usbsssp_data,
+		struct usb_request *req, int enable);
+
 /* USBSSP ring, segment, TRB, and TD functions */
 dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 		union usbssp_trb *trb);
-- 
2.17.1

