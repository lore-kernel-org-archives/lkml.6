Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4295BECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DA821476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c4NV//uG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DA821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeIOGwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:30 -0400
Received: from mail-sn1nam01on0126.outbound.protection.outlook.com ([104.47.32.126]:8380
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729501AbeIOGw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHXwuLtyd/G0oAOE4itVdpnjGK126AZmR86+k9ZbmUo=;
 b=c4NV//uGKa7luzAgX+I3W2UbHN1kpbNiw54hDl4BRYThgZ2HKvuN11oqinoZ30Zlslg1NvMvclUIjtV1/3GGZvj/vP4YseCRopG775hY6ciwh4zdTGj6XK1hGbs1YHOtUS8xCYktfF38LgeJA8SzcVUohvBvAXUB0/F4B6zCtpo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:35:25 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:25 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ronny Chevalier <ronny.chevalier@hp.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 02/11] audit: fix use-after-free in
 audit_add_watch
Thread-Topic: [PATCH AUTOSEL 3.18 02/11] audit: fix use-after-free in
 audit_add_watch
Thread-Index: AQHUTJRgXMk7VND2KEKRDSBYz6aNlQ==
Date:   Sat, 15 Sep 2018 01:35:25 +0000
Message-ID: <20180915013521.180178-2-alexander.levin@microsoft.com>
References: <20180915013521.180178-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013521.180178-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:/QsFB8V1VXQ4csfo5wyOGKEe1s11h2rk42uKOPZ8HZOXtIqWNRoYOjtmqLa5z3JuSSx1ug0Ee8PWfd1bC88eh+IQgj+p/ZrAkG+5yuCgWqlRlFJXI6plvVbrhTMOsQ6r8ONKDHtwgDTav2qI8Aey1BCA9Nvu/lylM5PeVF4CxiOMzL10i6jMa+kwxMxCRZIfXs/9cYtHGQKwkdjNkyiE4Uleu5ezcpD2b6ItUWxhYMUMnC8KgQFi+GFgqyXXu3a15L4hmBMMMqs6yVWzAK/uGJkqQeRQxg0JnGUZBzpQx5kOqiP51rmNd/qO+HpR+jHMu7QrlFP9IxX77ErTItvmbUr011YwqpS9KKrBVuDLZL1SZ6+ECL6oIpZ7IdecO3+2hIg3rdm4jllw/L1+/1jp9fdfR3WV93UibuTkLhN8JTNaKDS3vFLk3ylNrT5LGA0DB4R5oySsDlJyI5GRzLKISQ==;5:zQvohWHCMyFCzp6MPglulQv5AC0HItqrVYb56NjseZCkP6ok3EWxYOdDGX09mwc1m0wkVx98tkgmbiT6kHgTVQktxSXaD1GiuwMSME2tBv8+RsTXPuV1G4rBATx/BBgMKLno9edAxkZUV7+bK2ukoXg1TaLhyOAEGS/IOQUSkYA=;7:rUO8FaOiAPwcyr5wfPAZYa/6IKeKpnPu5OvDit7srJtVahBsNFxyjsNRsSpAbiGz1/NN6ck3U9iBu5gmXOLzQwKC3JughUNRqjj8S21wWMVLLEOoKZWjUQ8DynfuPZwYZf7TF858T9flPmYVLsBW//854nNDDBAjTuvi/A/OsaHxqJWkoMkRsAcRp8+0RkHCbz5JArPx61ZejS2mqbH11OtjdQx3DuBf8zA8JhjF+KiPocnGl2iyfY1iRpI9nxar
x-ms-office365-filtering-correlation-id: b2b89920-32b0-4e89-d9e5-08d61aab82f4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB0280151F38FA631403396B61FB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(73583498263828);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(107886003)(72206003)(14444005)(256004)(5024004)(217873002)(478600001)(5660300001)(6512007)(5250100002)(2501003)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(551544002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(575784001)(86362001)(8936002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: uM6VfUUHkP8eauci6ETQEHObEEX9ew/0XdIASngeci0q1mDKqBJG88a52ZA2+1SffL6cvE1tyW9qH36UxGyIG8Wn3GRVadCzDsdXI0ngATNa54u6rjK/WvD/EZp+lCbL0QBJHrUOAiJ1FZSTUQe9moH3dZfSsaO6U5vEg4flA0vUwooJRMOgCMLeNUv1ZyPCaM5r/2NPGvsM5NIJEudxAReugEUpqmBBALqSOVAVmgXBU1w5D4HCt+Os0mynjeMj5JVISFkZQulbn/sKrWE/bgAynx35fmGkc2o5GWPVFutVB2Ak2VTjqE+jry8YAFs9u/23IR85i1+764oimg3qn/tg2ZxTBpResmrvePeU0cY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b89920-32b0-4e89-d9e5-08d61aab82f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:25.6755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
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
index d39e6e3f1e0a..23484712654e 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -414,6 +414,13 @@ int audit_add_watch(struct audit_krule *krule, struct =
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
@@ -422,8 +429,10 @@ int audit_add_watch(struct audit_krule *krule, struct =
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
 	parent =3D audit_find_parent(parent_path.dentry->d_inode);
@@ -444,6 +453,7 @@ int audit_add_watch(struct audit_krule *krule, struct l=
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
