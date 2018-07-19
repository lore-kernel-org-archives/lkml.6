Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82064ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049D220684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="d2+bvVJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049D220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbeGSSqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:46:52 -0400
Received: from mail-sn1nam02on0056.outbound.protection.outlook.com ([104.47.36.56]:63616
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732452AbeGSSnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9ruvVTE9jRV0IBN+A9b2axCdTy1CM300EqSeDJjcZE=;
 b=d2+bvVJ9qowmY6UVNbI2VBPrDmqyxpY9sAqwbOABeXS68j0oPFU+byb3khadCOmoSOamoNRZ+8RiTzirI6hfZSRkAdPWiSbM0lOAIALCWU1wWSvxrcnhtVasnOUBRC7GkFWJ30wwm3I+Z/qLjMFtVL1XJU8sx2JTN4zBYY23NME=
Received: from CY1PR07CA0008.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::18) by SN6PR07MB4718.namprd07.prod.outlook.com
 (2603:10b6:805:3b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 19 Jul
 2018 17:59:21 +0000
Received: from DM3NAM05FT057.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by CY1PR07CA0008.outlook.office365.com
 (2a01:111:e400:c60a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:21 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT057.mail.protection.outlook.com (10.152.98.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:21 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAS6019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:20 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:29 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:29 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxDcm005853;
        Thu, 19 Jul 2018 18:59:13 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxDaV005848;
        Thu, 19 Jul 2018 18:59:13 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 16/31] usb: usbssp: added connect/disconnect procedures.
Date:   Thu, 19 Jul 2018 18:57:49 +0100
Message-ID: <1532023084-28083-17-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(2980300002)(189003)(199004)(36092001)(11346002)(478600001)(426003)(48376002)(5024004)(26005)(8676002)(14444005)(50466002)(486006)(186003)(87636003)(1671002)(2616005)(336012)(8936002)(446003)(106466001)(4326008)(47776003)(476003)(26826003)(5660300001)(50226002)(76176011)(356003)(305945005)(36756003)(575784001)(7636002)(51416003)(109986005)(86362001)(246002)(107886003)(2906002)(316002)(6666003)(42186006)(126002)(54906003)(16586007)(4720700003)(105596002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4718;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT057;1:0xQCwyAsGYuDoa560Plu9NFnfuWqSdHTUQmko9aZNRtBouVAapFfQGW3H1zGCHmlyBOUfTVAZ3XZUDJqmX0xfvDG7rK/w093D1652hAd0MxGNO0m57lJZpu7UgfjCAkR
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ec57a37-24d7-4118-bf58-08d5eda15aec
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN6PR07MB4718;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4718;3:m0cJb9lhtRgcyab09c4pvZALvOuiSwqRYQyr6bFF6OR+1i4W5P5vPhcLO7VnJtbU26/2qz6u/PaCtEzHApV8Rsf24+xK0Mr19SxOQFNByWnFaPhqZ2Y7WLTbs4yjEbj6b5i5n1fQfLZo8kcc4z9ckgdhl8RUnqd2nefY8Bd83W+I/J4tr6BIqzPP/hHOChPkmykJU3JObN6KtnZowNdY6vR6mpOF6QM7NPJY9rBII8fPBlFy5y3tog6fXc43mPHrjxT4WcFTdlOeTJZHX8tMvz9fnEv0rJOxGiGwvrOD2+zRivUz56PDYzGbxBnmz90l/3cUN/H7CQ7GPCAZvSj7jbYJkWT8xLY8PpuksVlI0Ng=;25:gqNf1BB7Ppf/ycsNbVf5HS27oznlsXvHg13rUZtyOwUbQQ/CUZZr2OAJt0pGGb9Nbo1L94wEFjty4gNTwU/NIrbVGnNWvU2phX2CHKROf0JWY7M2sE5D/pc0WZPp9sxtsWYKzsc0HS35Uerm+S9qRNol2flbM15nQJQoj4EguWa0bLFuQTLzIsxqxBIQrSshBLB4GS3JviT5/NkUag8zL6SPy8yvF4ENEuZ/GYVnfTNloilpjh2z1+rbDO3FPwv4O4djMqnSyScFjWPtjAibusP0TTIk/R7LOdM4/pxFXZyBXCfpw6PptyJS2DnrsP84srGSY9wlGnaTbI5yppFhUA==
X-MS-TrafficTypeDiagnostic: SN6PR07MB4718:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4718;31:kOmslFcZfSiwZSmYz5/k1yXkVZnVI0dmyYR4V6Mr1kdmMwM/d+z7pZrxDQsQS/hBV2LazYzNb7pVuVEpy3dYTaBHKTNSg1II1bTVqY2JuwudhVn+YAyZp4aNsfI0WITQFDF+mBObu7hR0YEOPaG9JUSpf7AFUnyyvSEXuvYwklzPpQc6LqX0tfDhydKNbuDkXKfd1+rR1PlfV3yzPSeSj+hPatv/C0o0IhjyMyQQl/8=;20:m/urWZhLrUmj555HTvIyGBuB7aM5Kdu+GfCuNgzgDxewubcLnrq3CPIl4eGu1KOxrpy2pfKPdqqe833WxmwQgfziZCjNhzqAzzHiQ1BcZe+Txtk++L2lY8o+gO/XiaPZPCo6FL3zgEqHl2tml0+sMpxVWy2p/yQgH8OCNCoTBFqfZZR845/Ya529+DqZxGPnFPavVe6ZLn9Vtm8noB+0wBk70z9xGqT9AOV1iEZPBhgSqEmL+lnYvgFJbjVARVBR93/zOhcW9k0+vRnNX+P3u3PLuexesKndHI/FYgIpxCQ4+OUhK41cVj0MvTft4tNR4yBLZ7c4hsY760tRp2ueGdDs8+ukC2YaO/hHoSRjBZFN8j1DkvpiSPWQ89TgSB7ELfKC69vFdbGcacyLbUnZF58Q47zlnqfRk0i0HOeBMs5erRkLik/yJTxppB5ZCuW7yXt6kbAi6WBuvVLPIHoRAJax+9RCXk1Bjf13TG7WpLwhn72Ro+E/HDKzn24FacRq
X-Microsoft-Antispam-PRVS: <SN6PR07MB471896FD62C3B08A615AFD84DD520@SN6PR07MB4718.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4718;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4718;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4718;4:I+6e89DOaVdjW/5FBVFeyYNkic4KrkxEzLzbqBTIqZi0wgdxABpjUyKRsI5cNlqsaYSCVDqAh1EIauTjJdPCcQAs0KlUjCh+9p9sXCIhxfn9JKoEU4IobnVG75xG/F1gYg3jVN3bzQ+j3KLNeEje5PEUwqBpVCjlC+WaMoAEJI9YeP2SS1Hm/Nyo5e5XLyg0m9ruz7KwMUBbu1wyRPCU1BbKzLXhVeUqIp00t06y3w3Dyk2npSQLpQUct7G9qKB0Jmz8OTHle4qvQC+ccNNbQHZwwy41zoxyfOR/pUx5ex5TauPsrmaGR1I0pxxHYAkXrkC/gqSKoheanDJyMbjbc3JEe29rJ9yPw8rFBWhHYP8=
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4718;23:TmyIcuhHVkHOkBp0RUsite4uhMXd8p5OcynsBJVx9?=
 =?us-ascii?Q?TJxMy/zfJ4gtqQk7fj35r37IABONg6Tkq0xKU63gWB1Hvl5RlEu9pJkucncn?=
 =?us-ascii?Q?DM9iIhwAN0Ni7ofkS9BrUeffAD8ImKwgJ6HtK7WY+Eh8mYZadst3E1Qeuz1J?=
 =?us-ascii?Q?UyDrSBMMjiDa9GZNfKHFamB+0znA3f71d6HHBMozJNbAHzJP9iPDBYC9X80G?=
 =?us-ascii?Q?FuWi2mTNYPNwFckwpOis9T0AzAm+BDke/apra3NyD3gKZjbtksCPZGT05au8?=
 =?us-ascii?Q?6g6raPvYb6DvkGbcmmFTX/guY9alAB8KpSs6hCdnv0Qo+xjHbhhjCYS4NxQl?=
 =?us-ascii?Q?RJQsGTHfUWogu4P2NGSskV8R/TJV70gpxFijP8LNDGOQ7+9phHtDjsU7HjsY?=
 =?us-ascii?Q?OyPjT8Im6pRjIqL6kqC5bEJvzo0ukNGnHr639wzXJGmc4AsZuWJQNt3wIZxh?=
 =?us-ascii?Q?eIUutfUROh/eb6/ZlA6RlN5TwNPoJVpkpXWnO1iVgM8akFDYn5p0wLSzYNwg?=
 =?us-ascii?Q?8NDDHXYOb0y96Yi2Vn80dIjvculShUhBltICeCuqSlWvOveA/2olXIxIUXOi?=
 =?us-ascii?Q?uRoy7MRWfde+UTPlATbCNieN1QGwhbFShRb9QJ+uAy40ulPethSlMd1oh8l9?=
 =?us-ascii?Q?Qr7A16VHgGNg21YljO+AlQgiOdgjBjIv9AtEL3RaOjoW+aVcZVDYza6cbmNx?=
 =?us-ascii?Q?ZOl48M/u4j1BxXAsI8c9TnywoLNVdL8LX96OLpZcn7n6RQgB6Xgjto0bAmQo?=
 =?us-ascii?Q?mFqsfuOIQXqix516ehwPT6P48EIsnc7SofR/qHg2MlNKe32A53+Nn7rWCJrT?=
 =?us-ascii?Q?CrHExiOkCEMF5B7KhQyjA0MPvjgmXP82c6LRLMi2EiNQK+nL65mOAIi1yg2U?=
 =?us-ascii?Q?yEFHion2FB62ZY+4+n78Fqe0+Zsla2bT27N6WFW7XbG+YF4Z65XSofkgnwcy?=
 =?us-ascii?Q?yv9PXRQB+RM12d7r6imKHWPQHVj2Lrk5DcsDhO5mvp2jcqLp6jizY7u2lSSH?=
 =?us-ascii?Q?BXmPvuZghqvuH6S0MN4OcoyqVAqWQT2V0pCZeYU8G6MCkB/bL4sS6ISA7kCk?=
 =?us-ascii?Q?vJk1UkqNMHKe7Hq2NkQM1GxH7M7WEMa1q6Vlbx5pWM1Ub3e0HOdJ3iqQFJlo?=
 =?us-ascii?Q?xaLMIz/ZMuhyoD/+xDC1b91/WUIyWvtSYmKHBuIQ6fC3amh1AbWrsoLCZ+pq?=
 =?us-ascii?Q?AqVOu+pkAQnSW7WBre/MEj2ob5fF1FyDQki?=
X-Microsoft-Antispam-Message-Info: pH9vskKl/pnbh8nS9XXBYNo1jHw7r4Qw7jMBzcJJYWN3ztqF5bPSCrJUeSW+xkRBGDnh2kyjdnjSWQDS/caW5Xd7Y+QJIUDyz8P/wCCaevQmjP2ajNH6hSh3A2Ovkm3W6lumneS13rg1gZ5W6f3LeoDlVcB1SNyXcCf0qSjzJP1TGTfp6CYkdN2m6Gxasc9bgdL2QRXP/aV/SRM2a7p/oTYbtdtbactW9s29IsYgMuvjT4o0bAnn2MRnc1qA49TPUFVrlkts9IjmcBKSMT4xbDVpT+tAkyUPdA68TZzsTOSprkty9zFZQzMZd8Xpq9MUr9mLvLn3Ccbrv2FC4zu0OrT2VInZ3KyHXqXnI8CJvrfFEMm2PtBg2aQKvlrByGMtFjVUF/HB8QmWxvQkPJh37g==
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4718;6:/S2UDMEvL6XMs6Olf9D2yHJarCEFfoutSj+QgipS8iXByQkn+WhRIm1eC6QUG4/zF8q6Gvqp/AQArTv/8oxhak19o8dENsuhljmHh391SnmHFoG53FBSpyqwYWiVW3dqkoBVaivLSOuPBrDhfXV19LfCDfZqQo7dB3b9K+Z5WGRxLJtE7S9DwqCdIXEfRe3IuySxUSbWOO19eMwCrCqxJEda1PKqNVJVefG0g8r8DycIOBlvT3b8m6iTiF8WbZqk5vS3RxQcXQGP7hCsb/dVwmIreBZtgAXQ2Z8e5lEnxhvKhpF8+A7rK6G8ggZoes243OKmiaw06DPeLUofefjU6/Sp62ogQBgi4T53hIrTMz4AfuvRiM4Yr0tI3+VuUtH4lzPi9yvAR2cfcCy+iRBhjlFqTEqKOuh9tqHJcupjZqPDpXSSTWtjWQT3Qxe+BCMJ1EZwn2NAhG5gR2lpXqhr2g==;5:8N17QEYw/pgiiAmOllAQXIbDyKibeSAOSrCK5GJNp79fDeGbo79URJ5ULv4vxn2XgswdfVOg6I2gFkE21JcgGsFAEYTSNcMFanFBIpbciDXW2v0JMY/XaIf/UVzpvUXJYVZTEkiQ5J1t46seGw1X8NReqVf59p4eJk8DFbtuOHg=;24:8JcBhsLaOUGpgZEtCGgS0p42oyAM46++WUVPiG2AprxW1wE+MzQgOOQBERDuGcH7ss/UHbIoc0D8O0cVTwsWTC9cLs+SUCtdh9QpO5Onky8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4718;7:vCHz2mdYmoV68O8XZbwFls5qO3cYqzgqKLzPulr4SepyTb54wd1A9+JYp5hmxErfOK8jd8CLAtFqxPC8qC3+o8CMZh/Ts6zDG9yFADX7EhdYgdZn2Uks2bqjdC4k0Mzk51hy802exXLEHBMlEKjK6Imkda5AJrHERZgAaiPwjCmlim02vEBaAHF8tF46bq5218kkYfTHzoVE3DzHI+NiaW9tV2jUeX+TdIuHNVRbU07DnCiywDt/NXrXkKqOEQc+;20:Uv3/KRtrwZdOwUUOrQ1GYPMDCzB4oQ9LCTpnNBiK446aRzpUOomo5+sWBHxuFTKLtYv0rluxZ01BMyLaMyRROQa6p9TkuZfggFvt3CcLG7rE2WmgSVtCXJ5DsdYVkklwRg3Y+5pumUb6mJO76tMivEH+9Yiy/vDCTz4Trxh24Qm1w6DG4GaaN5F1+daK8w4jvnyt0qLZpA3ywmp8Fi/6tb8DZSem1oiAoq7cMkAEF9AxW4eWytRQWneW25ZWpMbl
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:21.0806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec57a37-24d7-4118-bf58-08d5eda15aec
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4718
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds functionality responsible for handling CONNECT/DISCONNECT
event. This event will be reported after attached/detached USB
device to/from USB port.

To complete this procedure usbssp_halt_endpoint function must to be
implemented. This will be added in next patch.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-if.c   |  16 +++
 drivers/usb/usbssp/gadget-mem.c  |  73 +++++++++++++
 drivers/usb/usbssp/gadget-port.c |  92 ++++++++++++++++
 drivers/usb/usbssp/gadget-ring.c |  12 +++
 drivers/usb/usbssp/gadget.c      | 178 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h      |  17 +++
 6 files changed, 386 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index 6f42ad33979d..ef466aa47f56 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -288,6 +288,16 @@ void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data)
 	}
 }
 
+static void usbssp_disconnect_gadget(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->gadget_driver &&
+	    usbssp_data->gadget_driver->disconnect) {
+		spin_unlock(&usbssp_data->irq_thread_lock);
+		usbssp_data->gadget_driver->disconnect(&usbssp_data->gadget);
+		spin_lock(&usbssp_data->irq_thread_lock);
+	}
+}
+
 void usbssp_suspend_gadget(struct usbssp_udc *usbssp_data)
 {
 	if (usbssp_data->gadget_driver && usbssp_data->gadget_driver->suspend) {
@@ -318,6 +328,12 @@ static void usbssp_reset_gadget(struct usbssp_udc *usbssp_data)
 		spin_lock(&usbssp_data->lock);
 	}
 }
+
+void usbssp_gadget_disconnect_interrupt(struct usbssp_udc *usbssp_data)
+{
+	usbssp_disconnect_gadget(usbssp_data);
+}
+
 void usbssp_gadget_reset_interrupt(struct usbssp_udc *usbssp_data)
 {
 	usbssp_reset_gadget(usbssp_data);
diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index 5708a0090ead..2c220582a5f8 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -643,6 +643,70 @@ void usbssp_free_priv_device(struct usbssp_udc *usbssp_data)
 	usbssp_data->slot_id = 0;
 }
 
+int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags)
+{
+	struct usbssp_device *priv_dev;
+
+	/* Slot ID 0 is reserved */
+	if (usbssp_data->slot_id == 0) {
+		dev_warn(usbssp_data->dev, "Bad Slot ID %d\n",
+			usbssp_data->slot_id);
+		return 0;
+	}
+
+	priv_dev = &usbssp_data->devs;
+
+	/* Allocate the (output) device context that will be
+	 * used in the USBSSP.
+	 */
+	priv_dev->out_ctx = usbssp_alloc_container_ctx(usbssp_data,
+						USBSSP_CTX_TYPE_DEVICE, flags);
+
+	if (!priv_dev->out_ctx)
+		goto fail;
+
+	dev_dbg(usbssp_data->dev, "Slot %d output ctx = 0x%llx (dma)\n",
+		usbssp_data->slot_id,
+		(unsigned long long)priv_dev->out_ctx->dma);
+
+	/* Allocate the (input) device context for address device command */
+	priv_dev->in_ctx = usbssp_alloc_container_ctx(usbssp_data,
+						USBSSP_CTX_TYPE_INPUT, flags);
+
+	if (!priv_dev->in_ctx)
+		goto fail;
+
+	dev_dbg(usbssp_data->dev, "Slot %d input ctx = 0x%llx (dma)\n",
+		usbssp_data->slot_id,
+		(unsigned long long)priv_dev->in_ctx->dma);
+
+	/* Allocate endpoint 0 ring */
+	priv_dev->eps[0].ring = usbssp_ring_alloc(usbssp_data, 2, 1,
+						TYPE_CTRL, 0, flags);
+	if (!priv_dev->eps[0].ring)
+		goto fail;
+
+	priv_dev->gadget = &usbssp_data->gadget;
+
+	/* Point to output device context in dcbaa. */
+	usbssp_data->dcbaa->dev_context_ptrs[usbssp_data->slot_id] =
+		cpu_to_le64(priv_dev->out_ctx->dma);
+	dev_dbg(usbssp_data->dev, "Set slot id %d dcbaa entry %p to 0x%llx\n",
+		usbssp_data->slot_id,
+		&usbssp_data->dcbaa->dev_context_ptrs[usbssp_data->slot_id],
+		le64_to_cpu(usbssp_data->dcbaa->dev_context_ptrs[usbssp_data->slot_id]));
+
+	trace_usbssp_alloc_priv_device(priv_dev);
+	return 1;
+fail:
+	if (priv_dev->in_ctx)
+		usbssp_free_container_ctx(usbssp_data, priv_dev->in_ctx);
+	if (priv_dev->out_ctx)
+		usbssp_free_container_ctx(usbssp_data, priv_dev->out_ctx);
+
+	return 0;
+}
+
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					    bool allocate_completion,
 					    gfp_t mem_flags)
@@ -754,6 +818,7 @@ void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data)
 
 	cancel_delayed_work_sync(&usbssp_data->cmd_timer);
 	cancel_work_sync(&usbssp_data->bottom_irq);
+	destroy_workqueue(usbssp_data->bottom_irq_wq);
 
 	/* Free the Event Ring Segment Table and the actual Event Ring */
 	usbssp_free_erst(usbssp_data, &usbssp_data->erst);
@@ -1265,6 +1330,14 @@ int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags)
 			usbssp_handle_command_timeout);
 	init_completion(&usbssp_data->cmd_ring_stop_completion);
 
+	usbssp_data->bottom_irq_wq =
+		create_singlethread_workqueue(dev_name(usbssp_data->dev));
+
+	if (!usbssp_data->bottom_irq_wq)
+		goto fail;
+
+	INIT_WORK(&usbssp_data->bottom_irq, usbssp_bottom_irq);
+
 	page_size = readl(&usbssp_data->op_regs->page_size);
 	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
 			"Supported page size register = 0x%x", page_size);
diff --git a/drivers/usb/usbssp/gadget-port.c b/drivers/usb/usbssp/gadget-port.c
index 09ea5b574ae0..2c4d28070cab 100644
--- a/drivers/usb/usbssp/gadget-port.c
+++ b/drivers/usb/usbssp/gadget-port.c
@@ -65,6 +65,98 @@ u32 usbssp_port_state_to_neutral(u32 state)
 	return (state & USBSSP_PORT_RO) | (state & USBSSP_PORT_RWS);
 }
 
+/*
+ * Stop device
+ * It issues stop endpoint command for EP 0 to 30. And wait the last command
+ * to complete.
+ */
+int usbssp_stop_device(struct usbssp_udc *usbssp_data, int suspend)
+{
+	struct usbssp_device *priv_dev;
+	struct usbssp_ep_ctx *ep_ctx;
+	int ret = 0;
+	int i;
+
+	ret = 0;
+	priv_dev = &usbssp_data->devs;
+
+	trace_usbssp_stop_device(priv_dev);
+
+	if (usbssp_data->gadget.state < USB_STATE_ADDRESS) {
+		dev_dbg(usbssp_data->dev,
+			"Device is not yet in USB_STATE_ADDRESS state\n");
+		goto stop_ep0;
+	}
+
+	for (i = LAST_EP_INDEX; i > 0; i--) {
+		if (priv_dev->eps[i].ring && priv_dev->eps[i].ring->dequeue) {
+			struct usbssp_command *command;
+
+			if (priv_dev->eps[i].ep_state & EP_HALTED) {
+				dev_dbg(usbssp_data->dev,
+					"ep_index %d is in halted state "
+					"- ep state: %x\n",
+					i, priv_dev->eps[i].ep_state);
+				usbssp_halt_endpoint(usbssp_data,
+						&priv_dev->eps[i], 0);
+			}
+
+			ep_ctx = usbssp_get_ep_ctx(usbssp_data,
+					priv_dev->out_ctx, i);
+
+			if (GET_EP_CTX_STATE(ep_ctx) != EP_STATE_RUNNING) {
+				dev_dbg(usbssp_data->dev,
+					"ep_index %d is already stopped.\n", i);
+				continue;
+			}
+
+			if (priv_dev->eps[i].ep_state & EP_STOP_CMD_PENDING) {
+				dev_dbg(usbssp_data->dev,
+					"Stop endpoint command is pending "
+					"for ep_index %d.\n", i);
+				continue;
+			}
+
+			/*
+			 * Device was disconnected so endpoint should be disabled
+			 * and transfer ring stopped.
+			 */
+			priv_dev->eps[i].ep_state |= EP_STOP_CMD_PENDING |
+						USBSSP_EP_DISABLE_PENDING;
+
+			command = usbssp_alloc_command(usbssp_data, false,
+						GFP_ATOMIC);
+			if (!command)
+				return -ENOMEM;
+
+			ret = usbssp_queue_stop_endpoint(usbssp_data,
+							command, i, suspend);
+			if (ret) {
+				usbssp_free_command(usbssp_data, command);
+				return ret;
+			}
+		}
+	}
+
+stop_ep0:
+	if (priv_dev->eps[0].ep_state & EP_HALTED) {
+		dev_dbg(usbssp_data->dev,
+			"ep_index 0 is in halted state - ep state: %x\n",
+			priv_dev->eps[i].ep_state);
+		ret = usbssp_halt_endpoint(usbssp_data, &priv_dev->eps[0], 0);
+	} else {
+		/*
+		 * Device was disconnected so endpoint should be disabled
+		 * and transfer ring stopped.
+		 */
+		priv_dev->eps[0].ep_state &= ~USBSSP_EP_ENABLED;
+		ret = usbssp_cmd_stop_ep(usbssp_data, &usbssp_data->gadget,
+					&priv_dev->eps[0]);
+	}
+
+	return ret;
+}
+
 __le32 __iomem *usbssp_get_port_io_addr(struct usbssp_udc *usbssp_data)
 {
 	if (usbssp_data->port_major_revision == 0x03)
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index eab7676fa744..f3ee1c4d82dc 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -218,6 +218,18 @@ static inline int room_on_ring(struct usbssp_udc *usbssp_data,
 	return 1;
 }
 
+/* Ring the device controller doorbell after placing a command on the ring */
+void usbssp_ring_cmd_db(struct usbssp_udc *usbssp_data)
+{
+	if (!(usbssp_data->cmd_ring_state & CMD_RING_STATE_RUNNING))
+		return;
+
+	dev_dbg(usbssp_data->dev, "// Ding dong command ring!\n");
+	writel(DB_VALUE_CMD, &usbssp_data->dba->doorbell[0]);
+	/* Flush PCI posted writes */
+	readl(&usbssp_data->dba->doorbell[0]);
+}
+
 static bool usbssp_mod_cmd_timer(struct usbssp_udc *usbssp_data,
 				  unsigned long delay)
 {
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 6b3dc973c0d9..32d095b32e9f 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -23,6 +23,64 @@
 #include "gadget-trace.h"
 #include "gadget.h"
 
+void usbssp_bottom_irq(struct work_struct *work)
+{
+	struct usbssp_udc *usbssp_data = container_of(work, struct usbssp_udc,
+						bottom_irq);
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING) {
+		dev_err(usbssp_data->dev, "Device controller dying\n");
+		return;
+	}
+
+	mutex_lock(&usbssp_data->mutex);
+	spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	if (usbssp_data->defered_event & EVENT_DEV_DISCONECTED) {
+		dev_dbg(usbssp_data->dev, "Disconnecting device sequence\n");
+		usbssp_data->defered_event &= ~EVENT_DEV_DISCONECTED;
+		usbssp_data->usbssp_state |= USBSSP_STATE_DISCONNECT_PENDING;
+		usbssp_stop_device(usbssp_data, 0);
+
+		usbssp_gadget_disconnect_interrupt(usbssp_data);
+		usbssp_data->gadget.speed = USB_SPEED_UNKNOWN;
+		usb_gadget_set_state(&usbssp_data->gadget, USB_STATE_NOTATTACHED);
+
+		dev_dbg(usbssp_data->dev, "Wait for disconnect\n");
+
+		spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+					usbssp_data->irq_thread_flag);
+		/*fixme: should be replaced by wait_for_completion*/
+		msleep(200);
+		spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+				usbssp_data->irq_thread_flag);
+	}
+
+	if (usbssp_data->defered_event & EVENT_DEV_CONNECTED) {
+		dev_dbg(usbssp_data->dev, "Connecting device sequence\n");
+		if (usbssp_data->usbssp_state & USBSSP_STATE_DISCONNECT_PENDING) {
+			usbssp_free_dev(usbssp_data);
+			usbssp_data->usbssp_state &= ~USBSSP_STATE_DISCONNECT_PENDING;
+		}
+
+		usbssp_data->defered_event &= ~EVENT_DEV_CONNECTED;
+		usbssp_alloc_dev(usbssp_data);
+	}
+
+	if (usbssp_data->defered_event & EVENT_USB_RESET) {
+		/*TODO: implement handling of USB_RESET*/
+	}
+
+	/*handle setup packet*/
+	if (usbssp_data->defered_event & EVENT_SETUP_PACKET) {
+		/*TODO: implement handling of SETUP packet*/
+	}
+
+	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+	mutex_unlock(&usbssp_data->mutex);
+}
 
 /*
  * usbssp_handshake - spin reading dc until handshake completes or fails
@@ -273,6 +331,123 @@ unsigned int usbssp_last_valid_endpoint(u32 added_ctxs)
 	return fls(added_ctxs) - 1;
 }
 
+int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
+			 int value)
+{
+	/*TODO: implement this function*/
+	return 0;
+}
+
+/*
+ * At this point, the struct usb_device is about to go away, the device has
+ * disconnected, and all traffic has been stopped and the endpoints have been
+ * disabled. Free any DC data structures associated with that device.
+ */
+void usbssp_free_dev(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *priv_dev;
+	int i, ret;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	priv_dev = &usbssp_data->devs;
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, priv_dev->out_ctx);
+	trace_usbssp_free_dev(slot_ctx);
+
+	for (i = 0; i < 31; ++i)
+		priv_dev->eps[i].ep_state &= ~EP_STOP_CMD_PENDING;
+
+	ret = usbssp_disable_slot(usbssp_data);
+	if (ret)
+		usbssp_free_priv_device(usbssp_data);
+}
+
+int usbssp_disable_slot(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_command *command;
+	u32 state;
+	int ret = 0;
+
+	command = usbssp_alloc_command(usbssp_data, false, GFP_ATOMIC);
+	if (!command)
+		return -ENOMEM;
+
+	/* Don't disable the slot if the device controller is dead. */
+	state = readl(&usbssp_data->op_regs->status);
+	if (state == 0xffffffff ||
+	    (usbssp_data->usbssp_state & USBSSP_STATE_DYING) ||
+	    (usbssp_data->usbssp_state & USBSSP_STATE_HALTED)) {
+		kfree(command);
+		return -ENODEV;
+	}
+
+	ret = usbssp_queue_slot_control(usbssp_data, command, TRB_DISABLE_SLOT);
+	if (ret) {
+		kfree(command);
+		return ret;
+	}
+	usbssp_ring_cmd_db(usbssp_data);
+	return ret;
+}
+
+/*
+ * Returns 0 if the DC n out of device slots, the Enable Slot command
+ * timed out, or allocating memory failed. Returns 1 on success.
+ */
+int usbssp_alloc_dev(struct usbssp_udc *usbssp_data)
+{
+	int ret, slot_id;
+	struct usbssp_command *command;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	command = usbssp_alloc_command(usbssp_data, true, GFP_ATOMIC);
+
+	if (!command)
+		return -ENOMEM;
+
+	ret = usbssp_queue_slot_control(usbssp_data, command, TRB_ENABLE_SLOT);
+
+	if (ret) {
+		usbssp_free_command(usbssp_data, command);
+		return ret;
+	}
+
+	usbssp_ring_cmd_db(usbssp_data);
+	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+				usbssp_data->irq_thread_flag);
+	wait_for_completion(command->completion);
+	spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	slot_id = usbssp_data->slot_id;
+
+	if (!slot_id || command->status != COMP_SUCCESS) {
+		dev_err(usbssp_data->dev,
+			"Error while assigning device slot ID\n");
+		usbssp_free_command(usbssp_data, command);
+		return 0;
+	}
+
+	usbssp_free_command(usbssp_data, command);
+
+	if (!usbssp_alloc_priv_device(usbssp_data, GFP_ATOMIC)) {
+		dev_warn(usbssp_data->dev,
+			"Could not allocate usbssp_device data structures\n");
+		goto disable_slot;
+	}
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, usbssp_data->devs.out_ctx);
+	trace_usbssp_alloc_dev(slot_ctx);
+
+	return 1;
+
+disable_slot:
+	ret = usbssp_disable_slot(usbssp_data);
+	if (ret)
+		usbssp_free_priv_device(usbssp_data);
+
+	return 0;
+}
+
 int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
 {
 	int retval;
@@ -420,7 +595,6 @@ int usbssp_gadget_exit(struct usbssp_udc *usbssp_data)
 
 	usb_del_gadget_udc(&usbssp_data->gadget);
 	usbssp_gadget_free_endpoint(usbssp_data);
-	/*TODO: add usbssp_stop implementation*/
-	//usbssp_stop(usbssp_data);
+	usbssp_stop(usbssp_data);
 	return ret;
 }
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 145371eee47d..1827781125bd 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1685,6 +1685,8 @@ void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 /* USBSSP memory management */
 void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
+void usbssp_free_priv_device(struct usbssp_udc *usbssp_data);
+int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 			struct usbssp_ring *ring,
@@ -1712,12 +1714,15 @@ int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
 void usbssp_quiesce(struct usbssp_udc *usbssp_data);
 int usbssp_halt(struct usbssp_udc *usbssp_data);
 extern int usbssp_reset(struct usbssp_udc *usbssp_data);
+int usbssp_disable_slot(struct usbssp_udc *usbssp_data);
 
 int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
 int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated);
 
 irqreturn_t usbssp_irq(int irq, void *priv);
 
+int usbssp_alloc_dev(struct usbssp_udc *usbssp_data);
+void usbssp_free_dev(struct usbssp_udc *usbssp_data);
 /* USBSSP ring, segment, TRB, and TD functions */
 dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 				union usbssp_trb *trb);
@@ -1726,6 +1731,12 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 				union usbssp_trb *start_trb,
 				union usbssp_trb *end_trb,
 				dma_addr_t suspect_dma, bool debug);
+void usbssp_ring_cmd_db(struct usbssp_udc *usbssp_data);
+int usbssp_queue_slot_control(struct usbssp_udc *usbssp_data,
+			struct usbssp_command *cmd, u32 trb_type);
+int usbssp_queue_stop_endpoint(struct usbssp_udc *usbssp_data,
+			struct usbssp_command *cmd,
+			unsigned int ep_index, int suspend);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
@@ -1753,6 +1764,12 @@ void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data);
 unsigned int usbssp_port_speed(unsigned int port_status);
 void usbssp_gadget_reset_interrupt(struct usbssp_udc *usbssp_data);
+void usbssp_gadget_disconnect_interrupt(struct usbssp_udc *usbssp_data);
+int usbssp_stop_device(struct usbssp_udc *usbssp_data, int suspend);
+int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data,
+			struct usbssp_ep *dep, int value);
+int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
+		struct usbssp_ep *ep_priv);
 
 static inline char *usbssp_slot_state_string(u32 state)
 {
-- 
2.17.1

