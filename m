Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A018C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080D2206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="G9t7SF+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080D2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeILCgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:36:54 -0400
Received: from mail-by2nam01on0068.outbound.protection.outlook.com ([104.47.34.68]:54261
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727736AbeILCgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghTCCfQ0IHN3Uxg4BQIdAKO6nKKUKdKzq1/04z4e/nI=;
 b=G9t7SF+RGKQ66cvbG3vnDHDyE7NdJG7TQk0c9BE8ss7L+VAyj7Rh2GY1QshrpyzmoAxeHyLHlgGsoojUUn68QapCKSA43+FKkfKm0YvHL0VBPa1qt/I1Lfenr89XgvPWcseO+MK/Xrp/xw9OZ1+x9yVYu6xGHiJhaFvh0xKVC/8=
Received: from BL0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:207:3d::26)
 by DM6PR02MB4473.namprd02.prod.outlook.com (2603:10b6:5:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Tue, 11 Sep
 2018 21:35:19 +0000
Received: from BL2NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BL0PR02CA0049.outlook.office365.com
 (2603:10b6:207:3d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.17 via Frontend
 Transport; Tue, 11 Sep 2018 21:35:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT045.mail.protection.outlook.com (10.152.77.16) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Tue, 11 Sep 2018 21:35:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fzqJa-0000Wn-By; Tue, 11 Sep 2018 14:35:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fzqJV-00052s-7a; Tue, 11 Sep 2018 14:35:13 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8BLZ8Pa023974;
        Tue, 11 Sep 2018 14:35:09 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fzqJQ-00050U-Pg; Tue, 11 Sep 2018 14:35:08 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v3 2/3] firmware: xilinx: Implement ZynqMP power management APIs
Date:   Tue, 11 Sep 2018 14:34:56 -0700
Message-ID: <1536701697-23949-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536701697-23949-1-git-send-email-jollys@xilinx.com>
References: <1536701697-23949-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(2980300002)(438002)(199004)(189003)(16586007)(110136005)(106002)(54906003)(7696005)(51416003)(76176011)(305945005)(356003)(4326008)(77096007)(6666003)(9786002)(26005)(186003)(5660300001)(478600001)(39060400002)(8676002)(316002)(81156014)(81166006)(336012)(107886003)(2906002)(14444005)(63266004)(2616005)(48376002)(36386004)(476003)(446003)(36756003)(2201001)(486006)(126002)(50466002)(11346002)(44832011)(47776003)(106466001)(8936002)(72206003)(50226002)(426003)(7416002)(107986001)(921003)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4473;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT045;1:5tCcdZxtUHKaIGSFQdIMUzTR7Hk2qMfI/jnJj6lu5HuYAEENLY9vHjd6NkOeF43KMibVYQ/FA6qn/rIxLcd8bjLi/40oR55qKS5lRoKViIdPl68rbOH0+h5T5MiLcI8z
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66ad2bca-e15e-426f-fa5e-08d6182e78b7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4473;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4473;3:MXH3uN9sSPVJJKVHcnbDsslZ3gt4jb79ZsStCeoN5q/lYCQhCC91hCsEssegoEfW/kOAdUsRVlb5N2bs2f/GsNcQ/dVD/SDb7NC2gWxwz6WAZjXLruTf6G74TnbaKbVpSnAaF0nMdebPYj1BvgVDq7/rGk+ERlWtJuiXT5Ay9XUZe46Gt7xKpeNPdwv4NP71zyu4spTRo7rOjmvWRJRmNOI8YxiQ8auQ70KQ3mHmkcxvxmj9X8vtRg6U6ykJRQ4HbghhmRbucGVYJjoPH7vBZxO2v6ZJ2prZVaC/QdASG2yO9axprVzRR9BkUvQ6WWNhrmvd4ehvGUtVOmO/xWLjm+JNeuH521mHE66QxZ+UYgg=;25:dKnXAXklO4TBKqF7FmyNGFC2njAlfS9WOOVQQ4Lm8u4YdsGhXEQJOFvYdkwdlIZzalF/6zjdYC1TQlYqfZoCtiFnozHziuaAmDtlM7V+JKvGbxPXSODd0Ds4l93Zf3mlmWJyiQZxwJB4b7PESWX0W/7001rktfpzp9vLMC6dQn/qDRxHllOj9LcIQaTz1N0exQyvM8hkfFPqUrLQzz3cuhuagG+QG9DYPlPov7HbOicTdz9uNuCvAyg+Y+nbqIohXERWSUqbd2qdn6zlCcU07rS2svNazmU3GILxKBsTbhkMIJBp35JGmFdebqtRqOycsYiquvXnsP0hZdt+oC+3rA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4473:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4473;31:MtHvNVS4xdlxCFrz6YqGQSYHjaYRfO9XUd7ra+WnUiLmZXsshU7oGRLiIGmbS36D/xeRgc9SlEjXNxPTE9fEi1bkQ8zdeQpARV1pheCbvSF0592ZAqUMBNhFKhbObYKjQaRiIIBGR6DCTDY+7zHg3IK/jnoCY4h7XwJKDh5/DOo+pyBUKwl+ehMAj4nON1CbYOiPMkH+LNagz3iXysJjy4pgSuF2nfEBDa8KzsKADpk=;20:yTrEhDkt1fyXoGk3JLO5fx3z9b2KZlckHmZ0fsJVz76TY2oYgp/omixryWGQoD+1e8dxfPaoKZlZ1Kq3+O2/XgaaptetONnA/BVYsnv+KsGoXS+/IX8SIJntRf/tzXG42rtF0pwQbRFOe4Ff51HLLlVpt8VAqp9NEdjKcY+peGNaMRn8j6xjUArEZcIlmKv6K7Kghvce1kEoWDzOdOWmvcDC9zYZ1uSWZXqiAT9UpIgb55/+Twxmi7VooaVhw/a+OBUvLisnDaW/KvNTncogjQ43oMRZiYE66fkHHTa7byauZH+/LofQfQ42SeYa1QMAsa6fqoBTx/U8ZP/qFQ5zpm0DjTcdMqgWu0CLtlzsSFXxJyY6P/6FCMNLF4+jdiu1SwcAhJIl8Fnhby0mrYDlmb8Py38L+MKRzeOrY3wo9FZxe1hQ0+SCq1NesVtyiScdgEKH6VXu/LfmQulkp+mfhFEjPjv9tOH/ptg59KfCfwsqJIKPD8x5VPo0zpddntjo
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB447351576EDC9DD48D8A3E2DB8040@DM6PR02MB4473.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:DM6PR02MB4473;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4473;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4473;4:o/u7TSHIgJpCdnYnx6Za37G5UocaA4UCs9ytHN4svZkwCGAdWO9TI3P3S4ICXDIgUUxTC9NhB1ga9Mf2e/vdqc8VpMiGChulBAA40Rlkn5sL8CW2Ev4VE/i6VnmJovH6Kt/nRW246TZJBbrAOAR1Tj/UjhH82YYfsQ9Ya0gIchDftKV8xBvmUevYwZF4CL9oPXSi8LJbCkp4NWD5Jey8rDUchNJ6HTVc1bRJ7Kyp6rxl+mmOm8ZhO7+MRs0/DJqH0+W6egVnQur4RKEdpf3MwKdjqjErSgRFk8F8N8vJWGb4gTuao5YX+ORJ+W8VJQM7
X-Forefront-PRVS: 0792DBEAD0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4473;23:GJ8P6uu90TXDLUpbCOmDGrYfiH1AfckIWwVwXvxjt?=
 =?us-ascii?Q?Z2Pofqe41KCNdtCts59rMtqegT8t9Ritxh4QQEjU1PTKnogmbdIe3Bqq74MR?=
 =?us-ascii?Q?YelnG7Lg6Q+tY18zpFVXBuayou8rstXvG3DChfkS/ojWPHprovPODM0vCvKh?=
 =?us-ascii?Q?b/V7D5jZL4KSDtGKYZwbc7qBNO8VX9JmOtGTJz6UQZ1L0CqmEIuoOfc8fKoi?=
 =?us-ascii?Q?G1p7zyGbHF1PKcLYMXazbLZqHCag21JIQRoAQr2xkDweOKmpiZvmC15gecMh?=
 =?us-ascii?Q?klK4wVpbPF9cnVsKQuPnEvAMX1j+KiE4X/b+TVF91adeh1hZVYpweMv0/oaR?=
 =?us-ascii?Q?B+eVMKQ7Dxxet87tMDTaxndDXWsmGRHVMx7MnXNhEz8YdXuQia2NUzStNyjS?=
 =?us-ascii?Q?tIxzhyM5H4Yx+AkygDEy6ZqFiEVPcJGnFMK2ZzjaYRJUC//4X4tnTvwtP0Mv?=
 =?us-ascii?Q?0HV5BDkZVXTxt8twPz4AG7n0mbir2ji+PRyi3Fgeg3GHYofhBwcCVnNa+EwJ?=
 =?us-ascii?Q?J/BnIRI4N35XbVvmZir8FhaQS3L3prntBTamkcybmtwSC0/rR6xabAwohOf5?=
 =?us-ascii?Q?Mzi803vL92ACC3EMaGxv48ajelQYbkcLRphKKCMuvsNXjMCdCytrFhFeetFJ?=
 =?us-ascii?Q?S277JcQ+2eMcksBBmPUVBpv6vuMBJjWS3kQNJCqx+POL0UuzNYKQ+qlMDN62?=
 =?us-ascii?Q?xM5igsa5T5ryBBB/YBaXaRQKvwAndkGN5NJi+oMIcagd0HtsfpDbmbYU+Xu/?=
 =?us-ascii?Q?qGYDOmvxcHLZ3+ZFmbUctDVvlnQ24YyY/Ue7dQLH9/X0F+cY/N9rr3oK7Ffd?=
 =?us-ascii?Q?CcnbRXm4i97JVKawh/i0I6q62cC7nI9yBl2v9brIKV3aeKnO7HybQKEIQsEI?=
 =?us-ascii?Q?pzsPNsW1GGf6hkTctV81CpNBS1j23XjpBNv6BK6VToagokQeD8trN09k7YGt?=
 =?us-ascii?Q?Wgj/wPzUf96dOnswLG7vSM1D2ikxi3KTtGlanyBNNdRuRgMKJPXhy1b9K73r?=
 =?us-ascii?Q?+y1ROgRyVaVN0Qkh6yH7BaqZHglgCVKDb7WpGr1dBLxxoMgZAnknzTid/Haj?=
 =?us-ascii?Q?q+afWxsaPVeO8Y+eHdQJzENVX1yiIJ+vIzFKQ7KsoWqic9Vm1VT7jeS8QF4z?=
 =?us-ascii?Q?0e1pPZLQ0j8k5x6pgLTelTkIYeiVYnT5l29I4P5U3yI70QwrTuyB/j1TXg+P?=
 =?us-ascii?Q?TvVIdl35/ibCONII2UsUndv0kQzfTwX7L1NZCHVI/6jUr0EmMObcYaESrkKF?=
 =?us-ascii?Q?qshP0fiqkVHFIj4/ViPcWfj0bGRxb5GieoXCnJX2oyrZBOoLjBWWDncfed/s?=
 =?us-ascii?Q?U//NjJmiSpbnBf/IiylIvA=3D?=
X-Microsoft-Antispam-Message-Info: IwbdGqQPOr2+3XQZuQ2DKtlRmM04QNoOGeq/3Xuiotx7zF8wRI9syUg75+j/dmgnhlWOf2aEkXyb3+gMK8lG/SauzL7fNehv9vCGiw7PWiyqOUmZt0cZVNUF+4QcaLxl2EKiP263thxa4x8GEE0F4X6gv6Qb7a7wvERXm1hRqlbc+1ZTVKO+O0DkDR0cV1x7whOH3A7yEF0JiYh/RaKt/sjP5kRQByzPetFTulbEsSJpt6ge13DIqAZSilp+kuhGJ2spmk5hRSOiaN+kG5V5fbrPO7CzcjwdGdionbZq20GYzFqQJoYjmRT5NI51qTejSyEBF2QYISqLMJsbM4MMs8vHVuMtGRTzZU3AoGM8bYY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4473;6:Cohh6gdRGE/JJcLzLzQ9bsyETsVZDZn+0MQkQi2BBnWlUvIKtPLrObsEgRUPZuEahwZXV4/tK1ReJwH4k+t0IiNFWxKQdA0yADhTcb1zw4CM3aLDdFLwE1bkKyGDgel8AcesdXYXdU1+wtMvuvPrErP2cJUW+UcEtkrISbLStoDFhe8B6G/u+eemSPvW8QIiXnIUiBqbixs5HZ/+qBVcRJ+HvG+WQvPu5XVoQhDcpR9cq/gim9HBZzcwhIauVFMGryqQITbqcTxTiKLgaMBiPOu2gGw3uPSfFNAsXVU+pAJD1Lw8bZPGiuZoiXeKFgZtY6aiS70cBd0huoElDKdwE4CFzshtCfk3IfkAFaLHm9NrxwaWoujunMLfXfOz7mHVgJ497HCu9jAXfi/JFh5IUBLBenEoIob4fPGaPz2smPplZKIiScR5pDeO/iETt5xHp38aK2Q1wLKRRv+MLU5R5g==;5:pSMpuTeMs3ZXIn2hyhIiFwNew1LT7YHSAffa7ZY3epQxJVNiGyj4lE0NXW6bNsdm4so9Muf2PN/uaqiobHtOZcK7t/9GuzgPPQM01Emx5KRSsW6A1RopFtJEnDy3x5JT7aymQrOrSVgmRvlyn0z0REurlU4QFsKyW8rYxGhF9/Q=;7:GeJFSozMNJikRIdJE84BZrZWFXat/tRxtqeP+aL4aUPvbBepWmEnHUzdo3NrFPxklc27riVrsmXb6/lfsZn6s/rOaYWZROulavHM+vcXO3i4ltpsyNNRNn9VX24MAnTVqHLUJbLzsrJgfxEu5NEQlFjbsm7C+CWta6x6s2NsvJBEd4grp6wF+sOqB8/+vQbUOJM2M5/9lwwXZiKUhUfqmqZbRTUJ1//JzSeXl/YjvVVTl8LMmWzc/8hoUQKtXoJx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 21:35:18.9732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ad2bca-e15e-426f-fa5e-08d6182e78b7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4473
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add Xilinx ZynqMP firmware APIs to set suspend mode
and inform firmware that master has initialized its
own power management.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 29 +++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index ce6c746..97818e8 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -447,6 +447,33 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
+ *			       master has initialized its own power management
+ *
+ * This API function is to be used for notify the power management controller
+ * about the completed power management initialization.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_init_finalize(void)
+{
+	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
+ * @mode:	Mode to set for system suspend
+ *
+ * This API function is used to set mode of system suspend.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_suspend_mode(u32 mode)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
@@ -460,6 +487,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.init_finalize = zynqmp_pm_init_finalize,
+	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index a3ef7d6..fd8f99e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -28,12 +28,21 @@
 /* SMC SIP service Call Function Identifier Prefix */
 #define PM_SIP_SVC			0xC2000000
 #define PM_GET_TRUSTZONE_VERSION	0xa03
+#define PM_SET_SUSPEND_MODE		0xa02
+#define GET_CALLBACK_DATA		0xa01
 
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+/* Number of arguments for a callback */
+#define CB_ARG_CNT	4
+
+/* Payload size (consists of callback API ID + arguments) */
+#define CB_PAYLOAD_SIZE (CB_ARG_CNT + 1)
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_PM_INIT_FINALIZE = 21,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -75,6 +84,12 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
 };
 
+enum zynqmp_pm_suspend_reason {
+	ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST = 201,
+	ZYNQMP_PM_SUSPEND_REASON_ALERT,
+	ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -102,8 +117,13 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*init_finalize)(void);
+	int (*set_suspend_mode)(u32 mode);
 };
 
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload);
+
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 #else
-- 
2.7.4

