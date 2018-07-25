Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62430C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0194E20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aZQTHfSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0194E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbeGYLCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 07:02:45 -0400
Received: from mail-bn3nam01on0052.outbound.protection.outlook.com ([104.47.33.52]:32896
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728589AbeGYLCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 07:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni+wcSTSsRgsjNEZEbwEdmUEygMPSUoD3gqlINGoAo8=;
 b=aZQTHfSGC9LrhE7FFpajjQOG2UY5rUGcKWIOElu69KEb3NRReq6C5TA+o7BmcRxdOciO5jyyAdFISEp6TFzjEbX6Z3iRJ4l+07Uuvd5rhUlIILylIS8gzFeBX//R2dSu4shmBYqitks32VV1YKQXe4rfOex4EhoOX0XQyxFflYA=
Received: from MWHPR02CA0011.namprd02.prod.outlook.com (2603:10b6:300:4b::21)
 by BY2PR02MB1621.namprd02.prod.outlook.com (2a01:111:e400:5267::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Wed, 25 Jul
 2018 09:51:41 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by MWHPR02CA0011.outlook.office365.com
 (2603:10b6:300:4b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Wed, 25 Jul 2018 09:51:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Wed, 25 Jul 2018 09:51:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53088 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fiGSD-0002sh-7v; Wed, 25 Jul 2018 02:51:33 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fiGS7-0007JS-Jz; Wed, 25 Jul 2018 02:51:28 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6P9pKOZ019797;
        Wed, 25 Jul 2018 02:51:20 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fiGRz-0007Hv-Pp; Wed, 25 Jul 2018 02:51:20 -0700
Subject: Re: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river for
 ZynqMP core
To:     Jolly Shah <JOLLYS@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
 <2c3aad45-37ce-2446-4b90-bddb477286ed@xilinx.com>
 <CY1PR02MB2138E21A3FFBD5FEEAA7D6D4B8550@CY1PR02MB2138.namprd02.prod.outlook.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <19376df2-fdd4-12e3-da4c-37106fffed19@xilinx.com>
Date:   Wed, 25 Jul 2018 11:51:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CY1PR02MB2138E21A3FFBD5FEEAA7D6D4B8550@CY1PR02MB2138.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(438002)(199004)(189003)(13464003)(4326008)(5660300001)(336012)(446003)(356003)(478600001)(76176011)(36756003)(6306002)(7416002)(26005)(77096007)(316002)(476003)(9786002)(39060400002)(2616005)(2486003)(966005)(44832011)(486006)(126002)(11346002)(426003)(186003)(23676004)(53546011)(106466001)(31686004)(63266004)(64126003)(54906003)(6246003)(50466002)(58126008)(2501003)(110136005)(36386004)(229853002)(8936002)(6666003)(106002)(2906002)(81166006)(81156014)(305945005)(31696002)(65826007)(47776003)(2870700001)(65956001)(65806001)(2201001)(8676002)(921003)(107986001)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1621;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT039;1:uDOSyykaGd5F7CJqyybXb44L3vyusQJTxZ3InWQMmgTkRR/ezBpma4IHCDB1iXu2+HTz6f/cyFMChyvJEGplgDaQZ3/FC4gGJWSoNypcTh7G2PB6hm1Iz0Hsojqqb1Xa
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c37f2e6-16ea-494e-81be-08d5f214388f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB1621;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1621;3:7s9OK59pFxhCF5yJzqtt6cmJnAP4S1+T2d+hJo0nHZxU8pKFsik49Dq4DyWKNzFnNoaecSpSQlgRdYyQPz5TAY/RMETydJUVi07t7u9oZshg7JliQSQKJ0hPrwleFmz+/GyBM10iCY3xEX+oP/+8rGjJo01MvwvljarhuC/+Td4NctEqybCZ3w96K1Khu4SFL40drAX6hU510f4C9k3Ypm+QCUg9BjfvGtfJSjcIsHkAEVqWg9LxNXmscYz/kYGJFBphyXQcj3bGE67CrI9laY1yozetSad6pZeAQEllGMDCMF7vYop0eLdeBV2c3nvdiVO8nNTVzP3YGuqRpLFAic7KY42haNb+wgFbLxf70RA=;25:ceF70WCrM+xmgaAl8AlE3jmeMlNvRZtyQWyoUThASP1QnTpUmh91JjBew27+5WzK02xzdBSoigSvpG9A0c5VMbJdNyrZCVWgyAd5Bj6Bz8Lccg9ui6ZjRHMbcNXEy3YFvz3XS/1Mhys1a3xXm9g8W0dsYmk9mo+lBm7BMuwRSAu7SHSlJ7urKanzEg3zoVW50P8H2oj4kBbd23a77ayp88K+C198xZlhfKqgwkTfgPvLXTgyfG5eMZHM6MbO0XSGlUouh9aL5/PKeENZS8eOOnkFrd/oasvN9OaPxfnz/nccdB+k+NGPalc27lPjOr07pjaclQ8o58TXQejMXhzhvg==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1621:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1621;31:LGCzg0aRzM9klaxDHRvGDT+zXGrG+QZrEUKjhq8HsexSkXiwjGvRdqfqZB3lia6AYUzF74awYXmGqeSwH/cNOSMCW2Isxl+I+82rFb+D2MpMmBrzjyGYx+yXIp9G/jGGvW4K3R3b3Sp3gN2QunpTyQ1BKR2aL+3nfX38uuHWxzIN3w3KfyhAnBd64U/DU2NZ+sr3jupw0DpVe/s1SGPBkM9qDfY/QcKm+CLW8EpQUX8=;20:y4R0blzVSjETaPR3ANFlNCoyC78b1UPq4nKHKRxnpxSjmtq1CJC8s2IJ3l7bYGz+GDiBhONHX3sp5C8b621a0kIMdRm84UmzjSZb77pk01cI7YeLmVEkv3pCibC/csQCRuLKeJRtgGPR9ezQhPSpeNWxfbfH8pID/fq8Z4gP/tVLfOAOyXoX9DUbLXCgHEGKRlygfXGgMabLtBamOvmxnQWxRdqlAMxbM9D7ss1jMHzAP/rlFu60j2mN+OPyrvAuyfUmVw9FmhfWdUsQ3Itgx5PWtWB4dM1QCX2zxf5EC2TvfnwA15GRbA3nNF4QJBhFfCwh8ulW70V+uG+lEVV1nWr3DRTFnYAJ1CzHJJDCE9lDXbkqXnIKvFnglO8yDFbrUJRNEtUbvHwWs7pYNaaS0rF+duNJxcR51SNjv9OdjulTxSwgb1RAPoqer9xUUexMRXutgRU1xEqgccTs54wQhu6HwG0892gqAnlTGdsRQqRLRPJuSTT+Inag3jVKvsKq
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB162185F4E3C5AF8127E91ADFC6540@BY2PR02MB1621.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(166708455590820)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB1621;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1621;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1621;4:ptP+r94qpYbxMv0qSxYLsXMdaFTXvR/T+lKlzwNTKWLIkKXEI+WSwAd3FOkgljSuH8YKr57b906EkyHkJzBLT0RDS5pVuiyxp5nKawflcQ9XDhmC+qJYPWqlLPdxRv4lz8HsL6K28RFpMc099oTyH04VJZ0tO4KOEodDNxa7JRHozl8KRYz1kNi45r+Xh+KVrHX9s73fXOGkA/mLCnld/XlkI6yigKUHEf37YpJSdaT0nxxK59ozStEwqQFYSoOZ9VaCEd2SO70ohoMZzFLCRgA5eIESRKSZGzVUzyc7Niz/VfQPryp7aMOtqCBeYLilv/0Eae7zaAcFqqRhkMA11hnHCJptTYTKY5XTuF4EPw0QVgIplGTZ0VAMP96HzcMXsqODhDQIjQD3kx4CfX5Fqt3yxvMlbO8Wf1e9QaqRtR6BdRflqs3/6xyhxPmGpzO4QE4QJwPY0c5XDQqY9TTUQQH5TWiuNZDcdYVynCnyIYU=
X-Forefront-PRVS: 0744CFB5E8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyTUIxNjIxOzIzOkE4K2pNV2psQTdCbWcwY3ZXa3FTNUUvVWxD?=
 =?utf-8?B?MHY0ajB3eDNWOC9XSXhtanVLY3J6SWRybllRUzlVZDk1MmZaUCtXMkNpeHRh?=
 =?utf-8?B?eWhqVjljdTFsV0pBZ0l6d1lQK2F0VmI4M0pFQVBCZjR5cE9VaVBNaVZFV0ti?=
 =?utf-8?B?aDVReHVSZk80d2FGdUxOL1praElwalZGSldlRVFLQW1UUGVRVDROTVFOSjNI?=
 =?utf-8?B?R3FzQ2VRT1R4UHkzZEJyTlBtTEN5MGttR2UzSWFWSHdVS0xLYVZ2MHpNNTZM?=
 =?utf-8?B?OWVhNExiaFB0RHkxSW0xQkhXRWU1a05oMitXRXFXY2g0VVJIRDBJZlczeDgy?=
 =?utf-8?B?U0JQWWY1blNDbnFmK3RjaTAvNmNSbDYxZm5zU0JaTUpCcTFUN2dqYlhHa25p?=
 =?utf-8?B?Yi9sUENVWDNnMTJBQkxxMWhickp6VkR2ak03dGx0TWVmNGNxbFhQbjBITWZS?=
 =?utf-8?B?bjVtMXVGalJ3eEhuVW9oU0lGaXNmKzV6dUZBcWZSMFgwU2ZqQzhzeEZsOUxR?=
 =?utf-8?B?ZE1FNjNhQ1dtV05ocFJjaGpBSHBvY0IvbjMwRGVaWjFxb01DK1lCNGlURVJm?=
 =?utf-8?B?ZmdBWm9nZnFld1lvRGpJWVVsRDBHbzFyczRUK1F0RXA5eTNWdDliRVRTSURi?=
 =?utf-8?B?dXpiUDkyVVdXVWhBM0h1V2FtMyt3d0kwZEQ1dVhQcjVnZTI3S2pqTktxdzVN?=
 =?utf-8?B?b005OVBJVkhzaitFRDFmL2J5OHZIcmNvYnB6M1N5UmM4TEFDZ1MwbUdpTU9l?=
 =?utf-8?B?d3pWNk9xMTFCZzhkY0JuSm81UUwxSkRzY2tMWUU2YVpqa2drVmo1MUtTd1Vv?=
 =?utf-8?B?U1FEaklxQm16cFlGT2gwRWExeWVWTnlhWGZFS0hNNllUQVdKM0QyUTNMUzMr?=
 =?utf-8?B?UDBSU3FuNXA1Qk1ZdHNkcmxvb0g3YVY0ZlpsNTJMNjVPS0VTdy9oa0xJUzQy?=
 =?utf-8?B?ZU9LQW5XWmdQMmdjUlZMb282aTFzckVRY0JhOHgxYkpubDBhYjQ4RWN4NDBT?=
 =?utf-8?B?YTdqMzZkMXdCREFEWDdpeFVRSEUvT052QjJkd09jelhQUWI0VEg2NVlNSzN1?=
 =?utf-8?B?QnQ2QkRSMkdwL3hZamxpUC83THYwSmkvTkQ4ME9qb3ZYeG9HcWI2b3JzN2RJ?=
 =?utf-8?B?anBRaXlSNEhrQlNPRVlneHJLRnUxeWxqL08wTWJudjFsZU5DeElNTTg3UmRK?=
 =?utf-8?B?a29FYTUwYWxRZmd4VjkwM2F5dy9ER1VjaWVRK2Q4NHM2bUZBQXk2V0hVTzIy?=
 =?utf-8?B?K2dPZ3VHcVRTTlhlckNYc3V2aEswSFh0ME8wR1ZtYStYS0IwWnZHVTlQaUdj?=
 =?utf-8?B?VGYvbGZ0VDQvME4vV2wzMVh5RkVuMXZXazUzNWVjcUJFcHFpZFBVVlRBMXhh?=
 =?utf-8?B?YldUNlo0azdnZGF5NGlPb3V6d1U1TTc4UmFleU1JbjQ4YlVQMEVjVG9ld2hB?=
 =?utf-8?B?WjhUR0tUYjVPKzBjRUhlNURvZlhtUG5QYW00K2h0YzlnUGh0VGVwcjc5S3Fi?=
 =?utf-8?B?MHFnODlJK2xtc05ENW40ZXp6WW9IbU11a29UREI4TFRObERzMGJXYWhrVmhw?=
 =?utf-8?B?clJiYjlBVTlIRjRHb2JtM2xod05kUURlVGYwU1pmRVpkV1BLMDJlS3ZYNjZq?=
 =?utf-8?B?RXJNQ1JDa3NLZTZvNHVJaXNHMnk1OWpMRjE3QkJ0UmgxQmk3UkpKeC8vVlV6?=
 =?utf-8?B?dGV2MDFEQnVHZlpUbzBPUGwyZDkzd0NxQ0tsODJJUTYyYWVwRjVJTVVickFt?=
 =?utf-8?B?K0hMMWV5Q05CS1lJdUJOUHptdklhYlNIVzc5akx4WnV6VTRxeEt3elhZdFpn?=
 =?utf-8?B?UE9FTWtyTGRucG5scXhhYzZBR3dMYkhmb0d6aHdyT0xKTHlTaFh5RHRVRElB?=
 =?utf-8?B?OS8vc0lJeXEwejF2bUdVVUpDeGNOWld3YUUwMngxeCtubkpnQUxPT0NJYm5i?=
 =?utf-8?B?ajZ6S0tTOUFadWlMc29JLy8rL05vQ3ZrT0p3U05qYThGZzBiSnkyakpzTG44?=
 =?utf-8?B?L1VidTh3cy9wdnVGWURXbjNSeFNILzlXSkxTQT09?=
X-Microsoft-Antispam-Message-Info: 1jAMN23mCyLHpmH3P/JOTMpiihlKEXdaA8b7FHbtEYWffUXYS1teKbfvju/y1bNHDOZO7BUwvxiPHW2T0aQU1pGnhXSknIR4uP3cPBSSGJJwXJY7B/iq0+SV9Batqvt65RXBofj2Xuq00XVtcMH+VANR8nL9QyYIxPhoc+qlJClxRCG70FxZV9MB3+kjaSGY3BasV+1mTjPOR6Z+I40M+2mh0dVIzBvFRhJQuqasR95O0QHyfJRXi5H7GzJOEtCzbXhdceWF56XFShEntr/44wnMY+cNAqB0huyV8+9GNVDtvZ8R4UZPkZOkYo8P38yi2xBShX0+RVVMNsldYXbIxBivnotE7dqK9MpJLhCmJAo=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1621;6:mvSHyI2JhuUa3dwm2MJxv77P56o21sGsHc8SpBYR3y0M/NJQTxEyvvTDbBqMOUe/48GuEVybuFt24iQIp1doctyEDT+4pYPkDqh6qxnF5TAPMcSvYVyUU5TRBBljjZGRzGLEZPYH97dUkY3H96ILL3pP1qkOOXPMkchhJJY/wpGD5UmOel4xOYgcgUnCSWlbRm50ul5Ex6iKL56+pqw4Y6uu+2/ka7yOnxhh8OthowizlqWOKq1dfw+xeSNnF47hGuBzYVpSDAH1YJhECBAov1+5mK99BNCRkS0apwlxjusSjDjYirdVCi7H/rjbUnAagPIFBZrg7D5jwYWg7XgxvlElPqQU+2mbfJj3/nrdnQT/g1d+goPjbOH5X7Wx5NGPQWQhjOzyP0YUInekCCO5pGKiJQ1DojreIpf/OG/Gue4MfPj5KnaTbLWHfUeClGxc4MdxySsfXJJujCdq4NHGtQ==;5:no3Y6Cp9fAnqtYZU03+4QBLYjkKmwxFxnmltm5o5duSSjLk45EXznhZrJUAGXKsU5GbSC0VNkAxkuw7ATYbwqyGOGUZCqXh+Y6b8xBNx/4aehTYBO0REybwcG/TyQ/SvtyYVMa36vf7YLU9YO3Va0qcnFe1jZy0KBafRVtUTlTQ=;7:EQzs9yHn1aZn5Gg52BtmNYSYHTA8zt5ossvChIwioRebC8TngSykxcN/8k9SEB/8Smo6GfXLM3vUjEq5Ipqc7unbdyE1XT9GLpU/XPme2QfZ/LLDgvVAasu6oNU1K62pWUUGp6KDRp9ytteEyrcPJZCQi+vZC4Kv3bYJU/W8iRtXt/h83wX9UW0Ko4Nmm8Wwui4jtYvr6ZPpKunqvlKDpQlcZgEWyBka0oUbI4Ojb6GHZNLRJOrERI0r5P9oLwCn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 09:51:34.2331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c37f2e6-16ea-494e-81be-08d5f214388f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1621
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.7.2018 20:14, Jolly Shah wrote:
> Hi Michal,
> 
>> -----Original Message-----
>> From: Michal Simek [mailto:michal.simek@xilinx.com]
>> Sent: Thursday, July 19, 2018 3:33 AM
>> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel@linaro.org;
>> mingo@kernel.org; gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
>> sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
>> dmitry.torokhov@gmail.com; mturquette@baylibre.com;
>> sboyd@codeaurora.org; Michal Simek <michals@xilinx.com>;
>> robh+dt@kernel.org; mark.rutland@arm.com; linux-clk@vger.kernel.org
>> Cc: Rajan Vaja <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Jolly Shah
>> <JOLLYS@xilinx.com>
>> Subject: Re: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river for
>> ZynqMP core
>>
>> On 17.7.2018 21:58, Jolly Shah wrote:
>>> This patchset is adding communication layer with firmware and clock
>>> driver who uses those APIs to communicate with PMU.
>>> Firmware driver provides an interface to firmware APIs.Interface APIs
>>> can be used by any driver to communicate to PMUFW(Platform Management
>> Unit). All requests go through ATF.
>>> This patchset adds CCF compliant clock driver for ZynqMP.Clock driver
>>> queries supported clock information from firmware and regiters pll and output
>> clocks with CCF.
>>> v10:
>>>  - Incorporated code review comments from v9 patch series. Discussed below:
>>> 	https://patchwork.kernel.org/patch/10478575/
>>> 	https://patchwork.kernel.org/patch/10478457/
>>> 	https://patchwork.kernel.org/patch/10478461/
>>> 	https://patchwork.kernel.org/patch/10478463/
>>>
>>> v9:
>>>  - Fixed minor typo comments
>>>
>>> v8:
>>>  - Corrected typo in clk Kconfig
>>>
>>> v7:
>>>  - Removed xilinx specific clock debugfs API support
>>>  - Added reviewed-by tags for FW and clock bindings
>>>  - Updated clock node name to clock-controller
>>>
>>> v6:
>>>  - Broke patch series to have base FW driver and Clock driver user
>>>  - Incorporated code review comments from last FW and Clock driver patch
>> series. Discussed below:
>>> 	https://patchwork.kernel.org/patch/10230759/
>>> 	https://patchwork.kernel.org/patch/10250047/
>>>
>>> v5:
>>>  - Added ATF version check support
>>>  - Updated some functions to be static
>>>  - Minor function name corrections
>>>
>>> v4:
>>>  - Changed clock setrate/getrate API prototype to support 64 bit rate
>>>  - Defined macros for get_node_status return values
>>>  - Moved DT node as a child of firmware
>>>  - Changed debugfs APIs to return data to debugfs buffer instead of
>>> dumping to kernel log
>>>  - Minor changes to incorporate other review comments from v3 patch
>>> series
>>>
>>> v3:
>>>  - added some fixes to firmware-ggs.c
>>>  - updated pinmux get/set function argument names to specify function
>>> id instead of node id
>>>  - added new pinctrl query macros
>>>  - incorporated review comments from v2 patch series
>>>
>>> v2:
>>>  - change SPDX-License-Identifier license text style
>>>  - split patch into multiple patches
>>>  - Updated copyrights
>>>  - Added ABI documentation
>>>  - incorporated logical review comments from previuos patch. Discussed
>> below:
>>> 	https://patchwork.kernel.org/patch/10150665/
>>>
>>> Jolly Shah (1):
>>>   drivers: clk: Add ZynqMP clock driver
>>>
>>> Rajan Vaja (9):
>>>   dt-bindings: firmware: Add bindings for ZynqMP firmware
>>>   firmware: xilinx: Add Zynqmp firmware driver
>>>   firmware: xilinx: Add zynqmp IOCTL API for device control
>>>   firmware: xilinx: Add query data API
>>>   firmware: xilinx: Add clock APIs
>>>   firmware: xilinx: Add debugfs interface
>>>   firmware: xilinx: Add debugfs for IOCTL API
>>>   firmware: xilinx: Add debugfs for query data API
>>>   dt-bindings: clock: Add bindings for ZynqMP clock driver
>>>
>>>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  82 +++
>>>  arch/arm64/Kconfig.platforms                       |   1 +
>>>  drivers/clk/Kconfig                                |   1 +
>>>  drivers/clk/Makefile                               |   1 +
>>>  drivers/clk/zynqmp/Kconfig                         |  10 +
>>>  drivers/clk/zynqmp/Makefile                        |   4 +
>>>  drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
>>>  drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
>>>  drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
>>>  drivers/clk/zynqmp/clkc.c                          | 719 +++++++++++++++++++++
>>>  drivers/clk/zynqmp/divider.c                       | 217 +++++++
>>>  drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
>>>  drivers/firmware/Kconfig                           |   1 +
>>>  drivers/firmware/Makefile                          |   1 +
>>>  drivers/firmware/xilinx/Kconfig                    |  23 +
>>>  drivers/firmware/xilinx/Makefile                   |   5 +
>>>  drivers/firmware/xilinx/zynqmp-debug.c             | 249 +++++++
>>>  drivers/firmware/xilinx/zynqmp-debug.h             |  22 +
>>>  drivers/firmware/xilinx/zynqmp.c                   | 562 ++++++++++++++++
>>>  include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
>>>  include/linux/firmware/xlnx-zynqmp.h               | 116 ++++
>>>  21 files changed, 2818 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware
>>> .txt  create mode 100644 drivers/clk/zynqmp/Kconfig  create mode
>>> 100644 drivers/clk/zynqmp/Makefile  create mode 100644
>>> drivers/clk/zynqmp/clk-gate-zynqmp.c
>>>  create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
>>>  create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h  create mode
>>> 100644 drivers/clk/zynqmp/clkc.c  create mode 100644
>>> drivers/clk/zynqmp/divider.c  create mode 100644
>>> drivers/clk/zynqmp/pll.c  create mode 100644
>>> drivers/firmware/xilinx/Kconfig  create mode 100644
>>> drivers/firmware/xilinx/Makefile  create mode 100644
>>> drivers/firmware/xilinx/zynqmp-debug.c
>>>  create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
>>>  create mode 100644 drivers/firmware/xilinx/zynqmp.c  create mode
>>> 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
>>>  create mode 100644 include/linux/firmware/xlnx-zynqmp.h
>>>
>>
>> It looks pretty calm over the last several series that's why when I get an answer
>> from Stephen or Mike I will take this series via my tree and arm-soc tree.
>>
>> I have applied 01-08 here
>>  https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc
>>
>> Thanks,
>> Michal
> 
> 
> Thanks for merging the patches. 
> By mistake I added “Reviewed-by: Stephen Boyd sboyd@kernel.org” for firmware bindings (Patch01).  Stephen had reviewed clock bindings only.  Please suggest if I should send a new version with that fix.

I have fixed that in my branch and I have asked Shephen to look at clk
over chat.

Thanks,
Michal
