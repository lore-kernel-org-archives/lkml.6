Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06204C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947E420C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EjM1touo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947E420C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbeIXUwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:22 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:30464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387890AbeIXUwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O3zNQ2mfeSz1Og1B+BXoUg/ynAc7+oSOlW1Ur8ov1I=;
 b=EjM1touoAcK/gO9KPjKBuBa5AV9nYr/N3WxjMI1l//vFhABo7GCUurs5jUuIVDxYD5q2xbhG3cAvKZ6jMV4cotwlxD23afswteVa6hkRqUPd/N/MQjaA0XWyyFpbJzgk5wapin5lkXhR7dOVDkS2hMGtNBn+v9MszBQrv7om2Vg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 13/36] net: hns: add the code for cleaning pkt in
 chip
Thread-Topic: [PATCH AUTOSEL 4.14 13/36] net: hns: add the code for cleaning
 pkt in chip
Thread-Index: AQHUVBW70KoqVcMC1UST510Wd8KqXg==
Date:   Mon, 24 Sep 2018 14:49:01 +0000
Message-ID: <20180924144851.164533-13-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:xB8zN6RqvG9Yiiv89MFm9BvYS5mCgaNB24qh772QSjDV/w6en0wromxI7TVyGKE8pM/a8TOaD1fCyHjTERmDyZ4T9kP4DPptIUaxI4YXkw7f7OI8oQ14upWqeZ5IgdXXwDp/VfT3vwptHGLICnITWB9qvGQlT1mHGhvNmNUqPGacvS91uzBPRU3aleLluEgh4fJPx9yHXzKDbm40eFdKevmZuNhuAW6e/c5sCgo3NXJTW9+1BuvvdjQQV0KR8ASJrsSj08qQW07HnxBFA3GYyx+jxE4aT0MGIYTZ24mtulPWKV7HvYvG1PlJUKVbQaRM+tGUJ6DnV3sqvvew1ymZiNh0FC+tR3mOQ5P/rHFKQDgCSMqc85VCAIA4zHdklQH4Ydtl0V5FuPwtvC43M0XpigrHpSQ1rsgh7B2+JQWBYM14auRIJY6X88LOnOxTc68wMkRijPdOTexXU2LBAOHseA==;5:spwYxjgU5skT98OGAhsQkRI7NIUegPd/R6DUdcUA5s2sVosvcyeeyNYM+q+ewjg7dGisH4pvnKQls/E5IrzWVqX548tPAtHRBI58ZwpSAd2cq+mbly3zXOJBz3acloabhlnXl3rajZJ8JlON8b/kW0sY9BppLR1O6MUUfIIGIVI=;7:6TcL2uttPbxZm14Fxb+8mEKDf8X+m2mL6R4ptGqm9kikKkQ3S2xWsvavpHq/WwZmSB7t2zY4mQZDdgnquq2YM1F9WAkophQ6bjwH210/A8d7z9c9pQzLrquron3fk9Dysnqih75jBNej03CIGIsyhzzAcO8RhWn/QQpRbMwD0JlTkzLMXhowYmQHhsTVaHDcJ61vtuKQWLYVq6IUZqcrMb5fgbQgctzhWls2lNL0e+HEZMf2Q2mHBk8LEohjBTeN
x-ms-office365-filtering-correlation-id: e1a35db3-21d7-4a9d-77ae-08d6222cf70a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181E67697A7BF2D113AEA7AFB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(575784001)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(53946003)(11346002)(446003)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zwWSAgPxGPWkGam/xd9gnF/HzfsR082R9trztDYHzx604eCCpfYI0GUDAC6zuHNdCIHVKuf5xlL0TiBkDP8+nTGSwwaWdOqDpW+Ot/a37VjTpRGgwqR6IkqVtIQxRt4p7FHf1w0dt1aQ2R8YAXXrb/dEdkZrYQVrizyUQFN4KGR9YisN0f0VshzZm7wLPsX6FNIKDPC2iuchDI1Mb+cpULkrMdmch22CcyIE9FoIWVVjNEbK+4VK0fZ+Ho1TDyMWHlZEz4tLcNBBqAqXYCdfMH/fG+PaX8rbWxE0/W5Q7VnL00NqcEzrlH3RMzdZa/wY8+01car5bG5p82caaBba/q5q2N/aVp1Haa9sRLQvGd4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a35db3-21d7-4a9d-77ae-08d6222cf70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:01.6330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

[ Upstream commit 31fabbee8f5c658c3fa1603c66e9e4f51ea8c2c6 ]

If there are packets in hardware when changing the speed
or duplex, it may cause hardware hang up.

This patch adds the code for waiting chip to clean the all
pkts(TX & RX) in chip when the driver uses the function named
"adjust link".

This patch cleans the pkts as follows:
1) close rx of chip, close tx of protocol stack.
2) wait rcb, ppe, mac to clean.
3) adjust link
4) open rx of chip, open tx of protocol stack.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns/hnae.h     |  2 +
 .../net/ethernet/hisilicon/hns/hns_ae_adapt.c | 67 ++++++++++++++++++-
 .../ethernet/hisilicon/hns/hns_dsaf_gmac.c    | 36 ++++++++++
 .../net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 44 ++++++++++++
 .../net/ethernet/hisilicon/hns/hns_dsaf_mac.h |  8 +++
 .../ethernet/hisilicon/hns/hns_dsaf_main.c    | 29 ++++++++
 .../ethernet/hisilicon/hns/hns_dsaf_main.h    |  3 +
 .../net/ethernet/hisilicon/hns/hns_dsaf_ppe.c | 23 +++++++
 .../net/ethernet/hisilicon/hns/hns_dsaf_ppe.h |  1 +
 .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.c | 23 +++++++
 .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.h |  1 +
 .../net/ethernet/hisilicon/hns/hns_dsaf_reg.h |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 21 +++++-
 13 files changed, 255 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethern=
et/hisilicon/hns/hnae.h
index fa5b30f547f6..427866b9564e 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -486,6 +486,8 @@ struct hnae_ae_ops {
 			u8 *auto_neg, u16 *speed, u8 *duplex);
 	void (*toggle_ring_irq)(struct hnae_ring *ring, u32 val);
 	void (*adjust_link)(struct hnae_handle *handle, int speed, int duplex);
+	bool (*need_adjust_link)(struct hnae_handle *handle,
+				 int speed, int duplex);
 	int (*set_loopback)(struct hnae_handle *handle,
 			    enum hnae_loop loop_mode, int en);
 	void (*get_ring_bdnum_limit)(struct hnae_queue *queue,
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c b/drivers/ne=
t/ethernet/hisilicon/hns/hns_ae_adapt.c
index bd68379d2bea..bf930ab3c2bd 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -155,6 +155,41 @@ static void hns_ae_put_handle(struct hnae_handle *hand=
le)
 		hns_ae_get_ring_pair(handle->qs[i])->used_by_vf =3D 0;
 }
=20
+static int hns_ae_wait_flow_down(struct hnae_handle *handle)
+{
+	struct dsaf_device *dsaf_dev;
+	struct hns_ppe_cb *ppe_cb;
+	struct hnae_vf_cb *vf_cb;
+	int ret;
+	int i;
+
+	for (i =3D 0; i < handle->q_num; i++) {
+		ret =3D hns_rcb_wait_tx_ring_clean(handle->qs[i]);
+		if (ret)
+			return ret;
+	}
+
+	ppe_cb =3D hns_get_ppe_cb(handle);
+	ret =3D hns_ppe_wait_tx_fifo_clean(ppe_cb);
+	if (ret)
+		return ret;
+
+	dsaf_dev =3D hns_ae_get_dsaf_dev(handle->dev);
+	if (!dsaf_dev)
+		return -EINVAL;
+	ret =3D hns_dsaf_wait_pkt_clean(dsaf_dev, handle->dport_id);
+	if (ret)
+		return ret;
+
+	vf_cb =3D hns_ae_get_vf_cb(handle);
+	ret =3D hns_mac_wait_fifo_clean(vf_cb->mac_cb);
+	if (ret)
+		return ret;
+
+	mdelay(10);
+	return 0;
+}
+
 static void hns_ae_ring_enable_all(struct hnae_handle *handle, int val)
 {
 	int q_num =3D handle->q_num;
@@ -399,12 +434,41 @@ static int hns_ae_get_mac_info(struct hnae_handle *ha=
ndle,
 	return hns_mac_get_port_info(mac_cb, auto_neg, speed, duplex);
 }
=20
+static bool hns_ae_need_adjust_link(struct hnae_handle *handle, int speed,
+				    int duplex)
+{
+	struct hns_mac_cb *mac_cb =3D hns_get_mac_cb(handle);
+
+	return hns_mac_need_adjust_link(mac_cb, speed, duplex);
+}
+
 static void hns_ae_adjust_link(struct hnae_handle *handle, int speed,
 			       int duplex)
 {
 	struct hns_mac_cb *mac_cb =3D hns_get_mac_cb(handle);
=20
-	hns_mac_adjust_link(mac_cb, speed, duplex);
+	switch (mac_cb->dsaf_dev->dsaf_ver) {
+	case AE_VERSION_1:
+		hns_mac_adjust_link(mac_cb, speed, duplex);
+		break;
+
+	case AE_VERSION_2:
+		/* chip need to clear all pkt inside */
+		hns_mac_disable(mac_cb, MAC_COMM_MODE_RX);
+		if (hns_ae_wait_flow_down(handle)) {
+			hns_mac_enable(mac_cb, MAC_COMM_MODE_RX);
+			break;
+		}
+
+		hns_mac_adjust_link(mac_cb, speed, duplex);
+		hns_mac_enable(mac_cb, MAC_COMM_MODE_RX);
+		break;
+
+	default:
+		break;
+	}
+
+	return;
 }
=20
 static void hns_ae_get_ring_bdnum_limit(struct hnae_queue *queue,
@@ -902,6 +966,7 @@ static struct hnae_ae_ops hns_dsaf_ops =3D {
 	.get_status =3D hns_ae_get_link_status,
 	.get_info =3D hns_ae_get_mac_info,
 	.adjust_link =3D hns_ae_adjust_link,
+	.need_adjust_link =3D hns_ae_need_adjust_link,
 	.set_loopback =3D hns_ae_config_loopback,
 	.get_ring_bdnum_limit =3D hns_ae_get_ring_bdnum_limit,
 	.get_pauseparam =3D hns_ae_get_pauseparam,
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c b/drivers/n=
et/ethernet/hisilicon/hns/hns_dsaf_gmac.c
index 74bd260ca02a..8c7bc5cf193c 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -257,6 +257,16 @@ static void hns_gmac_get_pausefrm_cfg(void *mac_drv, u=
32 *rx_pause_en,
 	*tx_pause_en =3D dsaf_get_bit(pause_en, GMAC_PAUSE_EN_TX_FDFC_B);
 }
=20
+static bool hns_gmac_need_adjust_link(void *mac_drv, enum mac_speed speed,
+				      int duplex)
+{
+	struct mac_driver *drv =3D (struct mac_driver *)mac_drv;
+	struct hns_mac_cb *mac_cb =3D drv->mac_cb;
+
+	return (mac_cb->speed !=3D speed) ||
+		(mac_cb->half_duplex =3D=3D duplex);
+}
+
 static int hns_gmac_adjust_link(void *mac_drv, enum mac_speed speed,
 				u32 full_duplex)
 {
@@ -309,6 +319,30 @@ static void hns_gmac_set_promisc(void *mac_drv, u8 en)
 		hns_gmac_set_uc_match(mac_drv, en);
 }
=20
+int hns_gmac_wait_fifo_clean(void *mac_drv)
+{
+	struct mac_driver *drv =3D (struct mac_driver *)mac_drv;
+	int wait_cnt;
+	u32 val;
+
+	wait_cnt =3D 0;
+	while (wait_cnt++ < HNS_MAX_WAIT_CNT) {
+		val =3D dsaf_read_dev(drv, GMAC_FIFO_STATE_REG);
+		/* bit5~bit0 is not send complete pkts */
+		if ((val & 0x3f) =3D=3D 0)
+			break;
+		usleep_range(100, 200);
+	}
+
+	if (wait_cnt >=3D HNS_MAX_WAIT_CNT) {
+		dev_err(drv->dev,
+			"hns ge %d fifo was not idle.\n", drv->mac_id);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static void hns_gmac_init(void *mac_drv)
 {
 	u32 port;
@@ -690,6 +724,7 @@ void *hns_gmac_config(struct hns_mac_cb *mac_cb, struct=
 mac_params *mac_param)
 	mac_drv->mac_disable =3D hns_gmac_disable;
 	mac_drv->mac_free =3D hns_gmac_free;
 	mac_drv->adjust_link =3D hns_gmac_adjust_link;
+	mac_drv->need_adjust_link =3D hns_gmac_need_adjust_link;
 	mac_drv->set_tx_auto_pause_frames =3D hns_gmac_set_tx_auto_pause_frames;
 	mac_drv->config_max_frame_length =3D hns_gmac_config_max_frame_length;
 	mac_drv->mac_pausefrm_cfg =3D hns_gmac_pause_frm_cfg;
@@ -717,6 +752,7 @@ void *hns_gmac_config(struct hns_mac_cb *mac_cb, struct=
 mac_params *mac_param)
 	mac_drv->get_strings =3D hns_gmac_get_strings;
 	mac_drv->update_stats =3D hns_gmac_update_stats;
 	mac_drv->set_promiscuous =3D hns_gmac_set_promisc;
+	mac_drv->wait_fifo_clean =3D hns_gmac_wait_fifo_clean;
=20
 	return (void *)mac_drv;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/ne=
t/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 8b5cdf490850..5a8dbd72fe45 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -114,6 +114,26 @@ int hns_mac_get_port_info(struct hns_mac_cb *mac_cb,
 	return 0;
 }
=20
+/**
+ *hns_mac_is_adjust_link - check is need change mac speed and duplex regis=
ter
+ *@mac_cb: mac device
+ *@speed: phy device speed
+ *@duplex:phy device duplex
+ *
+ */
+bool hns_mac_need_adjust_link(struct hns_mac_cb *mac_cb, int speed, int du=
plex)
+{
+	struct mac_driver *mac_ctrl_drv;
+
+	mac_ctrl_drv =3D (struct mac_driver *)(mac_cb->priv.mac);
+
+	if (mac_ctrl_drv->need_adjust_link)
+		return mac_ctrl_drv->need_adjust_link(mac_ctrl_drv,
+			(enum mac_speed)speed, duplex);
+	else
+		return true;
+}
+
 void hns_mac_adjust_link(struct hns_mac_cb *mac_cb, int speed, int duplex)
 {
 	int ret;
@@ -432,6 +452,16 @@ int hns_mac_vm_config_bc_en(struct hns_mac_cb *mac_cb,=
 u32 vmid, bool enable)
 	return 0;
 }
=20
+int hns_mac_wait_fifo_clean(struct hns_mac_cb *mac_cb)
+{
+	struct mac_driver *drv =3D hns_mac_get_drv(mac_cb);
+
+	if (drv->wait_fifo_clean)
+		return drv->wait_fifo_clean(drv);
+
+	return 0;
+}
+
 void hns_mac_reset(struct hns_mac_cb *mac_cb)
 {
 	struct mac_driver *drv =3D hns_mac_get_drv(mac_cb);
@@ -1001,6 +1031,20 @@ static int hns_mac_get_max_port_num(struct dsaf_devi=
ce *dsaf_dev)
 		return  DSAF_MAX_PORT_NUM;
 }
=20
+void hns_mac_enable(struct hns_mac_cb *mac_cb, enum mac_commom_mode mode)
+{
+	struct mac_driver *mac_ctrl_drv =3D hns_mac_get_drv(mac_cb);
+
+	mac_ctrl_drv->mac_enable(mac_cb->priv.mac, mode);
+}
+
+void hns_mac_disable(struct hns_mac_cb *mac_cb, enum mac_commom_mode mode)
+{
+	struct mac_driver *mac_ctrl_drv =3D hns_mac_get_drv(mac_cb);
+
+	mac_ctrl_drv->mac_disable(mac_cb->priv.mac, mode);
+}
+
 /**
  * hns_mac_init - init mac
  * @dsaf_dev: dsa fabric device struct pointer
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h b/drivers/ne=
t/ethernet/hisilicon/hns/hns_dsaf_mac.h
index bbc0a98e7ca3..fbc75341bef7 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
@@ -356,6 +356,9 @@ struct mac_driver {
 	/*adjust mac mode of port,include speed and duplex*/
 	int (*adjust_link)(void *mac_drv, enum mac_speed speed,
 			   u32 full_duplex);
+	/* need adjust link */
+	bool (*need_adjust_link)(void *mac_drv, enum mac_speed speed,
+				 int duplex);
 	/* config autoegotaite mode of port*/
 	void (*set_an_mode)(void *mac_drv, u8 enable);
 	/* config loopbank mode */
@@ -394,6 +397,7 @@ struct mac_driver {
 	void (*get_info)(void *mac_drv, struct mac_info *mac_info);
=20
 	void (*update_stats)(void *mac_drv);
+	int (*wait_fifo_clean)(void *mac_drv);
=20
 	enum mac_mode mac_mode;
 	u8 mac_id;
@@ -427,6 +431,7 @@ void *hns_xgmac_config(struct hns_mac_cb *mac_cb,
=20
 int hns_mac_init(struct dsaf_device *dsaf_dev);
 void mac_adjust_link(struct net_device *net_dev);
+bool hns_mac_need_adjust_link(struct hns_mac_cb *mac_cb, int speed, int du=
plex);
 void hns_mac_get_link_status(struct hns_mac_cb *mac_cb,	u32 *link_status);
 int hns_mac_change_vf_addr(struct hns_mac_cb *mac_cb, u32 vmid, char *addr=
);
 int hns_mac_set_multi(struct hns_mac_cb *mac_cb,
@@ -463,5 +468,8 @@ int hns_mac_add_uc_addr(struct hns_mac_cb *mac_cb, u8 v=
f_id,
 int hns_mac_rm_uc_addr(struct hns_mac_cb *mac_cb, u8 vf_id,
 		       const unsigned char *addr);
 int hns_mac_clr_multicast(struct hns_mac_cb *mac_cb, int vfn);
+void hns_mac_enable(struct hns_mac_cb *mac_cb, enum mac_commom_mode mode);
+void hns_mac_disable(struct hns_mac_cb *mac_cb, enum mac_commom_mode mode)=
;
+int hns_mac_wait_fifo_clean(struct hns_mac_cb *mac_cb);
=20
 #endif /* _HNS_DSAF_MAC_H */
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/n=
et/ethernet/hisilicon/hns/hns_dsaf_main.c
index e0bc79ea3d88..1f056a6b167e 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2720,6 +2720,35 @@ void hns_dsaf_set_promisc_tcam(struct dsaf_device *d=
saf_dev,
 	soft_mac_entry->index =3D enable ? entry_index : DSAF_INVALID_ENTRY_IDX;
 }
=20
+int hns_dsaf_wait_pkt_clean(struct dsaf_device *dsaf_dev, int port)
+{
+	u32 val, val_tmp;
+	int wait_cnt;
+
+	if (port >=3D DSAF_SERVICE_NW_NUM)
+		return 0;
+
+	wait_cnt =3D 0;
+	while (wait_cnt++ < HNS_MAX_WAIT_CNT) {
+		val =3D dsaf_read_dev(dsaf_dev, DSAF_VOQ_IN_PKT_NUM_0_REG +
+			(port + DSAF_XGE_NUM) * 0x40);
+		val_tmp =3D dsaf_read_dev(dsaf_dev, DSAF_VOQ_OUT_PKT_NUM_0_REG +
+			(port + DSAF_XGE_NUM) * 0x40);
+		if (val =3D=3D val_tmp)
+			break;
+
+		usleep_range(100, 200);
+	}
+
+	if (wait_cnt >=3D HNS_MAX_WAIT_CNT) {
+		dev_err(dsaf_dev->dev, "hns dsaf clean wait timeout(%u - %u).\n",
+			val, val_tmp);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  * dsaf_probe - probo dsaf dev
  * @pdev: dasf platform device
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h b/drivers/n=
et/ethernet/hisilicon/hns/hns_dsaf_main.h
index 4507e8222683..0e1cd99831a6 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
@@ -44,6 +44,8 @@ struct hns_mac_cb;
 #define DSAF_ROCE_CREDIT_CHN	8
 #define DSAF_ROCE_CHAN_MODE	3
=20
+#define HNS_MAX_WAIT_CNT 10000
+
 enum dsaf_roce_port_mode {
 	DSAF_ROCE_6PORT_MODE,
 	DSAF_ROCE_4PORT_MODE,
@@ -463,5 +465,6 @@ int hns_dsaf_rm_mac_addr(
=20
 int hns_dsaf_clr_mac_mc_port(struct dsaf_device *dsaf_dev,
 			     u8 mac_id, u8 port_num);
+int hns_dsaf_wait_pkt_clean(struct dsaf_device *dsaf_dev, int port);
=20
 #endif /* __HNS_DSAF_MAIN_H__ */
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c b/drivers/ne=
t/ethernet/hisilicon/hns/hns_dsaf_ppe.c
index 93e71e27401b..a19932aeb9d7 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -274,6 +274,29 @@ static void hns_ppe_exc_irq_en(struct hns_ppe_cb *ppe_=
cb, int en)
 	dsaf_write_dev(ppe_cb, PPE_INTEN_REG, msk_vlue & vld_msk);
 }
=20
+int hns_ppe_wait_tx_fifo_clean(struct hns_ppe_cb *ppe_cb)
+{
+	int wait_cnt;
+	u32 val;
+
+	wait_cnt =3D 0;
+	while (wait_cnt++ < HNS_MAX_WAIT_CNT) {
+		val =3D dsaf_read_dev(ppe_cb, PPE_CURR_TX_FIFO0_REG) & 0x3ffU;
+		if (!val)
+			break;
+
+		usleep_range(100, 200);
+	}
+
+	if (wait_cnt >=3D HNS_MAX_WAIT_CNT) {
+		dev_err(ppe_cb->dev, "hns ppe tx fifo clean wait timeout, still has %u p=
kt.\n",
+			val);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  * ppe_init_hw - init ppe
  * @ppe_cb: ppe device
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h b/drivers/ne=
t/ethernet/hisilicon/hns/hns_dsaf_ppe.h
index 9d8e643e8aa6..f670e63a5a01 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
@@ -100,6 +100,7 @@ struct ppe_common_cb {
=20
 };
=20
+int hns_ppe_wait_tx_fifo_clean(struct hns_ppe_cb *ppe_cb);
 int hns_ppe_init(struct dsaf_device *dsaf_dev);
=20
 void hns_ppe_uninit(struct dsaf_device *dsaf_dev);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/ne=
t/ethernet/hisilicon/hns/hns_dsaf_rcb.c
index e2e28532e4dc..1e43d7a3ca86 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -66,6 +66,29 @@ void hns_rcb_wait_fbd_clean(struct hnae_queue **qs, int =
q_num, u32 flag)
 			"queue(%d) wait fbd(%d) clean fail!!\n", i, fbd_num);
 }
=20
+int hns_rcb_wait_tx_ring_clean(struct hnae_queue *qs)
+{
+	u32 head, tail;
+	int wait_cnt;
+
+	tail =3D dsaf_read_dev(&qs->tx_ring, RCB_REG_TAIL);
+	wait_cnt =3D 0;
+	while (wait_cnt++ < HNS_MAX_WAIT_CNT) {
+		head =3D dsaf_read_dev(&qs->tx_ring, RCB_REG_HEAD);
+		if (tail =3D=3D head)
+			break;
+
+		usleep_range(100, 200);
+	}
+
+	if (wait_cnt >=3D HNS_MAX_WAIT_CNT) {
+		dev_err(qs->dev->dev, "rcb wait timeout, head not equal to tail.\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  *hns_rcb_reset_ring_hw - ring reset
  *@q: ring struct pointer
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h b/drivers/ne=
t/ethernet/hisilicon/hns/hns_dsaf_rcb.h
index 602816498c8d..2319b772a271 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
@@ -136,6 +136,7 @@ void hns_rcbv2_int_clr_hw(struct hnae_queue *q, u32 fla=
g);
 void hns_rcb_init_hw(struct ring_pair_cb *ring);
 void hns_rcb_reset_ring_hw(struct hnae_queue *q);
 void hns_rcb_wait_fbd_clean(struct hnae_queue **qs, int q_num, u32 flag);
+int hns_rcb_wait_tx_ring_clean(struct hnae_queue *qs);
 u32 hns_rcb_get_rx_coalesced_frames(
 	struct rcb_common_cb *rcb_common, u32 port_idx);
 u32 hns_rcb_get_tx_coalesced_frames(
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h b/drivers/ne=
t/ethernet/hisilicon/hns/hns_dsaf_reg.h
index 46a52d9bb196..6d20e4eb7402 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
@@ -464,6 +464,7 @@
 #define RCB_RING_INTMSK_TX_OVERTIME_REG		0x000C4
 #define RCB_RING_INTSTS_TX_OVERTIME_REG		0x000C8
=20
+#define GMAC_FIFO_STATE_REG			0x0000UL
 #define GMAC_DUPLEX_TYPE_REG			0x0008UL
 #define GMAC_FD_FC_TYPE_REG			0x000CUL
 #define GMAC_TX_WATER_LINE_REG			0x0010UL
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/et=
hernet/hisilicon/hns/hns_enet.c
index e77192683dba..e3945fd1bc0e 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1212,11 +1212,26 @@ static void hns_nic_adjust_link(struct net_device *=
ndev)
 	struct hnae_handle *h =3D priv->ae_handle;
 	int state =3D 1;
=20
+	/* If there is no phy, do not need adjust link */
 	if (ndev->phydev) {
-		h->dev->ops->adjust_link(h, ndev->phydev->speed,
-					 ndev->phydev->duplex);
-		state =3D ndev->phydev->link;
+		/* When phy link down, do nothing */
+		if (ndev->phydev->link =3D=3D 0)
+			return;
+
+		if (h->dev->ops->need_adjust_link(h, ndev->phydev->speed,
+						  ndev->phydev->duplex)) {
+			/* because Hi161X chip don't support to change gmac
+			 * speed and duplex with traffic. Delay 200ms to
+			 * make sure there is no more data in chip FIFO.
+			 */
+			netif_carrier_off(ndev);
+			msleep(200);
+			h->dev->ops->adjust_link(h, ndev->phydev->speed,
+						 ndev->phydev->duplex);
+			netif_carrier_on(ndev);
+		}
 	}
+
 	state =3D state && h->dev->ops->get_status(h);
=20
 	if (state !=3D priv->link) {
--=20
2.17.1
