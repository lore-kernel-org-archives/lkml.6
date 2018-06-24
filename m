Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DB4C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB5725301
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="fiwllqGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB5725301
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbeFXV4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 17:56:06 -0400
Received: from mail-ve1eur01on0139.outbound.protection.outlook.com ([104.47.1.139]:35870
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751858AbeFXV4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 17:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84PY1LvuZ1JDCglLhieps89s1EwUPvqHOBi9XIQg4OM=;
 b=fiwllqGodyTG8I5wzelvtvYFXXyAQvA1C3vQr8vOabR8WS7nefxqv/Hlwh0zYWHl0qriMNDD+AHDde2IgxbsQLa4iYjo+SB1F/raat4Iw0jvcOmhR3bDN3U2HMRgkXDmsxwkGxcOMC42UC06m/jnlsxUXK2WuZKedbboHdqlJgg=
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2458.eurprd02.prod.outlook.com (2603:10a6:3:81::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Sun, 24 Jun 2018 21:55:41 +0000
Subject: Re: [PATCH v5 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-2-boris.brezillon@bootlin.com>
 <ed1add9b-ba21-d3d3-64c4-44d18af3d133@axentia.se>
 <20180623121705.1d618c5d@bbrezillon>
 <d6e37e99-d0d1-bd59-c1be-f462d3086a40@axentia.se>
 <20180624140210.03416dea@bbrezillon>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <cc5e03db-e480-f6d5-05ad-6edee52f46a7@axentia.se>
Date:   Sun, 24 Jun 2018 23:55:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180624140210.03416dea@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0501CA0013.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::23) To HE1PR0201MB2458.eurprd02.prod.outlook.com
 (2603:10a6:3:81::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3bd0a06-13f5-494a-88e2-08d5da1d3dda
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;3:JQn8qTuqmyyUHFhqGfILNS2Eo8B6WieB2rhafjOB0a+oMAt73AUlXtLmjW3K0r1N2H4JxnGPG/tvSCcGGme8b0tFriIgonhqV3GVQcIu00P/XZClGv0n7pCkDBo5Q7vDO99/erSCjy0OgpwuL09XEG468re/r8czGIlEgkP5c7PoRsqkJh2uFpiKJwmDCKpWG+Ky8IrR6NNL/ufrDgoOVli+J3w6RvgcLFdY5RIKXkM6oeN/qaJip9IRoRNIWBOz;25:ioNjdt3CotNC+wwUl1qI1wzpLNF79tEAuYf/l3KV0pX2q2vqAJPw9fIL8lQ/0VolhOagGKd2wRRO2gS030WsZgZw3NyXOqh98cSgJ+bMZ5byjSOdckcKzR5zVJLFGUQJaAMb1t5N8yQKwuNWQpW5RZfTBliVRyy0hzW1jFFlzo3uMV3Sbuabt+R4MOTOVOC7vNa9W2ZVagNOcz8V0ibuBN7I0RCJMbPsbGNQjm5iD4fv94FiaRYDm90cWyQX30VvcN+Piuv5nrp3W1gIgQ1PF4VVBmIs7jd1fPpOR+ksRj+24/uY8aFTnhipF9nN5S0584WDPeu2t8S6y4CCGn4UVA==;31:2pxmgvCIxa5hb6v0tbcic3uHTxGGxdx8ZvJpwZOY/CyqLBI06zZYgWln17dXXXF7O9EO4/koXf8/YQR/ei71RLs1zmOFAyRKQ4oWlG8dbKN59FCfgfAozErHbxQjPTKfHcQHCAwr12TbGZAeT200lfh9WnPsfVDpwTBcw37Rg+Fsmt/Ycle53MAVxCZXrY6isqMOBBPIGMLmbaD4IGJkHkiEphpWOaJLaevZ0zfL5xA=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2458:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB24586B15D0BC4051F09C39E3BC4B0@HE1PR0201MB2458.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(35073007944872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2458;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;4:rsmKaj/BpE+o5LqjRbye9sdK60aWVKsIGhEcOohGKWHV4Q9C7Tr1zJ+GMWufUHVOisi+7pRxWio7r1boJSkpBfuQ67RHRmQb/0gJ9DGmeuK8RmX/De3x8tBBTzUcpKSOqs0wDmPQWOEngPXjB0YIG+F5nKZkKYF8YzMfAJmpMvMZRdM3jEmMRCUsSZT4P3WkZhOEvXEqqHGtFZ1Nlrha1Stipzu1Y74B7XlG52BLTmOFsVGga17rU+Q8ZaVW+t3eQUuxXnmh26ICUdxU5cDF7bQ9I1Z3ToDB+cQJTVm8sDM8zkZEToF/NQWivA4Qj9Fe
X-Forefront-PRVS: 0713BC207F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(396003)(346002)(39830400003)(366004)(39380400002)(189003)(199004)(52314003)(65826007)(6916009)(105586002)(4326008)(5660300001)(229853002)(106356001)(50466002)(6486002)(11346002)(446003)(31686004)(3260700006)(25786009)(47776003)(956004)(476003)(2616005)(52146003)(97736004)(76176011)(2486003)(6666003)(93886005)(53546011)(117156002)(65806001)(59450400001)(65956001)(52116002)(64126003)(36916002)(23676004)(66066001)(74482002)(386003)(86362001)(6116002)(26005)(81156014)(6246003)(54906003)(7736002)(58126008)(2870700001)(77096007)(81166006)(8936002)(8676002)(53936002)(186003)(478600001)(2906002)(7406005)(7416002)(16576012)(305945005)(16526019)(316002)(3846002)(68736007)(486006)(31696002)(36756003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2458;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTg7MjM6U0c1ZkFGNS9kNUVuSENSbXNmUkF3MFR0?=
 =?utf-8?B?U05IOEErcXZYc3lBYndVQXBqTERiVS9seW9lNFZxN2taeTdvVWpuQnFMdGNp?=
 =?utf-8?B?YjB5NDA3cGpIcVg4dTVabnBJeURZRVhYeWdXaE83NE1Yc2RFdEJvdUlETFU0?=
 =?utf-8?B?NHY0Qk9BeGdlYlJxWGVES25EY2huckRFNW9KRzhOSkVmcmEyNEpDUHhoTU00?=
 =?utf-8?B?ZStUUnRMM29sRTNMZUpja2htYm43SkRzYUticUtaZkIwUHM2QWoyaDk2NDZn?=
 =?utf-8?B?TTVwaWRhRTRzbm5KdStYVG1Nd014czljS2JMRUxPdk8wTUZOWTdCcjN3MGc2?=
 =?utf-8?B?STIxUkxSL25YWWxvSTZjMFpqOHBhRVphQUMzbUFMODhxOWhJUGIwSkhXbHNw?=
 =?utf-8?B?SnRVdCtpekxjNUtzdWl6cjRnc3BMbFppd2lhQ2gzRkF0STExRm9jOGZZQXh1?=
 =?utf-8?B?b25NbUg0cndCWXV1YkFGQ0ZyU2MvTDBOS1Q4UHhhcHdtd1ZiSzh5bG5vdUU0?=
 =?utf-8?B?VkthRGRaRDZYVUwxZHlQQVZoZGUxTTZBZDk5QzZxZEVjYUdTOGowQUNtd2dD?=
 =?utf-8?B?eXlKTGh1c0drZjZXTjBKOHh2dXV5ck5nMFJZUlZDdUt2ait3bkhMUUp1MTQw?=
 =?utf-8?B?MnBEaGEvOWI0TVVBeWdBSmpJeDM3N1cwazd2RVd6S1IrbUkzTTVaU0pieGQr?=
 =?utf-8?B?RjlYQjdIUDZUbE1jTEs0bnNDWW5aNjZJT0w3OWVKWFI0dHNPZVpqWHpCbC9P?=
 =?utf-8?B?ZGN5VGtDbThtSExUZWFoVDVQYXl1d1ZDTVdJYVVlWmlFOTZnYS9zQkYydll4?=
 =?utf-8?B?SUZkSFgwRi8rQmx0Z0NuTkYvRmRuSE1lNkV2OEpxcmJicElDNDZpR2RBUUxV?=
 =?utf-8?B?am02cjljRmR2QjFoUGFsUFp1OCtHaFppVlZFeFROSTFSZjY1MGVKT0pJVWo4?=
 =?utf-8?B?M0VPWE5GUUlXckN4YTYzcHduMlpNRzlXOWZsOFpTY1F0aVM3WWpiQzhkZDFP?=
 =?utf-8?B?Z2lyWlNSVXMwUzdYd25zbWZOV1k1Qi8rZlFZSC9CT09FNFRBZ1B1aFJwS1R3?=
 =?utf-8?B?d3JOVDREVmRmMitWRTlVSXZnaDN1N05icGVCMkd2NG5MMmk4VmdrZThYNWxo?=
 =?utf-8?B?V0w0UEtlb0xqNTR4enF4MmJnRFhVd3RmVm9tMitOa1hrenVDbDBDYTFvMnpU?=
 =?utf-8?B?Y01ickZ4R2h3VFpibXRGQTZ2QXcyQjAzZHRHbjFLS0RrbDFaNWFwSjMrazAz?=
 =?utf-8?B?cFVvSGxIajBRZTUwaEYrTVpQNzZKWWhla0sxdVFlYWRBY3g1S3RsbjZob212?=
 =?utf-8?B?bHFCOHlkMGd1SW1aaEZrWFYvS2pJWWNpUDQyTmtDVE1samZxaFVxM1pIbGZn?=
 =?utf-8?B?Wmx1UWdycWpQK1A0WC9FbEdZZTNuZ2E5OGhXTElnTHBIVWloWHE4LzcreXpF?=
 =?utf-8?B?bkFqdGJBTzh0MCtKUjBiTFd4ZzVRZHUwMmtWc0tmeTJrejlmbS9WcUs1L0RP?=
 =?utf-8?B?dUhQaVIrbDhuMXNFeVZjZWpYTzFJSGlWaU02ellEOUpHemROVHhXa2x2QnU0?=
 =?utf-8?B?SnJyQlEwTkJIaUVEZWdNa1V2bmw4ajlzZklFT1BjWkU2ZHRzUFlzSzRVd2ZO?=
 =?utf-8?B?ZnNtWE1LcFZ1TTg4K01GeGRVVzk3NHMxdXdqdFFyUU16dHhjQzhrS05CSUty?=
 =?utf-8?B?d1FsWFZLTDBGM1U2bzhQdVV1N2I1azlLOGpCZk1nTTI2Vnc0bWhWM1hnTjY2?=
 =?utf-8?B?alBENWVPWklTWnM1K3FDSXZoQkkyVXZ1YTFxSGMrY2drSWNlUHpud0NXdXor?=
 =?utf-8?B?VlV0cDRLY0M1TVVtdkNKejFJT3pzd3NxL0RHcE1nL2xxL3Y5Y3FLWUhtT0hN?=
 =?utf-8?B?S3RVNjVrVmFsbFZWaEdMT0lFQVJpNm5oMUNBV0NkcXB5NEE1dkhDQ3R2UFlk?=
 =?utf-8?B?WVdIOWw4akkrb05FL3pnZEx6VFpIdXNlWmRzSVczdVo3OFBZUEZSMU11NENF?=
 =?utf-8?B?SnhvMkU4VnRKV2F2U1MvU2x4SjZLMTFGem5yTFJuYUtoVXVmZG8vQ2pTRVVu?=
 =?utf-8?B?Tm1DODY1RjJmZUZrTmlCSlNSc3A3aW4rQ1JlaUVWVmdldkwwZHJzYkVXSzc3?=
 =?utf-8?B?RW1GZ0oxU2djeTlPVTA3Um5RNWFGc2xLdzNQVjJ1L1Jrd0hjU2VPM09VQVE5?=
 =?utf-8?B?dzgxSGdHYUpqbzdWWkVvSENiMEt5WjQwd1l3K0ZuM3orb1c5NG5LUUdxYWtk?=
 =?utf-8?Q?9W6wYB2NhiA2TxRmPiWr?=
X-Microsoft-Antispam-Message-Info: vWWDI8K+3i8paGXCNIYiyfbsDAO51GJLBGxTyycLBQdTg88xEpDX/FFRhXydyicsmvG6wgMe8SNcKYRc6cen7OUAF0seeJ6uGKcm2xKz6SSorhzkREC8SFE6jrReNsB/k09QIU4QAVnKNFunUdmg+MQult51luk+a8E4k8ZPS3s4Vel4Fsx9oKYOYa45qZvrE+2R2kpILh4f0QgMy0E2IisUlChKfwQT4MszSgjzVFfqTYXF4XCn2s+z2nJzVHYmCYnHTHd8b5kZKn2PRTUkszA2axp2TMbOVRY8ZkHkeyUjFLOzWsJrdsCL4y6gQwTLQp+KHk0tWpbMwMvVQHKtkXe1+LNP7SLS8u8p6s/hUd8=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;6:/juny53VE8Dotx6JqybzjPoihA7z35r5H+BPOaY7w+a56VPSqTzyoWZjlR9HOEXLWkgG13BLo5l60LELSKjLjtJPYSa4lXP0BGnc1JpqqOL6+VcUdCPv1QifdYmKPnk9SFVE6pGsqg+ZdlBAlEngWVyIqHULaF5vDi9MQO9QbS3l6TrXpVf9UDHKUzz9U37Kw15x4lf/ak7s9CyPoxLsEBmiIMYMrYUIdBDtY1tIJJdGhkg73CK1mI253R5FXoLzmFiVKzNNMQVgMqiAMMqPLTdTsD2asN0yScg1Wwbymy8wk80cq3JP83GYIOUDzDvMuUMiXHTfwx8qQGpclDU587q3WHeXw73MXqbjSZE+QQRDdWgojKBoODeyIxCWL2SGhPDEZL5R99x8nPpfleZ//dbBpPqHaKHSENd3clNgl2OkKyHBjQZryyBG2jwXnhiGCGfRQjfmMRAgwD6wk1ucwA==;5:phP+knmGbbObVHZrdzZvannamQ6UZyqdb/YZUBO6ayvXT3kFSWF9Ie6eIzdsUf1gi4PatMEQ8rpDVKrdfHs1dMKmmrKbJlBnkw4YUn3qQHzpNEKqIlftvBmpDmwIyCIFeAEEvGJe4QC6YFUhBb0tEw0YW1uMapHE0U20Szrh6Es=;24:kT3KitmXTNsvvgzegFR781y3lxaNvHqZge1VSgCJe7fMYhsK+XKZDOheGCynSlBdde38tZaaizTFhuY19fpF4Q2pzcQS+0ue73CoJiTlIWA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;7:d6e+VGxgQC551eA/idNk+u0UBbUsOIzgZSElFxHJyWGg0Og8/TIR+AyDoLmLGbY1AGrKqO6rw0lgEo7P5ZkFpJYL7CZNM4lfqvS0kY+irJzjqhMrSlsunpe+swnaZyD9I5MLOQUlr18GaYi2NjKQHOF/GuOPPx1i8O3mPPYKOTpy3PSBTRGZu84yq8g3sM2pbRPdozFtLOBcIr2NT4p6hqogoHiQwdIxIt8ybxwoLC4mLGjKY2eU8KBoVHAjRCWk
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2018 21:55:41.6841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bd0a06-13f5-494a-88e2-08d5da1d3dda
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-24 14:02, Boris Brezillon wrote:
> On Sat, 23 Jun 2018 23:40:36 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2018-06-23 12:17, Boris Brezillon wrote:
>>> Hi Peter,
>>>
>>> On Fri, 22 Jun 2018 23:35:34 +0200
>>> Peter Rosin <peda@axentia.se> wrote:
>>>   
>>>> On 2018-06-22 12:49, Boris Brezillon wrote:  
>>>>> Add core infrastructure to support I3C in Linux and document it.
>>>>>
>>>>> This infrastructure is not complete yet and will be extended over
>>>>> time.
>>>>>
>>>>> There are a few design choices that are worth mentioning because they
>>>>> impact the way I3C device drivers can interact with their devices:
>>>>>
>>>>> - all functions used to send I3C/I2C frames must be called in
>>>>>   non-atomic context. Mainly done this way to ease implementation, but
>>>>>   this is still open to discussion. Please let me know if you think
>>>>>   it's worth considering an asynchronous model here
>>>>> - the bus element is a separate object and is not implicitly described
>>>>>   by the master (as done in I2C). The reason is that I want to be able
>>>>>   to handle multiple master connected to the same bus and visible to
>>>>>   Linux.
>>>>>   In this situation, we should only have one instance of the device and
>>>>>   not one per master, and sharing the bus object would be part of the
>>>>>   solution to gracefully handle this case.
>>>>>   I'm not sure we will ever need to deal with multiple masters
>>>>>   controlling the same bus and exposed under Linux, but separating the
>>>>>   bus and master concept is pretty easy, hence the decision to do it
>>>>>   like that.
>>>>>   The other benefit of separating the bus and master concepts is that
>>>>>   master devices appear under the bus directory in sysfs.    
>>>>
>>>> Are bus multiplexers relevant to I3C?  
>>>
>>> Not yet, but who knows.
>>>   
>>>> The locking needed for handling
>>>> muxes for I2C is, well, convoluted...  
>>>
>>> Do you remember what was the problem?
>>>
>>> Anyway, I'd really like to have basic support upstreamed before we
>>> start considering advanced use cases that do not exist yet. Don't get
>>> me wrong, I'm not against having the multiplexer/locking discussion,
>>> but it should not block inclusion of the I3C subsystem.  
>>
>> I'm trying to avoid the unfortunate situation in I2C where there
>> are two slightly incompatible locking schemes for muxes. There's
>> probably nothing to worry about until the first I3C mux is added
>> though. But since I2C devices are supposedly compatible with I3C
>> that might be the case from day one?
> 
> The I²C backward compatibility is implemented in a pretty simple way, so
> I don't think you'll have problems coming from the I3C part on this
> (unless it needs special hooks in i2c_adapter to work properly). This
> being said, if the I2C framework is already not able to properly
> handle the cases you describe below, the I3C layer won't solve
> that :-P. 
> 
>>
>> ---
>>
>> If I read your code right, I3C client drivers will typically call
>> i3c_device_do_priv_xfer (instead of i2c_transfer/i2c_smbus_xfer)
>> and i3c_device_do_prov_xfer will grab the i3c_bus_normaluse_lock
>> during the transfer. This seems equivalent to normal use in
>> I2C with i2c_transfer/i2c_smbus_xfer.
> 
> Note that the bus lock is a read/write lock which is mostly taken in
> read mode (AKA normaluse mode). The only situation where it's taken in
> write mode (AKA maintenance mode) is when a bus maintenance operation is
> done. In this case, we need to block all future transfers, because
> maintenance operations might change dynamic device addresses, which
> would make future transfers irrelevant if they were queued before the
> maintenance operation is finished. 
> 
> The bus lock does not guarantee proper serialization of bus accesses.
> This task is left to the controller drivers, since this is what they
> tend to optimize (by queuing transfers at the HW level).

Oh. Will that design decision (localized serialization) not make it
extremely hard to implement muxing (and gating and other stuff that
you need, at least for I2C) that is controller independent?

>> When muxes are thrown into the mix, you find yourself needing to
>> do more than the "real" transfer with some lock held. In I2C there
>> is an unlocked __i2c_transfer, and locking/unlocking is exposed.
>> Muxes typically grab the lock, set the mux in the appropriate
>> position, do an unlocked __i2c_transfer, optionally sets the mux
>> in some default position and then lets go of the lock. See e.g.
>> i2c/muxes/i2c-mux-pca954x.c
>>
>> However, that is the simple case. There are also muxes that are
>> controlled with GPIO pins, and that gets hairy if the GPIO pins
>> are controlled from the same I2C bus that is muxed. The GPIO
>> driver would have to know that some GPIO pins need to use unlocked
>> I2C transfers for that to work with the above locking scheme. And
>> no GPIO driver does not want to know about that at all. I.e. you
>> have two fundamentally different requirement depending on if the
>> GPIO pins controlling the mux are controlled using the muxed bus
>> or if the pins are controlled in some completely unrelated way.
>> The latter case is probably the normal case, with the GPIO mux
>> controlled directly from some SoC pins. In the latter case you
>> also want to prevent any transfer on the bus while the GPIO pins
>> for the mux are changing, i.e. the total opposite of the former
>> case. It gets really really hairy if you have multiple levels
>> of muxes...
>>
>> There are a some old drivers (e.g. i2c/busses/i2c-amd756-s4882.c)
>> that handles this by simply bypassing the GPIO subsystem, but
>> that is not really an option if some pins are used to mux the
>> I2C bus while some pins are used for other things.
> 
> I see.
> 
>>
>> I don't know if this affects I3C before muxes are added, but I
>> suspect muxes will happen sooner rather than later, since the
>> spec mentions that the bus only support 11 devices maximum. 11
>> don't seem like a lot, and it seems likely that there will be
>> a need to have more devices somehow...
> 
> I can't tell, and that's the whole problem here. How can you design a
> solution for something that does not exist yet? Fixing the I2C muxing
> logic, if it needs to be, is something I can understand. But how can you
> envision what I3C muxes (if they ever exist) will look like?

Yeah, you have a point there. One problem is that I don't even see
how the situation can be unified for I2C...

>>
>> But just maybe, in order to not run into the above situation, it
>> needs to be handled right from the start with preparatory and
>> cleanup stages of each transfers, or something?
> 
> How about applying this approach to I2C first and see how it flies.
> Changing the I3C framework afterwards (when I3C muxes come in)
> shouldn't be that complicated.

That would require more thinking first, and I fear that the overhaul
will be bigger than what is called for given the rather fringe cases
that cause problems.

Note that I'm not trying to block I3C, I'm just trying to trigger
some thinking before the fact...

Cheers,
Peter
