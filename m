Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B05ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DB8208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="o277o8JL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DB8208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeIQI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:27:19 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:29664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729222AbeIQI1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeqyUx5ZPK69Q9Z/wAuQXnIAHCq21uyqDY0B9MGbr8s=;
 b=o277o8JLuRD6J4SZ2SDdmx+HNTG8hdkr+D+OTeqCKlSPYdP2AbVVkhMIpfLQGRjosHA4ISd+/gY2DdneaNd5lRMT4F3y6hlpJzFL34WzMNfFSoD+V99KzsPBPYgOjwyXiGq+ecNVRVt/75OH9QxbMWgMijyNdGEMxk2E6rTQk2U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:55 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:55 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Petr Machata <petrm@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 069/136] selftests: forwarding: Tweak tc filters
 for mirror-to-gretap tests
Thread-Topic: [PATCH AUTOSEL 4.18 069/136] selftests: forwarding: Tweak tc
 filters for mirror-to-gretap tests
Thread-Index: AQHUTjKm2Tr97R7CdUykLN/BQliF4A==
Date:   Mon, 17 Sep 2018 03:00:55 +0000
Message-ID: <20180917030006.245495-69-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:ZTLmFE3RxFUuLIOKBi06585pCl7lUzLU7UBvUnW5V9CSPl6/GZ4AxNOlTJfIaW6FArflaZhxffH+zoCvysUtqiPHpTjVWBBYFnNj+f7FyFa3uuX3knNCff4/fNtmismV6WQq7ijl6DMUr/Nykf2kDSn51P4Xpj+PINs067yck4mBDqEQcQ1IxjgVceR7QJmP2W9kfV9s9XnI0nRM/GSCXnLiWMoqMkFirjc5kko6PPy/l8NPXdRcO2el2n2RitVcHkD7omJwE8YRRMAc8BMzaMJniQ6HLWbQfnCa6WNimfhtjxyHKCv7JruelSVBTE7sVpbXyx5r4LYpkLO3dyIVxINuj9X9t79un4TRetwNtJFm5Ij6VFqOO80SpW6IAdkrJmw7pcnXj1+JmmnNyJMrMxkt5600MTKfvNXYFQeO2bsS0UrO7h3D8wXNHg/XrNrNkmcP9CZqakS9B/fhtW+flw==;5:xSJubQBlDxWzOiGAjNQ08KDMxBRSVgOdgNkOSQbs++M93PyLmYfS1OgDpflwPyhLC3GgVWNQqXYbSBu1jmSycDDcWYUy8U/lp3QjfwpJRAaCRA9LellB/YifplMZewMtBxh4at9nBNJB5ayMZKgOBXIWRdMFUPgHQk8exNARit0=;7:QyJo4R9IbBb9NyIcAjnR2tkh+KyR9iLYa73dRdimE33xIL1Zc5vdrOCcD1BSFVjjNo1vWZ6djahbvM5WOACRHzuXAbwRaFQmzKAgU6hLbgXByu2YR9xSYKimUBiFA5dxEJPVQeZtbvtIX43ktikrI9ii2pF8ffDBPqIm72kwydBBzY2yh19kcT2m61M0dBGBMBm/eL5Npar0JxTB6wv2td8EtgJ+N+vhNHrAL9mTFoxHWRxtaOLmJzefSOfI/0t/
x-ms-office365-filtering-correlation-id: a3eb5f31-d26a-4473-5017-08d61c49ed1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB050234172B4F39966903E7C6FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(575784001)(1076002)(6116002)(3846002)(10290500003)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cSd5k7Xg4ZOzo7fmBFZqRWWYMw/RAOGVErqIKwvHvgtecXHSTc2f8GWozPrEVKXakKAUuAz5Ow0yA/7MmLWK/9g403E+cKZ2l3ZHys3dYmgp4qUuPr1kwbrHs7v5Nm5LunYOI/J4P3PuI+IoCak/YDhF0ixPEmzMUmeT87Jtol3alOZYC38c7fXEblr2WAf6qheVABIhJHYVJR8wue7zjwBvHSnTGIyLZtyGTe1mX+Q9k/vUj4T2uo3gYgZTBX7FNFZ3LEYl7fHI6EU0dyebZaj7/+JhwCvkg3OXNS93Fz2MHRnDGGbRFjLO/jR4YN7XOBU8D5Bic25CDObLkpo3GVArDdtm6BYCn68Ig++Tnbk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eb5f31-d26a-4473-5017-08d61c49ed1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:55.3231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit ec9fdc99f5a6a2cfe4061e807fcb0cc1129f0a2d ]

When running mirror_gre_bridge_1d_vlan tests on veth, several issues
cause spurious failures:

- vlan_ethtype should be ip, not ipv6 even in mirror-to-ip6gretap case,
  because the overlay packet is still IPv4.
- Similarly ip_proto matches the innermost IP protocol, so can't be used
  to filter out GRE packet. Drop the corresponding condition.
- Because the above fixes the filters to match in slow path as well,
  they need to be made skip_hw so as not to double-count packets.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh   | 6 ++++--
 tools/testing/selftests/net/forwarding/mirror_gre_lib.sh    | 2 +-
 .../selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh   | 6 ++++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vl=
an.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh
index 3bb4c2ba7b14..197e769c2ed1 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh
@@ -74,12 +74,14 @@ test_vlan_match()
=20
 test_gretap()
 {
-	test_vlan_match gt4 'vlan_id 555 vlan_ethtype ip' "mirror to gretap"
+	test_vlan_match gt4 'skip_hw vlan_id 555 vlan_ethtype ip' \
+			"mirror to gretap"
 }
=20
 test_ip6gretap()
 {
-	test_vlan_match gt6 'vlan_id 555 vlan_ethtype ipv6' "mirror to ip6gretap"
+	test_vlan_match gt6 'skip_hw vlan_id 555 vlan_ethtype ip' \
+			"mirror to ip6gretap"
 }
=20
 test_gretap_stp()
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh b/too=
ls/testing/selftests/net/forwarding/mirror_gre_lib.sh
index 619b469365be..1c18e332cd4f 100644
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
@@ -62,7 +62,7 @@ full_test_span_gre_dir_vlan_ips()
 			  "$backward_type" "$ip1" "$ip2"
=20
 	tc filter add dev $h3 ingress pref 77 prot 802.1q \
-		flower $vlan_match ip_proto 0x2f \
+		flower $vlan_match \
 		action pass
 	mirror_test v$h1 $ip1 $ip2 $h3 77 10
 	tc filter del dev $h3 ingress pref 77
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_=
1q.sh b/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
index 5dbc7a08f4bd..a12274776116 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
@@ -79,12 +79,14 @@ test_vlan_match()
=20
 test_gretap()
 {
-	test_vlan_match gt4 'vlan_id 555 vlan_ethtype ip' "mirror to gretap"
+	test_vlan_match gt4 'skip_hw vlan_id 555 vlan_ethtype ip' \
+			"mirror to gretap"
 }
=20
 test_ip6gretap()
 {
-	test_vlan_match gt6 'vlan_id 555 vlan_ethtype ipv6' "mirror to ip6gretap"
+	test_vlan_match gt6 'skip_hw vlan_id 555 vlan_ethtype ip' \
+			"mirror to ip6gretap"
 }
=20
 test_span_gre_forbidden_cpu()
--=20
2.17.1
