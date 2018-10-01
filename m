Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B17C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505BC2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CAZT72bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505BC2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbeJAHRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:17:05 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:43745
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730124AbeJAHRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bi5I3+b4+PAQaI0vg70I/VoI9/GrXjVmmV0g7UP6K/E=;
 b=CAZT72bYmaNkgakhqgRUiaoyFHl2PmWZ1zTRwXipe5EwRHKmJPcfyP/8ZAVjFn9PCWxCtQf5R/u3viUyYO16JcxnFwxc9Q+oiknXA5oXqixt7R1tKtwarSEU0ObKv75BYr4DFzyeKpAgYmUAA1TTQH/l/FwrQp+RLGQP46VULTE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0791.namprd21.prod.outlook.com (10.175.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:41:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:41:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 03/13] RDMA/ucma: check fd type in
 ucma_migrate_id()
Thread-Topic: [PATCH AUTOSEL 3.18 03/13] RDMA/ucma: check fd type in
 ucma_migrate_id()
Thread-Index: AQHUWR+H/U++iKwOdkSG7N8tgwSPuA==
Date:   Mon, 1 Oct 2018 00:41:45 +0000
Message-ID: <20181001004139.147341-3-alexander.levin@microsoft.com>
References: <20181001004139.147341-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004139.147341-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0791;6:UcVIHNamZGoI5/HEKk7YZ85u2BLDyplPaIgcrmjimk1k+s8/3npO1ZY+AO3CKnuZoK+1TkgT9kV9PKm7cvswLjj8IxtVKqmp5BEN1Bt5DQ9fGKL0KFPrBp6bmO5AYuK95pSQVIE4d6FZJ1XQtXhlFKW/QYSFEaufiscx/6UI+4jEkoqQOhrr5e92vVoWsz5qaqrF7SceP0n0ZbFXZUVYUxyiPY9tRQ3CGkmwAmGDZNq5Qi+4IRfWhe9lmVFQDTpZJiafTZP3w+eWcQQXabaAKH4famfBiXZiRsbD2w5jy1vfAsWZTmsDOdlxEx6u9eFzOLGn7YSTjUk5Jag9LdQCrWi495D7lDBHMeclT9f79YxVCc2ciN5FWFzSW/y4SgFakD6sfqQ0dfkD3T2yQFnr//spV6en4oBLvzQHQ2uF4QGqVlHNoyaG8SsvuPjTlcUvrasvQc9jQaMS+XQ+8yVwVw==;5:MAsHih23vNno84ZEphKHe3yKNP2tqBmLLKLlbkcY6tE/OAXzRU8FIiqpedvUfnfE4AwlRcTw9pWITfZsXVZBFlmDEQrmgfItWE7Ym3qqHiVQszvHHC3kta3EL1SKGXA52rGZ5R/613HpxVgkDxnP54SRPXh+xudOxHZ9uK3eo8A=;7:x6qvw9d/1uxzgbRND44bYBRQf30dZY+5GkeHQ9EigL4MqDSfsq7DQpjWJETbsQY0h5FMkkM9xpJ8XBQH3yMsY0WHpnE44MAJSdmN3syJmBsDGocKPIZYjXymP6zVvIAWIZ/psJMbcqqgDLSOmFhfeNZO+olLYM46c3dqi5Ot5a1oWu3ZyyE02aXCLrSYl/W817ERWboVvwE4KFBxuqHBJN+KH9eWH+mAbldwk4vSQjobx8uCrI6wo+3aAp0v48Lp
x-ms-office365-filtering-correlation-id: d0f750a2-2837-4dcb-dbb5-08d62736aa34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0791;
x-ms-traffictypediagnostic: CY4PR21MB0791:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0791E0E073941F8F758A1807FBEF0@CY4PR21MB0791.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0791;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0791;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(376002)(39860400002)(189003)(199004)(72206003)(71190400001)(478600001)(316002)(110136005)(14454004)(2616005)(54906003)(105586002)(107886003)(106356001)(186003)(305945005)(26005)(34290500001)(71200400001)(22452003)(7736002)(256004)(14444005)(25786009)(10290500003)(99286004)(68736007)(53936002)(486006)(6512007)(446003)(66066001)(36756003)(6506007)(81166006)(81156014)(6486002)(5250100002)(86362001)(2501003)(5660300001)(4326008)(11346002)(6116002)(476003)(3846002)(10090500001)(97736004)(1076002)(8676002)(8936002)(102836004)(217873002)(6436002)(76176011)(86612001)(2900100001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0791;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ewGv2erPz3AQfn0AF0PrnueEDmuA8Cj9dmQZ7r+5Hj4T36/Wi3xKdTxfljbfbOC/EY9k7I6wHByToBoY0P7Eq+whii4biOsvVjZFBQdXZpoVKNz8kJTI//bdg+ZJkWZvAQIp89Lu72AErzh+gxfZn6Lpd08F9K2x3RCw0lwawUpoZF+8GdINnIAkfjveXBPm3rYDTr4AhVsNiqAynvQ5whSYYOxkOmcCNc+Ma6aDvAB4wBL6VTAxJxukhTs3AoYSzAkIqjLMFXrGLlpcebSFqz+ZYARxN2yfLlN6RFI6PiPPaseqWp6+sWoMJac6NavyuEfhA4TbAu6+50HF80XlQOKB8yzV3EQMyPuFpBp6s1E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f750a2-2837-4dcb-dbb5-08d62736aa34
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:41:45.5671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0791
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

[ Upstream commit 0d23ba6034b9cf48b8918404367506da3e4b3ee5 ]

The current code grabs the private_data of whatever file descriptor
userspace has supplied and implicitly casts it to a `struct ucma_file *`,
potentially causing a type confusion.

This is probably fine in practice because the pointer is only used for
comparisons, it is never actually dereferenced; and even in the
comparisons, it is unlikely that a file from another filesystem would have
a ->private_data pointer that happens to also be valid in this context.
But ->private_data is not always guaranteed to be a valid pointer to an
object owned by the file's filesystem; for example, some filesystems just
cram numbers in there.

Check the type of the supplied file descriptor to be safe, analogous to how
other places in the kernel do it.

Fixes: 88314e4dda1e ("RDMA/cma: add support for rdma_migrate_id()")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/core/ucma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.=
c
index eaadd636c21b..a399d7da7774 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -113,6 +113,8 @@ static DEFINE_MUTEX(mut);
 static DEFINE_IDR(ctx_idr);
 static DEFINE_IDR(multicast_idr);
=20
+static const struct file_operations ucma_fops;
+
 static inline struct ucma_context *_ucma_find_context(int id,
 						      struct ucma_file *file)
 {
@@ -1416,6 +1418,10 @@ static ssize_t ucma_migrate_id(struct ucma_file *new=
_file,
 	f =3D fdget(cmd.fd);
 	if (!f.file)
 		return -ENOENT;
+	if (f.file->f_op !=3D &ucma_fops) {
+		ret =3D -EINVAL;
+		goto file_put;
+	}
=20
 	/* Validate current fd and prevent destruction of id. */
 	ctx =3D ucma_get_ctx(f.file->private_data, cmd.id);
--=20
2.17.1
