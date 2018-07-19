Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D268CECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1B220857
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jEPorUFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1B220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbeGSSny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:54 -0400
Received: from mail-eopbgr690049.outbound.protection.outlook.com ([40.107.69.49]:62478
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732151AbeGSSnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIPnqnErTdujz1N4V1NIP2ym5rBLyW6CCmXgSvPB+Z8=;
 b=jEPorUFORNNkQ9pPldx6jEUCK7cQTv0DEV26TnjpybPDuM2X76E1KU5LHPoRbRVeZ1QhqtzZTPHev40fMwAJZtBPifRTKurEXM2eXVisbrV2dqzUCRQt7g/cqmYQHpnR+SY0/rt+g2aLmgC8Ey11xNAHJ88l+KrX9+4UR375I74=
Received: from DM5PR07CA0108.namprd07.prod.outlook.com (2603:10b6:4:ae::37) by
 BYAPR07MB4709.namprd07.prod.outlook.com (2603:10b6:a02:f1::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 19 Jul 2018 17:59:31 +0000
Received: from BY2NAM05FT023.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::203) by DM5PR07CA0108.outlook.office365.com
 (2603:10b6:4:ae::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:30 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT023.mail.protection.outlook.com (10.152.100.160) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.995.0 via
 Frontend Transport; Thu, 19 Jul 2018 17:59:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxNgI025447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:30 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:32 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:32 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxHkY006076;
        Thu, 19 Jul 2018 18:59:17 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxG8X006069;
        Thu, 19 Jul 2018 18:59:16 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 28/31] usb: usbssp: implemented usbssp_gadget_ep_disable function.
Date:   Thu, 19 Jul 2018 18:58:01 +0100
Message-ID: <1532023084-28083-29-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(36092001)(189003)(199004)(107886003)(2616005)(4326008)(126002)(50226002)(246002)(486006)(8936002)(476003)(36756003)(4720700003)(6666003)(316002)(11346002)(356003)(446003)(86362001)(54906003)(16586007)(109986005)(42186006)(426003)(5660300001)(336012)(478600001)(186003)(47776003)(8676002)(26826003)(87636003)(7636002)(106466001)(50466002)(76176011)(48376002)(14444005)(305945005)(26005)(51416003)(1671002)(105596002)(2906002)(266003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4709;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT023;1:FfG6sdUAY6WTErZPM7R2A4GHUYRK1SLpzDPcIrQ+njo7ja3QasgTpxwvOVNvadOuf7mzfOeCUFRzz2yeIvHVphUyM0N4waM4o2e1O2DX72E0N35uAIBUrCqxfVS4NIsG
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0987cfe-e450-49b0-ba73-08d5eda16059
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4709;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4709;3:IbJTFEAL8eocIZo1tp0FmI/YEQ4UmxQbjMhNONd/uJV5rwBhVKt0BxTHTj4QCP9lYzhuslfk84W4o11udWxQjd3xmc1vQNRYky4JlQXX8pi58mPjKKeyFxKa8WnCg6byoNX8p+keE8z2CGF8s9jiNhtqe3VjBG9/gDuvErY0ur9AXCa3ABKRscphxBTcOmxTTl/H23vp5VhmezwnmU4iw6XoL+lzUHocvyifwvOcjrJ3MmRT/4dqKgL47jwOiUxnbyD5u5xCnl3AeoorMzU3XUUM2zmylY2O9S2Xfx6FO22iPO8u5eBTJuS7PUPgQ8lmG12iA/S1JJzr3dssgwBY37ntJ27TKs3OB/F+Jc3TSp0=;25:LtMCRcVXPswKk7BUCzQlg4NN4efKk6Q+4s+OvaNF/7YepVT1sitqyikdYsEpB3LxgS9DQubrfzasayFvA0a/DcXvwteBV2lzb02Vhq0rEXfi9kWT/8sq1ZEYMw61sZbtZ9Mk2HUsvEgDi1WvJnJMud9cbK4Wn46ED8JuT6blgQKF78VcOT7jEqCNZsj5NvL5ysb/WZp6tHrqD1Q5xtEN0jBg2pFCF27Q+wSIi/HykzCQYbv7abj+AhlQzUN5ySbswJ0gSmMHcUV4/UD9o0lfGsD11OY45aU8RQDHj+TRgvfKOdzkUYUfqaWTHqWPYnAc8FC1kRFUM38q1UMiVBIJPg==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4709:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4709;31:SpVAHb6F3kFJPUIhVIyKBuk5Chsbla/ItnBW5OwSc5bucCgvvcLZt1KDxLzyghTqs0NmIwGNn2QnNMElFvF88m8QvyaJng2slwDzu3mOA0J45RYPvtSdpTGND49FXEcI9PQeMiTLJ5ECCUmgiFoTLF1FU7xW432DmuJIgqwKf0UBVOD4gGoUwrZcIkUSajX3efM0OxBYnJgzyapJayhs29uYLpHL1EqHX6NE3jzwBO0=;20:qjaFfwt5Mi4UQCWxd2JWD3FRobrJN5G7eXI6g+JejUM0BcDe2/gCe4e8ZYqAbs2Byq5yQmOZTJLYo/KOwHUWNchC8VjVVBW5uo8IBh4KXEQH3eDNYIH5covsQIaUoNLCLhtpHPhniFrK9u6KRzOBUPNTU9VZpktNeSOHkyIo+pGgKQujlzKnk7XMlEckbS7afOZJzXX0L3ouwa7pnMEeHLX1W9qD/7eOmK//sNCb3J8WQ0XQjyU8lvAgKnW2jAwok3wiz54Mh56tkbK0WV+onKeRXRPKFKs8SAKu/6O0vLA/jCUdpw+Cj6yVyEtdwyy7Y/8Kvk8ghZvpL2VjBxAXs+04BsLOfcKFbbXkl8E5GbwO2dqMBpun89J92Y7gLuT5E5lV5sryLB97YD13puz4Wju79SzwipZKGkgS1Afx3XZjAmzy++b9kZzstYbzpw1BNuEu9q95E0lUgGrcQP+g5ljkl+sp5SY4axEJZONUuSmANBJL1QbRvD6lWhJtBRx0
X-Microsoft-Antispam-PRVS: <BYAPR07MB4709018F272824FDCC253A08DD520@BYAPR07MB4709.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4709;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4709;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4709;4:IhZwJ6qTJaUDjBIUVWegi0j1Hm8YFXgh70W2xPG1EjvexXpzkvQ5vkFeJcV6YqE6mFRObc2tFtrZF7ZQZCqsh8tA9lvxwkYqz0zk/BtToNKZsH6/HXerh+f2D0I4ovwbfwVhkJRVH1LI9ON9edvagn/5Px5vXeTr8Olg8zFr8CnbYwEFSIvL5WIOOqYxrv6jndiIpIxAuZmJ/T5cyl5tZ2pT9IjH1CDf02M4zIENrcvYjnpTtuIhwtPFJ1445ABALkPk7CPrh8FR8s0XWUhY/uQrw7Jzr8wLFtmaSelHPBHleZ9HDsLJWbZBBTuYkDy2
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4709;23:XzIVtw/6w0568fZHkoJeJQqegytS29KxzXEQ8knFv?=
 =?us-ascii?Q?MibQAn5wN16Jijv7UrTou2VNFH2Ep+O699qm25nJiL3bulG4RLem11hH1vj4?=
 =?us-ascii?Q?RLiCKzsXjVImofqZ3B6m0u12My7DF2NUPgd+f5jmY5+O1hlQh0JloHGV/7lt?=
 =?us-ascii?Q?7wGaUeho8sl3p0uoDdzDr/6/zfsL8e3CZXi7l3gi/YYaKhKEz8Tu2jQquFOT?=
 =?us-ascii?Q?NBXFixq1ivyXQRu7tlggKrQcCIKg3m02otDfRv8ze4WzUD1/qbTFpKPqZXz/?=
 =?us-ascii?Q?y+qL0V1/jZycYqNxJ7SyzbPjU80gCFOIrzPOLL/GPbNhlm3qPDTDU+95S+4U?=
 =?us-ascii?Q?41u0nrfMjc/dTBryTh2MULxNKWDpN+6vJfZ6kg4ze9p8mHY2xevm9z3XkbYI?=
 =?us-ascii?Q?MAineCvIRp+T6qKF79IN52rt5x+nqdol83r0Jcu6RxlK4RBNXHFqIQY1DsPG?=
 =?us-ascii?Q?1HUYW2jXRckiHtgxqnhiHhw2qOoLBnOyqTdhWvTK6ByhkHhlJRPEJDG4ljVp?=
 =?us-ascii?Q?11IVCiUqrsmigtnyUILt16sBDwBMm5+Dp1q4LMUg6iZ2zudiDNkfsJoO74AK?=
 =?us-ascii?Q?AGLgmYJ2VoJq7Jb+SycctmJIG9Ii3+mLEAE9w0k0JcBs9EiRtpRBP89caS97?=
 =?us-ascii?Q?F9rD51T9/f7zzN/cmiz4NvEmkq0hRpvE4xd+5Jv5QOabHBANvjLgIbslxMHr?=
 =?us-ascii?Q?v1q7+H2z2aHy+ofKzGdFSXwbsCWXxjbMmh5uEspkdceW6MT5ySzhuuRxTEIQ?=
 =?us-ascii?Q?qYdxSqNT3VWiKNhovDz0AY+FW3wFxsLouwHJjHqjculZe81e1qMaaXFqF0SZ?=
 =?us-ascii?Q?+lzihSMkUaHsGL2qMKXxyf6Pl2HrohYa2hzgIP9GU0+4H9zOIDAWwHCGZUyV?=
 =?us-ascii?Q?lBsnYbwVF06An9YVQJG5IUNyrelikBt9nBeqpegojkmcun4m4XLRbUP6ZlBp?=
 =?us-ascii?Q?+hQGVzQ4ojyba1NAhzTyJ1TDb2xnnYJnlPHjGyJP6nnsRlY5uoI4OKwEXGI0?=
 =?us-ascii?Q?tdLgUGiMkVqFD2B4TLhd1mQ24wSdokjXw7t5AJh32im1tgqXqPX3WvLuneM0?=
 =?us-ascii?Q?VVuC6NWQEXIsI0e9Syt3/l6Mqf8J24EdqjLSbUpBxCI/jFR5M03f096nuAPF?=
 =?us-ascii?Q?jY2FzTMrRa3AnUG9NF3PaNlaVa/2nHAkReQLsiOFqp7Koe3D+M+pmw+pL0Tb?=
 =?us-ascii?Q?8f3bd77H22j8JykCe8aziOzuFlDUfy3AtZ7A8grHIYcOxCfXj8hqsUQP0IM3?=
 =?us-ascii?Q?oWCoaALqHAMGsmwGzs=3D?=
X-Microsoft-Antispam-Message-Info: uTVkWTWlY8Nm33Z1nHzhJXLaI9+Lb1OueB6TUsOAPn/znvTr1TSYA/FBhnP5ZShUpc5sjByEBmbHm8FX7eAVRPteCUdE3W9xM0AURPJiEmq97QyrXzTpWklmxFFaKSlymumxN90kbVqLFGhCyZv+dJ3ZW8uNf9UVITMDek+qq+KWsYvpDKMkknIVj5c75fCIJLSu7/uZ9HVWykhRHVY+znynvD6bZdcrDr5Gl1Za+rAiy9taiL3OKrhcQgu34aDAPT0cybdKPkWyAHIYDva5EdPjvUvqAiLwuys6MLbo0T96Qoii7yVb82b4OI/xRPxz5tmFuYIirV1CisagE6LqBaaIP9kJoH2RBRiXMoILNP1r4z9s1rUxIrY4pSiimWaz+ljthl2ty1aBoflvuXxlJA==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4709;6:gfI8DCKTsindXFAlLtB+jHI5La17xz8YMKgUcyvJ4DI4mhgAumBOKb99NQWuoBrBh1lLLl6cPClBnpN5DwkIVQSeHb205vFYIpvsbjx2bpw7KM4WGaX06sR29xjC1ahJlsHoqZ4Dxe4Q/g6g31l6wSOYoZ32X4ejKC6Co30gzYQdowY8IQNeFGPt/xYxPaCMFEntoUw78fGgIAX1g5abhof6dR1rbzCtsv7zNh0jW/JRFo1UDYgUTZseDa+j7HYM4VcljWIDTqtI12eV/1xdzn9GaYIisHciosxfMmvp8XKBywm6ssASbnK8QDcqeKKfzXDm1vJfWkygmSMSA+rGQAyhUQBI26Ht4tdEAYpOLiso7XQV6W2mxhx0RSDe2B4Db/AMTaYhDaA3B4O0YxuIuoAq/XeuiCLkSrdEUTLUjQBEK6GiYkNmY3rT7LMsMZb9nyYG7Nf44KWm5tVhDlcX6A==;5:VMRvGVRl0QYlq3HxnwH1eGdQF8KG7gZ35Ugj2W+HO/EaG5/IqMa1e5Kx1nCVCy+7qJlwf41WQ75hgbCPlXdgvZ/81ewb2JqFMJ6ravWwAyORXSS2Dm3mJe3zh/ypTdhS+VCA2Dd6NXy/fG5xcHYFw/DLpaYw8YSlSx2GzyM/hkw=;7:Hii1Ar7TQfvHbyE35lNQ2LrEVNSzukajADTTYHeOfStHSXWMwC+OJmzuPZ00TX7t2BMUHuOEiLHEzCuM8gMwDJOOVKrpotoijQK/HmwvYgReF65XB0JnIedLfuipWmkZSodhVLftKzY51qydyj+BJ717dbTvkIRuXEsy+7NxOx3qHWrBPAXgosVd0IlPbkBECn9e5q8KBmAn2vgnXfdmUZAK3ZiriPwB3LAYs5QaLvsD6xFGRzp8Qh41uf9WOkFT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4709;20:TcVG0RZq2/Hr1Uwrkm25VMe01ICbpI2AiD55QL0DBrsatjb1ifPFyzryh8xJrulweDoim3F3mo5bWcYWXBgPShPYo9o55wPEi1GqRTLfEDryqgkXRFHBhQa1Ahg+yQ9WE4e6BvzGTnwV37sVYnlR4hiF4A8t4K8WU40pDjvcZcdHrr2Uk+Ov4vBRmOV81osM5WcXWNvSNMdyTPgMmV4OM+1BUxsnsNXVngy6T2/E78Nxyf5VXWjARGoPADGhAp8k
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:30.4178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0987cfe-e450-49b0-ba73-08d5eda16059
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4709
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements function responsible for disabling
USB endpoint. This function is called
from USB core gadget during handling SET_CONFIGURATION or
SET_INTERFACE request, or after such events as USB_RESET or detaching
device from host.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-if.c  | 44 +++++++++++++++++--
 drivers/usb/usbssp/gadget-mem.c | 21 ++++++++-
 drivers/usb/usbssp/gadget.c     | 75 +++++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.h     |  2 +
 4 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index afc4f32ec8af..d5ad204612fa 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -86,13 +86,49 @@ static int usbssp_gadget_ep_enable(struct usb_ep *ep,
 
 int usbssp_gadget_ep_disable(struct usb_ep *ep)
 {
-	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
-	int ret = 0;
+	struct usbssp_ep *ep_priv;
+	struct usbssp_udc *usbssp_data;
+	int ep_index = 0;
+	int ret;
+	int irq_disabled_locally = 0;
+	unsigned long flags = 0;
+	struct usbssp_request *req_priv;
+
+	ep_priv = to_usbssp_ep(ep);
+	usbssp_data = ep_priv->usbssp_data;
+	ep_index = usbssp_get_endpoint_index(ep_priv->endpoint.desc);
 
-	if (!ep_priv)
+	if (!(ep_priv->ep_state & USBSSP_EP_ENABLED)) {
+		dev_dbg(usbssp_data->dev, "%s is already disabled\n",
+			ep_priv->name);
 		return -EINVAL;
+	}
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+
+	ep_priv->ep_state |= USBSSP_EP_DISABLE_PENDING;
+
+	/*dequeue all USB request from endpoint*/
+	list_for_each_entry(req_priv, &ep_priv->pending_list, list) {
+		usbssp_dequeue(ep_priv, req_priv);
+	}
+
+	ret = usbssp_drop_endpoint(usbssp_data, &usbssp_data->gadget, ep_priv);
+	if (ret)
+		goto finish;
+
+	ret = usbssp_check_bandwidth(usbssp_data, &usbssp_data->gadget);
+	if (ret)
+		goto finish;
 
-	/*TODO: implements this function*/
+	ep_priv->ep_state &= ~USBSSP_EP_ENABLED;
+
+finish:
+	ep_priv->ep_state &= ~USBSSP_EP_DISABLE_PENDING;
+	dev_dbg(usbssp_data->dev, "%s disable endpoint %s\n", ep_priv->name,
+		(ret == 0) ? "success" : "failed");
+
+	usbssp_g_unlock(irq_disabled_locally, flags);
 	return ret;
 }
 
diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index 8438596ecf48..217ce46bff8b 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -873,7 +873,7 @@ static unsigned int usbssp_microframes_to_exponent(struct usb_gadget *g,
 }
 
 static unsigned int usbssp_parse_microframe_interval(struct usb_gadget *g,
-		struct usbssp_ep *dep)
+						     struct usbssp_ep *dep)
 {
 	if (dep->endpoint.desc->bInterval == 0)
 		return 0;
@@ -1103,6 +1103,25 @@ int usbssp_endpoint_init(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+void usbssp_endpoint_zero(struct usbssp_udc *usbssp_data,
+			  struct usbssp_device *dev_priv,
+			  struct usbssp_ep *ep)
+{
+	unsigned int ep_index;
+	struct usbssp_ep_ctx *ep_ctx;
+
+	ep_index = usbssp_get_endpoint_index(ep->endpoint.desc);
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->in_ctx, ep_index);
+
+	ep_ctx->ep_info = 0;
+	ep_ctx->ep_info2 = 0;
+	ep_ctx->deq = 0;
+	ep_ctx->tx_info = 0;
+	/*
+	 * Don't free the endpoint ring until the set interface or configuration
+	 * request succeeds.
+	 */
+}
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					    bool allocate_completion,
 					    gfp_t mem_flags)
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index f5b0659b6f2d..378828d10a2e 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -715,6 +715,81 @@ int usbssp_dequeue(struct usbssp_ep *ep_priv, struct usbssp_request *req_priv)
 	return ret;
 }
 
+/*
+ * Drop an endpoint from a new bandwidth configuration for this device.
+ * Only one call to this function is allowed per endpoint before
+ * check_bandwidth() or reset_bandwidth() must be called.
+ * A call to usbssp_drop_endpoint() followed by a call to usbssp_add_endpoint()
+ * will add the endpoint to the schedule with possibly new parameters
+ * denoted by a different endpoint descriptor in usbssp_ep.
+ * A call to usbssp_add_endpoint() followed by a call to
+ * usbsssp_drop_endpoint() is not allowed.
+ */
+int usbssp_drop_endpoint(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
+			 struct usbssp_ep *dep)
+{
+	struct usbssp_container_ctx *in_ctx, *out_ctx;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	unsigned int ep_index;
+	struct usbssp_ep_ctx *ep_ctx;
+	u32 drop_flag;
+	u32 new_add_flags, new_drop_flags;
+	int ret;
+
+	ret = usbssp_check_args(usbssp_data, dep, 1, true, __func__);
+	if (ret <= 0)
+		return ret;
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING)
+		return -ENODEV;
+
+	drop_flag = usbssp_get_endpoint_flag(dep->endpoint.desc);
+	if (drop_flag == SLOT_FLAG || drop_flag == EP0_FLAG) {
+		dev_dbg(usbssp_data->dev, "USBSSP %s - can't drop slot or ep 0 %#x\n",
+			__func__, drop_flag);
+		return 0;
+	}
+
+	in_ctx = usbssp_data->devs.in_ctx;
+	out_ctx = usbssp_data->devs.out_ctx;
+	ctrl_ctx = usbssp_get_input_control_ctx(in_ctx);
+	if (!ctrl_ctx) {
+		dev_warn(usbssp_data->dev, "%s: Could not get input context, bad type.\n",
+			__func__);
+		return 0;
+	}
+
+	ep_index = usbssp_get_endpoint_index(dep->endpoint.desc);
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, out_ctx, ep_index);
+
+	/*
+	 *If the controller already knows the endpoint is disabled,
+	 * or the USBSSP driver has noted it is disabled, ignore this request
+	 */
+	if ((GET_EP_CTX_STATE(ep_ctx) == EP_STATE_DISABLED) ||
+	    le32_to_cpu(ctrl_ctx->drop_flags) &
+	    usbssp_get_endpoint_flag(dep->endpoint.desc)) {
+		/* Do not warn when called after a usb_device_reset */
+		if (usbssp_data->devs.eps[ep_index].ring != NULL)
+			dev_warn(usbssp_data->dev, "USBSSP %s called with disabled ep %p\n",
+				__func__, dep);
+		return 0;
+	}
+
+	ctrl_ctx->drop_flags |= cpu_to_le32(drop_flag);
+	new_drop_flags = le32_to_cpu(ctrl_ctx->drop_flags);
+
+	ctrl_ctx->add_flags &= cpu_to_le32(~drop_flag);
+	new_add_flags = le32_to_cpu(ctrl_ctx->add_flags);
+
+	usbssp_endpoint_zero(usbssp_data, &usbssp_data->devs, dep);
+
+	dev_dbg(usbssp_data->dev, "drop ep 0x%x, new drop flags = %#x, new add flags = %#x\n",
+		(unsigned int) dep->endpoint.desc->bEndpointAddress,
+		(unsigned int) new_drop_flags,
+		(unsigned int) new_add_flags);
+	return 0;
+}
 
 /**
  * Add an endpoint to a new possible bandwidth configuration for this device.
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index c4075e765dcc..3a223b89efe6 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1694,6 +1694,8 @@ void usbssp_copy_ep0_dequeue_into_input_ctx(struct usbssp_udc *usbssp_data);
 unsigned int usbssp_get_endpoint_index(const struct usb_endpoint_descriptor *desc);
 unsigned int usbssp_get_endpoint_address(unsigned int ep_index);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
+void usbssp_endpoint_zero(struct usbssp_udc *usbssp_data,
+			struct usbssp_device *dev_priv, struct usbssp_ep *ep);
 int usbssp_endpoint_init(struct usbssp_udc *usbssp_data,
 			struct usbssp_device *dev_priv,
 			struct usbssp_ep *dep,
-- 
2.17.1

