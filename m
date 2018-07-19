Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67264C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0861C20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TN8w0Bzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0861C20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbeGSLat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:30:49 -0400
Received: from mail-eopbgr680050.outbound.protection.outlook.com ([40.107.68.50]:46078
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbeGSLas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/En1N1WGZj9jmujTSjqSdiXJgKJEVCIvHnHxFF6JKI=;
 b=TN8w0BzoNQ0qs5evUa79Wfq0kMZ1DGdOCfhgQQtNZzJN+W/ZXiTp3sqdqHZJecAKyBDO5zgdTaznPQ/URBANhC7GvBTWevTZbQdPv7mGKEmoTUq9obRMn2SMJD9vxpzFHp4P9hNalrCcI3cOLPiCmLuyvvHBxeghSXNneFwgptg=
Received: from BYAPR02CA0010.namprd02.prod.outlook.com (2603:10b6:a02:ee::23)
 by BY2PR02MB1623.namprd02.prod.outlook.com (2a01:111:e400:5267::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Thu, 19 Jul
 2018 10:48:10 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BYAPR02CA0010.outlook.office365.com
 (2603:10b6:a02:ee::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 10:48:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Thu, 19 Jul 2018 10:48:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36701 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fg6Tf-0000Kk-F5; Thu, 19 Jul 2018 03:48:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fg6Ta-000228-Bu; Thu, 19 Jul 2018 03:48:02 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6JAlsOJ001673;
        Thu, 19 Jul 2018 03:47:55 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fg6TS-0001zF-JI; Thu, 19 Jul 2018 03:47:54 -0700
Subject: Re: [PATCH v2] firmware/psci: add support for SYSTEM_RESET2
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Will Wong <WILLW@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
 <1525257003-8608-1-git-send-email-sudeep.holla@arm.com>
 <34a420e1-9d2a-b838-dce2-71de408043da@xilinx.com>
 <3e7235c7-d2c2-29f6-6bec-ae21cb841731@arm.com>
 <0fce3ee6-873e-154f-b61e-546d9da338df@xilinx.com>
 <8b08583c-121f-347a-700a-17b5d7784309@arm.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d2eaaf6d-01f9-2daa-ea1f-3396e3b93104@xilinx.com>
Date:   Thu, 19 Jul 2018 12:47:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8b08583c-121f-347a-700a-17b5d7784309@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(438002)(3190300001)(189003)(199004)(65956001)(65826007)(5660300001)(76176011)(39060400002)(63266004)(478600001)(6666003)(6246003)(106466001)(2486003)(23676004)(31686004)(93886005)(53546011)(65806001)(47776003)(36756003)(4326008)(230700001)(81166006)(36386004)(305945005)(8936002)(336012)(31696002)(64126003)(486006)(9786002)(50466002)(106002)(11346002)(426003)(2616005)(2906002)(44832011)(126002)(8676002)(14444005)(229853002)(110136005)(54906003)(77096007)(446003)(58126008)(476003)(26005)(316002)(81156014)(356003)(186003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1623;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT061;1:34g/F5V1lsZc+PhDdlBsZmTcSP7OoIwyBVx5NDdS5y9XdYc8udN+tudYcfctGbep5UskmTSsyw9Ix8UwN4g1C8AGlHK6HnBpyWNZgCn6HNnJBS5Jk49hYqmpxT6KmqgY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8495193-b7dd-4efd-5af5-08d5ed651d42
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR02MB1623;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1623;3:ed/ZhvmnkH64SP9HMBdXcQ+yidzNOkfEXZB14DjcdxK4Tge1aiDoZH+IgdqTIjAzUaa7F23htN/LKObUAFFXkAt9QUQ/8OEAFHsDOEt59ohKqI3jHbHf0QALq37TTHMTLkfpRo8Ewq09jtAgzsPnWlTg54W9Tgo+f47Q3VsduVKKpc4OOB9TjEvsNiRWMQLMkzsjZKAQY0GeNESrNbQWedviAaL4/chtinbeoRQhmgLw0eulfddlUdX8tNdysogKmF9yTxvZV86YyeTIQPI4pKSAr59m0fKH7mD0P8A4kCNWFvmEJKH62HsI5fKoLDHb3Eu2VdE099oLeYqJhV4M2c4CUkTxCCILO/81QHqxZUs=;25:E+dFbTuErykZzr2Hkl37Ef8JyU55CXztKYpYW2bSoJXga/axku/73ghynafJfI5LeBTsx6mrxOH8XBMF7WUIxfBsXd0isaKoVNjP4Vqu4oQl/iCoPRdooWrWiY4LaeOISmJb2qzUDj4SqtssuTQoG7jaqY/FxqJsmduDYniMBajk+Vsut2FNc8zFSGP1VOV7eSmBS+r1f5yeA8WipeLoBI2CQcnmdpWtNAwfJBEwrsJZCx2g/u2tmJU0cYJot+k9w63P+w8UZTs+ARbnygz7Zwju2UT6iTdMK9yuMsiLsGMZN08hC8wflcQP6gu2r4vEYesEGRlVUyGiicez0GFqij1Te64g8mBg3n9UDYOyYnA=
X-MS-TrafficTypeDiagnostic: BY2PR02MB1623:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1623;31:keOwEDkla9kzp6RaWCaNJCgrFk9HIIpYuvDc5QUPiBEb7DUujM+t2GevL0KevJA9jtTg5RQZ/X1YxMAWt1B3BbcwSzedp2fPe6x3U41bfL5OB9XBxHfTr6qm+TKFuS1GTsj5TgkueI4U6thRyFNPltTEvFywIe+3QWVTs10RzLE4qpIzFZLuwZRcucA4pYYJTPhiW233RX8LAw41CVRK8d16W77Y5+5HAceQKERpQQ8=;20:Wa35UHgFU84kr1JxR6L+7EdaH1reBjfyWRFhl7zXuNa3I/0nWFDMQc+vTE+8ISFb0httamVTlKoZGIqkDTwVibHiHD50q6rfzv58G593mH9ubGJOxYU+jE1F6+31mr5K/WGmSjuwQaVXT71DNAHHzJWcgOCZ5MEsWnzdxzv8OV3c/i0GRyEEBZy67BhZkzngdNRoL5RHUFtsexUu5f635/uxdkw0nChaMizgfV9gbOMTM6HpASzt4HqE0LoxfXOG4ZGFIEICSJBZu925Lxela7NWluDsDRZGOQ7lRF02Z9xTCiHPhWPIo3t1M5MVEd0ghiUR1fw2xaDMUZlk/aKO5FVzH9UhzSpJhtHeowCQtE5hVTT03xVxJ2PsRYhG3pNpxI7LnOZXElf7Y45zTzLtFJUs/CS7M6s35m+cbCkF7t/nx+0yj0ktTZziBwc1pf4kUie1asKVOwL946/oRUS/3IzSrm/TdPqhFpdT/BJ0KpWf3s3ROGBsDsJAIRJbEL4P
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB162306EFF510A5CD4576A38AC6520@BY2PR02MB1623.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB1623;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1623;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1623;4:re4+3a/xpCgQ09+VPjZfDi645W8JARb1j4daZZNRhj5R3EmSpbD+HjQv09IPvr1Y3ntAUIxbXNwaz+Pbg+Kcbos6N8l6hWboNBbYDitYlj3lF7MsJRIucarI+ugHlGkglpD1k7NkOIjZGhlaH7vECa0KmnOVhpnZ0OXgxBz69xaaSJpGcgOgHVUiagO29x1rkImkeuI2frNslr8++7WXayfBZSCK9oAg3HKii/UvfNgy2YoEUMD8YC9K/8EyfHZc4QY7XMfSO01ip/irAhwoEu2ldxTKCHhwlaUpjhQuceBcFGbra/Bq3YKHASvhqH8M
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyTUIxNjIzOzIzOjM4ZDNvcGN6WFIvbkNMZWt4aitYMUpzdmU5?=
 =?utf-8?B?YXhhOVFJOGVjeXhMQ0pWa0dCRTNQblBwSUhiL05ib1BES2Y2cnIraDMxR1RL?=
 =?utf-8?B?bnl4bFUyYmtZYmxsSDJORFljSHR1cWJWR3JMZjA1Q3RVUzNwRmZ5bmpQS2Ur?=
 =?utf-8?B?WGZIbFgxSGdpUC8wQmY5Zm5JRkk3MEhGWHN4M3gwNHhZT0NkNStjQ3ZIaWNV?=
 =?utf-8?B?ZlpSc0RqOHRrcUhYMEJiYWZVbkFXOUdneEpzeWcrRVA3OHV5YkxhQXdGT2NP?=
 =?utf-8?B?ek15WmlRdzg5ckNaVHhoTWVUekRUZ3h1clpHZmRNLy9jMW5EYjNPdjdFOGhr?=
 =?utf-8?B?L0VncGdEbng3a0dPUm1sN043Q1pPTVdISG4vSHBoVytEajBBdWdaSDV4eHFs?=
 =?utf-8?B?TCtHZmhKaFpwYXNza25KSGNmL1BTcjF3OTBtSkhaZ1E4bDdpaVZFa3E3OFg4?=
 =?utf-8?B?V0cvc0RtQWQ4am9TQXFZSEY0MmVGN3NWcW8rYmZrdlcwR0d0VDRlNjBxVDV6?=
 =?utf-8?B?MWhNWWN4OTB0WGZtTHR4KzEwNDFlNmNJQkNaR0lnK1JQeFozWXpEelNYMk1p?=
 =?utf-8?B?K1BuOUZlK3Y3OHpudGs5MHM2dXIvdDY4aWN3WGlrU2l5MWh3VERFd0EwekdD?=
 =?utf-8?B?ZnIzdUdXZXY5dWMxNW1CK1B5L1VSSU5uN2t6Tm0xRFJ4azJIbjhZWGNmSkhZ?=
 =?utf-8?B?d3Y0TTRoekRDKzNQdmNyRzladVh2em9QTEJpM1Y2QTlWYlFRQzNHL0Y2UVc3?=
 =?utf-8?B?OGMrMGdvbGR4djByZm5la2RtQjBVQk9TWUdxWFpHRXBoMkJhL3J5MFB1Vzdr?=
 =?utf-8?B?SEtRRTJjSFBIM25QU3E0N0RreEZtS2lGQW9aai82Qk1BR1phRnFpZW5MekRL?=
 =?utf-8?B?Z2g0OFAwdlZjOStKdExRd2tGZDNYYWdSeW9Ja0dQNzZuQjkxMDdIWHBJVmFy?=
 =?utf-8?B?VCsvYm42NGZsR1N6LytjLzVRcjlhWGJQSkNnMW9rOGxINU5xQmR5bGxQbjJG?=
 =?utf-8?B?K2EwWFJaY3hYUU5FNjR6MDFJUTJpaXR3MG1zK282b2h0MnkrUXpwNnNZZjVK?=
 =?utf-8?B?YW56M1ZHSnNpanlySlEwS2ErQlBZTEU0U1hNNEVReVVRaWpBN3QxdDFIVUVw?=
 =?utf-8?B?aEpLeUh6YkhvQVFmQnRST3ZzeUVNbzQ1L0FSd0g0OXpiUkFibFBtNzE2WFZ1?=
 =?utf-8?B?bEFKWVo3MTJYSHMxZEY5Y0tlTFZrRUh6TmhzNjh3RGJhY0d6dXVMTlBRbDFT?=
 =?utf-8?B?R2l1dUI0VDZ6L0pMQmRoOVhWN2FEcnBVbDFOancrK1QzYU9nWVc0c090ZXBD?=
 =?utf-8?B?K2tmUnNLV01DL3ZQVCt2enhNdnNoR1hwdGRlVXFjdVVKSVhjUzRONjdiQlBz?=
 =?utf-8?B?MXNTSTJVem1vTHV5RXVYZFY0TjlraHA0Zk1NYkF5RU1rZ2RwU0Z5WFQvcUFq?=
 =?utf-8?B?UjZ0YU40NHpSSzA0Z1hpWXZ6Q1Zud25QOG02MUh6L0ZRb3puYktua2V3bjRE?=
 =?utf-8?B?TFc0MnF3ZmpRTm5SS1A3by93clA3TDI1WEMvanNJK0w0elVjQSs5OXhoK1I1?=
 =?utf-8?B?NCtrMCtpU25Cbkh5a29PUGh3QTd0V25aN1p1YVRDRjUzVHZMWUVidi8xZnhU?=
 =?utf-8?B?S1RiUi9aaUZ3QnNOUktYM0ttN1BIc2FqSlJtU2xJT3A3K1RWWUJremlyQkdF?=
 =?utf-8?B?V2h2SWcvcW9uNWo5SXBuZU1IbG9xYWVQZ0xpbTdqQkZQOWVqRFpaNFEydWc3?=
 =?utf-8?B?cHJrRVZUWE42ekZoam02cHFMa2N0TTdwc09KUUlnWkhzRE1mUW1FOUI3VDJW?=
 =?utf-8?B?amxKdUpPUnhFSFZweG1KQm9nMUpmLzNRRVlsYlhBV09mREhIVU5QbGVVUGVU?=
 =?utf-8?Q?Na0PRWg3TCPduRcv02EfFgwu6gvhKSJ3?=
X-Microsoft-Antispam-Message-Info: OtJKINcCsITDi0w5g2kwc3JU0iKnPu9L/kVJCWgaWXkv0a2QTIs9GxhnF9FoyI7uv4shUoyMEUPf40q8sGuxYycAHU6Lph5KwG5RAMsUhui4iHVlFh4lf/jLcI6YSR2dDcqSgPuFcKDdMUTxTPH3okxfFai3jmIzRii2Zbckl8cFZVlOb3tmdGFIkYpuwcWkNAFcSX14ZDxDFMTjYphvp/Nd70bPJV8RQ86pY7WjBhYsMmM2r4besYGKOvD/19Vfv4Mxx08/E2K3tLRoa191b1f3wvyW3rPVDrPwH/Z+sb14msSlt3PH9sUlBbQxjHPzz64/rgUR82+0cEXGqqQ4Pk/V1Wt9f5To1/LMT8tP/Yo=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1623;6:PlsClE+MRmKAjYwuYsAymUTRt3bQhcXIUvcrSb/wA6MD9KrP1DNti82X3p9eo0BoERONaFN5CwXA7K2mjrFg0vsxG1lUPrJUT2JEfplvPc5VddumPIsy6YyCSvhF8vKhUbG5lhz9idClAQAEtH7NgRYPGl/uHBYQgE5aawUTB5RAWM2l1QyhyG+czSBkV2Mq93KjFZG/87HZXV806fyZSF7OuwPn276D0QruRqjNn+Tb2odMPfZodoT92OuQRcKMWapEGNNyvOtWHt2jZgpBylYZI4NoLHOyMjp0AdvxQ9bWbJoAJYeewpMfbQ2Py0biXkJ/GiW/crWVwC8cgUbp9t4eubVgod3P+A7zKSDHUyiBDpIjxVhVqqgSKvlyXuiIDJplMeKqQ+NGp6O/jDuOeLE8Q2G2vxSUJuj0Us4pUS4bLD1cQuBHdBkPQ560rH4+2Xb5ZsNOYPXnUSLKdtgzcQ==;5:NUquueB/ggH9MyHLLlQs1LYCbcTpEa1TZREjXnHwb/sBTUcFkK+b+drBmj0OBupn+FqSnkmMaxnA+L1rLxfQk3PjmI1VZtj7zmf/UHxvMqmuyrfsvOxjKFsnrw3kwcyPCPP1XG3uESS/9UtrEUwaCZ5Ek12/t3dY/bT5PSask6k=;24:UbPZ1zMrc7bKcaDkVg3vQ//Y6TACwAy4Obpk3I+icVmE4Ebq1Yghw+081qbZ7FZCs4AIoJ1Eg3DuvSeg+ntAfoE1CYJj5SXqCwrBRO4F7g0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1623;7:x3F2Z7EVkNa1IDzl2Kxpa+QoQmWI7xJXcj2/9zkv1kHrYfnGiNFq2AKmw6U/chvF5rkm9OiY3mRqGUFiM6YYhw9btDLO62FWN/cQRgP1Vm34PTbt/mOftqkjEh6MewuV/7jEuJnY1AsPQXbF4UwU6Zonlt7aevP5/+6RMDCB0drunv6Mv2T7bXRDLcr6auTHjk5skWO/5N+mbbQ/kZqh5FDdYESZLzA6VoARotztPpp1gedzWSuQvuAhz5TfLaqx
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:48:07.8348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8495193-b7dd-4efd-5af5-08d5ed651d42
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.7.2018 15:21, Sudeep Holla wrote:
> 
> 
> On 09/07/18 14:13, Michal Simek wrote:
>> On 9.7.2018 14:36, Sudeep Holla wrote:
>>>
>>>
>>> On 09/07/18 13:17, Michal Simek wrote:
>>>> Hi Sudeep,
>>>>
>>>> On 2.5.2018 12:30, Sudeep Holla wrote:
>>>>> PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
>>>>> where the semantics are described by the PSCI specification itself as
>>>>> well as vendor-specific resets. Currently only system warm reset
>>>>> semantics is defined as part of architectural resets by the specification.
>>>>>
>>>>> This patch implements support for SYSTEM_RESET2 by making using of
>>>>> reboot_mode passed by the reboot infrastructure in the kernel.
>>>>>
>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>>> ---
>>>>>  drivers/firmware/psci.c   | 21 +++++++++++++++++++++
>>>>>  include/uapi/linux/psci.h |  2 ++
>>>>>  2 files changed, 23 insertions(+)
>>>>>
>>>>> v1->v2:
>>>>> 	- Added mising static anotation to psci_system_reset2_supported
>>>>> 	- Added missing ')' in the comment
>>>>>
>>>>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>>>>> index c80ec1d03274..91748725534e 100644
>>>>> --- a/drivers/firmware/psci.c
>>>>> +++ b/drivers/firmware/psci.c
>>>>> @@ -88,6 +88,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
>>>>>  				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
>>>>>
>>>>>  static u32 psci_cpu_suspend_feature;
>>>>> +static bool psci_system_reset2_supported;
>>>>>
>>>>>  static inline bool psci_has_ext_power_state(void)
>>>>>  {
>>>>> @@ -253,6 +254,15 @@ static int get_set_conduit_method(struct device_node *np)
>>>>>
>>>>>  static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
>>>>>  {
>>>>> +	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>>>>
>>>> I am curious about this reboot_mode setup. I have grepped the kernel and
>>>> reboot_mode is setup via kernel parameters at boot time.
>>>> Shouldn't user decide what reboot type wants to do?
>>>>
>>>
>>> I have almost forgotten how I tested this. IIRC and looking quickly @
>>> kernel/reboot.c and __setup(reboot=,...), I recall passing reboot=w
>>> while testing this.
>>
>> I would expect that too. It means static setting at boot time.
>>
>>> We can do something like what efi_reboot, but not
>>> sure if we need that yet if users need too decide after boot.
>>
>>
>> I am checking with colleague about all xilinx use cases but I would be
>> surprised if static configuration at run time is enough.
>>
>> Also not quite sure about mixing reboot_warm and reboot_soft cases
>> together. They shouldn't be the same.
>>
>> Based on psci 1.0 spec there are more options especially for bit[31]
>> which should be likely setup via DT(no experience with EFI) with names
>> and codes which should be passed to firmware but still the same issue
>> remains how to setup reboot type.
>>
> 
> I think with efi_reboot, if user execute the command "reboot warm", it
> will set REBOOT_WARM. I was thinking something similar for psci too. I
> can drop REBOOT_SOFT if that's not correct.

Have you found more details about efi_reboot and passing information in
case of reboot warm?

Thanks,
Michal
