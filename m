Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57462C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FB02077B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BBS78hUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FB02077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeIBRT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:19:58 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727827AbeIBRT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE9YC5po9N1Af35RlUtMsx+cSVLWQMqpmXM0rlTIe18=;
 b=BBS78hULzy/Zxp4Gu/GFnE5ly0biWYt50d1v3M4lx2YD2z8a+WGs+39STx7QjCJk+F8rcfJmQTqR7GRxwxm0aWu5EBDUlv04uUApYpmqVn4DMWD9tRF6+r/MLPPrq5ZhMtmScUsKD4AdKC+7tr8Sc/cS90yedy96UVet6bo/etw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:10 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:10 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 039/131] f2fs: Keep alloc_valid_block_count in
 sync
Thread-Topic: [PATCH AUTOSEL 4.18 039/131] f2fs: Keep alloc_valid_block_count
 in sync
Thread-Index: AQHUQr1jkxZSEgZBZUq2BO55ArNBIg==
Date:   Sun, 2 Sep 2018 13:03:49 +0000
Message-ID: <20180902064601.183036-39-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:l6Nhu2TbuvvQJVHAZrgqAXhBMOMIVl1wbJ6YUQcTdjmOe8vcRwQWy/ohF05qDqXjlcvAf6q/8Pja8CfGd6pP5gE/64BCcjLvZFNAy4bwwRBg3T7t+W0LcZ4R2FWZ/6E/sHwgijto2LaEu+JDHwkZSPfIT55D8dbOgKEsr7Sy/gNVZ1hh/eA4expMW54wLsrzW/UDfc4b6fe9fXlkFX2t/sX9HuuJ1MrzHssmeMJi/axKI5v61C/pNchG3246nD6oynfH8dUu4CPDaSiVM/sbpiazgL9l2ZPmCflLa+jsB9vloLg8vr9clEZzSRBUHdLnQDQJ2WfMp6atAmIt9q/tGzy+vWAMp+xIDLUFCO1Yg5VzCZ1Jk4z98hUb40ox5Mw1ofdpRLXQh0Od3jPa4LC0l3j+k3RyzqpfBlGYis1WC6B7ZTfcoOPQPM6suXyPddtolrOyvhGIPViYxcR3ErISAA==;5:klZ3p8XBceeWrBY07J514LZ2u5+curYx8Mpl48nWYAhIWa5hq+zHSZiNVv/0lfMsC1mgmA2q9oG5KtMU1/dCW3Lrr9/KY28XfoahJMjpHUQhCGt+zIAdaxOJNBh2o3YlNG59fIhhNpwIKnVIoeNgJRZfNPD574Ho7p7wtJh00lo=;7:YXmPsC2y4H+ObEvid6MKQaOKwcUfveXpVvwiPcN8pxwZTJ8Zmvffen0yuKivp4tgul5fd+sQasLrE0/zIsR+SAcm/tGNTT+xtOGQrjk5kOOXO+9eCf3JZXYGWjQAPOSbUGZmeryEHNRS6MCszRb0+B9nRm/wMohv8k7mmRoww6papx4wZF7yRHR2tVHG+r2+tj5kCZc3LNIFWTmha162lbr3XisbBbO2HuqtuGBtNf20X0zj/m2RDa28DR4ovXRm
x-ms-office365-filtering-correlation-id: abf3a909-0f6a-4d03-f7f9-08d610d492ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01351480915CC6AF2CF7ED71FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513)(211936372134217)(153496737603132);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nHKDRVvhN1HzVXtkOkxDeWBDimwRLRXDVRZZnUDofbZR5OKeAft4jurmKWu6fJXqeD7+/Y9NN9OX0c9mbq4W7vzj1QyE6b+K00/iLBiaT+Nn9BrBhIyOAVp5oRK0Pt3/RRZysTg+z1szXu99H/Y0N4Htpy/2k5BPOcz/d3uSK5xrTpJJwwR6sZroAiC590vxshwfjcVl96sRGRsRPaRb8LIyOkPOZagTkfrtmaN8CqYm62zDSQMYMwFksVRcjxPF9Z2GnaamZHUG7BZZyOUI3T9RK8DBnxKLDqjOQiYEenrHriqvRggJeNhG+DQMUUWVTsTgskfySxtZ2IYYWSR+KVc2zoIFg+DZo3n/wDXrhHw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf3a909-0f6a-4d03-f7f9-08d610d492ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:03:49.3791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Rosenberg <drosen@google.com>

[ Upstream commit 36b877af7992893b6d1ddbe96971cab5ab9e50eb ]

If we attempt to request more blocks than we have room for, we try to
instead request as much as we can, however, alloc_valid_block_count
is not decremented to match the new value, allowing it to drift higher
until the next checkpoint. This always decrements it when the requested
amount cannot be fulfilled.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 fs/f2fs/f2fs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 34af21f46f2c..03c07721da49 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1680,18 +1680,20 @@ static inline int inc_valid_block_count(struct f2fs=
_sb_info *sbi,
 		sbi->total_valid_block_count -=3D diff;
 		if (!*count) {
 			spin_unlock(&sbi->stat_lock);
-			percpu_counter_sub(&sbi->alloc_valid_block_count, diff);
 			goto enospc;
 		}
 	}
 	spin_unlock(&sbi->stat_lock);
=20
-	if (unlikely(release))
+	if (unlikely(release)) {
+		percpu_counter_sub(&sbi->alloc_valid_block_count, release);
 		dquot_release_reservation_block(inode, release);
+	}
 	f2fs_i_blocks_write(inode, *count, true, true);
 	return 0;
=20
 enospc:
+	percpu_counter_sub(&sbi->alloc_valid_block_count, release);
 	dquot_release_reservation_block(inode, release);
 	return -ENOSPC;
 }
--=20
2.17.1
