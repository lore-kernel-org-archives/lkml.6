Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754146AbeENO56 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:57:58 -0400
Received: from mail-eopbgr20104.outbound.protection.outlook.com ([40.107.2.104]:52928
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754014AbeENOyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Subject: [PATCH 09/21] i2c: emev2: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:18 +0200
Message-Id: <20180514145330.4857-10-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:mNbldT4ZaXPY2CaDpNTro1lYUqu2a9mhQmsepUXvsnLnWvJiwY08WuUX8kXeubexLuoPLP/9rVOo0Jjoe0mTrx/bjFzXqZBpqC+Fl0R/B8wUcw1ck2PT+LDr7zWL+63t2Fg3prskw3vXM0a3pDLAtBbPp3gM3Riv15wMPx5R9wkzOkHglp5uGbF10jz6ffepgTr5B7zJ0EvtliAMGt4nyf+a0Ei5dK2d2ARyO5R4zhRKKlZXyInSqq+qo24DnSsq;25:YsKbfT6m6TLCZcOUyBKEb160imqXWcLukqggz15PMan1ED1Pwc0xHYGVV3E+vi3ZjkL5OJbBzGs4Siova1s5RxjdzBdq4/yUGffNSegfwGhyqLvleSYfwOKmsSqU/zNmNwongbNsT1tvHF+Nx0qoHcHL8R7UuBgloNAA9dGJE0V2PqMeCBlrtCSwwpyf9JGH7BwdfAFeZ/1uIM/HXSiYSTWxhOj718sAzIaIAYcSY7eXaZQJW89UZ6XH0vePofJ4Usaw3lRrS6WFQHBtbR2QiJ9enRHzW632Q9IwFO5H1ce2KfaRiH+Y9JxXfMSi9VNMzFU3cVO62iDqWWyJH3GoYg==;31:qpOjRsm4UhuOj50ckUg78mLyIpDieCmhx+3KQRi8SqHk7cqSGQolFmbMTJPpNA8nk1W245EWhRCjo/esLJzIEAjE5u+hdOwUZOiaYuDk8dBIEJeN+SbFVgrCTZlsWYIrwKkt0L9/x79zH+QqlDOLlbq10T8Mwm/uSKxsonOrLLl07lY7rpGgg+QApkn9tNWV/O89/rfrj8LhoN5R7R+A++dFQgO77WlQgoYcNFSGYsg=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782F3931FDAE4D4A0B82162BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:Os3zpvlSkGuLzifeKFaT0/TJ9d5XGEZ2lvgiI5nSgaO7PzyfVjxNaJxp7zPXUgoUdFobLpjKVkoE3lo0fMruF5iECa6uB5EiOjI5HvOFDqitB6k5zVb0Eya1EdGQFOG2M35E9YDOItt/gCJbNZMfu1i4nVnTdfGpMshQmOY7X7dv5146zJJX/veRIKgqEzNphJNTHlpTrD/sksEAdtzRBdr1UlMcT5vmIYpmzUV4jayusXIrkV7lxLzrDDQHJgYW86kH9HZUzzRyKzCJjudbmQ==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(551934003)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(59450400001)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:G2RfoUDgjC93zDJ/W+wUts0TVuAsbExfoG766lT?=
 =?us-ascii?Q?23mQeLmlnxUEIC6i60NEw+DfQerxFhDgtUFWCd2UpE3v9FSulWdGOxlVJrO/?=
 =?us-ascii?Q?oBuimbfJGoE4T7/NuJK2WmFldmbKedBeIuz4YDlhx13aTJRuj0XVZTDh6rZ6?=
 =?us-ascii?Q?LUXh7fJVLAjRgE4CZabgZi8i+doGty8c9jwr5KrhpRxDFtRr+hMVopHhaBQ3?=
 =?us-ascii?Q?ObRDzpv9N5F0ZEeC0DfhE5qm/HtmafDz5I3mmAVfv5AO1JQQnu0L3EYuKWTI?=
 =?us-ascii?Q?fqQziwwcmn6TKrlI4Pzk9lOYlVANfyaetOG0+B7Ci3XXwrVDZZqrxboO3GfT?=
 =?us-ascii?Q?olva7bM3MqN4i4V3puwE7/nGwWy3sgv4KBeHmXDq92XUh3RSsl23XYmfBvec?=
 =?us-ascii?Q?iQAHwVHUqlfOKhaZXP4l34BnbHE3dg1jDsmH51wQ6DsWuKPh2ZohbLebD8jH?=
 =?us-ascii?Q?BmLfH4ttQ0mE3XJoh9hSjyl/7PgJ7diCKF0iQtJvzA2BOzql5vxywP3Rvtl0?=
 =?us-ascii?Q?R6YsgubDLb5Ys+njhcGQ8ydybotidYGwo6uXUp23AmpjB+lo3d/53gN/wrFx?=
 =?us-ascii?Q?mOHXsnBA1L7I3tEAjI1p/URXe3eMs6w0Ghk4TXHLj+9N/xYjG2TwLJ5s6AOB?=
 =?us-ascii?Q?1ZrbhQG6MCyNxXYIGlu52wiJIaHP4F09wXEDs8X0WE/tKOlEVtQPmr2CCyY6?=
 =?us-ascii?Q?Iof5kFi0LdYNMSZFea6tp3TvHWE1nPVS09ZuKbKquaB5f2etczbk60JcP45m?=
 =?us-ascii?Q?JxiGtbfA7IKMYJnTMKo7JRb+tfxCANshCVHfddTPSxOmch/7F+sRcIomQvpj?=
 =?us-ascii?Q?QJaTmxyOxEJMUfCTkG4qyXDkQ5MMUx7txPPXs8uBQtWSCptw6ZGv1X9IlifV?=
 =?us-ascii?Q?8F1Pccc1SpkKvE6S9zvkuGd/3V4x8VX2TPm5+B/ANdpIZ9w/0zJirZMo6VG5?=
 =?us-ascii?Q?ngK+F7tI4j0m9F1+LPMUZErvdgGqgN+KLG+glufASdFcgl0kywlOPjtbwkkZ?=
 =?us-ascii?Q?pd9E2Xs+LUuZJInpZHWkbDijZ9JGSiMH3LmIKBJYoGKI3yQxUwPaweEhqmnp?=
 =?us-ascii?Q?Wd3FNHJnGBC9IloUdPKFcDj6kCq9dWXGbZ2Qq50fi3FHQVTuzftRsHSW+Z5N?=
 =?us-ascii?Q?qreiyTCg20TZuQ9jHGfvHELZTVoBP20jL5E9so5jstL+L6Z4FS/xOSp2jtDa?=
 =?us-ascii?Q?zXVxLolLrVLgh6zL59spc2pXpeLSR1+6K6bF5K4BO0MT8PfKgtCwW01gvSH7?=
 =?us-ascii?Q?nUIimyNBeuJNhP7Y8b+ng47JJvVsApdlBg1pXeoERHfpB/NbBrcvKipvH3kE?=
 =?us-ascii?Q?buJuj+phu6//5WGcKbLb0UUOTRsoEK26OEi4P8lgB5vO/c1bglbik3cfhR9/?=
 =?us-ascii?Q?ykg8uTwMKuyDIA2Ea/e8zson5llw=3D?=
X-Microsoft-Antispam-Message-Info: bP0YY+FW9Zf0CW/efZFndbBXwYf7nwVmdbxEA7FdqSioZpd67vplq3AO9YKr/Qb0KWIllsWKkdnQD7l6149u/uzQyOip6vrH7vDltILtN++ebVblrEYU7qr8bkMQOcHu3u2GhbvPSFqgrGu7FUisvm0cKEC/L1Qh3f+W2JEaBIjcFvm4gfxq5HaljvRoCHxF
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:aYhFkBKDUoVdQgOXQopOLPyyc57gTq3cKETUN8peWeaA2NXeIEro9ocSJSN9UMaI5aSuOGp2qOO7NLaV9O515ei9Kmg+rYaL8udjVGXSJVQDk2WBOcai8JGdkonsKZkeSchihdXdB2r3brKwuWWuXcNCxJQhtGBebNFcuqTLWw5ybPWUQB4OX0qReJYwx6ydT6qnnTHqmQ4RoxHtbO5etQDMUCZUUJj43dsBqgIcjbJtNvnLbYvG2HhqO5JiyUsGV0dk4BUkFsIKv4V2N0xKaH0igJTFKogqmugjfVSMbhRJrMmkHPlTE7ewqzSYdFrM1r3sJEVORdR0R5Wh2PjoTkiWnpUR9YiK2LLHnVpADsVN4W8qOKZj7kwJUEZ/fIAHLppdpar7WYDCxEJsdMXINz0rvnFfv6aG7wNjL3GmOa02aPnon0lDpjJfsOeIFNmve/deNboUE4jXnM0UZjvFOA==;5:j3/0ljwy+2OcpB6VK1VtUr1VKDHyzIOVDdkodz58Jl3YS5clW3dMxhWGAqz4yOERrExkp0EZKGnDcf9N+d6EGzsBooqHUSLgXQqNCCMyS5DEoRwSyGpCmz1cyQGDRO7VdXa2nKmdC+n1TQ1Q60iuiXwJ7lPzvz8NRqTfvaq6nIY=;24:kjXevyD+DMOjderPR/dCWgKTbF2SlvB0VNzNnyYby5pXUI4p1EAO0/EHa27pHcpLjuAra/eG5vwRd1R/vZLAjeHvPpWmcQSzNOhTKhZqkJs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:A3dugPAwPbnMwIbqhNDHjCfx+k4LZGd2JrDeuuedn+mr0lQ+XC9nyR7VzE7kyHxFec+dp65FTVOikCMyR0bhAncvZJniHYRl2RnZ+8F1ghuwMNqN+m0MB9Qs3NXPgNGzjgiClQuwkWw9FhPT5ma1wrdTvHFMWPHYlTZZsSQdOBBr1klbO0SUlRdex/94BRDajN1FdpYq2usV/tLtNWR91O/zZ7jX3V5j5qHBXB3Hl7LOKPWvAxkquY4nieeY4/za
X-MS-Office365-Filtering-Correlation-Id: 526099ce-dd87-48c6-3d12-08d5b9aa9977
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:30.9506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 526099ce-dd87-48c6-3d12-08d5b9aa9977
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-emev2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-emev2.c b/drivers/i2c/busses/i2c-emev2.c
index d2e84480fbe9..ba9b6ea48a31 100644
--- a/drivers/i2c/busses/i2c-emev2.c
+++ b/drivers/i2c/busses/i2c-emev2.c
@@ -149,7 +149,7 @@ static int __em_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 	em_clear_set_bit(priv, 0, I2C_BIT_STT0, I2C_OFS_IICC0);
 
 	/* Send slave address and R/W type */
-	writeb((msg->addr << 1) | read, priv->base + I2C_OFS_IIC0);
+	writeb(i2c_8bit_addr_from_msg(msg), priv->base + I2C_OFS_IIC0);
 
 	/* Wait for transaction */
 	status = em_i2c_wait_for_event(priv);
-- 
2.11.0
