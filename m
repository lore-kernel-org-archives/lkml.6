Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275C3ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4E821522
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XpGxfSC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4E821522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbeITI2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:37 -0400
Received: from mail-sn1nam01on0116.outbound.protection.outlook.com ([104.47.32.116]:8864
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733294AbeITI2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAKVXzkc82cLtlyQzAzCu/d0TtX7vxhm295PA9Pi3rI=;
 b=XpGxfSC73sUC99j9JtpiCL1NZm861PqNk4Ofc/CJsZrSJEX0+sXtaa5skkLd2wHTuDQGi8Xovus6Z+xhA1ejlYxtzL/jIbJIasnY+09ZPPKsmHDzyVmwwtwK3ZGf2X6BSt6EYgfF6Vm3HchlDI7x7rb3GzdeRqAS+Wvbt9IUGnI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:47:32 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:32 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Eric Sandeen <sandeen@redhat.com>, Jan Kara <jack@suse.cz>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 09/56] isofs: reject hardware sector size > 2048
 bytes
Thread-Topic: [PATCH AUTOSEL 4.18 09/56] isofs: reject hardware sector size >
 2048 bytes
Thread-Index: AQHUUIxHWvKHvJje5UK/b/TQOpbRTA==
Date:   Thu, 20 Sep 2018 02:47:32 +0000
Message-ID: <20180920024716.58490-9-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:X7g/wZjTLq58pYpsbdEkjBQNP7+uBoSMiedoCphy0bdVMbzpff8aQgnG1JObsR5suBY94I/rcP67H0QUi1+GiXMb9U5gvoLacIzpXwth4tFvrD3lcOBii1gFXO7qEuNi4xmyi9a9Q3lMpoGZb0CM6bj+9pQ1sMcPqRxLZoVbk5Rdf3dDAF5vofXQyRH/65beglFtfMzImMscg88hmPZAxmCOxfsKTkXlrv2sY3rCc+PkTN771HvZyNKELvVWFygD0ccHfnsqjD8xdDpxgwVz7+14Igo9ScTNoRW9hDT5jb8q/6dEUxaSWpQvlE53z7vXJMcv/mmApmgb42vK/Ff6X3V1XW4fmeSmxx7zKHLMnBhE29n08EJWOafSTDHBCdtZcIrXDSJwJu/k8fmB/sLhsVIDwOZu0yUTMR2mLhzHtP7puICroKgJCKj3ui4waMr8v2pylWhfzLQTi2iCILGjXg==;5:DyEC6Hn9bHTX52D06ACrJzKiovJIvGqxRGBUw6taROKlKlXK/1qjIfwUB+r6rqWvp2gyYSTeqeoFoJ7DSg+RDQ/BJ5O1Zegt+7boRSf3ZavQzP+tZkZ3fPk7x7Xr6nJUh90qNxuK2NJMLGtHp+NEKVbk90y2DeEnqhuc04h0iBI=;7:KMvmsJmm4Uvzv1viQvlkQJpRgLn8YcVtHHb30Q5BzL6T2RsHsA+C/PN7YeVRwNfndMQMpfhft8SmubkfFWsG1VCoCvUA+ED5ZQAN3nYbLE1EyYNto6O/zbD+AzoskqhzJyTqmbsKUdH74BL+SWXhJNg4hAKFDIphzLxKpkrSl6FgZG0I+NsJZm6btyT+Lg6VnodAKeVJpPEu5U9mPTd3E0LBaSl3484p2jDnHWczBG4qnjBzveRV6j2WY0+fxXri
x-ms-office365-filtering-correlation-id: 3612a446-ddda-4120-52a7-08d61ea36a2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB085515E2843FFB60F18502B4FB130@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(2501003)(186003)(86612001)(10290500003)(478600001)(2906002)(86362001)(106356001)(575784001)(3846002)(5660300001)(2900100001)(6116002)(8936002)(105586002)(1076002)(53936002)(14454004)(7736002)(305945005)(81156014)(81166006)(8676002)(6512007)(68736007)(72206003)(6346003)(107886003)(102836004)(26005)(14444005)(256004)(6506007)(36756003)(446003)(476003)(2616005)(71200400001)(71190400001)(486006)(217873002)(66066001)(11346002)(97736004)(25786009)(22452003)(5250100002)(10090500001)(6436002)(316002)(6486002)(110136005)(54906003)(99286004)(4326008)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: VAxqn4c1IlvaQb+PxXw12ud0Qw7PIhqzibBPP4yiygFvOE58qLhoX837zAKiAJGemwdy47LOFGJ0WrrXMksFLnfNoFCeL1vu/PWNNzrewa62CXptQ7tx0Fz16cgOcBdrYN1AFC28uPp+Qh+S+JJ416a3rtPBNr90OCMqLHEVobiaDe2YdSHS32JYuk7rga1da/g8p+8Ksc0x+3W8PfxcU1BcGpfsNlxcE+J6GAG9WDvhWth2CenOlntKe3vp5wucEw9ypkLIq61ku4xZ61VxPXoWuclOWVrl4Jeedaqcy+0o0bEnRJ+7ujKA3VoMWlsC5L++2uSQwGYYPiz3FTJU9z6begwuQay+UGgReWrMM5w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3612a446-ddda-4120-52a7-08d61ea36a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:32.7577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit 09a4e0be5826aa66c4ce9954841f110ffe63ef4f ]

The largest block size supported by isofs is ISOFS_BLOCK_SIZE (2048), but
isofs_fill_super calls sb_min_blocksize and sets the blocksize to the
device's logical block size if it's larger than what we ended up with after
option parsing.

If for some reason we try to mount a hard 4k device as an isofs filesystem,
we'll set opt.blocksize to 4096, and when we try to read the superblock
we found via:

        block =3D iso_blknum << (ISOFS_BLOCK_BITS - s->s_blocksize_bits)

with s_blocksize_bits greater than ISOFS_BLOCK_BITS, we'll have a negative
shift and the bread will fail somewhat cryptically:

  isofs_fill_super: bread failed, dev=3Dsda, iso_blknum=3D17, block=3D-2147=
483648

It seems best to just catch and clearly reject mounts of such a device.

Reported-by: Bryan Gurney <bgurney@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/isofs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index ec3fba7d492f..488a9e7f8f66 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -24,6 +24,7 @@
 #include <linux/mpage.h>
 #include <linux/user_namespace.h>
 #include <linux/seq_file.h>
+#include <linux/blkdev.h>
=20
 #include "isofs.h"
 #include "zisofs.h"
@@ -653,6 +654,12 @@ static int isofs_fill_super(struct super_block *s, voi=
d *data, int silent)
 	/*
 	 * What if bugger tells us to go beyond page size?
 	 */
+	if (bdev_logical_block_size(s->s_bdev) > 2048) {
+		printk(KERN_WARNING
+		       "ISOFS: unsupported/invalid hardware sector size %d\n",
+			bdev_logical_block_size(s->s_bdev));
+		goto out_freesbi;
+	}
 	opt.blocksize =3D sb_min_blocksize(s, opt.blocksize);
=20
 	sbi->s_high_sierra =3D 0; /* default is iso9660 */
--=20
2.17.1
