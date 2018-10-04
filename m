Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D4BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28CA20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dRW2eY3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28CA20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeJDWc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:32:58 -0400
Received: from mail-cys01nam02on0071.outbound.protection.outlook.com ([104.47.37.71]:48928
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727472AbeJDWc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2XAboMntgAWTpDnMWOcs7c7Dyg2C2joYKDZYwf4Tro=;
 b=dRW2eY3iqqq68Xm+F5FGP4wnvpHgeGG9ZTBoxQgMC5DQP/h08QG9kBd+ofD1wMxX/2EH9pqNx8BCDG1ViF4eUbOH2Zi2Vk/m3MqNJJsJ8ZzKZQa7Sgetcog+Mi7yhTxmM5J+vQpFCn6NCEk93a7z6kcvx94obxaFsqpWE6hZgZY=
Received: from BL0PR02CA0073.namprd02.prod.outlook.com (2603:10b6:208:51::14)
 by DM6PR02MB4474.namprd02.prod.outlook.com (2603:10b6:5:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.24; Thu, 4 Oct
 2018 15:36:02 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BL0PR02CA0073.outlook.office365.com
 (2603:10b6:208:51::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via Frontend
 Transport; Thu, 4 Oct 2018 15:36:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Thu, 4 Oct 2018 15:36:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:55004 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fV-0002YK-0Q; Thu, 04 Oct 2018 08:36:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fP-00005B-T5; Thu, 04 Oct 2018 08:35:55 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94FZsog030940;
        Thu, 4 Oct 2018 08:35:54 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g85fN-0008WR-Ry; Thu, 04 Oct 2018 08:35:54 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 135CF121465; Thu,  4 Oct 2018 21:05:53 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v8 03/10] edac: synopsys: Modify the comments in the driver
Date:   Thu, 4 Oct 2018 21:05:21 +0530
Message-ID: <1538667328-9465-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(396003)(2980300002)(438002)(189003)(199004)(48376002)(2201001)(8676002)(47776003)(63266004)(103686004)(4326008)(7416002)(90966002)(6666003)(305945005)(186003)(356003)(6266002)(52956003)(26005)(316002)(50466002)(16586007)(14444005)(5660300001)(51416003)(50226002)(2616005)(81166006)(81156014)(446003)(126002)(8936002)(44832011)(42186006)(5024004)(72206003)(2906002)(476003)(426003)(106466001)(486006)(110136005)(54906003)(336012)(478600001)(11346002)(106002)(36756003)(76176011)(36386004)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4474;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT062;1:Qhdl9OLCWcq3N2N4NdQzbMKLCuWObnRUqz0oBGPU11pt82MZJr/8rX5B4Bzo6EenJ1yeMfNpwJa1DKHDAjdNkuQ0eALT7H0zOa3PeCZfXfvajSoSViF+4QrEm0TnQPT7
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1c08cd3-ea66-4b06-3ad5-08d62a0f170d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4474;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4474;3:FoCyyC9QZhaG+1QxcSP4uSWZJMxKHoLGOIgNZHavezpX/ySAXanXW7ltKj2v2XXRX9pmmWAtANnuwb3AwYKZbhS99JtIVQppJazZLVMzNZmDm3tAcwtAR+jWS5AjM1dHUMJQahtMDPEoYO60ctR/a8euw16j1Qu7UklHTRfgMPstpZvpcIsFdeptH6GzsIGYIfVcEMzwDzfNag5bbIIo5um2TGlaHM7VuI8I1d/dml/swIW5oPsa9RFbQIvI0Tv8nNYgZKC0G9n+buxjYSRLCgoTzj4OsfPPW8JAV3w6AMZTTElssete3W+B38gskCOPaeSFzkklEtfmAiAzw7Pmil5nb1ODsfFflvzxuXxtpbQ=;25:JK+ShvGussSSsHVNjfHH2R/VPFF+vwr7OBn1ubd9Gzy+IXVOV9qKyFjGoMawpDRlfvwT2RvNbcIXEb6MNzPwZZYIJF6qi7DylBJPZgkTK9IRBu4N0JtgDvf8m7VobzJiCvyyvS/9M9T6v9pNrUY+ur7HV/LZhuAdf4KygPefNbWpk+pnzFXRtZDFn1uoU4mmDyb/bdcsEaFxsuhXIa6+c1c8bizJz4rlbSJ4ogZkZAHSnAl6iSVS2xsnDfrxVZe2fnNEkvTspwJvH6jwLTGdRMCdhcmjVuya/pKbIpOYlWxGBQmeCdAouQ9b6+dipzkXA+q3jVpXkjDqkb7n8pm3fg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4474:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4474;31:Lsgu4ebi46UODuxhpqE+8rV5Trxh6dSZJkAszrDqTuD4zPtVQy2TGzq0zUQzmwZFYglII8cVQvhy+ZtHJucsXAkygmF4A0X9ltTh1j7tQrb0e9R1lFCaohVUekYRvkdDTI3VRTezJinK7sY2WgOHUdm4MhxwUYF4JEh6DJqLDpPRRisWgycSdMqMuCj5mVf+NBObtSYEM5cStZsy8HEwRYM04b7vVX6bk80SnRvQXO4=;20:AchAJxeXcMbE7NHFFSc/frDPcEjGneZpRBSSu7mruQUdegk1zFK3EUwKLd2YIWBOmg0yXCstG1YmT1tQVEthm6+nVVoTV6AnPN0J4CkcAt4NrHB3A0IccV2tjXk6wlOXASDz8NsL0UwLARMwUTM9A7k9QL5eTYKGKrgaQru0E8PgevUUokHfdjsXD+mld06LKbgB/5P03Mf65KVtWprguR3kdEZryqsshCRLDD4DqsnL9NvI5mmkWJ3y31g+0dwoPCKYJP6johQcxX95hjz3M9d5ejKIE1VqxI18+OB3MjTktPW3bTzJCyrvGoQjum+3VNdQlyMDInny/p03g6aetZ4wIQf2OVOvAN4w539SZt3GhzQ7u77csMayalvH4jjSH5ZZcpPJj88Gdo4VocvCnnqEVz/c2o0htCFBmgva/Tth+CHEUJx3lajzkwsDxW6dPUYlyczR9FTwih6CyNfurkuPy9huRw7qBDIMdOAxM5IZ0I5kxwMMiYNqoRSXJV85
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4474A843AF6E08BDDF0AD040C1EA0@DM6PR02MB4474.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:DM6PR02MB4474;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4474;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4474;4:q7MXTwZJXcndpifZ+b9JLTBRZYw0l0gFtQNoq1sgv6HFeAPb+F7LdxgODhU8Yc/6jHqddWeXBQdt4Dc33Ik9urrlDqpPPF2o8/wdXO31FXSs0oUfe9cR1dQ3AIMIDW4hVXNmYe9Og38/4tKZbgC1GnWVQ1t4YRlD9PTYb4JILPsQ/7iPj8ayNogmlHEngXKyd1pdMFtrFx06ZeHPfFPFwu9hse7pMrFr/WihzWEJhbq5vXV71UhrmoCq0hsVDMI1FuY0EmNA3tjR29dxa0INIjd6bAjqodQwk5ZglWYbwN7LE/tnnW480zDBONzbzh9vmDz+e5dQ40faqivzjhEnH98MMFDD91ZUDgd5PR0qZY43WqZow6JOk/wrt73Tl3XD
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4474;23:Xn0d8Kt27QVanTCsONtD2Jnipon+e15nmY0PxEO7S?=
 =?us-ascii?Q?y1ZIA39y165ierUUScePYZqp0brvcR3ilTgEUMb2YXSES7QXL5jvgu0ZH327?=
 =?us-ascii?Q?Kn9PBIPTr/IZXsB5S+CtfCsbpcgnMovgg5KONQqv9ffzsWiZbcP+TNaOMG3s?=
 =?us-ascii?Q?/Zh+gicb2XD7OKGHUJ90cxtUDcm+hG+K1p4HSGL6GqbnsFv24/KH588SvaCL?=
 =?us-ascii?Q?UISrzzSYz7aM349AHYS07hijCCqYgYzlNFrZzhARvOV0Kf1zw7l4LDo0Rdqy?=
 =?us-ascii?Q?SBOc8AzxFrOq/HZ2MuVenkAJ5p5ScfOlITLY9XcPnszGZe4/70iOA5KS7CvU?=
 =?us-ascii?Q?b0a0nnx6QcC9pUsj545bzoPEBSX8AxkIL9xiazfXgALx9XhBv9zP8/P9+v5X?=
 =?us-ascii?Q?/Pydi5e9jfwVsav++NqrtBVKdB7WK5eqIMH8UGP3a8FFNAhSBU97l63nXLHt?=
 =?us-ascii?Q?SU/c3fswb9wY045yGB36wSh5RPcgo//NS0QuAfsjByPTtdIyCEef6UtBu5VP?=
 =?us-ascii?Q?ejJ8RkqD7DTdLmftyAPsDVEBpMianQ8j9YKUs+BXYCqPlGxdBXVaGIf/BOnJ?=
 =?us-ascii?Q?CwLm6kaaqJ9F2OdF2Aq5UMb095UaOUd3wSqTYYyqsddLZ8CKN2dYoDpA26WB?=
 =?us-ascii?Q?0+etoLaE++UlT5W5Lmr8C2K9mmvQo4JaVvo6a4mZChictzsDFmoT+htSlX5o?=
 =?us-ascii?Q?figpc8zqto0P65CYuZXAGWM9Q5DolJcIBtnDd2Zm/vYLwbbKaFJgLsaUmCwf?=
 =?us-ascii?Q?VuM3XWLiHt3R4SZdw3oWARk8snl2AN1yD0eKvO3g3ssxkaW5xV92EQrQEFBi?=
 =?us-ascii?Q?o26G8I2ZCv3Ust+GnwNAyoR65a+wyxhcD9yPLYUG8eUXFwq+tAfk707DC44H?=
 =?us-ascii?Q?dIkoFZx1n2RTBpXufSRIZvo0RQxXWsTRBALmwpOcBY8ozq4NRgU8PKFu0aXv?=
 =?us-ascii?Q?mcr292NG6tWiWH7t0yrWy22IVmO1CUcJL7K4b6zQnTuz8rCYpq0nw/V2tBLr?=
 =?us-ascii?Q?sOVkQiWvrvKPMfppQzpLOmWJqPq4Ef2392OfY2UEkR2lIbU0028tSdC3MavJ?=
 =?us-ascii?Q?v3AURJWruB3ZswgmTWjW8/WwYrXFghtzMvZLq+WMqa/MXtlDJJmDBCQitZ1A?=
 =?us-ascii?Q?SCILnLLodMU93FJtaXbSUjugieBya550MIdbqg+hqamh7ESX49Roq00TZE/M?=
 =?us-ascii?Q?jVBoxKFq/w/HUidC8OLpP9AEGylYjVggwgCTtAVff0S09y3vE2r8+HECdJaF?=
 =?us-ascii?Q?amhsMsPBxq7ZWcVwxR7i60/BAgNS+M7uHcthV73yOsXqzGmO163QMFLPJJyG?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: t5Y3QjS26TCYWt6coPb3eoLaLIwQh+xDZ5omKjLEx/tFnsU00aq412bbmf/E4t8BcwOaJc3b210iu7OCRKLa7gVQf+rH8o9+IYhCUW6gilyH76yNw1XHuzT2OLkalHk9QIzpNx8p7O2Vix/jQUl0SlRZiiT6qXDN3StUzAgS9NM0xPpCzSzr1oTxdMLOQB504tV3W6e5FFAXoVVNZO+r710pPDjoW+bI/yY6FkT2+dq380E7d5zPbwi6yQyVaWqg3lSVmw2kv4wNm8yb+nzf483b7M5KsqjmWwKphj21TNc1Hu7y5tCZojAxHHTY4hG67Gdo+X2QNV4oRC6nf18NChprPpgRSM4jubTQW4LADpI=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4474;6:kaTkrJdA3fXjwEZFQpusR2dQnj5PD9BxiaLAiFMH4kcVtNwv5q9JxtmW+Dy+gRYIHLlG/1ok13xuydP4Yu8d4EfoD8liD8n6Nl/4YKuOwddqJjT5o7YkzdpcqL5U5bWRD3J7pTkAfhe3tiqq5UnoCgIPowmT3iy6Lg9Wyx4R95pTIYyeYT2dmFc3dXyW05KcFpx8qbpbYWtLIGkP6NJeuyay3aUiGP8hrYBQ7rnQM8pBcG7eBrXYUbIARQuYwNkwRpjRVoqEgcAfxg5yjXwujcc26//2r2Th/YRtTDnITX24n7fRJTEfeWS0ZwJISARH+nnRJrDaFHShsczDlOWPh48Ey4keqVr3P0q9Rmg1lN+W5NwKgIOZx2y/NW8XdOvxdG8y3+yZmHqZ4nqflfLrV1m9JMWdfbGOsUXXpZebCHnh/5WtIFT1pgNAVurfoC6OVuDppyz5TaCo/jdQrtp1Kw==;5:wRE2seXDYfdGyymYLvFiLIfi6IdFTm23kNTJ36i2M4zIcs1f9wiOjwy4HPzx/GjPw+a+OSmcZxJ+iiR6woM+Gk/+Y1tFnn2euZo7G/jYtF0ZH6luRJIOvwFlhrjJB6ZAG/nrF5PLp4PDs0sVBYBRC2y+qaszMbgTlVLjOvpEKFQ=;7:kvAWqPRGWvvhSE91c/h+AtwAcQ1MQIxqPXfD2erYHpp5m7JBmSXf7CaFHxmG5VvyMlCKXZjmFyooKmev5gKG3KhrkMUMsCIYOQSyvENHeSC6JsC0SpIU2fzaAr6wnXAhekJ0ZmlBUy7Xkrzs4xXts/VCKg7diRvVMv4PHtUnthwul+OpuvHOlkoaTJ1avs+LUAnXa8YzGrv87R1ycufMweOAvI4CM/BQruuEqZou4WvCa3KBCgZFVD5rNJ7ABX/T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 15:36:01.4122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c08cd3-ea66-4b06-3ad5-08d62a0f170d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some comments which can be updated for better readability of
the driver. Update abbreviations to capital letters in the comments.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 98 ++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 50 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index abb5de8..7db5928 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -96,12 +96,12 @@
 #define SCRUB_MODE_SECDED		0x4
 
 /**
- * struct ecc_error_info - ECC error log information
- * @row:	Row number
- * @col:	Column number
- * @bank:	Bank number
- * @bitpos:	Bit position
- * @data:	Data causing the error
+ * struct ecc_error_info - ECC error log information.
+ * @row:	Row number.
+ * @col:	Column number.
+ * @bank:	Bank number.
+ * @bitpos:	Bit position.
+ * @data:	Data causing the error.
  */
 struct ecc_error_info {
 	u32 row;
@@ -112,11 +112,11 @@ struct ecc_error_info {
 };
 
 /**
- * struct synps_ecc_status - ECC status information to report
- * @ce_cnt:	Correctable error count
- * @ue_cnt:	Uncorrectable error count
- * @ceinfo:	Correctable error log information
- * @ueinfo:	Uncorrectable error log information
+ * struct synps_ecc_status - ECC status information to report.
+ * @ce_cnt:	Correctable error count.
+ * @ue_cnt:	Uncorrectable error count.
+ * @ceinfo:	Correctable error log information.
+ * @ueinfo:	Uncorrectable error log information.
  */
 struct synps_ecc_status {
 	u32 ce_cnt;
@@ -126,12 +126,12 @@ struct synps_ecc_status {
 };
 
 /**
- * struct synps_edac_priv - DDR memory controller private instance data
- * @baseaddr:	Base address of the DDR controller
- * @message:	Buffer for framing the event specific info
- * @stat:	ECC status information
- * @ce_cnt:	Correctable Error count
- * @ue_cnt:	Uncorrectable Error count
+ * struct synps_edac_priv - DDR memory controller private instance data.
+ * @baseaddr:	Base address of the DDR controller.
+ * @message:	Buffer for framing the event specific info.
+ * @stat:	ECC status information.
+ * @ce_cnt:	Correctable Error count.
+ * @ue_cnt:	Uncorrectable Error count.
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -142,13 +142,11 @@ struct synps_edac_priv {
 };
 
 /**
- * edac_geterror_info - Get the current ecc error info
- * @base:	Pointer to the base address of the ddr memory controller
- * @p:		Pointer to the synopsys ecc status structure
+ * edac_geterror_info - Get the current ECC error info.
+ * @base:	Base address of the DDR memory controller.
+ * @p:		Synopsys ECC status structure.
  *
- * Determines there is any ecc error or not
- *
- * Return: one if there is no error otherwise returns zero
+ * Return: one if there is no error otherwise returns zero.
  */
 static int edac_geterror_info(void __iomem *base,
 				    struct synps_ecc_status *p)
@@ -196,11 +194,11 @@ static int edac_geterror_info(void __iomem *base,
 }
 
 /**
- * edac_handle_error - Handle controller error types CE and UE
- * @mci:	Pointer to the edac memory controller instance
- * @p:		Pointer to the synopsys ecc status structure
+ * edac_handle_error - Handle controller error types CE and UE.
+ * @mci:	EDAC memory controller instance.
+ * @p:		Synopsys ECC status structure.
  *
- * Handles the controller ECC correctable and un correctable error.
+ * Handles the controller ECC correctable and un-correctable error.
  */
 static void edac_handle_error(struct mem_ctl_info *mci,
 				    struct synps_ecc_status *p)
@@ -232,10 +230,10 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * edac_check - Check controller for ECC errors
- * @mci:	Pointer to the edac memory controller instance
+ * edac_check - Check controller for ECC errors.
+ * @mci:	EDAC memory controller instance.
  *
- * Used to check and post ECC errors. Called by the polling thread
+ * Used to check and post ECC errors. Called by the polling thread.
  */
 static void edac_check(struct mem_ctl_info *mci)
 {
@@ -255,8 +253,8 @@ static void edac_check(struct mem_ctl_info *mci)
 }
 
 /**
- * edac_get_dtype - Return the controller memory width
- * @base:	Pointer to the ddr memory controller base address
+ * edac_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
  * configuration.
@@ -286,12 +284,12 @@ static enum dev_type edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * edac_get_eccstate - Return the controller ecc enable/disable status
- * @base:	Pointer to the ddr memory controller base address
+ * edac_get_eccstate - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
  *
- * Get the ECC enable/disable status for the controller
+ * Get the ECC enable/disable status for the controller.
  *
- * Return: a ecc status boolean i.e true/false - enabled/disabled.
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
 static bool edac_get_eccstate(void __iomem *base)
 {
@@ -311,9 +309,9 @@ static bool edac_get_eccstate(void __iomem *base)
 }
 
 /**
- * edac_get_memsize - reads the size of the attached memory device
+ * edac_get_memsize - reads the size of the attached memory device.
  *
- * Return: the memory size in bytes
+ * Return: the memory size in bytes.
  */
 static u32 edac_get_memsize(void)
 {
@@ -325,8 +323,8 @@ static u32 edac_get_memsize(void)
 }
 
 /**
- * edac_get_mtype - Returns controller memory type
- * @base:	pointer to the synopsys ecc status structure
+ * edac_get_mtype - Returns controller memory type.
+ * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
  * configuration.
@@ -349,11 +347,11 @@ static enum mem_type edac_get_mtype(const void __iomem *base)
 }
 
 /**
- * edac_init_csrows - Initialize the cs row data
- * @mci:	Pointer to the edac memory controller instance
+ * edac_init_csrows - Initialize the cs row data.
+ * @mci:	EDAC memory controller instance.
  *
  * Initializes the chip select rows associated with the EDAC memory
- * controller instance
+ * controller instance.
  *
  * Return: Unconditionally 0.
  */
@@ -383,9 +381,9 @@ static int edac_init_csrows(struct mem_ctl_info *mci)
 }
 
 /**
- * edac_mc_init - Initialize driver instance
- * @mci:	Pointer to the edac memory controller instance
- * @pdev:	Pointer to the platform_device struct
+ * edac_mc_init - Initialize driver instance.
+ * @mci:	EDAC memory controller instance.
+ * @pdev:	platform_device struct.
  *
  * Performs initialization of the EDAC memory controller instance and
  * related driver-private data associated with the memory controller the
@@ -424,8 +422,8 @@ static int edac_mc_init(struct mem_ctl_info *mci,
 }
 
 /**
- * synps_edac_mc_probe - Check controller and bind driver
- * @pdev:	Pointer to the platform_device struct
+ * synps_edac_mc_probe - Check controller and bind driver.
+ * @pdev:	platform_device struct.
  *
  * Probes a specific controller instance for binding with the driver.
  *
@@ -496,8 +494,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 }
 
 /**
- * synps_edac_mc_remove - Unbind driver from controller
- * @pdev:	Pointer to the platform_device struct
+ * synps_edac_mc_remove - Unbind driver from controller.
+ * @pdev:	Platform_device struct.
  *
  * Return: Unconditionally 0
  */
-- 
2.1.1

