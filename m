Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BC2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FC420C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="CudWnus2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FC420C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeGQOPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:15:53 -0400
Received: from mail-bn3nam01on0063.outbound.protection.outlook.com ([104.47.33.63]:51264
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731497AbeGQOPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnXhlmMbJo8bOjO14chAZlDtIpLQI+VMwTptywPo0rw=;
 b=CudWnus2SrrP7VgFQD0HmsrHET0tbmxiYFWosNIFTHBYkbAddFoe8YGH5fJRVKBfyDn6JXzVMM9CpTb2m7oj7Hg7Rr2awgPNuo5BJ+OKNnFtUknGp9lZxAo7I7dJp9/p8y5PuKx94DlK1kevFVVXY8Qq4xEAjVLdRN4+gnLkq/8=
Received: from BN3PR03CA0085.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::45) by DM2PR03MB559.namprd03.prod.outlook.com
 (2a01:111:e400:241d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Tue, 17 Jul
 2018 13:43:05 +0000
Received: from BN1AFFO11FD025.protection.gbl (2a01:111:f400:7c10::133) by
 BN3PR03CA0085.outlook.office365.com (2a01:111:e400:7a4d::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.973.16 via Frontend Transport; Tue, 17 Jul 2018 13:43:04 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1AFFO11FD025.mail.protection.outlook.com (10.58.52.85) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.20
 via Frontend Transport; Tue, 17 Jul 2018 13:43:04 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w6HDfhq0009486
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 17 Jul 2018 06:43:03 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 17 Jul 2018
 09:42:26 -0400
Received: from mircea-Latitude-E6540.analog.com ([10.50.1.102]) by
 zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id w6HDgMUf005768;      Tue, 17 Jul
 2018 09:42:23 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <peda@axentia.se>
CC:     <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
        <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V2 1/2] =?UTF-8?q?mux:=20adgs1408:=20new=20driver=20for=20Ana?= =?UTF-8?q?log=20Devices=20ADGS1408/1409=20mux=20=E2=80=A6?=
Date:   Tue, 17 Jul 2018 16:42:18 +0300
Message-ID: <20180717134218.5642-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(54534003)(2906002)(77096007)(86362001)(1076002)(356003)(72206003)(2351001)(7696005)(106466001)(2870700001)(14444005)(186003)(107886003)(336012)(6916009)(6666003)(53416004)(5660300001)(305945005)(23676004)(8936002)(2616005)(476003)(4326008)(5820100001)(7636002)(50466002)(44832011)(486006)(50226002)(426003)(36756003)(47776003)(126002)(316002)(246002)(54906003)(478600001)(26005)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB559;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD025;1:6X8mjIlsqRhujlniCrPC6hW0tI8MIlQhaWEEahLzL1NimIBmBzvFG8socuepstlW1Mvk8TUHQEoJ08Ph6X4+MAPM4hsEnI43jjUIGARyySJIJK6OAEHAfCk7SRtIhj86
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2708920d-7040-41a8-a0d0-08d5ebeb38c3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM2PR03MB559;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;3:e9zMsA+8WntDQqB2qr9/Td2MbL9ed3Xa9VyhsV2V2j094ZCUSSxWGUVhuFtidP0vyiMl5JcdemPEATb979mueWqSe7jZxfa1tSAJ9XEnoK8b9F1pa8QxFdwrT1O+vme2QF9jRAkyXjxmV7UBKLFq40JvCFdCdo6xsHQBFYVOEGL8aR02MwUwB19yw8U/ivEcTXTKl4BP/QmoQwxLsNDAFDCWLjmQr3Ll2ZdoK0k4fYrZkkiCihgntt95HO9cqkGcqF3FoSBWJyXBKpdp2SKT0Q39QvwLZGFdE8kdlancV2h6nE7UjHwA2cfXzYptLpCfVm6f2GhradvEIG27KCQqGQ==;25:3+YPbzaU2YZWPnk4Gz+I/MGKNGlQrAyQZskyGBsK5TOz5zmDC5Bn2R0MdJG78hNNNoczy+m+dDxPI4TMZEGOC3C9fFp6ipWjfsZ/9PbO2HkV06bDwEvQbG6I07F+bQDXoOwsjTtxDR+SjB4YN5EzB+z1r6+VCR7N2a/yqsXy6+TwzrCv/mJO0yYrPWAwf9WIByJx4eOY3MGjvO0HZzntajJzEDgnhIEYmuwXQ2Dc/VMms6vR6pDDdL+TFY37f/zdWTgoV78gKoLl11nmDoZJ11M4Qi+5gZIGI2QQs0AsBkskO0UrLvvJKLjriQi3opPhtXZ+eWP658H/LdFJeuJZxg==;31:HcQYZIfDWIywDk2UcTGjobIT4tqJq0kBlIiArYRmGDtd/m75IJzcEEHiaIZJ8IUhxjlJHHvYDXzmobdtDwcu9Dc+v0d+2lbwjdcB3c7/s1J57GnfSpuyV9O9CacPQlsX4y5t1ebnj6qkW//p8rdyxOVsbK13OutmSy5BQg53YLOnKkHEtDMWKP7aoJrNwPh/2hJPJtaqxhDFzteRprVCt9Y1hrdBTigFCehwGH8GQic=
X-MS-TrafficTypeDiagnostic: DM2PR03MB559:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;20:CiZPEKrnO77dwO2nrMQyjfhZJcPYycq6NdFRDvcbiku2zb8aIGqCfb+HKcqZ3B1YNRvLra9lWRW8p0dFZ05ThXwCfk8HL1WCJA4b1GZw++hTa2oTjI2oZpPAt8m/hvLVVtaRRY2VVLNL+sKT1onIzR3HZhwo8HveVSRghlU4xETI1hjJdVDFp94sYbqEkGi0AMktczTWAMxdonFRFTOgrYFlnbAda1Pj+urpmwW/ROxvpZ3QJ+ZVPUa51hHaeQEbJ7WOGfnCUzhuuflvf5Un30nZbxTM81PQyUO+Q13TVJD2QQndhpJHWk/8Qymtv1+ySGSGfG+10oqgz23ezxwdyDLWOyWJorZptMTucmEdsvAx4nw53ERo3AKRMLPvjla8Glc3neTw73IcR5UY41CV4LaZkpJMVYMOobOGljcoexM4MngSugwsey8P2lDSKGtxc4eCeFbg07hfCUTrA9c4TOvVVzrIsfsI5JeOyxNfJu3CvTjJXiR8faTKZqiT94o/;4:uM6pu5Rkvhir8ukic2G/YnDiXEp13tJhbzRiZDPl8Jy2yDBm7BmuZQmPbpIofKDmPZ6wRmbs/tOcPdHvWtf3OJrTGAho1NP20Gz/CmlsO5++Op/3J5euqTlUFaDb+jqIvwsT7XefJHr7QmdljpDolsZztzdOfbpwbhlPBP7JPiP4UtqZ5SZV9rAbwskIAplqR9Tz688oU58IY7yHnLRhj1p5eE7NamGb4HkKJQI2a5UKZF2AbtZyd5rseA//bas+/73PB896Z08an4mkqIh/EpDMH2rsLlR6ucK+BSCNSejulhNmEbTSM19F+npjnIQ3OVVTJKmrkyLaIi0lDj2DFjOOKFjmisk59ya3HEKTEKE=
X-Microsoft-Antispam-PRVS: <DM2PR03MB559001401F37CD77A4E13F0815C0@DM2PR03MB559.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM2PR03MB559;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB559;
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjAzTUI1NTk7MjM6ZFBjSkxBekY4d25PdDFwZ1QrOWVSRk5JMWhZ?=
 =?utf-8?B?VEJEZjdzN0xjUDlIS3o2cXlCMEE1VXJ1bXErbzhqc0ErWE8yckdMa3dkVUVs?=
 =?utf-8?B?WWJMUDByQS9UekcwL3pselkrK3dEUFhFcmU0Y0RUV1hKSEVmQzd5WGtGVm1a?=
 =?utf-8?B?WjJkODdkaXpXYTAxWE5aTURRdnFWYlVQY0JLWVR2bVNSalc5b2NWYWE3QTZa?=
 =?utf-8?B?SDZXblhTWi84YUFJL1pBSXJqZGdheGlxNHJ2TWFoZzduUXMyaVRiM1oxdGtt?=
 =?utf-8?B?WENZZ281aEdwRjIzdjcyV2cxdlhFc3I2NU1LdHBCYkg2djkwVTdPeGk2Ylhi?=
 =?utf-8?B?YXNXYkk3SXN2UHJUVDFBL3QvTnZQaisvSDdRSUY5eEJET2lENTA4N0xWMEhL?=
 =?utf-8?B?dHQrdDR2TG9qeFUyTFQwbUdNY21mQXY1Z2swK25MenMrL0ZEeEs3cEN0bDIx?=
 =?utf-8?B?SHNGZFhTNzJVc2FrR0lHeWdtWXlwN1R2VGp6aWMycHVZd3VMVUZvWk51YUVh?=
 =?utf-8?B?VXpzTnROZlVsSGhnN083aXp0SUk4K3kycEpNdUFYSkFjSHNUUEk5K0dkeGw4?=
 =?utf-8?B?ckNjWDNtb0lJRldXRllyamQrRXZ5bFNEZHZUUTBsSGlsRUhNU3lILzJGV0ZO?=
 =?utf-8?B?L1hTTTdnUTlpYVZtYUZuYlJnajlQSkhybmxZSHdqQWlvc1c2L1BlTWNKWWt0?=
 =?utf-8?B?MkZYUnEvaUVaaWxoYTJBQTl0bk54cG1qQlhZc3c1R0kvSHdNRTliLzdHRWhi?=
 =?utf-8?B?TGdHMXdiaFIzc3BXMFhEL284R3RZSm1wU2JobkFtOVZMTFNrWTlwTWI5SDZt?=
 =?utf-8?B?Mjh0TUFrLzdlWDg1dGZSbWxnR05INFFubUh3cFI2VXd1MmJ6R1RwR3BiR3No?=
 =?utf-8?B?dmtOUU5MQm9SOHVTNm1aMVlKdnh1Y3BxaU5KWWFKWkgwTGV4TzlKRFhKN3VD?=
 =?utf-8?B?Qk51QXVTUVh1c25sKzZ0TVhuRzc5MGFXVTYzb3p2YzZ1RURJOHd4eTBrY3pM?=
 =?utf-8?B?L2w2SEpyYTJzYWFOY0lVV1NhTDAyalRYZXdzbEl2RzFFUFBvQ1pVVjUySmtN?=
 =?utf-8?B?SUpWZVAxVGIrU1MxVTdQYjkrLy9BTldNUUlCaDlST2lBdTJOYnBBdE5tdndB?=
 =?utf-8?B?QjFvSmI3K0JTMkhtU003VEJoSWpxTlE3WVRXRzJ0V3Jud29xaWlkQkxiWE9I?=
 =?utf-8?B?NUlQdXZQbS9DaFJ0L2t6Lyt5cU16WlB1b056cXBwWC9jODMxamRnNWpvem9X?=
 =?utf-8?B?NUpkTnJWdjU4SlAvc1J3d0lZYkxhQnpjdFdMVnNMVUNCVEkyajFFQ2hlME1o?=
 =?utf-8?B?bnoxa2JFc1B1Snk5eFdjUjQzWnRMTlg4dnJvK0N2d3FyMzd5b2h5MnMzRWZv?=
 =?utf-8?B?MkVrLzNNbXpzdENqVFV6VG1rUmpCdk1yOTBTVEVTc2ZwMU9xQ3gzZXVQamtD?=
 =?utf-8?B?UlZqQnRwTThvUUIvdEpBTTJZQlZiWE05blZPbXpVWWxGdE9XWERHRzhpcElt?=
 =?utf-8?Q?aI8t0fU9Ouc7VQducctLFxBM=3D?=
X-Microsoft-Antispam-Message-Info: +HHKiww7IFrTjzFh7v6TSmOqTztiNQQ18grut/EIZSwuEu586vv9VsB0buYhnLGwih3yuQkQ/8r9D7nt1+4NN51GkeiUvpUuhej/rkTVFwlcP9nTYh1ia2wCG3/vPBImCOJtzBhvfuG+tA9d7IZUCTN1Llk8RybDrBA3EDGfoFgPQCv5bj5CqK1+YxRtUojTPYI18chGzuHeqdXWQnqgRGaO/BgSyxoxJIw/91FmqG3FyWnukZx6ED7ymOtYHxo+w5M0u/MbTYpHbfEZRMcsWAbzqLXwYbde4o9fHoR23Ywk22Hp361TLfT7/gXuP4VjuTG5KLB2MOvGGYPkx87YgjZPT6Pj5Q6zdbkDM0zNyiY=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;6:xqk1TTHbMDzuziQwkuKELj/g8reFmXYvjhSUQk2yE+clXOH87tYe2P+zVBUKmyivF5mbbwuSZC4j9KWP90A+UrJBExIIPvJYIXkGGhC5O6/522/o+qRs3DnGa+tkv0hUI90gu4gi7WNpLwTHzU9kFxuOkxlViNEiGYWNhO+TvqlqXS/wxhb3gva1Jkm39c6WGwueO7dz5lWDQ6LfbToyWpfxJJIzRh+SfqBDkWuZ0tmdClj7ZDdvPqnhehHvviJDmEgIpKdsRQs02Gf5Cp57Xs4Fl2KyDUaz0FbesNMDUpDGFp4EYynes9UlecR7LOhF4fjelQK1lJCHsXZi4zc2+ZJ110Z/UnNCNIFl/RU7jeZc8odEQNf57JYBuNNFYt8h45wgJTH/LyUrTA/dwAs6p+PTM3YCHH9EFzroUHhrwFg8wU20TblZRtF+JTdXo5+kTtFUEJi3bDe07EA5Xno0DA==;5:YF9OHLB2PZAK+hFfUZ0nscKIIMcdlcfgSXpKTmM/D2o2J7rrtFokEewSFklhH9/8YZyIm7bomqxtHqKmsTpUDfp2kY/sVJXAJI/j1/EowNTOcqyTz2CsWn53ezusfyEGTLMH3Gq77dgU4v2rejTOhLTj/ug6bcfcIr7+8J4STtA=;24:P8MkaoJySXNxqiWZJK+Fd61AIf6/r8NJsMCRPm9RK5Y3QGq3rMmKDe/Rkqbc0badLcRMSdTDidtB3Ftz35l3nQ+MVOP/qyW9ZVAPGVHO6o8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;7:mJ2uQkYH8O3Vo9U/W+l2ef6+q1NeStQuHrm28GcsEEYne3rsIACPPGtF/sjr0ur/Xoe9NiWyT6nPQ361MrqEANqGM8ienFjdtFcv7fYIWVYrXGtfS4HB8iJ4KaUwGy7mzX2AOQSJrwMdmzkPwFdIJFDK9OD1JMdANK3jbJml230oU4GW44xVkMV5vpbyfrpBooBpqQhf8/0bz/LXA02VrcGm8cV0N+b0IBth8MuEmRzvpJRVQrxJaIqqVUTmP+5D
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 13:43:04.3730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2708920d-7040-41a8-a0d0-08d5ebeb38c3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds basic support for Analog Device ADGS1408/09 SPI mux
controller.

The device is probed and set to a disabled state. It uses the new mux
controller framework.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
Changelog V1 -> V2
- removed adgs140x wildcard
- removed cells verification since only 0 configuration supported
- added id enum for ADGS1408 and ADGS1409
- sorted includes

 MAINTAINERS            |   5 ++
 drivers/mux/Kconfig    |  12 +++++
 drivers/mux/Makefile   |   2 +
 drivers/mux/adgs1408.c | 120 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+)
 create mode 100644 drivers/mux/adgs1408.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 192d7f73fd01..458d42d6f4f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -810,6 +810,11 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/ad9389b*
 
+ANALOG DEVICES INC ADGS1408 DRIVER
+M:	Mircea Caprioru <mircea.caprioru@analog.com>
+S:	Supported
+F:	drivers/mux/adgs1408.c
+
 ANALOG DEVICES INC ADV7180 DRIVER
 M:	Lars-Peter Clausen <lars@metafoo.de>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 6241678e99af..cf825e9f47ef 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -21,6 +21,18 @@ config MUX_ADG792A
 	  To compile the driver as a module, choose M here: the module will
 	  be called mux-adg792a.
 
+config MUX_ADGS1408
+	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
+	depends on SPI
+	help
+	  ADGS1408 8:1 multiplexer and ADGS1409 double 4:1 multiplexer
+	  switches.
+
+	  The driver supports driving each switch independently.
+
+	  To compile the driver as a module, choose M here: the module will
+	  be called mux-adgs1408.
+
 config MUX_GPIO
 	tristate "GPIO-controlled Multiplexer"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
index c3d883955fd5..6e9fa47daf56 100644
--- a/drivers/mux/Makefile
+++ b/drivers/mux/Makefile
@@ -5,10 +5,12 @@
 
 mux-core-objs			:= core.o
 mux-adg792a-objs		:= adg792a.o
+mux-adgs1408-objs		:= adgs1408.o
 mux-gpio-objs			:= gpio.o
 mux-mmio-objs			:= mmio.o
 
 obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
 obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
+obj-$(CONFIG_MUX_ADGS1408)	+= mux-adgs1408.o
 obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
 obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
new file mode 100644
index 000000000000..a5192c5e484b
--- /dev/null
+++ b/drivers/mux/adgs1408.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADG1408 SPI MUX driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/mux/driver.h>
+#include <linux/of_platform.h>
+#include <linux/property.h>
+
+#define ADGS1408_SW_DATA       (0x01)
+#define ADGS1408_REG_READ(reg) ((reg) | 0x80)
+#define ADGS1408_DISABLE       (0x00)
+#define ADGS1408_MUX(state)    (((state) << 1) | 1)
+
+enum {
+	ADGS1408,
+	ADGS1409
+};
+
+static int adgs1408_spi_reg_write(struct spi_device *spi,
+				  u8 reg_addr, u8 reg_data)
+{
+	u8 tx_buf[2];
+
+	tx_buf[0] = reg_addr;
+	tx_buf[1] = reg_data;
+
+	return spi_write_then_read(spi, tx_buf, sizeof(tx_buf), NULL, 0);
+}
+
+static int adgs1408_set(struct mux_control *mux, int state)
+{
+	struct spi_device *spi = to_spi_device(mux->chip->dev.parent);
+	u8 reg;
+
+	if (state == MUX_IDLE_DISCONNECT)
+		reg = ADGS1408_DISABLE;
+	else
+		reg = ADGS1408_MUX(state);
+
+	return adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, reg);
+}
+
+static const struct mux_control_ops adgs1408_ops = {
+	.set = adgs1408_set,
+};
+
+static int adgs1408_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct device *dev = &spi->dev;
+	struct mux_chip *mux_chip;
+	struct mux_control *mux;
+	int ret, idle_state;
+
+	mux_chip = devm_mux_chip_alloc(dev, 1, 0);
+	if (IS_ERR(mux_chip))
+		return PTR_ERR(mux_chip);
+
+	mux_chip->ops = &adgs1408_ops;
+
+	ret = adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, ADGS1408_DISABLE);
+	if (ret < 0)
+		return ret;
+
+	ret = device_property_read_u32_array(dev, "idle-state",
+					     &idle_state,
+					     mux_chip->controllers);
+	if (ret < 0) {
+		idle_state = MUX_IDLE_AS_IS;
+	}
+
+	mux = mux_chip->mux;
+
+	if (id->driver_data == ADGS1408)
+		mux->states = 8;
+	else
+		mux->states = 4;
+
+	switch (idle_state) {
+	case MUX_IDLE_DISCONNECT:
+	case MUX_IDLE_AS_IS:
+	case 0 ... 7:
+		/* adgs1409 supports only 4 states */
+		if (id->driver_data == ADGS1409 && idle_state > 3)
+			return -EINVAL;
+		mux->idle_state = idle_state;
+		break;
+	default:
+		dev_err(dev, "invalid idle-state %d\n", idle_state);
+		return -EINVAL;
+	}
+
+	return devm_mux_chip_register(dev, mux_chip);
+}
+
+static const struct spi_device_id adgs1408_id[] = {
+	{ "adi,adgs1408", ADGS1408 },
+	{ "adi,adgs1409", ADGS1409 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adgs1408_id);
+
+static struct spi_driver adgs1408_driver = {
+	.driver = {
+		.name = "adgs1408",
+	},
+	.probe = adgs1408_probe,
+	.id_table = adgs1408_id,
+};
+module_spi_driver(adgs1408_driver);
+
+MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADGS1408 MUX driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

