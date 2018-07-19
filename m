Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7326AECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F81420684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="bfjZLm9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F81420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbeGSSpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:45:25 -0400
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:20513
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387747AbeGSSnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vNmtIDW5TdIpN6bLrSNc77wU5Mgzxm5B6Le/u668Cw=;
 b=bfjZLm9IiTrwGp9a2TA6kjHZTbNtLJDi3Q8Ro5FftOrnSUfP08qe1W4GuUz9hQegbKEhMNXoZseqnbpNcXJWKpVWg8vqWJkPHHbz6eICgnHl4yukiSEYV8Tbu5qMbKfhZI95azL/NhqCwbTYeN2YqtnBhtxkYM4IyQJfTv34HZA=
Received: from DM5PR07CA0119.namprd07.prod.outlook.com (2603:10b6:4:ae::48) by
 BN7PR07MB4708.namprd07.prod.outlook.com (2603:10b6:406:f0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Thu, 19 Jul 2018 17:59:33 +0000
Received: from DM3NAM05FT006.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by DM5PR07CA0119.outlook.office365.com
 (2603:10b6:4:ae::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:33 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT006.mail.protection.outlook.com (10.152.98.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxNgL025447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:31 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:33 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:33 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxHWa006105;
        Thu, 19 Jul 2018 18:59:17 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxHDw006104;
        Thu, 19 Jul 2018 18:59:17 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 31/31] usb: usbssp: add pci to platform driver wrapper.
Date:   Thu, 19 Jul 2018 18:58:04 +0100
Message-ID: <1532023084-28083-32-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(2980300002)(36092001)(189003)(199004)(1671002)(478600001)(2616005)(126002)(26826003)(476003)(446003)(11346002)(48376002)(50466002)(14444005)(87636003)(486006)(106466001)(105596002)(51416003)(7636002)(4720700003)(305945005)(356003)(8676002)(246002)(5660300001)(336012)(16586007)(6666003)(76176011)(186003)(26005)(36756003)(316002)(426003)(8936002)(54906003)(42186006)(107886003)(4326008)(2906002)(109986005)(50226002)(47776003)(86362001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4708;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT006;1:Fj/qiQEBMBxsLKHrbDS3qte7Bu9XGo2IMqz8Wmp3/aC5TaEF2EIGHiUqkwRVdzpismGW2BgG8UVZG0/3a9ByIZa8JIOqIvz+SvSB9zC6ZeDUpvywMeAcnLO2vJLCLj4Q
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 172424d9-d9d6-4647-ac79-08d5eda16206
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN7PR07MB4708;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;3:17b0pef0jnB+MIyFLIMJEdjGp2hmEqPHasowVPv9dsMrO5MlBVyqu8hYUpOz1NbgA2Gr717s/h+2t7rkAIbF5uDMi4a/z19p1Q43UifRcRraV+7VU+m9ECyvEvybT16embDIgnzrks1O3rwdWiy+FtOSS5TAO1JbAqdRKq2i6eSWi2pTiFPMlU6UxWpQyFIF9sCBe4u80owT2G7lyrqU0PqR+7KMjiX6YCbIGYE4xdKFGVPxY3uMD2oIHyAEGBdxpSuNconmWPYOcmD8gPtmrReAYoJHvtAyVowGhIxr6q9xAYZEuHxUlWqWyFFUNg/khVz8yD/JhPvuYiNAFscgL6S3xYkhd7IbQQft+92HCHA=;25:xExO/zoVGg1in7zoH9s7L+BHlNUmdQ6fxFTLocqZbje2cY69WMpFC4FXBxDZdeXo+98a5wupvlb6WWFhjswkEB1+PJjp2YSUi5P7RVx0IWMb4iUbzgCA/7Hu5HpE0IRY1wboyAa6iLZ7GToYCd0nPOCSReMl+SvPvll+BYF9Jn0tgKZUiWc453c5FXzA691i+kjsoyvOzEyJalmXjwLSd9mG3Y58cXzaAdhRfXz1X9GLOPrKQu2lrQ9r4DyvZfZopnVnASNnw2elixq3USU9OfySdkbcbTKn4ZqOPuhIaM8NTxl5OtJunPKwn4O7Kv02mtU7DgnuGseCr7uyIpM3jw==
X-MS-TrafficTypeDiagnostic: BN7PR07MB4708:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;31:aa5OSf+3v8w+IrQgDnkxPaGFYPB2fJe+GUz0QL45ikEV8VNxDHJiRZNPolb8Zmrq911+1OrDWEUiwGGqY29jWRGAyTcsr7R1SbggTYm+WrCmGKfm+YIha4xJ3gTTmKhf3qbcnVQaAJ5euIbPB/TS2q8G3NhE3vA45/uni4GLNr2DZXNdYs5MLFjE10khEs4C4O4sgUhIcLgMl5Sra3Qfs2ANrQhonW2tnex+Wiuv+VY=;20:VrNUVAtF1b3K+yGmzAP7lDY3086MUogN7ez6OZs9nhmgFzdQkUbkHnOPG0yLEeYLxuikdOyoE/52YMPERD2TJhHKhESsU0e3sV0BpV7+idhxdVpaZOkSMBNRPfKYwQ7R1ePFX8ALVtnV8+ezXr+BN2QAgREoFii2PTO1ZvGeQVk50zoQJG1cS8Ak5zBQVPHys5j+E351NTz2Y3HnXA5UDtQ9ftu/PYgeRCi1UX4OAIwtboonHwDUNJPCcGfy9wBSSsrRe9f1aHXkDBTd2GlWEvluhr1Whs59plgGbCSfWbjQ0Dnm551XiCwSRyqbhYiwWhdpTaPuDyyQzZZS/z5bYP/KkA1kZx+NLor6c845TOafNqOIGkz7uX66zk0HR7a+/qHeEKQkxRCtm6MxMx2lkN4v+CCD6gIA0NdpBmBNkSbrw88pcMup48PSAZRzNU8VEIfXA3kFWMV1Igs3YFoo+HM/h+OuX1OupeeYpAoJ1r0XPlW+kJ4HPGHIaWUuU0yB
X-Microsoft-Antispam-PRVS: <BN7PR07MB470827674D58C97FD8EBEAE3DD520@BN7PR07MB4708.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4708;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4708;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;4:VQ7LYubM3/2FioQRsBBhYZsqymA76rCaOmTosLbbgF7enbCC2KZkyKiCac7t7rExKkuQzoH5Z+QBKMLC7xfUELWMKcYmFmM8u5WP0bwQB/nL6WU/6hpZREyGvDXo+iHFhV/TFJH2AcUJeM9SMoVAar5rtghn+QEPyI9eYi5HvL2FPCPkvg8wj6gkJbe+wp9SvlPydA7NskHR7qvlgM0NEcY2COHfHEmDRIOQsXpMqDpnroHfVVtvhKG5Tt19+mhwiLOl2pYJ4pnYUt5Ns4tno4THay7f07moLsv1xehQXAxPi9yhjlVxZtXWauVTSY4X
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4708;23:Qx6YpcoubgJYIwWhl9XsNNkdNLgO/5jFfbEk2MGh8?=
 =?us-ascii?Q?aqQWPdT8dHv+rLpDLKyh2lFfHu+KdSCHElI3+ieOZ9fsUA3bGbLNqwPBt3QL?=
 =?us-ascii?Q?bJOQ4B6xG0013ORK/jTs//97wXFMQA6Rh+ObzUdvcupzHz0AgRzdNfeexE72?=
 =?us-ascii?Q?ldk8cE2HylC8ToZy4Jl517tOaaiUqeVMrck1JP/zeK178l89IAUENQ540xLb?=
 =?us-ascii?Q?7YGx40YCrNJN2A6bxGSoSHjrADfqNZwGCRTDGxIqSy62nr36KiRgf9cKMV+C?=
 =?us-ascii?Q?kKZQ9ZCm85CWUjH+zrAJ+MxYtjHXakwN6jtWzO6IiHMx3RYJ9S3u5nc/iqUv?=
 =?us-ascii?Q?yFvYtanqrcT84BHgn1mNol4kCNSXjUx4v1QW5ErC2K/EaGGcSeLMe9b3kt+f?=
 =?us-ascii?Q?SSVkZvkF+FnsuB1ngqo6+uWKLrOaF3UaLonaShCj09M395oQhCWntDEdiny/?=
 =?us-ascii?Q?8m20HnqQDim3AoFPmoSdzKc1znLO+bWTApcASCQHA+Br+ouDHX00Vz0EFR0Q?=
 =?us-ascii?Q?NB0eubiQVsDudBVlbZKPgfEzF0I0k+OaMfw0m3c0LWPoCs1xD62K9J9XKSOR?=
 =?us-ascii?Q?MYvOA10gTYTz+IVCkW5ruv2Q1zMuSHMuVY+V253RnLYTVEITQx/Hh4ll7MGo?=
 =?us-ascii?Q?Ypv8WwhoxDuPSOcy1JZxt9oZ/duADddUdbggOQYq7d+JyJ07XjnSENd7U5SP?=
 =?us-ascii?Q?f1vEjhpXbifCjtm0AhqFwzQX+pki2nEdOpPlHTam2Sylz+Xz9JO90aqbhpn3?=
 =?us-ascii?Q?bhb711T9B3nKa7rnginlztZNv/ARDm56ansIMNgH6QYfBRYlEILVL8K1zTD4?=
 =?us-ascii?Q?e4gF9sir8y8B/cNo1K4wjG8e2DQAdUHTAtr6+NULXPnFYdaeVkKOv8CNsM8u?=
 =?us-ascii?Q?blbCVWl2fyiXmqSCSOZCbFzh1LSN6wDyqKxP7N+AzckdVWiesdaCIVQGA4Ah?=
 =?us-ascii?Q?LdS1c3lH0zy2duQAprWXOrMpbz7Bi3PMqv7EQFGcO1G6ttOT6eBhEZfKqXh5?=
 =?us-ascii?Q?gqcVs96kGnWQobjOPcmM4E6JdONmdz5xusUwNRGWhVj/3CcO8UPbTl/5+2zP?=
 =?us-ascii?Q?i4g7/4UYPAb9ra3OPiDkLdJ1qUbKNgCNVUTa+IAGsB2tSoGPg8RKqjsb8WmW?=
 =?us-ascii?Q?Jt7OSub1IAMEEhMgL5C2K2oydyAxfdLK8B89VJVgXcyVee4z13RsA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2iD70SFEjl0gy8DPNjCkFqf9PjbqsDh0hoFTh+l+Rv0uR4nLPLBco3Sy+e9u6rUtB9Ng5ETj6VVx9Ja3U9HKfAW9kHuQrH+cUvtU87IlJU5VU/16erdhz54g5f1PqPHfBvRxqiUZCavjcGG+KDgL/drrpLHvq34uO6i1FmmqDNlSwdCTzYTwqbTpae9VFKvWKL+idNsRbGpkX4Q9tZW72DlxV+catZWdcwIwk2bh/ktnkfAzNButMLkUvCT8tD6GTgNkqsXDka3znlbx0MWa4xduB5ojZbViCBifYTFxF+ZZjsHpM197N9geMXl+8esCg5blCQWQR3kloFI8AIcMqp//k+DnyAaoyLATiZ+grC+X7AUR/mxD7TRdD56nvqHNXHv6MJoSvBiPZouviJjAmQ==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;6:5fy7gN3oAKZNUS6NuUPDLRpR6UqRkSKHbK20nOshv674fFwgYHR6re7l0zdzjdgKK7/HQHdhgAYb8YCVGNoFG602G5uVdTA9JMORthHJIyr0klGw4oyayA58CACzaYLSrs8oEi3pNfiIAJw7uUHQSTWRhT1jB02SWhIbaqDOWqJ2TSh1qZhg8pHMP2Cm+tcTK213hVWUBzPMraqv7g2BjGIH2jheeOfPB0f2jtu0nix0KKfi1kSEqcrmZ53aCYVmXBdNNCji+SbufHZoVhwpcM3UkxV+iVIyhFiyjJXUDHuRucdhuUKIOcHeMx7E/xP5L7DftiuiBgBkv9O1Lex48XWOvu9Vrc9rs/JQdueu39YA8K8qoEDDeGBmneakArSK0Xbm/wM2YCoNkyuFpCSiMw0AnGDlIkp/AJBDhiFH51UOXmCUypSfQGLohBgIsqHpjWkYeUYkuuJkAlSGZ4UPRw==;5:YUL6DDJcr8j27hUAriicUscDKgZMRpWPR+9qdREfhZITziVtfAGoXE7+WsIsf5OYBK3dNdJn+llQrBvey42xLtVAkKi2DYxsz90Ybn9fNj21E3brgqA4ax+ycG8Ntd5eCrdBEvrNizrTQzyY9poKf0X4GjMEWgYHMBwdKs3MLds=;24:4bQfExke7gb2CuZE5VXLTtK++x9bYCZ7UBC6XsGr/Z8GlIferT9jAR1aJmsXxB3Z95RU0wxqifvvsJKP9m/afktPHaYafTr+do7kql++r8k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;7:Dol62oBtMy92zoI3FvxkgVt9R5Rls0S6Jrdsol8RHWKV1OeKUVdYzC2+YUaHJQDUPfvQ+3zqEYpMtu/OX6N0vF1wJaktC0Qv4NR6TXiz0giHanI5n+0YuqPDElcv3/D04YGk9BH3X2kOoZShi6tP5PgnIPXbHt6qgbqDtksJIOkm0Kx10ehT5vYtmQTd3vdPmQMF6ORZ+SOaUW57S2+5BwcEanRtFCRTo8JCkgxqEJPnhCV7IAhKkQDtJLRsEpKo;20:N7REZ/p+0z595NlWz36oye3GQDLc2/uz7XGyV73pSOV6rESCSIRv1cxf3gOoFpah+LYzTnxuFcR/kdzAtfOC3jMPJ4QteiC7UkZui9KBxDt7LurSdJjMmF3c9548AAJvt0kszGLtL36HaNRunrCxSWtdbxkl/bUB2Y4gpzU4NR04daBe+cBPXlIzAI6294VagBBTsX6HbdpUYwZlujwjxnyY5Rvx8Q5xXv5Av0rUy3vAqmq/v1LeH73Hewafgs5B
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:32.9946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 172424d9-d9d6-4647-ac79-08d5eda16206
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4708
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds PCI specific glue drivier that creaties and registers in
system usbssp platform device. Thanks to this we can use
the existing usbssp platform driver for usbssp controller
build on PCI board

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/Kconfig           |  10 +-
 drivers/usb/usbssp/Makefile          |   3 +
 drivers/usb/usbssp/usbssp-pci-wrap.c | 226 +++++++++++++++++++++++++++
 3 files changed, 238 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/usbssp/usbssp-pci-wrap.c

diff --git a/drivers/usb/usbssp/Kconfig b/drivers/usb/usbssp/Kconfig
index ee20b01753dc..bada82e5d223 100644
--- a/drivers/usb/usbssp/Kconfig
+++ b/drivers/usb/usbssp/Kconfig
@@ -17,5 +17,13 @@ config USB_USBSSP_GADGET
 	depends on USB_GADGET=y || USB_GADGET=USB_USBSSP
 	help
 	  Select this when you want to use USBSSP in gadget mode only,
-endif
 
+config USB_USBSSP_PCI
+	tristate "PCIe-based Platforms"
+	depends on USB_PCI && ACPI
+	default USB_USBSSP
+	help
+	  If you're using the USBSSP Core IP with a PCIe, please say
+	  'Y' or 'M' here.
+
+endif
diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
index b267fadcb104..fbf5d55500a4 100644
--- a/drivers/usb/usbssp/Makefile
+++ b/drivers/usb/usbssp/Makefile
@@ -10,3 +10,6 @@ usbssp-y 			:= usbssp-plat.o gadget-ring.o \
 ifneq ($(CONFIG_TRACING),)
 	usbssp-y		+= gadget-trace.o
 endif
+
+obj-$(CONFIG_USB_USBSSP_PCI)	+= usbssp-pci.o
+usbssp-pci-y 			:= usbssp-pci-wrap.o
diff --git a/drivers/usb/usbssp/usbssp-pci-wrap.c b/drivers/usb/usbssp/usbssp-pci-wrap.c
new file mode 100644
index 000000000000..10c0189c61f7
--- /dev/null
+++ b/drivers/usb/usbssp/usbssp-pci-wrap.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver - PCIe wrapper
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+
+struct usbssp_pci {
+	struct platform_device *plat_cdns;
+	struct pci_dev *otg;
+	struct pci_dev *hg_dev;
+	struct resource res[5];
+};
+
+struct usbssp_pci usbssp;
+
+/**
+ * usbssp_pci_probe - Probe function for Cadence USB wrapper driver
+ * @pdev: platform device object
+ * @id: pci device id
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static int usbssp_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	int rv = 0;
+	struct platform_device *usbssp_plat;
+
+	if (pdev->devfn > 1)
+		return 0;
+
+	if (!id)
+		return -EINVAL;
+
+	if (pcim_enable_device(pdev) < 0) {
+		dev_err(&pdev->dev, "failed to enable PCI device\n");
+		return -ENOMEM;
+	}
+
+	pci_set_master(pdev);
+
+	/*
+	 * function 0: device(BAR_2) + host(BAR_0)
+	 * function 1: otg(BAR_0))cdns3_remove_roles
+	 */
+	if (pdev->devfn == 0 || pdev->devfn == 1) {
+		if (!usbssp.plat_cdns) {
+			usbssp_plat = platform_device_alloc("usbssp-dev",
+					PLATFORM_DEVID_AUTO);
+			memset(usbssp.res, 0x00, sizeof(struct resource) *
+					ARRAY_SIZE(usbssp.res));
+			usbssp.plat_cdns = usbssp_plat;
+
+			if (!usbssp_plat->dev.dma_mask) {
+				dma_coerce_mask_and_coherent(&usbssp_plat->dev,
+					DMA_BIT_MASK(32));
+			}
+		}
+	} else
+		return -EINVAL;
+
+	/* for GADGET device function number is 0 */
+	if (pdev->devfn == 0) {
+		usbssp.hg_dev = pdev;
+		//device resource
+		usbssp.res[0].start = pci_resource_start(pdev, 2);
+		usbssp.res[0].end = pci_resource_end(pdev, 2);
+		usbssp.res[0].name = "usbssp-dev-regs";
+		usbssp.res[0].flags = IORESOURCE_MEM;
+
+		/* Interrupt resource*/
+		usbssp.res[1].start = pdev->irq;
+		usbssp.res[1].name = "usbssp-dev-irq";
+		usbssp.res[1].flags = IORESOURCE_IRQ;
+	} else if (pdev->devfn == 1) {
+		usbssp.otg = pdev;
+		//OTG
+		usbssp.res[2].start = pci_resource_start(pdev, 0);
+		usbssp.res[2].end =   pci_resource_end(pdev, 0);
+		usbssp.res[2].name = "otg";
+		usbssp.res[2].flags = IORESOURCE_MEM;
+
+		usbssp.res[3].start = pci_resource_start(pdev, 1);
+		usbssp.res[3].end =   pci_resource_end(pdev, 1);
+		usbssp.res[3].name = "debug1";
+		usbssp.res[3].flags = IORESOURCE_MEM;
+
+		usbssp.res[4].start = pci_resource_start(pdev, 2);
+		usbssp.res[4].end =   pci_resource_end(pdev, 2);
+		usbssp.res[4].name = "debug2";
+		usbssp.res[4].flags = IORESOURCE_MEM;
+	} else {
+		return -EIO;
+	}
+
+	if (usbssp.otg && usbssp.hg_dev) {
+
+		struct pci_dev *pci_hg = usbssp.hg_dev;
+		struct platform_device *plat_dev = usbssp.plat_cdns;
+
+		rv = platform_device_add_resources(plat_dev, usbssp.res,
+				ARRAY_SIZE(usbssp.res));
+		if (rv) {
+			dev_err(&plat_dev->dev,
+				"couldn't add resources to cdns device\n");
+			return rv;
+		}
+
+		rv = platform_device_add(plat_dev);
+
+		if (rv) {
+			dev_err(&pci_hg->dev,
+				"failed to register cdns device\n");
+			platform_device_put(plat_dev);
+			return rv;
+		}
+	}
+
+	pci_set_drvdata(pdev, &usbssp);
+
+	return rv;
+}
+
+void usbssp_pci_remove(struct pci_dev *pdev)
+{
+	struct usbssp_pci *usbssp = pci_get_drvdata(pdev);
+
+	if (pdev->devfn > 1)
+		return;
+
+	if (pdev->devfn == 1)
+		usbssp->otg = NULL;
+	else if (pdev->devfn == 0)
+		usbssp->hg_dev = NULL;
+
+	if (!usbssp->hg_dev && !usbssp->otg)
+		platform_device_unregister(usbssp->plat_cdns);
+}
+
+#if CONFIG_PM || CONFIG_PM_SLEEP
+static int usbssp_generic_suspend(struct usbssp_pci *usbssp, int param)
+{
+	/*TODO*/
+	return -ENOSYS;
+}
+
+static int usbssp_generic_resume(struct usbssp_pci *usbssp, int param)
+{
+	/*TODO*/
+	return -ENOSYS;
+}
+
+#endif /*CONFIG_PM || CONFIG_PM_SLEEP*/
+
+#ifdef CONFIG_PM
+static int usbssp_runtime_suspend(struct device *dev)
+{
+	struct usbssp_pci *usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_suspend(usbssp, 0);
+}
+
+static int usbssp_runtime_resume(struct device *dev)
+{
+	struct usbssp_pci *usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_resume(usbssp, 0);
+}
+#endif /* CONFIG_PM */
+
+#ifdef CONFIG_PM_SLEEP
+static int usbssp_pci_suspend(struct device *dev)
+{
+	struct usbssp_pci *usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_suspend(usbssp, 0);
+}
+
+static int usbssp_pci_resume(struct device *dev)
+{
+	struct usbssp_pci *usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_resume(usbssp, 0);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops usbssp_pci_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(usbssp_runtime_suspend, usbssp_runtime_resume)
+	SET_RUNTIME_PM_OPS(usbssp_pci_suspend, usbssp_pci_resume, NULL)
+};
+
+#define PCI_VENDOR_ID_CDZ 0x17CD
+static const struct pci_device_id usbssp_pci_ids[] = {
+	{PCI_VDEVICE(CDZ, 0x0100), },
+	{ /* terminate list */}
+};
+
+MODULE_DEVICE_TABLE(pci, usbssp_pci_ids);
+
+static struct pci_driver usbssp_pci_driver = {
+	.name = "usbssp-pci",
+	.id_table = &usbssp_pci_ids[0],
+	.probe = usbssp_pci_probe,
+	.remove = usbssp_pci_remove,
+	.driver = {
+	.pm = &usbssp_pci_dev_pm_ops,
+	}
+};
+
+MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Cadence USBSSP PCI Glue Layer");
+
+module_pci_driver(usbssp_pci_driver);
+
-- 
2.17.1

