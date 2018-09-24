Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA00C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3FF214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ocF2IJ16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3FF214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbeIXUw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:27 -0400
Received: from mail-sn1nam01on0124.outbound.protection.outlook.com ([104.47.32.124]:17682
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387825AbeIXUwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvdBmA7EEsnpP7deKWfZPUpg/y7FZphk+rMaDigGE8o=;
 b=ocF2IJ16YvVaIECWbshj1WUH5MFZmK68PwLs00LIncUi1m9v9p50VI5GJd3W9pok/rjbBs/DLQ6BeDYyod4qo/qRfZVPAdzoEaO/MW6iggxkBVmR06PC8sBXR5JsVcWqZN5nVGE+qyfyrmAX3l6yKRx7IarX+xIAel9P7rA7kWw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:40 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 04/36] btrfs: btrfs_shrink_device should call
 commit transaction at the end
Thread-Topic: [PATCH AUTOSEL 4.14 04/36] btrfs: btrfs_shrink_device should
 call commit transaction at the end
Thread-Index: AQHUVBW4sMmREjngdU6K2k6MiUEu9w==
Date:   Mon, 24 Sep 2018 14:48:56 +0000
Message-ID: <20180924144851.164533-4-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:d8AgN+D0K7/PaP131KxwRM1PREc4mAmFG5/wwDBXlKRjiq0F83vYnzajC8lN8ioHWTSnPlRkpauaEP5luYlbuyULJRJSeOOuot1/RZ6m60vg4LzH2JA5lhKmJoAtBCYE/krpeqbiNuMCUL48jmgkoqupe01GofqJy+5I5+OTqHvJcn1hm86ZGYF0C/yR7QpD+SljsaMxS7jQ+HmaS7VkNKm8pkKiHtqU5FxbNtLtY8X22rHuIH/kSYOry+cK3rlQdSB1t8lmCPKjlDJxLuvmpGaSuxjdxhSiag7tln/LPvzuQWleco/7ERKb/D7kDig99JgMPw4mKW8dFH1OY8jpdAo0FuQ6EZ+jUFpYSHMTeNq3SiDAcoY1ZqHG3L14enAW7BaQkZpllvqZFT7ENG41FbuPRU6yvsEnskwjXoVllzqNXSLrpUUSPcmmNbtnu3Eh51EXMMB9/eQsNhHbnN32jQ==;5:W84UW6Qv72422xL2Jkskttn5Mb/kdjXMZRK7w8/T+SmAX2XeYbEWbAf8b5HkZzW8p8vEvf1rMDEGwzk7wMREPNTr3ua5fnoMiXqzzDT9j5AgC20qXXOUiLntvacs/iX0WbCqwdyzljkvQzmNl7tFUvykPPClp7aDDVt6udWILmw=;7:wWgm2dmlO7LtpA+ZBmE41o8gHhKXDltEKGmxixCBkQdWy8Zpo5PBy9d4WKnzvbrMKzhwP5s0Rs/t26ZfAL6qL4U4OkWXSzIqghsg9bbxLXDzxsSqvUrdOt8x7IeLyrrpoxVv5V/sBwJEKtZJY7i5LT+OcnjcqAlsnh6uzjOGfaVIH3KF2QaVYgNptYvLR33mIb3jTshb+3noc7bbXsAuewABkNyJdVYBJIrwktr1E+q2BJW7l8Tx+nFzDDKKuId3
x-ms-office365-filtering-correlation-id: d3d7c5e0-95cd-4f8a-34fc-08d6222cf512
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB047023C1C572318F1772CD16FB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(146099531331640)(170618885588394)(268935105599563)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(54534003)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(76176011)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(575784001)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(551934003)(6486002)(6436002)(106356001)(486006)(105586002)(446003)(6506007)(11346002)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: O8MKF2EZM5pBPwYKn21QKvEgeSnrIJST1c1+u7ROh2yBCzDUUvDjozo4Jrij7n9fzxAKR2pKuJolZfs7YkjXWgBaEKzKNQJduIONlGh/qI67zvOm92CEHxYTuJDWNSXOU9btgJNXus7i+g381ugKo+menBQskq6MpD7YAoq2/qXvJFwAGkO0OLXEaW4LkcFikoDsrQc2Xo/UMi6ylOgKNBd36jFpOd1tkJCnld1W2YtQH8Tanij3FQrFNkq26TaOfSGQsettUPV1bRlIcHO16lwnttIQihRYR6Q1HFjQE8tgSgQXLVjKWFYGQ1kOQgnd7jZsTM9k8hOjAH3f83FiYDKK5PU91DiV73uVTKLHkSA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d7c5e0-95cd-4f8a-34fc-08d6222cf512
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:56.0704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit 801660b040d132f67fac6a95910ad307c5929b49 ]

Test case btrfs/164 reports use-after-free:

[ 6712.084324] general protection fault: 0000 [#1] PREEMPT SMP
..
[ 6712.195423]  btrfs_update_commit_device_size+0x75/0xf0 [btrfs]
[ 6712.201424]  btrfs_commit_transaction+0x57d/0xa90 [btrfs]
[ 6712.206999]  btrfs_rm_device+0x627/0x850 [btrfs]
[ 6712.211800]  btrfs_ioctl+0x2b03/0x3120 [btrfs]

Reason for this is that btrfs_shrink_device adds the resized device to
the fs_devices::resized_devices after it has called the last commit
transaction.

So the list fs_devices::resized_devices is not empty when
btrfs_shrink_device returns.  Now the parent function
btrfs_rm_device calls:

        btrfs_close_bdev(device);
        call_rcu(&device->rcu, free_device_rcu);

and then does the transactio ncommit. It goes through the
fs_devices::resized_devices in btrfs_update_commit_device_size and
leads to use-after-free.

Fix this by making sure btrfs_shrink_device calls the last needed
btrfs_commit_transaction before the return. This is consistent with what
the grow counterpart does and this makes sure the on-disk state is
persistent when the function returns.

Reported-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Tested-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/btrfs/volumes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a39b1f0b0606..a0947f4a3e87 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4517,7 +4517,12 @@ int btrfs_shrink_device(struct btrfs_device *device,=
 u64 new_size)
=20
 	/* Now btrfs_update_device() will change the on-disk size. */
 	ret =3D btrfs_update_device(trans, device);
-	btrfs_end_transaction(trans);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+	} else {
+		ret =3D btrfs_commit_transaction(trans);
+	}
 done:
 	btrfs_free_path(path);
 	if (ret) {
--=20
2.17.1
