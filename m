Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4CAECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ADA20857
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="d19wRSTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62ADA20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbeGSSnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:53 -0400
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:19918
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731774AbeGSSnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUcq/M7t2HWx4lK4/dEwizXnWkU8JblI/qNeQ9+2+NM=;
 b=d19wRSTDd4lDhd1eTZEczGLAcmtsriAd0YEwe5bvyabhGpZG9Nrd0RofCUS+aNP2in/qcRKG5Z73QcmDGtWzfqtXQvB7wPd/Ba0J8oyFXePOD5c4OAQAcuqr9Iachk1QDblu4eCAPDrYXv3NjATYcvQ4mwdOLe9EGHF/QEXBJrM=
Received: from CY1PR07CA0026.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::36) by SN6PR07MB4720.namprd07.prod.outlook.com
 (2603:10b6:805:3b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Thu, 19 Jul
 2018 17:59:23 +0000
Received: from DM3NAM05FT057.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by CY1PR07CA0026.outlook.office365.com
 (2a01:111:e400:c60a::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:23 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT057.mail.protection.outlook.com (10.152.98.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:22 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAS9019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:21 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:30 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:29 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxEEe005914;
        Thu, 19 Jul 2018 18:59:14 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxEh0005902;
        Thu, 19 Jul 2018 18:59:14 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 19/31] usb: usbssp: added support for USB enumeration process.
Date:   Thu, 19 Jul 2018 18:57:52 +0100
Message-ID: <1532023084-28083-20-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(189003)(199004)(36092001)(336012)(54906003)(26005)(4326008)(186003)(36756003)(316002)(51416003)(50226002)(551934003)(109986005)(107886003)(76176011)(8936002)(42186006)(16586007)(426003)(1671002)(305945005)(87636003)(5660300001)(7636002)(4720700003)(246002)(14444005)(126002)(11346002)(446003)(106466001)(48376002)(6666003)(2906002)(26826003)(356003)(8676002)(478600001)(486006)(47776003)(476003)(50466002)(2616005)(105596002)(575784001)(86362001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4720;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT057;1:HT+kmoVlAj0oPN5cNkm1JPNP7/+dxm7Ftu1DlLnxIDszk+gBRA971Tp/GfLZ9dmX/oqGoIUnPPiGzqyp3ENU///cpars7vo0nShy8149kmdUo2bvinpIPgiQatos6WWo
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62489680-37c0-4a75-7a4b-08d5eda15be9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN6PR07MB4720;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;3:pswi8Xj1ZJfGkFlh6oupe/mIy/SRK5H4GgfA4u0pLKDF+RRCynPAWR10H9WvtUT8P22EFFzI0LPCkeijK1G9yrWPeE6cxGL4WmdC3jqGH65UPBP9ijTZFJ27PKjEuT6SEFlOQVspPqE9BMNEDWjfiSnfqNf6Cuurls2MgIwLL5VKfpej3HOI4r63au00gkjqyOzdHLao8svuW2v0+SrAPHU9v9BwEDSpI0mTSq6z4SR2pYHIFSp5yUeFqPIBeJtZheQ7PP80sMsi/cKy1/5B05/fcW5OgW8RiH1+7k3+aEEwmBqzl4sEnTK8fUcJnvnwhji8cR6JM7pTqMeqL0qKFzAvvVcSmjMaWnpsvDnA0rI=;25:UemUHiW+TDkXD9JsW/bG4frI7OMEaruovpOJXqvMlZv5HFX/h+b6X5yCIwphyq9VqkUIHTNiKnFVIE4cEbxEZNwKZkAjsf+M6EdCwnSyYHQl0nHrLG9EuvBP9m6SNpy3yu2Nyr/w68TEEvPrwUNCNtL435lLG8JEqJMptIHKOo86PAxfFQNEUPc+lQY30/3CIBtwnCIkdnjLvXdgvpuWMQxo6v92aKUXG74dtJAwCXySuA9eD9LOKfSKcorb1dx9BoOa0JrN8nyeVgUJsDga2lUBzInI9ggfIhFj8tYwcdtEKRnzYHfOH0SJO0cTFFRdnbYWggsZbxV+uKn2a/qtFQ==
X-MS-TrafficTypeDiagnostic: SN6PR07MB4720:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;31:Vj/M5K1LU23vdw5cicFNbJRMwh4my8Y4+DtskjD6YTPp2y/xVVuCjBbxpZfWqwMA0+TTGBv+/Cd1G693ukOKNCqfjoGuWNa8OG9o7xSLXXFzFJStea8ikR5YpOxwUf8xXicewCwjolfRA/s5MM5etjSVPxCGG8Nv8PjM9rOgA/vOmP6/zZI18yN/WZTVXn9kuUCII5u0QfeRruZMqzss2noF3Xa6mcRzCMXpzqKj8N0=;20:MovIaBsC3Q5TnIn8g4REJ23cK74LK1/wlm8CzLH1nEQO2JezG/GK3wvzzuLouWK1+JwUOnVyiGB7Dw0wX1moDK98JBIP2bEYgX8JlBFbZA6k/R7F48hdy2figy1RqYKLpjAtR5JbNI0zEysaZ9LEF0Htz0nsMCqQRBNsM/JJKn5BczChxIvhyxddjTSRGV6PgiNPAcz9pi5cqsZ5Vk7MwtirZTr6JUtoHsMOcVol3wyhKryalPki1LQx1HYx4Xd0mCaOGaDmtH+u3PEyoodX/Z2DuCidluZgetNbvBMzEiYeqOVxx8R1amEPBoJFsF568oXrFslB4EpEIOJTGeqQMtiZ9SqajQzG7t4+H18PjrZOT7FqQrJZPK3FuU2qJYFC/JhQhmfVsZ4uhPUPzNa31FDY7Rn44lsv6ztjh7Gb48D22swcEkPk/bh6ZVt/Z/ZqTO+xTaCEBdF+IyzT1u9yucLakjR8r86fkK2ho+m1CNcYUWLKbvnx1LY3aGkQTMSz
X-Microsoft-Antispam-PRVS: <SN6PR07MB4720419095B9D045F83C04AEDD520@SN6PR07MB4720.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4720;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4720;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;4:yP81rdiMo1fvk1xZ2I7+0Y0BaO7MXoIQZM3XCVv1BnMCNISNvZFUAjfqjnCjsM9YlLAGIQw5h1E7gukGb6z/SsWjMUTpBmhmFnAzMwFrffZwrTDAeYDWq0ae6qschHRGSQicBJYWO0nEYhf5WvZnvsmGjtKXdehX92hwfpFBqHCevz5xdLBgV1xeF0ByLWF3VCFQL0KLqsTy6W1mBe1G+KXNe8jcoZbd+7HDqYnTnE7LEWKDX94RnX0/Yhi5zfG7spTGUoNenhEiqr7PuTjInftWSivcRfTJbut2wV1/Ov2Ii0wAN24q5jnYYi/RbNZo
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4720;23:UgHpnmZABXklc8CG18qm1ZyVKZ59z24gUeLZ0cxpi?=
 =?us-ascii?Q?LqUlXj3yI79mdmYXCAS1OeoTZ85R3fAxLJusjfb+dBltiCpprClAoPA0Ilcq?=
 =?us-ascii?Q?r1G8Gm8IVkB0D0u1fGGwMBTqJ5PAyQvIJl65CZ7nnauE+yHsSeR19QfLvfyj?=
 =?us-ascii?Q?YQHI7qjCBGW/IPdKs/vUGrbP3l9erEinEUZa5zFJZze6r2eSjuUkzkyBxvkt?=
 =?us-ascii?Q?NFimkEooHT+PqSDaE+McemO0J6r4PdGhhWrGgnxAmBR+WyOwnGhuPA7waoL7?=
 =?us-ascii?Q?2lj945Ztq58i4p0y9PIFMmzJooVX3mBXIJoNihkKJYKnKKYT6TTiGWRM929D?=
 =?us-ascii?Q?Vh3K+aJmhzIPhH4THjriMHohxZmUxbT21y1zcVDNkvcdLb9iLCdm9tPQh0nI?=
 =?us-ascii?Q?T4LacA0LyqNYA0XVV3pAeB1htsCEt5dGooB8T8Kk4aYTiK97ILxpvBeEcqz6?=
 =?us-ascii?Q?52BTsSMtO/ZA+FDF9HNLI/Xd1lbMPejGKcDSzBSdT7cGBLSKIlIzzWXQKmCD?=
 =?us-ascii?Q?BM/iiCEnph1qCyAw6Wl29bwK2g35LYZdZX+kSgY/wt1TrPf/TQLteqBOsYDn?=
 =?us-ascii?Q?XTaUb5Q6EyvOByOQTM0OyYePHjFKJHzbtXmpJHc0hdQYc9Vj48Eq818kRke6?=
 =?us-ascii?Q?o/eNUkd6d8BMy3V/RXmZGxCZblnMFznDZaZPqC19kQFIUq8G3YtA3z7YBewW?=
 =?us-ascii?Q?WD2NQ9u1xB/+nyjhq1VbUR4Ul9kZb53RXmxe0EuAnZU3iaFYEBXlDXZalmTG?=
 =?us-ascii?Q?AnZ4eAAFtq8SUH7V9PPdyJXHHAjEtk7FxUePL4jp4zrOfCoakEjMwunGKEPw?=
 =?us-ascii?Q?BsVKgOAxp9SOJkV+FlXx0k1cMazzn+KludOn4+QMLGcu/RkiTQhnw3Qv+zmN?=
 =?us-ascii?Q?9aUONHL6NnxE5HhHzMQWUP+82lg2m/a4NN8AKs+StuzITF2GC+r/F07nGE+u?=
 =?us-ascii?Q?BFp7y2hEaB3xdc8EZCnVOPQTyrNCIc/X5Zzh7CfXNeOf2gAKJWy8827UlX0T?=
 =?us-ascii?Q?U1Cp82LRfUe+ZSKfArudjepk+iWKVYhOOoBpCqTfdUsf6KNEQDtaxoR+aAIE?=
 =?us-ascii?Q?XxBnW2MgoPNRGglFebFfloooG0nE98njwdKOd4KknmMPIzDpx2hewOh1+Nw8?=
 =?us-ascii?Q?ylfd5xEzG1HULf+cawcb22JBADwGMfDoQ0pP23E8wWrVEta9NzGcIyW8jhd3?=
 =?us-ascii?Q?OkZPkrurKWuSjT/Hf8YDIsMuy820CkIperm?=
X-Microsoft-Antispam-Message-Info: bLKebz2tu4bVdWxDpHx2fYELkEC4ykuUcaJwhO6CNLeN7cb0LtsdDGSAOKzhm5bIEmCWup1eG5J0VBTZjM4cJsgZt/zeQRZ0UBTliNVS/dp8mzUBfzdXtsRdLHFtVQdyh3UXVv8sg5ZMDFiloSfKdXghPvv6kAr0GgRO9WJEQSsrDq2TVmptaeQ/eukaDG+xFJV6CiC2dj3a5q4QnwSUrO6WOyBXEjY7jqeKGLb+t6nYBfqYJ7WlT5KZ9j4dayBIRZP0blf3o5nHoXrCiPeIlJYfuRIpYFMNgm/o/tZAseuyvOVnbcyWRVCvLcmMcDDi8j56g7eWgFxHMJKwci4blKJ5x7sQh7RhsrTH88ifECFyxBsvB/xPAa4DyKs8zCFDdCGm7z6RpM5BNsLseWJr1g==
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;6:BRVC/VD8mb9MeiS4ivxYuiPI5g7vHWId2sxk+VAX4mlcFml4tg1SXJKET/Nj2a3WQG4a2YfGlj/l3eSawE389NhL4yPTFWYLC9fLrxAOmhWH657V3Ea9nEGWe9zhC5BAjHefSZN4BHxCV/3RG9YzrGJUyZedbB/VtuPgQ2tDTLlmaNPBG/FEl6uqWX5Zgszmub1dF+vhr5Rh2f8vYXsXU3oxb2ccXhHwI0WRNPbl0voWgsHBE2dtBs4d/MQYQpvSVeybxxWvDKvLeY8GwLkme2ffKz8j2JsS8ZfcaTBr+PdHmIncl9Co028Z/LS/fX1p38HDN8qHmRAH/KF9HyZUtjDGc69Ib6dRT/aXxW2IZ3m/G1hn5Ay7ZbtT22ghUCfMrN4LF7gsBLrUBahtV+qzv4d/SgZyf9j78C1Orip7aVr5ZGzZR8dcRg/WX1kcEF0z/NAfsVn8733f3bWU5qUevQ==;5:c7NaA2dLav6HsFW4KUW/axYi+hJQZv+4DomYLjg9Zv3rXo55mBVx64QamVhDIz+6x2FDodBSmvCJXgdSnSnE2Gv5GnIZFOeFe4RFaznhj636TeVbC2mhi55Qe0mhlLzT4J+tRv3Gpocij14jd+hUW9JYDuK0MQ3nGx5+hM9LFwM=;24:/fMGSAplqapZaO6RNCvdXffAHfUvpaDikiAnk9FKuF+SmNiydxRXfD8MIe0Ep21dxbUMQlY7ZG8U4yGVW/TETYy3ynfN9MNZIsXF/OKlbQM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;7:Oalv7zW/1codrF0B/TnHULmLgZEfVmyNo97LMbLHqqz8kn5TaEGOoXzrdvPhIllaeKarmvROvcYeZZlOo4VSn7APoaKSKRAKVXMod+S9NmjYJ3UnHsF3HKMK56x6E5HO2RiCwggaAHOa82PO9WPCaljgb+ACi20cePhfrBjEouv5KRB5uQ8AU/HUWjkksXXJbaHtgsFTqusS0s2eK4Nw+XnhPjnuAY75DkQrLxzS8YuxFCtlVVrAQEP5hB8PTEGx;20:v5Zodp7TmeugfnSrZ6JTXScIJIvmF2DaPTnTPAKP8CYMdEGgdZFq7Y5G4daefwCePig+Fh2rt3aXUgWsp8rd37cIZTtqwVVDFL8L5hqm9MZKY8cmWyd4L6tzX6zdDd7TtgPt+V0e7VTla/MLog2KnOjUKovyJUw/Uyqron5NBJIm7HjkMZywgGXrCq9BZ6C+K8cJBBr/P5PzBAVD+/fhS288uxz7xsRQSg9AUAkD9LtWBwU4obDlSMT5DynqPU18
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:22.7369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62489680-37c0-4a75-7a4b-08d5eda15be9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4720
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements a set of functions used during
USB device enumeration process. Added code analyzes
received SETUP packet and decides whether packet should
be handled by usbssp driver or should be delegated
to gadget core driver.

This patch also introduces usbssp_ep0_stall function that
sends STALL to host when received SETUP packet can't be
handled.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ep0.c  | 511 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget-if.c   |  32 ++
 drivers/usb/usbssp/gadget-ring.c |  18 ++
 drivers/usb/usbssp/gadget.c      |  43 ++-
 drivers/usb/usbssp/gadget.h      |   9 +
 5 files changed, 611 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-ep0.c b/drivers/usb/usbssp/gadget-ep0.c
index c889a3102740..3b7066875d46 100644
--- a/drivers/usb/usbssp/gadget-ep0.c
+++ b/drivers/usb/usbssp/gadget-ep0.c
@@ -15,9 +15,518 @@
 #include <linux/usb/composite.h>
 #include "gadget-trace.h"
 
+static void usbssp_ep0_stall(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_ep *dep;
+	int ret = 0;
+
+	dep = &usbssp_data->devs.eps[0];
+	if (usbssp_data->three_stage_setup) {
+		dev_dbg(usbssp_data->dev, "Send STALL on Data Stage\n");
+		ret = usbssp_halt_endpoint(usbssp_data, dep, true);
+
+		/*
+		 * Finishing SETUP transfer by removing request
+		 * from pending list
+		 */
+		if (!list_empty(&dep->pending_list)) {
+			struct usbssp_request	*req;
+
+			req = next_request(&dep->pending_list);
+			usbssp_giveback_request_in_irq(usbssp_data,
+						req->td, -ECONNRESET);
+			dep->ep_state = USBSSP_EP_ENABLED;
+		}
+	} else {
+		dev_dbg(usbssp_data->dev, "Send STALL on Status Stage\n");
+		dep->ep_state |= EP0_HALTED_STATUS;
+		usbssp_status_stage(usbssp_data);
+	}
+	usbssp_data->delayed_status = false;
+}
+
+static int usbssp_ep0_delegate_req(struct usbssp_udc *usbssp_data,
+				   struct usb_ctrlrequest *ctrl)
+{
+	int ret;
+
+	dev_dbg(usbssp_data->dev, "Delagate request to gadget driver\n");
+	spin_unlock(&usbssp_data->irq_thread_lock);
+
+	ret = usbssp_data->gadget_driver->setup(&usbssp_data->gadget, ctrl);
+	spin_lock(&usbssp_data->irq_thread_lock);
+
+	return ret;
+}
+
+static int usbssp_ep0_set_config(struct usbssp_udc *usbssp_data,
+				 struct usb_ctrlrequest *ctrl)
+{
+	enum usb_device_state state = usbssp_data->gadget.state;
+	u32 cfg;
+	int ret;
+
+	cfg = le16_to_cpu(ctrl->wValue);
+	switch (state) {
+	case USB_STATE_DEFAULT:
+		dev_err(usbssp_data->dev,
+			"Error: Set Config request from Default state\n");
+		return -EINVAL;
+	case USB_STATE_ADDRESS:
+		dev_dbg(usbssp_data->dev,
+			"Set Configuration from addressed state\n");
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+		/* if the cfg matches and the cfg is non zero */
+		if (cfg && (!ret || (ret == USB_GADGET_DELAYED_STATUS))) {
+			/*
+			 * only change state if set_config has already
+			 * been processed. If gadget driver returns
+			 * USB_GADGET_DELAYED_STATUS, we will wait
+			 * to change the state on the next usbssp_enqueue()
+			 */
+			if (ret == 0) {
+				dev_info(usbssp_data->dev,
+					"Device has been configured\n");
+				usb_gadget_set_state(&usbssp_data->gadget,
+						USB_STATE_CONFIGURED);
+			}
+		}
+		break;
+	case USB_STATE_CONFIGURED:
+		dev_dbg(usbssp_data->dev,
+			"Set Configuration from Configured state\n");
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+		if (!cfg && !ret) {
+			dev_info(usbssp_data->dev, "reconfigured device\n");
+			usb_gadget_set_state(&usbssp_data->gadget,
+					USB_STATE_ADDRESS);
+		}
+		break;
+	default:
+		dev_err(usbssp_data->dev,
+			"Set Configuration - incorrect device state\n");
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int usbssp_ep0_set_address(struct usbssp_udc *usbssp_data,
+				  struct usb_ctrlrequest *ctrl)
+{
+	enum usb_device_state state = usbssp_data->gadget.state;
+	u32 addr;
+	unsigned int slot_state;
+	struct usbssp_slot_ctx *slot_ctx;
+	int dev_state = 0;
+
+	addr = le16_to_cpu(ctrl->wValue);
+	if (addr > 127) {
+		dev_err(usbssp_data->dev, "invalid device address %d\n", addr);
+		return -EINVAL;
+	}
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, usbssp_data->devs.out_ctx);
+	dev_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+
+	if (state == USB_STATE_CONFIGURED) {
+		dev_err(usbssp_data->dev,
+			"can't SetAddress() from Configured State\n");
+		return -EINVAL;
+	}
+
+	usbssp_data->device_address = le16_to_cpu(ctrl->wValue);
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, usbssp_data->devs.out_ctx);
+	slot_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+
+	if (slot_state == SLOT_STATE_ADDRESSED) {
+		/*Reset Device Command*/
+		usbssp_data->defered_event &= ~EVENT_USB_RESET;
+		queue_work(usbssp_data->bottom_irq_wq,
+			&usbssp_data->bottom_irq);
+		usbssp_reset_device(usbssp_data);
+	}
+
+	/*set device address*/
+	usbssp_address_device(usbssp_data);
+
+	if (addr)
+		usb_gadget_set_state(&usbssp_data->gadget, USB_STATE_ADDRESS);
+	else
+		usb_gadget_set_state(&usbssp_data->gadget, USB_STATE_DEFAULT);
+	return 0;
+}
+
 int usbssp_status_stage(struct usbssp_udc *usbssp_data)
 {
-	/*TODO; function must to be implemented*/
+	struct usbssp_ring *ep_ring;
+	int ret;
+	struct usbssp_ep *dep;
+
+	dep = &usbssp_data->devs.eps[0];
+	ep_ring = usbssp_data->devs.eps[0].ring;
+
+	dev_dbg(usbssp_data->dev, "Enqueue Status Stage\n");
+	usbssp_data->ep0state = USBSSP_EP0_STATUS_PHASE;
+	usbssp_data->usb_req_ep0_in.request.length = 0;
+	ret = usbssp_enqueue(usbssp_data->usb_req_ep0_in.dep,
+			&usbssp_data->usb_req_ep0_in);
+	return ret;
+}
+
+
+static int usbssp_ep0_handle_feature_u1(struct usbssp_udc *usbssp_data,
+					enum usb_device_state state, int set)
+{
+	__le32 __iomem *port_regs;
+	u32 temp;
+
+	if (state != USB_STATE_CONFIGURED) {
+		dev_err(usbssp_data->dev,
+			"Error: can't change U1 - incorrect device state\n");
+		return -EINVAL;
+	}
+
+	if ((usbssp_data->gadget.speed != USB_SPEED_SUPER) &&
+	    (usbssp_data->gadget.speed != USB_SPEED_SUPER_PLUS)) {
+		dev_err(usbssp_data->dev,
+			"Error: U1 is supported only for SS and SSP\n");
+		return -EINVAL;
+	}
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+
+	temp = readl(port_regs+PORTPMSC);
+	temp &= ~PORT_U1_TIMEOUT_MASK;
+
+	if (set)
+		temp |= PORT_U1_TIMEOUT(1);
+	else
+		temp |= PORT_U1_TIMEOUT(0);
+
+	dev_info(usbssp_data->dev, "U1 %s\n", set ? "enabled" : "disabled");
+	writel(temp, port_regs+PORTPMSC);
+
+	usbssp_status_stage(usbssp_data);
+	return 0;
+}
+
+static int usbssp_ep0_handle_feature_u2(struct usbssp_udc *usbssp_data,
+					enum usb_device_state state, int set)
+{
+	__le32 __iomem *port_regs;
+	u32 temp;
+
+	if (state != USB_STATE_CONFIGURED) {
+		dev_err(usbssp_data->dev,
+			"Error: can't change U2 - incorrect device state\n");
+		return -EINVAL;
+	}
+	if ((usbssp_data->gadget.speed != USB_SPEED_SUPER) &&
+	    (usbssp_data->gadget.speed != USB_SPEED_SUPER_PLUS)) {
+		dev_err(usbssp_data->dev,
+			"Error: U2 is supported only for SS and SSP\n");
+		return -EINVAL;
+	}
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(port_regs+PORTPMSC);
+	temp &= ~PORT_U1_TIMEOUT_MASK;
+
+	if (set)
+		temp |= PORT_U2_TIMEOUT(1);
+	else
+		temp |= PORT_U2_TIMEOUT(0);
+
+	writel(temp, port_regs+PORTPMSC);
+	dev_info(usbssp_data->dev, "U2 %s\n", set ? "enabled" : "disabled");
+
+	usbssp_status_stage(usbssp_data);
+	return 0;
+}
+
+static int usbssp_ep0_handle_feature_device(struct usbssp_udc *usbssp_data,
+					    struct usb_ctrlrequest *ctrl,
+					    int set)
+{
+	enum usb_device_state state;
+	u32 wValue;
+	u32 wIndex;
+	int ret = 0;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+	wIndex = le16_to_cpu(ctrl->wIndex);
+	state = usbssp_data->gadget.state;
+
+	switch (wValue) {
+	case USB_DEVICE_REMOTE_WAKEUP:
+		usbssp_data->remote_wakeup_allowed = (set) ? 1 : 0;
+		break;
+	/*
+	 * 9.4.1 says only only for SS, in AddressState only for
+	 * default control pipe
+	 */
+	case USB_DEVICE_U1_ENABLE:
+		ret = usbssp_ep0_handle_feature_u1(usbssp_data, state, set);
+		break;
+	case USB_DEVICE_U2_ENABLE:
+		ret = usbssp_ep0_handle_feature_u2(usbssp_data, state, set);
+		break;
+	case USB_DEVICE_LTM_ENABLE:
+		ret = -EINVAL;
+		break;
+	default:
+		dev_err(usbssp_data->dev, "%s Feature Request not supported\n",
+			(set) ? "Set" : "Clear");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int usbssp_ep0_handle_feature_intf(struct usbssp_udc *usbssp_data,
+					  struct usb_ctrlrequest *ctrl,
+					  int set)
+{
+	u32 wValue;
+	int ret = 0;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+
+	switch (wValue) {
+	case USB_INTRF_FUNC_SUSPEND:
+		/*TODO: suspend device */
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int usbssp_ep0_handle_feature_endpoint(struct usbssp_udc *usbssp_data,
+					      struct usb_ctrlrequest *ctrl, int set)
+{
+	struct usbssp_ep *dep;
+	u32 wValue, wIndex;
+	unsigned int ep_index = 0;
+	struct usbssp_ring *ep_ring;
+	struct usbssp_td *td;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+	wIndex = le16_to_cpu(ctrl->wIndex);
+	ep_index = ((wIndex & USB_ENDPOINT_NUMBER_MASK) << 1);
+
+	if ((wIndex & USB_ENDPOINT_DIR_MASK) == USB_DIR_OUT)
+		ep_index -= 1;
+
+	dep = &usbssp_data->devs.eps[ep_index];
+	ep_ring = dep->ring;
+
+	switch (wValue) {
+	case USB_ENDPOINT_HALT:
+		if (set == 0 && (dep->ep_state & USBSSP_EP_WEDGE))
+			break;
+
+		usbssp_halt_endpoint(usbssp_data, dep, set);
+
+		td = list_first_entry(&ep_ring->td_list, struct usbssp_td,
+				td_list);
+
+		usbssp_cleanup_halted_endpoint(usbssp_data, ep_index,
+					ep_ring->stream_id, td,
+					EP_HARD_RESET);
+		break;
+	default:
+		dev_warn(usbssp_data->dev, "WARN Incorrect wValue %04x\n",
+			wValue);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int usbssp_ep0_handle_feature(struct usbssp_udc *usbssp_data,
+			      struct usb_ctrlrequest *ctrl, int set)
+{
+	u32 recip;
+	int ret;
+
+	recip = ctrl->bRequestType & USB_RECIP_MASK;
+
+	switch (recip) {
+	case USB_RECIP_DEVICE:
+		ret = usbssp_ep0_handle_feature_device(usbssp_data, ctrl, set);
+		break;
+	case USB_RECIP_INTERFACE:
+		ret = usbssp_ep0_handle_feature_intf(usbssp_data, ctrl, set);
+		break;
+	case USB_RECIP_ENDPOINT:
+		ret = usbssp_ep0_handle_feature_endpoint(usbssp_data,
+							ctrl, set);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int usbssp_ep0_set_sel(struct usbssp_udc *usbssp_data,
+			      struct usb_ctrlrequest *ctrl)
+{
+	struct usbssp_ep *dep;
+	enum usb_device_state state = usbssp_data->gadget.state;
+	u16 wLength;
+	int ret = 0;
+
+	if (state == USB_STATE_DEFAULT)
+		return -EINVAL;
+
+	wLength = le16_to_cpu(ctrl->wLength);
+
+	if (wLength != 6) {
+		dev_err(usbssp_data->dev, "Set SEL should be 6 bytes, got %d\n",
+			wLength);
+		return -EINVAL;
+	}
+
+	/*
+	 * To handle Set SEL we need to receive 6 bytes from Host. So let's
+	 * queue a usb_request for 6 bytes.
+	 */
+	dep = &usbssp_data->devs.eps[0];
+
+	usbssp_data->usb_req_ep0_in.request.length = 0x6;
+	usbssp_data->usb_req_ep0_in.request.buf = usbssp_data->setup_buf;
+
+	ret = usbssp_enqueue(usbssp_data->usb_req_ep0_in.dep,
+			&usbssp_data->usb_req_ep0_in);
+	if (ret) {
+		dev_err(usbssp_data->dev, "Error in Set Sel\n");
+		return ret;
+	}
 	return 0;
 }
 
+static int usbssp_ep0_std_request(struct usbssp_udc *usbssp_data,
+				  struct usb_ctrlrequest *ctrl)
+{
+	int ret = 0;
+
+	usbssp_data->bos_event_detected = 0;
+
+	switch (ctrl->bRequest) {
+	case USB_REQ_GET_STATUS:
+		dev_info(usbssp_data->dev, "Request GET_STATUS\n");
+		/*TODO:*/
+		//ret = usbssp_ep0_handle_status(usbssp_data, ctrl);
+		break;
+	case USB_REQ_CLEAR_FEATURE:
+		dev_info(usbssp_data->dev, "Request CLEAR_FEATURE\n");
+		ret = usbssp_ep0_handle_feature(usbssp_data, ctrl, 0);
+		break;
+	case USB_REQ_SET_FEATURE:
+		dev_info(usbssp_data->dev, "Request SET_FEATURE\n");
+		ret = usbssp_ep0_handle_feature(usbssp_data, ctrl, 1);
+		break;
+	case USB_REQ_SET_ADDRESS:
+		dev_info(usbssp_data->dev, "Request SET_ADDRESS\n");
+		ret = usbssp_ep0_set_address(usbssp_data, ctrl);
+		break;
+	case USB_REQ_SET_CONFIGURATION:
+		dev_info(usbssp_data->dev, "Request SET_CONFIGURATION\n");
+		ret = usbssp_ep0_set_config(usbssp_data, ctrl);
+		break;
+	case USB_REQ_SET_SEL:
+		dev_info(usbssp_data->dev, "Request SET_SEL\n");
+		ret = usbssp_ep0_set_sel(usbssp_data, ctrl);
+		break;
+	case USB_REQ_SET_ISOCH_DELAY:
+		dev_info(usbssp_data->dev, "Request SET_ISOCH_DELAY\n");
+		/*TODO:*/
+		//ret = usbssp_ep0_set_isoch_delay(usbssp_data, ctrl);
+		break;
+	default:
+		if ((le16_to_cpu(ctrl->wValue) >> 8) == USB_DT_BOS &&
+		    ctrl->bRequest == USB_REQ_GET_DESCRIPTOR) {
+			/*
+			 * It will be handled after Status Stage phase
+			 * in usbssp_gadget_giveback
+			 */
+			usbssp_data->bos_event_detected = true;
+		}
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+		break;
+	}
+	return ret;
+}
+
+int usbssp_setup_analyze(struct usbssp_udc *usbssp_data)
+{
+	int ret = -EINVAL;
+	struct usb_ctrlrequest *ctrl = &usbssp_data->setup;
+	u32 len = 0;
+	struct usbssp_device *priv_dev;
+
+	ctrl = &usbssp_data->setup;
+
+	dev_info(usbssp_data->dev,
+			"SETUP BRT: %02x BR: %02x V: %04x I: %04x L: %04x\n",
+			ctrl->bRequestType, ctrl->bRequest,
+			le16_to_cpu(ctrl->wValue), le16_to_cpu(ctrl->wIndex),
+			le16_to_cpu(ctrl->wLength));
+
+	if (!usbssp_data->gadget_driver)
+		goto out;
+
+	priv_dev = &usbssp_data->devs;
+
+	/*
+	 * First of all, if endpoint 0 was halted driver has to
+	 * recovery it.
+	 */
+	if (priv_dev->eps[0].ep_state & EP_HALTED) {
+		dev_dbg(usbssp_data->dev,
+			"Ep0 Halted - restoring to nomral state\n");
+		usbssp_halt_endpoint(usbssp_data, &priv_dev->eps[0], 0);
+	}
+
+	/*
+	 * Finishing previous SETUP transfer by removing request from
+	 * list and informing upper layer
+	 */
+	if (!list_empty(&priv_dev->eps[0].pending_list)) {
+		struct usbssp_request	*req;
+
+		dev_dbg(usbssp_data->dev,
+			"Deleting previous Setup transaction\n");
+		req = next_request(&priv_dev->eps[0].pending_list);
+		usbssp_dequeue(&priv_dev->eps[0], req);
+	}
+
+	len = le16_to_cpu(ctrl->wLength);
+	if (!len) {
+		usbssp_data->three_stage_setup = false;
+		usbssp_data->ep0_expect_in = false;
+	} else {
+		usbssp_data->three_stage_setup = true;
+		usbssp_data->ep0_expect_in =
+				!!(ctrl->bRequestType & USB_DIR_IN);
+	}
+
+	if ((ctrl->bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
+		ret = usbssp_ep0_std_request(usbssp_data, ctrl);
+	else
+		ret = usbssp_ep0_delegate_req(usbssp_data, ctrl);
+
+	if (ret == USB_GADGET_DELAYED_STATUS) {
+		dev_dbg(usbssp_data->dev, "Status Stage delayed\n");
+		usbssp_data->delayed_status = true;
+	}
+
+out:
+	if (ret < 0)
+		usbssp_ep0_stall(usbssp_data);
+
+	return ret;
+}
diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index ef466aa47f56..dbff5a400676 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -133,6 +133,38 @@ static const struct usb_ep_ops usbssp_gadget_ep_ops = {
 	.set_wedge	= usbssp_gadget_ep_set_wedge,
 };
 
+void usbssp_gadget_giveback(struct usbssp_ep *ep_priv,
+			    struct usbssp_request *req_priv, int status)
+{
+	struct usbssp_udc *usbssp_data = ep_priv->usbssp_data;
+
+	list_del(&req_priv->list);
+
+	if (req_priv->request.status == -EINPROGRESS)
+		req_priv->request.status = status;
+
+	usb_gadget_unmap_request_by_dev(usbssp_data->dev,
+				&req_priv->request, req_priv->direction);
+
+	trace_usbssp_request_giveback(&req_priv->request);
+
+	if (in_interrupt())
+		spin_unlock(&usbssp_data->lock);
+	else
+		spin_unlock(&usbssp_data->irq_thread_lock);
+
+	if (req_priv != &usbssp_data->usb_req_ep0_in) {
+		usb_gadget_giveback_request(&ep_priv->endpoint,
+					&req_priv->request);
+	}
+
+	if (in_interrupt())
+		spin_lock(&usbssp_data->lock);
+	else
+		spin_lock(&usbssp_data->irq_thread_lock);
+
+}
+
 static struct usb_endpoint_descriptor usbssp_gadget_ep0_desc = {
 	.bLength =		USB_DT_ENDPOINT_SIZE,
 	.bDescriptorType =	USB_DT_ENDPOINT,
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 59ba92494a56..1b57f5180115 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -310,6 +310,24 @@ static void ring_doorbell_for_active_rings(struct usbssp_udc *usbssp_data,
 	}
 }
 
+/* Must be called with usbssp_data->lock held in interrupt context
+ * or usbssp_data->irq_thread_lock from thread conext (defered interrupt)
+ */
+void usbssp_giveback_request_in_irq(struct usbssp_udc *usbssp_data,
+				    struct usbssp_td *cur_td,
+				    int status)
+{
+	struct usb_request	*req;
+	struct usbssp_request	*req_priv;
+
+	req_priv = cur_td->priv_request;
+	req = &req_priv->request;
+
+	usbssp_request_free_priv(req_priv);
+
+	usbssp_gadget_giveback(req_priv->dep, req_priv, status);
+}
+
 /*
  * When we get a command completion for a Stop Endpoint Command, we need to
  * stop timer and clear EP_STOP_CMD_PENDING flag.
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 5102dd31c881..2fd6d27ef0bd 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -94,7 +94,9 @@ void usbssp_bottom_irq(struct work_struct *work)
 
 	/*handle setup packet*/
 	if (usbssp_data->defered_event & EVENT_SETUP_PACKET) {
-		/*TODO: implement handling of SETUP packet*/
+		dev_dbg(usbssp_data->dev, "Beginning handling SETUP packet\n");
+		usbssp_data->defered_event &= ~EVENT_SETUP_PACKET;
+		usbssp_setup_analyze(usbssp_data);
 	}
 
 	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
@@ -397,6 +399,45 @@ static int usbssp_check_args(struct usbssp_udc *usbssp_data,
 	return 1;
 }
 
+int usbssp_enqueue(struct usbssp_ep *dep, struct usbssp_request *req_priv)
+{
+	/*TODO: this function must be implemented*/
+	return 0;
+}
+
+/*
+ * Remove the request's TD from the endpoint ring. This may cause the DC to stop
+ * USB transfers, potentially stopping in the middle of a TRB buffer. The DC
+ * should pick up where it left off in the TD, unless a Set Transfer Ring
+ * Dequeue Pointer is issued.
+ *
+ * The TRBs that make up the buffers for the canceled request will be "removed"
+ * from the ring. Since the ring is a contiguous structure, they can't be
+ * physically removed. Instead, there are two options:
+ *
+ *  1) If the DC is in the middle of processing the request to be canceled, we
+ *     simply move the ring's dequeue pointer past those TRBs using the Set
+ *    Transfer Ring Dequeue Pointer command. This will be the common case,
+ *     when drivers timeout on the last submitted request and attempt to cancel.
+ *
+ *  2) If the DC is in the middle of a different TD, we turn the TRBs into a
+ *     series of 1-TRB transfer no-op TDs. (No-ops shouldn't be chained.) The
+ *     DC will need to invalidate the any TRBs it has cached after the stop
+ *     endpoint command.
+ *
+ *  3) The TD may have completed by the time the Stop Endpoint Command
+ *     completes, so software needs to handle that case too.
+ *
+ * This function should protect against the TD enqueueing code ringing the
+ * doorbell while this code is waiting for a Stop Endpoint command to complete.
+ *
+ */
+int usbssp_dequeue(struct usbssp_ep *ep_priv, struct usbssp_request *req_priv)
+{
+	/*TODO: this function must be implemented*/
+	return 0;
+}
+
 int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
 			 int value)
 {
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index ea110667e964..d582c9dbe6b4 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1703,6 +1703,7 @@ struct usbssp_ring *usbssp_stream_id_to_ring(struct usbssp_device *dev,
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					bool allocate_completion,
 					gfp_t mem_flags);
+void usbssp_request_free_priv(struct usbssp_request *req_priv);
 void usbssp_free_command(struct usbssp_udc *usbssp_data,
 			struct usbssp_command *command);
 
@@ -1790,6 +1791,10 @@ int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
 void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data);
 int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data);
+void usbssp_gadget_giveback(struct usbssp_ep *ep_priv,
+			struct usbssp_request *req_priv, int status);
+int usbssp_enqueue(struct usbssp_ep *dep, struct usbssp_request *req_priv);
+int usbssp_dequeue(struct usbssp_ep *dep, struct usbssp_request *req_priv);
 unsigned int usbssp_port_speed(unsigned int port_status);
 void usbssp_gadget_reset_interrupt(struct usbssp_udc *usbssp_data);
 void usbssp_gadget_disconnect_interrupt(struct usbssp_udc *usbssp_data);
@@ -1798,6 +1803,7 @@ int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data,
 			struct usbssp_ep *dep, int value);
 int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 		struct usbssp_ep *ep_priv);
+int usbssp_setup_analyze(struct usbssp_udc *usbssp_data);
 int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
 int usbssp_reset_device(struct usbssp_udc *usbssp_data);
@@ -2275,4 +2281,7 @@ struct usbssp_udc;
 
 __le32 __iomem *usbssp_get_port_io_addr(struct usbssp_udc *usbssp_data);
 
+void usbssp_giveback_request_in_irq(struct usbssp_udc *usbssp_data,
+				struct usbssp_td *cur_td, int status);
+
 #endif /* __LINUX_USBSSP_GADGET_H */
-- 
2.17.1

