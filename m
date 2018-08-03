Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ED9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81902176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="hTH5CRWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81902176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeHCRFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:05:55 -0400
Received: from mail-by2nam03on0066.outbound.protection.outlook.com ([104.47.42.66]:63552
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732279AbeHCRFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uflBXHDjW46fe3twcMtjudbvBZhPkLh6gowCxlUwzQc=;
 b=hTH5CRWW4x6JGScW/+XNo4oIMN59CFuhUOkUj22t9xAwb/j/4WS57pVfDfbGJ4ULpfwxqK6L7hGbghLUii81qrdYQMKTHZIudCQ1Td36TA3Ddbc7JzkhAsF/YTxEOM8dSqAF5RlLEE3wi5eFNNclSP65/FNnScr5YwdzjGwbH98=
Received: from BYAPR07CA0055.namprd07.prod.outlook.com (2603:10b6:a03:60::32)
 by CY1PR0701MB1339.namprd07.prod.outlook.com (2a01:111:e400:4c1b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Fri, 3 Aug
 2018 15:09:07 +0000
Received: from DM3NAM05FT060.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by BYAPR07CA0055.outlook.office365.com
 (2603:10b6:a03:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Fri, 3 Aug 2018 15:09:06 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT060.mail.protection.outlook.com (10.152.98.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1038.3 via Frontend Transport; Fri, 3 Aug 2018 15:09:06 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w73F93aR004802
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 3 Aug 2018 08:09:04 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 3 Aug 2018 17:09:16 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 3 Aug 2018 17:09:16 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w73F92fC004555;
        Fri, 3 Aug 2018 16:09:02 +0100
Received: (from stelford@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w73F92Sj004465;
        Fri, 3 Aug 2018 16:09:02 +0100
From:   Scott Telford <stelford@cadence.com>
To:     <dkos@cadence.com>, <adouglas@cadence.com>, <kishon@ti.com>,
        <jbergsagel@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Scott Telford <stelford@cadence.com>
Subject: [PATCH v3 1/2] dt-bindings: phy: Document Cadence MHDP DisplayPort PHY bindings
Date:   Fri, 3 Aug 2018 16:08:30 +0100
Message-ID: <1533308911-17286-2-git-send-email-stelford@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1533308911-17286-1-git-send-email-stelford@cadence.com>
References: <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
 <1533308911-17286-1-git-send-email-stelford@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(189003)(199004)(36092001)(336012)(87636003)(2201001)(446003)(11346002)(478600001)(86362001)(4326008)(575784001)(186003)(26826003)(26005)(246002)(2906002)(8676002)(51416003)(50226002)(8936002)(305945005)(486006)(107886003)(476003)(76176011)(6666003)(105596002)(16586007)(106466001)(42186006)(36756003)(126002)(7636002)(47776003)(356003)(426003)(5660300001)(110136005)(316002)(48376002)(50466002)(2616005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1339;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT060;1:Vnl0QxLRlPPdEMpahpbskJIhBiY7R444r+0X27nOoWLWfQzs7+BLaNvC3VxuFWVqlH+TJPrkdTdHg+Pf+v0YrPuCeLOiQCUAFkOAd/6N4jzI/wn+QFc+j0CH1Y7o41Rm
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a823042e-d3bf-445e-e654-08d5f9530eb8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:CY1PR0701MB1339;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1339;3:nwZyO+eA2pfsWrOz9IwGQZh7b9IqAwoX1zk1ZMH6j0z/M7/n0hntGIp3NeRqeOsaaU3ZYf8FoawOhkfqm4o/cklx6iYd5bqiOnuFLD40Pk56QQSOFyRq6RRnILkqwV+qo0Ug/TXDIvQuX7bnpZw8zNG5yrqOMgYFnZ58nsW3f05JXdpvPQiE7kwMOlknruGEeSvhdQUuit2DONLWD46Fm0OGiXx9DR3oKAncK40aja8a7ULc5Io2jIbu6mgJ83YWNNrPwdH3tNFclMpVrJlJKQ1gn+2qJAyXwGilOK/hc8RW7W6yRfeNWxjuotaIxbHGsJF5j/vuI6TO8zz2l6BZxsdywW+sHbSboKnmlqYpNuI=;25:g2V2fvBYiUuTv4xSeeX4W2CsdI7cFjwOhumA0G7SKR6hY6coAwkQFN/74xhbvmvryI0GdkYFDc56wBOSYMbaNrUeHd5RafALVgIVaQqhAmfb3flYHGWFhY6bdqWZha1PeFdp812C1f5e/wk2Fw3DAVfTbty3IkyMX7165cdaIsOv1ksKfLIxkvrthifrVOc6YQaAis5fCVc83Y21347OGmbIXxh5Uz7hWwWTL0s5EHRsR2tSnhKVml7NtHixYO3yItkUrGBFFAK+VMSKTuqJ0N936jFx68LUHVasXDSnMztIxQDW3OTdO5zDsXAiJ+ZXIdeNrhatVuRn/OoIxYeBWw==
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1339:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1339;31:poV1xbMd48qX0sOicFmkAKoSq+lTZ8q7/AS0yPhPWwO8ErwrlgX+kVkq4idliyd+bP+khEhVWrH6OxyMuOLJ+JzVYRQUEE8guJX1n3C308SW8l/D4x/MYm05DIoiD9I2ZGw2k8vQffaXW1syhHqU0s3QPFoyZPPyDRlGx40b62Za8S9WwiiAhyPiKenna+VCEpr+I4ErqLYIVyv9zTzULIEyzNR2wlZqg0G1U/4IpDA=;20:XI9WToQRV+etf1f9B6XbjoCztQ06ZjpkWvBPwlLvyNm+qRVpirUXIkC9yJDWTZgPO1LUVbWPZ0CcREMJAl1VKz29FOsU+8diFF3RuZU/VtAknItgUEV4s9v9RbA5YVQMp0GS7Z/d5apH9erEqOfhQOXpOwXh+9xeHYxh/jXHlCEKC6kqHucChwcd1gxzamaH3X+YqUQdf7od2i8pKwHjKJyB4WnXooZX4imv3zkJMnBk3LcY3ofk+6DBp9bu2TqbKIGn+lGmqySL1HjMyYam7Nhp/TI+5krP6RF0Yk30dHMtEf69BnisRic20VA00sP6D62OXEwjqqiXolHSapvbsEEHKxdTAtZMteOvnZIzgAwz51oo6SaV7Nbze2+gk7nLfC/KVEfl+FMYH4aDmuRL6Fu9wl8PiefFmNmoCKL2Xfy6ci29b+Lj7wUCrXCQv/P3/mSE0S5ANtG+K4ZuBVr/AFYPNlI5kdChpDoKA7j/mqnaiTXxhkKWNFNakMUUBa1U
X-Microsoft-Antispam-PRVS: <CY1PR0701MB13396C4146ACE50F1AB6D1C0CF230@CY1PR0701MB1339.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0701MB1339;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1339;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1339;4:BH02UfLPBEjStlR1kJcUcV2ZX1rUbU+5AaGIp8WHuDqXq1dWxqGg39l7rrianB+CTFMSHTzXX5aWsOT2ed8nFx4TYqB1UVYFscbypMhV+jPTWyxbGv05UQQBjhxbIOgOQ2+w8fZA+K3H1ObEPtcjeyt/chKBiJbMXffYXTSPWzwFktHX5gNEQXT96bBkycs24XKeOF7SwxRx+cCXT66Nz6+A+BNFj7ByL3UtGZ8pls3VdO/Q2rSiON5+nKiKl5E7opwpAwI2RFLCFRY7i6ZFCARoMtAgespeQjMPNehaM7cE7/3LvGfJh3zwy/LwecyD
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1339;23:TrpIb6vjLobS7weHlCC1JAy8gcffqnKc2QRQJiv?=
 =?us-ascii?Q?LAqa1wkjkEdhX1lRc0uMGlSg54Gi6LUaYCSOso+2yHXanl81T9pijphOruVS?=
 =?us-ascii?Q?/PkARMEmJt/Agxx/N8kvXBbOERClHUu+d9lQ4zzK5kwkTDvEp3Zp38qCgd4p?=
 =?us-ascii?Q?WQW3PB06vVoBbMoMBNn/dM9cjIuT2jvyVmQ6mXhJ0LVhRrEAtkT16MjGZTKJ?=
 =?us-ascii?Q?4i4o2uNk48hk5u1d6D8DdYemdDyB9V8fFb/JUeL9npuvxLpUEuBNlPt9Dg8+?=
 =?us-ascii?Q?TOsQb2l66S5lf7abPPf3Zxee2tl+UB3ukDV+jmxDWMeix8Dl7101M80uI5kL?=
 =?us-ascii?Q?xEnJA5B8u21g69bu/TKJaJU1AbegQCJtb0jELbQW1RMCDOTka09O8HiSnvUx?=
 =?us-ascii?Q?PAGOj674E7DPneJo83ja4CTGhA76T4e80M2V7+QkKIOPU7dZ9H3vjUUHE/dl?=
 =?us-ascii?Q?sdn4mNx5jKdrV6H5R5Bt9ahCMNGL7QPQZe4B/bf/sprhCwtOK7bL+z2D5ALB?=
 =?us-ascii?Q?yyQ0QoaZXJNO492L/FwdQz4hKVc2P+VBPXiwih3chguMUBSQb4uhOJukdPQC?=
 =?us-ascii?Q?9pPx5sK1jiLrznIx0g+5qR/feDrj+XxmWKVEOeGhdhKF0wZ/JxxlgTGOlU/N?=
 =?us-ascii?Q?CCdQOB605QY+l30JfLoEbprdvAGyFEKqomV4ilY8HHxK9hXVkVEholt3jfre?=
 =?us-ascii?Q?ya8nCMMpN4OqXkPzh61mzuX7U35PBGpaFhkIQKUSnH7qp8bjLhFbaPI2r5av?=
 =?us-ascii?Q?WApJyf6N+pGywBuyU4df9oGwsVvIvyT+M8fppOpwEGER2wpLoVCGGXwb4q/1?=
 =?us-ascii?Q?gI3EeiwYyTue63ztcL5ITbuOrccYcTRVv5aE/pP+Kp5kPdh0h8ghvNwpqdqP?=
 =?us-ascii?Q?3PjCBRAbJypk4+nadqfuAaz/n66b/Qq3S/9ljBKBz/4wKVXor711UjPzQQqA?=
 =?us-ascii?Q?SzgAb5gN1HNk9KZbGqKVVXcD0QVeEOYIo/91YtpFU/xM/IB9KU0rJMps37Gp?=
 =?us-ascii?Q?SVPtwDeZ/BgrLF94mY5t+fGEbR2+CLDF4Acm1/KFOaWwkbex91WE2H3X0/lA?=
 =?us-ascii?Q?Y2y4TYQW/y6nJrcJo6JX5sSeQs71XFty1rRfomS89odDOnf1PEB+SMkHJtL8?=
 =?us-ascii?Q?uwfWXF85z/wQ=3D?=
X-Microsoft-Antispam-Message-Info: gjJ/c30zeASCyoZnviQpyTqr8USWRPs6pi600elsXBzQHLZU83RCy183tgYh5Mv6wIV3EPQOm8mjpwIm4T+n5h2TsAuZrkwdDzv/5+GLKoV93ueKlj8yPhaak8yCHifgOFLywRcckWKntPPjAxjkzDWgcH/BUpx2lm2EpZAAMEhWyZ0osIPcqoPbRVzhPL2xmFVmG1ihuibnqJ7ClGsS2zIggoAVHM9zmAqpxMKrn25dT3yK8xq0mlDa5jrs19NmjbOia37ESVvOJLMc4tr9XxCSbT5rRY9ZOSljuDm61LzYVptlzwQBY0dnGY7Daui7ixBF8e0zL7y5vp/tUKajS/8/8ULEFO+hfX06JhqQ/0quQmtOh8BJxJdx2/NVZF+91pYTykOg10kKbf5dYm+ifQ==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1339;6:SjaLU8bVLedn+gscC/KKq9gsJTy0jeAU/wzsDJWzTdL4tfpY1WYF2FaP8oKhCY8BOURveN0URxN5jjeoQh9HXbmdO0AYnqrrGgmNWdD1Gpj52w9pXrePlqCZ2EPzVLPqoTSdm4D80YYRAR1ajlVvM7bKXNQ30zWhvz3ZdIDZFDa2GHocPfs++pUasOTtrB8WKvhNO9JPwn+9409XoRAaxaHTJoevTc69MTh/vtg8cM34gk5zQcZ3jZMvrHRkj9hdBZiKwmwsLMthIKbFplyvhuxpYnbdWP1QtUU714IwHdPtxkq8cKd7sb9aahVTXcFKXSZUWXZ11YigalV0JcdiekX2fuJxlCp+CpprzW04b9qc6yy875JQBYu0r+atpr8yeRuaxMVssIUbynNlz9tSPTU9MKr6ui+ZbohUphXg5zI07S3y+3rsSNzQqQoQl+r8566fSXqSBYGmg1tpmtTfjQ==;5:NH1vXeidREAB1vl3Zg+DIRrUTiNF3KsfWF+xnDxHCcH9RGm9lDHjx+2nrNdta0uE0mw6iPYnz5XQLYE608w0F54lvr9pt7+kALnmCXMkyQRhTaExDh25Iu2tzjbY1GEfx6u7R7NufqbaPiKzHNAjTNBlkt/Q3+0wdcXnLQqrgX8=;7:CrrSTFgp24IQDazN4otM3mQ+VNsQh0rJTUW0nJRxywUhzHYzfYBjJid58FadOM4gm4jzcqatW4Ysht+cY3rQQs24mYit4QULnbZ/5r5rspjkGk9p/t1/RCVu8kmZZyhjEPUgUqmhL28q2GN3jcTOHWzHiwM9qMBuMvqN5prijLoAWe5qfc9DtaEAntpNAY2nOvldsDMNRfDxAcJtlEQSo/8T7GJp5j5wUycigbjcaowAeLZmhaSSITTE4se58Vtj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1339;20:corSC4bBAavUloHSlgRMNlSEACqW+H/W17avt0gH3LEOTd4b1sKZmBuW8zWFCMhLryH4L5MD1dALvBY4TCiJ3b1fne1A55xMXe+/wvpzby18IvqYDQ2ij2l+qNp78ImpUBTxqD0yfdQ3BihOQiM36NEEfDZzxiXRGIOI+3M7/KOBJBN0xItG15nGTxGX6D8PYzkSTySH62aou1jRnoivT4i1sgwTEMDwc44BfSfMJSgC5yCOKDwP61VSstaYwDi/
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 15:09:06.4581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a823042e-d3bf-445e-e654-08d5f9530eb8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Scott Telford <stelford@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-dp.txt     | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
new file mode 100644
index 0000000..8de0526
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
@@ -0,0 +1,28 @@
+Cadence MHDP DisplayPort SD0801 PHY binding
+===========================================
+
+This binding describes the Cadence SD0801 PHY hardware included with
+the Cadence MHDP DisplayPort controller.
+
+-------------------------------------------------------------------------------
+Required properties (controller (parent) node):
+- compatible	: Should be "cdns,dp-phy"
+- reg		: Defines the following sets of registers in the parent
+		  mhdp device:
+			- Offset of the DPTX PHY configuration registers
+			- Offset of the SD0801 PHY configuration registers
+- num_lanes	: Number of DisplayPort lanes to use (1, 2 or 4)
+- max_bit_rate	: Maximum DisplayPort link bit rate to use, in Mbps (2160,
+		  2430, 2700, 3240, 4320, 5400 or 8100)
+- #phy-cells	: from the generic PHY bindings, must be 0.
+-------------------------------------------------------------------------------
+
+Example:
+	dp_phy: phy@f0fb030a00 {
+		compatible = "cdns,dp-phy";
+		reg = <0xf0 0xfb030a00 0x0 0x00000040>,
+		      <0xf0 0xfb500000 0x0 0x00100000>;
+		num_lanes = <4>;
+		max_bit_rate = <8100>;
+		#phy-cells = <0>;
+	};
-- 
2.2.2

