Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1718AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B001F20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="fa8emS1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B001F20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933212AbeFTIwq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:52:46 -0400
Received: from mail-ve1eur01on0139.outbound.protection.outlook.com ([104.47.1.139]:2477
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933114AbeFTIwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl+pdELZkusLdBRDe8hbd0nW+m37Yp5ZmeceFkpp3qc=;
 b=fa8emS1odzYialazVtgEQugzjqmsGqV6dVxxiXZRYKz+MuOJBJZLLi4rXTWnvYVZ8rmXGwg8p4buvjIzvtnNvhPrNBdJ1luvQJG1iTniE4Btoaum206LAf5JeooLKTdxSEbV7k5D2WnLY5LyW/7A1Nkqli/EjDu9NH/XgdRScQs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Wed, 20 Jun
 2018 08:52:38 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Subject: [PATCH 5/5] i2c: mux: make use of __i2c_smbus_xfer
Date:   Wed, 20 Jun 2018 10:51:57 +0200
Message-Id: <20180620085157.30121-6-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180620085157.30121-1-peda@axentia.se>
References: <20180620085157.30121-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0301CA0014.eurprd03.prod.outlook.com
 (2603:10a6:3:76::24) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 915b9d55-cd5e-4821-2e17-08d5d68b2d47
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:CRlnvH0DotwA2uQwkyOKqqwwHj5s6gS8eXIIltcQZXfqpCos0/QwzBk93Bqd0TnMHxpxeXPcZvPnxs8PKkTl9OxXyCE6QuODVRDCdahc4oOU6Pmb3CICrYAPVUd+aKlbNCe6NNQw1bqKuSP7BWx8XMie0TY8Ov3CrgXD+UcGJFd6UGfWRP0VPcO5LrNFnqJtRbx+CFKj5BO+7IcOa4bb2TaRqi3PEjRCge+T4GrE9YJWzryXvuPX2iCkrrcrj+t9;25:wiV+zcJrZh7AKzNjE3fIjAkPEFXz1GjtNwI4zvRp1q/mtHhnfVvCh35Kk5pivw698zzfoaIJfL6NTYdACMcHPF0QyKeZGojaOmxfFRF2jfRKyS1LGy+NsssyJuGPrC40xE0i2yFQFvxuVlOTrL5gLHoPjMxLpX9kK52eFiD/A3CX2qFJgf3GF9It9+mcDE/GCSg0Of7cw4m1Md9FssGT6grs+B5cpdpeB841K9nvs526KAI4mwNofVtKxsr9qux/dxPn2FGatE0N34vwiRgsQM+f/wKaNMOvdUwAjRDqVNM/I0qypQLp1aACncYEQGcMiRCI8aRlELtUiYrWchnl3w==;31:53QnlsbpcrpW/Mogz1mNEnyoSW4nd7nwYCnfoS6h7EBUPVoA7YLQOTNMc4V7/e9f4bL7/CzHarWzFEyj8YbwIkfezPG3uSsNkRNtdSVGC5tcER+KHWxZprSQjfyWfq5nXecv6OhLdNq06n4jakYw6TjS+JeTFQjCXV3DBI3Fa38eG0PVHhe02Kb+9/3c7ph3PEi3/Lvr6UdTYHiHPerDVxiqciSMCIegqi9Zgczk2/M=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2464310543D0B6BA6AAC1CE9BC770@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:Xp1MyLZlTxRbgoT/qAXQrFwvWatca+P5J9xB/b9Eb7CxfXQYvJE9awnJDVP/kdOaGmljoAs4LFRF4nZPILsgnGFOQa8y9kByEnYAdJVeSjvqNtAbiCKpOqYWLhpDynzQO/zuRtfmQ/yuxvf8ypRBk+Jr54Jgfrz5SCxcDi9JW7JaGiNqfQkk3ak1d0Dq5mK8DEZVTeEak+/lDIxPTQEVxejgFoJi4V90IFRpRO8FWSWwkgs1EltwnYL+5pC7PDzk38OvhzEjpf6iZwZd6o0U8Q==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(39380400002)(346002)(376002)(366004)(189003)(199004)(48376002)(50466002)(74482002)(478600001)(305945005)(6486002)(7736002)(3846002)(97736004)(6116002)(1076002)(6512007)(81166006)(8936002)(86362001)(8676002)(2906002)(81156014)(2351001)(4326008)(53936002)(2361001)(26005)(25786009)(39060400002)(6916009)(50226002)(68736007)(5660300001)(316002)(54906003)(16586007)(6666003)(36756003)(105586002)(52116002)(51416003)(106356001)(15760500003)(47776003)(2616005)(386003)(59450400001)(6506007)(76176011)(66066001)(476003)(486006)(446003)(11346002)(956004)(186003)(16526019)(70780200001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0201MB2464;23:w6xfMD6KGuEktewC5fTAKD51sEJJJj7tKPL9bEv?=
 =?us-ascii?Q?Zum5Hd/Sx1wCqYwc4z3Ppm7Mbi3DnVCuTJSh/Fs2U2C6k0PioN6XYQ8GeQUS?=
 =?us-ascii?Q?p/GT5BAJj9pgknPlpTW3acy8ObEwCEYHM+jnWa4Dj4hV3kHK3eRl9y9N+IQM?=
 =?us-ascii?Q?Ipa8u5Hmx44JHAbc0m7pRpIL7XlTu0jygbRGars3136nT7zs1mildwPPp+oQ?=
 =?us-ascii?Q?mkAn3B/qyG7OaFghafOm5kXnbTVDV0zmvwijEW5dRlbJjBwHq8DWEzKjBBOA?=
 =?us-ascii?Q?pJiy68xyjLdIs6Z4l9gG7+9HYh1zBkPs36AtpMxxPCphQUgazrVYgo52f1FY?=
 =?us-ascii?Q?YJt9qZIsr+AibVqsMD0xB/nghLfIjbooWUfgMLa8qCS6njgIupHUhTHxsrT3?=
 =?us-ascii?Q?Mc2cz/Pzpp8tKOiWWAKF23excE/18/vveh5sy6nZGM8Sd+vltm7np6La/UGZ?=
 =?us-ascii?Q?UgEftUsJR0YeueXOkw0+YgBYyFxxCO7AvUGJLu5LGVXCM5kIOCMDanNqx+pj?=
 =?us-ascii?Q?h2Bg6YfY/0GTGDjaUv6S4cprpxCak7lt/uaVgaecNUbl54DVqL7EEgcfjw02?=
 =?us-ascii?Q?m08n86HT2mDFTugdRx3ZYVuSfmptcuvEj+kb57i3QbzJ2KyjF+WGTkJ8ceEy?=
 =?us-ascii?Q?cuMSYwb1xGB78CssQ5q9S2H57VGXWj3CozcpeQ+32GG4crNLqXuAnd/5dWo3?=
 =?us-ascii?Q?V8hM7oo5UJ9RIW5/MjV9n6pT+NH1nA5oGVgkdcNmlqeyWIv0RX601Yp3kna1?=
 =?us-ascii?Q?xpWvFHJ6UQa/34eP2769J+SXrfVSdtrhtHWaZDndL/IRc/K08ofvS+vhM1Fo?=
 =?us-ascii?Q?6Bq6MR8hUGRvWzGeNdyFNlIFpFmDDzVwScgie5+rs6D1XjSMP7VcOAlaQ+GI?=
 =?us-ascii?Q?xJSZi4pw1vPpcYWlPXKZ47eXVMua1JDfRhNqY14JQ/NUFpPD+KTSP6pj/VPd?=
 =?us-ascii?Q?HCgYOVDY2NWtYXAnPxRsUYMSdgb3QGN7gHitwG/BPm9TbSCuJkbUKLcHsr5S?=
 =?us-ascii?Q?fHPbuHd6d0+3XoHdE35IwkvNzvA3jDtKr+zhfkyLYzQdsyweitTcvvEc5swH?=
 =?us-ascii?Q?0llWiFVfsVlQR6bRhB73aOsqXbIgyVAAPNtd+c+fT/S+IkC84OR+k+yY1vLz?=
 =?us-ascii?Q?Q4QapREhCiAk7O72DdcYd+5hvgTLlzHD0QD7DrpsuZG9m9A3bWmi7l6kIFo9?=
 =?us-ascii?Q?FAXNV1a/mxXz1Tp3AGZuBLUEa/E28sXlXb6lVcMTL70W+8i0IW1xvYckUvA2?=
 =?us-ascii?Q?ab/qh+ZrIhf7sn3wQD0M+gD+Y8PKxIecsUwCMAete5dRTilCnRMXkHfbuLaM?=
 =?us-ascii?Q?eo5gwfETgiw9hWBbNia9d3LY2RnqXw/Je9QuMk4kCXfdTcR6Atc9kickfk7C?=
 =?us-ascii?Q?FcV5iRIuUegCn1ewzxkF+LWZIrH7u4y/EE0SmOoqsnWS3ZKlf?=
X-Microsoft-Antispam-Message-Info: J2uHPcfoqHBvREx1vML+blDv1F0RBZ7ANykFW7NhNZcc8MIAIU6HPIc4R76x2lzS9F0mO135i3xizqmBWXZ6lux4AqijLV0IyHIoPPf/qAPWluprVObfX1ec10LW/avrTXMuITQ2qr3q6bViUqfLp90PShjz8T33t5R6qIsZaxkspGApPiJnzlci8Rd5sXtWIIGlGu1eZk2FA9CZgb1rvViN2fvnhwicDRKRQPO3DrdBaoeG+qjtk4B3/CQp+56/9ewT0nJD2nyr+axixYOhrIQLliw7JiizDOFQBhw4uU74Mg0mKNd+Wtp899dkjS+KQJc6MJn77Za25QZKJssltQ==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:tmxzf5lP/nviU8D69tN5B2EgOU6QkCjIhJHqwSdmDDCGnBqFdESKhsoLs9Q49EeFuko/2L3431HuqwrN0cg+IsL4qco1gwRcRzenMFpc1nApbq0tLoXR7Ry9MeOBpMKIvwZ+B8gkpnZDCXHgj8+lMbtNZLaZz1T4EAfNxSw6ZBNo76LN4U+fQtcr7VraXw+CVZsrRoJuEYFLHpbpDTAE5Y1Qa55x9rC8jmVCd0d26eUACnGGr+Y8I4HT9pFGKjrVUSS2urepgq8gsPQcxKfS6lLkBRxtKpQIwU1m+++wl7xu8Lbp+RUrMZAoGSqS0FV/p8RFKmB/1L3toz7YajuogGsSdUvzDi3xOAu8+FnBYcHcLvRaRiUCHl8OOut24K+a3XEPox/6/kjl8iINn2toiM2nJkX2nFwdy27Zsw0RpP3wfkeOOlH5bV4SkxpEdJdKU3xC0L69pSuXMr9tptICmg==;5:XqXjKIFDtIwlPQHpZUy1I6a2GSVsXBet9/oDbgfCR3pwVzGI7jPUSsDGusUAQi2GQaklzccrj788tkyYIsnxts3fFVtGtkzK69IQmlNkHJXzpR2IYZV9HAYVAEyi1zwRaqS/CgkyZrokV3dMUd7wPu/9Gq1szUH1xMHzkt7RosM=;24:/AkdK0a1FyHB7gAqJPYPNIM+Z2hLK13/IO/YSZ4aZkR/JllOlSKlkCi//+4/F/FQ8bE3KlEKYLnInv/klt0TmSmL7E6Mv8nY0FjQrQy4ji8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;7:32GiI6zk+/Lrd9su2WLF3egPvUn1c3LvtxYWFPXebv/HRTiEX0pKitZnUfH2vVXojsQb3HpoZ2LA2gw4dTm7EvBr8M3jmyzF5QBazij0N/H9fngS77MX4JeUrZMc3Id8AZ3ELNxNSnQvd1HAhQUt8NOzAIL1ALeh1t31Iz28cmyTZGedKIHM6YE6afhzN3w4PP5neLB936o3wDQYe3SgpvavUTr08aBscNdULTf30mQ3sllScZBVVzhLWiXqKnL4
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 08:52:38.1699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 915b9d55-cd5e-4821-2e17-08d5d68b2d47
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling the __i2c_smbus_xfer wrapper in __i2c_mux_smbus_xfer provides
retries and thus makes the parent-locked case consistent with the both
mux-locked (i2c_mux_smbus_xfer) and the I2C transfer cases.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/i2c-mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 300ab4b672e4..221365eb7c05 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -87,8 +87,8 @@ static int __i2c_mux_smbus_xfer(struct i2c_adapter *adap,
 
 	ret = muxc->select(muxc, priv->chan_id);
 	if (ret >= 0)
-		ret = parent->algo->smbus_xfer(parent, addr, flags,
-					read_write, command, size, data);
+		ret = __i2c_smbus_xfer(parent, addr, flags,
+				       read_write, command, size, data);
 	if (muxc->deselect)
 		muxc->deselect(muxc, priv->chan_id);
 
-- 
2.11.0

