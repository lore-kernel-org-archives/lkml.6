Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1283CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40FD2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="JoBh8tMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfBTQql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:46:41 -0500
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:58708 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfBTQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:46:40 -0500
Received: from pps.filterd (m0098778.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KGkYke016667;
        Wed, 20 Feb 2019 10:46:35 -0600
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2054.outbound.protection.outlook.com [104.47.37.54])
        by mx0b-00010702.pphosted.com with ESMTP id 2qrn4abbbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 10:46:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cA1OAbAJw8Zyxxw2wL8E3IltOmh47uV2WJUg6XMpdbk=;
 b=JoBh8tMxfKKk+7D1R/OqKAkRixuRPzTu6EAZVKvNCtm73yHAFxtP0W99BOK0LiKBh1S0OtlyJodKXY7ObSp74kszYk4QGwO5Sb4KOawlU+PUMo51dOKvXHop/KxJb0eT+8iPC0o6MbcgVe0l0OPX0+AMF2M1ny/JdVOplRBNkys=
Received: from BN6PR04MB0963.namprd04.prod.outlook.com (10.174.233.163) by
 BN6PR04MB0404.namprd04.prod.outlook.com (10.173.198.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 16:46:31 +0000
Received: from BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c98f:5fe:e801:6c2f]) by BN6PR04MB0963.namprd04.prod.outlook.com
 ([fe80::c98f:5fe:e801:6c2f%7]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 16:46:31 +0000
From:   Julia Cartwright <julia@ni.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [PATCH] iommu/dmar: fix buffer overflow during PCI bus notification
Thread-Topic: [PATCH] iommu/dmar: fix buffer overflow during PCI bus
 notification
Thread-Index: AQHUyTvVSa/02Z1JH0OVA6u/ktCK3A==
Date:   Wed, 20 Feb 2019 16:46:31 +0000
Message-ID: <20190220164630.11087-1-julia@ni.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) To BN6PR04MB0963.namprd04.prod.outlook.com
 (2603:10b6:405:43::35)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [130.164.62.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bde5c803-64c6-4e57-99f1-08d69752f786
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB0404;
x-ms-traffictypediagnostic: BN6PR04MB0404:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;BN6PR04MB0404;23:mhhZ7kf3IDlXgHiVolQcYrOZ1mZb9tYxvn23QPK?=
 =?iso-8859-1?Q?0GINiuMkzqEUN9+J2yoKT+vKSIzwv+ZT5hnO/QzwJVEIiIP3y+sbY4FviY?=
 =?iso-8859-1?Q?Rtw/4Pk+id/oA1aqZkFkINihbaTDW+rwksJRfeBQfeJE5kYCkcahBTbus2?=
 =?iso-8859-1?Q?wHVQG+IV4vj2BQgrwJt06ui799CdnVAOxLk4cpdM44nyEDnhf3DkWdccl5?=
 =?iso-8859-1?Q?fkOA+Qq1/JBSXcAceLiQvVX71GpTt2B2BNqMCOmKV1FPWMVFoOuuAwfaMT?=
 =?iso-8859-1?Q?7K9aoeYKNTbKjjyV92ugYa1men4ucn6K/201BILvPKrrDbjHxgvr3wzL/8?=
 =?iso-8859-1?Q?5b8/15s7uSkqhK6PbF3Oio8DB2WEEgozTsrFDBN8eaQy1nml6d7dsVtYVR?=
 =?iso-8859-1?Q?LCCQAfrp3bfRapxL+Q0L0KRNGuxNYk3AatPV3T9StGMJjginY1TDCvuHIb?=
 =?iso-8859-1?Q?2pFsz8akw708YflsJdxy3b6IPIFTZL81ZWHsMCzzdf4JOhgutySso0/ouN?=
 =?iso-8859-1?Q?wbDKZ9JDfp2uC/p4uzrGSDrukC62wcGr7ohvgt4O7k1liCa1Q2y0oz/Jqi?=
 =?iso-8859-1?Q?KHP3+C7NlaRVkAA4i+Xfl9AtsXBwUSBOuwwIYv6TmOvhcTiMujqpKdiFZs?=
 =?iso-8859-1?Q?Xif4l9MMBzR2GBV1q9cuBLcxCldD9aVOD9n1S0c2dk9Y1QX0ovOrrXv5g/?=
 =?iso-8859-1?Q?X31LoWQZMEaJdt2FdM8CFxSAZTL2b+UtFLkrK1z0vLfhWsitPoEK8lsikz?=
 =?iso-8859-1?Q?HbnyZZWsqRFjbt9g/P6KFVZNhhKwGiNDZD7TK1ioBrE5Q9iLSxZfNmFVeO?=
 =?iso-8859-1?Q?lmU9RF/DCOUiUbEqaA6F3JH09bPtXdQP4j8tDVCTRiITdl5EwSYN92VYKo?=
 =?iso-8859-1?Q?rQUcvmv1LOvT9a/TOTgb+DZlnw+H5RifF2cL0xBUdCX0xs2l6ubiukhTjU?=
 =?iso-8859-1?Q?kriGe6BEusgBuxlvfpyv/aQqnPU0kPnXpHtz0kWd2UqVaIm9GQKR1ecRhW?=
 =?iso-8859-1?Q?WNLSh6PaRTQlSvcbEfZrww2tFiMtVek8J7i/rV5dZRd06Qft82b33RN66A?=
 =?iso-8859-1?Q?i6wNBz3V4V1YTzSxKxz+ouPgrMxXGOmXcJzxEg6PwJFE2jQ0YSbfuJbQ5H?=
 =?iso-8859-1?Q?Ka+dm6Hm6NDBbzKKwncuIUhpJicP08OFYZYDQf5TnmOlGdPwN0QgF8pNnp?=
 =?iso-8859-1?Q?JXbV+2m+gRByEYAvVZyAoKHMkfE19G8DK00G7IemFVVx68NUX3/i57qxDJ?=
 =?iso-8859-1?Q?CMj6tFBI/ZRDDpr8arKdVgf6B4tyUnKG65kKgKEwSWE3WUqYjoKxPc5/qC?=
 =?iso-8859-1?Q?GO2rxhKe1x3cwbxfHmtp17G?=
x-microsoft-antispam-prvs: <BN6PR04MB0404DE423DFB4E6E032C27EDF47D0@BN6PR04MB0404.namprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39850400004)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(15650500001)(102836004)(105586002)(186003)(6486002)(7736002)(106356001)(97736004)(2906002)(316002)(26005)(6436002)(305945005)(52116002)(99286004)(53936002)(81166006)(50226002)(81156014)(6512007)(8676002)(71200400001)(8936002)(71190400001)(54906003)(6916009)(14454004)(476003)(6116002)(3846002)(1076003)(386003)(6506007)(256004)(25786009)(2616005)(486006)(4326008)(36756003)(14444005)(5660300002)(66066001)(68736007)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB0404;H:BN6PR04MB0963.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vVSISewbuew35S4Otzo7fDENuvVkeMUIoPVRLQZd3W5y5lHCaT1v9lcEzGX+uXT50aQP+XgDo6iEevKUuVfiy3AUqY4RBQD5ZD2HTdbo37MPpqzw1sLuGoKsRq/7nkaNSPik5xCIS8K27kfqTMq+tGDuIgjQpAajVXit+kl8OFO+O1GnwlcCt465LTYqJIxQXClZNV1/mEWKrf85OKw0TOp4tEEqsQqUjOjfGYSHuokzv7Kfs7SL0m8+ckztfJbPmvY89z9hikvd5pu55ufVp2czIS31Ev0aBypkEVvX4GdFgj+FVrXE+MFqu1jpHwoKFbpSldwuWrwAls8SwYjEM87UKqqGuapYFbbXyvzhGCwr6ChU1wJGoafJLTRTMK8qZdG3zHdvTFLMlY4zZuoZA9H5zOP2G4eHbuniNozQlfM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde5c803-64c6-4e57-99f1-08d69752f786
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 16:46:31.4949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0404
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI
device path") changed the type of the path data, however, the change in
path type was not reflected in size calculations.  Update to use the
correct type and prevent a buffer overflow.

This bug manifests in systems with deep PCI hierarchies, and can lead to
an overflow of the static allocated buffer (dmar_pci_notify_info_buf),
or can lead to overflow of slab-allocated data.

   BUG: KASAN: global-out-of-bounds in dmar_alloc_pci_notify_info+0x1d5/0x2=
e0
   Write of size 1 at addr ffffffff90445d80 by task swapper/0/1
   CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.14.87-rt49-024=
06-gd0a0e96 #1
   Call Trace:
    ? dump_stack+0x46/0x59
    ? print_address_description+0x1df/0x290
    ? dmar_alloc_pci_notify_info+0x1d5/0x2e0
    ? kasan_report+0x256/0x340
    ? dmar_alloc_pci_notify_info+0x1d5/0x2e0
    ? e820__memblock_setup+0xb0/0xb0
    ? dmar_dev_scope_init+0x424/0x48f
    ? __down_write_common+0x1ec/0x230
    ? dmar_dev_scope_init+0x48f/0x48f
    ? dmar_free_unused_resources+0x109/0x109
    ? cpumask_next+0x16/0x20
    ? __kmem_cache_create+0x392/0x430
    ? kmem_cache_create+0x135/0x2f0
    ? e820__memblock_setup+0xb0/0xb0
    ? intel_iommu_init+0x170/0x1848
    ? _raw_spin_unlock_irqrestore+0x32/0x60
    ? migrate_enable+0x27a/0x5b0
    ? sched_setattr+0x20/0x20
    ? migrate_disable+0x1fc/0x380
    ? task_rq_lock+0x170/0x170
    ? try_to_run_init_process+0x40/0x40
    ? locks_remove_file+0x85/0x2f0
    ? dev_prepare_static_identity_mapping+0x78/0x78
    ? rt_spin_unlock+0x39/0x50
    ? lockref_put_or_lock+0x2a/0x40
    ? dput+0x128/0x2f0
    ? __rcu_read_unlock+0x66/0x80
    ? __fput+0x250/0x300
    ? __rcu_read_lock+0x1b/0x30
    ? mntput_no_expire+0x38/0x290
    ? e820__memblock_setup+0xb0/0xb0
    ? pci_iommu_init+0x25/0x63
    ? pci_iommu_init+0x25/0x63
    ? do_one_initcall+0x7e/0x1c0
    ? initcall_blacklisted+0x120/0x120
    ? kernel_init_freeable+0x27b/0x307
    ? rest_init+0xd0/0xd0
    ? kernel_init+0xf/0x120
    ? rest_init+0xd0/0xd0
    ? ret_from_fork+0x1f/0x40
   The buggy address belongs to the variable:
    dmar_pci_notify_info_buf+0x40/0x60

Fixes: 57384592c433 ("iommu/vt-d: Store bus information in RMRR PCI device =
path")
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 6b7df25e1488..9c49300e9fb7 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -145,7 +145,7 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigne=
d long event)
 		for (tmp =3D dev; tmp; tmp =3D tmp->bus->self)
 			level++;
=20
-	size =3D sizeof(*info) + level * sizeof(struct acpi_dmar_pci_path);
+	size =3D sizeof(*info) + level * sizeof(info->path[0]);
 	if (size <=3D sizeof(dmar_pci_notify_info_buf)) {
 		info =3D (struct dmar_pci_notify_info *)dmar_pci_notify_info_buf;
 	} else {
--=20
2.20.1

