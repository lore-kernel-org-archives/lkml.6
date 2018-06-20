Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D8DC1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7272C20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="UvJ7XIku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7272C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932996AbeFTI4E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:56:04 -0400
Received: from mail-ve1eur01on0129.outbound.protection.outlook.com ([104.47.1.129]:30448
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932874AbeFTIwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwkWKYvfrWXhAOHByfEMxhZbqQ/UC87g/MEIKYpIito=;
 b=UvJ7XIkuDO+vY5Q6yDodBlfwGX/iD0kbjJC4zGXwR2RlmBIYoCg3aPY99cw4eOUcDuWWg3u42UaGhXoalzqv+mvfyFqYe6weDX2gzAkUSPlOfeP2r+V3dosVI/ImOsYdQiJlCsAAVwPOj8qO21JfEtwnsjwXrNs9I46FgKBSUwA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Wed, 20 Jun
 2018 08:52:14 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Subject: [PATCH 0/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
Date:   Wed, 20 Jun 2018 10:51:52 +0200
Message-Id: <20180620085157.30121-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0301CA0014.eurprd03.prod.outlook.com
 (2603:10a6:3:76::24) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09c57e26-8221-4ce4-b180-08d5d68b1eea
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:b3lKPAcVRFC02vt5CKhncyZ8Q/Xp6pSdTM+Vn7G6OOq3M19pesIg3T8N4H6DKAZWI+len2CXoWNdsE/e3yT1HSW0fJHhCJnahXgDJdFfTCWLufNMRJNQr1K/dX03XAJRaoJ35WYouGCo1wxu19r2NBAnE7xwvr7pfaH/zsP7nLLT3TpLECzzeTn3UPWruvMQ49AYLyB7i+Ost1X49dUgbNZMG+jQXMMw0nvfLuT3JItpBUO+QDP0XaAXeMRQxvJH;25:HKutXzGSHXREjaEsTZdug+8xLByq53j7AtKpkwp10C1Q28gRHN/jTW0UhC9b8kqRcThy3WSjtO8tHE16zvPQ6pwYKrqQo9OoIMu3PMezZkTsLGUDF6XzHvfKaAaqyQVlQ5VAZE+f0TrYqG3QlE8J50XRdv2YtVqiN7x5XY6UkfBRTIKhp/EqrPPp/z6cLjUrx54nHJGkAtScWQ0Ujy+lYZiUUQxkWPZXQEa7dT6t45Smxqsm8lXm6FXBUDrag1axZxEtW+YJ2d2DLswE5tyBZr1wJeXzm9oaYojZImOGTbUJeVJAL2HxP3+XKf+SwNTBLCjBaSIPxrZ2GcX6t+Tg1w==;31:KEwkk9PI47hRFmdIiFIEjd1QKIr1mnOA13FGqLyvH8aaPQ4JKpuVRAQw3ep/zRqHE5eGborKL68QjIJjc4vAXAF7DbzU9y8Q1vBp3tMK9vfSPpRNwR3CkC4dcnNglPLLsxvYDOex5rs9z9bbK0keewngQ6fTwxwAhwf2dHwUPb0huNniZNRTBWOOj8C2W9Xfjjmy2HlrP//8UfZaNTAtrUA+FuXSMg4f+Fn2Rz9U/rA=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24641F8AD32CE5505D97F297BC770@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:deXupwiXJP5Hj6HNgRTfgg5gnKli19B+f+NIugFYwit2+TRY4cp7YeZB2k/Yqv6knEZlfTEsJv6XcEj6MmR8I8N3hIPImsq2+4Mam7ab7a82oTO7NIe3bVUyXaX4OcnJlSH3ipQ9ylRueIBHdyvMHE0R+vsQaFw0zYr4m9DQqLKkRjVROVqt+g5nYxdbTdl2E03cj2diU3pIj2JBAn0DNGLO76fKVkTWtPZkfeLIY49QhduSw/mE3Gv374OSHhhtQHBthPfYGugGMPgur1BFCw==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(39380400002)(346002)(376002)(366004)(189003)(199004)(52314003)(48376002)(50466002)(74482002)(966005)(478600001)(305945005)(6486002)(7736002)(3846002)(97736004)(6116002)(6306002)(1076002)(6512007)(81166006)(8936002)(86362001)(8676002)(2906002)(81156014)(2351001)(4326008)(53936002)(2361001)(26005)(25786009)(39060400002)(6916009)(50226002)(68736007)(5660300001)(316002)(54906003)(16586007)(6666003)(36756003)(105586002)(52116002)(51416003)(106356001)(15760500003)(47776003)(2616005)(386003)(59450400001)(6506007)(66066001)(476003)(486006)(956004)(186003)(16526019)(70780200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:b4j2zIDskyLW0xV9Tzc4bqrHQ1puQJVVA0a5Dji?=
 =?us-ascii?Q?FsyQZcUgqS0XQTo2RRyYcatPkTU6mr0ZSor3gXdmgpd+JuBHlavNCW7W96j0?=
 =?us-ascii?Q?sQjvqlG14+VGGMXJB8G7q/s9SE2xEJV6fmp8e39ULFi3zSnEsv0udfq1HOWU?=
 =?us-ascii?Q?kc349FHVlOjUkhhon7JSnxA1H12TSGMkUUxyKQEQJp4irdy6bt0LKA/+KZgQ?=
 =?us-ascii?Q?lW5hGFyQnAJfljBHuaT/jqE5jyG66O9JDmE356Xe4ECX0o84tesKvbYWNHH0?=
 =?us-ascii?Q?rUWjS67ST2lIslOVV/0eeQh151YQiU+VA5sZhqrtyu3Er7XqS5prHH6wG6L9?=
 =?us-ascii?Q?RB61SSWNpx2hOsw1/e5QVr5QcsJg2r+PTCjPe4peRZp84HtGjXdgB8371yXC?=
 =?us-ascii?Q?r7M/ywUQ2dbLXAnUCixj+QtTET1zh3coKrUncXzLjdD1+DNuMornmtS6hAyB?=
 =?us-ascii?Q?hL4T2WTuiSL5GzcJgPzvo2yYd9E3Ku+rQpB1MPMGI7fFHtdpt/M+e1s0HngG?=
 =?us-ascii?Q?i0Miw1qqZEt3k1q5ccINxvWFdxwbM/5lSO44CJvN7NCTDRg8DoQZJZ60zJXy?=
 =?us-ascii?Q?cOa/QGMyW1pnidPGhyfvP/PguvtjA2stbUvbr3Iw/cj0ttjPfW0/qxPKXFxe?=
 =?us-ascii?Q?9qZSL97R1vVQqYF8eZPSVANmllFN3mNhuIobwfgCdRsLG6vOXRZgIjGClzXZ?=
 =?us-ascii?Q?adyAHd3u1u+cfyvXDSTTd71OS1YecVgrnkPeBE9ISDIyncJpfYN7lIiHXJDd?=
 =?us-ascii?Q?cZ4aiH2SkxwzMmdLVCgnweU3/iTNrVXPD8mCLmO4LSLDLb1RmYJ1LMlwuVWA?=
 =?us-ascii?Q?yZf86t9PwZGxfmL88yTkiMTKj5+qo2RhBNrFE4gRoQDHdkk0S/zByCU/kxfF?=
 =?us-ascii?Q?IXvCVeKzJgecG39H0Isom3Q6ivdPBWyqNE5EDXTTgMdtKsESEc60cg2Ae4LX?=
 =?us-ascii?Q?FLsrC/jHw+oc0yO22MDqlo7ohoyY3c6ZLwulWuPKBR7W+my5xWlgBcQwXyFI?=
 =?us-ascii?Q?+VXomBZnlwzftC3A1/sYOHSZDUsGMJAQx+dKRihYXQ80XHZIPeQ38HjtKq/o?=
 =?us-ascii?Q?zo4mmAh9a6s4cKfBQLN5hm2L2XhTMaHxt3eJr17httVSisYvSFhBpDldYAYt?=
 =?us-ascii?Q?1iEQ4miOi5inWAmRmdeJd/CN+Le4r5PNTI/AteFNGh6jWHi6M1yPwUd/PhOf?=
 =?us-ascii?Q?icSdZf/du0NYb157jPrN7iUYjpD59uvGzlSAyQZMN9YOMh3/gO2X6LvLaBWE?=
 =?us-ascii?Q?pCiBJOwe2Lq0AVRw9jAgyf2tZtRk4o+12AQ166EQ3TUl3BjQpBK3FHX6t1sI?=
 =?us-ascii?Q?9O9t4lO4JoVal8P20Kt2dnb/63aEo0WN2BkoVLgyi1H5hl74JhoOCr8dn8xo?=
 =?us-ascii?Q?VDtwIH9+U4fFLI3WAVVSR6ZeJQ7NwlELH3ssSCECyXZ0pV5No?=
X-Microsoft-Antispam-Message-Info: jXkjUkc3ApVi+p/0pB4/fBl25EaI7lQII449DZRvPh0OQ2SwWYSfZU1hzaSH/P7zgjKz6UsU4VD3fZ6xl8RY17DTtfe8zUmUIcoY/IMHgYVKTevg5Fk25kn4XFSIyNEKK/3Jp/TzT64f2Ac3tAJ3gOLQw88vNLyquhWrOJ46WvZi9+EQNUJZsNJxcpPoD3671uDDKVNL1ZLSpIh1hBZIMYjeXQDjxzzu8vw15Sc9mC9OQokLONi9oYb207UNqYwiLG2+Yy7VB7DYu+XIdYr8GYaF+pya1dYqtl61ZVFLQ4p7DZCO/MWmAywDFphP2Ij+nbfGhdPVo5mM3/dg+IjztA==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:kngd9slOoYcahw0/tNY1mwp9mKw+jYNBClV/nzx2ohvRuJigVp7LqIMO3uNisdVxDM2jheGQDswiei2Z5qnX/rdA//U2V/rPo8Ms8Utu8q5U7BlfcRaHfPXhDEXCzMvVLEC1pqzY1e4h+R+PMjQj+xblX9VvlwjOoDrcOl/1ETHd8BoTH0yVWigPMEhVIETPt0OgUPY3pJKNIHcJeS7USIZGiSLIGfELw3lYk65zXJ1gg40eB9VvmBrm3WKq2weFJzGw4W77dnWCHhFthxSpexW0tEGDs31mWKZ2NVSi57EegmkvEyQWKuq4MPmQbYmvFd0P6bbQcsnOZwu6BTQlR6/DQl8muuNjO1fJd+XIrmf3t8SnacNQ6R8oe1DoOSTp9dQaj9vYdBoza7LS7T2rSpEsNExhHTEWyJns/9c47Ag0CUxu7DDs1uFP1vfwXlQMdkNpcwbmO0aWdFmxrcJ8Yg==;5:b+2WZEJvhSKzt9MEgA2AAsjKRxrDm/Q1Ec5BwdwtEFVgJLib41uDFCSND1SM7s2JtwkBZ46geWsc+afduPZQdTUEj3xe+LeByxQD41ZkRcpW/6/vdYJ6fG2aRQMJR6r+H01duAX1JSLIfbJmpqyH2XTR/2Lhyrzi2zr+ByUs5ac=;24:4cWGh7+zOectxpcvUF0Tjfl7Lor6BgcKg6x1ehgzDKByxZYETeB5VRzZX6lzNnZ8xRTrsPEQq/Pd/iaS98pEzt/6GegP0ZJ9cwPwvEO3yYY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;7:EcokB9HBo1qHfj+xNvIAFY2I27jkS6RBBvo3rczT67fbk0Kj8+ZdHPmo/hrGm8WQgHUYEjlWzHwi+AUNT/K1u8a7eEpOhMLZCGVHK6T8eyACz2Vzo4lD1MVjASltC4+ua9uQAwrizo49KBxnF2iUVbNfHEufBu4lviLfD64N5FBHTh/A9vAAMPGG+9youqlFRMQNgP3TIyPagjcMvl9HDRSxQNY7dE1MSKsZNYEpdJGMBeUbe5efpxRrExI2Kvyq
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 08:52:14.0757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c57e26-8221-4ce4-b180-08d5d68b1eea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There are a couple of users that could benefit from an unlocked variant
of i2c_smbus_xfer. In response to [1] I dusted off an old series that I
have had in a branch for a while that adds such a beast. It also converts
over some users in the i2c-mux department.

There are a couple of remaining candidates in i2c/busses/i2c-amd756-s4882.c
and i2c/busses/i2c-nforce2-s4985.c, but frankly, those are just too nasty.
Why do they unregister the root adapter and then continue to use it? I
dare not touch that code...

Anyway, this series looks like a nice cleanup to me, and the recent sccb
patch from Akinobu Mita could also benefit, as indicated by Wolfram [1].

Cheers,
Peter

[1] https://patchwork.ozlabs.org/patch/928386/#1936016

Peter Rosin (5):
  i2c: smbus: add unlocked __i2c_smbus_xfer variant
  i2c: mux: mlxcpld: make use of __i2c_smbus_xfer
  i2c: mux: pca9541: make use of __i2c_smbus_xfer
  i2c: mux: pca954x: make use of __i2c_smbus_xfer
  i2c: mux: make use of __i2c_smbus_xfer

 drivers/i2c/i2c-core-smbus.c        | 28 ++++++++++-----
 drivers/i2c/i2c-mux.c               |  4 +--
 drivers/i2c/muxes/i2c-mux-mlxcpld.c | 28 +++------------
 drivers/i2c/muxes/i2c-mux-pca9541.c | 69 ++++++-------------------------------
 drivers/i2c/muxes/i2c-mux-pca954x.c | 27 +++------------
 include/linux/i2c.h                 | 11 ++++--
 6 files changed, 49 insertions(+), 118 deletions(-)

-- 
2.11.0

