Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeENO5V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:57:21 -0400
Received: from mail-eopbgr20126.outbound.protection.outlook.com ([40.107.2.126]:6853
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754001AbeENOyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:54:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 13/21] i2c: kempld: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:22 +0200
Message-Id: <20180514145330.4857-14-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:fGVFztAA1yx0VdW5Q4ROT8LEtfjZspDpiNUvnFrpKC5q6NHphSdKtfR5TBft7c96Kg+r0pJfDmCpIrM97BE3JJd8OfGUJV91c8b7elHCTBwLw0NpaOA/UjxMYF3iY2vYOrMjB7uCxXya0fyll3/RLPAmjcckycWab4IvlDNoQSADTfRs57OjjqQjThrn2TCl+UG2lJ/yO3eXZOT/Xx5VoXca4DnFezTx64uBtTlHa/rsm/8A/FnF8grPRUJmNfDP;25:QPgYOkepr4WSJzelrdPm2hjP6UPzyUFCVsBqKdt0PTh9puHDUCyseVw+fw8jJMdm3nhw3LRBqJpSPqjYhqToC+aynJTm7YQNGfxyXSaOQ8bG+v0J34U8I9udpTS19ursMf09HGtTv7vxqTD8F/oxqEsAtIraVOnTpCtMOmOxw9/wwvHlbuKcdsnGlg+FslgoMtu/bzh4IichaoQn0K/xUJ/vwN7r5Jcq/wqvqh+KIol4Lnq+T0dmfn2h+Ykcc46QJuv13qXheeFa9xOfojgJjZAW6BFM1LJgeymWtJFh3SsPgZlii9oRmqBFbfFNBzkDQnhAPPhQMcQqxdoyRhKJ/A==;31:i6zuKNqWOdDOaBwZP57zUYxxshk0E0xW2n7OdEYuwkGp+Us1Y/u8fjW4V+Y9zWgTXS3OglFmnwn+w9ay6nmAJqJJU78luH6H+2oGcZxANpB4f9puHT9Bj7XOD+jMq/6MKdOYclS907mo1is6F5Zbvxq4t1mu9kkYDJPMoVPrRAmmNDCnlgmIuSkzvxYFYSDbLR3ylm9dTK8VqvLvgL442kIXtUP3wRE0lSUasH4f7qU=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278222653329F785CFE437F9BC9C0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:PsQ2ZEAIlezYX+xEJ267xh79/K/3pXWeJMaCxvTlAJvyXkMw9bRMnPzRnomKCwIsfo6zPNsMmkTYv2TJR7WfHGAarAkzf4nE8EuRmM4njDTbO7phWxDZ8rt/YSINiYGrDUarh3ISBLNvxt7zcb8JrfZPSZR2j+SFkWKNfpADwm4eCfhzvItRRXNGi4X725LwBQrmuj4lZFOuF734UnaeN62W8lDu1QS8zekfcTL7y4niFDsz+hz1eB6K+4AweJ11mMwlSV7SSxm/JEttQMmo6Q==
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(376002)(39840400004)(346002)(189003)(199004)(48376002)(6116002)(97736004)(68736007)(478600001)(4326008)(5660300001)(1076002)(6666003)(2906002)(53936002)(16586007)(3846002)(66066001)(6916009)(316002)(15760500003)(47776003)(50466002)(54906003)(6486002)(50226002)(186003)(16526019)(476003)(81166006)(25786009)(6512007)(11346002)(446003)(105586002)(7736002)(956004)(106356001)(2616005)(6506007)(36756003)(76176011)(386003)(2351001)(305945005)(486006)(52116002)(51416003)(26005)(8676002)(81156014)(74482002)(86362001)(2361001)(8936002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:RAg4FYzKxdd9eujOvZ9t0nJbLqwFRSImUbpkUMN?=
 =?us-ascii?Q?K6xwG9XFmr+JiW0uJWta2D9cbX4WRTz0V+OXjO6ek0Kxxz8wQF5beSc18wpB?=
 =?us-ascii?Q?W+KYm5EfUy485oj6g6i07rNksPqu9J0uFeg6KLpW0z7W/WG5NjpZrhtqr9f4?=
 =?us-ascii?Q?ZBG0P4ufonx916I3ey0ma501/pDwtQYD9+03mfPP4OpcoK5JA+w6QtRi77iF?=
 =?us-ascii?Q?nb2SIMv8Jlye52erpNK8j6KQO1lqFRnzHcv/xb8BMfg4tTLq7FYItbRsiPBc?=
 =?us-ascii?Q?xJwy4IF+GSbY0udOW8N2s0P7zhApAtqMRRWYQK7AvmsJDrolQz2cNQecjIbb?=
 =?us-ascii?Q?LH3tyVu5J/0f6OX+lO50yLXzKvxP5RcK8cUm9DlZyqngrS/1G/nSrMfsXH4k?=
 =?us-ascii?Q?e88enYHgFLuFj7xW19Dp183rI3Fjm79NExG9sahflzusrV4wR5PKzYGGs93o?=
 =?us-ascii?Q?c3krF4fKNRonu23My2f5iToSe279dgk7tO4KRENwffRw5arFJ+YtCblkS7MO?=
 =?us-ascii?Q?KcIBRrjLGA3FXpywXokXwouMMKPVxaqKZtnw5KwF0/NhaJD+w925lYc4lgxy?=
 =?us-ascii?Q?fdZUJgSiuWfEx1gHHYAAWsTQTkHtwjRIUqkboW4+V+c2RJJ0Oh/RrNpMY+oL?=
 =?us-ascii?Q?sR45u0/mDS7oxmh2u/gphiLe1/toFh4QCWVOvIXGIcFPY/RjSCe3acvq0N88?=
 =?us-ascii?Q?QjujvzBQkfIWPYh4makkQaN+LeIFQFE+eRRUi48OF+fc6Mo245N41zwQP5CP?=
 =?us-ascii?Q?KQOPr6yenAcc89M93ZQtSBMSD3MOO9Fqu1HiY+MdUW2Qhkbhid7wek2BZDwa?=
 =?us-ascii?Q?jNlLc5r3sWHUQC2enhkZuOv4xelIhiHT+P4UxtnlHM5Xce+9icsVsTLEyeaU?=
 =?us-ascii?Q?Tq7cQjLvnRjHBQuJPX3c2Wug2V+QMhSnAq+pP+qJOmU0dXw/AUlB90tDJlQj?=
 =?us-ascii?Q?Ft2I6f0jWZuW/7b9getsl+ueGA2/6Ltmr01Syu4Rx9xga/rQgo3hGhtb/CvK?=
 =?us-ascii?Q?Au95/6ofeGOgnS65yuRDewnW1fgniELHdsHYmIxx9mOn95mDeNi+mSWK/hPg?=
 =?us-ascii?Q?XoF3YfUNVrNDzU3HIVBDagOmaLrcWo5hGFPMIas/+ve1Hi7VXgd00nixFSS0?=
 =?us-ascii?Q?2lTFIsY+IUNbBvzg4zNfUCV0FzSh6Ddx/vmRh25E4kkDICb0CAazOWV2fvFT?=
 =?us-ascii?Q?OWT04um5A3r7L2GoaF+msCLt7c5/ODdhXUE+v5WiIBUViTPhamCPAxHwqk0v?=
 =?us-ascii?Q?p2A87+fnWDGhaiMRlfv8mQuENFZpeIb+varmO2CiUGnDIxHHYwhQVXJcZt/J?=
 =?us-ascii?Q?LBYpqeHzF5vUfPp6pjk7EqX4sj9CHHK6JtTMKQzyyJB3T?=
X-Microsoft-Antispam-Message-Info: rzy5jQI4Y+TTgsOnxgDu/4dSuUdJEujazSBFLpbOUEN3sHaef4/iz5U0S7RoG+CtPwxPcDJwNY1THVzLnG331qAuxgz4oCzavKGUCUZ+MBabpH1Sk8t1theNhl0j0i4bruj4mJT8JHcmPy7x/9rhMZuUnvo6ytYriQkjGFnXdSRq16/GvFw9tHQgDCrru/KT
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:B9NAUGp/bVfquaA7o77Fy8wdwbOjZUd+fCAtjjxY65bakvkdDH15kSBeGvqBVlYjI+kFWLG101BrOi2G5yVdyS5aZPCW2hBtvU9F6aWbnLuEXC41QQ0k9wkfDgZHGGLvC88yv/8ZB30QtgKOha6RT+PVix1j1tr9N4AWFzEtX+qkjQVzo50pRinN1oP1Y0KBGT/96JOjjYfMwoT90dM2Sgb9CURszCT+nksPFhqrka1q9xaY5JhpMvEXfYdoLqT0+bu6cUyWTvYSE5ZoRAPXsuY4MSz+7iNQ7H077tiboaSYUNqSakOltV3XbZZad0TUsWjT2BFD6+31MJMHWCEwVng7yPqChZ8iz4Dp1mf0Ds/Umk26oo6edmMr1G3VcpyyHYbmXhagHb5pc1HsYQL51Cq2OtBB9hx1UxcIm/h0w1E2EcEKAgvV8LU30pklwn6i1eIv5jUGQLiKUaL7QLMBZg==;5:AwGR1y0c8MjsZbswSynYeT4dibjZMNnT81rjgDE2k4N2ewulqGVKS+potfk4lKc5336QEnEnmzi4YJ+zm1jVgceaQNg8LT+gMrZDwgJQVR67mfmD0Gfn7dH39B4yKvzgj5Oi8tJnNtzDkJ0zELi6LDwYIiXNsjt6ll5KQzaUX7U=;24:KXiCAYHMjKG7b5q3PqZE063kHwZlTqX3CnOqO+xo+HVU/v1ezbPfCtZoBzlLnIDCgvr4w6yGKXMVd32b2Q6un+lBnE0BAvI90IlWLjvp/3g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:cwiiUgCZIHajvhC59Go0OWJLPtCWY4cdaaemSkTMKED5hlKoJAoZldmjJrHmTDA1RM4A/qyUnJs36fNkBP5g24SN1eMWncACvpY2lG4Li+uh0ziyIUJlUTV+R6vv24uD0i0rHwVR3Su1Pckd8dPFJlkk6RBnyRurIB4J4p6F3GCaTg4MzT20LBMNyjGtI7Fa6Ul3aMsDRxPf8T3rk3KDU6oWVQ0edOutMdRwffwJ4KzUi0MMq8y6MiR3dXobvuW2
X-MS-Office365-Filtering-Correlation-Id: 061cac5b-c39a-4993-892a-08d5b9aaa099
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 14:54:42.9038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061cac5b-c39a-4993-892a-08d5b9aaa099
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-kempld.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-kempld.c b/drivers/i2c/busses/i2c-kempld.c
index e879190b5d1d..1c874aaa0447 100644
--- a/drivers/i2c/busses/i2c-kempld.c
+++ b/drivers/i2c/busses/i2c-kempld.c
@@ -124,15 +124,14 @@ static int kempld_i2c_process(struct kempld_i2c_data *i2c)
 		/* 10 bit address? */
 		if (i2c->msg->flags & I2C_M_TEN) {
 			addr = 0xf0 | ((i2c->msg->addr >> 7) & 0x6);
+			/* Set read bit if necessary */
+			addr |= (i2c->msg->flags & I2C_M_RD) ? 1 : 0;
 			i2c->state = STATE_ADDR10;
 		} else {
-			addr = (i2c->msg->addr << 1);
+			addr = i2c_8bit_addr_from_msg(i2c->msg);
 			i2c->state = STATE_START;
 		}
 
-		/* Set read bit if necessary */
-		addr |= (i2c->msg->flags & I2C_M_RD) ? 1 : 0;
-
 		kempld_write8(pld, KEMPLD_I2C_DATA, addr);
 		kempld_write8(pld, KEMPLD_I2C_CMD, I2C_CMD_START);
 
-- 
2.11.0
