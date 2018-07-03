Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7407FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5B821F41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="NGshQRXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5B821F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932692AbeGCUBN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:01:13 -0400
Received: from mail-eopbgr680075.outbound.protection.outlook.com ([40.107.68.75]:24544
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753064AbeGCT6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFr9TorxkuLvGxsX+2CKggCI5H7VWX0roi1V6TONxl4=;
 b=NGshQRXygFG0QH5b7pVGdcrSX4Td2liKECSV5GTtPhwpuof2iZABVanunRiQqvn7HZ90QuMBW97R2DiHju2dxESDvsU8SQ8C6pf42D8XJkPqXuUPoDywSlguHjO+KbCEQgy5q6Xxh0IICm/NxbMz594Qb26UhJuwIVvXDM8xXfI=
Received: from DM5PR07CA0098.namprd07.prod.outlook.com (2603:10b6:4:ae::27) by
 BN7PR07MB4708.namprd07.prod.outlook.com (2603:10b6:406:f0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Tue, 3 Jul 2018 19:58:28 +0000
Received: from DM3NAM05FT015.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by DM5PR07CA0098.outlook.office365.com
 (2603:10b6:4:ae::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:28 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT015.mail.protection.outlook.com (10.152.98.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:27 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwMs6006991
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:58:26 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:40 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:40 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwNoc012256;
        Tue, 3 Jul 2018 20:58:23 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63JwNou012254;
        Tue, 3 Jul 2018 20:58:23 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: [PATCH 08/15] Introduce Cadence USBSSP DRD driver - added gadget-ext-caps.h
Date:   Tue, 3 Jul 2018 20:57:52 +0100
Message-ID: <1530647879-10007-9-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1530647879-10007-1-git-send-email-pawell@cadence.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(2980300002)(36092001)(199004)(189003)(336012)(8676002)(106466001)(69596002)(105596002)(426003)(81156014)(81166006)(356003)(11346002)(126002)(2616005)(476003)(8936002)(107886003)(16586007)(42186006)(110136005)(446003)(305945005)(54906003)(2906002)(4720700003)(486006)(53936002)(478600001)(87636003)(26826003)(5660300001)(316002)(50226002)(51416003)(76176011)(6666003)(4326008)(36756003)(186003)(26005)(50466002)(97736004)(48376002)(47776003)(86362001)(68736007)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4708;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT015;1:YLyFRBa5oybZxq+5t6iaCxhIblHycEyZaQRe0hiYJKPXrIEXRnouIsNzCq1stTkTUMdz5tNKgwMXfOdFpIVYEYo4J0cDcirigUvimWuO3txq5yfqOohAu5kBgM+AU9dZ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c035545f-1037-4906-dba1-08d5e11f57f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN7PR07MB4708;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;3:sT0tFBo1rAVT99aOwVrWlf6UZSuRzghEnDKTdZQev3mARZdS4Ule1/PlVILnnsrGqU6gIJFJCMUeZVwVgxdChgCWf8JchHgAbCfgN17Hqsj6C5s3zpIK1up2sRfPdfZ3b6T6kBImaR+IZDJ8YHUT7qBcheaD0iuicq/9a+Ta9TUPokVA7ASUnNWDAmezBIDxF/f3xO8DxUSORA+IDnZkPR3ZdW2dHxU7ZzUl+y6EdKpOE7UhkPq+Uu7zph1IpO507d6L/ShmoH2gRWneen1UT1dqVa+k/MXmahEtpXt+/4G9R+tCSoOjzCMq83/Ks5z8eOq8buB7+CxrK468vIAReA==;25:phDuASF/rM3A4LxE815f496wPHRhPp60rkdc5jjjpEELhxZ10eK+Kq2mS46hg6B3P3q+wzJnzb8sjxKNg0c35u5nN1r11RsjgSsp8RoKN/TOQMHLyyTGTs/swlx41yC9XpdS3pdZCWu7a4kxX7+I2BmtKLMz3RAtqNiR6KX6czAPzOkPnz0Q7D+8sR+gQSA7iLVx5izLcor4tqCbzzffO/wHVow6YymcSLbIxVQZZir6CqCBUJc/SnCy667m79o9huHFIupmr++eeNbrMAEpUH2uV4Ee8+kEQnGbyVTY2aijXdRGxlFjadXKSTc6mBmKxgTavjmrf7cPZGHdRH4cqg==;31:3a6uSUaBkp5b0xhc6/nH4SJ41hP3fDlwcyrNq7fL9QwZlGWEIHKd0kzqsAy+2cx1Tt2J2fBoqf5lHEJMgN1LGez4kYqKkFewtH7wsp3r1YBPNTtruwxdyvG7OetIrtcQolUIfakFklanaEcsNOG4AnVqzlSLrgqGFS5BCUUNMaP562zkTOdlj8HoYjRvaSnHt9tBvYqcOHOClhV3VHmADlCb8ssOxfirMMeaYQf3TS4=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4708:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;20:pI2EaXYgl88ZbPigesCN4n02oNiXjkLbQ+0G1jU+NHgViRqyxEeY0/219VtMdS6jbYzpwL2Yh8iWwfVnU3H3mYlfOL/VCSbe9hAR1KYjLGO4BRbf7UPWOthXOstL6pmKMMOprZe8gG+WncliYOnxlTXLPGxGHVkdl3QBioXugvhDQd+K37Fs5OyYrtVovhn/eWw4oS80t084GkNMtgAHnwdWIkMzSco9A86Cj4aipt1xK6+bntf+GzhcrRHoDKZE6k5/w/Gm8ZVNxJv/MI+0Z83LFPeBVHePIdvF8z15/aTIaMegFVccSaPqE7V3PLJrcnvLC7oPIURSWTVZFeUHOcGawI6GrNPrCCNCo+9PdbdVGZhC+sKWwmTCth/7xYVEFUGtsIVVvaCrmUSItGwJmwjWtUPxN77LkeUKKODZ0sMs8z9AxDFhE8HxZ/AhjK+LoWSZLKFl1KinFwSH8+THDjDvA6UQ3q1Lo9pV3sZh97ua8O9NGOISsAqeOw8drQNT;4:rppjfAGmBloRfEdoOg4jAeoU1TPVAOukUWSO3O51fg5aFA8pO7Ze91AFAhCXcPLg83/VH+1253hNViPXRnbPSYsZ98sIJ6N44YA+Uck+pnacIAHVX32WzgzVE6QY0L8DhxxGT9YZHR81/cY5ZpfHzE0FaJwRnGO0XOd0dmClejFGw+gTGt69wGf2VvM+ibC+/GJKmow8T7IBrVncd1ffBxSAj8YqzL7AKN0M9tndi83uzZd5cC0raVza5DTg/0IVVECBOEvcrNCaamYySH7e7n+ip6AYQBkGoiSHgvsSfLasPq4b69s7Asv+VAU3zfZQ
X-Microsoft-Antispam-PRVS: <BN7PR07MB47089F268C9A5081310E38B9DD420@BN7PR07MB4708.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93003095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4708;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4708;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4708;23:h7vjq7NLHj36a0KutIHxg2JoAC3KJzAiufbMZI5YR?=
 =?us-ascii?Q?6kzTy8tSXZvtqX4joc7C2mZSiAzkFEuep8+iInbsU4sWHHwHzn3K+mE1rW7K?=
 =?us-ascii?Q?IR19wzkHwiPKyucbVP5p3AZRpc1NQ6GGo9ja/I5wg1eeMVLYNI3YfyjcWppb?=
 =?us-ascii?Q?tjIdIoZn9LI1ZL1r6yvZZnTpxzxrBYUhtka+g/8nlYI9QSK2ewISUdXTu9G5?=
 =?us-ascii?Q?KpGUTdyVd8bPlZGkF7Vumua9F0fdNomTJMVEv2hgx3vtMOCwfpifkXmQZNza?=
 =?us-ascii?Q?f9IP/82z653OmzGj4HU9G55ngaHhYxyUpXCEMcOoXxgu8coE/bfLZYTlEsl2?=
 =?us-ascii?Q?CoKc1FNumLnYTtj3i1+tUx1q2pExyBxJX9S0Nuc/BAH5tS8jwAVyILehE5uG?=
 =?us-ascii?Q?JpOJH6IUp1ACo78yz4kHICIf95Ayi1tiJ55+sapDF/T5p0PpYMfoa7brZX5P?=
 =?us-ascii?Q?ZbmLfb3Inttaeerp1LRHWthY4GlHrIkL+aXsk7SIF0//fCCPwFTYD08iWUHp?=
 =?us-ascii?Q?dKj0+t44bKKS1F6eCnnIAhGhM7HiTugqjzneSwxd4ms0yAjDlhwaO4uTJJYj?=
 =?us-ascii?Q?JK3j1UpAUBW5BO+P/DAPTbjZ6iA+SAIJpc53NfHcSj6uEhHwNUGC/BcK5w1e?=
 =?us-ascii?Q?27xOiTDv8ac8LjKezwoUTu+kdfpJyAYeixwdefSZ6cWptLQsLYEE1SHl7eMw?=
 =?us-ascii?Q?NpYtXJu0iKURxmpKi4BGVDfu9sl4Nx3sT2Ioojy9vmn6ir8C3tq1q1tc/V4Q?=
 =?us-ascii?Q?A2HM+sVm8bGXlSwaXJ69KwShZDsPGkSbVACL+A+fGaXYVxkTILNbqKGrmIxs?=
 =?us-ascii?Q?3+/9pRzsL1eldqwuzebUVfkPDgRQtvR9ROKdDpsCzJmrUnrJfOsrvG0nykXT?=
 =?us-ascii?Q?rs8t9nwj2zraMPUAmImZ+JuiMohMpXG+6S6+PnO7f8pq72vTeiqVHk+yjIHY?=
 =?us-ascii?Q?x+s+tVyGh+H3ula6NSi0mfl8NnyY7WXSY/kumzL9gm+eBQwyWEnGitSDpjLR?=
 =?us-ascii?Q?J1Sovwcz6CHeix9uaJZC76HCf64UXk0i9pWxiUSrW+WCOq4eJKLmB+9MeyZN?=
 =?us-ascii?Q?/3ZrBAUeeOCetRMoDuA/PZ9QKGEEYV4luppC0HSov3sF3OhTfTCxVIdXrZrj?=
 =?us-ascii?Q?rmhd6OxvJ3H1SHNGdzi3bY+0cxKweHe0oHmN/FiRTT7CLRP259gDkdcPniFp?=
 =?us-ascii?Q?3V0nAH0kueZz5jeIqvKG/oVsherC6a1BVQfHWvgoXMusuAt/321pqUDvQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: biYekhQN5Wd2Kg8dMjlSqd84x6D77w+Ndr7Lm6gvxQ/I5c19C9CcGXuR8a8iQt4mQBE1+FF92SwFOe1k22tsH4Xt1Xbdo1MQIvBr7ucdNrbXxmhj4mrWXpu84HdmU2DQDi2STeZEnP10DK8sbYWK7Cj2bGFWa9sixf73MJhzTeA0/0a0DN3v/QQd3aZsif/5CogSfbOPMhdHaAX+3oFBehbt0aXcyHLpOw9c0nFLFeSlwCJ0G/c3wLvbOckkzR7DZr6s6rPGV5h7PIgYcgSfcFN8gKrNAFsFU9/oy6zj2lvwBTP72i3dWT/hoJxTlsLCcP0k4Nh+o8RRnrdejjQDLtNw5pfvThhKvV6XusbMFSIsMvJayuQbMiITlgSBhYNYW2TauDn7rQ8mOzN0EteslQ==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;6:Wc2uYbbn975IWTORwXPxJmj8gdXxFcEdYetQh3h+foazCPl7mTGH+rr2gCKZ6vnlCOYK9EgCtVvAE2bxf9X+ZlED47pNlAEAit28bTKsqsljrM7c1DBFnwTF3JJ60T8BLWZPoxZF/ClaA/3Oqhgb4rDSEiD+7uQ0R0k+zvyyZEAssEdPcrVCmaCL28w0/dPZvd0k94P9rjIuZiMHj+KPvSsq1E+zJ7/g61t0Pjf5rZdJ6jNTLaxZxaAdSAlR3Zs0XTKwwyJg5TFaJIAjQlRcjJDmqm8pAmKtkUgAlU/mlgF0OifRAt8z1u3tLxv7JDat3diXfGVwu7ylASXm4Zs5kaEQhEXU+TdhJ0xl5an9pYrPvJxebpZP6zq3QTqLCl+seBQgp/0U/U/ShfHpaePlJA1iWdxy6dO5BRsM/wJzt2GrRtapAwiE1031EMxJRaR743ME2zoGYurmf/WOy8B5wQ==;5:a/RAk2pjhbVJ34Xfs4oE/zV9k9fV5tSUX1AqQfJ0H0tazgGqFATAzcAkFIg4mAo5VmIuORWAuXCC+iSQJXoKDcKkGLVNlicXZIVxGfC1N19a3Lu8ep7GxewDhvJGT8AGNEiZQ53BB8R9RY1cbEtZb92neuzc2EYMZwT3EIWtQWg=;24:Nqanw6cfeNv4PqlCbWjHxwJ2jSwnbczUUPN7q75ns1lXqh2D2V5p9x0Ox/wMENPbpEDrQHeGXolzTbvQFmVVX7V4zpJR6FZmV9Kp4Qw8VMg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;7:nQib6pPyiY+AmR6i7P7KUHhOM25QhcjbbRIdOM2jIqzsZhKjpwgeeRoMZE0sGEtKUwdPqle07TGRVLBm77upnV/UBQCEqRMR8k+eWqcXipQHCI8Gt1PTEUSc8YwGKc2vYfxfdYO3laLF3bvErWfjVpKowsPzJAqqXKBKA2qNIOBdJK6C0DjXeUlRJJexWZtJbDarAiP87opxhcaGpFsjbuJwGSBwiQFE79hdBwdK9OSNPNmsCFjuYP8kRmtM/xOW;20:fXjQ0G/frCiPg343YxScFK9cxPa20qz3pTUcqpzpEzzag/TrpsvCHa+gKm8sVWX8f/HsN2Nf9foOsR5HKr692XibRqf1glrtAvo4JyRjDUsaJUsqqK3PANVCANV1YKmgbQjzkp582UStpbsIB4SOccX3tjaviDJ/S85DEHRhInWjZOYDXhr98vZ7IZ78kTUY9i0XAX3Y4MjaEqSrdxjTTt/4xT0yLzsyoK46Jj4AgcHsj2Vm6DRhuR7vlx5F8089
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:27.6012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c035545f-1037-4906-dba1-08d5e11f57f6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Laszczak Pawel <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ext-caps.h | 99 ++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 drivers/usb/usbssp/gadget-ext-caps.h

diff --git a/drivers/usb/usbssp/gadget-ext-caps.h b/drivers/usb/usbssp/gadget-ext-caps.h
new file mode 100644
index 000000000000..3b1f7b046440
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-ext-caps.h
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ * Some code borrowed from the Linux XHCI driver.
+ */
+
+/* Up to 16 ms to halt an DC */
+#define USBSSP_MAX_HALT_USEC		(16*1000)
+
+/* DC not running - set to 1 when run/stop bit is cleared. */
+#define USBSSP_STS_HALT			(1<<0)
+
+/* HCCPARAMS offset from PCI base address */
+#define USBSSP_HCC_PARAMS_OFFSET	0x10
+/* HCCPARAMS contains the first extended capability pointer */
+#define USBSSP_HCC_EXT_CAPS(p)	(((p)>>16)&0xffff)
+
+/* Command and Status registers offset from the Operational Registers address */
+#define USBSSP_CMD_OFFSET		0x00
+#define USBSSP_STS_OFFSET		0x04
+
+/* Capability Register */
+/* bits 7:0 - how long is the Capabilities register */
+#define USBSSP_HC_LENGTH(p)		(((p)>>00)&0x00ff)
+
+/* Extended capability register fields */
+#define USBSSP_EXT_CAPS_ID(p)		(((p)>>0)&0xff)
+#define USBSSP_EXT_CAPS_NEXT(p)		(((p)>>8)&0xff)
+#define	v_EXT_CAPS_VAL(p)		((p)>>16)
+/* Extended capability IDs - ID 0 reserved */
+#define USBSSP_EXT_CAPS_PROTOCOL		2
+
+/* USB 2.0 hardware LMP capability*/
+#define USBSSP_HLC			(1 << 19)
+#define USBSSP_BLC			(1 << 20)
+
+/* command register values to disable interrupts and halt the DC */
+/* start/stop DC execution - do not write unless DC is halted*/
+#define USBSSP_CMD_RUN			(1 << 0)
+/* Event Interrupt Enable - get irq when EINT bit is set in USBSTS register */
+#define USBSSP_CMD_EIE			(1 << 2)
+/* Host System Error Interrupt Enable - get irq when HSEIE bit set in USBSTS */
+#define USBSSP_CMD_HSEIE		(1 << 3)
+/* Enable Wrap Event - '1' means DC generates an event when MFINDEX wraps. */
+#define USBSSP_CMD_EWE			(1 << 10)
+
+#define USBSSP_IRQS	(USBSSP_CMD_EIE | USBSSP_CMD_HSEIE | USBSSP_CMD_EWE)
+
+/* true: Controller Not Ready to accept doorbell or op reg writes after reset */
+#define USBSSP_STS_CNR			(1 << 11)
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
-- 
2.17.1

