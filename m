Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB4FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C297E21735
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="nrCjxvVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C297E21735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934890AbeF1MON (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:14:13 -0400
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:55104
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933830AbeF1MOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9prDMX7Z08ZeyhJ53MpJyxjMWzirrtns4PV1J8ENsfU=;
 b=nrCjxvVX5rR5vRCm5tpSrCtgYUGkllDMzsvoEj6QmLzXaHbp60erchde7qcDCT4+r6MG7s5NoeDdRIktaTLwjNXT3WPmlOIarowjE9lnEZTjn+PqN8yc4YY1c2a/mFkb7wiXyYr5N2G+bTWy62GmVQTOqxwFXfu64/59IiVWT3k=
Received: from DM6PR03CA0013.namprd03.prod.outlook.com (2603:10b6:5:40::26) by
 CY4PR03MB3126.namprd03.prod.outlook.com (2603:10b6:910:53::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Thu, 28 Jun 2018 12:14:06 +0000
Received: from BL2FFO11FD014.protection.gbl (2a01:111:f400:7c09::156) by
 DM6PR03CA0013.outlook.office365.com (2603:10b6:5:40::26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.863.16 via Frontend Transport; Thu, 28 Jun 2018 12:14:06 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2FFO11FD014.mail.protection.outlook.com (10.173.160.222) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.820.5 via Frontend Transport; Thu, 28 Jun 2018 12:14:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w5SCE3TP006635
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 28 Jun 2018 05:14:04 -0700
Received: from linux.analog.com (10.50.1.113) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 28 Jun 2018
 08:14:02 -0400
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
Subject: [PATCH v3 1/2] iio: dac: Add AD5758 support
Date:   Thu, 28 Jun 2018 15:13:32 +0300
Message-ID: <1530188012-28253-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(2980300002)(438002)(199004)(189003)(36756003)(575784001)(2906002)(126002)(476003)(8676002)(107886003)(2616005)(2870700001)(50466002)(486006)(7636002)(4326008)(426003)(356003)(305945005)(53416004)(106466001)(39060400002)(246002)(72206003)(54906003)(106002)(5660300001)(44832011)(47776003)(6666003)(8936002)(50226002)(316002)(110136005)(7416002)(5820100001)(186003)(6306002)(77096007)(966005)(2201001)(26005)(478600001)(1720100001)(23676004)(14444005)(336012)(7696005)(19627235001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB3126;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD014;1:BkpzKz2yk1SOJ+atsins3BQwrS5gSWlMqUGKZRD4b98K2uxOVa+2nWRZvHKohCQw8P1Lvbhmu9j2IhR2aR2Oc9KiZQIty+V1vaTg99zfuoCVSG2pT8+MhjZiuaeCJ/Sy
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f6ab282-0829-4161-1b1b-08d5dcf0a46a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR03MB3126;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3126;3:4tpPy/NqslmByjUVwvWjmQ2XjKzMzsDs1nSMHTaE8Frv/R5n144f+XNME+gjO4E1BduZcYz9pB024/Xghbo/aWDattzP+a53fpm0fURgVIciHNyckYrkjP0x0Urb+9lOKDrC3igOjvo2OagKVouI4qVxjpYS9vBvwggT6hAwy7nP05gMgHvMrPlncPtYMGwczOSgOUnkQsQs1bZJR5gMiylay1hhQ4V/TC+ewXIg2t9OG3IWfDzzOEBeSMbpXuOj8AcAD6DUoAxz2cna+w2PKnK36IOnCK0MA5fJJaJtq+bFcIQ+leJPW7HjBtU76/cbvsA77ZcghhIT32kyg4CW+O0CZ4TjgOjClWLC0kMPiYs=;25:AXwYi5spWdarulxcrQJME1lpcX8dqaF2gXbtfaDGTdSA53vn+p4ycWOAnCXNGO0azZzUu9MimUIJKDk09NOpG9Hr6IKXwTaB/RsKPlFHlTz741nzsZNOCOQs//gHNWgCsepV4Puihuf2nitjKKl33DFPi4TtxjfbFV2Qz5ctGsO1/mQwvqkOH9FnRSb2yw4ok1q1hxv7+YpVgCF0DAyE3BWOYE5XbHZcH9P78Gi8sSGqITHP20K3Q9ODbC9HoLgu9QdgaPoI6GMX37JeTJVNl5IDYTcl5B+35MfhUKT2OgrWp+BaQeidqxC3OLUT1J4T6PYJTQze2KSb595Fa4nu7A==
X-MS-TrafficTypeDiagnostic: CY4PR03MB3126:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3126;31:CNB0HkQJoHknicIvGbUhvSFJ2HMHDIMlIpIE1t7QtVPjRU8SsybYifi9NKQxINgPhxdJ0SXOQXic418feaRVQMrIgfJybwW/QHiUA81WN6uYTW1WYZ7tTbtSKFjZTvEVM6jxKBpy04KLb7ciBa4uzJ5kzJQQNIIVrPPlT1wnTyMxXy3Mxs0GuUO8i3MrRJ5HqxTn+AIdBhgTw5hPpaF91zSaToONRFdvlEEWiNH4Fxw=;20:cPzcbYnaaau2Hcz1mcbTUuyYe0YFrg1y6CnO7hKel+hZDvNhsnvzmHWs4ilg+hXcSyz9xzpf612W7n6Ie4ebvX2Uoa9EidF7cG6yBy/3ReP06+jY6TyNblXSBkX3z6kEaZAqPpxncenyVIh8JAWL7ojRyTNJTThTfN37T7+MgeQlE6R0QKZQw2cmSS2/DN2d1RNUjpUIZLOCzpvtJSWDF6VVKhzvI4Day0lL+dPhuU+OVybKgByXJqTBcnfWeY/sfsBg98kctu65nqNomx9LA7rhNH20Db8eYbA4MLDvexiVQSbxudKgWnIbW/O8EahSstyImlv49BLY8xZrkO1VTpYGjg9ZGGEgAREcuy0ER2j4yIpB52nV4JXdknxF1pulis5KuZoMIKu5fsyRmYc5GlJR3zCYoI0Y+5r6x5RmERDoYIJ3kTJxR0FIY+JeLPczrezYaPB0nqXscMXAXJVU46WDRNXOLlPgDIukQT3ChxPRrfUfNOCKilODEdb8Kkz5
X-Microsoft-Antispam-PRVS: <CY4PR03MB312602CBAFA6ADB5387024AD9D4F0@CY4PR03MB3126.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR03MB3126;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB3126;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3126;4:aVGWRlqqROTa3zlKGcf8jvIwK4MYlAtc4C3Db/CURmw44SStrjhCGnldADMu1lsHcm+bbUwAo3nCWN99kk1GUlUAAAR5qxDp+n7rejxJbbRgbp5NyYdqw+vHtt36S0Gb0axiPL9dAXRlw+GJbaOjb629cj+Gorv/1BGO6rMRveUsyKvo4CbApWDYu8UlBu4Nf7F1crgIUI4H629ZiwePNbMkkTbMpbFB7JPXMlY/FZlCWchG0G+URxGX6TKxIqPBrV26UkaIoDAyARmxv5jL2y2pfdy1Lo7I9/8mghS06508psmG650/jiHZfRgmuil39qZ3L+IzNTh0Vcf9IRO8BY1/i7DNp3d2ROx3F0OQiQPRaNzo4qeFh4pQdwR4HXzfTYj4ZEqA3eLtq7iQSwifT9kYj7vxpe0lKTCPeWSrdLU=
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAzTUIzMTI2OzIzOmwrdXEycmJPaUxjeWttY3JwTnAxTUdUUEd0?=
 =?utf-8?B?a3gwd1djd2c4Z1RiZGFidjBHdi9UeXVEdnBZeU04S3ZNYTMvWEJ0MXQ0SDFJ?=
 =?utf-8?B?UUJ4Y1c5dUdGZzRObEhjOEVEeURzU0lBZUZDZzhkaGNGNHlMOXpnNzB6N1ox?=
 =?utf-8?B?MnZqa1RiRW0vcDhOSllIVUMrVzhCNkhDVDhnNC95eDcyWGpORm9wUkx0aGdX?=
 =?utf-8?B?NXNPazJTeWxsTk9oaWUzcEtkNzhYR2I1cHQ5djRtQzZueVB6VkhZbThBVkFX?=
 =?utf-8?B?TnJuU0JDRm9Ycm5kZEVhSGhGTGdKYm9zNllQcW90YmxwV3cwMGVUblFWM21I?=
 =?utf-8?B?YTNPTVU5RGw4aWZsVlhJSmJFNzJVdU9pZVVxZTdqeFEwVGhpSU9DdEhuVmNz?=
 =?utf-8?B?TFZXNGt4RWxRb3ltWU5BY0MyM3hEMjUvTmlDVE5PZTJMbGZWbXRkbmlpeUVk?=
 =?utf-8?B?d2Z3VEJ0Qng3TFZ3VnozNHZOeWduK1hXNUJpODhONkdZUmc0Y2VJTC9CNXNE?=
 =?utf-8?B?STg1TTdmZmZHLytwV28vUzNlUm5IRjI2bUV4ZTNPdzFwcHRhM3pjQ0E2OUNm?=
 =?utf-8?B?K2tXc2hlRDV6aTMvd1NYNHIzaUU2VzRaVTBIcW5sYWZYRStTN0RkM1VaTVNQ?=
 =?utf-8?B?MCtKZGNzbTN6NW9mbngzK0RGMzMycXl3c0svY3cxNFllK2NSREhnR1dOaGtq?=
 =?utf-8?B?U0VpWmxsNXNBb0J6Q01KUk1jMkhUbnZPNHNnYy9jSWgyQUVwa1FDZGY1SVYy?=
 =?utf-8?B?dThmK0FkOUluUjVNRUlEWnZ0VDVJNDM2Nnpwam1sM1NkUUVXMlM2RGh5UFNF?=
 =?utf-8?B?LzZKODZmWGFkdFduM3BZazVaS0MyWnJ5cDhnSEgrM3NmVDNOMmZiTStWZkIw?=
 =?utf-8?B?cWRzSUJjcFRaeG1SQzlEWGZ2c0RiVzZJY1c5MXZvbnArdTI4S3FVcjJEcURS?=
 =?utf-8?B?WGE5bzhSenE0MUlnM0dHY0FZRlBsdmowY3RmNGtYakxZL2xVUmxXbXc1OFhj?=
 =?utf-8?B?c1hTZVFWbzNFK1krZWxmaEcwZzlIYWdXZXlmK1JlRU84SGV2aEN3NC8wMlQ0?=
 =?utf-8?B?enkvVHNMcGxqK1k5R2ZsNGdQMHYvTHNBT2JSZEZtM1VWcldOcldaOWpoRmJ5?=
 =?utf-8?B?ZGFDamRwSWRZeDBWSjlxZjV3bTE4SGlWL3hHUEwxeXFyRVp3QjRjVDkyMUhU?=
 =?utf-8?B?WktVa25aQ2ZodC9Sc0x4ZHIraFltV1FsWjFwVlBYMG9qc0ZDWDBwNkFWT3kv?=
 =?utf-8?B?WjBXSzRwbkQ3T3Faa1JxMHlETkVpbWF1ZmNqanYxVmlVWHFLWFJtTHJJNisw?=
 =?utf-8?B?OStPYzdLNGsyMm9FaTJNOU5UTmUvTXljU09sdDMyWjVCSkRtY1JVWHN6ekdG?=
 =?utf-8?B?bjMvZjkwQWNTME00NWZjRkorZjFCRmJVcnRBUFpwbHVRekN4Z3R5Y0c5NEI5?=
 =?utf-8?B?L3NPREtSMXlVQktISTZIa2V3LzN0eGFKY1duakIvdVQxNlQrZnpJMEY5MTND?=
 =?utf-8?B?UHVrN0hKbVJBS1kyM29na1F0UjNRekIzaEVLSDQ4YmNSR1ZPNHB3dlJWMm9X?=
 =?utf-8?B?WHo2djBIQlhiVkNHek0zZndQeDQybTV2eU1wV2oyaHpWWnBMQ0RsWmQ5Nng2?=
 =?utf-8?B?OEtIWFQvUUlkMWoyQ0kzdm52MllZUW01ZytwZThRUHZ5UGxqZ1ZmK1pBPT0=?=
X-Microsoft-Antispam-Message-Info: GthqfUQRta1x6R70bAqQBVi2PRwJXmLTPSpM62l4hvYS5s8b/KwEoHfGOYwo5Lq9gFuqGAuk6KB5fzh3gh0lgSd+2L/NihGJubHvjHQQSkr8Ursd97VDCmj8EXSMJwpMnV0lPTttgpS+075vMfxRjueVuZ+q58gpcpmMF0TRadJsNz+yZbKtmj/9U90MgIj5ZN+ry9ySc+9+lY1lW0aGoCgOUf75ZR2+VRCCED1oymUU1ARwl0uSMTvUPhuNl63O2eirc5CJBh14MFP+RHNDz6f2t3dM+Qy99YG41FCC6BEUN7jKWMzqHbLkrNj2xHIRIWi9QcC1CKxJ6/9GlddOcsK0Ui9QReIxy+tSjyFOm/4=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3126;6:Eo76koAL/lRTdQDZk7K6D/fuDu02Qmnr3e54wvGdGzs4cokEj544M2qFBDsu82tT0RmSNlFgTKZO0rPZFApwFP8Ht5aavghj6K07NOZXBUbKwoUTqrkivJr3iHmocHcNXzdiscRugCCWLhzSa19peVeeKKYfb8lKZOP56ucZzJQo6x1LECTbokB7ZeQXr3YURoebwR3s36pAp7gWn+sG62Be13uZjEiUZgSuXmNZZD2xhqGp3GCfCmmW4NlJCdGgZBCC46Kc7ORjbEjFsiF6Ac5jLTDsZMun8CvTbGWi+MnNwyvrMshf4PstWB7NaIJYAbRRdpbZVbJmlrJrbM0gxVPZWxDMheOO5J4AuZUdYiYOjUX0FTTnQg4lFWRLcmUw9nXHPUrlSDriExyJDl+ff1wUa6apNRCNHQQ3ENO3H60bdrRqqLfY744fC5m8Vc030FFHBE3jbI/9KLyDqVYpRg==;5:1Mgd1SLbHBkYb5gQXxxbNzBFAA9Vt+SAIy8A9eaNaLe4Elg1v4sfzYVxF/o+ECRR1ImGptdYliBExUDvW4mFTaHrdnwtL9hngj3dsLljBUpCHehIBgIcIEHlnZeaK0+aWnvAPGpfx95XXbYbwxPjvnAqbN1wnY9VpWGaezayq7k=;24:68nz6/HMs/NBdAcKjLNfhAnxOdQS2KvUai278mCa0n+luganpdZ5zVPUYUEm88X+ncaD+d0YRgrZWd9zNUKqYpn5KYOyw9YM2ybRMI4t4/0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB3126;7:w/mg4LO3lNHBZyhfwGVtqBDftPsbxmoJMbGkIvaCzNXvfANq3qdJKXNYdUs9mxUZCQTav3ZSjfKE6qM7/zmy/pGUA6YfJ6jd7Y6e2aqpZxLaLTXycakdWwRLKwOQll+Kkfbq+mG8kM+qMVIHWmdfcXrgxavgoVwJhwTJefZwMbBPphbSlasFQhbkV6x3t4uw4IfNMJMdQmxaIK8Vph9QA+d0pZ6Ju5f8oTc5eoXJ8Zhs/JknX9zn5bsWUnZTXvXp
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 12:14:05.0380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6ab282-0829-4161-1b1b-08d5dcf0a46a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3126
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
 drivers/iio/dac/ad5758.c | 899 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 917 insertions(+)
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
index 0000000..2aaddf9
--- /dev/null
+++ b/drivers/iio/dac/ad5758.c
@@ -0,0 +1,899 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD5758 Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ *
+ * TODO: Currently CRC is not supported in this driver
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/property.h>
+#include <linux/delay.h>
+#include <linux/bsearch.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#include <asm/div64.h>
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
+#define AD5758_FULL_SCALE_MICRO	65535000000
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
+int cmpfunc(const void *a, const void *b)
+{
+	return (*(int *)a - *(int *)b);
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
+		udelay(100);
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
+	/* Perform a software reset and wait 100us */
+	udelay(100);
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
+		AD5758_DAC_CONFIG_SR_STEP_MODE(sr_step_idx) |
+		AD5758_DAC_CONFIG_SR_CLOCK_MODE(sr_clk_idx);
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
+	ret =  ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
+					     AD5758_CAL_MEM_UNREFRESHED_MSK);
+	if (ret < 0)
+		return ret;
+
+	return ret;
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
+	dcdc_config1_mode = (AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode) |
+			     AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(val));
+	dcdc_config1_msk = (AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
+			    AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK);
+
+	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
+				    dcdc_config1_msk,
+				    dcdc_config1_mode);
+	if (ret < 0)
+		goto err_unlock;
+
+	dac_config_mode = (AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
+			   AD5758_DAC_CONFIG_INT_EN_MODE(val));
+	dac_config_msk =  (AD5758_DAC_CONFIG_OUT_EN_MSK |
+			   AD5758_DAC_CONFIG_INT_EN_MSK);
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
+static struct iio_chan_spec ad5758_channels[] = {
+	{
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_OFFSET),
+		.indexed = 1,
+		.output = 1,
+		.ext_info = ad5758_ext_info,
+	},
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
+		index = (int *) bsearch(&tmp, ad5758_dc_dc_ilim,
+					ARRAY_SIZE(ad5758_dc_dc_ilim),
+					sizeof(int), cmpfunc);
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
+	struct iio_chan_spec *channels = ad5758_channels;
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
+	indio_dev->num_channels = ARRAY_SIZE(ad5758_channels);
+
+	ret = ad5758_parse_dt(st);
+	if (ret < 0)
+		return ret;
+
+	if (st->dc_dc_mode == AD5758_DCDC_MODE_DPC_VOLTAGE)
+		channels->type = IIO_VOLTAGE;
+	else
+		channels->type = IIO_CURRENT;
+
+	indio_dev->channels = channels;
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

