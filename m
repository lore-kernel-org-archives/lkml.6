Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB590ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F1E20647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="tZ8mp3mT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F1E20647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbeGTPxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:53:04 -0400
Received: from mail-bl2nam02on0068.outbound.protection.outlook.com ([104.47.38.68]:26896
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731731AbeGTPxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW6zlrz4lHYPhBvQewL8weXEoFuVXIcwCOwRa/EHkfs=;
 b=tZ8mp3mTAwFIe6AH/Fdw4vu39NEMPn4mBRqquQNZiQcWF2yAC3EZjodWnxgKFhP3B9uykC7nioMv5Y/Dnw4L5YKEJuorxEhrdJIi44dc/5Sb/zX3VTIdJoueCVV0cYZ1Y5RXPl1w9Zrx2Rpu/cCi58rPBh3aXfkY74s/oF90WL0=
Received: from MWHPR03CA0030.namprd03.prod.outlook.com (2603:10b6:301:3b::19)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Fri, 20 Jul
 2018 15:04:20 +0000
Received: from BY2FFO11FD008.protection.gbl (2a01:111:f400:7c0c::127) by
 MWHPR03CA0030.outlook.office365.com (2603:10b6:301:3b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.973.16 via Frontend Transport; Fri, 20 Jul 2018 15:04:19 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD008.mail.protection.outlook.com (10.1.14.159) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.20
 via Frontend Transport; Fri, 20 Jul 2018 15:04:19 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w6KF4Iv8029148
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 20 Jul 2018 08:04:18 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Fri, 20 Jul 2018
 11:04:18 -0400
Received: from mircea-Latitude-E6540.analog.com ([10.50.1.102]) by
 zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id w6KF4GkG023487;      Fri, 20 Jul
 2018 11:04:16 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <peda@axentia.se>
CC:     <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
        <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V5 2/2] =?UTF-8?q?mux:=20adgs1408:=20new=20driver=20for=20Ana?= =?UTF-8?q?log=20Devices=20ADGS1408/1409=20mux=20=E2=80=A6?=
Date:   Fri, 20 Jul 2018 18:04:14 +0300
Message-ID: <20180720150414.2993-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(54534003)(4326008)(305945005)(1076002)(476003)(336012)(6916009)(50466002)(36756003)(7636002)(2616005)(106002)(72206003)(106466001)(44832011)(14444005)(186003)(2351001)(8936002)(7696005)(478600001)(5820100001)(426003)(316002)(23676004)(53416004)(47776003)(126002)(246002)(5660300001)(54906003)(2906002)(86362001)(26005)(486006)(77096007)(50226002)(356003)(107886003)(2870700001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD008;1:x5mwJUwqlsbgBrZOj80JPSFRnn9UmDxW3UaYnTAqmCK4CheGyMKLqCNINDqoNVHWFXwApZ0u5jthHrfOezQJlI8PkNuaCWcmuZAg+BVFcVKNp2G4/2slaHiS/gQO2ZEG
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 805b5c47-dd2c-4d00-7dd2-08d5ee5211c1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL2PR03MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;3:g4X/26FCoVjca/gFSRyjsQgsN3LBcBAU2RxE4y2I18utM6LSA74f4W2hEI8tPWoY/lViRL4/t8RydjGBrpT0RpvDg/nhOHrVmgHGeZSfBiIvzRUCxEwhPH+rWIfhqc8FIDUy2Ylzot3UB400Xy7Vk4eNzdcfNIOFlwZPTvDhdksnByQD+b7xz26iHOWFhJRPCwZmpoKcuFsWwKAhR/DmYukDVQGK+fkI1pEck9GEgq6d2ZdjzqWKMCfseh0oq0DRICohNVVOaLgCSGJ9OL2WX9/RPVY07zP4JUmaFq/YjTwHNCM9hRIQHtstdPTbLx4jjlNfXJ8WYv2oBClN7g9uPNmAjoHYD3T1mfUzpycmXcU=;25:xuzmevT4IEg3I04rm3JsFiLiNl/9BtCXQRRfaj27tbPMnYltqiGEfOzJtkghrEttMBTeP3SwVDYWAFSXNVG7lYcztgXpGbb98S5RA9CEhHrFrBTl8W8+6+LG2u5eyvuW1R/9BrU7rhesC7204Gjgu2a3oEiZKeD86Qv0fay84VzYYnodklcduRwrrhaoC3hvfS1l8EOOWLaGtnxKd6d/ngCIS/ArtIRs18ONtErxCuA7h4VMZfd1G/IedQOe0h6nJnJtbTRrkZ0fwlDEJOcyQ+ljXoPHae30397Bb5aIRHcynn/VIdsrAyhBzcqefGcLtWJCz0T232DgRiVHniViOw==
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;31:2orY7sOVMclFydbYkDegUqRH3mtiswr5ByOO6qFc5h14Yc/zFDk3/vFB1emOSi3JamiCGGt8xycl3SEsEY3DwSAygxp45OYjcWdS4lDqXv23S5FCcUeIiSBVTX+8TxA8vQ9nCFnyQmMTRlZz5QWcziLc5zLe/jY6cVBg8xH0ws5qieNqQcuszDGq6TgB6XnPzndUgNFTW9grbr9NSvSb9pPc7cFXnxxUFBwb+qXHxTU=;20:9y6E4gJGTCE1xpwcBWgtVJsr73KA/bHpfNlIaSK2pgXToTrA5dmJSuDVBDRHdOeUgy30lejqWei9k1nTN8DYp9hE7aIUn2bh/9pNCWpxhS0CAtU9SUb/sKefkyCIzJSKV9hT3/dxCMXzuAjYgSm8WSE3jOKx7F6KA+rrEpyux6WJXwL5NHc8capsUzzKDK5jVY0bwMO5ddEoT9JbuZhFb7djkec5e3zvayiBqptyhyk0c3wL8y7uvyyQilrV9lQhs4ImGl10Qykl7Kl85U5VXSir1cv9PSk2mdYtuVY/YakcgdYnw94VLxifasWPvrOzskp3+W+6rHueq1tJmuQ+nyDFx2hq4r3Q8Mpo+m8dQjYEib3bssOAs2kEVVd5PPY2ABF1TIZYyfbadGSeQl1xFMcuL9wsofp+C1WOao06gE19z6dGrckOJDjPIBPwtYcGzM3TH311fW/flH/VlEm0egfKGOAAVQMFSjr2noZKmmR7d1nF2m8iMWhrWhEjtptp
X-Microsoft-Antispam-PRVS: <BL2PR03MB5458B1D4100893FCD63680D81510@BL2PR03MB545.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL2PR03MB545;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;4:cRZflb/PwNSsGeElVJ8ftikmXaW4/MCEDhePHQIhKQWOuAI4OegtlJk0LCUA+SxKHwBh6/5vXta+3XyxAOJCwVnPxxDF9lZKN4pYlLBljiQZt1O/54Q8yRPP8v7ARMGiaRX08Me5f51voVDP/ChTR9/yfv8OdadF1569xcDujq54XobN5CKUU/aAg5e8db/m4QwwYDivmckwqrNkBBuXeol2JA5wmGu58vxodpxJ0KpQ5uBEG/mGMsk0XdC/Gv67FMh/2yPXboiocV5MHh+xafpyd16cqhaD96JB/QrZ+HsB5idDpvnfQdqN0Dq/5kX6
X-Forefront-PRVS: 073966E86B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAzTUI1NDU7MjM6Qmh2eVRQSzJ6c0VGM0szL0J4bHVWUkdEcDFI?=
 =?utf-8?B?ekNaaytVRGJtS25SSkwyVmJXbXRZaFNJYkNaWXovaFBEbGt4M2Z4dGFxcWZV?=
 =?utf-8?B?NTlMK2FHczlXMHVESllDendRU3dpTXEwNGY0QTFSUEhlYkNXc2psWjVLUVcz?=
 =?utf-8?B?cXp4a2R4ZWNRK3hqai9BUVVWYVlOditST1pxWVdIRktjUjRVVTVudkZxTVlZ?=
 =?utf-8?B?d1ZqOE4xTUkzdDJWMGtPblk5azlHbkQ5ZWcrcEFPVGJ2OXFDVmRjVncreUZX?=
 =?utf-8?B?S0xHZmM5ek9KanZiM0FpMUtCamdScGJhbWRzTVlyVVhCV1lKRVlCY0xDYi9N?=
 =?utf-8?B?YkRhSGFDWXU1UGUyY3FJZzdHQjF1WVFqZi9HMlJudUZMOGJMV1BOVkhPTEVO?=
 =?utf-8?B?YThRa1RCWTVHaUJsQlpQdUNGc2lJaEV1YmRETEhBai9GQ2NJTlpxZ0hUNktH?=
 =?utf-8?B?bmpkckxMUWhyK1pGUldzaHZIQTVQMGdLTkRseXZyTnU2SGhDZXN6a0hkMkNF?=
 =?utf-8?B?UFR3RUZYTUtNYlVGeEk2Mys4aWtlbnlSUVlrcEFScW4wemQ0VklpOWpENjNl?=
 =?utf-8?B?OTFxTlJjdnB4bklXNGR6TGtFa0R0cWRra2MvY2twMmxnZUlqRDJtZ1poRXRK?=
 =?utf-8?B?aTJHSHEvbjhJUUhLVjNRVm9vbTFwNlgrcENHU3VPZGZDcWVKWVA2bjZYcE9w?=
 =?utf-8?B?LzNoQ1d3aGtqYVY0TThzS3prZzNHTGRYbm93aWdLSnh3bzg3ODhrNVBSZTlw?=
 =?utf-8?B?WUtnZE1FWS9QRnpTTjFXTnlwMGFxOVhaTDI2Mitnb3BQTXdUSVhNUDZyUml3?=
 =?utf-8?B?Ly9hV204L2VGRjhsQnJ3Z2hzSU5xNXVwSVJMSG1wdTJNV0l6dXRsNnBUcmUw?=
 =?utf-8?B?Q2k2bzZYNFM1aS9qbElNNkJYRi9udWlMbk94RWhyWVYzYWFOcnN5bHBwMjFW?=
 =?utf-8?B?RkFPT25zbzNzYzN0ektDM3pobXRsbUdBQVQ0NjJNU3UzTy9jME9DeWo1U2la?=
 =?utf-8?B?ZUdHMkJKNTlLUmt3SWM4VGJTQUdZcXk5L3pKS3o0a0QxQVoxM1k3bXBoMDVx?=
 =?utf-8?B?VTdmSU5NbWRJbGRRaDBYRTloY0N1TlVCYUtsbHh3VE8xSUl2Q1NsVGpIa1Nx?=
 =?utf-8?B?aUc0V1BRcnV0WTNOQ01lWDVzNFZVdXNiMTF1R1FFUldDckNDK2NWWENuU0U3?=
 =?utf-8?B?NjdQTXhEWjJRT2ZEQlRJb1hwaGV0S0lvc3B4cC9yVFBnVzFRTTdvWlp1UzY3?=
 =?utf-8?B?UEZza1dpdEtmYzVCeTRXK01YUnduVEdaeEpDL0czYnpXTHhSd3dUeUtySkgx?=
 =?utf-8?B?ck9EQVNyQnEraDNtMDhmRUE2VkFHSzVzd2FMK2hyS0dLaVBzZlZvQzNvcjk0?=
 =?utf-8?B?Y1dycHNHeXd1WklqUC9nYmtnRmE5ZGNEcTU2Q3BnajhDT1BtTjhTcm1RVzlY?=
 =?utf-8?B?dDZ1NjlqNkV5dnBYOC9BaFBLRlc1czlxTHRXTkZISDk1VWV0RzZKSlZSNlU1?=
 =?utf-8?B?cnl3PT0=?=
X-Microsoft-Antispam-Message-Info: IKYwBwcn6Qi3pBL9wP3vf7D/8OjmI3f/Jm9up58wh6i3KpOWc7g1O0qxV3x1vPofaOXWqiJHuq+nfCWVbwJJM21uNwkTMI9RyUO6WjiulZFk14qaJCdoSFtlRTP+kJOv4vLYC3ROjUkBAWHEYFEd2fFLf8+sCmPI6M9am/jX9C3CnrvAev2x95+jFr57RDQfA0jLJUTanMWJHJIaPvcDGp8BdO4IuDqN5ehQFaGUIaVXdT9lRD1MgFAJJK/XFtT9mT1uruee0lvXajVKOw7BvYWZzJemWRfjoxYp5DPbYVEosu51BiIHpQ6V5CaOOUTDeZd2pnxG/g4kvb1nw6x9EmhMsMV+HnxOoXAXZkjC1V8=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;6:gAExT7gFd9xRv/ZfJHpOgYRwijmo5QIEwoe2qC0vTYVdP0pVJQTGgiOTqttBsTUBGfdqYisAgsNflIQhCxV1p5pqFGntaw4wE3ugcmRE7c4DfsCmMAv8I1Pc5tCBPqaAh1eF1z99ra0iHzZJXatCzHqHTHlGcyPvfcg13wIzGgEsMhZjwHkqvi6KeGwfYXmCaS/scNKRFLcP48CusT6cCGQ0M8zvFFeCtHNpzQeqyw/3xXhnoWgBz5hh3/GUjXc9lSoTYPesUhblE3ZWY9gxkxra6JNIyUA6WdpaDKtUvnIlyJg2kjpGBOXAJL1exjoj08xwU6LRjy7Rk3yOp8AXyrQsyud2uUtF+yiEU+Lme6dOMTryDeJKw4cQVDqdZ7igg8tADvVxlFEKfr5DXFhpx8WAursGNqI2VjMUOCnoG4qgT3fGi0heWb093VA0BhrqOhA08XiC8u9QL1tCPCUIcg==;5:BeMZk8ifi/EJOAqZmXhWq++HAqpimeVQYsQsVbERa8BFFoCLi2ddMTJbhPnd4HvQ2/SXveoZTu2c4Pup9X2CiQ+JxV3/o9NXxTUGhJ8s1Z3VsrPtsRu6m8SvGZ74yiGiNhJsKBnO3Zsyi6bli9xzs4YhKGv20CCnD6i4u2Fuams=;7:kY5rQQZBSS4kwx5qDtqT45v2I46+1wUZUuS56BrSQZek5Wu78YJZbzEG63OCj8cF7QY5EAo6nyzQUr57tuHJ3JQwcEyfrRkgDbbQ0M4R0mP9XQegQbyKqvCsmVHhuw7hM0VchSDSJkNpFbA1RuQ5HkqPoVq+aiD4kMZtLc8ta6c8a/vbAdG+aP5SOXRClCses/SfrCLdTH8Byyvj7niDyonUgJRxCooAAS1Rgl0LD/qXRo61+5NFv9bvWbRyHEDy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 15:04:19.2446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805b5c47-dd2c-4d00-7dd2-08d5ee5211c1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
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
Changelog V4 -> V5
- defined idle_state as s32 and used (u32 *) cast
- replaced device_property_read_u32_array with device_property_read_u32

 drivers/mux/Kconfig    |  10 ++++
 drivers/mux/Makefile   |   2 +
 drivers/mux/adgs1408.c | 131 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/mux/adgs1408.c

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index 6241678e99af..7659d6c5f718 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -21,6 +21,16 @@ config MUX_ADG792A
 	  To compile the driver as a module, choose M here: the module will
 	  be called mux-adg792a.
 
+config MUX_ADGS1408
+	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
+	depends on SPI
+	help
+	  ADGS1408 8:1 multiplexer and ADGS1409 double 4:1 multiplexer
+	  switches.
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
index 000000000000..0f7cf54e3234
--- /dev/null
+++ b/drivers/mux/adgs1408.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ADGS1408/ADGS1409 SPI MUX driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mux/driver.h>
+#include <linux/of_platform.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+
+#define ADGS1408_SW_DATA       (0x01)
+#define ADGS1408_REG_READ(reg) ((reg) | 0x80)
+#define ADGS1408_DISABLE       (0x00)
+#define ADGS1408_MUX(state)    (((state) << 1) | 1)
+
+enum adgs1408_chip_id {
+	ADGS1408 = 1,
+	ADGS1409,
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
+	struct device *dev = &spi->dev;
+	enum adgs1408_chip_id chip_id;
+	struct mux_chip *mux_chip;
+	struct mux_control *mux;
+	s32 idle_state;
+	int ret;
+
+	chip_id = (enum adgs1408_chip_id)of_device_get_match_data(dev);
+	if (!chip_id)
+		chip_id = spi_get_device_id(spi)->driver_data;
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
+	ret = device_property_read_u32(dev, "idle-state", (u32 *)&idle_state);
+	if (ret < 0)
+		idle_state = MUX_IDLE_AS_IS;
+
+	mux = mux_chip->mux;
+
+	if (chip_id == ADGS1408)
+		mux->states = 8;
+	else
+		mux->states = 4;
+
+	switch (idle_state) {
+	case MUX_IDLE_DISCONNECT:
+	case MUX_IDLE_AS_IS:
+	case 0 ... 7:
+		/* adgs1409 supports only 4 states */
+		if (idle_state < mux->states) {
+			mux->idle_state = idle_state;
+			break;
+		}
+		/* fall through */
+	default:
+		dev_err(dev, "invalid idle-state %d\n", idle_state);
+		return -EINVAL;
+	}
+
+	return devm_mux_chip_register(dev, mux_chip);
+}
+
+static const struct spi_device_id adgs1408_spi_id[] = {
+	{ "adgs1408", ADGS1408 },
+	{ "adgs1409", ADGS1409 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adgs1408_spi_id);
+
+static const struct of_device_id adgs1408_of_match[] = {
+	{ .compatible = "adi,adgs1408", .data = (void *)ADGS1408, },
+	{ .compatible = "adi,adgs1409", .data = (void *)ADGS1409, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adgs1408_of_match);
+
+static struct spi_driver adgs1408_driver = {
+	.driver = {
+		.name = "adgs1408",
+		.of_match_table = of_match_ptr(adgs1408_of_match),
+	},
+	.probe = adgs1408_probe,
+	.id_table = adgs1408_spi_id,
+};
+module_spi_driver(adgs1408_driver);
+
+MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADGS1408 MUX driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

