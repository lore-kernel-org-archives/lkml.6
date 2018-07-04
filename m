Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B18C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C2820840
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="FSVmBcXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C2820840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeGDOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:38:06 -0400
Received: from mail-by2nam03on0089.outbound.protection.outlook.com ([104.47.42.89]:23392
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752598AbeGDOiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx/W1JoeHnm6ygBbrivCk/yPu1vqkimesmScIYe+jH0=;
 b=FSVmBcXOx8859W4xuCq54EEuhvzCIqwQgP/L1faBYdyYiE1T8xtoiFvpKN8ZRkMF0FLuWhJyld0d2h9/NZA9H3G9jaZDJQyxCrYGnDNpLoh4OxGmM0Au8v2IOYnYi3fqN+RMpQGkir2i3J3RMwUcgB0iFXwBMwIQOMwGd0wuSWA=
Received: from BLUPR0301CA0004.namprd03.prod.outlook.com
 (2a01:111:e400:5259::14) by BN6PR03MB3121.namprd03.prod.outlook.com
 (2603:10b6:405:3c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.18; Wed, 4 Jul
 2018 14:37:53 +0000
Received: from BN1AFFO11FD009.protection.gbl (2a01:111:f400:7c10::135) by
 BLUPR0301CA0004.outlook.office365.com (2a01:111:e400:5259::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.906.24 via Frontend Transport; Wed, 4 Jul 2018 14:37:53 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD009.mail.protection.outlook.com (10.58.52.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.820.5
 via Frontend Transport; Wed, 4 Jul 2018 14:37:52 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w64Ebpi7000717
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Wed, 4 Jul 2018 07:37:51 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Wed, 4 Jul 2018
 10:37:49 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
CC:     <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <lukas@wunner.de>,
        <Ismail.Kose@maximintegrated.com>, <vilhelm.gray@gmail.com>,
        <sean.nyekjaer@prevas.dk>, <pombredanne@nexb.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v5 1/2] iio: dac: Add AD5758 support
Date:   Wed, 4 Jul 2018 17:32:03 +0300
Message-ID: <1530714723-18835-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(438002)(199004)(189003)(36756003)(6666003)(5660300001)(356003)(305945005)(7636002)(246002)(8676002)(54906003)(107886003)(110136005)(316002)(106002)(50466002)(2616005)(426003)(476003)(336012)(2201001)(23676004)(186003)(126002)(8936002)(77096007)(26005)(575784001)(44832011)(486006)(7696005)(50226002)(2906002)(478600001)(2870700001)(72206003)(106466001)(6306002)(966005)(39060400002)(7416002)(1720100001)(4326008)(5820100001)(53416004)(14444005)(47776003)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3121;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD009;1:Ji8bn612YIW7PgZkqucpy6XbeEB2R7v98SGrUzzSGMhiJOQFllRW7hk4qgiJrGsKMCbCgzxcPtkqJ9KOcCCJ2XF4DA01R8+SqhOBMxKc9CUdqDt8dDFSqET9E46chkN5
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a16b97ca-79c3-41c2-68bb-08d5e1bbb987
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN6PR03MB3121;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;3:3fg4GaVm/grycsUpCzWBYuAx1sbYAfm+uzdTXmnYEP7IsU8d1dIeW6kpT+ZRkVm0gxhoKKyC8ZV4GN5JATCzIO7mEceqNUTvwwiofNWa1bTF8vGH3nq4d+EtoFvNjS1lwvplogFr1qWR0JEJutce7tBy0LCTlroqLK8qZAWHqE3uMNiuw9qJRMYPg9Z12fdwsDs7gtVMyVhVMGgn59jQEv0HCPXb3g3h09lDxUAxQLfV3vtGVNzc1GEqhsNOgJx9tepZxKXKYRcO4mUaQuejSzlzREUMaqT2vlfTT5eBsdGaAd/cxNEmGf7+YmQTRxU33u1fB469/rXlr7K9LwGMV2jzJV4iYs+HIFbar91QSbw=;25:gOm5Xi5LgwvPj4GtgYWkgjz7jwecBGi46yGCkVv0Qj2f7wjoVOVfzTKpdYpoN+RFV9LAMCBvRT9ZeMOBlUMvC4cZgv3jPzZPx5PMx0eD2lXcfHhiBOKhGEzGuD8vTuhwHRp70mFP7bK/kw3ZWQNJOvzD97S7BdMCMBuRvsRvob5+V/Y3v909B9A78VWZS7b1rwW+7SUw7ApB2MCjvCXNsAcXrl1STv9j2wDeapeHU7SQ2clhVZ47PoWN6LZ9H8H8oHf3yweS8CRzTVqMiqm29etv0OaFim2TL64oMDpbpUjfOTP2OvA3zhCnXNotam2SzGNbYalft5oBhLZ+KwBldg==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3121:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;31:iqzvs2nGyq4+YwfiM5b27g2CnCV22vj++SQ8vKNu4g6JyH+K4EtK5XghxdXNMgVYCpzeEWATS4dXovBXZeO4W40OxzvielXOfpYKBe7jslCkUw4JEKfg6f3o6aS27NoGXJpjSQ3d1/B45y+fCrT0SIsOvjSYFWvd3N5MLg/bJQOWc6BeCVzAWc/BLiOzoCHG6WfG/XirAqAKN9BIFGmFyqi0FklQE4fT/BHQRJRoK/c=;20:ZaWu2djWo/blIAKLTlFVT87Fs9r1P5tckahyraYF+oiLWVaPiLtXFMxdQ9wA6ROCYuS1exEnSX4MIE+9iWBj0bH83/ydRxRHJGnyFK2W1SRkuAdZj3ii4LF2tKl/dmUK/d8ONWwABaBW+v5+r4AWJZ4xS5gjzYHo1GRU6s7HeizawUHR0BrS88qBIS8jq7RBEIhcvoZqNsdBSEEdq/oSlGKD0YRAYFRF0SJzPOarkRoYBqa/uxKJBSI0xnVEqR+cyefdwFEr38WY1d8XebxXFlR+EK5c/tVgQfp+soYhHhHdHqDsL4wJNwwEC37olfxliw2rdUKLKf6UP9e/2y56/Wes1klg0zCd1rIAiegP2pgTGeIH/CF07JtArGHmV3ahVEifX4k78zCDFtOZAP3KhgKYLcoboSPaIyALOU/L8OtjFNsokwlS6xscdB1/BqgxT0xd+KW26Ma43FsIYEixTjbl361LTDs4AOjEkUI60KMKqXticDX5rL+ZisjmZmOK
X-Microsoft-Antispam-PRVS: <BN6PR03MB31215C56FE153D741B73E6D99D410@BN6PR03MB3121.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB3121;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB3121;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;4:3cFfwTmUgHlN3eFMrBAxoV59NRkWsuFAUAsJlzEssgWuZWScnMqf78/wzjND7da0LyvsDTlEjzsznkjkC9fONLG89uND8nPInkd6d7E67Q13bGG0G6hAUXxsQ40aAhV7w003fVUvkZYBFDst1o35qlnM6rLGDpcrYcQ7anqAUiaxxQGriE/Kh1tEVDmSK4/eJHq4y6civzoasi0xB0A9my8VWCfnf40B2xMmWl44IJGH67xkiwBF4IvLuY3jsojkxznrQ6TTDub7+eSHtyWN6LlNVQDvY+GWdTgrMUMp2eMgZkrJbxKn2avcr6pWrCG3LzmN0lXn+AriPM5QBDtLChaWOPnXWQfdd+fhGIj+hlA3UFzDnn9VfKowHEu2R4huXF64xXq1p5cpJpxlO4zLc/pqonLeGInN9Qub+6OEgGY=
X-Forefront-PRVS: 0723A02764
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIzMTIxOzIzOmdoRnBoTUhvL1hXdm15VFQxOUl6Yk1ZTHVW?=
 =?utf-8?B?V0xWd2ZNVmY4OHlhbFVEN0czNm9Ba1dYbDRlVzB5a29oSC9QNTFmRzYwVjBK?=
 =?utf-8?B?T0xpQ1Frd3ZyR3RFTitjTkRTa1FOajg1N2ZJMTZvUDBtSEY4YzVsbUdCZzdl?=
 =?utf-8?B?SzhsY2MwTytrcm01YlpIUng1NmczcGZzZCtzdG8xOGdHQXZDRDFVM3pmQ3Vl?=
 =?utf-8?B?Wk1wVnRnV202QytGNGd0ZlAyMTBaZFc0WENmN1RVckJBbFRRSjFtWElKN0FU?=
 =?utf-8?B?VDRway9kNENKNUZENG1TR1VISXdvenh6S0xwMTFQcjZPVnBjM0FVbWQxNlA5?=
 =?utf-8?B?QkgxdXpZV2pWSUVOaS9vZ2U1bDc5cUVMaCszbHVZOFE2MlZKTUFqM28rZDJ2?=
 =?utf-8?B?K1BDRjNuV21jM0dwMXRwNTlQYzlYcWpuV3NpVW9oQVRYK1l4SmdlcXJMZ0sy?=
 =?utf-8?B?d3ZPQ1E4UmdmTUo5VzQ0TWNKZnh6cnNwK2p1SStFNTkvL0NNRkpzRC9KbUlt?=
 =?utf-8?B?UUd0UUs2V3d1WlI1Vy96bmZVWWU0ZVBySklxNlZwZTBHbnVzdmJXWnMxZzlM?=
 =?utf-8?B?TU1aN1ZRNmF6WW1SeEM4YzBoNmIrM2tWdUNyZS9ZYXZMdFduR0draEgrY0da?=
 =?utf-8?B?bHBtVHM1ckZ1TzRSRmE2T2FXSldkK0locGNiTFpTcmpnT1o3azJiaDhKMnBQ?=
 =?utf-8?B?UU1VeFZzaUI3U1VGOW90Q0tsa3lmb01vcUNaeVF5THdVaWZzVXNZVVM0dFJq?=
 =?utf-8?B?S0Z0dElRbWJQSEdVekUwVUJoZVlrRUtmSDVQcDE1NVVHRkJFVUhKelIxQW4z?=
 =?utf-8?B?QXBxUCtNeTVrc09qelZ6bGhlZm82ZUhlM1hRTmIxRTRzZmFKL010UGN6TGtF?=
 =?utf-8?B?Uk1LVzk2aTBLUVdTdEFIZHRBeEtxc0dVd0FXcko1VEFIZUd4UmZrNllJNThW?=
 =?utf-8?B?YTN4a2F4MXBIMlFRQTg5dm9hK0pERy9oSWVGdGRFUEp2Vk9oYkcwVkxXZHYv?=
 =?utf-8?B?R0dQczF5SlpOc3hwblg3V2NhMDBRM0hvTUorVUlDK3c5SDE1UnNGKzdhckkx?=
 =?utf-8?B?aXl6emRQSSswV0NLQzE5RXFsNXQ0cE9lRm03WnZtM0RZSWcvRWlOVTNGaTBW?=
 =?utf-8?B?VWkrU1BpVFlvOGlVVXhKMjVoYThpQTF3VWRiUFJtcFhPQnoxR3p3V09UcjEv?=
 =?utf-8?B?bTY0TngwT3BRenVCZlNUU0VPT3FsdEJYNU5yNVRiVjNyUzlJK1JMRlVYeFpo?=
 =?utf-8?B?enVCWmFxdFNvQll5ZGZMdEttdkdGNFJCZmpIY1pGZzhoZklubnU0RkhHQ0U4?=
 =?utf-8?B?bkU2UmRPdG81NXY0T1ZVMFdIYTkvaFRxdkxCYzExbzNsMm5qUE9QcVQ3Qzlq?=
 =?utf-8?B?NGFSd3FhSUZCNGRLdmZhMXRDWCtmWWZqbUlabVpDUndobldYck9xQU9vV09i?=
 =?utf-8?B?RmhMUmY3WTNOV25jUXpjeHNMNTR3ZzNZT3BFL21iMWdTTVcxckFodUsyb3JV?=
 =?utf-8?B?Y2Nub3Y3bXovejdVZXU0NHY5RSt2TjJsZWgySTFSclA4Z1B4Q2dyRmRtRE10?=
 =?utf-8?B?RWl6bWJQaE9sZ2hhd21EVDBkeStUb0s0RHhkWmNGMXlZV0c0SUl3eDVvbEEy?=
 =?utf-8?B?ckN5cVNOY014RjlxOXJqZDRYSnJRWk15ckEyM1ZTQ3ZFM0Rlb0NZeHp3PT0=?=
X-Microsoft-Antispam-Message-Info: AAMesJGo/QfKb5OB/l6A16NbtOfxkz/bUqkejOKPLDCAuLRbyWYNzrrf5K6sjlbbA2zyi8JPZ58zxz246z4WV1jFIpSG7rzO8zPyy6NqetjoAc+pII7HcV+bNRorlZML0vEGYJviZ212ryuNmmchJ/aphp+arMufS0MQDblOQrVvjsDFmzlEjAvr2jGI0HXhP9XPHdnU4LOlG8/0o/1RT7p9YWZH69JoNe0W5DJnlSaKZ87gg26ikOhfDot4c0P8skMFYxnmjwPcR9JKAiA+CpdVDKVB6WJ+UT4Gee5pKAeTZf4tZ/tdKeNxG1TAfzr7QV98QJUqwnKo+rtpEO/lrGIN2n5EqTmnm83DFZjR8jA=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;6:q4lYLPiatshBuRenftSiw9+H2W/2hrbgzoDbEDSc/+KZvI47znJNpaute8w/GJxrCYdsQ2VGOxd9ZM+h4ZGGN5NszzBtZDDqPuPPH7ldnCWEihsqGScHAcUbIvvBKVbUdz1mdeA4Tcaxv9mbj+f7hPM76XJZ2+OyJoCpoiTUwRJSjcPC5ojPeuWsFtR3z02IJHkVGkGenwYFJfkkXlYyfZyVvoNHpqjgCfbJvCUiD2Q6l5V94UquKwRVIx6iRT+Z1cwyc2G08x0UjNe9w4rhDtyZlvN41qAiW4Tu0FPD/ey/s6/9KvAGssz0km1iZ7tAAIG0WYeDKcE2DxPUM374bKeCoLrhK0U1l90R6ltUIML5s1FBYZ93K/TIX+B+oemLV5xiOPIgt0jm7gSYI2U+uDJfUstAM7kmTiysu9Qr8fSlnKv0C2AuI+NEwJfVZl0BFQmuHGUBlqyp7oBopBqLbw==;5:I6yl92aFv8V0yAyBFxI+TuEBDe03JihOa52PGJX+i136bW9of48C+7jMTfMcrlq9Oh2x9r1zLBITT885CrTiqdtI5gLcIenED6ic0SW/ieOdnKgKwMS+pRQ0OOvfkbBjbmtMOnKVsGgNrA6UQgyiJqprT4QjOkVUI4iHjyjHquE=;24:5XErgCId/NzUmarRMZ/7NnDzhssHbirb1N7ytqeuFMn0QgdWcRpFXlOopsyJY2aluBgmxkG0AhKD4ZdpNPipNuPNM7OvNW3J832jS5503uo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3121;7:BdMKoUppohmSQ7V9dTNqPOiRab/XzFrQlz7undcJYQCSfZ+KgD7/f2ovVqa3/UjJhEhoO2J1pG0XuqRCeASMyU4ubcc4llJdXOifWQv47Zs913RbveWWcYR3TJcXew7plKUJl9T+I10ETQe7TMR/IIapIOUktoS5C5cFqy665b+rEeebkpbsX2MZ/HWranXtLzoh7vMc4FeighgpC6nNtuIUzraVQCSjz6Krz9U0J4c2EVfKevvXrLhzHByb8MOi
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 14:37:52.9026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a16b97ca-79c3-41c2-68bb-08d5e1bbb987
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD5758 is a single channel DAC with 16-bit precision which uses the
SPI interface that operates at clock rates up to 50MHz.

The output can be configured as voltage or current and is available on a
single terminal.

Datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v5:
	- changed the handling choice of voltage vs current by picking
	  between two constant structs.
	- returned ad5758_wait_for_task_complete() directly where possible.
	- fixed double spaces and removed unnecessary parentheses.
	- kept the includes in alphabetical order and removed asm/div64.h.
	- used usleep_range() instead of udelay().
	- removed unnecessary casting when calling bsearch().
Changes in v4:
	- fixed kbuild test robot warnings.
Changes in v3:
	- AD5758 can be both a current and voltage output DAC. The
	  decision is made based on the DT and the channel type is set
	  during probe.
	- dc-dc-mode, range-microvolt and range-microamp are required
	  properties.
	- Introduced a slew-time-us property from which slew rate clock
	  and slew rate step are calculated using a best match algorithm.
	- Dropped the union from ad5758_state struct.
	- Introduced a IIO_CHAN_INFO_OFFSET case part of ad5758_read_raw().
	- Added a TODO comment which specifies that CRC is not supported.
	- Kept the includes in order and removed the unused ones.
	- Removed unused macros and shortened the lengthy ones.
	- Renamed AD5758_REG_WRITE to AD5758_WR_FLAG_MSK.
	- Added an explanation for enum ad5758_output_range.
	- Used bsearch() instead of ad5758_get_array_index().
	- Reduced the delays.
	- strtobool() -> kstrtobool().

Changes in v2:
	- removed unnecessary parenthesis in AD5758_REG_WRITE macro.
	- added missing documentation fields of ad5758_state struct.
	- changed the type of pwr_down attribute to bool.
	- changed ad5758_dc_dc_ilimt[] to ad5758_dc_dc_ilim[].
	- ad5758_spi_reg_write() now returns spi_write(st->spi,
	  &st->data[0].d32, sizeof(st->data[0].d32));
	- removed unnecessary new line in ad5758_calib_mem_refresh().
	- changed the type of the mode parameter in
	  ad5758_set_dc_dc_conv_mode() from unsigned int to enum
	  ad5758_dc_dc_mode.
	- removed unnecessary parenthesis in ad5758_slew_rate_config().
	- changed the type of the enable parameter in
	  ad5758_fault_prot_switch_en() from unsigned char to bool.
	- the same as above, but for ad5758_internal_buffers_en().
	- added a missing mutex_unlock() in ad5758_reg_access().
	- moved the mutex_unlock() in ad5758_read_raw() and removed the
	  unreachable return.
	- returned directly where it was possible in ad5758_write_raw().
	- removed the channel, scan_type and scan_index fields.
	- in ad5758_parse_dt(), added missing "\n", and specified what the
	  default mode actually is.
	- returned directly at the end of ad5758_init().
	- in ad5758_probe() used device managed for registering the device
	  and returned directly without the error message.

 MAINTAINERS              |   7 +
 drivers/iio/dac/Kconfig  |  10 +
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/ad5758.c | 897 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 915 insertions(+)
 create mode 100644 drivers/iio/dac/ad5758.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 00e9670..12d102d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -796,6 +796,13 @@ M:	Michael Hanselmann <linux-kernel@hansmi.ch>
 S:	Supported
 F:	drivers/macintosh/ams/
 
+ANALOG DEVICES INC AD5758 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/dac/ad5758.c
+
 ANALOG DEVICES INC AD5686 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 06e90de..80beb64 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -167,6 +167,16 @@ config AD5755
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5755.
 
+config AD5758
+	tristate "Analog Devices AD5758 DAC driver"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for Analog Devices AD5758 single channel
+	  Digital to Analog Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5758.
+
 config AD5761
 	tristate "Analog Devices AD5761/61R/21/21R DAC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 57aa230..a1b37cf 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
 obj-$(CONFIG_AD5755) += ad5755.o
+obj-$(CONFIG_AD5755) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
new file mode 100644
index 0000000..bd36333
--- /dev/null
+++ b/drivers/iio/dac/ad5758.c
@@ -0,0 +1,897 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD5758 Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ *
+ * TODO: Currently CRC is not supported in this driver
+ */
+#include <linux/bsearch.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* AD5758 registers definition */
+#define AD5758_NOP				0x00
+#define AD5758_DAC_INPUT			0x01
+#define AD5758_DAC_OUTPUT			0x02
+#define AD5758_CLEAR_CODE			0x03
+#define AD5758_USER_GAIN			0x04
+#define AD5758_USER_OFFSET			0x05
+#define AD5758_DAC_CONFIG			0x06
+#define AD5758_SW_LDAC				0x07
+#define AD5758_KEY				0x08
+#define AD5758_GP_CONFIG1			0x09
+#define AD5758_GP_CONFIG2			0x0A
+#define AD5758_DCDC_CONFIG1			0x0B
+#define AD5758_DCDC_CONFIG2			0x0C
+#define AD5758_WDT_CONFIG			0x0F
+#define AD5758_DIGITAL_DIAG_CONFIG		0x10
+#define AD5758_ADC_CONFIG			0x11
+#define AD5758_FAULT_PIN_CONFIG			0x12
+#define AD5758_TWO_STAGE_READBACK_SELECT	0x13
+#define AD5758_DIGITAL_DIAG_RESULTS		0x14
+#define AD5758_ANALOG_DIAG_RESULTS		0x15
+#define AD5758_STATUS				0x16
+#define AD5758_CHIP_ID				0x17
+#define AD5758_FREQ_MONITOR			0x18
+#define AD5758_DEVICE_ID_0			0x19
+#define AD5758_DEVICE_ID_1			0x1A
+#define AD5758_DEVICE_ID_2			0x1B
+#define AD5758_DEVICE_ID_3			0x1C
+
+/* AD5758_DAC_CONFIG */
+#define AD5758_DAC_CONFIG_RANGE_MSK		GENMASK(3, 0)
+#define AD5758_DAC_CONFIG_RANGE_MODE(x)		(((x) & 0xF) << 0)
+#define AD5758_DAC_CONFIG_INT_EN_MSK		BIT(5)
+#define AD5758_DAC_CONFIG_INT_EN_MODE(x)	(((x) & 0x1) << 5)
+#define AD5758_DAC_CONFIG_OUT_EN_MSK		BIT(6)
+#define AD5758_DAC_CONFIG_OUT_EN_MODE(x)	(((x) & 0x1) << 6)
+#define AD5758_DAC_CONFIG_SR_EN_MSK		BIT(8)
+#define AD5758_DAC_CONFIG_SR_EN_MODE(x)		(((x) & 0x1) << 8)
+#define AD5758_DAC_CONFIG_SR_CLOCK_MSK		GENMASK(12, 9)
+#define AD5758_DAC_CONFIG_SR_CLOCK_MODE(x)	(((x) & 0xF) << 9)
+#define AD5758_DAC_CONFIG_SR_STEP_MSK		GENMASK(15, 13)
+#define AD5758_DAC_CONFIG_SR_STEP_MODE(x)	(((x) & 0x7) << 13)
+
+/* AD5758_KEY */
+#define AD5758_KEY_CODE_RESET_1			0x15FA
+#define AD5758_KEY_CODE_RESET_2			0xAF51
+#define AD5758_KEY_CODE_SINGLE_ADC_CONV		0x1ADC
+#define AD5758_KEY_CODE_RESET_WDT		0x0D06
+#define AD5758_KEY_CODE_CALIB_MEM_REFRESH	0xFCBA
+
+/* AD5758_DCDC_CONFIG1 */
+#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MSK	GENMASK(4, 0)
+#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MODE(x)	(((x) & 0x1F) << 0)
+#define AD5758_DCDC_CONFIG1_DCDC_MODE_MSK	GENMASK(6, 5)
+#define AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(x)	(((x) & 0x3) << 5)
+#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK	BIT(7)
+#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(x)	(((x) & 0x1) << 7)
+
+/* AD5758_DCDC_CONFIG2 */
+#define AD5758_DCDC_CONFIG2_ILIMIT_MSK		GENMASK(3, 1)
+#define AD5758_DCDC_CONFIG2_ILIMIT_MODE(x)	(((x) & 0x7) << 1)
+#define AD5758_DCDC_CONFIG2_INTR_SAT_3WI_MSK	BIT(11)
+#define AD5758_DCDC_CONFIG2_BUSY_3WI_MSK	BIT(12)
+
+/* AD5758_DIGITAL_DIAG_RESULTS */
+#define AD5758_CAL_MEM_UNREFRESHED_MSK		BIT(15)
+
+#define AD5758_WR_FLAG_MSK(x)		(0x80 | ((x) & 0x1F))
+
+#define AD5758_FULL_SCALE_MICRO	65535000000ULL
+
+/**
+ * struct ad5758_state - driver instance specific data
+ * @spi:	spi_device
+ * @lock:	mutex lock
+ * @out_range:	struct which stores the output range
+ * @dc_dc_mode:	variable which stores the mode of operation
+ * @dc_dc_ilim:	variable which stores the dc-to-dc converter current limit
+ * @slew_time:	variable which stores the target slew time
+ * @pwr_down:	variable which contains whether a channel is powered down or not
+ * @data:	spi transfer buffers
+ */
+
+struct ad5758_range {
+	int reg;
+	int min;
+	int max;
+};
+
+struct ad5758_state {
+	struct spi_device *spi;
+	struct mutex lock;
+	struct ad5758_range out_range;
+	unsigned int dc_dc_mode;
+	unsigned int dc_dc_ilim;
+	unsigned int slew_time;
+	bool pwr_down;
+	__be32 d32[3];
+};
+
+/**
+ * Output ranges corresponding to bits [3:0] from DAC_CONFIG register
+ * 0000: 0 V to 5 V voltage range
+ * 0001: 0 V to 10 V voltage range
+ * 0010: ±5 V voltage range
+ * 0011: ±10 V voltage range
+ * 1000: 0 mA to 20 mA current range
+ * 1001: 0 mA to 24 mA current range
+ * 1010: 4 mA to 20 mA current range
+ * 1011: ±20 mA current range
+ * 1100: ±24 mA current range
+ * 1101: -1 mA to +22 mA current range
+ */
+enum ad5758_output_range {
+	AD5758_RANGE_0V_5V,
+	AD5758_RANGE_0V_10V,
+	AD5758_RANGE_PLUSMINUS_5V,
+	AD5758_RANGE_PLUSMINUS_10V,
+	AD5758_RANGE_0mA_20mA = 8,
+	AD5758_RANGE_0mA_24mA,
+	AD5758_RANGE_4mA_24mA,
+	AD5758_RANGE_PLUSMINUS_20mA,
+	AD5758_RANGE_PLUSMINUS_24mA,
+	AD5758_RANGE_MINUS_1mA_PLUS_22mA,
+};
+
+enum ad5758_dc_dc_mode {
+	AD5758_DCDC_MODE_POWER_OFF,
+	AD5758_DCDC_MODE_DPC_CURRENT,
+	AD5758_DCDC_MODE_DPC_VOLTAGE,
+	AD5758_DCDC_MODE_PPC_CURRENT,
+};
+
+static const struct ad5758_range ad5758_voltage_range[] = {
+	{ AD5758_RANGE_0V_5V, 0, 5000000 },
+	{ AD5758_RANGE_0V_10V, 0, 10000000 },
+	{ AD5758_RANGE_PLUSMINUS_5V, -5000000, 5000000 },
+	{ AD5758_RANGE_PLUSMINUS_10V, -10000000, 10000000 }
+};
+
+static const struct ad5758_range ad5758_current_range[] = {
+	{ AD5758_RANGE_0mA_20mA, 0, 20000},
+	{ AD5758_RANGE_0mA_24mA, 0, 24000 },
+	{ AD5758_RANGE_4mA_24mA, 4, 24000 },
+	{ AD5758_RANGE_PLUSMINUS_20mA, -20000, 20000 },
+	{ AD5758_RANGE_PLUSMINUS_24mA, -24000, 24000 },
+	{ AD5758_RANGE_MINUS_1mA_PLUS_22mA, -1000, 22000 },
+};
+
+static const int ad5758_sr_clk[16] = {
+	240000, 200000, 150000, 128000, 64000, 32000, 16000, 8000, 4000, 2000,
+	1000, 512, 256, 128, 64, 16
+};
+
+static const int ad5758_sr_step[8] = {
+	4, 12, 64, 120, 256, 500, 1820, 2048
+};
+
+static const int ad5758_dc_dc_ilim[6] = {
+	150000, 200000, 250000, 300000, 350000, 400000
+};
+
+static int ad5758_spi_reg_read(struct ad5758_state *st, unsigned int addr)
+{
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->d32[0],
+			.len = 4,
+			.cs_change = 1,
+		}, {
+			.tx_buf = &st->d32[1],
+			.rx_buf = &st->d32[2],
+			.len = 4,
+		},
+	};
+	int ret;
+
+	st->d32[0] = cpu_to_be32(
+		(AD5758_WR_FLAG_MSK(AD5758_TWO_STAGE_READBACK_SELECT) << 24) |
+		(addr << 8));
+	st->d32[1] = cpu_to_be32(AD5758_WR_FLAG_MSK(AD5758_NOP) << 24);
+
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+	if (ret < 0)
+		return ret;
+
+	return (be32_to_cpu(st->d32[2]) >> 8) & 0xFFFF;
+}
+
+static int ad5758_spi_reg_write(struct ad5758_state *st,
+				unsigned int addr,
+				unsigned int val)
+{
+	st->d32[0] = cpu_to_be32((AD5758_WR_FLAG_MSK(addr) << 24) |
+				 ((val & 0xFFFF) << 8));
+
+	return spi_write(st->spi, &st->d32[0], sizeof(st->d32[0]));
+}
+
+static int ad5758_spi_write_mask(struct ad5758_state *st,
+				 unsigned int addr,
+				 unsigned long int mask,
+				 unsigned int val)
+{
+	int regval;
+
+	regval = ad5758_spi_reg_read(st, addr);
+	if (regval < 0)
+		return regval;
+
+	regval &= ~mask;
+	regval |= val;
+
+	return ad5758_spi_reg_write(st, addr, regval);
+}
+
+static int cmpfunc(const void *a, const void *b)
+{
+	return *(int *)a - *(int *)b;
+}
+
+static int ad5758_find_closest_match(const int *array,
+				     unsigned int size, int val)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (val <= array[i])
+			return i;
+	}
+
+	return size - 1;
+}
+
+static int ad5758_wait_for_task_complete(struct ad5758_state *st,
+					 unsigned int reg,
+					 unsigned int mask)
+{
+	unsigned int timeout;
+	int ret;
+
+	timeout = 10;
+	do {
+		ret = ad5758_spi_reg_read(st, reg);
+		if (ret < 0)
+			return ret;
+
+		if (!(ret & mask))
+			return 0;
+
+		usleep_range(100, 1000);
+	} while (--timeout);
+
+	dev_err(&st->spi->dev,
+		"Error reading bit 0x%x in 0x%x register\n", mask, reg);
+
+	return -EIO;
+}
+
+static int ad5758_calib_mem_refresh(struct ad5758_state *st)
+{
+	int ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY,
+				   AD5758_KEY_CODE_CALIB_MEM_REFRESH);
+	if (ret < 0) {
+		dev_err(&st->spi->dev,
+			"Failed to initiate a calibration memory refresh\n");
+		return ret;
+	}
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+					     AD5758_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_soft_reset(struct ad5758_state *st)
+{
+	int ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_1);
+	if (ret < 0)
+		return ret;
+
+	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_2);
+
+	/* Perform a software reset and wait at least 100us */
+	usleep_range(100, 1000);
+
+	return ret;
+}
+
+static int ad5758_set_dc_dc_conv_mode(struct ad5758_state *st,
+				      enum ad5758_dc_dc_mode mode)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+				    AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
+				    AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	ret = ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					    AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+	if (ret < 0)
+		return ret;
+
+	st->dc_dc_mode = mode;
+
+	return ret;
+}
+
+static int ad5758_set_dc_dc_ilim(struct ad5758_state *st, unsigned int ilim)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG2,
+				    AD5758_DCDC_CONFIG2_ILIMIT_MSK,
+				    AD5758_DCDC_CONFIG2_ILIMIT_MODE(ilim));
+	if (ret < 0)
+		return ret;
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+}
+
+static int ad5758_slew_rate_set(struct ad5758_state *st,
+				unsigned int sr_clk_idx,
+				unsigned int sr_step_idx)
+{
+	unsigned int mode;
+	unsigned long int mask;
+	int ret;
+
+	mask = AD5758_DAC_CONFIG_SR_EN_MSK |
+	       AD5758_DAC_CONFIG_SR_CLOCK_MSK |
+	       AD5758_DAC_CONFIG_SR_STEP_MSK;
+	mode = AD5758_DAC_CONFIG_SR_EN_MODE(1) |
+	       AD5758_DAC_CONFIG_SR_STEP_MODE(sr_step_idx) |
+	       AD5758_DAC_CONFIG_SR_CLOCK_MODE(sr_clk_idx);
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG, mask, mode);
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+					     AD5758_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_slew_rate_config(struct ad5758_state *st)
+{
+	unsigned int sr_clk_idx, sr_step_idx;
+	int i, res;
+	s64 diff_new, diff_old;
+	u64 sr_step, calc_slew_time;
+
+	sr_clk_idx = 0;
+	sr_step_idx = 0;
+	diff_old = S64_MAX;
+	/*
+	 * The slew time can be determined by using the formula:
+	 * Slew Time = (Full Scale Out / (Step Size x Update Clk Freq))
+	 * where Slew time is expressed in microseconds
+	 * Given the desired slew time, the following algorithm determines the
+	 * best match for the step size and the update clock frequency.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ad5758_sr_clk); i++) {
+		/*
+		 * Go through each valid update clock freq and determine a raw
+		 * value for the step size by using the formula:
+		 * Step Size = Full Scale Out / (Update Clk Freq * Slew Time)
+		 */
+		sr_step = AD5758_FULL_SCALE_MICRO;
+		do_div(sr_step, ad5758_sr_clk[i]);
+		do_div(sr_step, st->slew_time);
+		/*
+		 * After a raw value for step size was determined, find the
+		 * closest valid match
+		 */
+		res = ad5758_find_closest_match(ad5758_sr_step,
+						ARRAY_SIZE(ad5758_sr_step),
+						sr_step);
+		/* Calculate the slew time */
+		calc_slew_time = AD5758_FULL_SCALE_MICRO;
+		do_div(calc_slew_time, ad5758_sr_step[res]);
+		do_div(calc_slew_time, ad5758_sr_clk[i]);
+		/*
+		 * Determine with how many microseconds the calculated slew time
+		 * is different from the desired slew time and store the diff
+		 * for the next iteration
+		 */
+		diff_new = abs(st->slew_time - calc_slew_time);
+		if (diff_new < diff_old) {
+			diff_old = diff_new;
+			sr_clk_idx = i;
+			sr_step_idx = res;
+		}
+	}
+
+	return ad5758_slew_rate_set(st, sr_clk_idx, sr_step_idx);
+}
+
+static int ad5758_set_out_range(struct ad5758_state *st, int range)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    AD5758_DAC_CONFIG_RANGE_MSK,
+				    AD5758_DAC_CONFIG_RANGE_MODE(range));
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+					     AD5758_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_fault_prot_switch_en(struct ad5758_state *st, bool enable)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+			AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK,
+			AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(enable));
+	if (ret < 0)
+		return ret;
+	/*
+	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
+	 * This allows the 3-wire interface communication to complete.
+	 */
+	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
+					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
+}
+
+static int ad5758_internal_buffers_en(struct ad5758_state *st, bool enable)
+{
+	int ret;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    AD5758_DAC_CONFIG_INT_EN_MSK,
+				    AD5758_DAC_CONFIG_INT_EN_MODE(enable));
+	if (ret < 0)
+		return ret;
+
+	/* Wait to allow time for the internal calibrations to complete */
+	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+					     AD5758_CAL_MEM_UNREFRESHED_MSK);
+}
+
+static int ad5758_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	if (readval) {
+		ret = ad5758_spi_reg_read(st, reg);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+
+		*readval = ret;
+		ret = 0;
+	} else {
+		ret = ad5758_spi_reg_write(st, reg, writeval);
+	}
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad5758_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int max, min, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ad5758_spi_reg_read(st, AD5758_DAC_INPUT);
+		mutex_unlock(&st->lock);
+		if (ret < 0)
+			return ret;
+
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		min = st->out_range.min;
+		max = st->out_range.max;
+		*val = (max - min) / 1000;
+		*val2 = 16;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		min = st->out_range.min;
+		max = st->out_range.max;
+		*val = ((min * (1 << 16)) / (max - min)) / 1000;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5758_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ad5758_spi_reg_write(st, AD5758_DAC_INPUT, val);
+		mutex_unlock(&st->lock);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ad5758_read_powerdown(struct iio_dev *indio_dev,
+				     uintptr_t priv,
+				     const struct iio_chan_spec *chan,
+				     char *buf)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->pwr_down);
+}
+
+static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
+				      uintptr_t priv,
+				      struct iio_chan_spec const *chan,
+				      const char *buf, size_t len)
+{
+	struct ad5758_state *st = iio_priv(indio_dev);
+	bool pwr_down;
+	unsigned int dcdc_config1_mode, dc_dc_mode, dac_config_mode, val;
+	unsigned long int dcdc_config1_msk, dac_config_msk;
+	int ret;
+
+	ret = kstrtobool(buf, &pwr_down);
+	if (ret)
+		return ret;
+
+	mutex_lock(&st->lock);
+	if (pwr_down) {
+		dc_dc_mode = AD5758_DCDC_MODE_POWER_OFF;
+		val = 0;
+	} else {
+		dc_dc_mode = st->dc_dc_mode;
+		val = 1;
+	}
+
+	dcdc_config1_mode = AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode) |
+			    AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(val);
+	dcdc_config1_msk = AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
+			   AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+				    dcdc_config1_msk,
+				    dcdc_config1_mode);
+	if (ret < 0)
+		goto err_unlock;
+
+	dac_config_mode = AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
+			  AD5758_DAC_CONFIG_INT_EN_MODE(val);
+	dac_config_msk = AD5758_DAC_CONFIG_OUT_EN_MSK |
+			 AD5758_DAC_CONFIG_INT_EN_MSK;
+
+	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				    dac_config_msk,
+				    dac_config_mode);
+	if (ret < 0)
+		goto err_unlock;
+
+	st->pwr_down = pwr_down;
+
+err_unlock:
+	mutex_unlock(&st->lock);
+
+	return ret ? ret : len;
+}
+
+static const struct iio_info ad5758_info = {
+	.read_raw = ad5758_read_raw,
+	.write_raw = ad5758_write_raw,
+	.debugfs_reg_access = &ad5758_reg_access,
+};
+
+static const struct iio_chan_spec_ext_info ad5758_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = ad5758_read_powerdown,
+		.write = ad5758_write_powerdown,
+		.shared = IIO_SHARED_BY_TYPE,
+	},
+	{ }
+};
+
+#define AD5758_DAC_CHAN(_chan_type) {				\
+	.type = (_chan_type),					\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |	\
+		BIT(IIO_CHAN_INFO_SCALE) |			\
+		BIT(IIO_CHAN_INFO_OFFSET),			\
+	.indexed = 1,						\
+	.output = 1,						\
+	.ext_info = ad5758_ext_info,				\
+}
+
+static const struct iio_chan_spec ad5758_voltage_ch[] = {
+	AD5758_DAC_CHAN(IIO_VOLTAGE)
+};
+
+static const struct iio_chan_spec ad5758_current_ch[] = {
+	AD5758_DAC_CHAN(IIO_CURRENT)
+};
+
+static bool ad5758_is_valid_mode(enum ad5758_dc_dc_mode mode)
+{
+	switch (mode) {
+	case AD5758_DCDC_MODE_DPC_CURRENT:
+	case AD5758_DCDC_MODE_DPC_VOLTAGE:
+	case AD5758_DCDC_MODE_PPC_CURRENT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int ad5758_crc_disable(struct ad5758_state *st)
+{
+	unsigned int mask;
+
+	mask = (AD5758_WR_FLAG_MSK(AD5758_DIGITAL_DIAG_CONFIG) << 24) | 0x5C3A;
+	st->d32[0] = cpu_to_be32(mask);
+
+	return spi_write(st->spi, &st->d32[0], 4);
+}
+
+static int ad5758_find_out_range(struct ad5758_state *st,
+				 const struct ad5758_range *range,
+				 unsigned int size,
+				 int min, int max)
+{
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if ((min == range[i].min) && (max == range[i].max)) {
+			st->out_range.reg = range[i].reg;
+			st->out_range.min = range[i].min;
+			st->out_range.max = range[i].max;
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ad5758_parse_dt(struct ad5758_state *st)
+{
+	unsigned int tmp, tmparray[2], size;
+	const struct ad5758_range *range;
+	int *index, ret;
+
+	st->dc_dc_ilim = 0;
+	ret = device_property_read_u32(&st->spi->dev,
+				       "adi,dc-dc-ilim-microamp", &tmp);
+	if (ret) {
+		dev_dbg(&st->spi->dev,
+			"Missing \"dc-dc-ilim-microamp\" property\n");
+	} else {
+		index = bsearch(&tmp, ad5758_dc_dc_ilim,
+				ARRAY_SIZE(ad5758_dc_dc_ilim),
+				sizeof(int), cmpfunc);
+		if (!index)
+			dev_dbg(&st->spi->dev, "dc-dc-ilim out of range\n");
+		else
+			st->dc_dc_ilim = index - ad5758_dc_dc_ilim;
+	}
+
+	ret = device_property_read_u32(&st->spi->dev, "adi,dc-dc-mode",
+				       &st->dc_dc_mode);
+	if (ret) {
+		dev_err(&st->spi->dev, "Missing \"dc-dc-mode\" property\n");
+		return ret;
+	}
+
+	if (!ad5758_is_valid_mode(st->dc_dc_mode))
+		return -EINVAL;
+
+	if (st->dc_dc_mode == AD5758_DCDC_MODE_DPC_VOLTAGE) {
+		ret = device_property_read_u32_array(&st->spi->dev,
+						     "adi,range-microvolt",
+						     tmparray, 2);
+		if (ret) {
+			dev_err(&st->spi->dev,
+				"Missing \"range-microvolt\" property\n");
+			return ret;
+		}
+		range = ad5758_voltage_range;
+		size = ARRAY_SIZE(ad5758_voltage_range);
+	} else {
+		ret = device_property_read_u32_array(&st->spi->dev,
+						     "adi,range-microamp",
+						     tmparray, 2);
+		if (ret) {
+			dev_err(&st->spi->dev,
+				"Missing \"range-microamp\" property\n");
+			return ret;
+		}
+		range = ad5758_current_range;
+		size = ARRAY_SIZE(ad5758_current_range);
+	}
+
+	ret = ad5758_find_out_range(st, range, size, tmparray[0], tmparray[1]);
+	if (ret) {
+		dev_err(&st->spi->dev, "range invalid\n");
+		return ret;
+	}
+
+	ret = device_property_read_u32(&st->spi->dev, "adi,slew-time-us", &tmp);
+	if (ret) {
+		dev_dbg(&st->spi->dev, "Missing \"slew-time-us\" property\n");
+		st->slew_time = 0;
+	} else {
+		st->slew_time = tmp;
+	}
+
+	return 0;
+}
+
+static int ad5758_init(struct ad5758_state *st)
+{
+	int regval, ret;
+
+	/* Disable CRC checks */
+	ret = ad5758_crc_disable(st);
+	if (ret < 0)
+		return ret;
+
+	/* Perform a software reset */
+	ret = ad5758_soft_reset(st);
+	if (ret < 0)
+		return ret;
+
+	/* Disable CRC checks */
+	ret = ad5758_crc_disable(st);
+	if (ret < 0)
+		return ret;
+
+	/* Perform a calibration memory refresh */
+	ret = ad5758_calib_mem_refresh(st);
+	if (ret < 0)
+		return ret;
+
+	regval = ad5758_spi_reg_read(st, AD5758_DIGITAL_DIAG_RESULTS);
+	if (regval < 0)
+		return regval;
+
+	/* Clear all the error flags */
+	ret = ad5758_spi_reg_write(st, AD5758_DIGITAL_DIAG_RESULTS, regval);
+	if (ret < 0)
+		return ret;
+
+	/* Set the dc-to-dc current limit */
+	ret = ad5758_set_dc_dc_ilim(st, st->dc_dc_ilim);
+	if (ret < 0)
+		return ret;
+
+	/* Configure the dc-to-dc controller mode */
+	ret = ad5758_set_dc_dc_conv_mode(st, st->dc_dc_mode);
+	if (ret < 0)
+		return ret;
+
+	/* Configure the output range */
+	ret = ad5758_set_out_range(st, st->out_range.reg);
+	if (ret < 0)
+		return ret;
+
+	/* Enable Slew Rate Control, set the slew rate clock and step */
+	if (st->slew_time) {
+		ret = ad5758_slew_rate_config(st);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Enable the VIOUT fault protection switch (FPS is closed) */
+	ret = ad5758_fault_prot_switch_en(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Power up the DAC and internal (INT) amplifiers */
+	ret = ad5758_internal_buffers_en(st, 1);
+	if (ret < 0)
+		return ret;
+
+	/* Enable VIOUT */
+	return ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
+				     AD5758_DAC_CONFIG_OUT_EN_MSK,
+				     AD5758_DAC_CONFIG_OUT_EN_MODE(1));
+}
+
+static int ad5758_probe(struct spi_device *spi)
+{
+	struct ad5758_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	mutex_init(&st->lock);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad5758_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->num_channels = 1;
+
+	ret = ad5758_parse_dt(st);
+	if (ret < 0)
+		return ret;
+
+	if (st->dc_dc_mode == AD5758_DCDC_MODE_DPC_VOLTAGE)
+		indio_dev->channels = ad5758_voltage_ch;
+	else
+		indio_dev->channels = ad5758_current_ch;
+
+	ret = ad5758_init(st);
+	if (ret < 0) {
+		dev_err(&spi->dev, "AD5758 init failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&st->spi->dev, indio_dev);
+}
+
+static const struct spi_device_id ad5758_id[] = {
+	{ "ad5758", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad5758_id);
+
+static struct spi_driver ad5758_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = ad5758_probe,
+	.id_table = ad5758_id,
+};
+
+module_spi_driver(ad5758_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5758 DAC");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

