Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeENO7S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:59:18 -0400
Received: from mail-eopbgr20090.outbound.protection.outlook.com ([40.107.2.90]:3416
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932415AbeENOyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 04/21] i2c: aspeed: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:13 +0200
Message-Id: <20180514145330.4857-5-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR08CA0043.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::14) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:X7Z3sStox4t+sLTRxaJ6e9f4ZqMsFwN1aQmuRnx6L/d4/NgDUU7kYwcIrmdNL6Q7HidoPl7We09p7oDgn0lpn7uO+7/v5dVjLbTanPEUvnESt5HA32geX3vV4wh2mD9nyTjiztTz0KxuDzkRwGAcg8GxTc2MUlDWqSaMTK7dpIvN87wG67hvv4B0d1a95n70wziGvCq+DuFMtTXjj9X5POQTY3s57Nvjm23yOmLfPNEh6A9vsAdC0ysNKcqlyCdV;25:YK6ULX0sECz6l0GLfEHRAKT/JrgOkndCawwzY9ZiYD9A6l/q95gwWrFDNi2uHfZk7l7abPrr495VkNBNgniQFNEDYf+hjV1OFNR40QX3EVIeGqTl6HQ1YvJD86NQTFsycII08znsMFeB27YpAb0YkbhHhsO2nHX567hHE2DWBYBKQ02XQD8Qnl0nLIheYUsXaD65rkKMmeDNrB8pFaFNhwjogolixp1VrFu/IAB+0ZPBkP6Aos+HLaMvu66I3ML48H64TzvcyKJVDqypzoXSEpLTrt2VrsDzBG5vyqluXfW6cNkNzoXpQzD4SmYQnAoMg/Q04tjTyITbqpyJC69hvw==;31:uBQLLBIpqiw9xJZBISKkP7WK80E8lge/rvggMqQgg3Y4D3DaVeViLnJlcOI9ZIK/ysVcBp2GaV/L36vb6U8db2lEezuNqVlUj8iJl40BE+HYV2MXW4n+Y+LUG8TzMzoWJiJxQCW6CDLGqMhJnc+Zv2lNoaazO1SAZ0csgPAwZyBpqxVVNLrQ4Kw/sqkDGmcAmUWX+epgOMjS8WYDKDdOOOhffC1weVtjgR2Ab0DRMQw=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782B947BCC928B900A13C8DBC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:i45CPtHY+YSjIzKRUVNWp3eA9QTL7P2ZUeAQkIkq4MZlzosKrfwcA3wLpmTlMH7s2GotdoAie0jGsnuzBOV9CXdLEmVnhRbYWJe2KtrYwkADWO/Ru/aHPpMgq80GNvdyW0JJmAl6byNPKndeiZm0yx1iVYkt02kW1Hm07Vi16oyVGVBnRTp7eOjiWxqypPHpjECraXuHPK8/aKpyAWXl5sK4loDnWqfCcPAQ3vlWM86jNNI6tX/dz9YkuvjwO3XTGqK46M7+GfVY6Ew2iDOGVA==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39830400003)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(7416002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(575784001)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:Y2ds0rzHqTDfMjDkELPZzM63jkjxb6bU05X/1n+?=
 =?us-ascii?Q?l8MCs11LFzFdhideQ+HBs2QyOPxomuJVjZJbDjQzHbjwj0CovC3KaTJN/fKJ?=
 =?us-ascii?Q?VU+B9NFSh90mFZB5rWJFxaZ/3LTH61s1/1JtmrO6Sd5iv5EoPBSRcb0/eaKh?=
 =?us-ascii?Q?NoCQ2Agb55r7kO2w5kMt8q6i/befFudd+git7qHVGGeOt8qfm7gLJJDj61yQ?=
 =?us-ascii?Q?34uY8bFPrLSsUhHDSLaZMe70Bvu/68W1773mlc1dB3ssKy5qkpQc9rASs10K?=
 =?us-ascii?Q?IwgC5thfDNL1lwyE62VGuEuZiKiXqjIsqQp7KIweoGr2fknf66X+XCcflBLL?=
 =?us-ascii?Q?Gu+c3pwbBkumi3JJQ/7KsdXNXWEzFxMHbcHuFpeMrxN4RkuKLTaVMYc9ujp/?=
 =?us-ascii?Q?mZy1yNmm0OoZe6GOr2sg1i7ARCoFbKiMD1x2fZ7HtHcXqpvDFeukmNDshGI7?=
 =?us-ascii?Q?vULKN0W+9OC3Eifg+gxUyFoI6DgRcXR0jBG5JnFJOqEN0a8fGy+RvqABdznP?=
 =?us-ascii?Q?MECbVpLBey2Jl9blexDUssMPsKQ7GE2ZTzXYbcwT68llJivmx9x/iXNEIlf+?=
 =?us-ascii?Q?OfBdim7XiMaoLkmcP+CJq//roh8KJwhHFwu8nCTQ+bv8OzJbgVTLCTJAbFgV?=
 =?us-ascii?Q?oBYj+02Y+4TFA5H5Cz67LplSvivY/59NJOtbMYcmc+w/Qsl6Jqr3lEn8M0oD?=
 =?us-ascii?Q?HhtcIc9KOF2HdSVxMeW6U89aSkaYvrgd4iSjusDXBI1u9dyyHhUm0G37aJTY?=
 =?us-ascii?Q?xJhXRPDHVNbO7Z1OGIWXbN/nHm3eRqJ4HPimERRHcpj5JY4Wr+2ZZRIXBNND?=
 =?us-ascii?Q?6s1TJwtNw3+niCadiqzvG9PsV2ZSfJxyIDt2iOEf0Y2K50e4SYgo4xdNmRi+?=
 =?us-ascii?Q?sXauJg/m9Y7Mpao/H0oBOjsIX6pk2WcxkNDdRyrorWBQl6zmFh1nEMoGugxA?=
 =?us-ascii?Q?FCRyALqiTaLrbFuoCDwEg8Sw3VGIi4ro+7oT2KFJ8Z8X6sqvCe69LuAiz38c?=
 =?us-ascii?Q?9nhXxFyG5xFESxBJ1BS9PSkQnUtpQ1JdY6E739rZHGzdcNHni2vA1raI5OIy?=
 =?us-ascii?Q?Te5Im2Zl99mQjgRgEulXaTU08ulXU8ODkto79wgKtcAXWPvyGmhxWdU5oqm1?=
 =?us-ascii?Q?MVhqNQ2upWUFJl3YEbQnI36Qm1COvR7Hjv5ufjEABr+PRWuLxzMGDjKXyV99?=
 =?us-ascii?Q?FzQnUKW+x8H8/aKa2TTaOaZg4JgJZg41w3PPlnQQV7peTi5d4FUJNqPQk8i8?=
 =?us-ascii?Q?dkYAz7tAgs7yER/S/5MbnJlCppNR4G5jB+m4YWixTbeh2vtwAPnyfxg14OC+?=
 =?us-ascii?Q?s8H6F4dX9DbJX6f4goJLKU39+ll9BCRc4IOoijHi3xfLjisbSInSd1G7JS2T?=
 =?us-ascii?Q?RdwkPR2pcaYk3y2qbGG/0nDY77YY=3D?=
X-Microsoft-Antispam-Message-Info: Gp7+xWoFn3hvEDjQy1UVxD9VsAXp4Ysv0iOmm6/1bceGkT9ckbx6WEYOpsS1cHf3e0VxoiDPDvnavq9RGWsklo29KlE7KSjLX3j8KEzv3NMh2REfkax+c8fWI3bsEFk3yaGXcrx0GD/L2rIUXtnupeWikq0TG88cpfwOOq4p2RX+ZsnCErIJ/KmpblHx0MA5
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:paLvJxlQ+hR/l+d2jcMfYzMfvCw7Jv++JzOKSElywFbj2x7lzYjdXrge7Io7cn1xhXr7SlJJhphesDbD4RhmP2yJV9DdlKfdaOiehgkNnYhy2he7zHTyJV0sm06Mm9LIq4ZtKkflJmsOGL1n+b9SuxXRkmNstaLEMlIfmUY69bk/ZYMYBShYfC0zJkmO4q1uSeLs+OsBtr996Xn7pkFFB6XQLXME83KUmnIqkKRSQ9bp/sn+51hLB9tsgzpZkmtyk6GIEcDski6H5Hr6cWsGaYd91waZIGVG0cHB59HjDRVHeJiUphug6vij/+6Qt9CFht7/OyzvTR+xtg5VmwUBKvSJYsd/cZ73hebYMOdwLZzG3sN9wMDRaVXKKbbdMu787PBCy+LXFexA6TbvARVXhX8ozeJ7+tMQRyoCeo0IZ+V4PerbOK6OVX1vpCxZgjJvVxiXYdJ4lundlQJ3D2/92A==;5:u0NphFsBuDkbUsGjJLdiRrI29tTJWEuprvVH3nHP/l03GYfSa0tPpaSKxcuXlG26wDLr6xpNr6G4BP/aBMNsXZYoU2AsNeDn3wnivegpn7cz+2sOsh1VVbWNCxmsHbgy/BQ2EpMHp4CIW2NnDTFR1y9WhxhB9ji8XnUYZCIBZsI=;24:JIH2j+f4g8vMrD5Sl/+VB3z54rRB75wdZS5DHZGvAnnQmlcfAic/rfRHu66UNKgDhbGAgMCunbW+YX38904MP9ub7AV1vDYs28bWTFt+qro=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:KnSCTiMdDYtXxPdkxyD+HJHrMcYs+tWwy8mXacy/v1c5ix2+e0GYyVDe2P/U17yH4vxW9AgN91jTGbFBrhlJNkjR5ptvX9Nm9VKC7/7n9Qq9Zgmq3ZDQz2PcmmcekBVkDL0NtHajn6MJK0LyeY4ps/YvEn/dCpLfNEn4o4vzNs2JROm7Rx3Moo2bxOvGQtsM4bFSdzRyAmluwYUPjJjjxtTwLfoe/ZPF4OOJQkV99CWkKh8V9gmy9v5B7cT1dzHC
X-MS-Office365-Filtering-Correlation-Id: 131a0c51-efa2-426c-3a13-08d5b9aa911a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:16.4505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131a0c51-efa2-426c-3a13-08d5b9aa911a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-aspeed.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 7d4aeb4465b3..60e4d0e939a3 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -335,13 +335,12 @@ static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
 {
 	u32 command = ASPEED_I2CD_M_START_CMD | ASPEED_I2CD_M_TX_CMD;
 	struct i2c_msg *msg = &bus->msgs[bus->msgs_index];
-	u8 slave_addr = msg->addr << 1;
+	u8 slave_addr = i2c_8bit_addr_from_msg(msg);
 
 	bus->master_state = ASPEED_I2C_MASTER_START;
 	bus->buf_index = 0;
 
 	if (msg->flags & I2C_M_RD) {
-		slave_addr |= 1;
 		command |= ASPEED_I2CD_M_RX_CMD;
 		/* Need to let the hardware know to NACK after RX. */
 		if (msg->len == 1 && !(msg->flags & I2C_M_RECV_LEN))
-- 
2.11.0
