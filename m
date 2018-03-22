Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeCVDwR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 23:52:17 -0400
Received: from mail-db5eur01on0065.outbound.protection.outlook.com ([104.47.2.65]:49568
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751843AbeCVDwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 23:52:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=xiaofeng.wei@nxp.com;
From: Xiaofeng Wei <xiaofeng.wei@nxp.com>
To: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux@roeck-us.net, hongjun.chen@nxp.com,
        Xiaofeng Wei <xiaofeng.wei@nxp.com>
Subject: [PATCH] watchdog: booke_wdt: Disable the watchdog prior to setting a new timeout value in order to avoid the following situation
Date: Thu, 22 Mar 2018 11:51:46 +0800
Message-Id: <20180322035146.1236-1-xiaofeng.wei@nxp.com>
X-Mailer: git-send-email 2.16.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SG2PR06CA0145.apcprd06.prod.outlook.com
 (2603:1096:1:1f::23) To DB5PR04MB1381.eurprd04.prod.outlook.com
 (2a01:111:e400:58da::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4775cda6-f493-4de9-73c8-08d58fa84aeb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1381;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1381;3:JP0g+knkicNhA/pNpuJqTEa5QkcYBeCJKAJh1eaum32bMFxNmt4bCXa3qIUwC7QPEmo+FHA94Wp/JnQDyMFGIrmzrTc6oxGfVJrC2B8+UweICm2UZWQJWl2gctAv8t1GKdviq19lfjStuDH7WmVXQmAlRn8RIyaro0QsT5XkQX9V+j852EWtRWGJjCDqxgekg4yng7n5gwqhifD5hIR3Ptk9oDjEk6lMvQDXofZq3+D5m06/AfRxqJPbfh4kDgMd;25:DkcVyotaBtXjpIN11yb2WkTTfv2o54NYUcfbH1otkAIV9KZAtugYgi7yJ8pa5mrMrLDFXtFQ1of98WxZXCtoiAhOF6vG3mtIrbmF0TXib1v7Ambs1LCtlc1V4CB9Y/gjv9bLQEMaHuLShsu4/k1T2yawl1ucbz/bG8ksBn3Qyl8wxsN9BB9BLH+AexwWA+ObjI0C3SfDJvzKhtLvPsa9Ed7TP97hC9IPXIDJAFtVw9GpSvfWEfe6rPHzB/cWkdNeX3YSpM6lLu3Y1VrkXvNYeY0cKYgn6flHnrogJzzwScIF0krlKVRZadzEMroe1NzpzdC0OsO3Hc7wmO6XMwg0HQ==;31:P9pQaqd69qobJrr4RSjZDOsxxRA+IvCGgzgzcaZZTPqnYsdmg3Ubn7nMtrSxhpPrPry4hs33H8OACYHFa/Xbg78vZrupcz70TQZGVioTiFdN615HwzmSzObMMCvhkq6Pf9Ef+KkAthxZrqYCJQNMgNFyPh0wu8qYByFcpDuTtnDvNwwGExGUPCtAKLPm+VbxatiWBCvGv2DGXjHuVQcN2Z/egi5jzj2zWqrLvwqU3ac=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1381:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1381;20:PhdK1byyTt04/8QpZL/HqoFQwp8zrZai/09IrSKPSjsFxMDORLiAP5RYWvnzSbpB78i+kn3q8XNyiQdwrIXT2jJNCg8IsF0h1GLKPCYBD7eGOAVXiPha/qqr0duyQr6MQuItn5JpaYawT2M+c2onx1nmNa1XK2kHKaXjFuKUnzO1jJr6TiRg9N35Dxfc0feD2D/8evYlfnmDJUD3swmTfEvL5tNOUYE12PeseFaSZNs3KgGQ1WXFeMSSCN/Xbcu9hRzMDkch1rYx2U9p4BPGpRU6/VjWsoEZNdNDkyxlzApCprJQpmxYu6LP0AQk84waTRHyLgiRkUVgD/7vOCQtynZZiIc6+Vjpm2bYstnL3s/c8TNT4puuSooB8sGvDyG4Qj0bN0yQbKqGyCFNCkpmUA1WfE0TbJkJRgQxCv5xDHh1vLmDOLrTvqXNYb7/Rwy0eJ3qmSs9mySbXBu/S+uPtxvKLm6LU6cYn6v5P1yvRaupFcqSLBUaxfWxumud6xN1;4:rFbagRjJ36MmBjuu6WolHQDEtaCG3UfEPkxEdGifIbzgerX+VPgSkHDQtUaCGLrFe1425l2kXtL6t9pM4uAzvLR0BKxr6L6x4FgmSj/nDKXDwECu2fGo6t3+xwdkgHAICojasgKpwBCpKTzIbaNXi7OrnjzLo0MU2RcL3LoBVrF8eL177Qojzr9rPJzPFEPJftRw3MvzZH44NaLyucigBsLdbkbjl+0BumB3xMMQ+GmWV8Xfq3/p/qDUOGjoWoVOZ5Fx/yFw6EWGXeCC2RaZGqEA+uNxWCM46Gygt7T51XcEwabKlNybFwBkvoXt9sg4
X-Microsoft-Antispam-PRVS: <DB5PR04MB1381F0F3D254633E2C66FDFA93A90@DB5PR04MB1381.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DB5PR04MB1381;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1381;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(39860400002)(346002)(376002)(189003)(199004)(50466002)(48376002)(4326008)(316002)(51416003)(7696005)(52116002)(1076002)(6116002)(3846002)(5660300001)(68736007)(16586007)(105586002)(478600001)(106356001)(305945005)(81156014)(81166006)(86362001)(26005)(97736004)(8676002)(8936002)(386003)(6486002)(7736002)(50226002)(6666003)(36756003)(2906002)(47776003)(1857600001)(25786009)(66066001)(16526019)(53936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1381;H:NXL65279.wbi.nxp.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1381;23:2q6mUluyFNI8v0u3U/aF0C45lp2P5+qeoNasaikGy?=
 =?us-ascii?Q?PMBKGS7V22Y8FptSdfD5h+QCYYc4aPevUSQbUPCazxBbRRt2xQv52R2ukkSL?=
 =?us-ascii?Q?HIuf37lRex9nBelvv40qR+GNGrtFw4t+hCGsayCv/+rcFjPu/bUBjGMZKg76?=
 =?us-ascii?Q?uu8nkSTTO5PmVcE2wlYzCG983x+IvaZkajHcUFPPUdePay6WZ/CIZ+JuCAKh?=
 =?us-ascii?Q?+3PSe4qrIoexo6nwXcqJunY91lCcI9ec/1VY7xfJ0j/M4X7ZcLJDkckT5NS0?=
 =?us-ascii?Q?AmHqvfWFpeT3ETKprzUBnMbGrf5px0qzt5pMTjNm8RiLNT42bpkL54Nw9PGc?=
 =?us-ascii?Q?PxMYYqrqBlew9v3v4smMhrSBCDY9ow3qCVAAJXZJJm+JTxWyC94p7WRA8ssy?=
 =?us-ascii?Q?xKU6d9Cp1srwyZ28LaodAk8QiLCnFNB9B1i1vuzUojT9x9vDwj/jWbkRzldQ?=
 =?us-ascii?Q?DdxbkZA8AaqsxSzCaR91Qv8P1VGQrEUXV+neH9yyTta5fQJKg77hdHsrKTCe?=
 =?us-ascii?Q?qcgeqPlzMG9OXgR3YiqA9T2GyZW45fmXT3d6jYe4bulcedjmeEIPqXJV09Zr?=
 =?us-ascii?Q?2Wk7l7gZkSMkcNrCiSvlt7zGlWJH/8aUg+L5ex9MrS1Y5C8Zyy/syKc3w8co?=
 =?us-ascii?Q?sywfcwuvF3z/BGUZqMz2fZtbVwgOfwlOCZ8gI51sveoUbNadnv57M8DGfU1a?=
 =?us-ascii?Q?CQIa8PkjSNlgOhVJRlFGJh4fAK7Zibc+4BWgO4HJYzJggwLP5XkkMBSNA8bn?=
 =?us-ascii?Q?vuEsXODsvP1L1u6uPhJby6Nrp1PIJV/i5xJdv1RmEa7UUJ3nlismgiIXeDF6?=
 =?us-ascii?Q?pyxae7eAdX3Yec3lG8K1PG9i0UgjlCjXKIFM8qcgBFSfjEOYS7KiCip9NlyI?=
 =?us-ascii?Q?srd2fGVnS7fwCFYxTWEeB/R8EqSJ0XPFL0/A+y9xXQNzpvh/zg/Nb8/Uxnmx?=
 =?us-ascii?Q?4idBkPBYLWUfGN16EgPA9yFtbHwG9juQVCRWT+gGRY1PDn6u+HMxb/8lc3/U?=
 =?us-ascii?Q?tfSJ4Pu6M/UeqoOBNzlZmHWkHlydoYu41Z0vnVR6pXwQ7ox8F6zkWrE3wrfV?=
 =?us-ascii?Q?CBlCQc=3D?=
X-Microsoft-Antispam-Message-Info: lBQX2tXfUShxV37duZvbw9DtcuA78zJUwipCygr62A4fS0MIc18czqu8r1hBXbP3NwRo6JDYCeOKcp2sdt+i+yKhPXWykt0HzFS+3eq2nRTWiDvH6kdV1/j9wFfb/YLtIIVSgp1EcC0EoEZLUdvFiJbSUUV8zDDW5k+/qrtsU3WlaEEhiWe+Cgh1OOxQxOMd
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1381;6:XWo/TZODdLbFxihCOawjx0B/b1tKA0lN4LnztY8V8aFVcsR4rWYaXyTsoom2jS4Ca/r155E5AIbFT9nkbj+TNdoF3PXh7cX9n5mPGYMZ1ghkXu7d/w3YRI/5BTUa/ojj2zCL68uL4t7sJBuD5MDe/EfvFevYCIK7hHu86wsHlcKrecpv/IFLCaPFQFew7H5/Ey0qbps4bNlDv70X3RPyXMhrqfLIUxH5M7lx3mk4D3kpMwqA0a0zkx9y2so7py2iBWGLmjSw4wlfbJmgtMj6hOYI1FQR52yH0BIUMPEueYRG4NxwKpRWD8tDU2d6pzPeS1W55nhdmOHla/swlBQOE4JDLe0++cv7UAadK0Tg1W8=;5:h4Bn0Uwo0/trawKnAFvkHrajq6WY/yOOfM30CvRhiobjhzvrTiNGMleTQRPb9J+3XceML+nmN4Abg9zT0G0WT+O8jRIs931WeDZLDU7CtEbWMLgrAPGOt+woHSJMJOMD3BmlpkYRLqdfKsa4iVRi+ofHu+kU/XxzNXWDOtkTbrc=;24:umncVakEXT7TDTdidJXLC6wEhEldstXmEL2i8l8KoAhpzmq8++lRcqVJo9e7voM8iwjqtGvsiPYcemHs3Yfgv73bYxteg6788ECf/XgXs04=;7:QnwKK/CdHLEXSow1ganq2qpbvZwTW4o0qwcgIFwyL3bRB6s/5t91lOdFkwe2d7sXbak3HNK5K59ThUGGFPKk/ObKkcTsqyau2jOe1fnRTClu5TbAI8SXs8f7kA7fuAgXaz2gfHzvUXgywi3YM6K8Xgv17iq+tv+oS4OdBIb7N+qp8aHfOA2ZEQpkJyWZvQgd9Zk8Pla0z87FKmgh/NBGOewWMUEwr+LypFZ4Jc4bTsF8ff9zU2LmSX2rGe+9cqtk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 03:52:09.4514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4775cda6-f493-4de9-73c8-08d58fa84aeb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1381
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A watchdog timer exception also occurs if the selected time base bit transitions from 0 to 1 due
to an mtspr that writes a 1 to the bit when its previous value was 0.

Signed-off-by: Xiaofeng Wei <xiaofeng.wei@nxp.com>
---
 drivers/watchdog/booke_wdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 3ad1e44..70e742c 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -186,9 +186,15 @@ static int booke_wdt_stop(struct watchdog_device *wdog)
 static int booke_wdt_set_timeout(struct watchdog_device *wdt_dev,
 				 unsigned int timeout)
 {
+	if (watchdog_active(wdt_dev))
+		on_each_cpu(__booke_wdt_disable, NULL, 0);
+
 	wdt_dev->timeout = timeout;
 	booke_wdt_set(wdt_dev);
 
+	if (watchdog_active(wdt_dev))
+		on_each_cpu(__booke_wdt_enable, wdt_dev, 0);
+
 	return 0;
 }
 
-- 
2.9.3
