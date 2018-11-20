Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D64FC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA7B206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="I9jC8NGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA7B206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeKUCOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:14:44 -0500
Received: from mail-eopbgr720088.outbound.protection.outlook.com ([40.107.72.88]:62521
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbeKUCOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLoKG/gqXvBZcG4g/QRhCef/ZNpv/kexeJqtQb6srwY=;
 b=I9jC8NGlhZqgeVy208GfS4zMtA/UEUWsgmd4WbYKrafc1nlqltkjL86RExTw6iqdgniIpkilbyWpJPBgw4sTmAyCnLAgnaTVLLe+guLAH0v2QiexoiUKzvLcPfkLCEq5iTub5D03o24xyCkmoNo+jhTc+XbHfa3lAK/wW405VLg=
Received: from CY4PR03CA0095.namprd03.prod.outlook.com (2603:10b6:910:4d::36)
 by BN3PR03MB2258.namprd03.prod.outlook.com (2a01:111:e400:7bba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1361.14; Tue, 20 Nov
 2018 15:44:50 +0000
Received: from BL2FFO11FD014.protection.gbl (2a01:111:f400:7c09::171) by
 CY4PR03CA0095.outlook.office365.com (2603:10b6:910:4d::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1361.14 via Frontend Transport; Tue, 20 Nov 2018 15:44:50 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD014.mail.protection.outlook.com (10.173.160.222) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1339.12 via Frontend Transport; Tue, 20 Nov 2018 15:44:49 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id wAKFin5n014425
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 20 Nov 2018 07:44:49 -0800
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.301.0; Tue, 20 Nov 2018 10:44:48 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: adc: Add docs for AD7606 ADC
Date:   Tue, 20 Nov 2018 17:44:37 +0200
Message-ID: <1542728677-25899-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(356004)(6666004)(336012)(36756003)(5660300001)(426003)(8676002)(50226002)(8936002)(26005)(50466002)(7416002)(4326008)(126002)(2616005)(476003)(486006)(44832011)(7636002)(186003)(478600001)(72206003)(77096007)(966005)(305945005)(1720100001)(5820100001)(2906002)(110136005)(47776003)(107886003)(2870700001)(316002)(6306002)(7696005)(246002)(54906003)(106002)(23676004)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2258;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD014;1:Kv2R8E0lnnPGkfq8Ic4FL236+6bTCpXYM/x3QTuJxSJgJffiW9fwjvB87n7i4HKtJRavxG7mU2huNHBg4z1NM3iak/yjz6kKPOUVmxtY6bOnpD+AX5Vzn6CA9atB8wWd
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc543f4a-d4bd-4b52-2f83-08d64eff1b08
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN3PR03MB2258;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2258;3:epQJVvwsYi//mF1tQDOS1kslHDPp4M7vWvfCkePrRtey89oESpOCZadn2QdK6+ps3ZW2pOm5tWMdnzDNbNOQvjmTH37qFGETT4H5Mu9QLPQhkhDTl+zJOKhEIGwa5OHKp4nXmRArygfazaeeNVZ88AKCybTafv9O975Npetqk+hKEm4DVKsntx8FWIGRozIn3X7Lduo8yYVB+CBzkG6StFpNITiAD22Y8je37JV+dJdhP+do5npJRZTwjNQCcmy1BB5D0n0yKXpeBsDtxeOi4+ZVWdGB+5Tg6612KCVkIXcFG179RilmEu6yn+s/Fga0PuScskCoHixP4oeIN1G+EGSpfgv3pFHvePA8x4Jc7i0=;25:V3SniEq9bbsLiW+4TaMl3IT19Vx0/6KgOIcZiAZG0M6Z4r4h4qWjhcOfpc3lhgNtfMff/42U2h6NcKyrs3LBULArReegV5D0rCw3RbkfyfC8JzdBSGLIab71aTZ9GqK7+cyfsjvfGZLlWZlSBUIhDW4KkMr94ba+yI0tfrMtRQyqJUQVju5oDqbBaLQZhSZnEeOY0nqBwisPVE4RGyIpqg/vRwsx3lv2rx6/lclgs08LHpM4q/47EnNvUN7WeiYizfY3wolAPSedW9CsXrslJGXrXqhUQRZ/BVidf2M+TgdUim5nc8iV6FPa09n/NvR7F9pwtzjfNGlYCxqK57KDeQ==
X-MS-TrafficTypeDiagnostic: BN3PR03MB2258:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2258;31:OKSOt66Ky3TcNMXhhwPDH+m7uTEr1JiaIuaQdfrNf/czCToJEhWgHv8gVdD7Z75uVmw24Hxj9pi1RP8Xhdsc/wrL5MFpT8zZwHM4YILVjWdOyFqeJ1hqO1Q8+LHKNWWlQQqNVbnO8BPG4zlN416PcqB12r1Y/VFSWlhkROEzX23NTLQN1Rb/T0DwTxhZZoZG3xBv/piathQ6nxyOPftD/ZjgbtYK0GlBEa1yBnJ0/ik=;20:z8+EwjT9g0+ofsrynSvRwqSm0j+YT6Q14A9lpWbTj3mepMGAvXytXAq0UIap41YEKaYF0Mknvp83WCYUavP1bDQG9OuTByZmePKFy2STjz9DenCFv97rJZgd5MrhrLQ7ZLI9+at9KprMi1RW1Pqo2266CW0qt3tQUiDOcuKknHkhDNhBGX38Es3JGLtXGgVHWwAO44tMO21t7n5Fn46aAJsBX3TpWaxreHdDeE+wy6FFNQnBvLZ58UeaCVhcu+cCnoBxw8ih3C33AntKlvc7DGT5JD+V2vQMR27T4uIhsR6gwAOrAlrtz0MkbFjS5vau2E0Yubh9BWwActwIGpRvJ08RBXVGpqF8PodTzacaycNSk9wEsyb39nAsEUv/nH7bMg+9MJIDX3A9ZpcLzdIZ+2SL5L/P/IPY2Q//yeMQJ6eCPrtA8C/qWt9bTm9+EPTPyLZSbu2bsIkyycQ2c0AH5gVkUJKyBkbJ2V6BPPFoj99GrmYdaB+4ovVqqAhFW5Mh
X-Microsoft-Antispam-PRVS: <BN3PR03MB225853C595108992B1FE04E79DD90@BN3PR03MB2258.namprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231442)(944501410)(4982022)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN3PR03MB2258;BCL:0;PCL:0;RULEID:;SRVR:BN3PR03MB2258;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2258;4:hwosUo0bJ1BZMVFAaMb6nIO59NTVuMaZXghr5JX2H8vOCLaPa/YG0GhBh5KmOPQcNOCBov72bnEwXFL9a3tP6MGTRQGPfCOAWGGZJO02myCPKmLmi7IEKWdHj23mNH8eAwiTNs9/Gl0l/YmZMSfvUJyvXUvd9axnryN8rtyHU9yrMEwuacp/Z8IbRvUScjJqtoFR5H7i9mNaQ9oAjW3Ul5s7cWYBGiGMMJjqCZemBR1LZPNOBknSPFh8EBhlN/3JdpSA5SDn/gOuH+NNNxhKUA==
X-Forefront-PRVS: 08626BE3A5
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjAzTUIyMjU4OzIzOm84b25qZWFGaElOTkpQNW94TzJxNC9lU0tJ?=
 =?utf-8?B?d2dWTHlSb1phZ0k2bnFRSVJjdDRLenJFdXBCNVNncUFLMEk1bTJEVXk3RDZX?=
 =?utf-8?B?UDREYTUxV1gyc0NLbVMvdFpUaHRYUWFTSlc1L0Zud2VNblRqVlY0dzA3YjQy?=
 =?utf-8?B?dEpieUJOWEZ4ZTVQUWVydVdYYWtnbms1YnV4MGhxbE8yZEZlK1FlRzd2bERm?=
 =?utf-8?B?ck5xUFNITnF3S0NWYVZ4RFJNdmMxN3dzbEliUDVBOFZlV2RLSWZydzJ6WEpF?=
 =?utf-8?B?aC9ROEJXM0c0ZisxTFc5b1VmaS9xcHhlUWRCdnk4Vk9HVjlMTjJjZ1cvVWQw?=
 =?utf-8?B?aG13dmtnbnpJenVGRGdBMXhobi9LalhwbVN2Mk12U1JUcml5Sk9ZLzY2SEVL?=
 =?utf-8?B?ZTQwdGtrbGp5N3RIUGh3SzgrRzlsaVVEREIvNTdwWmNrekJNZ1R6ZlpnL2po?=
 =?utf-8?B?aXpRT2g4ZldwNWtPS25NQlFhSjhEeVFWbFFEZnh5SWMyeDlFTXV6L3A1d01Y?=
 =?utf-8?B?RWpZT0poT25MWlpXQzdOZFZMcnZXQyt1TzFtN1J0SGlSMkRhZ1luM2ZPYllC?=
 =?utf-8?B?TkxSUTlDaFJNK1RqWkJvRDN5azVpTHlTckllenVRZ2hZTllxaFBXQnhkOWZw?=
 =?utf-8?B?cGtsZzZtalVrM1JXTCs0VXp5dDNJMFVXN2d0Vi9KS05xU2xQbFBDaWlCeXFE?=
 =?utf-8?B?OSs2d01YK2Y3RTA5OXRqTkFSYmtZT05mWTNvOEhGUEtsZ3M2c091N2dMdTNM?=
 =?utf-8?B?endqa01lRzV1Q29NTE8rNlV1WE83U0htYUhSYnFIeFQ1UGxxQnp1NmdFWTdG?=
 =?utf-8?B?ZjlESGJZK2JwQlZSSk5RVVRqbmhxNTBQTkdlbTRtZXlLbk5aK1N6ZG5zMHdt?=
 =?utf-8?B?S1cyRzBWTmErSWRMaFpFNS9kWms2WUMzUmhobGlvMGVVdGtCVmovRmhPWlZu?=
 =?utf-8?B?ajVOOTlCQzhqeCtEeHM1TWZLWnc0c0doOG11NjNHS1hRUFNlSmtzMkNNREJq?=
 =?utf-8?B?ZndCbnVqenhEN0NPSGY5NUJWWXNhRnNkdk1tUEFCVDlNamFoVnl4dmpQRVNz?=
 =?utf-8?B?Q3Znb1FnRy9EWVViRnhrTVkwN0pLbXIrQkF4Vnd0LzluWVVRck80UndmcHdF?=
 =?utf-8?B?eE52QmVtT2NCQUh0T1EvRGw4M296cUw1QlhrcVI5WkVMZWRnbFM2eC9PaEdM?=
 =?utf-8?B?UmFIVTNWNWl3ZFIwQkRvd010UUlLK08wS0dCSFduTUhZaTRsdkhYT293S0s3?=
 =?utf-8?B?SVlTS0FtdE15SXFlOGFWaFlLY2NhOVJ0dEpUYTFPaUJlNThiT2xlUjNXVlVP?=
 =?utf-8?B?M2xFSTVXMXdBRHlVaExjbFAxNm0rVlFkK090K3ozTytxNTh5K0FrQTAvOWFn?=
 =?utf-8?B?S3AxYzdkSFQzZ053a2xhNnRMb1JSYmJMdmpCbWFGMVVnd2U4RURtYytZNVFi?=
 =?utf-8?B?OGNKd005TldKbnp1SktiZkpxck5PN0lPeFA1OFQ4ZldzZFIzM1pDZWs3VUp3?=
 =?utf-8?B?WlVkdz09?=
X-Microsoft-Antispam-Message-Info: yMr25Cea0+I719/6QptiaUHIAUk6LlpXPjXQMh3cIuFAPqAmYUV9v7J32ed9YsZ0WD8NjSZnooxc7Wlm23ZGFpxmPwBB4Q8AoENKy7VEk/L4a+3aGtgjiz0J/pLET+o/AK27opf/eITkX1FqPrE0ymhZA9c8NepElj0pAOfHlbxrU3vCXYxqgPHuC5iJiNF7nmvXhcXmtXtzz9uMdACTHr3BXB4tq3pXTqRzT5mFkcwNTid2KTefH6sv4MD8u/klhByGFupTnR3CCmqGBzEvxDN+5df3VJUFeGzd27f/nuJsDV9mgVJQu3BRBXqZhK88wc8si0M0NYw7a97lbK/qY/pm624+aKhSufsZdqdh+8I=
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2258;6:Jabiv8wepFoUW4Se5jlZmHbs25+DnAFSw/kzdvqxTrDcG2Cxj2RAm4CQvXXSFcyZJLcGfmLDuUTyiDLijuOCk2gjxAyLUw1iVGzwHzMs07ihHecBmfI8IUEyZ8qzyqlNMQkCppbRyx/kjbF5N4Qget0k/oi186vN3szrwHBCJamO/junAy1oPrjAIPZLoJHf/UgPOOYqTAQs7f0rkW6ABR+EuP+us2B2TSm76xy1Lmjf2iPb9Lei48W2Uw7KHjXwLFZ2ui4Jp5u8wD59vEA0JqxRkAnwgLCC0wQHIyE+tIHvN2PsC7X1rUoHJodq14OOAijrwUSMxrSzgeVZd7krD1ZCZhCAHv8J9btKo8FLycXZqtshDIRJGQ8b3QhnB5JOYRYvTUU/ieD7AScnzRMQx1Z1508l6SknubUweCM0ieTgHUcKJ7xUz9yiZQcHqsLO+Ng4BXECF32zS63FEbpMNg==;5:eVxxTbE8VT120HoKPsKZZfQ4LdTlWPfd83x7XB2rmNF7ymRqnOA/x3zYuhkcwqrSt/GsOI7lVsDQtYO79ZaK7UCuK277PJbGMoCZxR1cCz+71X0swH7D4mQMkq/MhDgl7693da7cHBqDZa6gXtrc8ITn/szl4YHqYBbc1+sWP8g=;7:D2Gzql7joXkLMUZOYtPgLAINZsHxM0zur4l8I++uB1jXgidOkzPvjaSeeywwiiGFnydR3y56gHkuXhWcBT4iOWwmUEnYovzPopYeo9bYBtoYUWiDL9VkTy62PtHZErRoLXgKx3DZneYLDorBvE2JKg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2018 15:44:49.5558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc543f4a-d4bd-4b52-2f83-08d64eff1b08
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for AD7606 Analog to Digital Converter.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- fixed indentation issues.
	- used gpios instead of gpio.
	- added vendor prefix for conversion-start-gpios, first-data-gpios,
	and range-gpios.

 .../devicetree/bindings/iio/adc/adi,ad7606.txt     | 54 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
new file mode 100644
index 0000000..02fae23
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
@@ -0,0 +1,54 @@
+Analog Devices AD7606 Simultaneous Sampling ADC
+
+Required properties for the AD7606:
+
+- compatible: Must be one of
+	* "adi,ad7605-4"
+	* "adi,ad7606-8"
+	* "adi,ad7606-6"
+	* "adi,ad7606-4"
+- reg: SPI chip select number for the device
+- spi-max-frequency: Max SPI frequency to use
+	see: Documentation/devicetree/bindings/spi/spi-bus.txt
+- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
+- avcc-supply: phandle to the Avcc power supply
+- interrupts: IRQ line for the ADC
+	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+- adi,conversion-start-gpios: must be the device tree identifier of the CONVST pin.
+		  This logic input is used to initiate conversions on the analog
+		  input channels.
+
+Optional properties:
+
+- reset-gpios: must be the device tree identifier of the RESET pin. If specified,
+	       it will be asserted during driver probe.
+- standby-gpios: must be the device tree identifier of the STBY pin. This pin is used
+		to place the AD7606 into one of two power-down modes, Standby mode or
+		Shutdown mode.
+- adi,first-data-gpios: must be the device tree identifier of the FRSTDATA pin.
+		    The FRSTDATA output indicates when the first channel, V1, is
+		    being read back on either the parallel, byte or serial interface.
+- adi,range-gpios: must be the device tree identifier of the RANGE pin. The polarity on
+	      this pin determines the input range of the analog input channels. If
+	      this pin is tied to a logic high, the analog input range is ±10V for
+	      all channels. If this pin is tied to a logic low, the analog input range
+	      is ±5V for all channels.
+
+Example:
+
+	adc@0 {
+		compatible = "adi,ad7606-8";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		spi-cpol;
+
+		avcc-supply = <&adc_vref>;
+
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-parent = <&gpio>;
+
+		adi,conversion-start-gpios = <&gpio 17 0>;
+		reset-gpios = <&gpio 27 0>;
+		adi,first-data-gpios = <&gpio 22 0>;
+		standby-gpios = <&gpio 24 0>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 843545d..6d63db4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7606.c
+F:	Documentation/devicetree/bindings/iio/adc/ad7606.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4

