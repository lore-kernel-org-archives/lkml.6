Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF358C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD6820875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Z62/C415"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD6820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbeGLF6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:58:02 -0400
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:17563
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbeGLF6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/6FzxbGQDvkcuxAvPmPBeeh1XJlqGlc/69TR1lwn1M=;
 b=Z62/C4150i87Wx0EE+1HSGDjdsxuVgT8iGViitiYMbNeVGDDlyb4adViG634lj07WnrKYgoC733mSUjPAqdB9XCRcvJ1sPByIZ5aJa0ofaMdvx/EVJNndIusu7hgpPQPLUMMDNF/fyKV8Y0CUHfy1zuBshRlhYiQyG6deRlJGLY=
Received: from DM5PR07CA0028.namprd07.prod.outlook.com (2603:10b6:3:16::14) by
 DM2PR0701MB1343.namprd07.prod.outlook.com (2a01:111:e400:5119::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 05:47:58 +0000
Received: from CO1NAM05FT051.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::202) by DM5PR07CA0028.outlook.office365.com
 (2603:10b6:3:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.21 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:57 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT051.mail.protection.outlook.com (10.152.96.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkw3032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:54 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:04 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:04 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lm2H029593;
        Thu, 12 Jul 2018 06:47:48 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5llts029591;
        Thu, 12 Jul 2018 06:47:47 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 09/31] usb: usbssp: add implementation of usbssp_mem_cleanup
Date:   Thu, 12 Jul 2018 06:47:06 +0100
Message-ID: <1531374448-26532-10-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(2980300002)(36092001)(189003)(199004)(186003)(51416003)(8676002)(305945005)(81166006)(11346002)(2906002)(446003)(126002)(476003)(486006)(36756003)(2616005)(26005)(316002)(5660300001)(106466001)(54906003)(16586007)(105596002)(42186006)(8936002)(81156014)(47776003)(14444005)(26826003)(50226002)(97736004)(336012)(356003)(109986005)(76176011)(107886003)(53936002)(478600001)(69596002)(87636003)(4720700003)(575784001)(86362001)(1671002)(4326008)(48376002)(6666003)(426003)(50466002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0701MB1343;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:ErrorRetry;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT051;1:/ri30g2Q1uqoO8N0QPrIri3w1fSyKzWgtajPOBsL59Ye81iIPdDreuwOk8ZzpiETOhF5U42iGczKD9KvmZsB3YpshwnJ0VtRDqtHOMGzFlym8j6J3Bp5kEbvcsuT/YFI
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4545e273-e313-4ca7-f81b-08d5e7bb046b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM2PR0701MB1343;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1343;3:XWl8RmNuVoFBMAAc7LQNvZjIXRZwctT1n7CBV5yafbkZrYHDIUEoeqsykiXE4f+nffbkz+A7UUlZKuAK8QjxUtB4grWZjJJdGTk6A76KTawTZiQv36VbEjJFqXP5IAl6iyAh7Chc600xCKsNtYnAc/h36Nmi9NDq/loIWUnhQZ4EhcFXHuor1AfR1SGMhBCzNy5V1xGozf7de8hi3tyI0l8KaHhic+WP3FfJPSrU7PkBO+36/be2h7jBNTckUp8GitDRE/7vBO7dOvmdFEEdvkM0zFgbAnPbAvepFJw1GP95/W+GeYOWsPSw4uD0Klx5a4w/Dwhm2xKKMbVYy0ENUYSW54TwroSjSJMfB3PHyic=;25:nfHzL2r1MXQIBYkmnnisn7lfAqShh90mzkFsYX8cF18c9SateivPz1aE1BVnMkiNGciYbFcH8JHzJNkKwtUGLHu+Eby3nX0vNEwdYt3H2C+FfS9+PIrj6mivYZvPCQivAPsUVSzTyy6pPIUe2uXpSYqVCItLPpqLKQ6uYu8RluufwKgdWzqtjOU5qqx8WQKMZb/BsveoyYC1I7mZNW/PoDARwsebxP6DNpk/S8G7//Iymw0P62LQg1zZnje+if7kyLxJw14jUoU8UDhmLvHNTUkkhlSjSmaVqqgG6AjI3Nw/GvBJMNdAFi+y1IW6P91VNhvi1xhIk3caOJV7DZDThw==
X-MS-TrafficTypeDiagnostic: DM2PR0701MB1343:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1343;31:1hWkMOlDWoCydD6MP6f6Kx7cX9nGc/8GHFTkFdHV3no2Af61JORgdXkBr/+2U5dr8h2Tb/HVUbe34PSh1sV8lW9GK2sUaEH90JuodEhb9skDVahkTAn8whrswuBxNXVMFQ2+Qiyx3dmcGjUpDzO9Eb0qW4JGUwJTVyj6zoSx1hy6FNY/4tpjYYEWzGuhppe17DiR3GETAsUfjkK340BmwsZPfGjmYfkK9tHJrqTv0Zc=;20:e7JO8nU3Mk9+vuS03NNVGo/nfs1hW+9NhpizDaNswTIAneKOUpOy29wtiYy1MTVKN57rs0qIynzOTdQRwtWEHsjKfUcBx9Gkkg8hpCcIkAZdL4Q5oxj/xUQx2d1Nbogx3nYzjWA7GSmQ6aXBUS9CGF+QyYSm4ohQmjis0qj/c4MdyOrNHD8NNAC2CZz8Vr6Is2PGClQgvCqrQjbrD4Q0R2wKGBnIrKD6rPQpAljpVgERFpMoX8VytqY/iD71n9aoersKKJ2ECjxmNcXZdEcAwjvIVOq6WZ5PgBIJDV080wbve2wEHjSCCmFqsob1U7bmVlKE120qplwUX0KftEaSw6HZvKdpb1mNIY2oysQVmhG2s+sk7dKlkWI51GLUJ4zM2idqYFDvw05qCkaSmlxXheTpQODN0Tdewl53y6TbUs0pI+dzBJSBtRKVNHn/XhurX1f0KDRu2GGwWvSINd11Ksh4m1BJPRMbCjhdbTPJn99QEYGCYvWlhxx+BY2ahQuY
X-Microsoft-Antispam-PRVS: <DM2PR0701MB1343E9228E49A3C5A0A6DCAADD590@DM2PR0701MB1343.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR0701MB1343;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1343;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1343;4:/50dTQidSHiHXt7n38K/LUZlbkC9wnXQWG+Zs9pdoY8Yf6ghkTcbRotakcTVK69+floF5izJ1OF9ELdUYevIGc8QhaG3Se4bediuYxRqrZZUItzFjm9ij+Y8Q0nLAcOM9jnXv/CcXAsEmcYG1GvRqrrVG6E+u8h5bBDkIXwgD8PZxyP03nsM5brvxaeZpkns9eyCWt+X9206QiwB9paQWLR+pgt81/VEaHPuf7Nx03bRHkNP1D3pI9xxIkU8j0cXdrL0DW+Ddcl2hrJ5PvKeqfJY4bLGVllw53BhlZXF2Z2gyU3NjO0m+YWdxuESabO0
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0701MB1343;23:u1fjwRyB7LYTk7b7x6eUnvVQ3hVCGkhp/cLFyoO?=
 =?us-ascii?Q?77ZYx1zN9OLMP4JKanegp4/1jz692TaeVnjRql95TOp8uwL2rVyIUHlnuijS?=
 =?us-ascii?Q?VZKU6SoMj03pzXCr6pTlhRG1oKH2xTW1Y6gQ/wLinQrzxdW7+XjxOBVfaEWx?=
 =?us-ascii?Q?UlZYybZwhUl0ryXTCFh36NByy6pxSC0itAqqK4F9TeWLWsbtVicdWM1a9Uln?=
 =?us-ascii?Q?Ul50yoOC+DXFSiVrkjiMG+OYaZlEUgPANUuoskLt3sgGDWMeVcvzabmQ8LRx?=
 =?us-ascii?Q?DplN2L58lGtiagW2APd+RfvPi5qx/lw9Z4Wt20hJ5ayA4tLU292cX/nU0e6Q?=
 =?us-ascii?Q?IcSJhPsSj9y9pLp1j9o8nL3eprLsjnAGJNdvf2Vc9fCigdAoHUeTuurdfJqu?=
 =?us-ascii?Q?wO/ZwgPTYHs94wVf0xeoddCBYwCUBt6TAn2HyFdVG82wq6O6P6Sdo1B3wnJR?=
 =?us-ascii?Q?zTcVN/ArEm33NCNY+qFEK4ysRl79ckZvzpM6fBEBE0d0mLd7amuS/4SsYxyH?=
 =?us-ascii?Q?zVVbUWiqtul9DucfCH5hZJ+uDIrMxecF9GI3L3v0frJNT+l/8WkMy/Z6l50P?=
 =?us-ascii?Q?6KsTORmvmGH2mzco0dnxKlY+5RpSgHK7SZfMAIm5GltsBF9fJVbUYiWZ8xfD?=
 =?us-ascii?Q?RZuM/+6fJ2WasYhCVnf0eZ2trWIUufaNsWZ/tKtpWNEM9Er9kI1k8Y47n4Ry?=
 =?us-ascii?Q?RX4TVRSBlmR4KXLnGHhofHkdLgC8eRLtfCTGYDe5K+oBouvythNq+rTybOPM?=
 =?us-ascii?Q?KY7RkXddIwXohyAYvh0bCi4xRfR4ZLJskIGUan5XfgVwYH6NVtZW460/vdyj?=
 =?us-ascii?Q?lRoX9TLgu52E1S2JoN3oX4mkrng4+ZO9EDAkOu2vAFCzL9dnfF+bqBENYpAw?=
 =?us-ascii?Q?W8XDJmFo7KLLTAcBUgsvw5wdjHHusQpz819lrPCIPepMIDOoqTOsQayN9/NV?=
 =?us-ascii?Q?z8DMnjNYPTHeL3L1+wR2ni1EOwsR1A1pRK6vc7TCRm68TYUfk1RwQR2S0/oY?=
 =?us-ascii?Q?jamGSkKHqmn6JlT2shS3Gr3+xAlNWZs1aC8JQ6W4IB/lMWBC8BYbrDvsaONF?=
 =?us-ascii?Q?rS22UEIu7yIcygzQJh1oueNTCF4s4M8dS8X9x0w+LZhgXhC9Kro0ZO/1Dq3z?=
 =?us-ascii?Q?sWuJoJnSDfLBxl3i9IKkjKdBqkWbIyig2kQv5g6Que4xpoJLoLKn//0yHggU?=
 =?us-ascii?Q?+9oYLITDCrm6BV6JDTwFBl8Oy5u4VBl+s2l1IZJOnr9w/u+hJK6WowIb5vag?=
 =?us-ascii?Q?QMrwPkdOHQUg9pWZimu4=3D?=
X-Microsoft-Antispam-Message-Info: yiu7+hgNzAOOYHarldTyfZHFwxK2tIXUcotCjr/vRS7b9H+EZQTIEhH9ZBQNi20SvBNu6UvMPtz/uEgXOwMchBqYWe8UBzppNQNmT/gSQYXFURN98YPyk7LQ1bLS1OzM6hnqo83aJqf5c4QHIJ58QooGZ6bY96Xp6/UxnbE/xovh4TlETWTI9fiAIXOxo9UmA7bWz47Nfsxau1L3EaII7tK1jjs+tITUJkQXOwQCov5Pab75TIGoEuMd3LdXdKaqXN91c8AX012n91zG70Q6qY8vg78UKAyG/Gfsh2G2A/d4NBvDN2ibMw5Nq1CpNHwxcUQVFyuhNsOIhDltSz0Wqzi+ETwBgRdramzu8pQWsk/rAtb3IKhOY/lNppSdZh09nzkNczwLlk+dAAKzahS66Q==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1343;6:4CK0g8cLYyjxSSzrNxefKfXlbVL6i2tG89SpEh8I+MTFFAMG1kojjP1iqrxpcVS+K0pm4pUcFnIDpZj9Jzf7sNOPs3uIm+TtQtFoUec7Z94gV2NDer/BN+ttcIVOZFJN/BCuhwENT/k64uzl4/HsLRsKf8kqvEOjxJaI1gS8PK4TThDWpJAVanwT1LxZibDTEOqo+o6n98bTXpMHkEWziHdi+r+6p7Y7s+zM96vkGu699Cufnm/LGJbBWP0cCJefkuUsXwYCCALDEhF0xfRffl0YhSsbR/k1WAwCixXg5q5ibvOB9zwcIXXwS5xy7AnTLl0NYC0lL2syHYYHnxB13iJqH6Wk13RcQOuHHgl25eapHbdyGOoRW3F3L+0WFpIVUFdDqF1I0HJz9sGgvqAbNQD7faOw9hPsfmivr2h+BeCHTXyO8ov4Rtz/N+CmQ/Gro2UckYg81b19f6ObP3FCvw==;5:c5i47P4kpnBLSAfEtkAECO7vxl8ADHeFNwlp5etdPjdTMYRt19bjAQJ4YIjv8YhUKUl4b0cbVzZ0lyk+HHMJFwLzleZvxHxtPdOdwOqR/BW6h4Xb+aWciLQ1bAJmkbmgkBmmmtkSw0WwURu5CMyHI2ikdUh2bda+7DqvJO4gOmg=;24:S12/J7f6XryegMFPrQJJobSp//A0njM8v6HRwlU0GQvoTbXye2Rn3iTIkbU7ODCMbWkTQ7qh/kH2ZitE//F6Eisjbb/eV66zg9JSEPuY88s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1343;7:UwfkdeBk/kDg0YkU+US1Uzeq0moOM5opmwkIgYPIOo1GiduahUc+iuKXjw8+7X9bAGOoPT7kWv38DDY5DHQk5e27aan0xHHtOBaVHwDcqhom1A47AmS/VqSGE8OKl7bihjyWcFSMZujZ0jX+hkLcEWYC9OimioNtYqJ0TwldCB11v6cnDFiczkQB1oVj+l8AxsYxhBVWxuiyb2WqnpY3ew1RuO2il0Lz8HpGQfh39ryyJT2+Ynx+OC7Jcyrb8EIO;20:kwu1T/4gh+SAXiQJ7H77/nBk10mZDQD0AWCjwam/Vz7EBZKktHkCTmfH6ehpscwnM6VFybfVP/Qim2PTgkq0WTEi19fKRIGWN830QfwJDajvhdCj0uy2NmdWLpMb+xZCvSbnm1cO03Q7yimcvTFfjK6v2GIQFvpPEIG7EOeSdEgketW4bMk23ohIxzVGfy87Q54bwD2xpt+rJa+c+pabTFz/N0v4LEx2OY6z3F6jgIcJEhfuJkvd6TrDwNqUmPMB
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:56.0316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4545e273-e313-4ca7-f81b-08d5e7bb046b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0701MB1343
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch add implementation of usbssp_mem_cleanup and
all other functions used during cleaning driver during
unloading module.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-mem.c  | 180 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget-ring.c |  21 ++++
 drivers/usb/usbssp/gadget.c      |   3 +-
 drivers/usb/usbssp/gadget.h      |  10 ++
 4 files changed, 211 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index b3d86d400dba..6ee068592ba4 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -498,6 +498,103 @@ struct usbssp_container_ctx *usbssp_alloc_container_ctx(
 	return ctx;
 }
 
+void usbssp_free_container_ctx(struct usbssp_udc *usbssp_data,
+			       struct usbssp_container_ctx *ctx)
+{
+	if (!ctx)
+		return;
+	dma_pool_free(usbssp_data->device_pool, ctx->bytes, ctx->dma);
+	kfree(ctx);
+}
+
+/***************** Streams structures manipulation *************************/
+static void usbssp_free_stream_ctx(struct usbssp_udc *usbssp_data,
+				   unsigned int num_stream_ctxs,
+				   struct usbssp_stream_ctx *stream_ctx,
+				   dma_addr_t dma)
+{
+	struct device *dev = usbssp_data->dev;
+	size_t size = sizeof(struct usbssp_stream_ctx) * num_stream_ctxs;
+
+	if (size > MEDIUM_STREAM_ARRAY_SIZE)
+		dma_free_coherent(dev, size, stream_ctx, dma);
+	else if (size <= SMALL_STREAM_ARRAY_SIZE)
+		return dma_pool_free(usbssp_data->small_streams_pool,
+				stream_ctx, dma);
+	else
+		return dma_pool_free(usbssp_data->medium_streams_pool,
+				stream_ctx, dma);
+}
+/* Frees all stream contexts associated with the endpoint,
+ *
+ * Caller should fix the endpoint context streams fields.
+ */
+void usbssp_free_stream_info(struct usbssp_udc *usbssp_data,
+			     struct usbssp_stream_info *stream_info)
+{
+	int cur_stream;
+	struct usbssp_ring *cur_ring;
+
+	if (!stream_info)
+		return;
+
+	for (cur_stream = 1; cur_stream < stream_info->num_streams;
+			cur_stream++) {
+		cur_ring = stream_info->stream_rings[cur_stream];
+		if (cur_ring) {
+			usbssp_ring_free(usbssp_data, cur_ring);
+			stream_info->stream_rings[cur_stream] = NULL;
+		}
+	}
+	usbssp_free_command(usbssp_data, stream_info->free_streams_command);
+	usbssp_data->cmd_ring_reserved_trbs--;
+	if (stream_info->stream_ctx_array)
+		usbssp_free_stream_ctx(usbssp_data,
+				stream_info->num_stream_ctxs,
+				stream_info->stream_ctx_array,
+				stream_info->ctx_array_dma);
+
+	kfree(stream_info->stream_rings);
+	kfree(stream_info);
+}
+
+/***************** Device context manipulation *************************/
+
+/* All the usbssp_tds in the ring's TD list should be freed at this point.
+ */
+void usbssp_free_priv_device(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *dev;
+	int i;
+
+	/* if slot_id = 0 then no device slot is used */
+	if (usbssp_data->slot_id == 0)
+		return;
+
+	dev = &usbssp_data->devs;
+	trace_usbssp_free_priv_device(dev);
+
+	usbssp_data->dcbaa->dev_context_ptrs[usbssp_data->slot_id] = 0;
+	if (!dev)
+		return;
+
+	for (i = 0; i < 31; ++i) {
+		if (dev->eps[i].ring)
+			usbssp_ring_free(usbssp_data, dev->eps[i].ring);
+
+		if (dev->eps[i].stream_info) {
+			usbssp_free_stream_info(usbssp_data,
+					dev->eps[i].stream_info);
+		}
+	}
+
+	if (dev->in_ctx)
+		usbssp_free_container_ctx(usbssp_data, dev->in_ctx);
+	if (dev->out_ctx)
+		usbssp_free_container_ctx(usbssp_data, dev->out_ctx);
+
+	usbssp_data->slot_id = 0;
+}
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					    bool allocate_completion,
 					    gfp_t mem_flags)
@@ -552,6 +649,13 @@ void usbssp_request_free_priv(struct usbssp_request *priv_req)
 		kfree(priv_req->td);
 }
 
+void usbssp_free_command(struct usbssp_udc *usbssp_data,
+			 struct usbssp_command *command)
+{
+	usbssp_free_container_ctx(usbssp_data, command->in_ctx);
+	kfree(command->completion);
+	kfree(command);
+}
 
 int usbssp_alloc_erst(struct usbssp_udc *usbssp_data,
 		      struct usbssp_ring *evt_ring,
@@ -583,9 +687,83 @@ int usbssp_alloc_erst(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+void usbssp_free_erst(struct usbssp_udc *usbssp_data, struct usbssp_erst *erst)
+{
+	size_t size;
+	struct device *dev = usbssp_data->dev;
+
+	size = sizeof(struct usbssp_erst_entry) * (erst->num_entries);
+	if (erst->entries)
+		dma_free_coherent(dev, size, erst->entries,
+				erst->erst_dma_addr);
+	erst->entries = NULL;
+}
+
 void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data)
 {
-	/*TODO: implements functions*/
+	struct device	*dev = usbssp_data->dev;
+	int num_ports;
+
+	cancel_delayed_work_sync(&usbssp_data->cmd_timer);
+	cancel_work_sync(&usbssp_data->bottom_irq);
+
+	/* Free the Event Ring Segment Table and the actual Event Ring */
+	usbssp_free_erst(usbssp_data, &usbssp_data->erst);
+
+	if (usbssp_data->event_ring)
+		usbssp_ring_free(usbssp_data, usbssp_data->event_ring);
+	usbssp_data->event_ring = NULL;
+	usbssp_dbg_trace(usbssp_data,
+			trace_usbssp_dbg_init, "Freed event ring");
+
+	if (usbssp_data->cmd_ring)
+		usbssp_ring_free(usbssp_data, usbssp_data->cmd_ring);
+	usbssp_data->cmd_ring = NULL;
+	usbssp_dbg_trace(usbssp_data,
+			trace_usbssp_dbg_init, "Freed command ring");
+	usbssp_cleanup_command_queue(usbssp_data);
+
+	num_ports = HCS_MAX_PORTS(usbssp_data->hcs_params1);
+
+	usbssp_free_priv_device(usbssp_data);
+
+	dma_pool_destroy(usbssp_data->segment_pool);
+	usbssp_data->segment_pool = NULL;
+	usbssp_dbg_trace(usbssp_data,
+			trace_usbssp_dbg_init, "Freed segment pool");
+	dma_pool_destroy(usbssp_data->device_pool);
+	usbssp_data->device_pool = NULL;
+	usbssp_dbg_trace(usbssp_data,
+			trace_usbssp_dbg_init, "Freed device context pool");
+	dma_pool_destroy(usbssp_data->small_streams_pool);
+	usbssp_data->small_streams_pool = NULL;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Freed small stream array pool");
+
+	dma_pool_destroy(usbssp_data->medium_streams_pool);
+	usbssp_data->medium_streams_pool = NULL;
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Freed medium stream array pool");
+
+	if (usbssp_data->dcbaa)
+		dma_free_coherent(dev, sizeof(*usbssp_data->dcbaa),
+				usbssp_data->dcbaa, usbssp_data->dcbaa->dma);
+
+	usbssp_data->dcbaa = NULL;
+
+	usbssp_data->cmd_ring_reserved_trbs = 0;
+	usbssp_data->num_usb2_ports = 0;
+	usbssp_data->num_usb3_ports = 0;
+	usbssp_data->num_active_eps = 0;
+	kfree(usbssp_data->port_array);
+	kfree(usbssp_data->ext_caps);
+	usbssp_data->usb2_ports = NULL;
+	usbssp_data->usb3_ports = NULL;
+	usbssp_data->port_array = NULL;
+	usbssp_data->ext_caps = NULL;
+
+	usbssp_data->page_size = 0;
+	usbssp_data->page_shift = 0;
 }
 
 
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 69cf478c222b..7c4b6b7b7b0a 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -52,3 +52,24 @@ void usbssp_handle_command_timeout(struct work_struct *work)
 {
 	/*TODO: implements function*/
 }
+
+static void usbssp_complete_del_and_free_cmd(struct usbssp_command *cmd,
+					     u32 status)
+{
+	list_del(&cmd->cmd_list);
+
+	if (cmd->completion) {
+		cmd->status = status;
+		complete(cmd->completion);
+	} else {
+		kfree(cmd);
+	}
+}
+
+void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_command *cur_cmd, *tmp_cmd;
+
+	list_for_each_entry_safe(cur_cmd, tmp_cmd, &usbssp_data->cmd_list, cmd_list)
+		usbssp_complete_del_and_free_cmd(cur_cmd, COMP_COMMAND_ABORTED);
+}
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 9010d3a3720c..a66209fc069b 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -367,8 +367,7 @@ int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
 err1:
 	usbssp_halt(usbssp_data);
 	usbssp_reset(usbssp_data);
-	//TODO freeing memory
-	//usbssp_mem_cleanup(usbssp_data);
+	usbssp_mem_cleanup(usbssp_data);
 err3:
 	return ret;
 }
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 04cc9f3e0f08..b19826c1798a 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1679,6 +1679,15 @@ void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 /* USBSSP memory management */
 void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
+
+void usbssp_free_command(struct usbssp_udc *usbssp_data,
+		struct usbssp_command *command);
+
+struct usbssp_container_ctx *usbssp_alloc_container_ctx(
+		struct usbssp_udc *usbssp_data,
+		int type, gfp_t flags);
+void usbssp_free_container_ctx(struct usbssp_udc *usbssp_data,
+		struct usbssp_container_ctx *ctx);
 /* USBSSP Device controller glue */
 void usbssp_bottom_irq(struct work_struct *work);
 int usbssp_init(struct usbssp_udc *usbssp_data);
@@ -1698,6 +1707,7 @@ dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 		union usbssp_trb *trb);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
+void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
 /* USBSSP gadget interface*/
 int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
 int  usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
-- 
2.17.1

