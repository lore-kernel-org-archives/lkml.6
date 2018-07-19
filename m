Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD085ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCA420684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="QtJREYZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCA420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388132AbeGSSp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:45:26 -0400
Received: from mail-eopbgr720044.outbound.protection.outlook.com ([40.107.72.44]:31566
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387873AbeGSSnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erpkw0p9aKNtIIOCtd1rDaiBNF2rMXxqzYWRx4OWLp0=;
 b=QtJREYZuYRk6x20J62JvDRfJUXEZpQ/EAJurPXtF/9NFKRqZ/q5157/X956DnWAcEwodXDrWHSNhEI43uvMrHugicESG/pLPL1S1f7WyJNFGxAasl8SfN+csIxgmXb3seFbuy2OKOsKuRwFteD5E90oG2UNAHQ327dKt7J4XRTc=
Received: from CY1PR07CA0031.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::41) by BN7PR07MB4707.namprd07.prod.outlook.com
 (2603:10b6:406:f0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 19 Jul
 2018 17:59:22 +0000
Received: from BY2NAM05FT033.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::202) by CY1PR07CA0031.outlook.office365.com
 (2a01:111:e400:c60a::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:22 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT033.mail.protection.outlook.com (10.152.100.170) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.995.0 via
 Frontend Transport; Thu, 19 Jul 2018 17:59:22 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAS8019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:21 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:29 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:29 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxEmk005885;
        Thu, 19 Jul 2018 18:59:14 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxEWu005883;
        Thu, 19 Jul 2018 18:59:14 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 18/31] usb: usbssp: added handling of Port Reset event.
Date:   Thu, 19 Jul 2018 18:57:51 +0100
Message-ID: <1532023084-28083-19-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(199004)(189003)(36092001)(316002)(16586007)(54906003)(87636003)(42186006)(50466002)(48376002)(86362001)(50226002)(1671002)(2906002)(575784001)(478600001)(26826003)(8676002)(126002)(305945005)(446003)(6666003)(356003)(11346002)(336012)(14444005)(26005)(47776003)(107886003)(5660300001)(109986005)(4326008)(7636002)(486006)(4720700003)(186003)(51416003)(106466001)(76176011)(36756003)(426003)(105596002)(8936002)(246002)(2616005)(476003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4707;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT033;1:YQfvad0m9ib9i1Oc3aMxlsP/8GyA/hv43wCpDLEK0Le9VjNC3zyrcFgY5Ci7gbp2aM+cU8uQJAXYZ57Kr81NTsOKeRkQK1Q7MgUo1EPtQq26KvOJxoK5YnGFuRmTNAeK
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 697f0fb9-065c-40d6-7d49-08d5eda15b53
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN7PR07MB4707;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;3:wTqNHv4mPKFzJMaSWxZsdo5H1uiSNlIYD4qr7mZ7HcpOOd+fVN+AzTNxStOWj2AWNh+ShTndkx4kqCpwmzk9oupSJDN7dlhZU8MT6BDsmB0O3Sd7WwHbsnQxwvNOYVfgMilaA4jErfBTjg+TJ04P1Tbjf+uBsq/UbFMnOou8Rs54RHGpWynvNiV/s9HImF+M0KXOILRUF0iCj+mqDfQPIWHCF3Pm5UJKjKBVPEBw+k4uzYusPZ9h02Ixd+BICLIp+23Bvv3he7SsRIDAK7XRq37vus2RGS6lQ/8WreRp+9CUh5xBwijvZn4CI2QZjQtS2ojqvnOBYrOW9Q9wdQI5a198Ob4XMW3vCT7RpZ5wd1g=;25:TmrYe+Wb3regGmiWY6GIvonlqMBkT+iEQzvufiJ7IbP0tiqakH8oL1Km9YSUJRuGscm/EIbNI0v1by2np5yoI5SZFsgFKoHNxX9JwaTOwkjOz2GbECtf3D+QRE0fHjoXP7dT/35tkfYt8SO5/ZRrrY4SDNiSHLl6fQZM+sPQ1cfxAWlGZvmeBSQVT+6Z9YX6Ps3or6r+HRS2xlaHjGZpdW25/S4V9ySBIhC+dtDvwAeBlJI1YuqZ3p+kZlwZAlqPKkeFnl61kKE1IYFYqo2HKmVEEPgKtOh/nudyjA/FqfevAPsmM2Gtd+AwK2I9guj951txYn4v3Zjjo/HyjMOXDg==
X-MS-TrafficTypeDiagnostic: BN7PR07MB4707:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;31:mrFR/+VkWLL/ALnrl6nWqCgSu/RgmuS2ajPL5QrNW9AXFZJJDCm3QuZv1kBriShkS6fqQUBsNSFgQ5EIBF5AFcKl164dg1iFF2OgULBZNxzAJ5PWW3ASTPl2PZsYOUbTcBRQVm9s4BWUgvO1CW9JAW9GcdN+c5ebWJh0gq1t9VGJh09t2UsDVZsGEKpJqs4gECr+xqy9oZvCwsKwWJVUHTu4ZtUTJ7gl3Yi+oedLCAo=;20:ggdePfK4vJvTAT/FL628Jmz+/FnlXMXv9yL2W03jLYgdjSo9s1QwplFoQF5Fo9+jRcJzdarxVwj8C6I8I34hBUP9/sLDHWts3OK0ld2KbMBgkfsEfGzwoZnYdY9/J5emKPd/0worQXrWP5Gio7NqxRDGqzm0vqi7cMGZE2DpGsVFCtOnByk22TGRy33C3kbbUxVRG5SdB097Q1b/4D3ZH7Yzgto/h7wr9AahcjylfoSfcRJc/jQyTrhTNFrJO37AOHPkZ24dSe0SJqT0o83+j7RdbnojV/tO+p5xSrVwTR8Z7RIoN8Otwmt/cgXAVQATX1biS1xYngVMQclXUSFsaJ/bLWTg1zUIF7FmVEKob+kmq4aEK425JvpPlQuFu6gsjiYqbgW2srreX/P8AMkNVByzgZ3EUBRTQf4f+LvieAJiVY7EnuyGmE4TQKwxbbBothK+VE8VRT1Q7uUC4fbEeMP42gXbeTAT6LTjnLebWVwT6SonQ5HDDtPi4VhQ7bHT
X-Microsoft-Antispam-PRVS: <BN7PR07MB470794F65C28B48237C0EB1CDD520@BN7PR07MB4707.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4707;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4707;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;4:5sZRk/5yL+mPsvxXKtWCMhCdXcc0wYy3oBT2An36tyzXnngak7oD0pqVxc3M/CBhVHCewDrp9wMwHdt8Qs80UyJrU1oKpTKsA8mpMyzvmXJE19E0hq4QfbcPBKrjdttyw0IjyiPuOsp59vP1C5ss27e2ewGpl1eTjL8dTv8HDWRAeSpocRj6xoaXhX95DQPXvdm6nXygVGuEyycTLShYTnyTROhPb2NDrSiNWsRZEzmF/AUXLqO+lzhvvK/50jlCL1S5YyItdSKRsC8yZhoK09A/sdvfKrlFHevN6cey8oiumBul3+3xnGnAsTVLSoFn
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4707;23:AZTZ6CJptqLzTUZvpl99UQ0EXmUhnN8UfuIW2c5c9?=
 =?us-ascii?Q?uzv4dQ0LijSkJ4hJFI0dGrvkmvheI6SP+4kHLRW7fOOIPUp0nAPi9lLVgmsx?=
 =?us-ascii?Q?cyZyeiTYyr//Sb7FRyETSBMCBQbOGOoXELVCVJgYrZjT1JDBBBF2KJyQjiYD?=
 =?us-ascii?Q?W7DMuGFogKszHMqyrRnNYZp24JRMJy279qo6/JsDhWNw+t+NJkQSMtnjbZ0F?=
 =?us-ascii?Q?iXbTaTsOYaEu1c922CmxKekW4ObPkH7v/I8tJ+AWw6ucqD1Q+ehXwaWbDUsh?=
 =?us-ascii?Q?isXgQkkcht4cNeM0ywrrkul33zC0u0UiiYATNxuEy15Eil5jLoU2iuk8ikiU?=
 =?us-ascii?Q?0K5LoceOtwWkr/7Ux+GH16di7TybepyMD4+6Zj3hWAfna4n2AJE4jOISES6L?=
 =?us-ascii?Q?KhVpniB4zQS7+hGqzkJQdF8rAT1O5/HEOQrh3m5RcrypGmJyxrz6LO7uvTF0?=
 =?us-ascii?Q?J4u+7nscDaHZuS/8PwqLob5bm8bUbhaN93la0eHHDQYT6rM5fcgxWKRktLSi?=
 =?us-ascii?Q?+JjNXZdjmiF+PgL2WWbn7jEiAAflj3Mu/syitotPkr+4PHhVbxUTlBtGjqER?=
 =?us-ascii?Q?YbPxGVU/ej98SY/ldLMrzNycdPdkYM1Wsll6ng+u/M1bhJZNwBdRbaGqLe9k?=
 =?us-ascii?Q?yVSGd1+6DkuTt19368GXgIvJYhRsrCa787hMy5PSt8AE1wEuewQbfEQGcmr3?=
 =?us-ascii?Q?1VIsvTinjjtK0cadltaMysLnzhPKWBFQyOD+XS7GA4O5opVlktm3dPbzzDqw?=
 =?us-ascii?Q?vKOGPbo8dGcM0HdTMIqAJKkAqlfR4sv0Uv0OH0f5WVY7uPnjozUzyMtEtSww?=
 =?us-ascii?Q?afk6HSqM0IZusV0UwsKEj+VW2jujpHgSOeccoKfsZjDcVXkHyOALEh1prM/J?=
 =?us-ascii?Q?yOm2auK5FOKqTHA7P71AB6X1ynH/kY02e/lzmhqSazyDQOxXM5epTT3l/EqI?=
 =?us-ascii?Q?UpC0dGvqg89ykh+Ha43NWxAJVbRGtaZJwFXm477+Y2JgFGmMVrq6jf7UBsI8?=
 =?us-ascii?Q?qStO0QOXJ/qNhdZcBzPKfKGtOLHdi0Ni45UTqxAk2NwOXpv/Y5iWTMt+dNfx?=
 =?us-ascii?Q?kxsdI+0EmDLEZD+YJK5XZrmCvpK3v/sGKcC+JY9JlZC29a12ReooSeOD7MRt?=
 =?us-ascii?Q?M6e/U7dK7UU4HArL12WJ0IarrNfM/Zy9r98rwHYev9FReErszX+5M6OO867Q?=
 =?us-ascii?Q?I5XNUjBdinIjBs=3D?=
X-Microsoft-Antispam-Message-Info: uFcrA41dTxdKbYKW2qGQCnA1MyzhgGkEf20Y5aMZ5FTQ5O5Gkv7hnGzuJAHvXWBr1wBXOc9jF4IDDkcHzKl2oHBMbUAVZeZe68nEXb3dLkCxSOF3BRh7UXaORP1j39fAuEBltNSZVD4Fwe91RjJmQwl2jJoC3VazaIAf3mOWFTMfmzIo1eLS3ukXPFTlWojbx12OhLacIpwyF36NHHVBkuvjLAa1dAa5Vy703V2sn9KCSxEqxEOozt8p4+/MPeYUhQPWAN6kiDD2bCd1+63uJNyABMuggrU8hP24Nr8rfSEgOrI0wQsgWTSn9+JOYK47WJeMwrZZ00V8y6O1oWO1wGvKdJ4tuRNOG0wL7lmW4GgkYSajaOV0ucMsERFoqTCKdQ97Pkwyh8q0etYV0OzcWQ==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;6:GgK+xx5/mNRa+FqtSYxbX6+q3OGD0QPhMGgbtVPD72tx1aUOyYDimZuuWMqQ6Tn2ikMzREk4nFkV1yl9+PwiCPCRJNBolFsBmeY7RLIA2di5+cjo/AJCYj9v7MS4L296eF1t8/EOAL8VzUrBkZdxbRC1PFURkKYjVcGQl7zUj64Nw+LhGXnEMhDtgCD5+Pk9JMXChfMRVAqtmM2a0zPNAZUh/AL34qjmX/enHn2RG7d7JrpgM7+aUQp8Klt4CQLYExnTDTldt1ZodCkmsQEuDXVdn6jd1tbQuYdD6Lnpcps3s6VP7LXMFORp2r9an6gP5HzVQZuWuHCX/vK0XUzwQZV+vsJdTq83wFxuAwPy1NjDvcW3KmJJJQI86PtY77l90R/jCFmYPmW0lx64Qp7RnYcDPqMPizNLeM90TjffHFwmoVaUV4vGMTlFgdKaLln0lTywVfDriZrvR0SxuBotXQ==;5:l7o75TeRmHQi0SPwpw5ZlPvYBNqY9cVnpnHb56vtsou0zd8RNSYLGMq7Nt4MG5BqxRp75TUZTX00UFyWDPSK4jXVpzECPTDE1I1c+cAl1Hxk52HN9zcSCu4XdXtpkTLf4GhLaHGU4JXWwjwoE4G6LsTm5G2DM0esver/oTtIUjw=;24:KBVUwpkVXZQIzqf7zG8xIi7TFcbz4GaTwC2bQqrSjN9xm20bjccsnNAbxTLG6yaqaFdQLtl+8n49pg1F4egANiSj/xrJviZti9k+/tEd05w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4707;7:U50ADL/ptaGlehl6rIsFkL5Cuip0Xy8Pbk6xpNEQpn6KA4u5QFD+Z79Vm++rhsfLEACHk5zM1O4cHfa+emE8oxJVEtFDGu1PaLnMSKuLlXfMAdoSi/advhQ1uYsZCtEBAiQCfQz72A93xxWxnYBTGUTQqqJi7PW1nL7/d7m0H9DGHot9uEIY+TVQSF/Asw5ROpkRdKU2rYTIwffnRc17b3M3WtFQsKvi2bZMSv2IO9GzlpmuRi92yUz51haVlhMn;20:/VtgRpsiQDBjEdllvjPOUYYrbcUih6MBNkbQTicOPTqIwmAThklYQWgjAwNoVamkXmUfs+2PXwSelO+yuc5f1UVXjeoKVRtVGlvWCkKK3OQt2gvvsNv4MfrODkTYTSemxDUWapKYWEj6im5MDLbcCom6Knz9Z8ulS6ot0XNIpwHDyGLUfUly9xww+n2BWbOlxfh5z+lLmJu5y9pH5HmX0uGFO3fbiCP5qVZFIKJdLCbWD+K/WcEQFW/UBH3j3lyx
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:22.0040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697f0fb9-065c-40d6-7d49-08d5eda15b53
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4707
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds functionality used during resetting USB port.
During this process driver must finish all queued transfers,
and enter the controller to default state.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-dbg.c |   9 +
 drivers/usb/usbssp/gadget-mem.c | 101 +++++++++++
 drivers/usb/usbssp/gadget.c     | 305 +++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h     |  13 ++
 4 files changed, 427 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbssp/gadget-dbg.c b/drivers/usb/usbssp/gadget-dbg.c
index 277617d1a996..a425469d95d9 100644
--- a/drivers/usb/usbssp/gadget-dbg.c
+++ b/drivers/usb/usbssp/gadget-dbg.c
@@ -12,6 +12,15 @@
 
 #include "gadget.h"
 
+char *usbssp_get_slot_state(struct usbssp_udc *usbssp_data,
+			    struct usbssp_container_ctx *ctx)
+{
+	struct usbssp_slot_ctx *slot_ctx = usbssp_get_slot_ctx(usbssp_data, ctx);
+	int state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+
+	return usbssp_slot_state_string(state);
+}
+
 void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 		      void (*trace)(struct va_format *),
 		      const char *fmt, ...)
diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index 2c220582a5f8..858bee77b0dc 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -707,6 +707,107 @@ int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags)
 	return 0;
 }
 
+void usbssp_copy_ep0_dequeue_into_input_ctx(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *priv_dev;
+	struct usbssp_ep_ctx *ep0_ctx;
+	struct usbssp_ring *ep_ring;
+
+	priv_dev = &usbssp_data->devs;
+	ep0_ctx = usbssp_get_ep_ctx(usbssp_data, priv_dev->in_ctx, 0);
+	ep_ring = priv_dev->eps[0].ring;
+
+	/*
+	 * We don't keep track of the dequeue pointer very well after a
+	 * Set TR dequeue pointer, so we're setting the dequeue pointer of the
+	 * device to our enqueue pointer. This should only be called after a
+	 * configured device has reset, so all control transfers should have
+	 * been completed or cancelled before the reset.
+	 */
+	ep0_ctx->deq = cpu_to_le64(usbssp_trb_virt_to_dma(ep_ring->enq_seg,
+			ep_ring->enqueue) | ep_ring->cycle_state);
+}
+
+/* Setup an DC private device for a Set Address command */
+int usbssp_setup_addressable_priv_dev(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_ep_ctx *ep0_ctx;
+	struct usbssp_slot_ctx *slot_ctx;
+	u32 max_packets;
+
+	dev_priv = &usbssp_data->devs;
+	/* Slot ID 0 is reserved */
+	if (usbssp_data->slot_id == 0 || !dev_priv->gadget) {
+		dev_warn(usbssp_data->dev,
+			"Slot ID %d is not assigned to this device\n",
+			usbssp_data->slot_id);
+		return -EINVAL;
+	}
+
+	ep0_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->in_ctx, 0);
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->in_ctx);
+
+	/* 3) Only the control endpoint is valid - one endpoint context */
+	slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(1));
+
+	switch (dev_priv->gadget->speed) {
+	case USB_SPEED_SUPER_PLUS:
+		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_SSP);
+		max_packets = MAX_PACKET(512);
+		break;
+	case USB_SPEED_SUPER:
+		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_SS);
+		max_packets = MAX_PACKET(512);
+		break;
+	case USB_SPEED_HIGH:
+		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_HS);
+		max_packets = MAX_PACKET(64);
+		break;
+	case USB_SPEED_FULL:
+		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_FS);
+		max_packets = MAX_PACKET(64);
+		break;
+	case USB_SPEED_LOW:
+		slot_ctx->dev_info |= cpu_to_le32(SLOT_SPEED_LS);
+		max_packets = MAX_PACKET(8);
+		break;
+	case USB_SPEED_WIRELESS:
+		dev_dbg(usbssp_data->dev,
+			"USBSSP doesn't support wireless speeds\n");
+		return -EINVAL;
+	default:
+		/* Speed was not set , this shouldn't happen. */
+		return -EINVAL;
+	}
+
+	if (!usbssp_data->devs.port_num)
+		return -EINVAL;
+
+	slot_ctx->dev_info2 |=
+			cpu_to_le32(ROOT_DEV_PORT(usbssp_data->devs.port_num));
+	slot_ctx->dev_state |= (usbssp_data->device_address & DEV_ADDR_MASK);
+
+	ep0_ctx->tx_info = EP_AVG_TRB_LENGTH(0x8);
+
+
+	/* Step 4 - ring already allocated */
+	/* Step 5 */
+	ep0_ctx->ep_info2 = cpu_to_le32(EP_TYPE(CTRL_EP));
+
+	/* EP 0 can handle "burst" sizes of 1, so Max Burst Size field is 0 */
+	ep0_ctx->ep_info2 |= cpu_to_le32(MAX_BURST(0) | ERROR_COUNT(3) |
+			max_packets);
+
+	ep0_ctx->deq = cpu_to_le64(dev_priv->eps[0].ring->first_seg->dma |
+				dev_priv->eps[0].ring->cycle_state);
+
+	trace_usbssp_setup_addressable_priv_device(dev_priv);
+	/* Steps 7 and 8 were done in usbssp_alloc_priv_device() */
+
+	return 0;
+}
+
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					    bool allocate_completion,
 					    gfp_t mem_flags)
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 4dac1b3cbb85..5102dd31c881 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -69,7 +69,27 @@ void usbssp_bottom_irq(struct work_struct *work)
 	}
 
 	if (usbssp_data->defered_event & EVENT_USB_RESET) {
-		/*TODO: implement handling of USB_RESET*/
+		__le32 __iomem *port_regs;
+		u32 temp;
+
+		dev_dbg(usbssp_data->dev, "Beginning USB reset device sequence\n");
+
+		/*Reset Device Command*/
+		usbssp_data->defered_event &= ~EVENT_USB_RESET;
+		usbssp_reset_device(usbssp_data);
+		usbssp_data->devs.eps[0].ep_state |= USBSSP_EP_ENABLED;
+		usbssp_data->defered_event &= ~EVENT_DEV_CONNECTED;
+
+		usbssp_enable_device(usbssp_data);
+		if ((usbssp_data->gadget.speed == USB_SPEED_SUPER) ||
+		    (usbssp_data->gadget.speed == USB_SPEED_SUPER_PLUS)) {
+			dev_dbg(usbssp_data->dev, "Set U1/U2 enable\n");
+			port_regs = usbssp_get_port_io_addr(usbssp_data);
+			temp = readl(port_regs+PORTPMSC);
+			temp &= ~(PORT_U1_TIMEOUT_MASK | PORT_U2_TIMEOUT_MASK);
+			temp |= PORT_U1_TIMEOUT(1) | PORT_U2_TIMEOUT(1);
+			writel(temp, port_regs+PORTPMSC);
+		}
 	}
 
 	/*handle setup packet*/
@@ -488,6 +508,108 @@ int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
 	return 0;
 }
 
+/*
+ * This submits a Reset Device Command, which will set the device state to 0,
+ * set the device address to 0, and disable all the endpoints except the default
+ * control endpoint. The USB core should come back and call
+ * usbssp_address_device(), and then re-set up the configuration.
+ *
+ * Wait for the Reset Device command to finish. Remove all structures
+ * associated with the endpoints that were disabled. Clear the input device
+ * structure? Reset the control endpoint 0 max packet size?
+ */
+int usbssp_reset_device(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_command *reset_device_cmd;
+	struct usbssp_slot_ctx *slot_ctx;
+	int slot_state;
+	int ret = 0;
+
+	ret = usbssp_check_args(usbssp_data, NULL, 0, false, __func__);
+	if (ret <= 0)
+		return ret;
+
+	dev_priv = &usbssp_data->devs;
+
+	/* If device is not setup, there is no point in resetting it */
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->out_ctx);
+	slot_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+	pr_info("usbssp_reset_deviceslot_stated\n");
+	if (slot_state == SLOT_STATE_DISABLED ||
+	    slot_state == SLOT_STATE_ENABLED ||
+	    slot_state == SLOT_STATE_DEFAULT) {
+		dev_dbg(usbssp_data->dev,
+			"Slot in DISABLED/ENABLED state - reset not allowed\n");
+		return 0;
+	}
+
+	trace_usbssp_reset_device(slot_ctx);
+
+	dev_dbg(usbssp_data->dev, "Resetting device with slot ID %u\n",
+		usbssp_data->slot_id);
+
+	/* Allocate the command structure that holds the struct completion.*/
+	reset_device_cmd = usbssp_alloc_command(usbssp_data, true, GFP_ATOMIC);
+
+	if (!reset_device_cmd) {
+		dev_dbg(usbssp_data->dev,
+			"Couldn't allocate command structure.\n");
+		return -ENOMEM;
+	}
+
+	/* Attempt to submit the Reset Device command to the command ring */
+	ret = usbssp_queue_reset_device(usbssp_data, reset_device_cmd);
+	if (ret) {
+		dev_dbg(usbssp_data->dev,
+			"FIXME: allocate a command ring segment\n");
+		goto command_cleanup;
+	}
+	usbssp_ring_cmd_db(usbssp_data);
+
+	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	/* Wait for the Reset Device command to finish */
+	wait_for_completion(reset_device_cmd->completion);
+	spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	/*
+	 * The Reset Device command can't fail, according to spec,
+	 * unless we tried to reset a slot ID that wasn't enabled,
+	 * or the device wasn't in the addressed or configured state.
+	 */
+	ret = reset_device_cmd->status;
+	switch (ret) {
+	case COMP_COMMAND_ABORTED:
+	case COMP_COMMAND_RING_STOPPED:
+		dev_warn(usbssp_data->dev,
+			"Timeout waiting for reset device command\n");
+		ret = -ETIME;
+		goto command_cleanup;
+	case COMP_SLOT_NOT_ENABLED_ERROR: /*completion code for bad slot ID */
+	case COMP_CONTEXT_STATE_ERROR: /* completion code for same thing */
+		dev_dbg(usbssp_data->dev, "Not freeing device rings.\n");
+		ret = 0;
+		goto command_cleanup;
+	case COMP_SUCCESS:
+		dev_dbg(usbssp_data->dev, "Successful reset device command.\n");
+		break;
+	default:
+		dev_warn(usbssp_data->dev, "Unknown completion code %u for "
+			"reset device command.\n", ret);
+		ret = -EINVAL;
+		goto command_cleanup;
+	}
+
+	ret = 0;
+
+command_cleanup:
+	usbssp_free_command(usbssp_data, reset_device_cmd);
+	return ret;
+}
+
 /*
  * At this point, the struct usb_device is about to go away, the device has
  * disconnected, and all traffic has been stopped and the endpoints have been
@@ -598,6 +720,187 @@ int usbssp_alloc_dev(struct usbssp_udc *usbssp_data)
 	return 0;
 }
 
+/*
+ * Issue an Address Device command
+ */
+static int usbssp_setup_device(struct usbssp_udc *usbssp_data,
+			       enum usbssp_setup_dev setup)
+{
+	const char *act = setup == SETUP_CONTEXT_ONLY ? "context" : "address";
+	struct usbssp_device *dev_priv;
+	int ret = 0;
+	struct usbssp_slot_ctx *slot_ctx;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	u64 temp_64;
+	struct usbssp_command *command = NULL;
+	int dev_state = 0;
+	int slot_id = usbssp_data->slot_id;
+
+	if (usbssp_data->usbssp_state) {/* dying, removing or halted */
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
+	if (!slot_id) {
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+				"Bad Slot ID %d", slot_id);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	dev_priv = &usbssp_data->devs;
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->out_ctx);
+	trace_usbssp_setup_device_slot(slot_ctx);
+
+	dev_state = GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
+
+	if (setup == SETUP_CONTEXT_ONLY) {
+		if (dev_state == SLOT_STATE_DEFAULT) {
+			dev_dbg(usbssp_data->dev,
+				"Slot already in default state\n");
+			goto out;
+		}
+	}
+
+	command = usbssp_alloc_command(usbssp_data, true, GFP_ATOMIC);
+	if (!command) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	command->in_ctx = dev_priv->in_ctx;
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->in_ctx);
+	ctrl_ctx = usbssp_get_input_control_ctx(dev_priv->in_ctx);
+
+	if (!ctrl_ctx) {
+		dev_warn(usbssp_data->dev,
+			"%s: Could not get input context, bad type.\n",
+			__func__);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * If this is the first Set Address (BSR=0) or driver trays
+	 * transition to Default (BSR=1) since device plug-in or
+	 * priv device reallocation after a resume with an USBSSP power loss,
+	 * then set up the slot context or update device address in slot
+	 * context.
+	 */
+	if (!slot_ctx->dev_info || dev_state == SLOT_STATE_DEFAULT)
+		usbssp_setup_addressable_priv_dev(usbssp_data);
+
+	if (dev_state == SLOT_STATE_DEFAULT)
+		usbssp_copy_ep0_dequeue_into_input_ctx(usbssp_data);
+
+	ctrl_ctx->add_flags = cpu_to_le32(SLOT_FLAG | EP0_FLAG);
+	ctrl_ctx->drop_flags = 0;
+
+	trace_usbssp_address_ctx(usbssp_data, dev_priv->in_ctx,
+				le32_to_cpu(slot_ctx->dev_info) >> 27);
+
+	ret = usbssp_queue_address_device(usbssp_data, command,
+					dev_priv->in_ctx->dma, setup);
+
+	if (ret) {
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+				"Prabably command ring segment is full");
+		goto out;
+	}
+
+	usbssp_ring_cmd_db(usbssp_data);
+
+	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+	wait_for_completion(command->completion);
+	spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	switch (command->status) {
+	case COMP_COMMAND_ABORTED:
+	case COMP_COMMAND_RING_STOPPED:
+		dev_warn(usbssp_data->dev,
+			"Timeout while waiting for setup device command\n");
+		ret = -ETIME;
+		break;
+	case COMP_CONTEXT_STATE_ERROR:
+	case COMP_SLOT_NOT_ENABLED_ERROR:
+		dev_err(usbssp_data->dev,
+			"Setup ERROR: setup %s command for slot %d.\n",
+			act, slot_id);
+		ret = -EINVAL;
+		break;
+	case COMP_INCOMPATIBLE_DEVICE_ERROR:
+		dev_warn(usbssp_data->dev,
+			"ERROR: Incompatible device for setup %s command\n",
+			act);
+		ret = -ENODEV;
+		break;
+	case COMP_SUCCESS:
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+				"Successful setup %s command", act);
+		break;
+	default:
+		dev_err(usbssp_data->dev,
+			"ERROR: unexpected setup %s command completion code 0x%x.\n",
+			 act, command->status);
+
+		trace_usbssp_address_ctx(usbssp_data, dev_priv->out_ctx, 1);
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		goto out;
+
+	temp_64 = usbssp_read_64(usbssp_data, &usbssp_data->op_regs->dcbaa_ptr);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+			"Op regs DCBAA ptr = %#016llx", temp_64);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+			"Slot ID %d dcbaa entry @%p = %#016llx",
+			slot_id, &usbssp_data->dcbaa->dev_context_ptrs[slot_id],
+			(unsigned long long)
+			le64_to_cpu(usbssp_data->dcbaa->dev_context_ptrs[slot_id]));
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+			"Output Context DMA address = %#08llx",
+			(unsigned long long)dev_priv->out_ctx->dma);
+
+	trace_usbssp_address_ctx(usbssp_data, dev_priv->in_ctx,
+				le32_to_cpu(slot_ctx->dev_info) >> 27);
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->out_ctx);
+	trace_usbssp_address_ctx(usbssp_data, dev_priv->out_ctx,
+				le32_to_cpu(slot_ctx->dev_info) >> 27);
+	/* Zero the input context control for later use */
+	ctrl_ctx->add_flags = 0;
+	ctrl_ctx->drop_flags = 0;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_address,
+			"Internal device address = %d",
+			le32_to_cpu(slot_ctx->dev_state) & DEV_ADDR_MASK);
+
+	if (setup == SETUP_CONTEXT_ADDRESS)
+		usbssp_status_stage(usbssp_data);
+out:
+	if (command) {
+		kfree(command->completion);
+		kfree(command);
+	}
+	return ret;
+}
+
+int usbssp_address_device(struct usbssp_udc *usbssp_data)
+{
+	return usbssp_setup_device(usbssp_data, SETUP_CONTEXT_ADDRESS);
+}
+
+int usbssp_enable_device(struct usbssp_udc *usbssp_data)
+{
+	return usbssp_setup_device(usbssp_data, SETUP_CONTEXT_ONLY);
+}
+
 int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
 {
 	int retval;
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 64168ea16dbf..ea110667e964 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1679,6 +1679,8 @@ static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
 }
 
 /* USBSSP memory management */
+char *usbssp_get_slot_state(struct usbssp_udc *usbssp_data,
+		struct usbssp_container_ctx *ctx);
 void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 		void (*trace)(struct va_format *),
 		const char *fmt, ...);
@@ -1687,6 +1689,8 @@ void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
 void usbssp_free_priv_device(struct usbssp_udc *usbssp_data);
 int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags);
+int usbssp_setup_addressable_priv_dev(struct usbssp_udc *usbssp_data);
+void usbssp_copy_ep0_dequeue_into_input_ctx(struct usbssp_udc *usbssp_data);
 unsigned int usbssp_get_endpoint_index(const struct usb_endpoint_descriptor *desc);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
@@ -1724,6 +1728,8 @@ irqreturn_t usbssp_irq(int irq, void *priv);
 
 int usbssp_alloc_dev(struct usbssp_udc *usbssp_data);
 void usbssp_free_dev(struct usbssp_udc *usbssp_data);
+int usbssp_address_device(struct usbssp_udc *usbssp_data);
+int usbssp_enable_device(struct usbssp_udc *usbssp_data);
 /* USBSSP ring, segment, TRB, and TD functions */
 dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 				union usbssp_trb *trb);
@@ -1738,6 +1744,10 @@ int usbssp_is_vendor_info_code(struct usbssp_udc *usbssp_data,
 void usbssp_ring_cmd_db(struct usbssp_udc *usbssp_data);
 int usbssp_queue_slot_control(struct usbssp_udc *usbssp_data,
 			struct usbssp_command *cmd, u32 trb_type);
+int usbssp_queue_address_device(struct usbssp_udc *usbssp_data,
+				struct usbssp_command *cmd,
+				dma_addr_t in_ctx_ptr,
+				enum usbssp_setup_dev setup);
 int usbssp_queue_stop_endpoint(struct usbssp_udc *usbssp_data,
 			struct usbssp_command *cmd,
 			unsigned int ep_index, int suspend);
@@ -1753,6 +1763,8 @@ void usbssp_cleanup_halted_endpoint(struct usbssp_udc *usbssp_data,
 int usbssp_queue_halt_endpoint(struct usbssp_udc *usbssp_data,
 			struct usbssp_command *cmd,
 			unsigned int ep_index);
+int usbssp_queue_reset_device(struct usbssp_udc *usbssp_data,
+			struct usbssp_command *cmd);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
@@ -1788,6 +1800,7 @@ int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 		struct usbssp_ep *ep_priv);
 int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
+int usbssp_reset_device(struct usbssp_udc *usbssp_data);
 static inline char *usbssp_slot_state_string(u32 state)
 {
 	switch (state) {
-- 
2.17.1

