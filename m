Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5553C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DC820875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="IkL1GWtd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DC820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbeGLF5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:57:10 -0400
Received: from mail-bn3nam01on0051.outbound.protection.outlook.com ([104.47.33.51]:22639
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732349AbeGLF5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUdQEFDpoqqrtn2OgGXjPG9l7SOekSOWO/LOVZLhmkU=;
 b=IkL1GWtdIDRldleWfrm98phEM9jcc9r6MkWMMCwzhRMRRTku7leyzDG1ecN9A67ub+eqFEFzK8iHvjw3jL9dbLs1Zngab8In8n+5IB/A0nwSVN4ou1fbh3zKCv8hMzqVbDHVdVwvLu2cjsfFsjSMPEcx5Oa8zC+KrTJcBVuilGY=
Received: from DM5PR07CA0037.namprd07.prod.outlook.com (2603:10b6:3:16::23) by
 SN1PR07MB2301.namprd07.prod.outlook.com (2a01:111:e400:7a45::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Thu, 12 Jul
 2018 05:48:06 +0000
Received: from CO1NAM05FT063.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::205) by DM5PR07CA0037.outlook.office365.com
 (2603:10b6:3:16::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:06 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT063.mail.protection.outlook.com (10.152.96.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5luUa017906
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:48:05 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:10 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:10 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lrTp029934;
        Thu, 12 Jul 2018 06:47:53 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lrGJ029928;
        Thu, 12 Jul 2018 06:47:53 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 30/31] usb: usbssp: added support for TEST_MODE.
Date:   Thu, 12 Jul 2018 06:47:27 +0100
Message-ID: <1531374448-26532-31-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(199004)(189003)(36092001)(2906002)(356003)(14444005)(8936002)(126002)(446003)(2616005)(316002)(54906003)(486006)(11346002)(246002)(16586007)(107886003)(42186006)(109986005)(476003)(7636002)(48376002)(575784001)(8676002)(106466001)(47776003)(105596002)(26826003)(36756003)(426003)(76176011)(478600001)(87636003)(305945005)(50466002)(6666003)(4720700003)(86362001)(336012)(4326008)(5660300001)(51416003)(26005)(186003)(1671002)(50226002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2301;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT063;1:40no4Hleiw0qJNKTNfMGpktL6bKJfJCZh7BbojILJHvUlJwqssLVlHFcIYxb96BVPeZzoIbGJ5mgtBht0DabojZWlHJ2urQkW8aQhh+e2PwyIbaT+Dox236ZPiQwUbSb
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a716f71-f91d-49a0-17df-08d5e7bb0a36
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR07MB2301;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2301;3:MxM3dHH4sWyxwAc5aTINuczMSKQb7OUuDQMTnBJwsFcBxJUvtlV5UKtqug1xtscqBbbCzA0R8dhSTVm6mdzGhbintkD000Ep7UA6kJmtnWH5rlzXIorAxydiYhikWogf1csQHkBnZbgmTs9dI10bmA29V989taHKKJKZdrYDToND6ZdwKVffFQzRKur5DLsGlgptaij5Lp9kFYRGzVB2C7wiDO2XzrnrNoTP9r4oTdVX8Qi34rqNypiOuSVm/lbXZcKPWkDLnxgj+8fzBaiy3XPVl2MCtvZRyc/+ByDosaJwU/uQsI3r5kcrAX91q8eA6VmCN5fVdrLrRqZKQAwMH7YEiKYLq0VRCfxZZe9HmWE=;25:h58V+IC/Ac4cTS761c6LHKdPxxg9N8ySYSeyvMLHxij7gcSCQpxUnNWqcDVBYZP3xus4LFq5OygvkWHWkH/gxlmyncuml0rx3l1bqb7hV0FVcgkX72XXZrBpUwXxDHwb5cQ7wOX5DkRvTvywzTjouLlI1WdSya+enyTxiva4xgDkwZvPI617WRyGNF4du5CqtPmOkfacPsdRHHBfBNLngtp05rNwud5XlgJ4G3bpvF79PcsvxQcETbIg7Esd2+8/djn3oLHabfsglN78rJUeahMI2+01SwBc402DNAQg0y5CQLhSadkupeV/eOxgLFCSPAX6IWcHeSX4H4enPvH+ZA==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2301:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2301;31:zVYdIo0B8xtuWvu1LGPngIDVVFNfD7xblIdYhG9rEdLWM99oR0kAvj9BBA4sgnh3KfYU05JPBnsa4KN3dlRLgNJ99BlTBcdGl7EXlkkZD1kAMDV0Nx0HnfnWvz3n/fu5KN3uEzMYPQz/imyzhMR5jE3+PcDI0sQjW+3KvBWVV2aUdCIG0W2PPEmoJ1VRWzBUx/+GAxNHo7i6As+PzeBKXo4C976lM55DXFGdI5O2l7w=;20:1SqEOrmmVnSJxuHMn1ts5hl15WSU4nSaogbJYgOwLlLkJdpJ39/J5r8IkONmLVhG8kxPAq1Q6C7xrlAmJ8o/OnSMdfaOP5hEDIMtqBzki8gOy/qfzsvpKBqgOIvSXky6EV4Sh6zew6eeW5pqTFBQn6wn+69AaV45u94P05wpYcTcmugXMsCROGMOTidiv8EjnYTO0vHxWIKQfXqFgGuY+Xk/UedTeOW8s8KKsUnjlrNnQwkfM40v7/6MJR+cYqTehAVCNKCbofzrgLgnFCvIPQaPKgIqp2XDMVHWgEVFNut+ydKbvGlbY4FldKjejSbe2HAO8GsdCgwfy7HDVJZlRdKvOEXVxBw6/W20vgGPpmI4GhAKnWBYY0HgH9SiYgY4Gj1/TmGlpf0AfF7IZayrvSgDxdcdaWXIhkMI04BgbR1iNFIlNso+zJognOTyN4sYKZPsahK//UB7obsBzu53uIzyXCMOGihGI2v7V6I12xui7WG41z75lVSAzs07eht5
X-Microsoft-Antispam-PRVS: <SN1PR07MB2301E67A09BFD507F98171DDDD590@SN1PR07MB2301.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93003095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB2301;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2301;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2301;4:iCs7jANwF+rv3sjI+yNmDHs44vvz4lzUMwBoBVS/2V7UUKXYXNvW44Rk6k69+g46JmuOsR2yuEO273HygzZpxOyCg0lY+uGh5eEMapHfaDqPZXKdY0wi+61RWkfcqhe4em+WxiY6nXUSw54scyI31hRg7GJ4bKQpt01GYtE6G1I0lg7kTQYM8rAHWfh8dEzqRILIVbdFZjOSkVMy+20pCTvSv9dN3TBrGArEAH7uN4RjeF+5xPEedly+61vp7fMNA6WW6+i3KKQ9fcv9cE+9DoTrLIF4IyvgQi3eq76mSzAy8m/4ltUd1cxDuBHm4K28
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2301;23:YQkNFjvIHffEVcIAXDL6ca4sA92odH9vDCxaqL1e4?=
 =?us-ascii?Q?obeG+kIG9BF58mRbJhk2K9EzoRSx07270SSZoa93M6gDAlS+MSIpRCSG+gRs?=
 =?us-ascii?Q?e8Uw0z87MdhD7Kijc8txox9uRzICY9iMPmtjj7pWZIU4KPpsUgd/UuIdpqql?=
 =?us-ascii?Q?HQ9NJhOZWBAsFN8hi7tr/Tq5Zf/VgmJYCNaWbfi5/FodvDr6NJ6OUNIlJcqg?=
 =?us-ascii?Q?n3w1Z8vw8ymsrGdhzrOryerAdYILeuyXO3nfN/y+TZsYFeA4dmAheWI34dhP?=
 =?us-ascii?Q?yRukY1LdG9tDFPhewfyXxRqOeWFQhFtY5JudNu/2i2V7ktMhwfzs9cLQDWtU?=
 =?us-ascii?Q?5oN/m4dS/O/mWyOmt6vnf+skh/IctT48HcZZlnlRPru5BuOmA1inJQEo2og/?=
 =?us-ascii?Q?a5XVVp7k1mQnlVe4ZFSxuCiDAurQYsXPzYzJVL5VakW1NUO6f7pSIV3RQMbo?=
 =?us-ascii?Q?7CqQUQ82CxIR/+BUgf0UK+3gNiCvWvGF7SlhI07ECV9sF20p8UhfRHwU/4rd?=
 =?us-ascii?Q?oMilethzXg1cRYemPjlkqabc0VaB3+hgnNerrslQMfQH7rKJlNRftrJym83n?=
 =?us-ascii?Q?gtAp9nlVzd6F/iwQIVjjCRghXuNrWLME2+eSOSxwo02Ve+NavBbpqAhEb6MI?=
 =?us-ascii?Q?w37vbL77SBcCnPgZATqvCVNMPn1VG3r+mHv9VrmYZmq3eRio3yDaiBVsUTmJ?=
 =?us-ascii?Q?lyw1QuJMcaqwLtyYTFmrUqe20eihtQbNQvA/ZMIU0RtwyD4ykZ5pSToR7vX9?=
 =?us-ascii?Q?DFMefiQnlLGY1WqVpO5xM5hHKC8e11oxVWCHd2KQPdzmDAZN+PPruZs2PXoT?=
 =?us-ascii?Q?qZXNvuRjmmtxLHFZ6rfcQl8YvhU+M6zlzaHtf2F5Ets0NRFZIQ26Uk5c/rco?=
 =?us-ascii?Q?hZDFrA7OsvnUvt3fGMbYnzBeAMlm+j7TNdSppaThW4M//bjWgU7XnQnUzROR?=
 =?us-ascii?Q?sgGzypCqdauiykdU2gTa9NT1OO0Jh7y/8KAaY3MKKY6pPpSTYZ5DXTIlkVwa?=
 =?us-ascii?Q?HvMhOaztSr8TLiTPSg0jXdfirOJaJob2B0ZpaawoW/hpUwWKrsfmfghx6l9f?=
 =?us-ascii?Q?FB6QEjYRbcQ6vW9hxXzNaUzmYetrF085mUnLXkv/dhRDtN1nerkTjEo5AtAh?=
 =?us-ascii?Q?En3vGzv+TWsyGumru21NNLdVu+y+6dvT0p+2VQmJuPdiasESjw+XezoWupxx?=
 =?us-ascii?Q?XBxmY/UteQekHw=3D?=
X-Microsoft-Antispam-Message-Info: zggVwLq1uhpMHKRx4CvADo+LShmQftwF+/MDhFH/4Qspklfa7kND0RDy/gbQOJQ36QOIa6WaJUmSxo/I42o9NeALvjEoG3JEI0ezAc1bgHazg52v1f3m2BNIJFluRYmtt15b9YFZaVLjaEXnckaZh4JuU4MQl7yXQFdl2vwqTFbHvjA1wteLMOakwvSpPokcRWRrEtEoFWRaxYZpvVQk7nE/2lWoKA8KZtdz0s/O6WZbqSCQ3Zxb/PxZS35qeGkIqrXVJCSsHaiosYScfeJ9mDhhs6XGCvml/U12kUT1FBWTEVOnWtr3VqLj5YiGWjeGOC/DKLykw9ZWnjWYdY6POrzk9ep8Ddq9zi2svzfGMIhf9auRLeDvv6LiPjATSjcBjfV84oXBWBw0LRO8Est4hQ==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2301;6:Di+f5SG3onBnrIKzgLpCYToBxPqtumtC7Y3lr2dtUbBvPFmDoEY1Dr+sqczyUMtTeRzFYO+xg9+ZG+WVFK+AbN26q76BBssf9Gw2yhtw/Kh7ADYHTOP+1k11XNGPjChHyKycKWri6VDhKylvXdP5dbpkJrc36Iyek/XALZVyZVLd9kPHg7fu9a9v/FVGQJoaJCNaA9f+Z3Eitk9k4J9peAnHLGHhLKH8My6Zat4aD8iMxpWRhHjBnp9ixlFdw5f0urqzF88GG3KKq61D7QitDJJ+ry0C17ht6/ZFcuuz2+zWN7wpXtYYHrYFQoqebTTGVbIy1U/17haB9OQEDgRRHwUHYBSSa5WBlgKV0kH++LJUzvVVAeaYEuX9Ro9Mzy+jgVGyFCkzimWhKOCWy/HXdKULGU+g8xUY+zybLGP4xlKVR8EzXwLiPTZRUcx26r051ZFd1kOzVo/h3xEesO4uJw==;5:XRfFAuTclENS0DTps054Ifffn4OBTFmdeLcEMjVCxrajULyQrc+RFiv+B+OYNcvqzbcM3hDaZtq58X/snduRNWkX2flcg3Sbl5ryChfjIOS+xp0ZsmNP22RroD1Ec2uXC3m6TnlVftrzBl5s5RTU+nTintLyfMEoXdRQMvZTCps=;24:gcYuh5hqIy+Tju2efUzb+JH61WN9SgVRVe+rUYJcOrt95KytESwcd4laRGup6LdJvSiOl349dQeSaS1Kfr5bKrsTGFh3jH6omcTW7Laejog=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2301;7:OIfcGsMv3ACJG7grnXfZfQbU+v9OoRgYB/zaFHCkqoQT48IIuKSSsRxeIhFnYhB3HMvYSr6QguhO8pTFoEtr6lUeg/H0B0SpYRex+pDQRtYH46TfgcHBXge1cYVX48iZpDp5CdT12QOvWJ+CS9FnLuw0+8IqWspe+eb2/tww7ogOKd9zwGRcnsQWW+tiqlhDPFRIIBTnaBQMdR/q2npwnV/LphtHbc5mVuXnuRTT9vhEwDIznkLyuHi49I3J4pFF;20:aiYVdJJ8oYsuXf/DX/+InJ/rTejFmqiIICM5171nuiUg0DTjzQUKU0fgy0CWMMJT1GDE8Dq88YHMc3NvDIs2tU2eEH3M7q3UFhuTSH/DJqp9fvkv9BB6Aud9avvkcLn6YpfZQQfpziH2iVaRlqOxXP6vB4vqcY1DUESqHGrX4PQ2oUIgpHwiVEaD54LOo5+oMO35r2K9Nu5fJ9AqGPNjZKEPxXqKnMgDbMDNBGmttWKmMyvTK9YIpFRQNK/NLvFU
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:05.7292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a716f71-f91d-49a0-17df-08d5e7bb0a36
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2301
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements TEST_MODE feature that puts the device port
into test mode. This feature is used only when device works
in HS mode

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ep0.c  | 39 ++++++++++++++
 drivers/usb/usbssp/gadget-port.c | 91 ++++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.h      |  6 +++
 3 files changed, 136 insertions(+)

diff --git a/drivers/usb/usbssp/gadget-ep0.c b/drivers/usb/usbssp/gadget-ep0.c
index 6ded0c1b0e70..565fb410e0b4 100644
--- a/drivers/usb/usbssp/gadget-ep0.c
+++ b/drivers/usb/usbssp/gadget-ep0.c
@@ -242,6 +242,41 @@ static int usbssp_ep0_handle_feature_u2(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+static int usbssp_ep0_handle_feature_test(struct usbssp_udc *usbssp_data,
+					  enum usb_device_state state,
+					  u32 wIndex, int set)
+{
+	int test_mode;
+	__le32 __iomem *port_regs;
+	u32 temp;
+	unsigned long flags;
+	int retval;
+
+	if (usbssp_data->port_major_revision == 0x03)
+		return -EINVAL;
+
+	usbssp_info(usbssp_data, "Test mode; %d\n", wIndex);
+
+	port_regs = usbssp_get_port_io_addr(usbssp_data);
+
+
+	test_mode = (wIndex & 0xff00) >> 8;
+
+	temp = readl(port_regs);
+	temp = usbssp_port_state_to_neutral(temp);
+
+	if (test_mode > TEST_FORCE_EN || test_mode < TEST_J) {
+		/* "stall" on error */
+		retval = -EPIPE;
+	}
+
+	usbssp_status_stage(usbssp_data);
+	retval = usbssp_enter_test_mode(usbssp_data, test_mode, &flags);
+	usbssp_exit_test_mode(usbssp_data);
+
+	return 0;
+}
+
 static int usbssp_ep0_handle_feature_device(struct usbssp_udc *usbssp_data,
 		struct usb_ctrlrequest *ctrl, int set)
 {
@@ -271,6 +306,10 @@ static int usbssp_ep0_handle_feature_device(struct usbssp_udc *usbssp_data,
 	case USB_DEVICE_LTM_ENABLE:
 		ret = -EINVAL;
 		break;
+	case USB_DEVICE_TEST_MODE:
+		ret = usbssp_ep0_handle_feature_test(usbssp_data, state,
+				wIndex, set);
+		break;
 	default:
 		usbssp_err(usbssp_data, "%s Feature Request not supported\n",
 				(set) ? "Set" : "Clear");
diff --git a/drivers/usb/usbssp/gadget-port.c b/drivers/usb/usbssp/gadget-port.c
index fc76139468d5..509c76489a1b 100644
--- a/drivers/usb/usbssp/gadget-port.c
+++ b/drivers/usb/usbssp/gadget-port.c
@@ -191,3 +191,94 @@ void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
 		writel(temp, port_regs);
 	}
 }
+
+static void usbssp_set_port_power(struct usbssp_udc *usbssp_data,
+				  bool on, unsigned long *flags)
+{
+	__le32 __iomem *addr;
+	u32 temp;
+
+	addr = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(addr);
+	temp = usbssp_port_state_to_neutral(temp);
+	if (on) {
+		/* Power on */
+		writel(temp | PORT_POWER, addr);
+		temp = readl(addr);
+		usbssp_dbg(usbssp_data,
+			"set port power, actual port status  = 0x%x\n",
+			temp);
+	} else {
+		/* Power off */
+		writel(temp & ~PORT_POWER, addr);
+		usbssp_dbg(usbssp_data,
+			"clear port power, actual port status  = 0x%x\n",
+			 temp);
+	}
+}
+
+static void usbssp_port_set_test_mode(struct usbssp_udc *usbssp_data,
+	u16 test_mode)
+{
+	u32 temp;
+	__le32 __iomem *addr;
+
+	/* USBSSP only supports test mode for usb2 ports, */
+	addr = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(addr + PORTPMSC);
+	temp |= test_mode << PORT_TEST_MODE_SHIFT;
+	writel(temp, addr + PORTPMSC);
+	usbssp_data->test_mode = test_mode;
+	if (test_mode == TEST_FORCE_EN)
+		usbssp_start(usbssp_data);
+}
+
+int usbssp_enter_test_mode(struct usbssp_udc *usbssp_data,
+			   u16 test_mode, unsigned long *flags)
+{
+	int retval;
+
+	retval = usbssp_disable_slot(usbssp_data);
+	if (retval) {
+		usbssp_err(usbssp_data,
+			"Failed to disable slot %d, %d. Enter test mode anyway\n",
+			usbssp_data->slot_id, retval);
+		return retval;
+	}
+	/* Put port to the Disable state by clear PP */
+	usbssp_set_port_power(usbssp_data, false, flags);
+
+	/* Stop the controller */
+	retval = usbssp_halt(usbssp_data);
+	if (retval)
+		return retval;
+
+	/* Disable runtime PM for test mode */
+	pm_runtime_forbid(usbssp_data->dev);
+	/* Set PORTPMSC.PTC field to enter selected test mode */
+	/* Port is selected by wIndex. port_id = wIndex + 1 */
+	usbssp_dbg(usbssp_data, "Enter Test Mode: _id=%d\n",
+			test_mode);
+	usbssp_port_set_test_mode(usbssp_data, test_mode);
+
+	return retval;
+}
+
+int usbssp_exit_test_mode(struct usbssp_udc *usbssp_data)
+{
+	int retval;
+
+	if (!usbssp_data->test_mode) {
+		usbssp_err(usbssp_data, "Not in test mode, do nothing.\n");
+		return 0;
+	}
+	if (usbssp_data->test_mode == TEST_FORCE_EN &&
+		!(usbssp_data->usbssp_state & USBSSP_STATE_HALTED)) {
+		retval = usbssp_halt(usbssp_data);
+		if (retval)
+			return retval;
+	}
+	pm_runtime_allow(usbssp_data->dev);
+	usbssp_data->test_mode = 0;
+	return usbssp_reset(usbssp_data);
+}
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index ff10b70b3906..3ad32cf5f2a5 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1728,6 +1728,7 @@ void usbssp_stop(struct usbssp_udc *usbssp_data);
 int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
 void usbssp_quiesce(struct usbssp_udc *usbssp_data);
 int usbssp_halt(struct usbssp_udc *usbssp_data);
+int usbssp_start(struct usbssp_udc *usbssp_data);
 extern int usbssp_reset(struct usbssp_udc *usbssp_data);
 int usbssp_disable_slot(struct usbssp_udc *usbssp_data);
 
@@ -1810,6 +1811,8 @@ void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
 		__le32 __iomem *port_regs, u32 port_bit);
 
 void usbssp_udc_died(struct usbssp_udc *usbssp_data);
+u32 usbssp_port_state_to_neutral(u32 state);
+
 /* USBSSP DC contexts */
 struct usbssp_input_control_ctx *usbssp_get_input_control_ctx(
 		struct usbssp_container_ctx *ctx);
@@ -1838,6 +1841,9 @@ int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data,
 		struct usbssp_ep *dep, int value);
 int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 		struct usbssp_ep *ep_priv);
+int usbssp_enter_test_mode(struct usbssp_udc *usbssp_data,
+		u16 test_mode, unsigned long *flags);
+int usbssp_exit_test_mode(struct usbssp_udc *usbssp_data);
 int usbssp_setup_analyze(struct usbssp_udc *usbssp_data);
 int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
-- 
2.17.1

