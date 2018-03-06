Return-Path: <ruxandra.radulescu@nxp.com>
X-Google-Smtp-Source: AG47ELsgN9M2yUC97P/aPNkKR8Ve3nCTIQC7N1nDVeOKryCU74kN2xNjrofyOUT4hE/BLXL7xVKe
ARC-Seal: i=1; a=rsa-sha256; t=1520358255; cv=none;
        d=google.com; s=arc-20160816;
        b=InKRklVv6pxHgeu6xOMYvYjo127tGzln/ZvubQJWKWNdg36W9kTL/ux38Dn4KFthbo
         P1BOAAst34VECsruarOa2xLoLA7qaDhxtyXDCkoonyccT1elhzqeIfAlS5rsaYdTfCwr
         tt1zrhxGcMX8NTb+0+AuhnGJBNpsPKAAmeO4o0RanGwAJ4NDqGp43EO7ZMb+vkN5hJDS
         n/YKLpGERCZGiha/v9sa+8oSRfrsd/CculzRymT64nhsacMw4EQWHyR9aKcJoqH45B2o
         iPS9WtJ9qu+82hn66ZEIFyjWv+KanHdvP5QcDYTfeWb3rn2C9JorpssEL5tu0KqzhrJ9
         XNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=D04FefTBlmETJGxRb/Mm1DmRye7F0Dr8GjfmCEDGFFU=;
        b=U5xGqmd7lEylocJRNFGpZVf7s6XNmA5OBT7SYD4R5qT1FkX8R/HUYeDCpsAlZ46myH
         v63ilNTztdZr5WceRsCGLALiPTbcdzw19dGokpr7M/hqZiq6ibeCNIWWEao+7KwJvqwv
         H70MjwqfvFzxR1Xr7tzL8YpOh30VnFE0+SWbmmsmOG9fmGl/izKUwYZ6UyoXvAMsIxL4
         qeiyuhgP5R76/yCUiMFZdik5OD0wIYv4grvb0Fw3HnqALzJ29kEGk2QzGvkcbtGkEhKO
         XGSUuGulKfTpzUbA2M0Ej8c75jgnwqUcWy9whxVQI9VDcL3wP+k3u6Rgu1HB5mLQ1azd
         QmIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=D+UshMaW;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.83 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=D+UshMaW;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.83 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	roy.pledge@nxp.com,
	laurentiu.tudor@nxp.com
Subject: [PATCH 4/5] staging: fsl-mc/dpio: Fix incorrect masking
Date: Tue,  6 Mar 2018 11:43:47 -0600
Message-Id: <20180306174348.26095-5-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
References: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:404:8e::23) To HE1PR0402MB2700.eurprd04.prod.outlook.com
 (2603:10a6:3:e0::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69849078-0b5b-4380-f2fb-08d58389dfa1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB2700;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;3:GsYIlnkBcmdJ1pNd5fUPzTmWhwn21VwnIxxwY90tlANh0yNvB9wurib4h7jm+UieqCrGQclnETQqXZZreUt5aCftOLa/z/FbPECbcGiNWjrhsVfwpVnZMbx/yEgHOust0PmKVbXSaG+0felwZP+9KlGPaFnLgneK3KKQhmSQp5B1voojZXUfuMvqOP6FCbZwEsg9bOI7oZRmXVuhSVDZqrtP9nHDKLvgjtID4TpjyvkE18wYe1dvFMewxOMM1B6h;25:WupeFsQ1+v6MAxFOYjqdLDP3+MvTvfPQLUrPY3Z4X8hwPPNuiA3DSXAJx6J7M5BK0o++cAAIBQE7PXe/IIbA5Oyl+0o/knXyy2l9uu+Oi/eGJZm85fUUKHA5Bg5LBLffRvWYSKRrpjAM9MXw9v6NIwMXG7waKKv+aSCSikH6H6BOD0Q/bWLVNow8Voss+jucfrKEg1F4+/SLJzBZ3Y2BLqQYPCQ/kZlDwk0+mE2A+qKOQjCt0qUKctKNCLd1mbO3HQB5v0PU0csG9gRqX/OBdoU9NxlJcQFfPPQj+jdMwTAVVTqSy60m/WRrtLIv/BkTAG1O6sYliB0Ghg4CHYiOyw==;31:YlsmBqziRjbzaP1DJVUkreF+MycK/TLQR3oRcJwOWsqdKg7ynHvSa6SBPc3NxiTFO6m17WBDEeoket75BY2PoIC1Sp31P8H6OTv4U0lGbainZ63es3WdkkYaF84wv731RBEPqJY2Sk+N+Sty88/5HTIEiT1AX9w6+lGTnD4tDH48D+b1JHEhbz5J7d+XRgd7rCNDYf74Bg4qQBrrlYuo0IpjD0ZOdFNGYpHjr6MIXEw=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2700:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;20:/YjTT9I+13KuLDDf9FjUfUN7UYf/glrtXCJ8baYEYXWznwdgeXDjTkTRGsRputdSyk6sYpljf9fO0Pb9YuaEYTK1J1NEg66cbo/jdkas8ecDjFv7etZTZ0LO+5QQSPPyeocynIEO6SN6TM4fZV8Vz4VS1E2tPEL/59n72NFUxIF91DBbgDnla+BhUEuvisHCHQBPvUu8OAVIUPqHP04wwlb3fMGtECwSEJ6Mg4bTaHHUD+ewB5hw+2/EalFpE/yb52yB1cZ2y2EJW6F3iB1fn3LE0eFo2HC6sMfCNnBRVtfR4aoML7nkGsueVE+vaR6UKS9HUoh5m1hELDSF2Cpi3je+nfwk75x3Ykto2RxKAjP4mWwQ7BAnbbjJsG/PHPmPDMFVOVzDibD1Z1AHHa6SZ6vr8nhIBpXBmAYWZQa9qrB8QTxFA2fOEAMlyN81Cy80FbjY0YHW4s/1QVUnrzNq5mrFtoEL6uTaMNykOwBaQZ6TTYjOzhoqfXZKD8nTQ1Y/;4:V9yr/8uOPb3uG49RcpdGoUs8MxkYj3TODenTmMfXer0+oLiT7j6TBWcWmNplymlU9EW38q7d1F6qlPJ+20ewP/GCdl44oapSzeHX22UWIOAXCskQnEdfZSrlqmO/UNjubMMOb4WntISXCCyARp5cv5a3y2hcw+IuBJEWiY4OBSG+CWjcbBKdnMDg4zewURrx4D8B7YcJweKfLfObgBtoMjkGQP8div+Vng5fLY1gz2nNXYvxA+j1mqhSq6dh0aDtH1qKXVGlV5fdU1zzVHHgYiyf8RZfqWaPUM7yKTS/xgZ0H8tSJ1dFYkj0+VZc4XZM
X-Microsoft-Antispam-PRVS: <HE1PR0402MB270015E094765F2398F3B51F94D90@HE1PR0402MB2700.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0402MB2700;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB2700;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(189003)(199004)(6916009)(106356001)(3846002)(48376002)(68736007)(53936002)(6512007)(47776003)(2361001)(66066001)(7736002)(97736004)(51416003)(6116002)(2351001)(52116002)(8936002)(478600001)(76176011)(105586002)(2950100002)(316002)(26005)(8676002)(81156014)(5660300001)(50226002)(2906002)(4326008)(6666003)(50466002)(81166006)(25786009)(6486002)(16526019)(16586007)(6506007)(1076002)(305945005)(186003)(86362001)(36756003)(59450400001)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB2700;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0402MB2700;23:GF5nSv4R+Kb++bD3PSfymYoE/tWjGtJOiPu/0ta?=
 =?us-ascii?Q?pAMtJ6jR4aT2rZRNdGs/a9PZl71bD1s6lO4tCUpfCgGBYWjet+talql/igZt?=
 =?us-ascii?Q?FOmSVVsxHNm0GcR0JfXjJR7LmlZbRXIZdhr2tmZROKbw8M66PVjz5W2pqFso?=
 =?us-ascii?Q?Vhd16OIBi8FgmzKeiZa7rxIZLE1errFDDUIEXalD/9KxHBObVq+AqMrFQi2w?=
 =?us-ascii?Q?sTpsJkGMB0zkZgVhSZLAAaBHt1dRlNebQJq1hvYDMBzSCh0eoAYMNx329eHm?=
 =?us-ascii?Q?KXZOH8NYx2AMMRmzJO8axtr0ywaQollzJNCRFal/wL6ai8JzVoGIMAxaqjz0?=
 =?us-ascii?Q?pmc0yOVUrqL2YxrMGmDb/KPye0C9GN2QFs895U3VixhmtIvOPAxfI0h75WIG?=
 =?us-ascii?Q?Wui1ibkOtz4YuSxXqOuzG8hIxi91Ei3ozj5i/iHffmBgczs0EGFiDeNGH6r3?=
 =?us-ascii?Q?LrgAA2sgTgAJ23ERkqzw+ATJWA2YIVDa9DpIQdKy2Yo/y0ptWDPryU8h0FQe?=
 =?us-ascii?Q?s4OiYilFjPMdp5yR5ulrbzbl3wnUCHEOr/zMc9u/Jq72xdULRDmT7NoC6247?=
 =?us-ascii?Q?Wa9/QOpr1AQ8765CviG501ZdSsrkO5FucCRy9JQNYc0fIufzN1ZEBvy1Y1ii?=
 =?us-ascii?Q?JzS83myFtShjrjXm7M29Y8MvMPYT4SpEAZwEPwTwl/9o7lfj24pTogkgFw6d?=
 =?us-ascii?Q?e+6kIaKVS6RHJHy306O1slO0UJk0a98D4wGIflk5CB6SB8a2s8xtCzPlDXm0?=
 =?us-ascii?Q?2hV2lKkWVa4XCTJJDX8wxQB+HXXntNcY/oIC703zfv+7Or9+lCJw+s+tvtLC?=
 =?us-ascii?Q?IgwMXmvRiyAsJsiTUeB7BMCciS9UFk3I69h0mpYXvyzAEEn4bIOMPMm0ZMK7?=
 =?us-ascii?Q?PPE3/rBCWpaOutUwlI1ENGzANbejf3rDr+RDns8Ptpatv6lsFjVENoAm43Ep?=
 =?us-ascii?Q?760kEucWLwM7NOoc/g2mur6JsQMmXQb5kJSId6iulUs5dLMmwIYxLYZH6Lw7?=
 =?us-ascii?Q?1048pcoq/HevCh0wHX8pc5yccxlIG3nu9/pRYBoFOp4v8WkCXxO4Imf5F2bW?=
 =?us-ascii?Q?D5Dt7wh2ldqiqXxmaY3it9A6eWu0ql+9pmOjRebEOjRKEUgb2OIs/44JrA2D?=
 =?us-ascii?Q?jO1octUYLFY3KafHML670+Esm/gB92nyKnBk7KkCrl2y/tpQZmjt2TSx2DbV?=
 =?us-ascii?Q?2mn5ec9gHMkqs++8=3D?=
X-Microsoft-Antispam-Message-Info: Os2yuf72dG71Ffz8dAZwN+AVSiKy9QdOi3O0w7TGvEjiDoUh81k00zCVkryD/QGCXBjFUuwxZcNCISC14P5zZJWfmmgRf65kbAOhP8yUoQNEjELeZgkkjPyfIBFCKbaI4ZGZR9UBGYpf/AZ6wuFxbO5vLvFK21otA855TmFhtNeriqvpFbkPSYY/GPYC7ykF
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;6:NHWmPw+ef1G78IzLZ0drCNpuV/VjSFlzbD8PVSRWkZo2qETjOgO2V9f+cx04D1dgmg6lCl5Vt05Cro83qb6Lapu61pdKHirVQdA771iTnXRfCIg9TorrunXwVWDPFm0hg5BUHsOpmbNY5CZrlSU+S+c22W9mAzCYn02yyCD5qgKnNhNBk1H/0Cxl+T/AgL0DcDXhEkEPkGVkVY5fMdPhZLIE5NUYdq7Avg3CfkAEGJTnImNMhfv1s7hFgSZC00FbdHQGtqbN/Z19zGkfiJDMaXr1xbwCeAr/PHyj5gzoU6v+kndCGSUliyKX/GPSNGtu2fqVTIBziapkri6YJUAjFHojqIfJ4YkuW4tVmfpL1rk=;5:2vpVy6Pxe0CX1syqDrRfVZUX1TM5BRtA2WhzjggW0zzriIfqmfvCwk+CZW1uuqEYupAOsWagpi6UgIe1dC8KTodrqEkB5UN976NKlClo5e7HAsY48d/u4nx8nfeRys+pxrEjiUy1XhupO0hQoIiDJItxtXUOACuVXHhMJzryvzQ=;24:j2hiwi8Od+8QSZg+pVe5BCtWxe30/96VRHFOZbUE02uGr+lorXevKuy6zTtfk9Ck6EJNUm1Gtg/TYvooi1p6WXooBitjf1VsCcZgmo+tBiE=;7:CFjx5KIiSMcsbnTrb3oY6Y0yhl61KkJ5iCzBXLObYtH8hJD+4aoWZxV+0yPWN4Ox0QeX62ff5W0/Jt7RY/0US3dnlJPtGlcs2cNP1VgJGv15NE9x0ldZTKFZVDjj84VzHVEBrdMAhLR+GoM6E5G9zIyPZojKBT49b8Hj2yxQnGZWIMjlStRjv081b5/s+ZwmT6QIFQ54OaWaYQttHUH1QcY0j9NXwsEFDBbV5bQmYNHQI/F0YO5D3zVsw1PQx7b2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 17:44:11.4577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69849078-0b5b-4380-f2fb-08d58389dfa1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594211178467494863?=
X-GMAIL-MSGID: =?utf-8?q?1594211178467494863?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In qbman_swp_alt_fq_state(), we need to mask the fqid value
before converting it to little endian, otherwise we write a
wrong value to hardware when running in big endian mode.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
index 377f4d9..7e55b56 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
@@ -927,7 +927,7 @@ int qbman_swp_alt_fq_state(struct qbman_swp *s, u32 fqid,
 	if (!p)
 		return -EBUSY;
 
-	p->fqid = cpu_to_le32(fqid) & ALT_FQ_FQID_MASK;
+	p->fqid = cpu_to_le32(fqid & ALT_FQ_FQID_MASK);
 
 	/* Complete the management command */
 	r = qbman_swp_mc_complete(s, p, alt_fq_verb);
-- 
2.7.4
