Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE726C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD04208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="rMKby1MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD04208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbeG0RTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:19:25 -0400
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:37952
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731160AbeG0RTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErwK0wRDDpvoPTuAJ8vq1HAeH7ySlxSVSSO48YV/ZmQ=;
 b=rMKby1MFSWPOjxc4AhwclC4+MI8vzqoA1vtHg2AbwZdS6J5EHxrB2b0xh+K52J8TvQyw05nQdnfZsG6nyCbqwSygaU3nEXjORbGaN3HrR1aIADLfvxEeD7z4g01yzlj+0u50Qn+PviUtBeha/Qm9bmpUMAxM0gLN0v1gd75yP8E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 DB7PR05MB4459.eurprd05.prod.outlook.com (2603:10a6:5:1b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Fri, 27 Jul 2018 15:54:09 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fj546-00040b-Dw; Fri, 27 Jul 2018 09:54:02 -0600
Date:   Fri, 27 Jul 2018 09:54:02 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     linux-rdma@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma] IB/cache: Restore compatibility for ib_query_gid
Message-ID: <20180727155402.GA15253@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::23) To DB7PR05MB4459.eurprd05.prod.outlook.com
 (2603:10a6:5:1b::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25ce7a65-e83e-49a4-3c5e-08d5f3d9310e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4459;3:RN9e48TZGb6AKKyRz/iX87+xYyHebU0TV4GswDw9bnxWh09xOrT74TgfTiX2jqdSpN1NAqqnpTeXf9MYIuN0P8PlG5XDRJ2hQqSl9dYn1XaWp7zQWtR3Ifs5HpK0n4XT4jLq+FLcnEBLl5K5eC8knUT9k6LW/A1mAkFw0sQpdwwh8lIPmRsIacscYlUjKaGpTFinerUOG9TtuIKmWU+koFO+vPWniW2CvaU2H7obGhpSDNOTF0nkPhxBvRdam1fV;25:thZlWaTNq3w4F9WR1SA7Cx+j5GkW8djVcYuuoAjpN2EXsWkRULu/tzgzhOcdbqP/3qvbRhgiPwMoZ4XzRRPsHzdwwGahf7FcaJ1KHZeowzj0yg+qpX2u8CYxPfdcvpjLF8Rr2gMiBrtSrtdMdsMQYqTWjhl+AOyrF0mx7QP9p1HZV2H1s3I5wf+L3ZMw0gVTi6UPK7o/+qf4r/eemGwnULAoJxK+EXNaUf77gaeRnOzVDO4Tqwoe7g1rHEhEWOnGNiWpE+I4WilmgOGV7pFqlgtkdaJczQOHk0MfizFO/qMP7Y4FA5ohBaRqyDXakygzY7qdy1YhkZ4UNsfFEm2JBg==;31:bbjZYk1RuNAwHtxe43nB3gAxsatWcghqQA2ksqH9Ipf2bBJAgHEsV+v+gZODg4hIxw2wYjYl0iViVozcd9lC0mgbChNjrbtAOIJGOxmImyJ3EdRIp8DV/BzSHzGITElbiTNVobrXtFderzN6Z/gXgRj9Jotv0V3S25ObwuL1wg24SeSRERn3WbPbETxfWJ7D48DydQWItfpyj59oqFW+OapVyTcc7aflIAZuelObHC8=
X-MS-TrafficTypeDiagnostic: DB7PR05MB4459:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4459;20:buQal6pa+RIAUOEOsCUBsJrO34yumWaSNWgHneCrtScUirrm9OlykvpD52R4nlYb/vzhj6l0o4AiSu3gplkcHrlj1X5W4/uM9iEN8QWMZpTgAZBfJb3DDjdIuFYRp1Wgm7Te5l6fdkxaBWFufw5wilJG9rOFibubzBWw5SNOk+lyEV45fcqABes1uT6RfWfj+W/akjJjuaBe0Oax6P8J4FbsNqiO3ZnZgHoXlar4VBzONPyTtQNREjST8hqG3gm4jI0V2D4shQrT43WqhFVF/p0jJZP50DGXiMAW/4/cSjOez5HPa8WDJECARri/N5ZwsfrklAzNAF+XUUBzO0POeTT9ffl6fJdwed3eWTR0Fhh79XkccEJ4Of+Ww5Yvus0TVDB4BvCWqZi8cXynsIxtCvqpslmnkePiaO41rWj6IiAsw7tayDJg+V52Pz/xW4JGD3i9ICsx9Zy5m7dBombyjN5Xoi+0BgYV9O5P29KpMEDmo0tnuJQwE6Vjf7W8t0Jd;4:Zdp39A2JVqIWOa9Zr3Csk1qSXcZkl29tIxYfYTVTznGohBF1u8ir5661NaTORTpSWVdhftZpi/9A79NgQCa4xPRQLV5MOW9jc8gyUMi4vtpnOymqwPO6O/ungACOyzuZJQDYXlmJHCg/Z0CnTnHNGdNa431OElpf/k2lQA2avaN/9G6bXG+KA+Xc6gTzbbI7INiqGF16Xc6lIfvR0vOkpl8aKC4XOFBCOGQBZxMM5IXzsVHcDoXHqHpQZUB1OfPWaT2y8AxGhDzjozP5gZuR1A5sv2a2YzRdNRXqx/qf0NTvNl4P6eupq8i684ET/C2I
X-Microsoft-Antispam-PRVS: <DB7PR05MB4459318DE4250B5AC77F41C1CF2A0@DB7PR05MB4459.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB7PR05MB4459;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4459;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(486006)(478600001)(2906002)(46656002)(66066001)(33896004)(14444005)(53936002)(47776003)(83796002)(106356001)(9786002)(58126008)(1076002)(54906003)(105586002)(966005)(68736007)(4326008)(6116002)(9746002)(23726003)(86362001)(26005)(81166006)(316002)(476003)(3846002)(57986006)(305945005)(186003)(69596002)(5660300001)(50466002)(52116002)(16586007)(6306002)(122856001)(8676002)(9686003)(81156014)(7736002)(8936002)(6916009)(36756003)(33656002)(97736004)(386003)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4459;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR05MB4459;23:m3MJpFqnuGt1ItVQd1TKJNrzkWAPrsHvsqp5yij7+?=
 =?us-ascii?Q?SoG3D/9hHA6iTQ4nfwpJk10MhfkNKxuzlEr/9NXdZufNOhWH2irbpDJWuvNc?=
 =?us-ascii?Q?7UpRPVIZfoRQOHccPkz+Eryauwzp+rpPf+mQmHEJSgru+6v7/FvZDiZ7z3kD?=
 =?us-ascii?Q?Cq+o/12x7kuOup/PXZtsJ5erG1W701msEwTnwffaM2Jfw+5oYcdqHrM8lu45?=
 =?us-ascii?Q?iT1rnsQFnSnQe4sf43SvHUucyVYtv5WR3EQr4lb9EkfX4CsUmfhyInmhkLEd?=
 =?us-ascii?Q?T1va37GZQBZgE6FAQBEKOhgo/q0lO55lPzvsPsg4zfWKeoZzhjD04tLt+PZG?=
 =?us-ascii?Q?7rDL7Lc6JrVA+5gl7MD0WEGmZtEbkruSqLGPfj944XM+RgWonlRcfcrkhspX?=
 =?us-ascii?Q?70fQ1hOYe5DwfjGBRl7UO1oS+Kf/Dd6UqE2032G7tcq3RLzeg1S27J+2aCS/?=
 =?us-ascii?Q?xP9jr8wC8rp+xsD6LBeWo/qE/yxREYjFN5VsiqypIs4fWAniy2XLWv4Ston2?=
 =?us-ascii?Q?Bojzy7tH5bBRUo8AiEJm9t5PYi1IZBlPT3cOyt7SmsozwQiAastf9HVy4+im?=
 =?us-ascii?Q?1F/FgRtN06FpoKq8Vd5ExuSWkKsq+8RVOF1LPXzJQHEuoG0bT5GNjnA41TYY?=
 =?us-ascii?Q?cNUFViFK7qFxktz8jlXlOMY2k2XYvhmnbx8YrMOktb7+7DQV7YhxzSa9EM2F?=
 =?us-ascii?Q?91P4qNleonCgNY3ilDB+hdZRj4FsWLxL8aLh94JFwZm3BVR+DdmOk0HFLqzr?=
 =?us-ascii?Q?lbz9kgw+kCCesZkbZZmggwdaAqHKjCLvEDLhC2eX8MPj4eUGkn2YJAlB5mIF?=
 =?us-ascii?Q?7pV6cxEK81a+J5hgV3EKn1vig8p3GsMxOz2oQgETKG2BdduZtKTnkqdxny5S?=
 =?us-ascii?Q?069EUvlQOmm0GHI0wvxW9762KVODXtTw1scp+YyKntGcXOj47ShNJuB4eAhE?=
 =?us-ascii?Q?P3Gy6LeZaas3B9PbUxo/r7XDMxfITllyyKj+FQFU/vU+0U9x+6s97jshIlHm?=
 =?us-ascii?Q?9xbebU/1TjSK4XC87ngcM6AE/V/ups7ku/PDs4siSjY5SBjVkW/Fsuhw+WNY?=
 =?us-ascii?Q?YNIbQw74ewqvzOA2jzGhkG+iyHkXVFTJqyA+Y/0jZaKJuAtu5OliTx0gIkbf?=
 =?us-ascii?Q?9pUiBXlNuVyBxpT/XXbCqsCTnI5cSudhhSl2CZX0GrP5k3iKnET+bUoQEhGJ?=
 =?us-ascii?Q?DsrP+8G7pxLWnS8TEGgzzeQxmW+VBTfi3OlSPii7Rg7EgyJ7wZZxx1ZWjwll?=
 =?us-ascii?Q?pGRmv2pw6NRpHRwdVn8WYV1thkpsZquQNP77NxnS42zolzPwu6XtV/eSjki4?=
 =?us-ascii?Q?mcqb0q8V7UNv3uKjQ8BSfc=3D?=
X-Microsoft-Antispam-Message-Info: qTCiEO67JHebFv3dtTMWoWppuBdg64m/UbiVMV4F3HFJKx6kssthL2f9b9JRe8jJvGm5vtwLmtuR7Garrf+/flEnaKuMX4YP30/7ElZadyZKnOFI32GP8le0csfRxSYZ7uetQZ6jwmKdx6gOtvxbNSYiHV/xkj/apGODk6Vjr/NCsqFEpSfnV7XfKtFL/DopZmUPdHDQUnqTteGcWF0WauPHnJXeqVP/DkN7IoNgTJCi4JYJU43fUlH0WdVaoPXdWgoO0gAkk5qWGt2pqnfbrIRX2GX+VcJxDsvnrIJZbVzO8TACFrCu7HRi434DJ7sRAmhJViaWOCqZfnWswyrm8WRQrxIE+b7WFQpw6QYt2NY=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4459;6:gsqoEhSm1pBf7qiTbZKQWQzChPnLGcGWv/d8muAQ6N7xCQDHjxfTetwjGs8aKPYDyjY29rYZ05/MKoO5clhlIOdTPabYt0NgFO245lLCPdwPXzKBNhTvfvCdAGABsDehpayX6b/Uff7WGSoAvOKl7h/1iy2Zs+B4XJaA9NYdZLm8OEFCANyfZUcG+iDQIGBr4lCeJsCkuGaLrMJAivAbtVPZChfS7OlyiuXyGUSKsUW3Jkaya/iVV+kv6tlu5vwK4skNAp2rsEhJWP+8N4Xv4dtO6TE/SBWvJC1d02sBaYzzuKkA4zhc3YzQp2wV1/CnhvIPUw27jga6w2QdJNTmS+Z2pnwABlpKnfUenAZTmfM5ciY8XDglgP3cImqNXLANr3+f6RQcHnXnLWvBsQ7Ih0VdBLJM8Cy6CP4HZvooVNKswev8PS3XLOeFMLZla0KidscoQcfjvoaWQVBwVd7JJg==;5:qxzwrK3X7n2Sd0ctJP17kp0B5lyGmWw9KQdAu6cJMAnVBMuJSQ2l2PfEAm14FYIdCI3BMtJgd6n36xIaKeXGeGwd0arO9f43PgpXibe1Zbq4jID4UjCakj0dYpSg4tvk0Z3YQgCDg8TsDlluVPn2Uituout6ytNGoS6WwAygXb8=;7:8WMJjq+ApRZEAV2zqHk9hatCLGQ9PFKCU5ITJ+KzrJQYqOG7RST8mS7Idz3t2D+0w4x7mHE+ouHUqDxWzHKnPUcaHBWNzFu7yY0667aOIcp4DAaz6ohm+8qIZ26wqOpcNTglDaq5wy18RNJ+xP5vJCfBMOq2enDOFOM7ThaHUNted3a9Dc5o2l89EEzqThH4knq1LfdvGlTV4AvU/7H/N26skqgwDsFZxcP6G/18lW1tFHupoPD3ivpF4QzB+rh3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 15:54:09.7711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ce7a65-e83e-49a4-3c5e-08d5f3d9310e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code changes in smc have become so complicated this cycle that the RDMA
patches to remove ib_query_gid in smc create too complex merge conflicts.
Allow those conflicts to be resolved by using the net/smc hunks by
providing a compatibility wrapper. During the second phase of the merge
window this wrapper will be deleted and smc updated to use the new API.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/rdma/ib_cache.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

The resolution Stephen had to make is too complicated, I think we
should go this way instead. Parav can send a patch to DaveM during the
2nd half of the merge window to safely update SMC and delete this
wrapper.

Parav, can you check this?

Ursula, this is only for SMC, are you able to test SMC with it? You
will need to apply it to the RDMA tree here:

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=for-next

Thanks,
Jason

diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 1108d422027696..c7e9b42b96e5b8 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -132,4 +132,28 @@ const struct ib_gid_attr *rdma_get_gid_attr(struct ib_device *device,
 					    u8 port_num, int index);
 void rdma_put_gid_attr(const struct ib_gid_attr *attr);
 void rdma_hold_gid_attr(const struct ib_gid_attr *attr);
+
+/*
+ * This is to be removed. It only exists to make merging rdma and smc simpler.
+ */
+static inline __deprecated int ib_query_gid(struct ib_device *device,
+					    u8 port_num, int index,
+					    union ib_gid *gid,
+					    struct ib_gid_attr *attr_out)
+{
+	const struct ib_gid_attr *attr;
+
+	attr = rdma_get_gid_attr(device,port_num,index);
+	if (IS_ERR(attr))
+		return PTR_ERR(attr);
+
+	if (attr->ndev)
+		dev_hold(attr->ndev);
+	*attr_out = *attr;
+
+	rdma_put_gid_attr(attr);
+
+	return 0;
+}
+
 #endif /* _IB_CACHE_H */
-- 
2.18.0

