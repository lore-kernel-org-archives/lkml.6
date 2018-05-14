Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754214AbeENO7n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:59:43 -0400
Received: from mail-eopbgr30107.outbound.protection.outlook.com ([40.107.3.107]:37024
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751953AbeENOyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:13 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 02/21] i2c: algo: pca: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:11 +0200
Message-Id: <20180514145330.4857-3-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:70dEk2Sz7DX4VnL5SU0MSsjo2eNAAe4p8IB+nj5h5iM27rC6znBtQVo1e48uIcg9naDSgxaoQSQfbMOIcXaDyahcb18lvsefv9w99X70eU3kIYaT9q7UJhMmIthuS6EOQhL+Kd/MXvao3KoTuYfOUwB0m+JqETKoe9YBt6FTvZPDY3EYCxWVTX5LCnpd+ebuVPvCCDOT9I3biPA8wsgyyg4AtitOYHKF9HzwAeRukgGepVmD4UwjTDJpsj6B4O2x;25:gme5T+BnIT83P4rXNp6RqyQsWcCwhaL81Q4H7qsPrNH2uqR8D/WsnBj2xwo2JVcsfDR7J5LdDewDl1gT3rFdoXwVCJp28ZYYxs4RYt53z/Ea/ufNzGEyxCRiFtRyllzh4Vh72eZOOXFuHDQwOmG7RtXYViujFvbzkAGBXue06h1GCqHInH+JAYQDJOysYHg4yg8r2SzyPuerhAjXL8g28H6s4VEhDSjffaUnGZrIjRWZTgK8WhvkIQ+pZWEGZJER/nEi6rMgtL/aXqtv6pOpcTNAEtq53p7dydlcGyGDV6F8vSsTAkrX2idA7bNUXQxlVz1bIdDvRunwPgwAPPVxxw==;31:SF3dZHqhJvOc9t4F6zg0yJ3Qbex3UHEHnU3Ij1rV1/R6DBGhtT+JFg9WOjdM1DsDyn1aFpqA6sf3651HCxRzWit+9aY2f0aC28pxALTXnbo8JWmozxQ1ni75tW8bDRtHNkd9Pf/ITXSGyYcgrkEmQelzuywdCZQU7BS9gsENYnEgTf4ukyATC/H+1ZBU9dzxHcFZZypJK562HLasILKbYHtBB5KKmqoStbEbIdTmRIY=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27821C98F2D50F90C40ABA08BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:8Q7qNfEs0KqG0G2L5rr14hK/evQVk3f3Qxs1X+A50McvDKGiGX9ASUzC4hh2qTX13vrk6yDnJIxZ9JHG+cq8NH8qflKN7KDFbAvSgrIDQwpkH9wUaVM69NWlqKAWE2OGMhVI9QJq06IRVKlRv90lrp49Vf4IUwlptu6/XrItOEInFTRCxSCqVNRElpqO/axicaXcHY+W0shYOdG4HN4ZuQrpP3KpbQgtT1ZDMU5Tj5MIuavlYz5idapx+N3bocWSkXY8UAfleUv4GZhWwBgSHg==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39830400003)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:W+qRzF+8qqhAHMv/XBKMzKSWQ6NhBGuxmQxj/34?=
 =?us-ascii?Q?+Wp2EbLMcH09Fn3xhHniHhG1EbuJqcyZk6ScvywJpfvfFaMd7Y6/7JGjl9SM?=
 =?us-ascii?Q?tTijg2Hbn51fdhy2YOGSGq2uYDeM6C6RY1y8NkFtz5WCGPe7fCqK38+KhEnl?=
 =?us-ascii?Q?Zb/y+n/uk/d1s4ryMHPM6aGjZyiEJD2Tccn2lc3prXhFykpEsVo8jzPc72bY?=
 =?us-ascii?Q?vKX+1hXbOeosMDHXy9tjzlhodKgihi8be01fQflOPyE1oWy3C/jWpmPPr8oJ?=
 =?us-ascii?Q?oB0g9fMBxAQiIRD6cMh3r2Icgo0CElHQmdMy4pn0Up7cADPa9EzwnfzDr8t7?=
 =?us-ascii?Q?dyxH1Wavr2cYWRU4k7wT+CG513lVQKsU7li3hjdDJgNxUxwPHuIxIdNNrkUp?=
 =?us-ascii?Q?tpGKdsXZqD85idAGTk9NjNG01XZMmNz+9jv2IW1qXBbSFwJ0V3/vgbsdW0Xe?=
 =?us-ascii?Q?a/9Cho5jvKixBwX3ddIJHWBPGHDXJf3AYBK7Ozmo62MJukd2ePJetyXBJbJ3?=
 =?us-ascii?Q?7gT3a5zwUp7lcT83e4PwOBxe+qnuRgBWZNEsljcQhTFMspO23m0TV486qPGx?=
 =?us-ascii?Q?MHYf7mm9gEk/3yOUa/SIcH54uKLyIKUvPrzFc0dDZ57L3NyMxP+gpaYy0WID?=
 =?us-ascii?Q?KYAlfBqrl/Bvr6LO4/2gVfg4ShRYvcpT8VyO1vyngOf7IKuL0RkH/4dtCPkI?=
 =?us-ascii?Q?yXUoI62S6hlbmjz7GgTRO+7NC202xyVfNb4ZlsgHhyI9nTHr3TGhdWjEnT2m?=
 =?us-ascii?Q?O4wZ0TReGojKzINGHVAbG8uToKolRZNM+bCzQ7Kftubk+96jeXbKurqQN+1O?=
 =?us-ascii?Q?KpzopMemiMf92+Up1ugBM8sN9S8BQ9pKNk9JgFPOKDBgxb16mJiUwTsfCGId?=
 =?us-ascii?Q?Ti8xGtEEtGf+WYQS+S6TSX0a6XYW26FX+mQlW5GDZLlApg0QDSfOGshQaTtj?=
 =?us-ascii?Q?krT4FAamjvwnFvxsWeO3zeQgM5srFneDQwKR+YuBwJXD4lq4TQBYS8nVs6nI?=
 =?us-ascii?Q?Ky8Ge4NVG0H3puafD61mbN6FqCk+0q4PE97Ql1EoXh3lDBZNT7zx5C5+z68x?=
 =?us-ascii?Q?+nD85gS+ZUhv3CUVvJcT0RBxWL6FvTgvCuVdnLfLlYETpD2OiNPAE6kkEuyR?=
 =?us-ascii?Q?qzUGRpZMWmWR8UVdU8EyQdOy5Uf6MHoWPy+YyHDZjqq+jXbuG0yHqSh+rQia?=
 =?us-ascii?Q?FmdWQbXmRs1C/8mRgtDqVeaQoAsf9NvfwWPGPqXDdTNr87aWBnYXjbGFhgNH?=
 =?us-ascii?Q?JD4jchd03cfoQ5Wyn1Mke/1Sw1fWw5VD/95rteB+idojq5fKInSqG/X5uJCY?=
 =?us-ascii?Q?d2+CPB0mxKuJ6nY3S8uKLu2I=3D?=
X-Microsoft-Antispam-Message-Info: GLdzTj1bf0oDlWrgIynyWu0ZkyfcswOW7zX9p0lLQ1sfMHiU6BZP5Sdivp1+1Ug7Kb6GZu1AaKTXeEgxdEgX/A9LIr3XXWDt//olUAAYfm/l4seHQZe0NG0UYBiqndzGc3yt/ind08/qDt37P6F6WtZRXmFnzHRJp5xvsmwZjjUqWrRgNmn+y4TWup3v9YDz
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:8TuMuQZBXg3kGoVQFk8CKIdboA7dLrEHB11Ukc06/xKHVai01YlDKQn5vQ7g5zOWP6WXYTznP5mA8lSXnrhz3m+BlzpCaJ9Ug6bVfE3rjb9BXfYEPG86VGmTTuWBrUgDGB6Nf7SyGXaRQS/knJvaa7sTYdrKW2356nlb+D+Joapn3IlO9lC7woMbKOZfzddQVWmoP228kVv4wQqAb1j1ZWrQxOmnDuvgbc4XAk0GtIp/9Vw/uNgHV5d9ZH7Hyg3t1Hn2y0vMFegxzm4iORCLltyRrnW9qZ/PLJRNPE/3AKCTIMA4PmVVPv+5le0llFnjQIOthnZvnOE8TYE/HXHUbT3OHZHGz4oJygHIpyAh76hXrRY1FK8kJWB0N1YUyTP8Q2GOEuyLQd9yKgfIMgzvlw2LtVc3eI5wFQXCtD/Ok1qexvViHSz2OCB8S4XHlZkKmwaiYzmQkMtRb1jHnxVO8g==;5:/YXzISRZzzMw2PHye4iHLXWFeaNAfzUFu7qzvN63lzhSVVW2pvPFY3hNoNkss63WsPtWUbk+CXYlLMiOP3ZiK0yxB0DgLO6PXJnbO65PgKDeV+Qzx9rTgJUTroPZhtIK7OB1ez+JzZj0Z0reTp+vXHSOEvoc/kWlAs/oBJypC60=;24:sudSeJp6bB6OsP13DIp3K/L6SvRDSpqZ6AcgibCFYoBF4Kl+Eks2WgtZ2uBTEdtBRZmmpLrR3Hsuq6xgAOTaCFwjcR3aQW+HRzFpClLSVLw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:qDan/cJ/52uys3CfdI1UuTlWuSq9j8AyvCGb0IRGK8XSpjFYwI6+lRGuW0F3eNSW7lj9A5lhIFKVdtWXJxrqRiR7O0Kl031BE4J13sOcsmuuqtTK90V0v1G83ikx6hGVk5iS9meNNbEZ0iNRuwyaOZN4rvASzfV8gqACflBaVqBcUiHRFi0GZ9pXn6ZtpfYFIQsVOj64x78UGCNH3f3TKcNVmxDoYdsNC10AeBNz47Fc8m2wLlzFD7JJT9vKuc5x
X-MS-Office365-Filtering-Correlation-Id: fd02e7a3-a99f-47ba-140b-08d5b9aa8d89
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:10.9349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd02e7a3-a99f-47ba-140b-08d5b9aa8d89
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/algos/i2c-algo-pca.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index e370804ec8bc..883a290f6a4d 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -112,11 +112,8 @@ static int pca_address(struct i2c_algo_pca_data *adap,
 		       struct i2c_msg *msg)
 {
 	int sta = pca_get_con(adap);
-	int addr;
+	int addr = i2c_8bit_addr_from_msg(msg);
 
-	addr = ((0x7f & msg->addr) << 1);
-	if (msg->flags & I2C_M_RD)
-		addr |= 1;
 	DEB2("=== SLAVE ADDRESS %#04x+%c=%#04x\n",
 	     msg->addr, msg->flags & I2C_M_RD ? 'R' : 'W', addr);
 
-- 
2.11.0
