Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AA0C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE9420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aeeb0uzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE9420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932940AbeFTRmg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:42:36 -0400
Received: from mail-dm3nam03on0043.outbound.protection.outlook.com ([104.47.41.43]:17024
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754721AbeFTRlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJzB+KnyFKhLEmWrAsNYQ8EP3hzk/DxRcJ5zh/8+xcg=;
 b=aeeb0uzTahKmG9str+Uv3Y+dv0doE2w2dv2+vHFzNGeLVp77w0BXUB4FhBw/liZLMv2ZeHytVMZ0GpA9ljaZou6li7xzd3uFIXSdY5T+B5wcFfbISP/bsL+Yy8wLpOQeR1ns7McCWxj0aoE2MVQPEgB6WAlBVs+DNQ2QzhQL6IY=
Received: from BYAPR02CA0008.namprd02.prod.outlook.com (2603:10b6:a02:ee::21)
 by BY2PR02MB2149.namprd02.prod.outlook.com (2a01:111:e400:c506::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Wed, 20 Jun
 2018 17:40:58 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BYAPR02CA0008.outlook.office365.com
 (2603:10b6:a02:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.884.19 via Frontend
 Transport; Wed, 20 Jun 2018 17:40:58 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 17:40:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6G-0002P8-EH; Wed, 20 Jun 2018 10:40:56 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6B-0004lu-Au; Wed, 20 Jun 2018 10:40:51 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5KHeflk027137;
        Wed, 20 Jun 2018 10:40:42 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fVh61-0004hY-Lt; Wed, 20 Jun 2018 10:40:41 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v9 01/10] dt-bindings: firmware: Add bindings for ZynqMP firmware
Date:   Wed, 20 Jun 2018 10:40:26 -0700
Message-ID: <1529516435-7315-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(39860400002)(396003)(39380400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(63266004)(2906002)(11346002)(446003)(44832011)(336012)(426003)(8936002)(476003)(2616005)(126002)(486006)(106466001)(305945005)(478600001)(72206003)(36756003)(50466002)(48376002)(26005)(8676002)(77096007)(6666003)(6346003)(47776003)(186003)(81166006)(36386004)(81156014)(5660300001)(107886003)(356003)(9786002)(7696005)(51416003)(76176011)(39060400002)(7416002)(106002)(16586007)(50226002)(110136005)(2201001)(316002)(54906003)(4326008)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2149;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT009;1:BXDHIwkZUFYORtVED6rO9m940DoTpytt0g9KPimlXUH6HrIW+hXWb5+zPqLehvxuBtlGnJR18Zos4Zw+FhJik6VN2HsbWnwXBORtr3NRbv2qIJhRSq453BaRHifTSkGH
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e4c7c0a-631f-4bf4-8c12-08d5d6d4fb45
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB2149;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;3:i77k2Rk9viFoC0dQVqxtYn1+vRnzmF7Yh/lu/Dpo1VWHQXXGqnhV1mRfziSZwNQcc3Jd4RnEE6HtFj2mXUpQvC3qgpr/aTksPbhOYrmHt+Z5Wc0m4jI1wGefUOPoSOXEhuzq3cr2NgA9lR3hBDysJxMymVBfxuCXCA/phcdgLB/Rt7FmLm/wu8Si/Hl3U9raWSAtCnsjGcYYsBQBj3cpbpdPRXE6mhalNKOXEvhYLJb6l+S2teZFrM+fsfBhwJR5bYdvxEqJPa7kAbqEES/aDYYe4hjtYA7AH5N5Ti9hZsivDutqYK6kHS3j+ZhkA5bZ35hKaj3T8S3J4jL/qaesZVQkfkT1Bv9ZHQuvyZIvHBw=;25:7FSinMEKbxK0Pp4lFRefRzIeLg3FS0xQuMUp25WcgcdLycqfBjbUZZ0/C5kdAkhzKqdYsyE2EDqT+2Uwj4gvjwR7d0FUf1+rJ1aF80HOfDRTeLozI0SBi/hAOKh0xefkpGdawBm0EyG3tWc5+crw/nUa7c6apwwRZdWsn0WIDz6AatIjX/zTG5l3hRRMG+n7LWXu96WnmPTQUofJBK9eXaQwpkKf41vLnIrNm44Z5/3DJug+ker13tLPid8v00eoaK0iWxhz0u/senf3qYJXhrHGjoNf+nYawoA6hdLhGC1bvc0G3WGT6ar10CAvEzYXnXzbO8WsJDL4d3mpJyz6rA==
X-MS-TrafficTypeDiagnostic: BY2PR02MB2149:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;31:EThS4/IBIVwhOSGN3TzbrNqx6SVYjKGpJXGbFDxzjYLPFxV+NTvoqoN96hU1HPelhYcferU1s/FNqn/0jgMjUGY9LFEL6J1/Lkx1Y8bo9vW8r5CZfmlEzfEVBkvAewCkcnSi5xhVanzBwojaZTKCXm3TGz5shJnSnPjjBDxDsgNFLb+GExLzsk2ptbc3stHicthOt9LxePk2yO0p1hMdrGZs5IneZFa4SYte2sXeRwE=;20:nE9s/Kyt9NlBfXV3o1g7OTsEuRco7D4hTc1VXWTW/0htoIRxKMaeij+sGEMlg2kig/eS69+yc0T3Lpw6VvzqcC8YfX8Z5uwfROMEPXZmTVKvRi4gzGia1QWpYs14i22Ko9xkonDQRQe44vxo5XCIH/y2MKuzoWyjOKoDzH9NjdY0MvKEhawIUmpJsYvQY6Fr1mlvwIez4+qghjlzDyi1IYnLIFDZNRyfRcxUq2r/HjFdjmZcW/x3QRcxV7QAq6SGSkFWlmt87+QoTWri6UJXa2cq3U+oqrdp3Ak+g1y3/HE7ocaqbsDT9/9OWzAocaG7wWd5XeIz67mq+pBoU0QwRx2DDq65aH+mAwBpcawoMJaPlKRveOto3Qcx4Ow68+ZFSUWbel9LTHBN4bQK5hGNZ0/Iyjysr/TMtmJX6OJK6A01EMNsJhcl9vKAQxi/xMxJ2itkW6EHUxBSX0h4f8gHsWpgAbcG5ZtmfbK8+z0TykU4XVfmXT7Y8LEhuW/JMm2o
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB214956B758119E948264A1E3B8770@BY2PR02MB2149.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB2149;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB2149;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;4:V3DG8jxXRo5AnKrPhx3L8Se6CtXxVpldbsl7gCuJKmYpX+xSwHbiC1s8zN/f3sFl1FnB4d4IphC/65bWZLXCDnS3jxZntE9sIKNrAlCR03lugcqsQx/nyy2TR6Vzx9qhKk/TiL53yYEBOfVRP1oJnemM7h8oohYccQhO2aXs1Bw8pylgwTGICoEruLLd926pjklL7W+c2vf9JBRtFOWgyujHup6JEDEB0ObJuP2+wiDq7aYC+gvmNeQqqhGM9jeFUFPDmKdxgJFCwHrf0db7C0nzNyY12BbI+6sesJJRVBzvSehhIc8cS1HCSzRt11pV
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB2149;23:r+nZxnaxoXrD8zkeCY2sftGdc51iNIcYZ4XiLJw5c?=
 =?us-ascii?Q?F7ZLlLAqm0EcANes1Lapx2nV8bl6ssr/U9f8EMZ4Au5qs7EspOW6KzdHDj7a?=
 =?us-ascii?Q?FThwT1+fq56UPjcr2+iALEY/+NVXN1fWKqDS5kJCgumuahURLiVN5rZOm1tN?=
 =?us-ascii?Q?M6Cc36BYB/m+IuozVBB2dEBGonW3nns7tGl09DeTvsxXX5PWtCZeoNwuZBHQ?=
 =?us-ascii?Q?GmwF0rObenhSNcn0zT4Hem6TvCs5L5rXOTjyKbP+m9m6TDvFC9lZvPGh9xC1?=
 =?us-ascii?Q?56N04mxpaysudttkZIbtt0Mqz1QD0Qp5ZLjc8sCaVA7H7IDvMfIOweFelDxU?=
 =?us-ascii?Q?MxoFb85ZUTjh0sebu43sw/gT2ezwt3Bugg89AEQPTuYI0wY3dWeVXjjCFZTg?=
 =?us-ascii?Q?nsaiWxyQ7zwGzCDTHVl5iKfBpuuknraLt/peaJUpsbSwFRFhcgVLUdhgTvLF?=
 =?us-ascii?Q?6wZ7AnkdGwlziUTvjL5LZZEwIyNXNXpcaHnbDYb4MpHDkKDnJBK0xMtL5D9t?=
 =?us-ascii?Q?Pz0jzTfuVyZ3gnW5eI45N2F4y35AcV8Hmbf6Zn91N4vn/nt+IzSFXfFF1Mk4?=
 =?us-ascii?Q?nCZExJSKhQE/eopB96cFE+byAQpNEswcq/3yNjbrZZ0YNIXlGZoef0uh3Wga?=
 =?us-ascii?Q?q6nm9SaVxZENd5RAkRJgY7o39cPzspvv1ck7wsyFSspxa5J38LGWs2mjX4wf?=
 =?us-ascii?Q?STaJkKKJ4A6ivy0m0xRfrcCCbim/ZpqSCfo/+y/9UImZIxQnPwYx86bGotcR?=
 =?us-ascii?Q?6S2AZ72E9EVaPLpegBSC/OlSz2MlBnke1KgxjR7PE1umM6HtLNEec8co8Ul7?=
 =?us-ascii?Q?i5C4S3GSTq2pdtIX9o+I8Vy3pVPpVZ2ku23uJS6jsPycyGGIXFAio77clqG2?=
 =?us-ascii?Q?BHmQVgwPh2jUsg3GfsSDmrZW/vn88g9Rwg9SZ+AULxHnaYFXnf0+b+9aXlsF?=
 =?us-ascii?Q?4I+qWVBwJiNJtsmBX5V1cdVIdIzX1uFOegIVx+et6DYY25y2trtlnfjuPzGX?=
 =?us-ascii?Q?BjzQhxVSq+PGl3wTxLhB4pl5AfUjM2zC/CbLgUGh07B2rLuEXK4weExB94V1?=
 =?us-ascii?Q?G+X6cGvWxNDY+CuhTy7kbUH+o7fxI4ieJS3/T/7gmM58wciah8oXK5RkckYS?=
 =?us-ascii?Q?cEF1XPNZs1YsH3rDXEF5/skYL7+KLx9DIUcZIe5ERxY9FJ0qjDA1idhzLC+e?=
 =?us-ascii?Q?XVLqbKMbKjzs3TACuFcDlPzejOZmK4njVc7aQ/1tc5j2nKdhYAeQsx1SisuZ?=
 =?us-ascii?Q?52g3v7djKhijXNyZx+SIDyHwfZWYxBZyb4FfwqIECdlYPBxOcq4X3iH3g0gX?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: D2DAQuz6Tk6UqIQ5LqYdHFD9cjdjQ4kVyPbS7YjoQyhvJA/C9Xw33U5+ooALCxxAF4/8lBf1HvcY1LYLLpzxFHi6pbytpyStMTw0Gxu2U3lhd7AnNMOkxYsbDfij6oKTsZ0XgfPuc5HKgo9SZmASF5ct5gbULG4NAtOBUmnrTxZIqnEpTo92fn1cplb9t9cJ6c3qxSBNyEOAiw1iFhExojZtnw+JgV2OuxMXPkId/zuw6Jfd7SzxGWiNFLpkpMr6uXTL2I1ILJ1INTsYCutbSOsl5wSfphDP+mAggifiowo2ikZQszv/oJGHOxm+GvZ892gdN6WjioRdJnGXRKVwaA==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;6:h+XPGOzYhZ1vN6/gkb0YGHJ1joBFXllkbT6nBxwb0YX6S4okTR0FPemmI7uOE62Dd6hR3wiusCnH1nGz7fnfdW6yL1/W1jpgS6SUw2Vow8lzmdTv8rVDxSQISmShTkCFBT8dEzAJ2NYGOPxL4YSpV/QUUs079fShzg52VxyBSLc5tq2esT8cSeA60iTMGH8a9hUs48mvPrlrUtWl1Bak5L8ns4qU4aN7ic+08/KZVyAuO3cHlZU46oB4Ruz2x44LEgNyiRnUxxSDKltBWMJ6N14oUEUcKacH2ToVV0Y8YeFoqHRkZh9/jUjRqeWorpiWbsk13b11OGEl6mD86DOjFBn2PRJpWkpuaW+5HEzfskA7wqwlD4JKv3PQ+e8e1p4+7eKPPFNKZyrd8cAAQM/lvH3fEB0Q/EwsWtGV+HKJlnMCTTZf8GsmUdwQKG33tEc8sItxKdAbNonIhJGP0+j32w==;5:aNHAnnEhMvpThQx4Lq2PGX94R2qIF0M8QzvCb2CNuZS5LgAtwKOVg4yKBS4+iS18xQ71N+kWdzstXQP1nF0NF0aD1r2/zNhoDl9PTacNBY8aFQGnQphPNmP18f1AMyKxTFBUR6feC5ve3j2gFW0MWj9FrMSvPihSN+ssTvGV4SI=;24:3DK3CB8l4tNgMLgLFxS4nRpYgy3lmkiPhbU5Q4eg6WEySDhKPd07Der9XYHEN67NQ/PXECi5qtEkW/uap1NNp3292HpfdIgQGjrSpoSRejU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2149;7:AqmH6aprDEx0UQhtjPuat61AJKMY4zpqjp1/RBZ8MVQly4urzDsfSEVajrhdWIvVH72jApXMFxnxLG91AySIxfDNNDhUxI1hqU0JlDifClVztIqRraV29Pkr84DhwlbPWO5VdzAme4cOETXVVkKuJw8TTgKPNYkwY/9kW0buEj+G5Kh0texfFf1OSUBJM1ilEfXPRNfRR9hWntFSTya/TGYT5bE7dQdPo+amyljKPX8azxFd6aidnxWmjtoR9fsO
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:40:57.0780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4c7c0a-631f-4bf4-8c12-08d5d6d4fb45
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP firmware driver
bindings. Firmware driver provides an interface to firmware
APIs. Interface APIs can be used by any driver to communicate
to PMUFW (Platform Management Unit).

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
new file mode 100644
index 0000000..1b431d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -0,0 +1,29 @@
+-----------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Firmware Interface
+-----------------------------------------------------------------
+
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate to PMUFW(Platform Management Unit).
+These requests include clock management, pin control, device control,
+power management service, FPGA service and other platform management
+services.
+
+Required properties:
+ - compatible:	Must contain:	"xlnx,zynqmp-firmware"
+ - method:	The method of calling the PM-API firmware layer.
+		Permitted values are:
+		  - "smc" : SMC #0, following the SMCCC
+		  - "hvc" : HVC #0, following the SMCCC
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+	};
+};
-- 
2.7.4

