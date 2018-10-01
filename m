Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F433C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B342083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Uea7yS/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B342083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJAHNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:17 -0400
Received: from mail-eopbgr700117.outbound.protection.outlook.com ([40.107.70.117]:52496
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbeJAHNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kf1oUxhZzJp1w0o27Fhf1VxYw/S/GGLZ8TE6D/I3gg=;
 b=Uea7yS/FtuDqCC6ymROtH9uaNlx8W1oHsOoHL/4Rc5VrG/O4WRq3TxNW9UM+1Ym0G72cCSFMcBueVnGyxliNFVuWlYA6DcZMCCbsB7LPdAgVCnwdJ5wqy1ovyGr603YSICCQor7dHa/tmqk9B6U0gSz08vEh2zQ9KBxBy/LWpjQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:38:03 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:03 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 02/65] netfilter: xt_checksum: ignore gso skbs
Thread-Topic: [PATCH AUTOSEL 4.18 02/65] netfilter: xt_checksum: ignore gso
 skbs
Thread-Index: AQHUWR8Dxpc2GMiq+0yQGyF8LIKj0A==
Date:   Mon, 1 Oct 2018 00:38:03 +0000
Message-ID: <20181001003754.146961-2-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:SsdRlYOTCpjykh/qB7W/Rb/Kc1HASme+sSJSNo35VRn+EQLvEqtybtJ54ZtRvtGleCBH4VmVA+W1tik0fHAH8mw8zp3AboOy4FxECA5NVcrWjCsAhN5+fE80+hj5u5617we+khqPY6PG1Ag71BlpGrirhsuxZHZTHZO+4Bm/5ZjFncHVlGzQAHqdIu/yYDKfMKvzG3YMZk5G9kJTEZibGlg3YiNyNWua+BihIzsaViH8AlJgWWuqHzoBfIPxBnlDAibB71H6sFlvrFU58Qpi/KsCH9KvDTGe78c10rGPD2jS1zHCVVkCIQ+NjZgwsSThCAZR/CWCEAqMDgJ00Myb3wkbOdDZnvJvxxhnC/rdZHy+39Q/QtLbxzGNBoWgNa5wcDQoIToa+iAyWcty+Ne1ABN02zzYquTFolMRQFCaLNdOOcF0eq8A0aY8eLBz1quwsxwmEBoK/sJ7OWSq+WB00Q==;5:9IO+1f9OW1gHBQFRMhIEjlTCFOccvaVjMhm7wGm/kfmfR19e7RIqEo94CUDnWvo7ahU5ftuzRmHVxqzCvj5PfLCTPHEvNjL1X5bxlqZP9Tv1tBald0J1OT//upYG3ZD7c8fi/k/feGwpUDO0ZrTMB12xu9v6IcsJPdfxq9nq2+w=;7:aD9bFoDeG0NTb4vGOucGyt12J1reUIBk5ktLqmkHxVioKaedftu8UAscTI8nihnon0G0KDch0uGm5zlv7KIfk4c81IVfyHz+Om1P5UGwDcrPmQdECJseRw0CEFBAdISdtQF0lJwMwmEPp9l2QMvuiwszfy9eWy+vGv2k+HfgeZf/4CPt5Qtd312LOx8pGO2GRQh5EWR1R1Sj8SS7R/A7Zq5Qtho7HT5mrn+HaQm83PzwO2B4rAVKQBspag0Jdp9B
x-ms-office365-filtering-correlation-id: 536c313e-e920-4528-11b7-08d6273625a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB04697D314A330E93F84C1547FBEF0@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506)(278428928389397)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(5250100002)(106356001)(81166006)(14454004)(10290500003)(316002)(54906003)(22452003)(110136005)(25786009)(305945005)(2501003)(217873002)(256004)(72206003)(68736007)(14444005)(478600001)(6506007)(2906002)(7736002)(86612001)(575784001)(1076002)(86362001)(4326008)(99286004)(97736004)(3846002)(6116002)(76176011)(8936002)(81156014)(105586002)(8676002)(71200400001)(5660300001)(71190400001)(10090500001)(36756003)(6512007)(107886003)(2900100001)(102836004)(6486002)(6436002)(53936002)(11346002)(446003)(26005)(66066001)(2616005)(476003)(486006)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 78hdUZVYymg4J6Y0iRXUhuu+YGZuSfmr7Jdboy9WRtE3c1vv2m+U1+TzoFLPm2+z+SLR4DZy3lxHm7oS0OmK6ahyqXvVK0bewZB1GYcySFN/XAeSuENAwFTZPtCPSfHfl7g6YitY7nvJxZLj1h4UWy2au/oma9BVoTZqZ4roOG7KdJwNmCZ4V+eeDiV1y6C9Kr84E0mIo3FnEQWdH8QUJfOOquf8resWyg8/Glbq4f8SeuW5awi9d6pe4RRIKXf+jZ0SXnaSM5JLO/KarvPYhmLL1URd0Zvj8Als4r5DcHJf1E3Dq7Kh75sa0NYj0DsAbgjFWLlNXfrSZ6imLDAiU+QecJ04NgSagQ5OxNBvzew=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536c313e-e920-4528-11b7-08d6273625a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:03.1068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 10568f6c5761db24249c610c94d6e44d5505a0ba ]

Satish Patel reports a skb_warn_bad_offload() splat caused
by -j CHECKSUM rules:

-A POSTROUTING -p tcp -m tcp --sport 80 -j CHECKSUM

The CHECKSUM target has never worked with GSO skbs, and the above rule
makes no sense as kernel will handle checksum updates on transmit.

Unfortunately, there are 3rd party tools that install such rules, so we
cannot reject this from the config plane without potential breakage.

Amend Kconfig text to clarify that the CHECKSUM target is only useful
in virtualized environments, where old dhcp clients that use AF_PACKET
used to discard UDP packets with a 'bad' header checksum and add a
one-time warning in case such rule isn't restricted to UDP.

v2: check IP6T_F_PROTO flag before cmp (Michal Kubecek)

Reported-by: Satish Patel <satish.txt@gmail.com>
Reported-by: Markos Chandras <markos.chandras@suse.com>
Reported-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/netfilter/Kconfig       | 12 ++++++------
 net/netfilter/xt_CHECKSUM.c | 22 +++++++++++++++++++++-
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index f0a1c536ef15..e6d5c87f0d96 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -740,13 +740,13 @@ config NETFILTER_XT_TARGET_CHECKSUM
 	depends on NETFILTER_ADVANCED
 	---help---
 	  This option adds a `CHECKSUM' target, which can be used in the iptables=
 mangle
-	  table.
+	  table to work around buggy DHCP clients in virtualized environments.
=20
-	  You can use this target to compute and fill in the checksum in
-	  a packet that lacks a checksum.  This is particularly useful,
-	  if you need to work around old applications such as dhcp clients,
-	  that do not work well with checksum offloads, but don't want to disable
-	  checksum offload in your device.
+	  Some old DHCP clients drop packets because they are not aware
+	  that the checksum would normally be offloaded to hardware and
+	  thus should be considered valid.
+	  This target can be used to fill in the checksum using iptables
+	  when such packets are sent via a virtual network device.
=20
 	  To compile it as a module, choose M here.  If unsure, say N.
=20
diff --git a/net/netfilter/xt_CHECKSUM.c b/net/netfilter/xt_CHECKSUM.c
index 9f4151ec3e06..6c7aa6a0a0d2 100644
--- a/net/netfilter/xt_CHECKSUM.c
+++ b/net/netfilter/xt_CHECKSUM.c
@@ -16,6 +16,9 @@
 #include <linux/netfilter/x_tables.h>
 #include <linux/netfilter/xt_CHECKSUM.h>
=20
+#include <linux/netfilter_ipv4/ip_tables.h>
+#include <linux/netfilter_ipv6/ip6_tables.h>
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael S. Tsirkin <mst@redhat.com>");
 MODULE_DESCRIPTION("Xtables: checksum modification");
@@ -25,7 +28,7 @@ MODULE_ALIAS("ip6t_CHECKSUM");
 static unsigned int
 checksum_tg(struct sk_buff *skb, const struct xt_action_param *par)
 {
-	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL)
+	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL && !skb_is_gso(skb))
 		skb_checksum_help(skb);
=20
 	return XT_CONTINUE;
@@ -34,6 +37,8 @@ checksum_tg(struct sk_buff *skb, const struct xt_action_p=
aram *par)
 static int checksum_tg_check(const struct xt_tgchk_param *par)
 {
 	const struct xt_CHECKSUM_info *einfo =3D par->targinfo;
+	const struct ip6t_ip6 *i6 =3D par->entryinfo;
+	const struct ipt_ip *i4 =3D par->entryinfo;
=20
 	if (einfo->operation & ~XT_CHECKSUM_OP_FILL) {
 		pr_info_ratelimited("unsupported CHECKSUM operation %x\n",
@@ -43,6 +48,21 @@ static int checksum_tg_check(const struct xt_tgchk_param=
 *par)
 	if (!einfo->operation)
 		return -EINVAL;
=20
+	switch (par->family) {
+	case NFPROTO_IPV4:
+		if (i4->proto =3D=3D IPPROTO_UDP &&
+		    (i4->invflags & XT_INV_PROTO) =3D=3D 0)
+			return 0;
+		break;
+	case NFPROTO_IPV6:
+		if ((i6->flags & IP6T_F_PROTO) &&
+		    i6->proto =3D=3D IPPROTO_UDP &&
+		    (i6->invflags & XT_INV_PROTO) =3D=3D 0)
+			return 0;
+		break;
+	}
+
+	pr_warn_once("CHECKSUM should be avoided.  If really needed, restrict wit=
h \"-p udp\" and only use in OUTPUT\n");
 	return 0;
 }
=20
--=20
2.17.1
