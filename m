Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4B7ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADDA20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="inijTAvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADDA20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeJ3B2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:28:36 -0400
Received: from mail-dm3nam03on0067.outbound.protection.outlook.com ([104.47.41.67]:13011
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728022AbeJ3B2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4OVagrIYfDN0rU5jyTGjV06MpvDPVPPvLnXauSNFgM=;
 b=inijTAvid7qtR5sJbvgZn16B11l2+vGQcELug8UyZ8IH52bcwzReKZcjV5JaZQXDVdzICrlevegURl835L3/bi+VF3iCeSdNJx3Byg8Vwk20GX9J6zcx0R5hHDum0s0H5VvRZgsjqp274yFEnoEI4Ksg23EWS1gpdNxTCDfuZQU=
Received: from CY4PR03CA0076.namprd03.prod.outlook.com (2603:10b6:910:4d::17)
 by BLUPR03MB550.namprd03.prod.outlook.com (2a01:111:e400:880::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.24; Mon, 29 Oct
 2018 16:39:09 +0000
Received: from BL2FFO11FD023.protection.gbl (2a01:111:f400:7c09::199) by
 CY4PR03CA0076.outlook.office365.com (2603:10b6:910:4d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1273.21 via Frontend Transport; Mon, 29 Oct 2018 16:39:08 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD023.mail.protection.outlook.com (10.173.161.102) with Microsoft
 SMTP Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1294.14 via Frontend Transport; Mon, 29 Oct 2018 16:39:08 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w9TGd8e5009747
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 29 Oct 2018 09:39:08 -0700
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 29 Oct 2018
 12:39:07 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 2/3] iio: adc: Add ad7124 support
Date:   Mon, 29 Oct 2018 18:38:31 +0200
Message-ID: <1540831111-3040-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(136003)(396003)(346002)(2980300002)(438002)(189003)(199004)(37524003)(5660300001)(26005)(1720100001)(4744004)(6666004)(356004)(305945005)(7636002)(186003)(426003)(336012)(14444005)(6306002)(4326008)(6346003)(107886003)(77096007)(7696005)(478600001)(23676004)(966005)(5820100001)(53416004)(2906002)(8676002)(106466001)(575784001)(476003)(126002)(486006)(316002)(2351001)(106002)(54906003)(72206003)(47776003)(36756003)(2870700001)(50466002)(246002)(50226002)(8936002)(2616005)(44832011)(6916009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB550;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD023;1:aO90HDSZRn+2th+RIjqt0FSlr7SUznDj7o8O6w6bZsvFqETOvP4QrO4Mfc86zkLtnSwiwGlRXDf5s89Hf6hL5/cCd0WliYdHL82n685g5ofJxUdhEIZEXfb0iEqeNiwK
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82cf870a-0a51-423b-48c5-08d63dbd0c7b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;3:fXbmlBfOs5BrIe6fBfmwFy0BDHtU5DjCELnmIU0nOyQMqLF2dn/Pz50KSSf572defK11rKb6hkeJSBLynEg7ldusqWgMZcLezh+Gwpik/t2Ek7g56j7zn6sH+zbDgUoZ0YwdAiU3Y//CDT68OvjlTwVqIm1cq6OLAeEIwU3wvj3vWG0H1NLq9k5MuYDxHL0iMrZUiHaiVYRmRZL1lYJt2yVaHKb57rhOMyrlUYL4sLYfD0BETHhVCZ+KZCzxYD8xpdKhfbsPNJ60fmdWQ5AvmXuoiX5cy7cz/oJHIakQuEq6qBglYbhulGYCItXWMBw48SMhqKshCf41dJYQ2FRAEBW+Qph+le2fo6kflYbYz7g=;25:+Phhjje72Z1z6n6g6o5NEVqdlEQyMUW8Ji0muDx+YpuJktJkzHnJ3Z/J5h36tkTenKh7zc22FutdD/myU9YxPmHVsW8a1+p8ovcFjDx7firNpNoPLFpRL6e4c1E30riUP5sSHbVM79HWNESgh4uRPU0gSqQCu3pGdL7jv0+kom4H8/8TEvVNJfxTcNOuPCNvIXiPV2VirENoYnQsjyyY5bjbnTMaYgx4K9ll9u0RLxrppjmif485I2DSi4afrVAiTxpbvEkUoinx6mZiAB38x2U3pD8VaBEM6xclInxqKkcDA2kqSR+RV1UNHPrCgm967QxHAKKb9JwIvBAGeKgMYQ==
X-MS-TrafficTypeDiagnostic: BLUPR03MB550:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;31:WVvbz3WZXzC4ozj/e7HcmFL18ZPQG/IvTa/3VZZUJxhGhYvFPdEw9X63uCf6WBUOGnnjlHQGX+tUaJf5qX7soO7OkFTk+feBvr/PUqK6R+aAcNe7lh4KaiWKSIkNBEX/8YNrrjexHXO9Jr9sQenFFJ37b5LkMD/a8rYZsL+ZTA5T/0Blu48hYE6FYJLxWkn88sPFOkkZdSi4rEdM06tJHt+AWqo5WTZ/AmmqXllyC78=;20:craFtu5cnnnfSJLzdimJS5B7kg/GJzz/H/x9yHr0Qs+x0P2+Ul85lzwsK0HjR/i3Jwq5VP8oYjeMuJoWH7hD2nxiEPiBHx6w0DHe1WvVj2/hSPjA6X2Lbk+oLNyiuZJukPB/CWD7pI4pxc0uc0IVuG/oVXxsaUBCD98XC8MgYaChrNajL+5wTfXZ4IR+xtpcd6NjcOAL6ERzk6xv1xW2mF2igxCHoijfmcrDhShPkbHVaxUkZIFwg+1UaOA3fOonss9sKQ7iDanhHRGCGlXZPytBfY4E7+vuDrL4zGmdFltUEXCbCsURyCUQk5dywZvjTNDb+/MB0wnyHHKcmrn8hv3ePkIaTtqb52+7ONluvBv5Y/yPTvDev0NB7tWC1MUfVS8LneTttVIAQoqRu1EJEAgDT1UAJUhMbAyH3mzU+Ytg9zaToTOFL1vtilPv9bYWsnXGadpJC2plbI8Hb5MU9O81V8FJqOjKs4Ndm8s0Sc514+FSiGWGCbuFJPvriCLM
X-Microsoft-Antispam-PRVS: <BLUPR03MB550AA7C02EA85A2182B027B9DF30@BLUPR03MB550.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(232431446821674)(9452136761055)(170811661138872)(95692535739014);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231382)(944501410)(4982022)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR03MB550;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB550;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;4:4kNH5O3cvxDB6DQP87Ctt3BoEOSBps546P3xw61gt1VSBZo7V9GuJ0qKm+pcIEwRYKubCI2xa4YlC5bylLmbr2r4wcVTieYRm2Q/SWY6GvPzv10XoqHBxHG5u+JUbh0PPV06sEmiAWjnDCpK1nguz/ZaGjVe+YSTDx+OtJUO9uW9tFGg7EwLgcRUpIPr3wsSla9N8yKqnmgU/YtguAjuNlsbS5JXzW3Ow1ItiHDNzNlciN5/bHSNoeyGoJ9SjbTGiKnjpUJRYl4sHa8lAZZn7pcQ8an9HXgCyRUp3ISCU5kjGJ6XO94gtbYayk32ttHjhFrSpltcAiONPW3neGtgTW+vbnCGKBJCQwJELXTRUefmXLxKX/ESGVrZArim4Y/WPW9fGp5v0pcOyrBtbdoiYEzto/3CsirH4EIpx2W8Qh3e5h4OZDqDXgokW+E4lLP2I4UPLWnc2Q08Bp9jQdeZWA==
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAzTUI1NTA7MjM6UGJhMm1sTjlsOHlMM1Y2SUxUTGNIQ2N5VVhu?=
 =?utf-8?B?VVZrWWcrU252TENIdGNvallEK254Y1lEUG9HSm9ndHYxajVFWCtHbUhLcldk?=
 =?utf-8?B?UzN5SGJINUdnOWNMa3lkSFdlbk1SbjdkdC9EaE16OVE4Q2Y0aEZHdUw0TVM0?=
 =?utf-8?B?SnU0RWczODU2NlNXR3E5YnF0dlQvZmtRa1UxdWxhcmp5dmlHNGF4OHJydldp?=
 =?utf-8?B?am8wR0tPRlRkRm1jc21KOEdKZWtJUTZlL1M0RkpNWE5EcnR4UTJOTGY0aDZO?=
 =?utf-8?B?YVlidzRkaCt6MWtSTjRDK1BxdTBZbzFMUTlKU24rYVVYbFpmZy95Ynd1dS9p?=
 =?utf-8?B?VmFCcVF5bWZXRWtDU1l2VDYxSlJ1OFc1SjAraG0zSzRjMXNTT2dIQ1YzWnJD?=
 =?utf-8?B?OGxHTGY3ZTJOMDJxN2FqeC9KRTVuSG5vT0k2UUJObzg5OXA3RWxUWmFBU0M2?=
 =?utf-8?B?MmR4ek1IbWwrSlZ3NTFxQWVGNEJiYXpLVDNhR3Q0T0cvZjBvbDFXaDZoemxE?=
 =?utf-8?B?aFhHNEVQQmYwZWdmTVlNUDBIZXNpT28wTHZTcmkzS0VRd1VUN0dVZjJVNlgy?=
 =?utf-8?B?Rll5ckRhYkc5emJLUDhieHloZ3doRWZOYiswZGcrL2xpWER6RDRwRUY4OHZY?=
 =?utf-8?B?WmhrZFpCdG9QSGxYajJsOVoxTUJwUUIrdm1ZK0tqRS83MHpoeUdWckpNMDFl?=
 =?utf-8?B?VWlSY3JQRW85MkEvejhTdkFCSEI1YTJyQlVOU0kzRk44a1dPRUEyYkVqMHdu?=
 =?utf-8?B?Q1NpSDEzbG9VWTdOTTg0NmgvRkJubEovWWF6a3dlOXUxdjlnd3NwdFRiaDRs?=
 =?utf-8?B?eEdtN2JDY01xdHRycWJpYWhqbTMvMHlCUXJKM2xLbkcvaWdvZ2xEV040dHJY?=
 =?utf-8?B?RlU5TlFhNnJaL2R3eXYrWG5KRDh6TS9MVlVkbUtKSzJpdUdsbGl4Y2x1eW5P?=
 =?utf-8?B?NWNXUHpEblNGcHRMM0tJZTRUSmhLMklBeE01akxmOWZnQ2pFZUdnaXl4OER5?=
 =?utf-8?B?MEh6bHRaS0wxMTNBRWpyU3dCQkhuZHlDSEd4S2RUcjYvbEhiR1dqb01sYzJp?=
 =?utf-8?B?RmFLd1VMNVhGY3BLc3draldQWUVCdGxPd0VxSlBqZnhNb0E2RWRpSFFtNzgw?=
 =?utf-8?B?YkRuRXRMVVBoVmtUUDk2Q1MvZGpOcXgzbmpxWFEzbmplRHY1MHZza1dqZkFE?=
 =?utf-8?B?SW1BRlhuU0dJNUVWV1MvT2w5MnlPbzBVVWJZZ2hJYTFMWnhTMXBiN1lvZ28v?=
 =?utf-8?B?cXBlMEkyUVBxdXR5MytTQUNYaHhTVXVuTU5lU0ZOclVtSmEzV2tPdFJ2d0Fj?=
 =?utf-8?B?TXFsbE1Feis3cFVQaHREdDZuWGlBcWV2d0hlTU1ZMFV6OXRvdW9DWkl4VE9W?=
 =?utf-8?B?MVcwV2FuTnlrUXhiMlgzdExKYk5YenVJOTYzVmxBc3RHZEJWOHZMcW16N2R5?=
 =?utf-8?B?THlSa2lyMTVwaDFiSko5MG9tQU8vK1JPelBmdkNOaXErbjdWbTVWOUNRK1Ev?=
 =?utf-8?B?eGJSTDBIdFZaam1VV0R0eU56NVNnMVVwZTgyNVREU3pvQnM1ckVxb0Zya2pJ?=
 =?utf-8?B?QUJUL2QxVk9vdTNRRHVaWDF5dzhOTVpKdlVvSWlvbGxLdUVUVjBXSUtBSWR0?=
 =?utf-8?B?TDd5ZEhGMHUzU2Nndi9CaE9ZakZzTnFBOTU2bGpmQWo0akN6bEFvUjZCZlgz?=
 =?utf-8?B?TFQ0Um1OZ29OS0x6V3JtTThwZ1M3ZUYxZ3U5dHl5Z1o2NktIT3JWWHU3eSt1?=
 =?utf-8?Q?YgHAlgTvXU5jkDKr9lj8tScra+koJJb+EYfA=3D?=
X-Microsoft-Antispam-Message-Info: ZISdo1xTFtKvFg3Ps/xTLuIReh/fz3NfpHLoQAZVnw5OJWAoywUn+gYOM+CtXu2SH4lxplXQKFaD+KYmYHu7HQFtuez+X3wgTZJuhgzrZiStzZc7s1Bjx8JuXQ5APJJVAyeEi9+Vw8tsHOc/daH0715I9RANjY1GFfTTtCmaz9lSwD/ohmQUW63cKaL6H+VC3N5bC7eBg+nNvXp/g/aLshq0Bt9l2gCBO4JevZwJJF+7oYqdUPyWakpVvV4WDSjbkwzt6kuCtGEIpYQR2IrAKQbH9VUVzc1np5JRo8MkNTiDdKhxH3x8npkDUGJrTmaFplwz6016lk6KbalHjWsISkfAxrCnWJ9B/pMYh2VD4tM=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB550;6:L9oB8tXunOSn1ie2AhzX1Iu11YL2Eo2W4pD5umbqgQXGuiWyP6DHEPeKFChcrMC9ZGwmJm/CgrEn4U8N6jj2RyExobVa4myOWbaVm0UfjnHXG/uAhCymqWvNmiZ6ld6Key+L3ssTAt+mcbCPsSHAvSHsXi34cEnJ8qXGRtJ61TRhFO/3P4pGKwo8qykEkXmuOKjs5tDBqbWr5B9dWmnBQnOOcggDq06srZ14pO8TZFwz5EFdffFVYZXYJDREVQefyefxPbpZcB1RT1JYsFEiUoW216fOnzA7daFNX3Pbh9VEVfvk4AuKUaVoaVJRJGYro/G+gVS3jfIVKjdPcVMu7rJyMIZrN6FAOPDTJkUPK8snGRvlBGfY+P9CBKWUnsGs6u1dxuDW4Esj0ixv3jBlGBdarCjZDEXAAccH/zX2Afv33Q7DKCjyWwnDJa8OMxnY/t7oZdDsjPi1A+8AAGPNeg==;5:+mVQz7PVghgR11z5RsHdAFBl8irt68FGwORbXpHVTpsSpykH4RA/cLjyt5Qv5cJQ13BLXg6837Dl55SqGtV9oaiQAwaHAkO+fm5MFuziTuFy4bluXlPAJ0SwBWwZyJrdhJ9OsCvX3qo3hzBlVk403s7AdBMtxowraYxRrpQMTM8=;7:pTq7h/A20VyrrU9fxyUcyzPoY/jc8W6QDYVV4+cGbFJQnqGa0wQ2QwYVAog3cMDU8HMZeAS0n7+vTEqsa6M4W7tqe8+oT6k0UlSdpA2P+gOxaErgz4Hg65pLaJzi1BF3B0r9h9Lm4mP2KWb2i/WYqA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 16:39:08.5930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cf870a-0a51-423b-48c5-08d63dbd0c7b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad7124-4 and ad7124-8 are a family of 4 and 8 channel sigma-delta ADCs
with 24-bit precision and reference.

Three power modes are available which in turn affect the output data rate:
 * Full power: 9.38 SPS to 19,200 SPS
 * Mid power: 2.34 SPS to 4800 SPS
 * Low power: 1.17 SPS to 2400 SPS

The ad7124-4 can be configured to have four differential inputs, while
ad7124-8 can have 8. Moreover, ad7124 also supports per channel
configuration. Each configuration consists of gain, reference source,
output data rate and bipolar/unipolar configuration.

Datasheets:
Link: http://www.analog.com/media/en/technical-documentation/data-sheets/AD7124-4.pdf
Link: http://www.analog.com/media/en/technical-documentation/data-sheets/ad7124-8.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Added this commit.
Changes in v3:
	- Removed channel, address, scan_index and shift fields from
	  ad7124_channel_template.
	- Added a sanity check for val2 in ad7124_write_raw().
	- Used the "reg" property to get the channel address and "adi,diff-channels"
	  for the differential pins. The "adi,channel-number" property was removed.
	- When calling regulator_get_optional, the probe is given up in case of error,
	  but continues in case of -ENODEV.
	- clk_disable_unprepare() is called before ad_sd_cleanup_buffer_and_trigger
	  in ad7124_remove().

 MAINTAINERS              |   7 +
 drivers/iio/adc/Kconfig  |  11 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7124.c | 648 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 667 insertions(+)
 create mode 100644 drivers/iio/adc/ad7124.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f642044..3a1bfcb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -839,6 +839,13 @@ S:	Supported
 F:	drivers/iio/dac/ad5758.c
 F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
 
+ANALOG DEVICES INC AD7124 DRIVER
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-iio@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/iio/adc/ad7124.c
+
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a52fea8..148a10f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -10,6 +10,17 @@ config AD_SIGMA_DELTA
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 
+config AD7124
+	tristate "Analog Devices AD7124 and similar sigma-delta ADCs driver"
+	depends on SPI_MASTER
+	select AD_SIGMA_DELTA
+	help
+	  Say yes here to build support for Analog Devices AD7124-4 and AD7124-8
+	  SPI analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7124.
+
 config AD7266
 	tristate "Analog Devices AD7265/AD7266 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index a6e6a0b..76168b2 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -5,6 +5,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
+obj-$(CONFIG_AD7124) += ad7124.o
 obj-$(CONFIG_AD7266) += ad7266.o
 obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7298) += ad7298.o
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
new file mode 100644
index 0000000..0660135
--- /dev/null
+++ b/drivers/iio/adc/ad7124.c
@@ -0,0 +1,648 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD7124 SPI ADC driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/adc/ad_sigma_delta.h>
+#include <linux/iio/sysfs.h>
+
+/* AD7124 registers */
+#define AD7124_COMMS			0x00
+#define AD7124_STATUS			0x00
+#define AD7124_ADC_CONTROL		0x01
+#define AD7124_DATA			0x02
+#define AD7124_IO_CONTROL_1		0x03
+#define AD7124_IO_CONTROL_2		0x04
+#define AD7124_ID			0x05
+#define AD7124_ERROR			0x06
+#define AD7124_ERROR_EN		0x07
+#define AD7124_MCLK_COUNT		0x08
+#define AD7124_CHANNEL(x)		(0x09 + (x))
+#define AD7124_CONFIG(x)		(0x19 + (x))
+#define AD7124_FILTER(x)		(0x21 + (x))
+#define AD7124_OFFSET(x)		(0x29 + (x))
+#define AD7124_GAIN(x)			(0x31 + (x))
+
+/* AD7124_STATUS */
+#define AD7124_STATUS_POR_FLAG_MSK	BIT(4)
+
+/* AD7124_ADC_CONTROL */
+#define AD7124_ADC_CTRL_PWR_MSK	GENMASK(7, 6)
+#define AD7124_ADC_CTRL_PWR(x)		FIELD_PREP(AD7124_ADC_CTRL_PWR_MSK, x)
+#define AD7124_ADC_CTRL_MODE_MSK	GENMASK(5, 2)
+#define AD7124_ADC_CTRL_MODE(x)	FIELD_PREP(AD7124_ADC_CTRL_MODE_MSK, x)
+
+/* AD7124_CHANNEL_X */
+#define AD7124_CHANNEL_EN_MSK		BIT(15)
+#define AD7124_CHANNEL_EN(x)		FIELD_PREP(AD7124_CHANNEL_EN_MSK, x)
+#define AD7124_CHANNEL_SETUP_MSK	GENMASK(14, 12)
+#define AD7124_CHANNEL_SETUP(x)	FIELD_PREP(AD7124_CHANNEL_SETUP_MSK, x)
+#define AD7124_CHANNEL_AINP_MSK	GENMASK(9, 5)
+#define AD7124_CHANNEL_AINP(x)		FIELD_PREP(AD7124_CHANNEL_AINP_MSK, x)
+#define AD7124_CHANNEL_AINM_MSK	GENMASK(4, 0)
+#define AD7124_CHANNEL_AINM(x)		FIELD_PREP(AD7124_CHANNEL_AINM_MSK, x)
+
+/* AD7124_CONFIG_X */
+#define AD7124_CONFIG_BIPOLAR_MSK	BIT(11)
+#define AD7124_CONFIG_BIPOLAR(x)	FIELD_PREP(AD7124_CONFIG_BIPOLAR_MSK, x)
+#define AD7124_CONFIG_REF_SEL_MSK	GENMASK(4, 3)
+#define AD7124_CONFIG_REF_SEL(x)	FIELD_PREP(AD7124_CONFIG_REF_SEL_MSK, x)
+#define AD7124_CONFIG_PGA_MSK		GENMASK(2, 0)
+#define AD7124_CONFIG_PGA(x)		FIELD_PREP(AD7124_CONFIG_PGA_MSK, x)
+
+/* AD7124_FILTER_X */
+#define AD7124_FILTER_FS_MSK		GENMASK(10, 0)
+#define AD7124_FILTER_FS(x)		FIELD_PREP(AD7124_FILTER_FS_MSK, x)
+
+enum ad7124_ids {
+	ID_AD7124_4,
+	ID_AD7124_8,
+};
+
+enum ad7124_ref_sel {
+	AD7124_REFIN1,
+	AD7124_REFIN2,
+	AD7124_INT_REF,
+	AD7124_AVDD_REF,
+};
+
+enum ad7124_power_mode {
+	AD7124_LOW_POWER,
+	AD7124_MID_POWER,
+	AD7124_FULL_POWER,
+};
+
+static const unsigned int ad7124_gain[8] = {
+	1, 2, 4, 8, 16, 32, 64, 128
+};
+
+static const int ad7124_master_clk_freq_hz[3] = {
+	[AD7124_LOW_POWER] = 76800,
+	[AD7124_MID_POWER] = 153600,
+	[AD7124_FULL_POWER] = 614400,
+};
+
+static const char * const ad7124_ref_names[] = {
+	[AD7124_REFIN1] = "refin1",
+	[AD7124_REFIN2] = "refin2",
+	[AD7124_INT_REF] = "int",
+	[AD7124_AVDD_REF] = "avdd",
+};
+
+struct ad7124_chip_info {
+	unsigned int num_inputs;
+};
+
+struct ad7124_channel_config {
+	enum ad7124_ref_sel refsel;
+	bool bipolar;
+	unsigned int ain;
+	unsigned int vref_mv;
+	unsigned int pga_bits;
+	unsigned int odr;
+};
+
+struct ad7124_state {
+	const struct ad7124_chip_info *chip_info;
+	struct ad_sigma_delta sd;
+	struct ad7124_channel_config channel_config[4];
+	struct regulator *vref[4];
+	struct clk *mclk;
+	unsigned int adc_control;
+	unsigned int num_channels;
+};
+
+static const struct iio_chan_spec ad7124_channel_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.differential = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.scan_type = {
+		.sign = 'u',
+		.realbits = 24,
+		.storagebits = 32,
+	},
+};
+
+static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
+	[ID_AD7124_4] = {
+		.num_inputs = 8,
+	},
+	[ID_AD7124_8] = {
+		.num_inputs = 16,
+	},
+};
+
+static int ad7124_find_closest_match(const int *array,
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
+static int ad7124_spi_write_mask(struct ad7124_state *st,
+				 unsigned int addr,
+				 unsigned long mask,
+				 unsigned int val,
+				 unsigned int bytes)
+{
+	unsigned int readval;
+	int ret;
+
+	ret = ad_sd_read_reg(&st->sd, addr, bytes, &readval);
+	if (ret < 0)
+		return ret;
+
+	readval &= ~mask;
+	readval |= val;
+
+	return ad_sd_write_reg(&st->sd, addr, bytes, readval);
+}
+
+static int ad7124_set_mode(struct ad_sigma_delta *sd,
+			   enum ad_sigma_delta_mode mode)
+{
+	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
+
+	st->adc_control &= ~AD7124_ADC_CTRL_MODE_MSK;
+	st->adc_control |= AD7124_ADC_CTRL_MODE(mode);
+
+	return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
+}
+
+static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
+{
+	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
+	unsigned int val;
+
+	val = st->channel_config[channel].ain | AD7124_CHANNEL_EN(1) |
+	      AD7124_CHANNEL_SETUP(channel);
+
+	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(channel), 2, val);
+}
+
+static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
+	.set_channel = ad7124_set_channel,
+	.set_mode = ad7124_set_mode,
+	.has_registers = true,
+	.addr_shift = 0,
+	.read_mask = BIT(6),
+	.data_reg = AD7124_DATA,
+};
+
+static int ad7124_set_channel_odr(struct ad7124_state *st,
+				  unsigned int channel,
+				  unsigned int odr)
+{
+	unsigned int fclk, odr_sel_bits;
+	int ret;
+
+	fclk = clk_get_rate(st->mclk);
+	/*
+	 * FS[10:0] = fCLK / (fADC x 32) where:
+	 * fADC is the output data rate
+	 * fCLK is the master clock frequency
+	 * FS[10:0] are the bits in the filter register
+	 * FS[10:0] can have a value from 1 to 2047
+	 */
+	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * 32);
+	if (odr_sel_bits < 1)
+		odr_sel_bits = 1;
+	else if (odr_sel_bits > 2047)
+		odr_sel_bits = 2047;
+
+	ret = ad7124_spi_write_mask(st, AD7124_FILTER(channel),
+				    AD7124_FILTER_FS_MSK,
+				    AD7124_FILTER_FS(odr_sel_bits), 3);
+	if (ret < 0)
+		return ret;
+	/* fADC = fCLK / (FS[10:0] x 32) */
+	st->channel_config[channel].odr =
+		DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
+
+	return 0;
+}
+
+static int ad7124_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+	int idx, ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ad_sigma_delta_single_conversion(indio_dev, chan, val);
+		if (ret < 0)
+			return ret;
+
+		/* After the conversion is performed, disable the channel */
+		ret = ad_sd_write_reg(&st->sd,
+				      AD7124_CHANNEL(chan->address), 2,
+				      st->channel_config[chan->address].ain |
+				      AD7124_CHANNEL_EN(0));
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		idx = st->channel_config[chan->address].pga_bits;
+		*val = st->channel_config[chan->address].vref_mv /
+			ad7124_gain[idx];
+		if (st->channel_config[chan->address].bipolar)
+			*val2 = chan->scan_type.realbits - 1;
+		else
+			*val2 = chan->scan_type.realbits;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		if (st->channel_config[chan->address].bipolar) {
+			/* Code = 2^(n − 1) × ((Ain × Gain / Vref) + 1) */
+			idx = st->channel_config[chan->address].pga_bits;
+			*val = -(st->channel_config[chan->address].vref_mv /
+				 ad7124_gain[idx]);
+		} else {
+			*val = 0;
+		}
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->channel_config[chan->address].odr;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7124_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2 != 0)
+			return -EINVAL;
+
+		return ad7124_set_channel_odr(st, chan->address, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad7124_info = {
+	.read_raw = ad7124_read_raw,
+	.write_raw = ad7124_write_raw,
+};
+
+static int ad7124_soft_reset(struct ad7124_state *st)
+{
+	unsigned int readval, timeout;
+	int ret;
+
+	ret = ad_sd_reset(&st->sd, 64);
+	if (ret < 0)
+		return ret;
+
+	timeout = 100;
+	do {
+		ret = ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readval);
+		if (ret < 0)
+			return ret;
+
+		if (!(readval & AD7124_STATUS_POR_FLAG_MSK))
+			return 0;
+
+		/* The AD7124 requires typically 2ms to power up and settle */
+		usleep_range(100, 2000);
+	} while (--timeout);
+
+	dev_err(&st->sd.spi->dev, "Soft reset failed\n");
+
+	return -EIO;
+}
+
+static int ad7124_init_channel_vref(struct ad7124_state *st,
+				    unsigned int channel_number)
+{
+	unsigned int refsel = st->channel_config[channel_number].refsel;
+
+	switch (refsel) {
+	case AD7124_REFIN1:
+	case AD7124_REFIN2:
+	case AD7124_AVDD_REF:
+		if (IS_ERR(st->vref[refsel])) {
+			dev_err(&st->sd.spi->dev,
+				"Error, trying to use external voltage reference without a %s regulator.",
+				ad7124_ref_names[refsel]);
+				return PTR_ERR(st->vref[refsel]);
+		}
+		st->channel_config[channel_number].vref_mv =
+			regulator_get_voltage(st->vref[refsel]);
+		/* Conversion from uV to mV */
+		st->channel_config[channel_number].vref_mv /= 1000;
+		break;
+	case AD7124_INT_REF:
+		st->channel_config[channel_number].vref_mv = 2500;
+		break;
+	default:
+		dev_err(&st->sd.spi->dev, "Invalid reference %d\n", refsel);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
+					  struct device_node *np)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+	struct device_node *child;
+	struct iio_chan_spec *chan;
+	unsigned int ain[2], channel = 0, tmp;
+	int ret, res;
+
+	st->num_channels = of_get_available_child_count(np);
+	if (!st->num_channels) {
+		dev_err(indio_dev->dev.parent, "no channel children\n");
+		return -ENODEV;
+	}
+
+	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
+			    sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return -ENOMEM;
+
+	indio_dev->channels = chan;
+	indio_dev->num_channels = st->num_channels;
+
+	for_each_available_child_of_node(np, child) {
+		ret = of_property_read_u32(child, "reg", &channel);
+		if (ret)
+			goto err;
+
+		ret = of_property_read_u32_array(child, "adi,diff-channels",
+						 ain, 2);
+		if (ret)
+			goto err;
+
+		if (ain[0] >= st->chip_info->num_inputs ||
+		    ain[1] >= st->chip_info->num_inputs) {
+			dev_err(indio_dev->dev.parent,
+				"Input pin number out of range.\n");
+			ret = -EINVAL;
+			goto err;
+		}
+		st->channel_config[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
+						  AD7124_CHANNEL_AINM(ain[1]);
+		st->channel_config[channel].bipolar =
+			of_property_read_bool(child, "adi,bipolar");
+
+		ret = of_property_read_u32(child, "adi,reference-select", &tmp);
+		if (ret)
+			st->channel_config[channel].refsel = AD7124_INT_REF;
+		else
+			st->channel_config[channel].refsel = tmp;
+
+		ret = of_property_read_u32(child, "adi,gain", &tmp);
+		if (ret) {
+			st->channel_config[channel].pga_bits = 0;
+		} else {
+			res = ad7124_find_closest_match(ad7124_gain,
+						ARRAY_SIZE(ad7124_gain), tmp);
+			st->channel_config[channel].pga_bits = res;
+		}
+
+		ret = of_property_read_u32(child, "adi,odr-hz", &tmp);
+		if (ret)
+			/*
+			 * 9 SPS is the minimum output data rate supported
+			 * regardless of the selected power mode.
+			 */
+			st->channel_config[channel].odr = 9;
+		else
+			st->channel_config[channel].odr = tmp;
+
+		*chan = ad7124_channel_template;
+		chan->address = channel;
+		chan->scan_index = channel;
+		chan->channel = ain[0];
+		chan->channel2 = ain[1];
+
+		chan++;
+	}
+
+	return 0;
+err:
+	of_node_put(child);
+
+	return ret;
+}
+
+static int ad7124_setup(struct ad7124_state *st)
+{
+	unsigned int val, fclk, power_mode;
+	int i, ret;
+
+	fclk = clk_get_rate(st->mclk);
+	if (!fclk)
+		return -EINVAL;
+
+	/* The power mode changes the master clock frequency */
+	power_mode = ad7124_find_closest_match(ad7124_master_clk_freq_hz,
+					ARRAY_SIZE(ad7124_master_clk_freq_hz),
+					fclk);
+	if (fclk != ad7124_master_clk_freq_hz[power_mode]) {
+		ret = clk_set_rate(st->mclk, fclk);
+		if (ret)
+			return ret;
+	}
+
+	/* Set the power mode */
+	st->adc_control &= ~AD7124_ADC_CTRL_PWR_MSK;
+	st->adc_control |= AD7124_ADC_CTRL_PWR(power_mode);
+	ret = ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL, 2, st->adc_control);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < st->num_channels; i++) {
+		val = st->channel_config[i].ain | AD7124_CHANNEL_SETUP(i);
+		ret = ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, val);
+		if (ret < 0)
+			return ret;
+
+		ret = ad7124_init_channel_vref(st, i);
+		if (ret < 0)
+			return ret;
+
+		val = AD7124_CONFIG_BIPOLAR(st->channel_config[i].bipolar) |
+		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel) |
+		      AD7124_CONFIG_PGA(st->channel_config[i].pga_bits);
+		ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(i), 2, val);
+		if (ret < 0)
+			return ret;
+
+		ret = ad7124_set_channel_odr(st, i, st->channel_config[i].odr);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int ad7124_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id;
+	struct ad7124_state *st;
+	struct iio_dev *indio_dev;
+	int i, ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	id = spi_get_device_id(spi);
+	st->chip_info = &ad7124_chip_info_tbl[id->driver_data];
+
+	ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
+
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad7124_info;
+
+	ret = ad7124_of_parse_channel_config(indio_dev, spi->dev.of_node);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(st->vref); i++) {
+		if (i != AD7124_INT_REF) {
+			st->vref[i] = devm_regulator_get_optional(&spi->dev,
+							ad7124_ref_names[i]);
+			if (PTR_ERR(st->vref[i]) == -ENODEV)
+				continue;
+			else if (IS_ERR(st->vref[i]))
+				return PTR_ERR(st->vref[i]);
+
+			ret = regulator_enable(st->vref[i]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	st->mclk = devm_clk_get(&spi->dev, "mclk");
+	if (IS_ERR(st->mclk)) {
+		ret = PTR_ERR(st->mclk);
+		goto error_regulator_disable;
+	}
+
+	ret = clk_prepare_enable(st->mclk);
+	if (ret < 0)
+		goto error_regulator_disable;
+
+	ret = ad7124_soft_reset(st);
+	if (ret < 0)
+		goto error_clk_disable_unprepare;
+
+	ret = ad7124_setup(st);
+	if (ret < 0)
+		goto error_clk_disable_unprepare;
+
+	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	if (ret < 0)
+		goto error_clk_disable_unprepare;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&spi->dev, "Failed to register iio device\n");
+		goto error_remove_trigger;
+	}
+
+	return 0;
+
+error_remove_trigger:
+	ad_sd_cleanup_buffer_and_trigger(indio_dev);
+error_clk_disable_unprepare:
+	clk_disable_unprepare(st->mclk);
+error_regulator_disable:
+	for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
+		if (!IS_ERR_OR_NULL(st->vref[i]))
+			regulator_disable(st->vref[i]);
+	}
+
+	return ret;
+}
+
+static int ad7124_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7124_state *st = iio_priv(indio_dev);
+	int i;
+
+	iio_device_unregister(indio_dev);
+	clk_disable_unprepare(st->mclk);
+	ad_sd_cleanup_buffer_and_trigger(indio_dev);
+
+	for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
+		if (!IS_ERR_OR_NULL(st->vref[i]))
+			regulator_disable(st->vref[i]);
+	}
+
+	return 0;
+}
+
+static const struct spi_device_id ad7124_id_table[] = {
+	{ "ad7124-4", ID_AD7124_4 },
+	{ "ad7124-8", ID_AD7124_8 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad7124_id_table);
+
+static const struct of_device_id ad7124_of_match[] = {
+	{ .compatible = "adi,ad7124-4" },
+	{ .compatible = "adi,ad7124-8" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad7124_of_match);
+
+static struct spi_driver ad71124_driver = {
+	.driver = {
+		.name = "ad7124",
+		.of_match_table = ad7124_of_match,
+	},
+	.probe = ad7124_probe,
+	.remove	= ad7124_remove,
+	.id_table = ad7124_id_table,
+};
+module_spi_driver(ad71124_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7124 SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

