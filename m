Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7B0C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B02120878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gr42lUPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B02120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754577AbeGINvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:51:20 -0400
Received: from mail-eopbgr130092.outbound.protection.outlook.com ([40.107.13.92]:35086
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750996AbeGINvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uIRmqRceoaCZQ/2wgpVJCyR9h0ZamkwEmp48tvgNt8=;
 b=gr42lUPdfO92KIK75CHU0HEBF8x8ihNhNT3r9VKf42KO4xP+vn7r8qaXKEnvptp/MZ6LZ6q4Pn0BCZRqo0zIiAf8/4AobrJJWbe2e2YrbBGdWFE7maBENtIziynpgnuuNM277fWRMn16WcMfQqRPiz0w2VE8SBncaK8hLl3RWFE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jan.dakinevich@virtuozzo.com; 
Received: from work.sw.ru (185.231.240.5) by
 VI1PR08MB2781.eurprd08.prod.outlook.com (2603:10a6:802:19::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 13:51:12 +0000
From:   Jan Dakinevich <jan.dakinevich@virtuozzo.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Subject: [PATCH] ib_srpt: use kvmalloc to allocate ring pointers
Date:   Mon,  9 Jul 2018 16:51:08 +0300
Message-Id: <1531144268-25361-1-git-send-email-jan.dakinevich@virtuozzo.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM0PR01CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::24) To VI1PR08MB2781.eurprd08.prod.outlook.com
 (2603:10a6:802:19::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16622bf3-e7d8-4b3b-5b37-08d5e5a30898
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2781;3:dgrgUNpB/QRwm+/5M/7IFhqQGwg4F8CK6VgNDDTrQXBVvEXzmq5Ny7zJtFhkKx4V0C4DbtnPwmUbgcXnwZU+cr4KjIA6ltv0ikxFIDLs6wTv64DPbgGRXO6xTNXxv0rohJNI1OBzbDHUmKFzZUU51/2wQlwD4LAx6eFyIweLa9ASpK2him7x8isvUq7RVTOOpCUAZ6xaH6RoeTpccPHR9+He2jeopGX4S6FWz3fhPZhVC4M09vyUPMyQl6Tk7vyw;25:OwsM7xIxOfeWhvRqhwEDRj6FR3wrj86H0CTmIpc9A4kj1jNBcBp3dEWMVP/okhiHuxBMWvTfVQZPmwsUIuCsR8O9Bd5VvYnueL6uvQxN214GT3hwoo8iyIZ9NFP37Pfa+6E0GMRMEIP5+FB28MEd4jzekEpg+8lLf0D83aO+zPZgrloKKfKr5YsWGugcGQVkTN9oOVXoR0E2EmWPvAwe/Fu/UF86hGGWXiSRdw59gF7AvPhZ++LYrWUa8qDY3RSvwgIlLrWzp4O7lMFuDBOsfLhGVsPXQLI63bgucJMAXYQ4bPwIWO4A4OJQfHRJlgwdG7UhxjAINCKV30zK1S4xFA==;31:JoUNQMHTpE07N8eyhv0FWR72H8YK59TZYINrlXJ2/SzaANff+xL1lfnN7sOqwX2VemeNhOikIVlYo48UafgEXCKZZF17ye+swtwo8ywntoRuXqKIakegNhbAB3VAcNHoSChe+oUFnKN0CktMTAf1pzY29joEbV+zGb2atVLzov6H//xv2keIV014AtV3nXhvXu1XJievmZvKMfToEMehFIKX3xTbxcQoLOk6rqgNSsk=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2781:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2781;20:uHbcmgmSQce3hhmfezyT7t7isWY/j2xvjXhFcxCmxB95t1RlExbStccK1ndkNYyz+bhcptRtgYMJeqCwDMOB1dm3pu6/glr0orhPlWBvIO/Owi5cFzacuVjxQKoplZ0XUfUuWLrZLfJPZhgRvzoCKBnNOFUy1B76I0LWH8vjOpkw1X3TbmOv23RUXwjYRDLyO+2skt1pdLsM8FyMcCkgA0UdlbxZwDCxoRfwxlJ5SAAD+BEiXxB6+jyTV0J3uSM3FQvNI+EZFZTvD8cEQOrGdGMV9kIgf4F1A2D5mE4l1aY16p6HCASipC3bZG7iLKha9DnrrvnLaIftcNM5WRUUZBw5AlNF13NPShYovtjTw6Ey1Sp9QVfFZRt3RjRArndG3X4U1NqLdB+mMcTojPZQwUNIdnFH9+bAo9CMnRDsl3/YlLclXtUgb+3KGXsST76At4TvUGBOzcOmcmia27w4WTmeVf84Vn9BYflknmWcACaBzV57euaNJC7kf2I3qiFc;4:74juHyZqh+WqbXwFty9mCU9Mypherw0lQTJlfKKEpe2oI6kQ7RsFSku8iIDcn7F1H1eIu6YvBF79HqYQKHWnpbp7j5Y6/hmyNkte8U575MbS0gIq+s4NDAqJXhUQseVSAflfIii7ftIJhXLJbRMXnrQRpSjjHdRZ7fI451vYcCdZSULriBRLseb8y+VhGemICnK1TAx6E1St5jyxYV9YqlIHB4jWCS2wyk8lPsXOe6pE46CtV8mpa9t3ud9CNzgieeHgYRDvPXxDCdYmGdb+Kw==
X-Microsoft-Antispam-PRVS: <VI1PR08MB2781744C3AE9CD31F2A648348A440@VI1PR08MB2781.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB2781;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2781;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(6666003)(8936002)(26005)(8676002)(81166006)(81156014)(16526019)(86362001)(476003)(25786009)(7736002)(186003)(44832011)(6486002)(486006)(69596002)(50466002)(6116002)(3846002)(305945005)(1857600001)(2616005)(4326008)(48376002)(5660300001)(2906002)(6506007)(53416004)(105586002)(106356001)(478600001)(956004)(68736007)(50226002)(110136005)(54906003)(66066001)(51416003)(16586007)(52116002)(316002)(53936002)(6512007)(107886003)(386003)(97736004)(36756003)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2781;H:work.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB2781;23:5XBauBIlUrG0wvWmhRqW2VJzzcyd/b2+GKhCdsFxe?=
 =?us-ascii?Q?Z66Az5E/8NYT5ujJ/KiNwgVUdx8AY4AFzpoySVafUpq4FPXKYab4bJzTpCJZ?=
 =?us-ascii?Q?CKNDxqS7AvqmkuyM7DrY1hEcl0oJNtX8/1qC/+ji20bN7B9VJLZBruyfFugQ?=
 =?us-ascii?Q?L7nHFkZbU/cwsxaPWZH9y0HiKwXQFyOk34PXaf+tloc+mKUM+kVmOFPi2q+K?=
 =?us-ascii?Q?sOpIspooYIXeESYeBZKPT5gsRKoJTaYzWQiwFcmXAc+4k9AWUoVtoBQrrx/g?=
 =?us-ascii?Q?MEARrkMuIk63qgSlM+55sCZ+G7YArnwSkIF996OkrN+nG8uvkj5b1go2aB5w?=
 =?us-ascii?Q?ceaQFSJ4l/tQEtl/mX0U2IoRuZpBGQgLaBev6c1/sZVZXFmkG7rxZWhmGnVw?=
 =?us-ascii?Q?7+mcgBb+ZPfX2nTIYrtP6j57UmD5uA+D482zrdh417gHC4j/gBRX+923asyb?=
 =?us-ascii?Q?acpY9RqCAXZRo87cczL84WMNf4gR3Bi/OydmjC7Qb6rKcX0wJnp0mhBPbeSC?=
 =?us-ascii?Q?fdSoudUtdWQ309WGfpBOgZnsi63ftHeJyQNBrc1uzKaFZllr2D3e0kK7e7UE?=
 =?us-ascii?Q?PlB2M4ogNAJDq/GVzVeQiiDXEUP4sclSJI9qvnm0Hkj8VEBFXOALfeBfWAzC?=
 =?us-ascii?Q?jP6YQUUeplKcDNrnGs0OIuuz9GsPyr1DwaEmObUi58DgvBANG7DoyVs8shoL?=
 =?us-ascii?Q?679AosH9pw8EhANuLclIJgf3VUXZ+JXhvLiTxNxAGqstAWBj0JnMBayjhOd+?=
 =?us-ascii?Q?mW4ttCiTSiEaODEmlAyUGe0MZIZyFvhHhz8gm20YDYvbkKAQe/J3ZWDurQts?=
 =?us-ascii?Q?JGnC1Zk/i66BSQDXAIIvKQllSyppXUD6qY4JurueBeJB7K8miHiMonHXD0Pt?=
 =?us-ascii?Q?WT7UYLkXZNcji07krRgPCfmS15Eajj6gZ07sS1CLwUmiS5UV7flqnbtQVc8H?=
 =?us-ascii?Q?+imDxf1OuaevzbD130mkfU1JGfBsdGdSZc5RytuCiTQbnRdewFqSZNrqDAMB?=
 =?us-ascii?Q?USnEacFVzJ0FDyUiOJCp7yQLsSVlnhlj61V0UPB0aya+aXNdoQbONCiOAsfB?=
 =?us-ascii?Q?O1pi6jv/HVGe0LX0NUCrGHa8uBNZq2gd36bQ57WdsAFI7HuzybeXqQnCxg/M?=
 =?us-ascii?Q?sPoeYkMdPuf+zs/USj+hkkyDMrDDs2+ubr1+lwWYOOMvo9yyDzuR5bD6fbHH?=
 =?us-ascii?Q?YuJJRQ2sz4KdnVhw9PDaCRaNMlU0besdyhDrkiUS4o4h/Vd+3ESGX0mvIBvG?=
 =?us-ascii?Q?ZqgOZ9B3JRiTt5O9Ys=3D?=
X-Microsoft-Antispam-Message-Info: arPUMiERAaEq97NiN2Yba7zE9EEf2eyEb40X+zrfbS5Ru8RIP3ed0PV48+rYlqUJzN1jLWiWeGT5sM1KvKWJFlizHvJUpuOThWfQIUrOu/ZVEEuZ9qNAW2UtKBR2+YievzriWEx5Ea1gUjfX/Tymm2Hrma8GDZa/uZCo5QENKh72EaRcec6WP0Th06cHPIwSE3TtE8pkRGxi2Y9dBJ8WgP4YmiY2kWaM5GGYHvCNxftT+p+TitKdNlvyrJMIEWrLrOgLNKP+MkPJA2YsHyXypAt2rottwwXAZgBCNnzvin3MilQF9MljpvB9HBLBVuAUL8G/z8YJefOHpfchzm4OOhMozPcbKVmRJfZjX1zFeaw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2781;6:zYicPpEmLHj1c4mB/xNPKBJfZM22FoanxJZZbeoWDXWhgPIBlnt/tcvBZqQGF719vEW0jCzJ8Xs3Cc1dCWNXlP29uq6/AadHY5w0feUWUia//O+eLw/VYAL+zOQYm66duBLsXej90xQjEtOc/WwNhY9aEpI0ai5tv/uiAeifZD+Q99uH7j9IlFumGyxXl+tDqUAi1ES5ZsibB93jLGaTB3aQwKfwIOODWkNJtOJtfFlwhcv1aBmniEFfSCOlukzoF7A1qSTC5noi5Mz3bxMLgD8YSBSURMymY42hR0zIj72hLV7GNe6+Woq02vuu7wfmH95TVzey0A34l3z1X4XGrvkwsp7hlf2mPnuTj5t5y4lfacKeHscD9jmy8UDPVfOMwISN+641/wJUpbX3mTOZ1BStHy41J47uGHLx4IJdLFZTPhZ639lvX0ItodGN36AJsYao0nxa7/O7TUqeWCPpUw==;5:C8WKcqcUDOExoXzm6b1Z/kSJkXduFAaNqkr8WTcpf/wUB0DBE5c8aM5agvGKJRQRtT9cv1OEeFbSPjP5AGXUIk2kNdhySnW+1MS3T2U63nu/oni2qBuVdiTc0jOqLhpZoASCvED52Id+G6aWPH+I23b4YiWJVIWFaSzJyFJzE1M=;24:OtOfCfPVB/LcWDcZAIXLq80DYsEXCXW+/BZaWZSuIseTwca3m6sK/8/D/cCVKG8szQAtJcpgNcRvPUxVjN+ryovNyvrGa2yrReT0SE39Tos=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2781;7:cia6HE0wciTk70TNRfLNQXas3ciUyIuPq9WtEl+Dark8iKHIfgWFDoDVVmlJ4mjFApKDQEKPbIbV8jy2QNGfHv1T9LBoxKzywSQfLnkVCaZHANNb6/AGBLUMpa5kIi6/NDPDm6i4CnR3Y5LIbWSd3EYW478QgdTDenvglMP5WU7sEmOweZgAdB1h+De8xmYK2dle47efEN2xPmNyDsWqXXRrCvXolipG9tZRdMQIpvbBk62/+ssVuHcVmw0jEQ+X;20:xsHcMyHQaEvxcLgu4Szti4LAk7eZkzO9jkJnEVXiGpPa/09EjeBQEL0Z0p4Rc+DNap2BYPWDf9Px2WR+QYHobV3FFb3osqewW+Lg2/ixD3o6lWw/2VAo2ZrREewwc7tuX5oZNJb9w4kHt2/Ij/Jlje5urtvb15StUujUQvINxgg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 13:51:12.2140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16622bf3-e7d8-4b3b-5b37-08d5e5a30898
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2781
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An array of pointers to SRPT contexts in ib_device is over 30KiB even
in default case, in which an amount of contexts is 4095. The patch
is intended to weed out large contigous allocation for non-DMA memory.

Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 3081c62..de167af 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -720,7 +720,7 @@ static struct srpt_ioctx **srpt_alloc_ioctx_ring(struct srpt_device *sdev,
 	WARN_ON(ioctx_size != sizeof(struct srpt_recv_ioctx)
 		&& ioctx_size != sizeof(struct srpt_send_ioctx));
 
-	ring = kmalloc_array(ring_size, sizeof(ring[0]), GFP_KERNEL);
+	ring = kvmalloc_array(ring_size, sizeof(ring[0]), GFP_KERNEL);
 	if (!ring)
 		goto out;
 	for (i = 0; i < ring_size; ++i) {
@@ -734,7 +734,7 @@ static struct srpt_ioctx **srpt_alloc_ioctx_ring(struct srpt_device *sdev,
 err:
 	while (--i >= 0)
 		srpt_free_ioctx(sdev, ring[i], dma_size, dir);
-	kfree(ring);
+	kvfree(ring);
 	ring = NULL;
 out:
 	return ring;
@@ -759,7 +759,7 @@ static void srpt_free_ioctx_ring(struct srpt_ioctx **ioctx_ring,
 
 	for (i = 0; i < ring_size; ++i)
 		srpt_free_ioctx(sdev, ioctx_ring[i], dma_size, dir);
-	kfree(ioctx_ring);
+	kvfree(ioctx_ring);
 }
 
 /**
-- 
2.1.4

