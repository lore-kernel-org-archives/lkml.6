Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01E7ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C32F20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GYsC/sOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C32F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeIOHCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:02:22 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:19456
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729047AbeIOGtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hfG7TrflFFfx1OyKwhxZn/dTbSoQXEG6CcIxblE9KQ=;
 b=GYsC/sOv9PD2K7vanLND4pO6mFIE4jZJ8tT9QUpTNZ4ooxjv6SkTrV6gNe7gUEnfp5DKWygHgHv6KgrrG+IMDiqYiYUP9zI6WWxazLtaeLfkOTOvftnqyTHouVa68BNDpmvW+v7BDtGKSB0MN8ahcKHtegnAC5AJ5rqoO63hJ34=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Sat, 15 Sep 2018 01:32:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:29 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ronny Chevalier <ronny.chevalier@hp.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 04/57] audit: fix use-after-free in
 audit_add_watch
Thread-Topic: [PATCH AUTOSEL 4.14 04/57] audit: fix use-after-free in
 audit_add_watch
Thread-Index: AQHUTJP3bAuiX1+/VE2du+dOKj9WEw==
Date:   Sat, 15 Sep 2018 01:32:29 +0000
Message-ID: <20180915013223.179909-4-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:+i8zMtJ2/o8mrWlyV4iETxYJlbbuwcbswbqV1Dtvg7n/G4ABt4ikojqo/WXwQDJalJaC+8lnvyyst8cRcMDyuPY45f61HkGJJr9YzUazXTqWknkrG3dhBnWAN4+0YsTWSJWX+oUEHVYV7UUj0ac1C3q2xh+BRCHn0PHlZfWSVzteMwqGJkQfvnByLox/lIt7JZbmQ9EALegiZcWNi0wUi/ZCSZYNP/LKfd3V/A83u13ABEhFlxsxHAO/2C3mSFY/OwpFQYnJI0gKabp30o7C5x1O/tAPXab8ktDB8v/Ckr/PYDBCxfOOuu2RfWItW3lOsSfUNIerW9FUNRHWhcABiOJfYV0iroS1B2DZyyBOO8W0cI0Xeg91T5Fzwn3QbiBCSTqygarX4DnrMkSJxivMQKOVX/5mxch6Z7PmOnmUW/0kzdfjcR+UU6K4Tbc1vg/RCQrbpfUzN3rw/MtW2dsWqA==;5:SqUiDBqsQU3ToYILLaqZYoHbhg8kioPtUHHvpk7fJ/OSuX9JzfhptcVBWjrU2fNsSbdF/x1UcIik/TtKPJGDdVOo1Eu+ZJq6xitCP/KSPXiSf7/raaFkS1EC1R7C+G3VTNJiEbDgT/wysXmDL79p2xtKewnprOMH7O0uASpc6P4=;7:dAzVkrON65GQCstl8RxbCMgSF+nMTYu7po9RIeWQfynBV+0+wcGqGV/mO+Cjq/7OF0y/hqpNDCCPwSzoDMbaPtcKDMsA5E28dZKKsyJ35X5DL1ysbCwQi2odWhV2OOp0I6uzVTxVWBQo6BISJj1X1R0/sqdq7xjBzWxER4ZvUDs5gwnD04Vg4gfyBH5KxnGZiklqjLR2yeZqmMLmCwsxPTRKq7l7ZkvO3EkxTle/LZGVavEFvapTyfNQ9ddO13lw
x-ms-office365-filtering-correlation-id: a7c5b653-78db-4891-a997-08d61aab1a10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0117E32A3770AD0108E0BDC1FB180@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(73583498263828);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(36756003)(316002)(2900100001)(110136005)(54906003)(8676002)(478600001)(5250100002)(2501003)(66066001)(72206003)(10090500001)(446003)(86612001)(476003)(2616005)(8936002)(102836004)(11346002)(486006)(14444005)(86362001)(256004)(575784001)(186003)(5024004)(6506007)(22452003)(68736007)(26005)(217873002)(305945005)(2906002)(6116002)(551544002)(3846002)(1076002)(106356001)(7736002)(5660300001)(105586002)(53936002)(14454004)(6436002)(81156014)(81166006)(6486002)(10290500003)(6512007)(99286004)(107886003)(76176011)(97736004)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: C9bxctvXJ/rWWFckCk/b7zthlN2+dZAU2VeNG1A1O0K9w/OBbUgbgfFzbMwhKO0Yu7g9NLLNSl+YJ0HwOGbWVabMI6bpZcLNdzY1asxYldB0LrHcn/fFDynNGkXohGaf8VHAaqtm5mimimG0zZhztV9wZc8c/uRzDlTRX1/cUw/4Tt/N9EWx8Gcn2kzGC73aO49GG6kLNg/8/wQflicY0E6RV3BS73YYZLvSyWEOVlNuyjo4HLoDOi0uJGTjdJiXBAfp+N8F8VhvbiGl6khEHzMGCrizLihospE35igKb4tcXyP/jWwSdSe/Pf+rdnF4TzngQT/tnt97JXGmlCl5t0EMzVmqCOsby7wd99dWMqQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c5b653-78db-4891-a997-08d61aab1a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:29.6502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronny Chevalier <ronny.chevalier@hp.com>

[ Upstream commit baa2a4fdd525c8c4b0f704d20457195b29437839 ]

audit_add_watch stores locally krule->watch without taking a reference
on watch. Then, it calls audit_add_to_parent, and uses the watch stored
locally.

Unfortunately, it is possible that audit_add_to_parent updates
krule->watch.
When it happens, it also drops a reference of watch which
could free the watch.

How to reproduce (with KASAN enabled):

    auditctl -w /etc/passwd -F success=3D0 -k test_passwd
    auditctl -w /etc/passwd -F success=3D1 -k test_passwd2

The second call to auditctl triggers the use-after-free, because
audit_to_parent updates krule->watch to use a previous existing watch
and drops the reference to the newly created watch.

To fix the issue, we grab a reference of watch and we release it at the
end of the function.

Signed-off-by: Ronny Chevalier <ronny.chevalier@hp.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/audit_watch.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 9eb8b3511636..4a98f6e314a9 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -419,6 +419,13 @@ int audit_add_watch(struct audit_krule *krule, struct =
list_head **list)
 	struct path parent_path;
 	int h, ret =3D 0;
=20
+	/*
+	 * When we will be calling audit_add_to_parent, krule->watch might have
+	 * been updated and watch might have been freed.
+	 * So we need to keep a reference of watch.
+	 */
+	audit_get_watch(watch);
+
 	mutex_unlock(&audit_filter_mutex);
=20
 	/* Avoid calling path_lookup under audit_filter_mutex. */
@@ -427,8 +434,10 @@ int audit_add_watch(struct audit_krule *krule, struct =
list_head **list)
 	/* caller expects mutex locked */
 	mutex_lock(&audit_filter_mutex);
=20
-	if (ret)
+	if (ret) {
+		audit_put_watch(watch);
 		return ret;
+	}
=20
 	/* either find an old parent or attach a new one */
 	parent =3D audit_find_parent(d_backing_inode(parent_path.dentry));
@@ -446,6 +455,7 @@ int audit_add_watch(struct audit_krule *krule, struct l=
ist_head **list)
 	*list =3D &audit_inode_hash[h];
 error:
 	path_put(&parent_path);
+	audit_put_watch(watch);
 	return ret;
 }
=20
--=20
2.17.1
