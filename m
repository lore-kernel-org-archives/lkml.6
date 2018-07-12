Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E310C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AD920875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="MCbfhk+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90AD920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbeGLF7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:59:38 -0400
Received: from mail-eopbgr700089.outbound.protection.outlook.com ([40.107.70.89]:15424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbeGLFzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DknYd++N4CWADZT0A3I5+9LR/jfIcpUwG8pFu2wSR9g=;
 b=MCbfhk+jjtnwecs3HcAZHcrZOVK27RDGGT/PCI1M0xjbAWGB/x+WwH11PQn4/JePpefXzvA2Oaop5Az7M/zFYXoZW42eIFtkdT0NatkAShbRnbO69Wf+SBFuB4+ZpgNnzjNTHgN7O1KHDIq8txVkr/GQIU3hKmfPRaAALzXeGWI=
Received: from CY1PR07CA0005.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::15) by SN6PR07MB4720.namprd07.prod.outlook.com
 (2603:10b6:805:3b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.22; Thu, 12 Jul
 2018 05:47:55 +0000
Received: from CO1NAM05FT016.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::201) by CY1PR07CA0005.outlook.office365.com
 (2a01:111:e400:c60a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:54 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT016.mail.protection.outlook.com (10.152.96.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkw1032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:53 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:03 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:03 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5llXb029550;
        Thu, 12 Jul 2018 06:47:47 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5llVD029548;
        Thu, 12 Jul 2018 06:47:47 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 07/31] usb: usbssp: Initialization - added usbssp_mem_init
Date:   Thu, 12 Jul 2018 06:47:04 +0100
Message-ID: <1531374448-26532-8-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(36092001)(199004)(189003)(8936002)(47776003)(26005)(26826003)(51416003)(76176011)(305945005)(14444005)(356003)(8676002)(476003)(486006)(246002)(11346002)(446003)(7636002)(126002)(2616005)(106466001)(575784001)(105596002)(50226002)(4720700003)(478600001)(87636003)(5660300001)(6666003)(50466002)(86362001)(36756003)(2906002)(109986005)(107886003)(42186006)(54906003)(336012)(4326008)(48376002)(1671002)(316002)(16586007)(186003)(426003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4720;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT016;1:wwWaJYLefxowEbyVq/nOZ6s01xp65lfHhBYN70RV819MPWcg4z9mBrOfFi5EPykfYSctXdjZNAGcrO9/SLh0DGiKVbyN1sDJpdPaB2Ot7ZWOe713avAuMJwT3dflFagL
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a569b5f-8cd8-4857-c2c8-08d5e7bb0364
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN6PR07MB4720;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;3:UTnvzuckx7hOoiP6FqTPF/Y71s3wYwE7A9UBisP3mhUErqxUtqEjbTD/fqNpSVeI8j6sqs6ByAivtdjFl0AG1ztuzvW4Ei/0eDIN6Fl0qP+KM3IngCt8pF7zS8oPLCfpHCeYTbson3sXqPohy/zTf55KL/I3Lm7vdq6XIhcq/xfWBC8uItVgcd6vyjhKiKTvFE+7xKHqEivoKP0aSAAnupxPJOIBhE2V8eaK6m9Gd5iJZLd1h5ht+JIdnMMzze6LnGqjzqbitUVknWG+wet5J2Z/s43a1zYSxvZnrGixYem9aALdEgz/6P3C96frpuau82CzmuJBWDBp1gtLCG2IlirREg3XkQI5GUgN1mrtPQU=;25:P/1Eewn/EUK9oEjbMBh0nbXQ/kS9ePFR//XQPO5O5rn61eABN4LPLsMv1nhzPSij84QHIZ/EGpuPwIYMNam+P1bq4gl/tLfWwxLjmRGk+SOScsWXQse8a0MVA/ooSHd6MhYDAsHMux2FdMBXesyhnOYviWwGVccENVX1PNm1Y/OZh8flwrh+vf8id/hgbj8cAdJiISXtGuRoxNsgLVryAJWbnUShBkWoNBdvtsIWuRyT1UHoHUpSjf7S8JUfJtWvqean59U47JMhOklwtBVMkenrfmgyH4q5Zi39zqKnqp4fYDlfNqcnxF7trHvSjTyilZYLbZYM9Q9xIARH3BUQPQ==
X-MS-TrafficTypeDiagnostic: SN6PR07MB4720:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;31:c4MQPjp80musPr8NlI9qbEFv1IEgRwGbg6QCCH4IUphO6KAShHqxUYECOrqoUKKgNCjsQiNwL8oLciND1/4NYFZB9lfWVQWfjikzJ0nbxyBmdEe3icf8tmtQdAGLmlO9eLR31l7en1BpO1j4uQ10mVxkPQTFgRpaQU0DLzWP4LnNVCcHXrKe4FwPvNki4J1tL3ZqpmVl2i0SdyPbBb/UnG4+oVPqiReLxY0Yu87QEEo=;20:p+skKvdta2SsX2tN3hXvnZRYwgdBQq4Q7zkUIxPhXjcMGmfqPu4CsiYkR1xWrQnX1heGWMx92RJxVZlETLaMrIcsWjHlOIiMlRGzGwP1WTyNsqzV3hwLl0HnEjY/SjrznQjv4lXhTczP9HgjfXvTNn7o4py01wHD3/PlIWY9GP1e+BTFkCwc7a7tfEgbFOvMHh0n8v4VMe2Z5CR83Xu9iMDhIzZQihhMwUmdYP901znY30akbZTg/oQ+xonHRSyWLeOo++eCXqQBwOVetzoz0dqRNwijfds2XIMwFb3K4craqUb1twtAeTu5AbXd+o/lroDZpw+jp+hEZSR0YreazjwIfaLck4hDAUT40qwVBFCd/7YwGARLYP0s+Tio2ws6Sea27hsM+j9OgLHTYHhb9jm6MsxgzVby6JjzPS9o7Yvv/FMdaPuCD9tU7puvNXq2yVZUfGRY7h+N2DXd64pFMuXL37wrgpUPNmzSs0PNeqeRpasiBRp0Z8SMNDEe2bp7
X-Microsoft-Antispam-PRVS: <SN6PR07MB4720DCA696EB3ACEE9297487DD590@SN6PR07MB4720.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93003095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4720;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4720;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;4:j3YO2qDHnJGGyAD0UC6XWOq3Qua7T/we3W8bRyDPosd0om1ITyCXH7Wh2sJllJSlAeul6dUGai8Th3CkjQDOI9tvaTJqNZP18ZzrZls/lazaYYcPk4xdCUdNV/XdfLWOijF8vAaLlPIWHKO7RqOGDE4N2yeoohtBNVcyk154TIERVAPy0otkri3Q6MSzXBt+CVGnVbxGQSp72u91t7rf4r0+Q03CLNEVzXotuaXbRqDD+xXimQNuE4I6bnvjlfNryJcOGNR8QzcP/jQ7RTsAqDhDvxeJQBGiNMxlydPihcMnr03E3k9JO7YG/ZnoQCrR
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4720;23:GsCiyMu39QEXDkcVwg+NNOSlCq3xnH6/iJyFHdOOB?=
 =?us-ascii?Q?UTFJ/ixhka4A1j7InFGdNsQxHmYU0wrHLGrN5ohZvRuAWFjWa4rM28A3tsc7?=
 =?us-ascii?Q?gqehFWCckZcWtqzXBRhNh2ZZJL+JVolBLyHMm6X8OLuMXtAhtqjoJE9sqZLt?=
 =?us-ascii?Q?oXW4ErSUiCMhOhlYbd5QdthE0dNAZayE9fhSSlaow1a+omNzz6lRCZtmkapx?=
 =?us-ascii?Q?Ec70HCMuOV8rwkJvKAkLXy9uEBq4LSb22Q70Y4rUbQgD0rzG7MdoGMh4aOPJ?=
 =?us-ascii?Q?t6Xu6FRXOGmL8n7uiqNg/Zgx1vamOVerl7EZtr4OM+bDx9d6XTTEhbuPz48W?=
 =?us-ascii?Q?qwiJJfRFyx968l8YLo8frvAXL6wfTC6jKYyjdLsroR4pgRcFW+kcYiQg9m6s?=
 =?us-ascii?Q?0IDZdANXlHW9J9AWPOJOZ8O5MobDVvqJb4MGZ6Bc82CGQbWrdtlTXp4cMYQ1?=
 =?us-ascii?Q?56w/+HYXWAXsTyegHftlG5w9D0uCquUHnZ0r6zKuZ8/AXTf0cDclW/q98Khv?=
 =?us-ascii?Q?PtKj19t01gakJLQFWGP/WLMtIGfubeIqZmkKUBJU6+DM/32v80QjhMO1FKQ+?=
 =?us-ascii?Q?gqltt5H8tr/lFWHiLsN54MS0Y8C/LUOHfv9wROIM0SHMV2ddFswmBNlu0HNh?=
 =?us-ascii?Q?dl6FYGwR7/Msvt1N+tlPxKtx2ba28DPh6KuTxo9MeYWUcPf9EVY2UnWTTmcd?=
 =?us-ascii?Q?8n2ZzEGynykipiAuvPgjfbryLmF3GnqBKhGMn3aNJ6u974NiZwHoPf958mSv?=
 =?us-ascii?Q?Jr8se3UABP2Wesz3dfFL8F60ofVcE2MlHHcjsw5/DzT0pVoOEaUBO7nFMRfH?=
 =?us-ascii?Q?ge7Oik/NXksDVwxbxJbB9b9xv9mfyXVmbiKOs+DYbbXz2be2ysmLv7sUQxzi?=
 =?us-ascii?Q?chwW7J2X36VSHAF9TMtq0wDPMJZrSo5Q6WoDMdDUyJceMnAWaUX5YiqlXVJW?=
 =?us-ascii?Q?W+6Aqn5TCs4I/yyYkyBPH93/8fwTHb98jPjcusJcJNHT/liuCXBuufuxJesk?=
 =?us-ascii?Q?sZG1VGJfX1TkIWUSAGUxDPB1ZH5Qh7zejFNcrudQdUXWJ1Z/i+pxj7Wt4y99?=
 =?us-ascii?Q?UxhWbu+RKcgRFEJn9ARvgnflcCyQe82HjMcIRlp3H/iZ30z1Vb8HIQ7ef4rj?=
 =?us-ascii?Q?2D7tcL3jmJBPrwxXpOfaTAsiChe7FZPZzR8o0idvEy56ZST5aV310dXQ95eN?=
 =?us-ascii?Q?E0Kn7gLgfWO9Yw=3D?=
X-Microsoft-Antispam-Message-Info: 5ZS8Xo2wg8UhgmbPclbsUO+BKWg4DIuVp/urE0Qt6DLNp+QEF7mOyWo+mEgXfdslZ5KtEAQiYzOirR3VQoxKgz//Aj6iLLQ1sp27NW/9niGwkGsPcKHX+QlepKYK4/rG3NBRubTOsfH4HrLcINMf8I1J7xXjeuJTF6c46DlfrPhoFCobHa8AxHCBs4rKIxBaRMImrwRUoxUociKsC4ViTZfIlHNbdJ5pqWk8LVPscExmbMjuWHWJt0Eh8gN/8g4DxTFrL8yPOr5d7LXNKzb37Ku5Ic8fjRUt+1iqisbsWZAWPILpW5mk+ZvnmBgLqkPFzPPewjK9nfRmS50JUrIF56OLv1kXOL4b1Ox+jUo4Vik+H40/rxekPFHzfDQfPb1bOAsudUXnVWDGjp109fekdQ==
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;6:KDc83Sppbvh6V2/1rLo7oqGyWrcHJuMAgUXnlF1V5EQqWicyoNUlU1u390CSjiXo9g8McwHGluD4op+Xc5pyM3+5JvZpSDNuZWE582mA9nYWumY798Dtg1xNA3uFtdPJVa4v3lAS8ePtIJd2Pn1THBZ3MO/2NUQYsquUgPhm6ij8exAwb9ZqeSo+jeyog0mgBnN+da24JpwEeXSrTR5v+dZfe6ieXl/aefCVo259ltq1MSpxS6Y+yeCNE+ADMPZifATh9KXKWGmiWUys7UmXGukRIMdSKBOQWaTE0GFSEkZwHDrQhDZZ3boDCdJZ1HJ4VK4s5u9gOCsHLKlO6d5kyI8UhqFhykI0xGZ37Olmeo1ghwmJWv/MCsKuBMZFy9d2vR+JmO6IvuvFBdJQik6LXjPHdq1ymrp9AlJcKYIrdY6n/4H3ed5F9bkumsR2vma2owQKHi2dBgD07WiQYZ2qBw==;5:PSFx71aBLfeaqbwDFdCjiz67G10FYO0f+i6bNQ4Hbv27vJFC7mddrJPl9KotaJPzEoX+oZwG2I7xQygEuY6AQadkVrVUnUPo+wsdQQXqyjYQKoJ965mQ14DuiSNK0uLynrbVnFnyhy0dHT1Di+UOAKgRbi+cUotjGF9baNwsX1Q=;24:usk7QsSJYXMUfwRUooXiMjeew6B6ERen+766kR/8SIHtEhutRU6TXTupzvHkBqpXplRMPMO4107NFrZmLKR8iezQA8CScZOxkEVcAKpKk+c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4720;7:tndp9z4s2gwzGn16F3FxSSiGHBSXLfkfGr7UA6f9ys+U56uEnN2cp9OF+XlWjzcsMNezCRW60wKO25LyQZeUd2rBCUC2BwU/pXtuZ8xkz8OR299GtQjU10fS0SOLBFTw9FF5ry9qmPjfuDO1ebndQFxoJUUDmvGn3mi6/bjqXjAHQ0qfXXkDeTs3mXPWuxVb26iQ04AENBE7Mf0CXAgTCxZlmDeJCiQTk6Hb4Qd4y2+xjpZulXdDIkmInCKoigEV;20:FErmY7k59XentXjq4J/63cfh/PGqsLCSK1Dfpkz+L0oozFgAWILy0mHu5gAvRGessmDB2wl8gmrP58b024e+P/Bta6fhI8NJpAuZmL3SgwKuJMU5aqSj5mpojw5jOY0kaIw+wnTyazj+XjzUBEeHJRbL4NQR+Mur5jv9ittm3k+0D1rNybgsXwgtOKzKHBFRS3uBIE/+7AhMi/YvbFNwqURPKJ7NAgFAnyXWMw7PMxES6ejLz49rHiic8k1ZroBn
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:54.3066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a569b5f-8cd8-4857-c2c8-08d5e7bb0364
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4720
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds some stuff regarding initialization of
usbssp driver.

It introduces new file gadget-mem.c which contains
functions responsible for allocating and freeing object
used in driver. It will be gradually expended with
new functionality.

To limits the size of this patch not all functions are
implemented - some of them are empty end will be implemented
in next patch.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/Makefile          |   2 +-
 drivers/usb/usbssp/gadget-ext-caps.h |  45 ++
 drivers/usb/usbssp/gadget-mem.c      | 613 +++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget-ring.c     |   6 +
 drivers/usb/usbssp/gadget.c          |   3 +-
 drivers/usb/usbssp/gadget.h          |   5 +
 6 files changed, 671 insertions(+), 3 deletions(-)
 create mode 100644 drivers/usb/usbssp/gadget-mem.c

diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
index ccc7c5646a6b..884352e80779 100644
--- a/drivers/usb/usbssp/Makefile
+++ b/drivers/usb/usbssp/Makefile
@@ -4,7 +4,7 @@ CFLAGS_gadget-trace.o := -I$(src)
 
 obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
 usbssp-y 			:=  usbssp-plat.o gadget-ring.o \
-				    gadget.o \
+				    gadget.o gadget-mem.o \
 				    gadget-dbg.o
 
 ifneq ($(CONFIG_TRACING),)
diff --git a/drivers/usb/usbssp/gadget-ext-caps.h b/drivers/usb/usbssp/gadget-ext-caps.h
index 2cadb5e0d15f..8d0b9e83cbcf 100644
--- a/drivers/usb/usbssp/gadget-ext-caps.h
+++ b/drivers/usb/usbssp/gadget-ext-caps.h
@@ -54,3 +54,48 @@
 
 /* true: Controller Not Ready to accept doorbell or op reg writes after reset */
 #define USBSSP_STS_CNR			(1 << 11)
+
+#include <linux/io.h>
+
+/**
+ * Find the offset of the extended capabilities with capability ID id.
+ *
+ * @base	PCI MMIO registers base address.
+ * @start	address at which to start looking, (0 or HCC_PARAMS to start at
+ *		beginning of list)
+ * @id		Extended capability ID to search for.
+ *
+ * Returns the offset of the next matching extended capability structure.
+ * Some capabilities can occur several times,
+ * e.g., the USBSSP_EXT_CAPS_PROTOCOL, and this provides a way to find them all.
+ */
+
+static inline int usbssp_find_next_ext_cap(
+		void __iomem *base, u32 start, int id)
+{
+	u32 val;
+	u32 next;
+	u32 offset;
+
+	offset = start;
+	if (!start || start == USBSSP_HCC_PARAMS_OFFSET) {
+		val = readl(base + USBSSP_HCC_PARAMS_OFFSET);
+		if (val == ~0)
+			return 0;
+		offset = USBSSP_HCC_EXT_CAPS(val) << 2;
+		if (!offset)
+			return 0;
+	};
+	do {
+		val = readl(base + offset);
+		if (val == ~0)
+			return 0;
+		if (USBSSP_EXT_CAPS_ID(val) == id && offset != start)
+			return offset;
+
+		next = USBSSP_EXT_CAPS_NEXT(val);
+		offset += next << 2;
+	} while (next);
+
+	return 0;
+}
diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
new file mode 100644
index 000000000000..f0c529cf824a
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -0,0 +1,613 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp.
+ */
+
+#include <linux/usb.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
+#include "gadget.h"
+#include "gadget-trace.h"
+/**
+ * Create a new ring with zero or more segments.
+ *
+ * Link each segment together into a ring.
+ * Set the end flag and the cycle toggle bit on the last segment.
+ * See section 4.9.1 and figures 15 and 16.
+ */
+static struct usbssp_ring *usbssp_ring_alloc(struct usbssp_udc *usbssp_data,
+					     unsigned int num_segs,
+					     unsigned int cycle_state,
+					     enum usbssp_ring_type type,
+					     unsigned int max_packet,
+					     gfp_t flags)
+{
+	/*TODO: implements function*/
+	return NULL;
+}
+
+struct usbssp_container_ctx *usbssp_alloc_container_ctx(
+					struct usbssp_udc *usbssp_data,
+					int type, gfp_t flags)
+{
+	struct usbssp_container_ctx *ctx;
+
+	if ((type != USBSSP_CTX_TYPE_DEVICE) && (type != USBSSP_CTX_TYPE_INPUT))
+		return NULL;
+
+	ctx = kzalloc(sizeof(*ctx), flags);
+	if (!ctx)
+		return NULL;
+
+	ctx->type = type;
+	ctx->size = HCC_64BYTE_CONTEXT(usbssp_data->hcc_params) ? 2048 : 1024;
+	if (type == USBSSP_CTX_TYPE_INPUT)
+		ctx->size += CTX_SIZE(usbssp_data->hcc_params);
+
+	ctx->bytes = dma_pool_zalloc(usbssp_data->device_pool,
+				flags, &ctx->dma);
+
+	if (!ctx->bytes) {
+		kfree(ctx);
+		return NULL;
+	}
+	return ctx;
+}
+
+struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
+					    bool allocate_completion,
+					    gfp_t mem_flags)
+{
+	struct usbssp_command *command;
+
+	command = kzalloc(sizeof(*command), mem_flags);
+	if (!command)
+		return NULL;
+
+	if (allocate_completion) {
+		command->completion =
+			kzalloc(sizeof(struct completion), mem_flags);
+		if (!command->completion) {
+			kfree(command);
+			return NULL;
+		}
+		init_completion(command->completion);
+	}
+
+	command->status = 0;
+	INIT_LIST_HEAD(&command->cmd_list);
+
+	return command;
+}
+
+struct usbssp_command *usbssp_alloc_command_with_ctx(
+					struct usbssp_udc *usbssp_data,
+					bool allocate_completion,
+					gfp_t mem_flags)
+{
+	struct usbssp_command *command;
+
+	command = usbssp_alloc_command(usbssp_data,
+			allocate_completion, mem_flags);
+	if (!command)
+		return NULL;
+
+	command->in_ctx = usbssp_alloc_container_ctx(usbssp_data,
+				USBSSP_CTX_TYPE_INPUT, mem_flags);
+	if (!command->in_ctx) {
+		kfree(command->completion);
+		kfree(command);
+		return NULL;
+	}
+	return command;
+}
+
+void usbssp_request_free_priv(struct usbssp_request *priv_req)
+{
+	if (priv_req)
+		kfree(priv_req->td);
+}
+
+
+int usbssp_alloc_erst(struct usbssp_udc *usbssp_data,
+		      struct usbssp_ring *evt_ring,
+		      struct usbssp_erst *erst,
+		      gfp_t flags)
+{
+	size_t size;
+	unsigned int val;
+	struct usbssp_segment *seg;
+	struct usbssp_erst_entry *entry;
+
+	size = sizeof(struct usbssp_erst_entry) * evt_ring->num_segs;
+	erst->entries = dma_zalloc_coherent(usbssp_data->dev,
+			size, &erst->erst_dma_addr, flags);
+	if (!erst->entries)
+		return -ENOMEM;
+
+	erst->num_entries = evt_ring->num_segs;
+
+	seg = evt_ring->first_seg;
+	for (val = 0; val < evt_ring->num_segs; val++) {
+		entry = &erst->entries[val];
+		entry->seg_addr = cpu_to_le64(seg->dma);
+		entry->seg_size = cpu_to_le32(TRBS_PER_SEGMENT);
+		entry->rsvd = 0;
+		seg = seg->next;
+	}
+
+	return 0;
+}
+
+void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data)
+{
+	/*TODO: implements functions*/
+}
+
+
+static void usbssp_set_event_deq(struct usbssp_udc *usbssp_data)
+{
+	u64 temp;
+	dma_addr_t deq;
+
+	deq = usbssp_trb_virt_to_dma(usbssp_data->event_ring->deq_seg,
+			usbssp_data->event_ring->dequeue);
+	if (deq == 0 && !in_interrupt())
+		usbssp_warn(usbssp_data,
+			"WARN something wrong with SW event ring dequeue ptr.\n");
+	/* Update USBSSP event ring dequeue pointer */
+	temp = usbssp_read_64(usbssp_data, &usbssp_data->ir_set->erst_dequeue);
+	temp &= ERST_PTR_MASK;
+	/* Don't clear the EHB bit (which is RW1C) because
+	 * there might be more events to service.
+	 */
+	temp &= ~ERST_EHB;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+		"// Write event ring dequeue pointer, preserving EHB bit");
+	usbssp_write_64(usbssp_data, ((u64) deq & (u64) ~ERST_PTR_MASK) | temp,
+			&usbssp_data->ir_set->erst_dequeue);
+}
+
+static void usbssp_add_in_port(struct usbssp_udc *usbssp_data,
+			       unsigned int num_ports,
+			       __le32 __iomem *addr,
+			       int max_caps)
+{
+	u32 temp, port_offset, port_count;
+	int i;
+	u8 major_revision;
+	struct usbssp_ports *rport;
+
+	temp = readl(addr);
+	major_revision = USBSSP_EXT_PORT_MAJOR(temp);
+
+	if (major_revision == 0x03) {
+		rport = &usbssp_data->usb3_rhub;
+	} else if (major_revision <= 0x02) {
+		rport = &usbssp_data->usb2_rhub;
+	} else {
+		usbssp_warn(usbssp_data, "Ignoring unknown port speed, "
+				"Ext Cap %p, revision = 0x%x\n",
+				addr, major_revision);
+		/* Ignoring port protocol we can't understand. */
+		return;
+	}
+
+	rport->maj_rev = USBSSP_EXT_PORT_MAJOR(temp);
+	rport->min_rev = USBSSP_EXT_PORT_MINOR(temp);
+
+	/* Port offset and count in the third dword, see section 7.2 */
+	temp = readl(addr + 2);
+	port_offset = USBSSP_EXT_PORT_OFF(temp);
+	port_count = USBSSP_EXT_PORT_COUNT(temp);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+		"Ext Cap %p, port offset = %u, count = %u, revision = 0x%x",
+		addr, port_offset, port_count, major_revision);
+
+	if (port_count > 1) {
+		usbssp_warn(usbssp_data,
+			"DC support only single port but it detect %d ports",
+			port_count);
+		port_count = 1;
+	}
+	/* Port count includes the current port offset */
+	if (port_offset == 0 || (port_offset + port_count - 1) > num_ports)
+		return;
+
+	rport->psi_count = USBSSP_EXT_PORT_PSIC(temp);
+	if (rport->psi_count) {
+		rport->psi = kcalloc(rport->psi_count, sizeof(*rport->psi),
+				GFP_KERNEL);
+		if (!rport->psi)
+			rport->psi_count = 0;
+
+		rport->psi_uid_count++;
+		for (i = 0; i < rport->psi_count; i++) {
+			rport->psi[i] = readl(addr + 4 + i);
+
+			/* count unique ID values, two consecutive entries can
+			 * have the same ID if link is assymetric
+			 */
+			if (i && (USBSSP_EXT_PORT_PSIV(rport->psi[i]) !=
+				  USBSSP_EXT_PORT_PSIV(rport->psi[i - 1])))
+				rport->psi_uid_count++;
+
+			usbssp_dbg(usbssp_data,
+				"PSIV:%d PSIE:%d PLT:%d PFD:%d LP:%d PSIM:%d\n",
+				USBSSP_EXT_PORT_PSIV(rport->psi[i]),
+				USBSSP_EXT_PORT_PSIE(rport->psi[i]),
+				USBSSP_EXT_PORT_PLT(rport->psi[i]),
+				USBSSP_EXT_PORT_PFD(rport->psi[i]),
+				USBSSP_EXT_PORT_LP(rport->psi[i]),
+				USBSSP_EXT_PORT_PSIM(rport->psi[i]));
+		}
+	}
+
+	/* cache usb2 port capabilities */
+	if (major_revision < 0x03 && usbssp_data->num_ext_caps < max_caps)
+		usbssp_data->ext_caps[usbssp_data->num_ext_caps++] = temp;
+
+	if (major_revision != 0x03) {
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+				"USBSSP: support USB2 software lpm");
+		usbssp_data->sw_lpm_support = 1;
+		if (temp & USBSSP_HLC) {
+			usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+					"USBSSP: support USB2 hardware lpm");
+			usbssp_data->hw_lpm_support = 1;
+		}
+	}
+
+	usbssp_data->port_array[port_offset-1] = major_revision;
+	if (major_revision == 0x03)
+		usbssp_data->num_usb3_ports++;
+	else
+		usbssp_data->num_usb2_ports++;
+}
+
+/*
+ * Scan the Extended Capabilities for the "Supported Protocol Capabilities" that
+ * specify what speeds each port is supposed to be.
+ */
+static int usbssp_setup_port_arrays(struct usbssp_udc *usbssp_data, gfp_t flags)
+{
+	void __iomem *base;
+	u32 offset;
+	u32 port3offset = 0;
+	u32 port2offset = 0;
+	unsigned int num_ports;
+	int i;
+	int cap_count = 0;
+	u32 cap_start;
+
+	num_ports = HCS_MAX_PORTS(usbssp_data->hcs_params1);
+
+	/*USBSSP can support only two ports - one for USB2.0 and
+	 * second for USB3.0
+	 */
+	if (num_ports > MAX_USBSSP_PORTS) {
+		usbssp_err(usbssp_data,
+			"USBSSP-Dev can't support more then %d ports\n",
+			MAX_USBSSP_PORTS);
+		return -EINVAL;
+	}
+
+	usbssp_data->port_array =
+		kzalloc(sizeof(*usbssp_data->port_array)*num_ports, flags);
+	if (!usbssp_data->port_array)
+		return -ENOMEM;
+
+	base = &usbssp_data->cap_regs->hc_capbase;
+
+	cap_start = usbssp_find_next_ext_cap(base, 0, USBSSP_EXT_CAPS_PROTOCOL);
+	if (!cap_start) {
+		usbssp_err(usbssp_data,
+			"No Ext. Cap. registers, unable to set up ports\n");
+		return -ENODEV;
+	}
+
+	offset = cap_start;
+
+	/* count extended protocol capability entries for later caching */
+	while (offset) {
+		u32 temp;
+		u8 major_revision;
+
+		temp = readl(base + offset);
+		major_revision = USBSSP_EXT_PORT_MAJOR(temp);
+
+		if (major_revision == 0x03 && port3offset == 0)
+			port3offset = offset;
+		else if (major_revision <= 0x02 && port2offset == 0)
+			port2offset = offset;
+
+		cap_count++;
+
+		offset = usbssp_find_next_ext_cap(base, offset,
+				USBSSP_EXT_CAPS_PROTOCOL);
+	}
+
+	if (cap_count > MAX_USBSSP_PORTS) {
+		usbssp_err(usbssp_data, "Too many  Ext. Cap. registers\n");
+		return -EINVAL;
+	}
+
+	if (!port3offset &&  !port2offset) {
+		usbssp_warn(usbssp_data, "No ports on the USBSSP?\n");
+		return -ENODEV;
+	}
+
+	usbssp_data->ext_caps =
+		kzalloc(sizeof(*usbssp_data->ext_caps) * cap_count, flags);
+	if (!usbssp_data->ext_caps)
+		return -ENOMEM;
+
+	/** if exist add USB3 port*/
+	if (port3offset)
+		usbssp_add_in_port(usbssp_data, num_ports,
+				base + port3offset, cap_count);
+
+	/** add USB2 port*/
+	if (port2offset)
+		usbssp_add_in_port(usbssp_data, num_ports,
+				base + port2offset, cap_count);
+
+	if (usbssp_data->num_usb2_ports == 0 &&
+	    usbssp_data->num_usb3_ports == 0) {
+		usbssp_warn(usbssp_data, "No ports on the USBSSP?\n");
+		return -ENODEV;
+	}
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Found %u USB 2.0 ports and %u USB 3.0 ports.",
+			usbssp_data->num_usb2_ports,
+			usbssp_data->num_usb3_ports);
+
+	//Only one port USB3.0 and USB2.0 can be supported by USBSSP_DEV
+	if (usbssp_data->num_usb3_ports > 1) {
+		usbssp_err(usbssp_data, "Limiting USB 3.0 ports to 1\n");
+		return -EINVAL;
+	}
+
+	if (usbssp_data->num_usb2_ports > 1) {
+		usbssp_err(usbssp_data, "Limiting USB 2.0 ports to 1\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Note we could have only USB 3.0 ports, or  USB 2.0 ports.
+	 */
+	if (usbssp_data->num_usb2_ports) {
+		for (i = 0; i < num_ports; i++) {
+
+			if (usbssp_data->port_array[i] == 0x03)
+				continue;
+			usbssp_data->usb2_ports =
+				&usbssp_data->op_regs->port_status_base +
+				NUM_PORT_REGS*i;
+
+			usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+					"USB 2.0 port at index %u, addr = %p",
+					i, usbssp_data->usb2_ports);
+		}
+	}
+
+	if (usbssp_data->num_usb3_ports) {
+
+		for (i = 0; i < num_ports; i++)
+			if (usbssp_data->port_array[i] == 0x03) {
+				usbssp_data->usb3_ports =
+					&usbssp_data->op_regs->port_status_base +
+					NUM_PORT_REGS*i;
+
+				usbssp_dbg_trace(usbssp_data,
+					trace_usbssp_dbg_init,
+					"USB 3.0 port at index %u, addr = %p",
+					i, usbssp_data->usb3_ports);
+			}
+	}
+
+	return 0;
+}
+
+int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags)
+{
+	dma_addr_t	dma;
+	struct device	*dev = usbssp_data->dev;
+	unsigned int	val, val2;
+	u64		val_64;
+	u32 page_size;
+	int i, ret;
+
+	INIT_LIST_HEAD(&usbssp_data->cmd_list);
+
+	/* init command timeout work */
+	INIT_DELAYED_WORK(&usbssp_data->cmd_timer,
+			usbssp_handle_command_timeout);
+	init_completion(&usbssp_data->cmd_ring_stop_completion);
+
+	page_size = readl(&usbssp_data->op_regs->page_size);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Supported page size register = 0x%x", page_size);
+	for (i = 0; i < 16; i++) {
+		if ((0x1 & page_size) != 0)
+			break;
+		page_size = page_size >> 1;
+	}
+	if (i < 16)
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Supported page size of %iK", (1 << (i+12)) / 1024);
+	else
+		usbssp_warn(usbssp_data, "WARN: no supported page size\n");
+
+	/* Use 4K pages, since that's common and the minimum the
+	 * USBSSP supports
+	 */
+	usbssp_data->page_shift = 12;
+	usbssp_data->page_size = 1 << usbssp_data->page_shift;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"USBSSP page size set to %iK",
+			usbssp_data->page_size / 1024);
+
+	/* In device mode this value should be equal 1*/
+	val = DEV_HCS_MAX_SLOTS(readl(&usbssp_data->cap_regs->hcs_params1));
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// USBSSP can handle at most %d device slots.", val);
+
+	/*device should have only 1 slot*/
+	if (val > DEV_MAX_SLOTS)
+		pr_err("Invalid number of supported slots");
+
+	val2 = readl(&usbssp_data->op_regs->config_reg);
+	val |= (val2 & ~DEV_HCS_SLOTS_MASK);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Setting Max device slots reg = 0x%x.", val);
+	writel(val, &usbssp_data->op_regs->config_reg);
+
+	/*
+	 * Doorbell array must be physically contiguous
+	 * and 64-byte (cache line) aligned.
+	 */
+	usbssp_data->dcbaa = dma_alloc_coherent(dev,
+			sizeof(*usbssp_data->dcbaa), &dma, GFP_KERNEL);
+	if (!usbssp_data->dcbaa)
+		goto fail;
+	memset(usbssp_data->dcbaa, 0, sizeof *(usbssp_data->dcbaa));
+	usbssp_data->dcbaa->dma = dma;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// DCBA array address = 0x%llx (DMA), %p (virt)",
+			(unsigned long long)usbssp_data->dcbaa->dma,
+			usbssp_data->dcbaa);
+	usbssp_write_64(usbssp_data, dma, &usbssp_data->op_regs->dcbaa_ptr);
+
+	/*
+	 * Initialize the ring segment pool.  The ring must be a contiguous
+	 * structure comprised of TRBs.  The TRBs must be 16 byte aligned,
+	 * however, the command ring segment needs 64-byte aligned segments
+	 * and our use of dma addresses in the trb_address_map radix tree needs
+	 * TRB_SEGMENT_SIZE alignment, so we pick the greater alignment need.
+	 */
+	usbssp_data->segment_pool = dma_pool_create("USBSSP ring segments", dev,
+			TRB_SEGMENT_SIZE, TRB_SEGMENT_SIZE,
+			usbssp_data->page_size);
+
+	usbssp_data->device_pool =
+			dma_pool_create("USBSSP input/output contexts", dev,
+					2112, 64, usbssp_data->page_size);
+	if (!usbssp_data->segment_pool || !usbssp_data->device_pool)
+		goto fail;
+
+	/* Linear stream context arrays don't have any boundary restrictions,
+	 * and only need to be 16-byte aligned.
+	 */
+	usbssp_data->small_streams_pool =
+			dma_pool_create("USBSSP 256 byte stream ctx arrays",
+					dev, SMALL_STREAM_ARRAY_SIZE, 16, 0);
+	usbssp_data->medium_streams_pool =
+			dma_pool_create("USBSSP 1KB stream ctx arrays",
+					dev, MEDIUM_STREAM_ARRAY_SIZE, 16, 0);
+
+	/* Any stream context array bigger than MEDIUM_STREAM_ARRAY_SIZE
+	 * will be allocated with dma_alloc_coherent()
+	 */
+	if (!usbssp_data->small_streams_pool ||
+	    !usbssp_data->medium_streams_pool)
+		goto fail;
+
+	/* Set up the command ring to have one segments for now. */
+	usbssp_data->cmd_ring = usbssp_ring_alloc(usbssp_data, 1, 1,
+			TYPE_COMMAND, 0, flags);
+	if (!usbssp_data->cmd_ring)
+		goto fail;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Allocated command ring at %p", usbssp_data->cmd_ring);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"First segment DMA is 0x%llx",
+			(unsigned long long)usbssp_data->cmd_ring->first_seg->dma);
+
+	/* Set the address in the Command Ring Control register */
+	val_64 = usbssp_read_64(usbssp_data, &usbssp_data->op_regs->cmd_ring);
+	val_64 = (val_64 & (u64) CMD_RING_RSVD_BITS) |
+		(usbssp_data->cmd_ring->first_seg->dma & (u64) ~CMD_RING_RSVD_BITS) |
+		usbssp_data->cmd_ring->cycle_state;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Setting command ring address to 0x%x", val_64);
+	usbssp_write_64(usbssp_data, val_64, &usbssp_data->op_regs->cmd_ring);
+
+	val = readl(&usbssp_data->cap_regs->db_off);
+	val &= DBOFF_MASK;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Doorbell array is located at offset 0x%x"
+			" from cap regs base addr", val);
+	usbssp_data->dba = (void __iomem *) usbssp_data->cap_regs + val;
+
+	/* Set ir_set to interrupt register set 0 */
+	usbssp_data->ir_set = &usbssp_data->run_regs->ir_set[0];
+
+	/*
+	 * Event ring setup: Allocate a normal ring, but also setup
+	 * the event ring segment table (ERST).
+	 */
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Allocating event ring");
+	usbssp_data->event_ring = usbssp_ring_alloc(usbssp_data,
+			ERST_NUM_SEGS, 1, TYPE_EVENT, 0, flags);
+	if (!usbssp_data->event_ring)
+		goto fail;
+
+	ret = usbssp_alloc_erst(usbssp_data, usbssp_data->event_ring,
+			&usbssp_data->erst, flags);
+	if (ret)
+		goto fail;
+
+	/* set ERST count with the number of entries in the segment table */
+	val = readl(&usbssp_data->ir_set->erst_size);
+	val &= ERST_SIZE_MASK;
+	val |= ERST_NUM_SEGS;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Write ERST size = %i to ir_set 0 (some bits preserved)",
+			val);
+	writel(val, &usbssp_data->ir_set->erst_size);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Set ERST entries to point to event ring.");
+
+	/* set the segment table base address */
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"// Set ERST base address for ir_set 0 = 0x%llx",
+			(unsigned long long)usbssp_data->erst.erst_dma_addr);
+	val_64 = usbssp_read_64(usbssp_data, &usbssp_data->ir_set->erst_base);
+	val_64 &= ERST_PTR_MASK;
+	val_64 |= (usbssp_data->erst.erst_dma_addr & (u64) ~ERST_PTR_MASK);
+	usbssp_write_64(usbssp_data, val_64, &usbssp_data->ir_set->erst_base);
+
+	/* Set the event ring dequeue address */
+	usbssp_set_event_deq(usbssp_data);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Wrote ERST address to ir_set 0.");
+
+	if (usbssp_setup_port_arrays(usbssp_data, flags))
+		goto fail;
+
+	return 0;
+
+fail:
+	usbssp_warn(usbssp_data, "Couldn't initialize memory\n");
+	usbssp_halt(usbssp_data);
+	usbssp_reset(usbssp_data);
+	usbssp_mem_cleanup(usbssp_data);
+	return -ENOMEM;
+}
+
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index d1da59306d02..69cf478c222b 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -46,3 +46,9 @@ irqreturn_t usbssp_irq(int irq, void *priv)
 	spin_unlock_irqrestore(&usbssp_data->lock, flags);
 	return ret;
 }
+
+
+void usbssp_handle_command_timeout(struct work_struct *work)
+{
+	/*TODO: implements function*/
+}
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 67845e8368bc..9010d3a3720c 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -197,8 +197,7 @@ int usbssp_init(struct usbssp_udc *usbssp_data)
 	spin_lock_init(&usbssp_data->lock);
 	spin_lock_init(&usbssp_data->irq_thread_lock);
 
-	//TODO: memory initialization
-	//retval = usbssp_mem_init(usbssp_data, GFP_KERNEL);
+	retval = usbssp_mem_init(usbssp_data, GFP_KERNEL);
 
 	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
 			"Finished usbssp_init");
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index ce0ac6883efc..04cc9f3e0f08 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1676,12 +1676,16 @@ static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
 void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 		void (*trace)(struct va_format *),
 		const char *fmt, ...);
+/* USBSSP memory management */
+void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
+int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
 /* USBSSP Device controller glue */
 void usbssp_bottom_irq(struct work_struct *work);
 int usbssp_init(struct usbssp_udc *usbssp_data);
 void usbssp_stop(struct usbssp_udc *usbssp_data);
 int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
 void usbssp_quiesce(struct usbssp_udc *usbssp_data);
+int usbssp_halt(struct usbssp_udc *usbssp_data);
 extern int usbssp_reset(struct usbssp_udc *usbssp_data);
 
 int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
@@ -1692,6 +1696,7 @@ irqreturn_t usbssp_irq(int irq, void *priv);
 /* USBSSP ring, segment, TRB, and TD functions */
 dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 		union usbssp_trb *trb);
+void usbssp_handle_command_timeout(struct work_struct *work);
 
 /* USBSSP gadget interface*/
 int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
-- 
2.17.1

