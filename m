Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8088EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3672098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Yf9BbM54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3672098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbeIXUum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:42 -0400
Received: from mail-eopbgr720121.outbound.protection.outlook.com ([40.107.72.121]:64608
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbeIXUul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd7GAbmdhCrv8iQ/MtqvjFPRHMPvYQNd0ABFXS7e0R4=;
 b=Yf9BbM54QObe50cfnkBPf3PDVvQ2lD1bk8IdvW8X0GbxyF1CRNGuEczADKLSkADSyV8GTXvK29LmhPxE6iTeuPjyHH+Z6FDCquJ5s6OmvV3/WIvS4TBxrkqKRCtZY8ARh0Wsz4WS4w0Ol28myxQvb3ccSn+CAR4yIkwXFMtQrv4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 06/76] btrfs: btrfs_shrink_device should call
 commit transaction at the end
Thread-Topic: [PATCH AUTOSEL 4.18 06/76] btrfs: btrfs_shrink_device should
 call commit transaction at the end
Thread-Index: AQHUVBWYxIoO5zscIUuibTWPfyk1/A==
Date:   Mon, 24 Sep 2018 14:48:03 +0000
Message-ID: <20180924144751.164410-6-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:oZGS7dVvPyPk//NZMTJyOZ51oZ1EnhXEQDLGLbKmC/I+OrbHKYP9+h/jq1x3B0/JdeyLU1dQA+ZvpfmEsMNvPGKyEpF+IFeRDv68v1aJ3npZXcV9/M3NJaE7Ix5+ILsiS2n6xo78I44yr8IvEs+prTXb3bc6lW0FYjevCYVL4aPCeSY9kNea8rYpkpPpM3hWB0WdaRFukPd8PukzLjCLgYIgv5s37vML0GZEUxO2TzizaiWT9WYPtE5SSdxbjWXWS3FylNppTrYdfBw2HsmdlewmXR5Pu5wiequcdSIlVSqiQGbCgxHYcbhCPuBkSy0b6ZUQSWr/j/Pi8JPWIJe5oMZ6IC5p/1u0rHZkjeOAthWindRqxM+hXJYxPNvBvCkgtNSLeqt9lB+3LTsANjgQeoHVRG5lfhBXbz8sOaEsI7KmF7Lo/ZW2+f0peMblKC1p132DcmfXy78JM+l9rW8dmQ==;5:t+4iYIDr4SLHyJwA4Zj4CYWiR+IYwidI32MDEVYmQHr0FyB26hHxgWV3GlsIR7XGpqjVWjlIrIdc2YeeecolwJZMPJXLoWjKEETdNAExc1SmM/qjlvlXCMuDF3V7X8YQT+/H5F0nriM2qDaC/HOdguouhw3u6vCOvVgN4zHQp+8=;7:2X51NHMaUF/LIK6WiM39k0QUKbAVOnpmvcUEDQTYsEx6CN/AFYkl8GDqvhoAsOxEMa46lRQxSDSyasFSwFDz+Z5/GPZWOTVsqoVxBBsVIyE3DXrocoUiklPzbNIe7utCeyGfD0dN8Jurs3lOaUosejITpPmH2xPN06je3OVx1ldHvEPsB91jHHh9a9yHyTAHlAk985OEMT6iwJ5fEFj7z8hdABnW/Ble7nNTv7KGMsCNQRuYcd3KZHLC6I4cjB+j
x-ms-office365-filtering-correlation-id: e1f23a65-09f7-4d47-8dd1-08d6222cbc71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB0134677CC2FF9C80FB902389FB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(146099531331640)(268935105599563)(170618885588394)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(54534003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(575784001)(6116002)(8936002)(76176011)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(14444005)(11346002)(446003)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(551934003)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: QueKAa9CH1UhghiOimTEvYIUXo0uPfrRxnubCD58uDvWQA5Xx/cKDd4IpLvFeNLSTSRpkS/1aq11ejDLGgmXNRvcqOY3ImPgQlzDPD3YVt/Am6YhZaKTY7HzWnj8S05gYbUhtoY+m+weOgRyZPLRSmMwA0BD6PWp9teK3hLVUheIzbBQF2V3P7Qom6unoqMbrYPufqp102PlT+xRnATaqLi5VYkd9Az2aQ/i0txPA4SougW0RSJ241ScPfxYvU/f2HUGKqnlElkitwydA03Fdyur3f9DqlbFJKwAz/hJKDKWM327LHLhNTJaiir+wFw/ArqzQ2mL/lWVASD3sN4l24PTUwn3Sci1n6//nt058gU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f23a65-09f7-4d47-8dd1-08d6222cbc71
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:03.7583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
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
index 5304b8d6ceb8..1a22c0ecaf67 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4584,7 +4584,12 @@ int btrfs_shrink_device(struct btrfs_device *device,=
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
