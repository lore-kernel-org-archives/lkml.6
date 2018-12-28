Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B7FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548C62146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rko5Hb5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeL1DwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 22:52:05 -0500
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:20515
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbeL1DwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 22:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCAD4LXS9tgEyWqSqelT84ibXQYXhYCERkLEk+GkSyQ=;
 b=rko5Hb5B6HoLW5Q3wTk0+0UFV0gmQgV5gXnRkjVfKfu3jcWrdJWUarr9n7RNmJ1NlLf0uE+Vdx/PCIYeQqnNu5WdQSB3rcWIi79sUROxtaQwin3NVwCeWhdGI1eMFb35q49fzOzWI/A+ZKBYK1kh6gEekZ4TQN9Ygo0BgV8jdEM=
Received: from VI1PR04MB5135.eurprd04.prod.outlook.com (20.177.50.160) by
 VI1PR04MB5968.eurprd04.prod.outlook.com (20.178.123.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 28 Dec 2018 03:49:40 +0000
Received: from VI1PR04MB5135.eurprd04.prod.outlook.com
 ([fe80::8483:4806:c363:3c21]) by VI1PR04MB5135.eurprd04.prod.outlook.com
 ([fe80::8483:4806:c363:3c21%3]) with mapi id 15.20.1471.019; Fri, 28 Dec 2018
 03:49:40 +0000
From:   PO LIU <po.liu@nxp.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "haustad@cisco.com" <haustad@cisco.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        PO LIU <po.liu@nxp.com>, PO LIU <po.liu@nxp.com>
Subject: [PATCH] net: tsn: add an netlink interface between kernel and
 application layer
Thread-Topic: [PATCH] net: tsn: add an netlink interface between kernel and
 application layer
Thread-Index: AQHUnl7Q0OQhsXkvlE2k4BYXbHWC16WTgwIAgAAAzoA=
Date:   Fri, 28 Dec 2018 03:49:40 +0000
Message-ID: <1545968945-7290-1-git-send-email-Po.Liu@nxp.com>
References: <1545968772-7237-1-git-send-email-Po.Liu@nxp.com>
In-Reply-To: <1545968772-7237-1-git-send-email-Po.Liu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.8.3.1
x-clientproxiedby: HK2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:202:2e::19) To VI1PR04MB5135.eurprd04.prod.outlook.com
 (2603:10a6:803:5a::32)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=po.liu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5968;6:kNvhF1ILxPmCi+KJjJxq9Af6OmuUuXMILZUaZh2K8Y9YkhbNM6VS3nj4F2I2OM/NV16NwaenWtE8a9HAqb4CPMN5Hy2SLf21DpvU+vATnoa6DYHDyvfdlBOFH8wHYcR7VnL7TPozWWhDCn0IDa1yErC58iVMZEmn/uoF6j3/yFLNgJHyF122bgmY3WAtNhGdBmzK1jdIOEHq3r9VrhRlCipuXMlPLCe5kmRheU+qzW8Ws9dw1pnIsVqiH236f25UcHM/lFmf00vvND6yyDQ0p3hFkN7QS9AzkdJFeZX9K3/h6AQBA/3vNJSxkon2XrD7CrXQa7+JiVtkBSeEVu25JXPAWQVgTnzCH85HazzGtJCi8w6+V04NndSl6bEldhSrOmTOYH+6leHiypyymnQAMddDquax6f6c7Z1AQdTmxQJ93FlG+tfzbXqfU4SEq1h7VeOw4ae7XoY+75OnTlJs2Q==;5:wsI4b3bqTA6C7ZSxK1vE9bIBf/EekGw8mi/lZvbm80Z+e5k6w7AWZi2SmKNy6x1dowqrKxkIc6MAMAwXNU794IHBLXEF7V4oBNfiXvEhcGWD7ExZNsYDJLZwyUwqBLHkvXA14OPrlcvTodZdfLBJL1NWktPFppzZBCz7HSJCHgs=;7:G+SDXeLjuea59ZpDgL6X2ykGGeDnocNEepYuNePejg+9LfRij4vVLQ7XS04Xr8xKDtHnlPqJWvxgtkMr5jmtef3lqcCGVfit6Np44wD5/H4izTHe3OlEfLYlNBwHCLQbOXILnmTjQ9YqnJ/EkaEQjg==
x-ms-office365-filtering-correlation-id: 44cd3235-6d50-4fed-a172-08d66c777e75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5968;
x-ms-traffictypediagnostic: VI1PR04MB5968:
x-microsoft-antispam-prvs: <VI1PR04MB5968A8F063156B292604D27492B70@VI1PR04MB5968.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5968;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5968;
x-forefront-prvs: 09007040D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(53936002)(4720700003)(6486002)(105586002)(53346004)(14454004)(6436002)(2906002)(86362001)(36756003)(478600001)(575784001)(4326008)(305945005)(4744004)(76176011)(7736002)(8676002)(186003)(8936002)(81166006)(50226002)(25786009)(54906003)(256004)(68736007)(14444005)(446003)(26005)(11346002)(6116002)(3846002)(102836004)(106356001)(97736004)(316002)(81156014)(110136005)(66066001)(2501003)(52116002)(2616005)(486006)(53946003)(6506007)(99286004)(71200400001)(71190400001)(386003)(5660300001)(476003)(6512007)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5968;H:VI1PR04MB5135.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zu5oGJh8A2OYHA06BnrwF6H8RJMe431sR1aQj//iPV8o0/3XtvoUJFXt9CD00v9PczdnMtErZDYEgvz8z9UXYZoyLi+N1ESW2X4v84lOwEgcG5lktLts3zIWFHszBq0ms8UHjUMBo2/y9lYcLmMg3eo8SkSc+dRM7inGp8WXR0fpq+sMRrIper594frymgVz5B4jbvdSi7JBJ90Dil4PaGwmCjLF9R0Uz4tNqjeJ74jovT4PxqpD5dyqVsFd3OVx8JYhrNfyhdN6/ug3FJZtKWPxlFqNMMXsUTFCjzqs0We6wS+CNAzLj3ZfGvRUdT74
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cd3235-6d50-4fed-a172-08d66c777e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2018 03:49:40.5695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5968
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provids netlink method to configure the TSN protocols hardwares.
TSN guaranteed packet transport with bounded low latency, low packet delay
variation, and low packet loss by hardware and software methods.

The three basic components of TSN are:

1. Time synchronization: This was implement by 8021AS which base on the
   IEEE1588 precision Time Protocol. This is configured by the other way
   in kernel.
   8021AS not included in this patch.

2. Scheduling and traffic shaping and per-stream filter policing:
   This patch support Qbv/Qci.

3. Selection of communication paths:
   This patch not support the pure software only TSN protocols(like Qcc)
   but hardware related configuration.

TSN Protocols supports by this patch: Qbv/Qci/Qbu/Credit-base Shaper(Qav).
This patch verified on NXP ls1028ardb board.

Will add more protocols in the future.

Signed-off-by: Po Liu <Po.Liu@nxp.com>
---
 MAINTAINERS              |    6 +
 include/net/tsn.h        |   76 ++
 include/uapi/linux/tsn.h |  958 +++++++++++++++++
 net/Kconfig              |    1 +
 net/Makefile             |    3 +
 net/tsn/Kconfig          |   15 +
 net/tsn/Makefile         |    1 +
 net/tsn/genl_tsn.c       | 2626 ++++++++++++++++++++++++++++++++++++++++++=
++++
 8 files changed, 3686 insertions(+)
 create mode 100644 include/net/tsn.h
 create mode 100644 include/uapi/linux/tsn.h
 create mode 100644 net/tsn/Kconfig
 create mode 100644 net/tsn/Makefile
 create mode 100644 net/tsn/genl_tsn.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a9804a..bc037e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15385,6 +15385,12 @@ F:	sound/soc/codecs/tscs*.c
 F:	sound/soc/codecs/tscs*.h
 F:	Documentation/devicetree/bindings/sound/tscs*.txt
=20
+TSN NETLINK INTERFACE DRVIER
+M:	Po Liu <Po.Liu@nxp.com>
+F:	net/tsn/genl_tsn.c
+F:	include/net/tsn.h
+F:	include/uapi/linux/tsn.h
+
 TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jslaby@suse.com>
diff --git a/include/net/tsn.h b/include/net/tsn.h
new file mode 100644
index 0000000..008360c
--- /dev/null
+++ b/include/net/tsn.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright 2017-2018 NXP */
+
+#ifndef __TSN_H__
+#define __TSN_H__
+
+#include <uapi/linux/tsn.h>
+
+struct tsn_ops {
+	void (*device_init)(struct net_device *ndev);
+	void (*device_deinit)(struct net_device *ndev);
+	u32 (*get_capability)(struct net_device *ndev);
+	/* Qbv standard */
+	int (*qbv_set)(struct net_device *ndev, struct tsn_qbv_conf *qbvconf);
+	int (*qbv_get)(struct net_device *ndev, struct tsn_qbv_conf *qbvconf);
+	int (*qbv_get_status)(struct net_device *ndev,
+				struct tsn_qbv_status *qbvstat);
+	int (*cb_streamid_set)(struct net_device *ndev, u32 index,
+				bool enable, struct tsn_cb_streamid *sid);
+	int (*cb_streamid_get)(struct net_device *ndev, u32 index,
+				struct tsn_cb_streamid *sid);
+	int (*cb_streamid_counters_get)(struct net_device *ndev, u32 index,
+				struct tsn_cb_streamid_counters *sidcounter);
+	int (*qci_get_maxcap)(struct net_device *ndev,
+				struct tsn_qci_psfp_stream_param *qcicapa);
+	int (*qci_sfi_set)(struct net_device *ndev, u32 index, bool enable,
+				struct tsn_qci_psfp_sfi_conf *sficonf);
+	/* return: 0 stream filter instance not valid
+	 * 1 stream filter instance valid
+	 * -1 error happened
+	 */
+	int (*qci_sfi_get)(struct net_device *ndev, u32 index,
+				struct tsn_qci_psfp_sfi_conf *sficonf);
+	int (*qci_sfi_counters_get)(struct net_device *ndev, u32 index,
+				struct tsn_qci_psfp_sfi_counters *sficounter);
+	int (*qci_sgi_set)(struct net_device *ndev, u32 index,
+				struct tsn_qci_psfp_sgi_conf *sgiconf);
+	int (*qci_sgi_get)(struct net_device *ndev, u32 index,
+				struct tsn_qci_psfp_sgi_conf *sgiconf);
+	int (*qci_sgi_status_get)(struct net_device *ndev, u16 index,
+				struct tsn_psfp_sgi_status *sgistat);
+	int (*qci_fmi_set)(struct net_device *ndev, u32 index, bool enable,
+				struct tsn_qci_psfp_fmi *fmi);
+	int (*qci_fmi_get)(struct net_device *ndev, u32 index,
+				struct tsn_qci_psfp_fmi *fmi,
+				struct tsn_qci_psfp_fmi_counters *counters);
+	int (*cbs_set)(struct net_device *ndev, u8 tc, u8 bw);
+	int (*cbs_get)(struct net_device *ndev, u8 tc);
+	/* To set a 8 bits vector shows 8 traffic classes
+	 * preemtable(1) or express(0)
+	 */
+	int (*qbu_set)(struct net_device *ndev, u8 ptvector);
+	/* To get port preemtion status */
+	int (*qbu_get)(struct net_device *ndev,
+				struct tsn_preempt_status *preemptstat);
+};
+
+enum ethdev_type {
+	TSN_SWITCH,
+	TSN_ENDPOINT,
+};
+
+#define GROUP_OFFSET_SWITCH 256
+
+struct tsn_port {
+	u16 groupid;
+	struct tsn_ops *tsnops;
+	struct net_device *netdev;
+	struct list_head list;
+	enum ethdev_type type;
+};
+
+int tsn_port_register(struct net_device *netdev,
+				struct tsn_ops *tsnops, u16 groupid);
+void tsn_port_unregister(struct net_device *netdev);
+#endif
diff --git a/include/uapi/linux/tsn.h b/include/uapi/linux/tsn.h
new file mode 100644
index 0000000..0789c74
--- /dev/null
+++ b/include/uapi/linux/tsn.h
@@ -0,0 +1,958 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright 2017-2018 NXP */
+
+#ifndef __UAPI_GENL_TSN_H
+#define __UAPI_GENL_TSN_H
+
+#define	TSN_GENL_NAME		"TSN_GEN_CTRL"
+#define	TSN_GENL_VERSION	0x1
+
+#define MAX_USER_SIZE 0
+#define MAX_ATTR_SIZE 3072
+#define MAX_TOTAL_MSG_SIZE  (MAX_USER_SIZE + MAX_ATTR_SIZE)
+#define MAX_ENTRY_SIZE 2048
+#define MAX_ENTRY_NUMBER 128
+#define MAX_IFNAME_COUNT 64
+#define NUM_MSCC_QOS_PRIO 8
+#define MSCC_QOS_PRIO_MAX (NUM_MSCC_QOS_PRIO - 1)
+
+enum tsn_capability {
+	TSN_CAP_QBV =3D 0x1,
+	TSN_CAP_QCI =3D 0x2,
+	TSN_CAP_QBU =3D 0x4,
+	TSN_CAP_CBS =3D 0x8, /* Credit-based Shapter Qav */
+};
+
+/*
+ * Commands sent from userspace
+ * Not versioned. New commands should only be inserted at the enum's end
+ * prior to __TSN_CMD_MAX
+ */
+
+enum {
+	TSN_CMD_UNSPEC =3D 0,	/* Reserved */
+	TSN_CMD_QBV_SET,
+	TSN_CMD_QBV_GET,
+	TSN_CMD_QBV_GET_STATUS,
+	TSN_CMD_CB_STREAMID_SET,
+	TSN_CMD_CB_STREAMID_GET,
+	TSN_CMD_QCI_CAP_GET, /* Qci capability get length capability get */
+	TSN_CMD_QCI_SFI_SET,
+	TSN_CMD_QCI_SFI_GET,
+	TSN_CMD_QCI_SFI_GET_COUNTS,
+	TSN_CMD_QCI_SGI_SET,
+	TSN_CMD_QCI_SGI_GET,
+	TSN_CMD_QCI_SGI_GET_STATUS,
+	TSN_CMD_QCI_FMI_SET,
+	TSN_CMD_QCI_FMI_GET,
+	TSN_CMD_CBS_SET,
+	TSN_CMD_CBS_GET,
+	TSN_CMD_QBU_SET,
+	TSN_CMD_QBU_GET_STATUS,
+	TSN_CMD_QAV_SET_CBS,
+	TSN_CMD_QAV_GET_CBS,
+	TSN_CMD_ECHO,			/* user->kernel request/get-response */
+	TSN_CMD_REPLY,			/* kernel->user event */
+	__TSN_CMD_MAX,
+};
+#define TSN_CMD_MAX (__TSN_CMD_MAX - 1)
+
+
+enum {
+	TSN_CMD_ATTR_UNSPEC =3D 0,
+	TSN_CMD_ATTR_MESG,		/* common message  */
+	TSN_CMD_ATTR_DATA,		/* common data */
+	TSN_ATTR_IFNAME,
+	TSN_ATTR_PORT_NUMBER,
+	TSN_ATTR_QBV,
+	TSN_ATTR_STREAM_IDENTIFY,	/* stream identify */
+	TSN_ATTR_QCI_SP,		/* psfp port capbility parameters */
+	TSN_ATTR_QCI_SFI,		/* psfp stream filter instance */
+	TSN_ATTR_QCI_SGI,		/* psfp stream gate instance */
+	TSN_ATTR_QCI_FMI,		/* psfp flow meter instance */
+	TSN_ATTR_CBS,			/* credit-based shaper */
+	TSN_ATTR_QBU,			/* preemption */
+	__TSN_CMD_ATTR_MAX,
+};
+#define TSN_CMD_ATTR_MAX (__TSN_CMD_ATTR_MAX - 1)
+
+enum {
+	TSN_QBU_ATTR_UNSPEC,
+	TSN_QBU_ATTR_ADMIN_STATE,
+	TSN_QBU_ATTR_HOLD_ADVANCE,
+	TSN_QBU_ATTR_RELEASE_ADVANCE,
+	TSN_QBU_ATTR_ACTIVE,
+	TSN_QBU_ATTR_HOLD_REQUEST,
+	__TSN_QBU_ATTR_MAX,
+	TSN_QBU_ATTR_MAX =3D __TSN_QBU_ATTR_MAX - 1,
+};
+
+enum {
+	TSN_CBS_ATTR_UNSPEC,
+	TSN_CBS_ATTR_TC_INDEX,
+	TSN_CBS_ATTR_BW,
+	__TSN_CBS_ATTR_MAX,
+	TSN_CBS_ATTR_MAX =3D __TSN_CBS_ATTR_MAX - 1,
+};
+
+enum {
+	TSN_STREAMID_ATTR_UNSPEC,
+	TSN_STREAMID_ATTR_INDEX,
+	TSN_STREAMID_ATTR_ENABLE,
+	TSN_STREAMID_ATTR_DISABLE,
+	TSN_STREAMID_ATTR_STREAM_HANDLE,
+	TSN_STREAMID_ATTR_IFOP,
+	TSN_STREAMID_ATTR_OFOP,
+	TSN_STREAMID_ATTR_IFIP,
+	TSN_STREAMID_ATTR_OFIP,
+	TSN_STREAMID_ATTR_TYPE,
+	TSN_STREAMID_ATTR_NDMAC,
+	TSN_STREAMID_ATTR_NTAGGED,
+	TSN_STREAMID_ATTR_NVID,
+	TSN_STREAMID_ATTR_SMAC,
+	TSN_STREAMID_ATTR_STAGGED,
+	TSN_STREAMID_ATTR_SVID,
+	TSN_STREAMID_ATTR_COUNTERS_PSI,
+	TSN_STREAMID_ATTR_COUNTERS_PSO,
+	TSN_STREAMID_ATTR_COUNTERS_PSPPI,
+	TSN_STREAMID_ATTR_COUNTERS_PSPPO,
+	__TSN_STREAMID_ATTR_MAX,
+	TSN_STREAMID_ATTR_MAX =3D __TSN_STREAMID_ATTR_MAX - 1,
+};
+
+enum {
+	TSN_QCI_SFI_ATTR_UNSPEC =3D 0,
+	TSN_QCI_SFI_ATTR_INDEX,
+	TSN_QCI_SFI_ATTR_ENABLE,
+	TSN_QCI_SFI_ATTR_DISABLE,
+	TSN_QCI_SFI_ATTR_STREAM_HANDLE,
+	TSN_QCI_SFI_ATTR_PRIO_SPEC,
+	TSN_QCI_SFI_ATTR_GATE_ID,
+	TSN_QCI_SFI_ATTR_FILTER_TYPE,
+	TSN_QCI_SFI_ATTR_FLOW_ID,
+	TSN_QCI_SFI_ATTR_MAXSDU,
+	TSN_QCI_SFI_ATTR_COUNTERS,
+	TSN_QCI_SFI_ATTR_OVERSIZE_ENABLE,
+	TSN_QCI_SFI_ATTR_OVERSIZE,
+	__TSN_QCI_SFI_ATTR_MAX,
+	TSN_QCI_SFI_ATTR_MAX =3D __TSN_QCI_SFI_ATTR_MAX - 1,
+};
+
+enum {
+	TSN_QCI_SFI_ATTR_COUNTERS_UNSPEC =3D 0,
+	TSN_QCI_SFI_ATTR_MATCH,
+	TSN_QCI_SFI_ATTR_PASS,
+	TSN_QCI_SFI_ATTR_DROP,
+	TSN_QCI_SFI_ATTR_SDU_DROP,
+	TSN_QCI_SFI_ATTR_SDU_PASS,
+	TSN_QCI_SFI_ATTR_RED,
+	__TSN_QCI_SFI_ATTR_COUNT_MAX,
+	TSN_QCI_SFI_ATTR_COUNT_MAX =3D __TSN_QCI_SFI_ATTR_COUNT_MAX - 1,
+};
+
+enum {
+	TSN_QCI_SGI_ATTR_UNSPEC =3D 0,
+	TSN_QCI_SGI_ATTR_INDEX,
+	TSN_QCI_SGI_ATTR_ENABLE,
+	TSN_QCI_SGI_ATTR_DISABLE,
+	TSN_QCI_SGI_ATTR_CONFCHANGE,
+	TSN_QCI_SGI_ATTR_IRXEN,		/* Invalid rx enable*/
+	TSN_QCI_SGI_ATTR_IRX,
+	TSN_QCI_SGI_ATTR_OEXEN,		/* Octet exceed enable */
+	TSN_QCI_SGI_ATTR_OEX,
+	TSN_QCI_SGI_ATTR_ADMINENTRY,
+	TSN_QCI_SGI_ATTR_OPERENTRY,
+	TSN_QCI_SGI_ATTR_CCTIME,	/* config change time */
+	TSN_QCI_SGI_ATTR_TICKG,
+	TSN_QCI_SGI_ATTR_CUTIME,
+	TSN_QCI_SGI_ATTR_CPENDING,
+	TSN_QCI_SGI_ATTR_CCERROR,
+	__TSN_QCI_SGI_ATTR_MAX,
+	TSN_QCI_SGI_ATTR_MAX =3D __TSN_QCI_SGI_ATTR_MAX - 1,
+};
+
+enum {
+	TSN_SGI_ATTR_CTRL_UNSPEC =3D 0,
+	TSN_SGI_ATTR_CTRL_INITSTATE,
+	TSN_SGI_ATTR_CTRL_LEN,
+	TSN_SGI_ATTR_CTRL_CYTIME,
+	TSN_SGI_ATTR_CTRL_CYTIMEEX,
+	TSN_SGI_ATTR_CTRL_BTIME,
+	TSN_SGI_ATTR_CTRL_INITIPV,
+	TSN_SGI_ATTR_CTRL_GCLENTRY,
+	__TSN_SGI_ATTR_CTRL_MAX,
+	TSN_SGI_ATTR_CTRL_MAX =3D __TSN_SGI_ATTR_CTRL_MAX - 1,
+};
+
+enum {
+	TSN_SGI_ATTR_GCL_UNSPEC =3D 0,
+	TSN_SGI_ATTR_GCL_GATESTATE,
+	TSN_SGI_ATTR_GCL_IPV,
+	TSN_SGI_ATTR_GCL_INTERVAL,
+	TSN_SGI_ATTR_GCL_OCTMAX,
+	__TSN_SGI_ATTR_GCL_MAX,
+	TSN_SGI_ATTR_GCL_MAX =3D __TSN_SGI_ATTR_GCL_MAX - 1,
+};
+
+enum {
+	TSN_QCI_FMI_ATTR_UNSPEC =3D 0,
+	TSN_QCI_FMI_ATTR_INDEX,
+	TSN_QCI_FMI_ATTR_ENABLE,
+	TSN_QCI_FMI_ATTR_DISABLE,
+	TSN_QCI_FMI_ATTR_CIR,
+	TSN_QCI_FMI_ATTR_CBS,
+	TSN_QCI_FMI_ATTR_EIR,
+	TSN_QCI_FMI_ATTR_EBS,
+	TSN_QCI_FMI_ATTR_CF,
+	TSN_QCI_FMI_ATTR_CM,
+	TSN_QCI_FMI_ATTR_DROPYL,
+	TSN_QCI_FMI_ATTR_MAREDEN,
+	TSN_QCI_FMI_ATTR_MARED,
+	TSN_QCI_FMI_ATTR_COUNTERS,
+	__TSN_QCI_FMI_ATTR_MAX,
+	TSN_QCI_FMI_ATTR_MAX =3D __TSN_QCI_FMI_ATTR_MAX - 1,
+};
+
+enum {
+	TSN_QBV_ATTR_UNSPEC,
+	TSN_QBV_ATTR_ENABLE,
+	TSN_QBV_ATTR_DISABLE,
+	TSN_QBV_ATTR_CONFIGCHANGE,
+	TSN_QBV_ATTR_CONFIGCHANGETIME,
+	TSN_QBV_ATTR_MAXSDU,
+	TSN_QBV_ATTR_GRANULARITY,
+	TSN_QBV_ATTR_CURRENTTIME,
+	TSN_QBV_ATTR_CONFIGPENDING,
+	TSN_QBV_ATTR_CONFIGCHANGEERROR,
+	TSN_QBV_ATTR_ADMINENTRY,
+	TSN_QBV_ATTR_OPERENTRY,
+	TSN_QBV_ATTR_LISTMAX,
+	__TSN_QBV_ATTR_MAX,
+	TSN_QBV_ATTR_MAX =3D __TSN_QBV_ATTR_MAX - 1,
+};
+
+enum {
+	TSN_QBV_ATTR_CTRL_UNSPEC,
+	TSN_QBV_ATTR_CTRL_LISTCOUNT,
+	TSN_QBV_ATTR_CTRL_GATESTATE,
+	TSN_QBV_ATTR_CTRL_CYCLETIME,
+	TSN_QBV_ATTR_CTRL_CYCLETIMEEXT,
+	TSN_QBV_ATTR_CTRL_BASETIME,
+	TSN_QBV_ATTR_CTRL_LISTENTRY,
+	__TSN_QBV_ATTR_CTRL_MAX,
+	TSN_QBV_ATTR_CTRL_MAX =3D __TSN_QBV_ATTR_CTRL_MAX - 1,
+};
+
+enum {
+	TSN_QBV_ATTR_ENTRY_UNSPEC,
+	TSN_QBV_ATTR_ENTRY_ID,
+	TSN_QBV_ATTR_ENTRY_GC,
+	TSN_QBV_ATTR_ENTRY_TM,
+	__TSN_QBV_ATTR_ENTRY_MAX,
+	TSN_QBV_ATTR_ENTRY_MAX =3D __TSN_QBV_ATTR_ENTRY_MAX - 1,
+};
+
+#define ptptime_t uint64_t
+
+#define MAX_QUEUE_CNT 8
+
+struct tsn_preempt_status {
+	/* The value of admin_state shows a 8-bits vector value for showing
+	 * the framePreemptionAdminStatus parameter and PreemptionPriority
+	 * for the traffic class. Bit-7 is the highest priority traffic class
+	 * and the bit-0 is the lowest priority traffic class.
+	 * The bit is express (0) and is preemptible (1).
+	 */
+	uint8_t admin_state;
+	/* The value of the holdAdvance parameter for the port in nanoseconds.
+	 * There is no default value; the holdAdvance is a property of the
+	 * underlying MAC." This parameter corresponds to the holdAdvance
+	 * parameter in 802.1Qbu.
+	 */
+	uint32_t hold_advance;
+
+	/* The value of the releaseAdvance parameter for the port in
+	 * nanoseconds.  There is no default value; the releaseAdvance is a
+	 * property of the underlying MAC." This parameter corresponds to the
+	 * releaseAdvance parameter in 802.1Qbu.
+	 */
+	uint32_t release_advance;
+
+	/* The value is active (TRUE) when preemption is operationally active
+	 * for the port, and idle (FALSE) otherwise.  This parameter corresponds
+	 * to the preemptionActive parameter in 802.1Qbu.
+	 */
+	bool preemption_active;
+
+	/* The value is hold (1) when the sequence of gate operations for
+	 * the port has executed a Set-And-Hold-MAC operation, and release
+	 * (2) when the sequence of gate operations has executed a
+	 * Set-And-Release-MAC operation. The value of this object is release
+	 * (FALSE) on system initialization.  This parameter corresponds to the
+	 * holdRequest parameter in 802.1Qbu.
+	 */
+	uint8_t hold_request;
+};
+
+enum tsn_tx_mode  {
+	TX_MODE_STRICT,
+	TX_MODE_CBS,
+	TX_MODE_ETS,
+	TX_MODE_VENDOR_DEFINE =3D 255,
+};
+
+#define QUEUE_TX_MASK ((1 << TX_MODE_STRICT) | (1 << TX_MODE_CBS) \
+			| (1 << TX_MODE_ETS) | (1 << TX_MODE_VENDOR_DEFINE))
+
+struct cbs_status {
+	uint8_t delta_bw; /* percentage, 0~100 */
+	uint32_t idleslope;
+	int32_t sendslope;
+	uint32_t maxframesize;
+	uint32_t hicredit;
+	int32_t locredit;
+	uint32_t maxninference;
+};
+
+struct tx_queue {
+	/* tx_queue_capbility shows the queue's capability mask.
+	 * refer the enum tsn_tx_mode
+	 */
+	uint8_t capability;
+
+	/* tx_queue_mode is current queue working mode */
+	uint8_t mode;
+
+	/* prio is showing the queue priority */
+	uint8_t prio;
+
+	/* mstat shows the status data of cbs or priority */
+	union {
+		struct cbs_status cbs;
+	};
+};
+
+struct port_status {
+	/* txqueue_cnt shows how many queues in this port */
+	uint8_t queue_cnt;
+
+	/* max_rate(Mbit/s) is the port transmit rate current port is setting */
+	uint32_t max_rate;
+
+	/* tsn_capability mask the tsn capability */
+	uint32_t tsn_capability;
+};
+
+enum tsn_cb_streamid_type {
+	STREAMID_RESERVED =3D 0,
+	/* Null Stream identification */
+	STREAMID_NULL,
+	/* Source MAC and VLAN Stream identification */
+	STREAMID_SMAC_VLAN,
+	/* Active Destination MAC and VLAN stream identification */
+	STREAMID_DMAC_VLAN,
+	/* IP stream identification */
+	STREAMID_IP,
+};
+
+/* When instantiating an instance of the Null Stream identification functi=
on
+ * 8021CB(6.4) for a particular input Stream, the managed objects in the
+ * following subsections serve as the tsnStreamIdParameters managed object
+ * 8021CB claus(9.1.1.7).
+ */
+struct tsn_cb_null_streamid {
+	/* tsnCpeNullDownDestMac. Specifies the destination_address that
+	 * identifies a packet in an Enhanced Internal Sublayer Service (EISS)
+	 * indication primitive, to the Null Stream identification function.
+	 */
+	uint64_t dmac;
+
+	/* tsnCpeNullDownTagged. It can take the following values:
+	 * 1 tagged: A frame must have a VLAN tag to be recognized as belonging
+	 * to the Stream.
+	 * 2 priority: A frame must be untagged, or have a VLAN tag with a VLAN
+	 * ID =3D 0 to be recognized as belonging to the Stream.
+	 * 3 all: A frame is recognized as belonging to the Stream whether
+	 * tagged or not.
+	 */
+	uint8_t tagged;
+
+	/* tsnCpeNullDownVlan. Specifies the vlan_identifier parameter that
+	 * identifies a packet in an EISS indication primitive to the Null
+	 * Stream identification function. A value of 0 indicates that the vlan
+	 * _identifier parameter is ignored on EISS indication primitives.
+	 */
+	uint16_t vid;
+};
+
+struct tsn_cb_source_streamid {
+	uint64_t smac;
+	uint8_t tagged;
+	uint16_t vid;
+};
+
+struct tsn_cb_dest_streamid {
+	uint64_t down_dmac;
+	uint8_t down_tagged;
+	uint16_t down_vid;
+	uint8_t down_prio;
+	uint64_t up_dmac;
+	uint8_t up_tagged;
+	uint16_t up_vid;
+	uint8_t up_prio;
+};
+
+struct tsn_cb_ip_streamid {
+	uint64_t dmac;
+	uint8_t tagged;
+	uint16_t vid;
+	uint64_t siph;
+	uint64_t sipl;
+	uint64_t diph;
+	uint64_t dipl;
+	uint8_t dscp;
+	uint8_t npt;
+	uint16_t sport;
+	uint16_t dport;
+};
+
+/* 802.1CB stream identify table clause 9.1 */
+struct tsn_cb_streamid {
+	/* The objects in a given entry of the Stream identity table are used
+	 * to control packets whose stream_handle subparameter is equal to the
+	 * entry=E2=80=99s tsnStreamIdHandle object.
+	 */
+	int32_t handle;
+
+	/* The list of ports on which an in-facing Stream identification
+	 * function in the output (towards the system forwarding function)
+	 * direction Only Active Destination MAC and VLAN Stream identification
+	 * (or nothing) can be configured.
+	 */
+	uint32_t ifac_oport;
+
+	/* The list of ports on which an out-facing Stream identification
+	 * function in the output (towards the physical interface) direction.
+	 * Only Active Destination MAC and VLAN Stream identification
+	 * (or nothing) can be configured.
+	 */
+	uint32_t ofac_oport;
+
+	/* The list of ports on which an in-facing Stream identification
+	 * function in the input (coming from the system forwarding function)
+	 * direction
+	 */
+	uint32_t ifac_iport;
+
+	/* The list of ports on which an out-facing Stream identification
+	 * function in the input (coming from the physical interface) direction
+	 * .
+	 */
+	uint32_t ofac_iport;
+
+	/* An enumerated value indicating the method used to identify packets
+	 * belonging to the Stream.
+	 * The Organizationally Unique Identifier (OUI) or Company Identifier
+	 * (CID) to identify the organization defining the enumerated type
+	 * should be: 00-80-C2
+	 * 1: null stream identification
+	 * 2: source mac and vlan stream identification
+	 * 3: activ destination mac and vlan stream identification
+	 * 4: ip stream identifaciton
+	 */
+	uint8_t type;
+
+	/* tsnStreamIdParameters The number of controlling parameters for a
+	 * Stream identification method, their types and values, are specific
+	 * to the tsnStreamIdIdentificationType
+	 */
+	union {
+		struct tsn_cb_null_streamid nid;
+		struct tsn_cb_source_streamid sid;
+		struct tsn_cb_dest_streamid did;
+		struct tsn_cb_ip_streamid iid;
+	} para;
+};
+
+/* Following counters are instantiated for each port on which the Stream
+ * identification function (6.2) is configured. The counters are indexed b=
y
+ * port number, facing (in-facing or out-facing), and stream_handle value
+ * (tsnStreamIdHandle, 9.1.1.1).
+ */
+struct tsn_cb_streamid_counters {
+	struct {
+		uint64_t input;
+		uint64_t output;
+	} per_stream;
+
+	struct {
+		uint64_t input;
+		uint64_t output;
+	} per_streamport[32];
+};
+
+/* 802.1Qci Stream Parameter Table, read from port */
+struct tsn_qci_psfp_stream_param {
+	/* MaxStreamFilterInstances.
+	 * The maximum number of Stream Filter instances supported by this
+	 * Bridge component.
+	 */
+	int32_t max_sf_instance;
+
+	/* MaxStreamGateInstances
+	 * The maximum number of Stream Gate instances supported by this Bridge
+	 * component.
+	 */
+	int32_t max_sg_instance;
+
+	/* MaxFlowMeterInstances
+	 * The maximum number of Flow Meter instances supported by this Bridge
+	 * component.
+	 */
+	int32_t max_fm_instance;
+
+	/* SupportedListMax
+	 * The maximum value supported by this Bridge component of the
+	 * AdminControlListLength and OperControlListLength parameters.
+	 */
+	int32_t supported_list_max;
+};
+
+/* 802.1Qci Stream Filter Instance Table, counters part only. */
+struct tsn_qci_psfp_sfi_counters {
+	/* The MatchingFramesCount counter counts received frames that match
+	 * this stream filter.
+	 */
+	uint64_t matching_frames_count;
+
+	/* The PassingFramesCount counter counts received frames that pass the
+	 * gate associated with this stream filter.
+	 */
+	uint64_t passing_frames_count;
+
+	/* The NotPassingFramesCount counter counts received frames that do not
+	 * pass the gate associated with this stream filter.
+	 */
+	uint64_t not_passing_frames_count;
+
+	/* The PassingSDUCount counter counts received frames that pass the SDU
+	 * size filter specification associated with this stream filter.
+	 */
+	uint64_t passing_sdu_count;
+
+	/* The NotPassingSDUCount counter counts received frames that do not
+	 * pass the SDU size filter specification associated with this stream
+	 * filter.
+	 */
+	uint64_t not_passing_sdu_count;
+
+	/* The  REDFramesCount counter counts received random early detection
+	 * (RED) frames associated with this stream filter.
+	 */
+	uint64_t red_frames_count;
+};
+
+/* 802.1Qci Stream Filter Instance Table, configuration part only. */
+struct tsn_qci_psfp_sfi_conf {
+
+	/* The StreamHandleSpec parameter contains a stream identifier
+	 * specification value. A value of -1 denotes the wild card value; zero
+	 * or positive values denote stream identifier values.
+	 */
+	int32_t stream_handle_spec;
+
+	/* The PrioritySpec parameter contains a priority specification value.
+	 * A value of -1 denotes the wild card value; zero or positive values
+	 * denote priority values.
+	 */
+	int8_t priority_spec;
+
+	/* The StreamGateInstanceID parameter contains the index of an entry in
+	 * the Stream Gate Table.
+	 */
+	uint32_t stream_gate_instance_id;
+
+	/* The filter specifications. The actions specified in a filter
+	 * specification can result in a frame passing or failing the specified
+	 * filter. Frames that fail a filter are discarded.
+	 */
+	struct {
+		/* The MaximumSDUSize parameter specifies the maximum allowed
+		 * frame size for the stream. Any frame exceeding this value
+		 * will be dropped.  A value of 0 denote that the MaximumSDUSize
+		 * filter is disabled for this stream.
+		 */
+		uint16_t maximum_sdu_size;
+
+		/* The FlowMeterInstanceID parameter contains the index of an
+		 * entry in the Flow Meter Table.  A value of -1 denotes that
+		 * no flow meter is assigned; zero or positive values denote
+		 * flow meter IDs.
+		 */
+		int32_t flow_meter_instance_id;
+	} stream_filter;
+
+	/* The StreamBlockedDueToOversizeFrameEnable object contains a Boolean
+	 * value that indicates whether the StreamBlockedDueToOversizeFrame
+	 * function is enabled (TRUE) or disabled (FALSE).
+	 */
+	bool block_oversize_enable;
+
+	/* The StreamBlockedDueToOversizeFrame object contains a Boolean value
+	 * that indicates whether, if the StreamBlockedDueToOversizeFrame
+	 * function is enabled, all frames are to be discarded (TRUE) or not
+	 * (FALSE).
+	 */
+	bool block_oversize;
+};
+
+/* 802.1Qci Stream Gate Control List Entry. */
+struct tsn_qci_psfp_gcl {
+	/* The GateState parameter specifies a desired state, open (true) or
+	 * closed (false), for the stream gate.
+	 */
+	bool gate_state;
+
+	/* An IPV is encoded as a signed integer.  A negative denotes the null
+	 * value; zero or positive values denote internal priority values.
+	 */
+	int8_t ipv;
+
+	/* A TimeInterval is encoded in 4 octets as a 32-bit unsigned integer,
+	 * representing a number of nanoseconds.
+	 */
+	uint32_t time_interval;
+
+	/* The maximum number of octets that are permitted to pass the gate
+	 * during the specified TimeInterval.  If zero, there is no maximum.
+	 */
+	uint32_t octet_max;
+
+};
+
+/* 802.1Qci Stream Gate Admin/Operation common list control parameters */
+struct tsn_qci_sg_control {
+	/* The administrative/operation value of the GateStates parameter
+	 * for the stream gate.  A value of false indicates closed;
+	 * a value of true indicates open.
+	 */
+	bool gate_states;
+
+	/* The administrative/operation value of the ListMax parameter for the
+	 * gate. The integer value indicates the number of entries (TLVs) in
+	 * the AdminControlList/OperControlList.
+	 */
+	uint8_t control_list_length;
+
+	/* The administrative/operation value of the CycleTime parameter for
+	 * the gate.  The value is an unsigned integer number of nanoseconds.
+	 */
+	uint32_t cycle_time;
+
+	/* The administrative/operation value of the CycleTimeExtension
+	 * parameter for the gate.  The value is an unsigned integer number
+	 * of nanoseconds.
+	 */
+	uint32_t cycle_time_extension;
+
+	/* The administrative/operation value of the BaseTime parameter for the
+	 * gate.  The value is a representation of a PTPtime value, consisting
+	 * of a 48-bit integer number of seconds and a 32-bit integer number of
+	 * nanoseconds.
+	 */
+	ptptime_t base_time;
+
+	/* The administrative/operation value of the IPV parameter for the gate.
+	 * A value of -1 denotes the null value; zero or positive values denote
+	 * internal priority values.
+	 */
+	int8_t init_ipv;
+
+	/* control_list contend the gate control list of
+	 * administrative/operation
+	 */
+	struct tsn_qci_psfp_gcl *gcl;
+};
+
+/* 802.1Qci Stream Gate Instance Table, configuration part only. */
+struct tsn_qci_psfp_sgi_conf {
+	/* The GateEnabled parameter determines whether the stream gate is
+	 * active (true) or inactive (false).
+	 */
+	bool gate_enabled;
+
+	/* The ConfigChange parameter signals the start of a configuration
+	 * change when it is set to TRUE. This should only be done when the
+	 * various administrative parameters are all set to appropriate values.
+	 */
+	bool config_change;
+
+	/* admin control parameters with admin control list */
+	struct tsn_qci_sg_control admin;
+
+	/* The GateClosedDueToInvalidRxEnable object contains a Boolean value
+	 * that indicates whether the GateClosedDueToInvalidRx function is
+	 * enabled (TRUE) or disabled (FALSE).
+	 */
+	bool block_invalid_rx_enable;
+
+	/* The GateClosedDueToInvalidRx object contains a Boolean value that
+	 * indicates whether, if the GateClosedDueToInvalidRx function is
+	 * enabled, all frames are to be discarded (TRUE) or not (FALSE).
+	 */
+	bool block_invalid_rx;
+
+	/* The GateClosedDueToOctetsExceededEnable object contains a Boolean
+	 * value that indicates whether the GateClosedDueToOctetsExceeded
+	 * function is enabled (TRUE) or disabled (FALSE).
+	 */
+	bool block_octets_exceeded_enable;
+
+	/* The GateClosedDueToOctetsExceeded object contains a Boolean value
+	 * that indicates whether, if the GateClosedDueToOctetsExceeded
+	 * function is enabled, all frames are to be discarded (TRUE) or not
+	 * (FALSE).
+	 */
+	bool block_octets_exceeded;
+};
+
+/* 802.1Qci Stream Gate Instance Table, status part only. */
+struct tsn_psfp_sgi_status {
+
+	/* admin control parameters with admin control list */
+	struct tsn_qci_sg_control oper;
+
+	/* The PTPtime at which the next config change is scheduled to occur.
+	 * The value is a representation of a PTPtime value, consisting of a
+	 * 48-bit integer number of seconds and a 32-bit integer number of
+	 * nanoseconds.
+	 */
+	ptptime_t config_change_time;
+
+	/* The granularity of the cycle time clock, represented as an unsigned
+	 * number of tenths of nanoseconds.
+	 */
+	uint32_t tick_granularity;
+
+	/* The current time, in PTPtime, as maintained by the local system.
+	 * The value is a representation of a PTPtime value, consisting of a
+	 * 48-bit integer number of seconds and a 32-bit integer number of
+	 * nanoseconds.
+	 */
+	ptptime_t current_time;
+
+	/* The value of the ConfigPending state machine variable.  The value is
+	 * TRUE if a configuration change is in progress but has not yet
+	 * completed.
+	 */
+	bool config_pending;
+
+	/* A counter of the number of times that a re-configuration of the
+	 * traffic schedule has been requested with the old schedule still
+	 * running and the requested base time was in the past.
+	 */
+	uint64_t config_change_error;
+
+};
+
+/* 802.1Qci Flow Meter Instance Table. */
+struct tsn_qci_psfp_fmi {
+	/* The FlowMeterCIR parameter contains an integer value that represents
+	 * the CIR value for the flow meter, in kbit/s.
+	 */
+	uint32_t cir;
+
+	/* The FlowMeterCBS parameter contains an integer value that represents
+	 * the CBS value for the flow meter, in octets.
+	 */
+	uint32_t cbs;
+
+	/* The FlowMeterEIR parameter contains an integer value that represents
+	 * the EIR value for the flow meter, in kbit/s.
+	 */
+	uint32_t eir;
+
+	/* The FlowMeterEBS parameter contains an integer value that represents
+	 * the EBS value for the flow meter, in octets.
+	 */
+	uint32_t ebs;
+
+	/* The FlowMeterCF parameter contains a Boolean value that represents
+	 * the CF value for the flow meter, as a Boolean value indicating no
+	 * coupling (FALSE) or coupling (TRUE).
+	 */
+	bool cf;
+
+	/* The FlowMeterCM parameter contains a Boolean value that represents
+	 * the CM value for the flow meter, as a Boolean value indicating
+	 * colorBlind (FALSE) or colorAware (TRUE).
+	 */
+	bool cm;
+
+	/* The FlowMeterDropOnYellow parameter contains a Boolean value that
+	 * indicates whether yellow frames are dropped (TRUE) or have
+	 * drop_eligible set to TRUE (FALSE).
+	 */
+	bool drop_on_yellow;
+
+	/* The FlowMeterMarkAllFramesRedEnable parameter contains a Boolean
+	 * value that indicates whether the MarkAllFramesRed function
+	 * is enabled (TRUE) or disabled (FALSE).
+	 */
+	bool mark_red_enable;
+
+	/* The FlowMeterMarkAllFramesRed parameter contains a Boolean value
+	 * that indicates whether, if the MarkAllFramesRed function is enabled,
+	 * all frames are to be discarded (TRUE) or not (FALSE).
+	 */
+	bool mark_red;
+};
+
+struct tsn_qci_psfp_fmi_counters {
+	uint64_t bytecount;
+	uint64_t drop;
+	uint64_t dr0_green;
+	uint64_t dr1_green;
+	uint64_t dr2_yellow;
+	uint64_t remark_yellow;
+	uint64_t dr3_red;
+	uint64_t remark_red;
+};
+
+/* An entry for gate control list */
+struct tsn_qbv_entry {
+	/* Octet represent the gate states for the corresponding traffic
+	 * classes.
+	 * The MS bit corresponds to traffic class 7.
+	 * The LS bit to traffic class 0.
+	 * A bit value of 0 indicates closed;
+	 * A bit value of 1 indicates open.
+	 */
+	uint8_t gate_state;
+
+	/* A TimeInterval is encoded in 4 octets as a 32-bit unsigned integer,
+	 * representing a number of nanoseconds.
+	 */
+	uint32_t time_interval;
+};
+
+/* The administrative/operation time and gate list */
+struct tsn_qbv_basic {
+	/* The administrative/operation value of the GateStates parameter for
+	 * the Port.
+	 * The bits of the octet represent the gate states for the
+	 * corresponding traffic classes; the MS bit corresponds to traffic
+	 * class 7, the LS bit to traffic class 0. A bit value of 0 indicates
+	 * closed; a bit value of 1 indicates open.
+	 * The value of this object MUST be retained
+	 * across reinitializations of the management system.
+	 */
+	uint8_t gate_states;
+
+	/* The administrative/operation value of the ListMax parameter for the
+	 * port. The integer value indicates the number of entries (TLVs) in
+	 * the AdminControlList. The value of this object MUST be retained
+	 * across reinitializations of the management system.
+	 */
+	uint32_t control_list_length;
+
+	/* The administrative/operation value of the AdminCycleTime
+	 * parameter for the Port. The numerator and denominator together
+	 * represent the cycle time as a rational number of seconds.  The value
+	 * of this object MUST be retained across reinitializations of the
+	 * management system.
+	 */
+	uint32_t cycle_time;
+
+	/* The administrative/operation value of the CycleTimeExtension
+	 * parameter for the Port. The value is an unsigned integer number of
+	 * nanoseconds.
+	 * The value of this object MUST be retained across reinitializations
+	 * of the management system.
+	 */
+
+	uint32_t cycle_time_extension;
+
+	/* The administrative/operation value of the BaseTime parameter for the
+	 * Port.  The value is a representation of a PTPtime value, consisting
+	 * of a 48-bit integer number of seconds and a 32-bit integer number of
+	 * nanoseconds.
+	 * The value of this object MUST be retained across reinitializations of
+	 * the management system.
+	 */
+	ptptime_t base_time;
+
+	/* admin_control_list represent the AdminControlList/OperControlList.
+	 * The administrative version of the gate control list for the Port.
+	 */
+	struct tsn_qbv_entry *control_list;
+};
+
+struct tsn_qbv_conf {
+	/* The GateEnabled parameter determines whether traffic scheduling is
+	 * active (true) or inactive (false).  The value of this object MUST be
+	 * retained across reinitializations of the management system.
+	 */
+	bool gate_enabled;
+
+	/* The maxsdu parameter denoting the maximum SDU size supported by the
+	 * queue.
+	 */
+	uint32_t maxsdu;
+
+	/* The ConfigChange parameter signals the start of a configuration
+	 * change when it is set to TRUE. This should only be done when the
+	 * various administrative parameters are all set to appropriate values.
+	 */
+	bool config_change;
+
+	/* The admin parameter signals the admin relate cycletime, basictime,
+	 * gatelist paraters.
+	 */
+	struct tsn_qbv_basic admin;
+};
+
+/* 802.1Qbv (Time Aware Shaper) port status */
+struct tsn_qbv_status {
+	/* The PTPtime at which the next config change is scheduled to occur.
+	 * The value is a representation of a PTPtime value, consisting of a
+	 * 48-bit integer number of seconds and a 32-bit integer number of
+	 * nanoseconds.  The value of this object MUST be retained across
+	 * reinitializations of the management system.
+	 */
+	ptptime_t config_change_time;
+
+	/* The granularity of the cycle time clock, represented as an unsigned
+	 * number of tenths of nanoseconds.  The value of this object MUST be
+	 * retained across reinitializations of the management system.
+	 */
+	uint32_t tick_granularity;
+
+	/* The current time, in PTPtime, as maintained by the local system.
+	 * The value is a representation of a PTPtime value, consisting of a
+	 * 48-bit integer number of seconds and a 32-bit integer number of
+	 * nanoseconds.
+	 */
+	ptptime_t  current_time;
+
+	/* The value of the ConfigPending state machine variable.  The value is
+	 * TRUE if a configuration change is in progress but has not yet
+	 * completed.
+	 */
+	bool config_pending;
+
+	/* A counter of the number of times that a re-configuration of the
+	 * traffic schedule has been requested with the old schedule still
+	 * running and the requested base time was in the past.
+	 */
+	uint64_t config_change_error;
+
+	/* The maximum value supported by this Port of the
+	 * AdminControlListLength and OperControlListLength parameters.
+	 */
+	uint32_t supported_list_max;
+
+	/* Operation settings parameters and Oper gate list */
+	struct tsn_qbv_basic oper;
+};
+#endif /* _UAPI_GENL_TSN_H */
diff --git a/net/Kconfig b/net/Kconfig
index 5cb9de1..d4ba7d6 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -229,6 +229,7 @@ source "net/ieee802154/Kconfig"
 source "net/mac802154/Kconfig"
 source "net/sched/Kconfig"
 source "net/dcb/Kconfig"
+source "net/tsn/Kconfig"
 source "net/dns_resolver/Kconfig"
 source "net/batman-adv/Kconfig"
 source "net/openvswitch/Kconfig"
diff --git a/net/Makefile b/net/Makefile
index bdaf539..d6804ba 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -59,6 +59,9 @@ obj-$(CONFIG_CAIF)		+=3D caif/
 ifneq ($(CONFIG_DCB),)
 obj-y				+=3D dcb/
 endif
+ifneq ($(CONFIG_TSN),)
+obj-y 				+=3D tsn/
+endif
 obj-$(CONFIG_6LOWPAN)		+=3D 6lowpan/
 obj-$(CONFIG_IEEE802154)	+=3D ieee802154/
 obj-$(CONFIG_MAC802154)		+=3D mac802154/
diff --git a/net/tsn/Kconfig b/net/tsn/Kconfig
new file mode 100644
index 0000000..9f22807
--- /dev/null
+++ b/net/tsn/Kconfig
@@ -0,0 +1,15 @@
+config TSN
+	bool "802.1 Time-Sensitive Networking support"
+	default n
+	depends on VLAN_8021Q && PTP_1588_CLOCK
+	help
+	  This enables support for TSN(time sensitive networking)
+	  TSN features include:
+		802.1Qav:
+		802.1Qbv:
+		802.1Qci:
+		802.1Qbu:
+		802.1AS:
+		802.1CB:
+
+	  If unsure, say N.
diff --git a/net/tsn/Makefile b/net/tsn/Makefile
new file mode 100644
index 0000000..ed46381
--- /dev/null
+++ b/net/tsn/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_TSN) +=3D genl_tsn.o
diff --git a/net/tsn/genl_tsn.c b/net/tsn/genl_tsn.c
new file mode 100644
index 0000000..f167b5c
--- /dev/null
+++ b/net/tsn/genl_tsn.c
@@ -0,0 +1,2626 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2017-2018 NXP */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/netdevice.h>
+#include <linux/if_vlan.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+#include <linux/version.h>
+#include <net/tsn.h>
+
+#define NLA_PARSE_NESTED(a, b, c, d) nla_parse_nested(a, b, c, d, NULL)
+#define NLA_PUT_U64(a, b, c) nla_put_u64_64bit(a, b, c, NLA_U64)
+
+static struct genl_family tsn_family;
+
+LIST_HEAD(port_list);
+
+enum TSN_REPLY_VALUE {
+	TSN_SUCCESS =3D 0,
+	TSN_NODEVOPS,
+	TSN_ATTRERR,
+	TSN_DEVRETERR,
+};
+
+static const struct nla_policy tsn_cmd_policy[TSN_CMD_ATTR_MAX + 1] =3D {
+	[TSN_CMD_ATTR_MESG]		=3D { .type =3D NLA_STRING },
+	[TSN_CMD_ATTR_DATA]		=3D { .type =3D NLA_S32 },
+	[TSN_ATTR_IFNAME]		=3D { .type =3D NLA_STRING },
+	[TSN_ATTR_PORT_NUMBER]		=3D { .type =3D NLA_U8 },
+	[TSN_ATTR_QBV]			=3D { .type =3D NLA_NESTED },
+	[TSN_ATTR_STREAM_IDENTIFY]	=3D { .type =3D NLA_NESTED },
+	[TSN_ATTR_QCI_SP]		=3D { .type =3D NLA_NESTED },
+	[TSN_ATTR_QCI_SFI]		=3D { .type =3D NLA_NESTED },
+	[TSN_ATTR_QCI_SGI]		=3D { .type =3D NLA_NESTED },
+	[TSN_ATTR_QCI_FMI]		=3D { .type =3D NLA_NESTED },
+	[TSN_ATTR_CBS]			=3D { .type =3D NLA_NESTED },
+	[TSN_ATTR_QBU]			=3D { .type =3D NLA_NESTED },
+};
+
+static const struct nla_policy qbu_policy[TSN_QBU_ATTR_MAX + 1] =3D {
+	[TSN_QBU_ATTR_ADMIN_STATE]	=3D { .type =3D NLA_U8 },
+	[TSN_QBU_ATTR_HOLD_ADVANCE]	=3D { .type =3D NLA_U32},
+	[TSN_QBU_ATTR_RELEASE_ADVANCE]	=3D { .type =3D NLA_U32},
+	[TSN_QBU_ATTR_ACTIVE]		=3D { .type =3D NLA_FLAG},
+	[TSN_QBU_ATTR_HOLD_REQUEST]	=3D { .type =3D NLA_U8},
+};
+
+static const struct nla_policy cbs_policy[TSN_CBS_ATTR_MAX + 1] =3D {
+	[TSN_CBS_ATTR_TC_INDEX]		=3D { .type =3D NLA_U8},
+	[TSN_CBS_ATTR_BW]		=3D { .type =3D NLA_U8},
+};
+
+static const struct nla_policy qbv_policy[TSN_QBV_ATTR_MAX + 1] =3D {
+	[TSN_QBV_ATTR_ADMINENTRY]	=3D {	.type =3D NLA_NESTED},
+	[TSN_QBV_ATTR_OPERENTRY]	=3D { .type =3D NLA_NESTED},
+	[TSN_QBV_ATTR_ENABLE]		=3D { .type =3D NLA_FLAG},
+	[TSN_QBV_ATTR_DISABLE]		=3D { .type =3D NLA_FLAG},
+	[TSN_QBV_ATTR_CONFIGCHANGE]	=3D { .type =3D NLA_FLAG},
+	[TSN_QBV_ATTR_CONFIGCHANGETIME]	=3D { .type =3D NLA_U64},
+	[TSN_QBV_ATTR_MAXSDU]		=3D { .type =3D NLA_U32},
+	[TSN_QBV_ATTR_GRANULARITY]	=3D { .type =3D NLA_U32},
+	[TSN_QBV_ATTR_CURRENTTIME]	=3D { .type =3D NLA_U64},
+	[TSN_QBV_ATTR_CONFIGPENDING]	=3D {.type =3D NLA_FLAG},
+	[TSN_QBV_ATTR_CONFIGCHANGEERROR]	=3D { .type =3D NLA_U64},
+	[TSN_QBV_ATTR_LISTMAX]		=3D { .type =3D NLA_U32},
+};
+
+static const struct nla_policy qbv_ctrl_policy[TSN_QBV_ATTR_CTRL_MAX + 1] =
=3D {
+	[TSN_QBV_ATTR_CTRL_LISTCOUNT]		=3D { .type =3D NLA_U32},
+	[TSN_QBV_ATTR_CTRL_GATESTATE]		=3D { .type =3D NLA_U8},
+	[TSN_QBV_ATTR_CTRL_CYCLETIME]		=3D { .type =3D NLA_U32},
+	[TSN_QBV_ATTR_CTRL_CYCLETIMEEXT]	=3D { .type =3D NLA_U32},
+	[TSN_QBV_ATTR_CTRL_BASETIME]		=3D { .type =3D NLA_U64},
+	[TSN_QBV_ATTR_CTRL_LISTENTRY]		=3D { .type =3D NLA_NESTED},
+};
+
+static const struct nla_policy qbv_entry_policy[TSN_QBV_ATTR_ENTRY_MAX + 1=
] =3D {
+	[TSN_QBV_ATTR_ENTRY_ID]	=3D { .type =3D NLA_U32},
+	[TSN_QBV_ATTR_ENTRY_GC]	=3D { .type =3D NLA_U8},
+	[TSN_QBV_ATTR_ENTRY_TM]	=3D { .type =3D NLA_U32},
+};
+
+static const struct nla_policy cb_streamid_policy[TSN_STREAMID_ATTR_MAX + =
1] =3D {
+	[TSN_STREAMID_ATTR_INDEX]	=3D { .type =3D NLA_U32},
+	[TSN_STREAMID_ATTR_ENABLE]	=3D { .type =3D NLA_FLAG},
+	[TSN_STREAMID_ATTR_DISABLE]	=3D { .type =3D NLA_FLAG},
+	[TSN_STREAMID_ATTR_STREAM_HANDLE]	=3D { .type =3D NLA_S32},
+	[TSN_STREAMID_ATTR_IFOP]	=3D { .type =3D NLA_U32},
+	[TSN_STREAMID_ATTR_OFOP]	=3D { .type =3D NLA_U32},
+	[TSN_STREAMID_ATTR_IFIP]	=3D { .type =3D NLA_U32},
+	[TSN_STREAMID_ATTR_OFIP]	=3D { .type =3D NLA_U32},
+	[TSN_STREAMID_ATTR_TYPE]	=3D { .type =3D NLA_U8},
+	[TSN_STREAMID_ATTR_NDMAC]	=3D { .type =3D NLA_U64},
+	[TSN_STREAMID_ATTR_NTAGGED]	=3D { .type =3D NLA_U8},
+	[TSN_STREAMID_ATTR_NVID]	=3D { .type =3D NLA_U16},
+	[TSN_STREAMID_ATTR_SMAC]	=3D { .type =3D NLA_U64},
+	[TSN_STREAMID_ATTR_STAGGED]	=3D { .type =3D NLA_U8},
+	[TSN_STREAMID_ATTR_SVID]	=3D { .type =3D NLA_U16},
+	[TSN_STREAMID_ATTR_COUNTERS_PSI] =3D { .type =3D NLA_U64},
+	[TSN_STREAMID_ATTR_COUNTERS_PSO] =3D { .type =3D NLA_U64},
+	[TSN_STREAMID_ATTR_COUNTERS_PSPPI] =3D { .type =3D NLA_U64},
+	[TSN_STREAMID_ATTR_COUNTERS_PSPPO] =3D { .type =3D NLA_U64},
+};
+
+static const struct nla_policy qci_sfi_policy[TSN_QCI_SFI_ATTR_MAX + 1] =
=3D {
+	[TSN_QCI_SFI_ATTR_INDEX]		=3D { .type =3D NLA_U32},
+	[TSN_QCI_SFI_ATTR_ENABLE]		=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_SFI_ATTR_DISABLE]		=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_SFI_ATTR_STREAM_HANDLE]	=3D { .type =3D NLA_S32},
+	[TSN_QCI_SFI_ATTR_PRIO_SPEC]		=3D { .type =3D NLA_S8},
+	[TSN_QCI_SFI_ATTR_GATE_ID]		=3D { .type =3D NLA_U32},
+	[TSN_QCI_SFI_ATTR_FILTER_TYPE]		=3D { .type =3D NLA_U8},
+	[TSN_QCI_SFI_ATTR_FLOW_ID]		=3D { .type =3D NLA_S32},
+	[TSN_QCI_SFI_ATTR_MAXSDU]		=3D { .type =3D NLA_U16},
+	[TSN_QCI_SFI_ATTR_COUNTERS]		=3D {
+		.len =3D sizeof(struct tsn_qci_psfp_sfi_counters)},
+	[TSN_QCI_SFI_ATTR_OVERSIZE_ENABLE]	=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_SFI_ATTR_OVERSIZE]		=3D { .type =3D NLA_FLAG},
+};
+
+static const struct nla_policy qci_sgi_policy[] =3D {
+	[TSN_QCI_SGI_ATTR_INDEX]		=3D { .type =3D NLA_U32},
+	[TSN_QCI_SGI_ATTR_ENABLE]		=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_SGI_ATTR_DISABLE]		=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_SGI_ATTR_CONFCHANGE]		=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_SGI_ATTR_IRXEN]		=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_SGI_ATTR_IRX]			=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_SGI_ATTR_OEXEN]		=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_SGI_ATTR_OEX]			=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_SGI_ATTR_ADMINENTRY]		=3D { .type =3D NLA_NESTED},
+	[TSN_QCI_SGI_ATTR_OPERENTRY]		=3D { .type =3D NLA_NESTED},
+	[TSN_QCI_SGI_ATTR_CCTIME]		=3D { .type =3D NLA_U64},
+	[TSN_QCI_SGI_ATTR_TICKG]		=3D { .type =3D NLA_U32},
+	[TSN_QCI_SGI_ATTR_CUTIME]		=3D { .type =3D NLA_U64},
+	[TSN_QCI_SGI_ATTR_CPENDING]		=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_SGI_ATTR_CCERROR]		=3D { .type =3D NLA_U64},
+};
+
+static const struct nla_policy qci_sgi_ctrl_policy[] =3D {
+	[TSN_SGI_ATTR_CTRL_INITSTATE]		=3D { .type =3D NLA_FLAG},
+	[TSN_SGI_ATTR_CTRL_LEN]			=3D { .type =3D NLA_U8},
+	[TSN_SGI_ATTR_CTRL_CYTIME]		=3D { .type =3D NLA_U32},
+	[TSN_SGI_ATTR_CTRL_CYTIMEEX]		=3D { .type =3D NLA_U32},
+	[TSN_SGI_ATTR_CTRL_BTIME]		=3D { .type =3D NLA_U64},
+	[TSN_SGI_ATTR_CTRL_INITIPV]		=3D { .type =3D NLA_S8},
+	[TSN_SGI_ATTR_CTRL_GCLENTRY]		=3D { .type =3D NLA_NESTED},
+};
+
+static const struct nla_policy qci_sgi_gcl_policy[] =3D {
+	[TSN_SGI_ATTR_GCL_GATESTATE]		=3D { .type =3D NLA_FLAG},
+	[TSN_SGI_ATTR_GCL_IPV]			=3D { .type =3D NLA_S8},
+	[TSN_SGI_ATTR_GCL_INTERVAL]		=3D { .type =3D NLA_U32},
+	[TSN_SGI_ATTR_GCL_OCTMAX]		=3D { .type =3D NLA_U32},
+};
+
+static const struct nla_policy qci_fmi_policy[] =3D {
+	[TSN_QCI_FMI_ATTR_INDEX]	=3D { .type =3D NLA_U32},
+	[TSN_QCI_FMI_ATTR_ENABLE]	=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_FMI_ATTR_DISABLE]	=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_FMI_ATTR_CIR]		=3D { .type =3D NLA_U32},
+	[TSN_QCI_FMI_ATTR_CBS]		=3D { .type =3D NLA_U32},
+	[TSN_QCI_FMI_ATTR_EIR]		=3D { .type =3D NLA_U32},
+	[TSN_QCI_FMI_ATTR_EBS]		=3D { .type =3D NLA_U32},
+	[TSN_QCI_FMI_ATTR_CF]		=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_FMI_ATTR_CM]		=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_FMI_ATTR_DROPYL]	=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_FMI_ATTR_MAREDEN]	=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_FMI_ATTR_MARED]	=3D { .type =3D NLA_FLAG},
+	[TSN_QCI_FMI_ATTR_COUNTERS]	=3D {
+		.len =3D sizeof(struct tsn_qci_psfp_fmi_counters)},
+};
+
+static int tsn_prepare_reply(struct genl_info *info, u8 cmd,
+			     struct sk_buff **skbp, size_t size)
+{
+	struct sk_buff *skb;
+	void *reply;
+
+	/* If new attributes are added, please revisit this allocation
+	 */
+	skb =3D genlmsg_new(size, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	if (!info) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+
+	reply =3D genlmsg_put_reply(skb, info, &tsn_family, 0, cmd);
+	if (!reply) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+
+	*skbp =3D skb;
+	return 0;
+}
+
+static int tsn_mk_reply(struct sk_buff *skb, int aggr, void *data, int len=
)
+{
+    /* add a netlink attribute to a socket buffer */
+	return nla_put(skb, aggr, len, data);
+}
+
+static int tsn_send_reply(struct sk_buff *skb, struct genl_info *info)
+{
+	struct genlmsghdr *genlhdr =3D nlmsg_data(nlmsg_hdr(skb));
+	void *reply =3D genlmsg_data(genlhdr);
+
+	genlmsg_end(skb, reply);
+
+	return genlmsg_reply(skb, info);
+}
+
+static int cmd_attr_echo_message(struct genl_info *info)
+{
+	struct nlattr *na;
+	char *msg;
+	struct sk_buff *rep_skb;
+	size_t size;
+	int ret;
+
+	na =3D info->attrs[TSN_CMD_ATTR_MESG];
+	if (!na)
+		return -EINVAL;
+
+	msg =3D (char *)nla_data(na);
+	pr_info("tsn generic netlink receive echo mesg %s\n", msg);
+
+	size =3D nla_total_size(strlen(msg) + 1);
+
+	ret =3D tsn_prepare_reply(info, TSN_CMD_REPLY, &rep_skb,
+				size + NLMSG_ALIGN(MAX_USER_SIZE));
+	if (ret < 0)
+		return ret;
+
+	ret =3D tsn_mk_reply(rep_skb, TSN_CMD_ATTR_MESG, msg, size);
+	if (ret < 0)
+		goto err;
+
+	return tsn_send_reply(rep_skb, info);
+
+err:
+	nlmsg_free(rep_skb);
+	return ret;
+}
+
+static int cmd_attr_echo_data(struct genl_info *info)
+{
+	struct nlattr *na;
+	s32	data;
+	struct sk_buff *rep_skb;
+	size_t size;
+	int ret;
+
+	/*read data */
+	na =3D info->attrs[TSN_CMD_ATTR_DATA];
+	if (!na)
+		return -EINVAL;
+
+	data =3D nla_get_s32(info->attrs[TSN_CMD_ATTR_DATA]);
+	pr_info("tsn generic netlink receive echo data %d\n", data);
+
+	/* send back */
+	size =3D nla_total_size(sizeof(s32));
+
+	ret =3D tsn_prepare_reply(info, TSN_CMD_REPLY, &rep_skb,
+				size + NLMSG_ALIGN(MAX_USER_SIZE));
+	if (ret < 0)
+		return ret;
+
+	/* netlink lib func */
+	ret =3D nla_put_s32(rep_skb, TSN_CMD_ATTR_DATA, data);
+	if (ret < 0)
+		goto err;
+
+	return tsn_send_reply(rep_skb, info);
+
+err:
+	nlmsg_free(rep_skb);
+	return ret;
+}
+
+static int tsn_echo_cmd(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_CMD_ATTR_MESG])
+		return cmd_attr_echo_message(info);
+	else if (info->attrs[TSN_CMD_ATTR_DATA])
+		return cmd_attr_echo_data(info);
+
+	return -EINVAL;
+}
+
+static int tsn_simple_reply(struct genl_info *info, u32 cmd,
+			    char *portname, s32 retvalue)
+{
+	struct sk_buff *rep_skb;
+	size_t size;
+	int ret;
+
+	/* send back */
+	size =3D nla_total_size(strlen(portname) + 1);
+	size +=3D nla_total_size(sizeof(s32));
+
+	ret =3D tsn_prepare_reply(info, cmd,
+				&rep_skb, size + NLMSG_ALIGN(MAX_USER_SIZE));
+	if (ret < 0)
+		return ret;
+
+	/* netlink lib func */
+	ret =3D nla_put_string(rep_skb, TSN_ATTR_IFNAME, portname);
+	if (ret < 0)
+		return ret;
+
+	ret =3D nla_put_s32(rep_skb, TSN_CMD_ATTR_DATA, retvalue);
+	if (ret < 0)
+		return ret;
+
+	return tsn_send_reply(rep_skb, info);
+}
+
+struct tsn_port *tsn_init_check(struct genl_info *info,
+				struct net_device **ndev)
+{
+	struct nlattr *na;
+	char *portname;
+	struct net_device *netdev;
+	struct tsn_port *port;
+	bool tsn_found =3D false;
+
+	na =3D info->attrs[TSN_ATTR_IFNAME];
+	if (!na) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 "no portname", -TSN_ATTRERR);
+		return NULL;
+	}
+
+	portname =3D (char *)nla_data(na);
+	netdev =3D __dev_get_by_name(genl_info_net(info), portname);
+	if (!netdev) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return NULL;
+	}
+
+	list_for_each_entry(port, &port_list, list) {
+		if (port->netdev =3D=3D netdev) {
+			tsn_found =3D true;
+			break;
+		}
+	}
+
+	if (!tsn_found) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return NULL;
+	}
+
+	*ndev =3D netdev;
+
+	return port;
+}
+
+static int cmd_cb_streamid_set(struct genl_info *info)
+{
+	struct nlattr *na, *sid[TSN_STREAMID_ATTR_MAX + 1];
+	u32 sid_index;
+	u8 iden_type =3D 1;
+	bool enable;
+	int ret;
+	struct net_device *netdev;
+	struct tsn_cb_streamid sidconf;
+	const struct tsn_ops *tsnops;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	memset(&sidconf, 0, sizeof(struct tsn_cb_streamid));
+
+	if (!info->attrs[TSN_ATTR_STREAM_IDENTIFY])
+		return -EINVAL;
+
+	na =3D info->attrs[TSN_ATTR_STREAM_IDENTIFY];
+
+	ret =3D NLA_PARSE_NESTED(sid, TSN_STREAMID_ATTR_MAX,
+			       na, cb_streamid_policy);
+	if (ret)
+		return -EINVAL;
+
+	if (!sid[TSN_STREAMID_ATTR_INDEX])
+		return -EINVAL;
+
+	sid_index =3D nla_get_u32(sid[TSN_STREAMID_ATTR_INDEX]);
+
+	if (sid[TSN_STREAMID_ATTR_ENABLE])
+		enable =3D true;
+	else if (sid[TSN_STREAMID_ATTR_DISABLE])
+		enable =3D false;
+	else
+		return -EINVAL;
+
+	if (!enable)
+		goto loaddev;
+
+	if (sid[TSN_STREAMID_ATTR_TYPE])
+		iden_type =3D nla_get_u8(sid[TSN_STREAMID_ATTR_TYPE]);
+	else
+		return -EINVAL;
+
+	sidconf.type =3D iden_type;
+	switch (iden_type) {
+	case STREAMID_NULL:
+		if (!sid[TSN_STREAMID_ATTR_NDMAC] ||
+		    !sid[TSN_STREAMID_ATTR_NTAGGED] ||
+		    !sid[TSN_STREAMID_ATTR_NVID]) {
+			return -EINVAL;
+		}
+
+		sidconf.para.nid.dmac =3D
+			nla_get_u64(sid[TSN_STREAMID_ATTR_NDMAC]);
+		sidconf.para.nid.tagged =3D
+			nla_get_u8(sid[TSN_STREAMID_ATTR_NTAGGED]);
+		sidconf.para.nid.vid =3D
+			nla_get_u16(sid[TSN_STREAMID_ATTR_NVID]);
+		break;
+	case STREAMID_SMAC_VLAN:
+		/* TODO: not supportted yet */
+		if (!sid[TSN_STREAMID_ATTR_SMAC] ||
+		    !sid[TSN_STREAMID_ATTR_STAGGED] ||
+		    !sid[TSN_STREAMID_ATTR_SVID]) {
+			return -EINVAL;
+		}
+
+		sidconf.para.sid.smac =3D
+			nla_get_u64(sid[TSN_STREAMID_ATTR_SMAC]);
+		sidconf.para.sid.tagged =3D
+			nla_get_u8(sid[TSN_STREAMID_ATTR_STAGGED]);
+		sidconf.para.sid.vid =3D
+			nla_get_u16(sid[TSN_STREAMID_ATTR_SVID]);
+		break;
+	case STREAMID_DMAC_VLAN:
+
+	case STREAMID_IP:
+
+	default:
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	if (sid[TSN_STREAMID_ATTR_STREAM_HANDLE])
+		sidconf.handle =3D
+			nla_get_s32(sid[TSN_STREAMID_ATTR_STREAM_HANDLE]);
+
+	if (sid[TSN_STREAMID_ATTR_IFOP])
+		sidconf.ifac_oport =3D nla_get_u32(sid[TSN_STREAMID_ATTR_IFOP]);
+	if (sid[TSN_STREAMID_ATTR_OFOP])
+		sidconf.ofac_oport =3D nla_get_u32(sid[TSN_STREAMID_ATTR_OFOP]);
+	if (sid[TSN_STREAMID_ATTR_IFIP])
+		sidconf.ifac_iport =3D nla_get_u32(sid[TSN_STREAMID_ATTR_IFIP]);
+	if (sid[TSN_STREAMID_ATTR_OFIP])
+		sidconf.ofac_iport =3D nla_get_u32(sid[TSN_STREAMID_ATTR_OFIP]);
+
+loaddev:
+	if (!tsnops->cb_streamid_set) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -EOPNOTSUPP;
+	}
+
+	tsnops->cb_streamid_set(netdev, sid_index, enable, &sidconf);
+
+	/* simple reply here. To be continue */
+	if (tsn_simple_reply(info, TSN_CMD_REPLY, netdev->name, 0))
+		return -1;
+
+	return 0;
+}
+
+static int tsn_cb_streamid_set(struct sk_buff *skb, struct genl_info *info=
)
+{
+	if (info->attrs[TSN_ATTR_IFNAME]) {
+		cmd_cb_streamid_set(info);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cmd_cb_streamid_get(struct genl_info *info)
+{
+	struct nlattr *na, *sidattr, *sid[TSN_STREAMID_ATTR_MAX + 1];
+	u32 sid_index;
+	struct genlmsghdr *genlhdr;
+	struct sk_buff *rep_skb;
+	int ret, i;
+	int valid;
+	struct net_device *netdev;
+	struct tsn_cb_streamid sidconf;
+	struct tsn_cb_streamid_counters sidcounts;
+	const struct tsn_ops *tsnops;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	memset(&sidconf, 0, sizeof(struct tsn_cb_streamid));
+	memset(&sidcounts, 0, sizeof(struct tsn_cb_streamid_counters));
+
+	if (!info->attrs[TSN_ATTR_STREAM_IDENTIFY])
+		return -EINVAL;
+
+	na =3D info->attrs[TSN_ATTR_STREAM_IDENTIFY];
+
+	ret =3D NLA_PARSE_NESTED(sid, TSN_STREAMID_ATTR_MAX,
+			       na, cb_streamid_policy);
+	if (ret)
+		return -EINVAL;
+
+	if (!sid[TSN_STREAMID_ATTR_INDEX])
+		return -EINVAL;
+
+	sid_index =3D nla_get_u32(sid[TSN_STREAMID_ATTR_INDEX]);
+
+	if (!tsnops->cb_streamid_get) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		ret =3D -EINVAL;
+		goto exit;
+	} else {
+		valid =3D tsnops->cb_streamid_get(netdev, sid_index, &sidconf);
+		if (valid < 0) {
+			tsn_simple_reply(info, TSN_CMD_REPLY,
+					 netdev->name, -TSN_DEVRETERR);
+			return -1;
+		}
+	}
+
+	/* send back */
+	genlhdr =3D info->genlhdr;
+	ret =3D tsn_prepare_reply(info, genlhdr->cmd, &rep_skb,
+				NLMSG_ALIGN(MAX_ATTR_SIZE));
+	if (ret < 0)
+		return ret;
+
+	/* input netlink the parameters */
+	sidattr =3D nla_nest_start(rep_skb, TSN_ATTR_STREAM_IDENTIFY);
+	if (!sidattr) {
+		ret =3D -EINVAL;
+		goto err;
+	}
+
+	nla_put_u32(rep_skb, TSN_STREAMID_ATTR_INDEX, sid_index);
+
+	if (valid =3D=3D 1) {
+		nla_put_flag(rep_skb, TSN_STREAMID_ATTR_ENABLE);
+	} else if (valid =3D=3D 0) {
+		nla_put_flag(rep_skb, TSN_STREAMID_ATTR_DISABLE);
+	} else {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		goto err;
+	}
+
+	nla_put_s32(rep_skb, TSN_STREAMID_ATTR_STREAM_HANDLE, sidconf.handle);
+
+	nla_put_u32(rep_skb, TSN_STREAMID_ATTR_IFOP, sidconf.ifac_oport);
+	nla_put_u32(rep_skb, TSN_STREAMID_ATTR_OFOP, sidconf.ofac_oport);
+	nla_put_u32(rep_skb, TSN_STREAMID_ATTR_IFIP, sidconf.ifac_iport);
+	nla_put_u32(rep_skb, TSN_STREAMID_ATTR_OFIP, sidconf.ofac_iport);
+
+	nla_put_u8(rep_skb, TSN_STREAMID_ATTR_TYPE, sidconf.type);
+
+	switch (sidconf.type) {
+	case STREAMID_NULL:
+		NLA_PUT_U64(rep_skb, TSN_STREAMID_ATTR_NDMAC,
+			    sidconf.para.nid.dmac);
+		nla_put_u16(rep_skb, TSN_STREAMID_ATTR_NVID,
+			    sidconf.para.nid.vid);
+		nla_put_u8(rep_skb, TSN_STREAMID_ATTR_NTAGGED,
+			   sidconf.para.nid.tagged);
+		break;
+	case STREAMID_SMAC_VLAN:
+		NLA_PUT_U64(rep_skb, TSN_STREAMID_ATTR_SMAC,
+			    sidconf.para.sid.smac);
+		nla_put_u16(rep_skb, TSN_STREAMID_ATTR_SVID,
+			    sidconf.para.sid.vid);
+		nla_put_u8(rep_skb, TSN_STREAMID_ATTR_STAGGED,
+			   sidconf.para.sid.tagged);
+		break;
+	case STREAMID_DMAC_VLAN:
+	case STREAMID_IP:
+	default:
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		goto err;
+	}
+
+	if (!tsnops->cb_streamid_counters_get) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		goto err;
+	} else {
+		ret =3D tsnops->cb_streamid_counters_get(netdev,
+							sid_index,
+							&sidcounts);
+		if (ret < 0) {
+			tsn_simple_reply(info, TSN_CMD_REPLY,
+					 netdev->name, -TSN_DEVRETERR);
+			goto err;
+		}
+	}
+
+	NLA_PUT_U64(rep_skb, TSN_STREAMID_ATTR_COUNTERS_PSI,
+		    sidcounts.per_stream.input);
+	NLA_PUT_U64(rep_skb, TSN_STREAMID_ATTR_COUNTERS_PSO,
+		    sidcounts.per_stream.output);
+	for (i =3D 0; i < 32; i++) {
+		NLA_PUT_U64(rep_skb, TSN_STREAMID_ATTR_COUNTERS_PSPPI,
+			    sidcounts.per_streamport[i].input);
+		NLA_PUT_U64(rep_skb, TSN_STREAMID_ATTR_COUNTERS_PSPPO,
+			    sidcounts.per_streamport[i].output);
+	}
+
+	nla_nest_end(rep_skb, sidattr);
+	/* end netlink input the parameters */
+
+	/* netlink lib func */
+	ret =3D nla_put_string(rep_skb, TSN_ATTR_IFNAME, netdev->name);
+	if (ret < 0)
+		goto err;
+
+	ret =3D nla_put_s32(rep_skb, TSN_CMD_ATTR_DATA, 0);
+	if (ret < 0)
+		goto err;
+
+	return tsn_send_reply(rep_skb, info);
+
+err:
+	nlmsg_free(rep_skb);
+exit:
+	return ret;
+}
+
+static int tsn_cb_streamid_get(struct sk_buff *skb, struct genl_info *info=
)
+{
+	if (info->attrs[TSN_ATTR_IFNAME]) {
+		cmd_cb_streamid_get(info);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cmd_qci_sfi_set(struct genl_info *info)
+{
+	struct nlattr *na, *sfi[TSN_QCI_SFI_ATTR_MAX + 1];
+	u32 sfi_handle;
+	bool enable;
+	int ret;
+	struct net_device *netdev;
+	struct tsn_qci_psfp_sfi_conf sficonf;
+	const struct tsn_ops *tsnops;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	memset(&sficonf, 0, sizeof(struct tsn_qci_psfp_sfi_conf));
+
+	if (!info->attrs[TSN_ATTR_QCI_SFI])
+		return -EINVAL;
+
+	na =3D info->attrs[TSN_ATTR_QCI_SFI];
+
+	ret =3D NLA_PARSE_NESTED(sfi, TSN_QCI_SFI_ATTR_MAX, na, qci_sfi_policy);
+	if (ret) {
+		pr_info("tsn: parse value TSN_QCI_SFI_ATTR_MAX  error.");
+		return -EINVAL;
+	}
+
+	if (!sfi[TSN_QCI_SFI_ATTR_INDEX])
+		return -EINVAL;
+
+	sfi_handle =3D nla_get_u32(sfi[TSN_QCI_SFI_ATTR_INDEX]);
+
+	if (sfi[TSN_QCI_SFI_ATTR_ENABLE]) {
+		enable =3D true;
+	} else if (sfi[TSN_QCI_SFI_ATTR_DISABLE]) {
+		enable =3D false;
+		goto loaddrive;
+	} else {
+		pr_err("tsn: must provde ENABLE or DISABLE attribute.\n");
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	if (!sfi[TSN_QCI_SFI_ATTR_GATE_ID]) {
+		pr_err("tsn: must provide stream gate index\n");
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	if (!sfi[TSN_QCI_SFI_ATTR_STREAM_HANDLE])
+		sficonf.stream_handle_spec =3D -1;
+	else
+		sficonf.stream_handle_spec =3D
+			nla_get_s32(sfi[TSN_QCI_SFI_ATTR_STREAM_HANDLE]);
+
+	if (!sfi[TSN_QCI_SFI_ATTR_PRIO_SPEC])
+		sficonf.priority_spec =3D -1;
+	else
+		sficonf.priority_spec =3D
+			nla_get_s8(sfi[TSN_QCI_SFI_ATTR_PRIO_SPEC]);
+
+	sficonf.stream_gate_instance_id =3D
+			nla_get_u32(sfi[TSN_QCI_SFI_ATTR_GATE_ID]);
+
+	if (sfi[TSN_QCI_SFI_ATTR_MAXSDU])
+		sficonf.stream_filter.maximum_sdu_size =3D
+			nla_get_u16(sfi[TSN_QCI_SFI_ATTR_MAXSDU]);
+	else
+		sficonf.stream_filter.maximum_sdu_size =3D 0;
+
+	if (sfi[TSN_QCI_SFI_ATTR_FLOW_ID])
+		sficonf.stream_filter.flow_meter_instance_id =3D
+			nla_get_s32(sfi[TSN_QCI_SFI_ATTR_FLOW_ID]);
+	else
+		sficonf.stream_filter.flow_meter_instance_id =3D -1;
+
+	if (sfi[TSN_QCI_SFI_ATTR_OVERSIZE_ENABLE])
+		sficonf.block_oversize_enable =3D true;
+
+	if (sfi[TSN_QCI_SFI_ATTR_OVERSIZE])
+		sficonf.block_oversize =3D true;
+
+loaddrive:
+	if (!tsnops->qci_sfi_set) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -EINVAL;
+	}
+
+	tsnops->qci_sfi_set(netdev, sfi_handle, enable, &sficonf);
+
+	if (tsn_simple_reply(info, TSN_CMD_REPLY,
+			     netdev->name, TSN_SUCCESS))
+		return -1;
+
+	return 0;
+}
+
+static int tsn_qci_sfi_set(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME]) {
+		cmd_qci_sfi_set(info);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cmd_qci_sfi_get(struct genl_info *info)
+{
+	struct nlattr *na, *sfiattr;
+	struct nlattr *sfi[TSN_QCI_SFI_ATTR_MAX + 1];
+	u32 sfi_handle;
+	struct sk_buff *rep_skb;
+	int ret, valid =3D 0;
+	struct net_device *netdev;
+	struct genlmsghdr *genlhdr;
+	struct tsn_qci_psfp_sfi_conf sficonf;
+	struct tsn_qci_psfp_sfi_counters sficount;
+	const struct tsn_ops *tsnops;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	genlhdr =3D info->genlhdr;
+
+	if (!info->attrs[TSN_ATTR_QCI_SFI])
+		return -EINVAL;
+
+	na =3D info->attrs[TSN_ATTR_QCI_SFI];
+
+	ret =3D NLA_PARSE_NESTED(sfi, TSN_QCI_SFI_ATTR_MAX,
+			       na, qci_sfi_policy);
+	if (ret)
+		return -EINVAL;
+
+	if (!sfi[TSN_QCI_SFI_ATTR_INDEX])
+		return -EINVAL;
+
+	sfi_handle =3D nla_get_u32(sfi[TSN_QCI_SFI_ATTR_INDEX]);
+
+	memset(&sficonf, 0, sizeof(struct tsn_qci_psfp_sfi_conf));
+	memset(&sficount, 0, sizeof(struct tsn_qci_psfp_sfi_counters));
+
+	if (!tsnops->qci_sfi_get || !tsnops->qci_sfi_counters_get) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		ret =3D -EINVAL;
+		goto exit;
+	} else {
+		valid =3D tsnops->qci_sfi_get(netdev, sfi_handle, &sficonf);
+
+		if (valid < 0) {
+			tsn_simple_reply(info, TSN_CMD_REPLY,
+					 netdev->name, -TSN_DEVRETERR);
+			return -1;
+		}
+
+		tsnops->qci_sfi_counters_get(netdev, sfi_handle, &sficount);
+	}
+
+	ret =3D tsn_prepare_reply(info, genlhdr->cmd,
+				&rep_skb, NLMSG_ALIGN(MAX_ATTR_SIZE));
+	if (ret < 0)
+		return ret;
+
+	if (nla_put_string(rep_skb, TSN_ATTR_IFNAME, netdev->name))
+		goto err;
+
+	sfiattr =3D nla_nest_start(rep_skb, TSN_ATTR_QCI_SFI);
+	if (!sfiattr) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		ret =3D -EINVAL;
+		goto err;
+	}
+
+	nla_put_u32(rep_skb, TSN_QCI_SFI_ATTR_INDEX, sfi_handle);
+
+	if (valid)
+		nla_put_flag(rep_skb, TSN_QCI_SFI_ATTR_ENABLE);
+	else
+		nla_put_flag(rep_skb, TSN_QCI_SFI_ATTR_DISABLE);
+
+	nla_put_s32(rep_skb, TSN_QCI_SFI_ATTR_STREAM_HANDLE,
+		    sficonf.stream_handle_spec);
+	nla_put_s8(rep_skb, TSN_QCI_SFI_ATTR_PRIO_SPEC,
+		   sficonf.priority_spec);
+	nla_put_u32(rep_skb, TSN_QCI_SFI_ATTR_GATE_ID,
+		    sficonf.stream_gate_instance_id);
+
+	if (sficonf.stream_filter.maximum_sdu_size)
+		nla_put_u16(rep_skb, TSN_QCI_SFI_ATTR_MAXSDU,
+			    sficonf.stream_filter.maximum_sdu_size);
+	if (sficonf.stream_filter.flow_meter_instance_id >=3D 0)
+		nla_put_s32(rep_skb, TSN_QCI_SFI_ATTR_FLOW_ID,
+			    sficonf.stream_filter.flow_meter_instance_id);
+
+	if (sficonf.block_oversize_enable)
+		nla_put_flag(rep_skb, TSN_QCI_SFI_ATTR_OVERSIZE_ENABLE);
+	if (sficonf.block_oversize)
+		nla_put_flag(rep_skb, TSN_QCI_SFI_ATTR_OVERSIZE);
+
+	nla_put(rep_skb, TSN_QCI_SFI_ATTR_COUNTERS,
+		sizeof(struct tsn_qci_psfp_sfi_counters), &sficount);
+
+	nla_nest_end(rep_skb, sfiattr);
+
+	return tsn_send_reply(rep_skb, info);
+err:
+	nlmsg_free(rep_skb);
+	tsn_simple_reply(info, TSN_CMD_REPLY,
+			 netdev->name, -TSN_ATTRERR);
+exit:
+	return ret;
+}
+
+static int tsn_qci_sfi_get(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME]) {
+		cmd_qci_sfi_get(info);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cmd_qci_sfi_counters_get(struct genl_info *info)
+{
+	struct nlattr *na, *sfiattr;
+	struct nlattr *sfi[TSN_QCI_SFI_ATTR_MAX + 1];
+	u32 sfi_handle;
+	struct sk_buff *rep_skb;
+	int ret;
+	struct net_device *netdev;
+	struct genlmsghdr *genlhdr;
+	struct tsn_qci_psfp_sfi_counters sficount;
+	const struct tsn_ops *tsnops;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	genlhdr =3D info->genlhdr;
+
+	if (!info->attrs[TSN_ATTR_QCI_SFI])
+		return -EINVAL;
+
+	na =3D info->attrs[TSN_ATTR_QCI_SFI];
+
+	ret =3D NLA_PARSE_NESTED(sfi, TSN_QCI_SFI_ATTR_MAX,
+			       na, qci_sfi_policy);
+	if (ret)
+		return -EINVAL;
+
+	if (!sfi[TSN_QCI_SFI_ATTR_INDEX])
+		return -EINVAL;
+
+	sfi_handle =3D nla_get_u32(sfi[TSN_QCI_SFI_ATTR_INDEX]);
+
+	memset(&sficount, 0, sizeof(struct tsn_qci_psfp_sfi_counters));
+	if (!tsnops->qci_sfi_counters_get) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -1;
+	}
+
+	ret =3D tsnops->qci_sfi_counters_get(netdev, sfi_handle, &sficount);
+	if (ret < 0) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_DEVRETERR);
+		return -EINVAL;
+	}
+
+	ret =3D tsn_prepare_reply(info, genlhdr->cmd, &rep_skb,
+				NLMSG_ALIGN(MAX_ATTR_SIZE));
+	if (ret < 0)
+		return ret;
+
+	if (nla_put_string(rep_skb, TSN_ATTR_IFNAME, netdev->name))
+		goto err;
+
+	sfiattr =3D nla_nest_start(rep_skb, TSN_ATTR_QCI_SFI);
+	if (!sfiattr) {
+		ret =3D -EINVAL;
+		goto err;
+	}
+
+	nla_put_u32(rep_skb, TSN_QCI_SFI_ATTR_INDEX, sfi_handle);
+
+	tsnops->qci_sfi_counters_get(netdev, sfi_handle, &sficount);
+
+	nla_put(rep_skb, TSN_QCI_SFI_ATTR_COUNTERS,
+		sizeof(struct tsn_qci_psfp_sfi_counters), &sficount);
+
+	nla_nest_end(rep_skb, sfiattr);
+
+	return tsn_send_reply(rep_skb, info);
+err:
+	nlmsg_free(rep_skb);
+	tsn_simple_reply(info, TSN_CMD_REPLY, netdev->name, -TSN_ATTRERR);
+	return ret;
+}
+
+static int tsn_qci_sfi_counters_get(struct sk_buff *skb, struct genl_info =
*info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME]) {
+		cmd_qci_sfi_counters_get(info);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cmd_qci_sgi_set(struct genl_info *info)
+{
+	struct nlattr *na;
+	struct nlattr *sgia[TSN_QCI_SGI_ATTR_MAX + 1];
+	struct nlattr *admin[TSN_SGI_ATTR_CTRL_MAX + 1];
+	int ret =3D 0;
+	struct net_device *netdev;
+	const struct tsn_ops *tsnops;
+	struct tsn_qci_psfp_sgi_conf sgi;
+	struct tsn_qci_psfp_gcl *gcl =3D NULL;
+	u16 sgi_handle =3D 0;
+	u16 listcount =3D 0;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	memset(&sgi, 0, sizeof(struct tsn_qci_psfp_sgi_conf));
+
+	if (!info->attrs[TSN_ATTR_QCI_SGI]) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	na =3D info->attrs[TSN_ATTR_QCI_SGI];
+
+	ret =3D NLA_PARSE_NESTED(sgia, TSN_QCI_SGI_ATTR_MAX,
+			       na, qci_sgi_policy);
+	if (ret) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	if (sgia[TSN_QCI_SGI_ATTR_ENABLE] && sgia[TSN_QCI_SGI_ATTR_DISABLE]) {
+		pr_err("tsn: enable or disable?\n");
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -1;
+	}
+
+	if (sgia[TSN_QCI_SGI_ATTR_INDEX])
+		sgi_handle =3D nla_get_u32(sgia[TSN_QCI_SGI_ATTR_INDEX]);
+
+	if (sgia[TSN_QCI_SGI_ATTR_DISABLE]) {
+		sgi.gate_enabled =3D 0;
+		goto loaddev;
+	} else {
+		/* set default to be enable*/
+		sgi.gate_enabled =3D 1;
+	}
+
+	if (sgia[TSN_QCI_SGI_ATTR_CONFCHANGE])
+		sgi.config_change =3D 1;
+
+	if (sgia[TSN_QCI_SGI_ATTR_IRXEN])
+		sgi.block_invalid_rx_enable =3D 1;
+
+	if (sgia[TSN_QCI_SGI_ATTR_IRX])
+		sgi.block_invalid_rx =3D 1;
+
+	if (sgia[TSN_QCI_SGI_ATTR_OEXEN])
+		sgi.block_octets_exceeded_enable =3D 1;
+
+	if (sgia[TSN_QCI_SGI_ATTR_OEX])
+		sgi.block_octets_exceeded =3D 1;
+
+	if (sgia[TSN_QCI_SGI_ATTR_ADMINENTRY]) {
+		struct nlattr *entry;
+		int rem;
+		int count =3D 0;
+
+		na =3D sgia[TSN_QCI_SGI_ATTR_ADMINENTRY];
+		ret =3D NLA_PARSE_NESTED(admin, TSN_SGI_ATTR_CTRL_MAX,
+				       na, qci_sgi_ctrl_policy);
+
+		/* Other parameters in admin control */
+		if (admin[TSN_SGI_ATTR_CTRL_INITSTATE])
+			sgi.admin.gate_states =3D 1;
+
+		if (admin[TSN_SGI_ATTR_CTRL_CYTIME])
+			sgi.admin.cycle_time =3D
+				nla_get_u32(admin[TSN_SGI_ATTR_CTRL_CYTIME]);
+
+		if (admin[TSN_SGI_ATTR_CTRL_CYTIMEEX])
+			sgi.admin.cycle_time_extension =3D
+				nla_get_u32(admin[TSN_SGI_ATTR_CTRL_CYTIMEEX]);
+
+		if (admin[TSN_SGI_ATTR_CTRL_BTIME])
+			sgi.admin.base_time =3D
+				nla_get_u64(admin[TSN_SGI_ATTR_CTRL_BTIME]);
+
+		if (admin[TSN_SGI_ATTR_CTRL_INITIPV])
+			sgi.admin.init_ipv =3D
+				nla_get_s8(admin[TSN_SGI_ATTR_CTRL_INITIPV]);
+		else
+			sgi.admin.init_ipv =3D -1;
+
+		if (admin[TSN_SGI_ATTR_CTRL_LEN]) {
+			sgi.admin.control_list_length =3D
+				nla_get_u8(admin[TSN_SGI_ATTR_CTRL_LEN]);
+			listcount =3D sgi.admin.control_list_length;
+		}
+
+		if (!listcount)
+			goto loaddev;
+
+		gcl =3D kmalloc_array(listcount, sizeof(*gcl), GFP_KERNEL);
+
+		memset(gcl, 0, listcount * sizeof(struct tsn_qci_psfp_gcl));
+
+		/* Check the whole admin attrs,
+		 * checkout the TSN_SGI_ATTR_CTRL_GCLENTRY attributes
+		 */
+		nla_for_each_nested(entry, na, rem) {
+			struct nlattr *gcl_entry[TSN_SGI_ATTR_GCL_MAX + 1];
+			struct nlattr *ti, *om;
+
+			if (nla_type(entry) !=3D TSN_SGI_ATTR_CTRL_GCLENTRY)
+				continue;
+
+			/* parse each TSN_SGI_ATTR_CTRL_GCLENTRY */
+			ret =3D NLA_PARSE_NESTED(gcl_entry, TSN_SGI_ATTR_GCL_MAX,
+					       entry, qci_sgi_gcl_policy);
+			/* Parse gate control list */
+			if (gcl_entry[TSN_SGI_ATTR_GCL_GATESTATE])
+				(gcl + count)->gate_state =3D 1;
+
+			if (gcl_entry[TSN_SGI_ATTR_GCL_IPV])
+				(gcl + count)->ipv =3D
+				 nla_get_s8(gcl_entry[TSN_SGI_ATTR_GCL_IPV]);
+
+			if (gcl_entry[TSN_SGI_ATTR_GCL_INTERVAL]) {
+				ti =3D gcl_entry[TSN_SGI_ATTR_GCL_INTERVAL];
+				(gcl + count)->time_interval =3D nla_get_u32(ti);
+			}
+
+			if (gcl_entry[TSN_SGI_ATTR_GCL_OCTMAX]) {
+				om =3D gcl_entry[TSN_SGI_ATTR_GCL_OCTMAX];
+				(gcl + count)->octet_max =3D nla_get_u32(om);
+			}
+
+			count++;
+
+			if (count >=3D listcount)
+				break;
+		}
+
+		if (count < listcount) {
+			tsn_simple_reply(info, TSN_CMD_REPLY,
+					 netdev->name, -TSN_ATTRERR);
+			pr_err("tsn: count less than TSN_SGI_ATTR_CTRL_LEN\n");
+			kfree(gcl);
+			return -EINVAL;
+		}
+
+	} else {
+		pr_info("tsn: no admin list parameters setting\n");
+	}
+
+loaddev:
+	if (!tsnops->qci_sgi_set) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		kfree(gcl);
+		return -EINVAL;
+	}
+
+	sgi.admin.gcl =3D gcl;
+
+	ret =3D tsnops->qci_sgi_set(netdev, sgi_handle, &sgi);
+	kfree(gcl);
+	if (!ret)
+		return tsn_simple_reply(info, TSN_CMD_REPLY,
+					netdev->name, TSN_SUCCESS);
+
+	tsn_simple_reply(info, TSN_CMD_REPLY,
+			 netdev->name, -TSN_DEVRETERR);
+	return -1;
+}
+
+static int tsn_qci_sgi_set(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME]) {
+		cmd_qci_sgi_set(info);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cmd_qci_sgi_get(struct genl_info *info)
+{
+	struct nlattr *na, *sgiattr, *adminattr, *sglattr;
+	struct nlattr *sgi[TSN_QCI_SGI_ATTR_MAX + 1];
+	struct sk_buff *rep_skb;
+	int ret;
+	struct net_device *netdev;
+	struct genlmsghdr *genlhdr;
+	struct tsn_qci_psfp_sgi_conf sgiadmin;
+	struct tsn_qci_psfp_gcl *gcl =3D NULL;
+	const struct tsn_ops *tsnops;
+	u16 sgi_handle;
+	u8 listcount, i;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	if (!info->attrs[TSN_ATTR_QCI_SGI]) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		pr_err("tsn: no sgi handle input\n");
+		return -EINVAL;
+	}
+
+	na =3D info->attrs[TSN_ATTR_QCI_SGI];
+
+	ret =3D NLA_PARSE_NESTED(sgi, TSN_QCI_SGI_ATTR_MAX,
+			       na, qci_sgi_policy);
+	if (ret)
+		return -EINVAL;
+
+	if (!sgi[TSN_QCI_SGI_ATTR_INDEX]) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		pr_err("tsn: no sgi handle input\n");
+		return -EINVAL;
+	}
+
+	sgi_handle =3D nla_get_u32(sgi[TSN_QCI_SGI_ATTR_INDEX]);
+
+	/* Get config data from device */
+	genlhdr =3D info->genlhdr;
+
+	memset(&sgiadmin, 0, sizeof(struct tsn_qci_psfp_sgi_conf));
+
+	if (!tsnops->qci_sgi_get) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -1;
+	}
+
+	ret =3D tsnops->qci_sgi_get(netdev, sgi_handle, &sgiadmin);
+	if (ret < 0) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_DEVRETERR);
+		return -1;
+	}
+
+	/* Form netlink reply data */
+	ret =3D tsn_prepare_reply(info, genlhdr->cmd,
+				&rep_skb, NLMSG_ALIGN(MAX_ATTR_SIZE));
+	if (ret < 0)
+		return ret;
+
+	if (nla_put_string(rep_skb, TSN_ATTR_IFNAME, netdev->name))
+		return -EMSGSIZE;
+
+	/* Down 1 */
+	sgiattr =3D nla_nest_start(rep_skb, TSN_ATTR_QCI_SGI);
+	if (!sgiattr)
+		return -EMSGSIZE;
+
+	nla_put_u32(rep_skb, TSN_QCI_SGI_ATTR_INDEX, sgi_handle);
+
+	/* Gate enable? sgiadmin.gate_enabled */
+	if (sgiadmin.gate_enabled)
+		nla_put_flag(rep_skb, TSN_QCI_SGI_ATTR_ENABLE);
+	else
+		nla_put_flag(rep_skb, TSN_QCI_SGI_ATTR_DISABLE);
+
+	if (sgiadmin.config_change)
+		nla_put_flag(rep_skb, TSN_QCI_SGI_ATTR_CONFCHANGE);
+
+	if (sgiadmin.block_invalid_rx_enable)
+		nla_put_flag(rep_skb, TSN_QCI_SGI_ATTR_IRXEN);
+
+	if (sgiadmin.block_invalid_rx)
+		nla_put_flag(rep_skb, TSN_QCI_SGI_ATTR_IRX);
+
+	if (sgiadmin.block_octets_exceeded_enable)
+		nla_put_flag(rep_skb, TSN_QCI_SGI_ATTR_OEXEN);
+
+	if (sgiadmin.block_octets_exceeded)
+		nla_put_flag(rep_skb, TSN_QCI_SGI_ATTR_OEX);
+
+	/* Administration Down 2 */
+	adminattr =3D nla_nest_start(rep_skb, TSN_QCI_SGI_ATTR_ADMINENTRY);
+	if (!adminattr)
+		return -EMSGSIZE;
+
+	if (sgiadmin.admin.gate_states)
+		nla_put_flag(rep_skb, TSN_SGI_ATTR_CTRL_INITSTATE);
+
+	nla_put_u32(rep_skb, TSN_SGI_ATTR_CTRL_CYTIME,
+		    sgiadmin.admin.cycle_time);
+
+	nla_put_u32(rep_skb, TSN_SGI_ATTR_CTRL_CYTIMEEX,
+		    sgiadmin.admin.cycle_time_extension);
+	NLA_PUT_U64(rep_skb, TSN_SGI_ATTR_CTRL_BTIME,
+		    sgiadmin.admin.base_time);
+	nla_put_u8(rep_skb, TSN_SGI_ATTR_CTRL_INITIPV,
+		   sgiadmin.admin.init_ipv);
+
+	listcount =3D sgiadmin.admin.control_list_length;
+	if (!listcount)
+		goto out1;
+
+	if (!sgiadmin.admin.gcl) {
+		pr_err("error: no gate control list\n");
+		ret =3D -TSN_DEVRETERR;
+		goto err;
+	}
+
+	gcl =3D sgiadmin.admin.gcl;
+
+	/* loop list */
+	for (i =3D 0; i < listcount; i++) {
+		s8 ipv;
+		u32 ti, omax;
+
+		if (!(gcl + i)) {
+			pr_err("error: list count too big\n");
+			ret =3D -TSN_DEVRETERR;
+			kfree(sgiadmin.admin.gcl);
+			goto err;
+		}
+
+		/* Adminastration entry down 3 */
+		sglattr =3D nla_nest_start(rep_skb, TSN_SGI_ATTR_CTRL_GCLENTRY);
+		if (!sglattr)
+			return -EMSGSIZE;
+		ipv =3D (gcl + i)->ipv;
+		ti =3D (gcl + i)->time_interval;
+		omax =3D (gcl + i)->octet_max;
+
+		if ((gcl + i)->gate_state)
+			nla_put_flag(rep_skb, TSN_SGI_ATTR_GCL_GATESTATE);
+
+		nla_put_s8(rep_skb, TSN_SGI_ATTR_GCL_IPV, ipv);
+		nla_put_u32(rep_skb, TSN_SGI_ATTR_GCL_INTERVAL, ti);
+		nla_put_u32(rep_skb, TSN_SGI_ATTR_GCL_OCTMAX, omax);
+
+		/* End administration entry down 3 */
+		nla_nest_end(rep_skb, sglattr);
+	}
+
+	kfree(sgiadmin.admin.gcl);
+	nla_put_u8(rep_skb, TSN_SGI_ATTR_CTRL_LEN, listcount);
+
+out1:
+	/* End adminastration down 2 */
+	nla_nest_end(rep_skb, adminattr);
+
+	/* End down 1 */
+	nla_nest_end(rep_skb, sgiattr);
+
+	return tsn_send_reply(rep_skb, info);
+err:
+	nlmsg_free(rep_skb);
+	tsn_simple_reply(info, TSN_CMD_REPLY, netdev->name, ret);
+	return -1;
+}
+
+static int tsn_qci_sgi_get(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME]) {
+		cmd_qci_sgi_get(info);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cmd_qci_sgi_status_get(struct genl_info *info)
+{
+	struct nlattr *na, *sgiattr, *operattr, *sglattr;
+	struct nlattr *sgi[TSN_QCI_SGI_ATTR_MAX + 1];
+	struct sk_buff *rep_skb;
+	int ret;
+	struct net_device *netdev;
+	struct genlmsghdr *genlhdr;
+	struct tsn_psfp_sgi_status sgistat;
+	struct tsn_qci_psfp_gcl *gcl =3D NULL;
+	const struct tsn_ops *tsnops;
+	u16 sgi_handle;
+	u8 listcount;
+	int valid, i;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	if (!info->attrs[TSN_ATTR_QCI_SGI]) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		pr_err("tsn: no sgi handle input\n");
+		return -EINVAL;
+	}
+
+	na =3D info->attrs[TSN_ATTR_QCI_SGI];
+
+	ret =3D NLA_PARSE_NESTED(sgi, TSN_QCI_SGI_ATTR_MAX,
+			       na, qci_sgi_policy);
+	if (ret)
+		return -EINVAL;
+
+	if (!sgi[TSN_QCI_SGI_ATTR_INDEX]) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		pr_err("tsn: no sgi handle input\n");
+		return -EINVAL;
+	}
+
+	sgi_handle =3D nla_get_u32(sgi[TSN_QCI_SGI_ATTR_INDEX]);
+
+	/* Get status data from device */
+	genlhdr =3D info->genlhdr;
+
+	memset(&sgistat, 0, sizeof(struct tsn_psfp_sgi_status));
+
+	if (!tsnops->qci_sgi_status_get) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -1;
+	}
+
+	valid =3D tsnops->qci_sgi_status_get(netdev, sgi_handle, &sgistat);
+	if (valid < 0) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_DEVRETERR);
+		return -1;
+	}
+
+	/* Form netlink reply data */
+	ret =3D tsn_prepare_reply(info, genlhdr->cmd,
+				&rep_skb, NLMSG_ALIGN(MAX_ATTR_SIZE));
+	if (ret < 0)
+		return ret;
+
+	if (nla_put_string(rep_skb, TSN_ATTR_IFNAME, netdev->name))
+		return -EMSGSIZE;
+
+	/* Down 1 */
+	sgiattr =3D nla_nest_start(rep_skb, TSN_ATTR_QCI_SGI);
+	if (!sgiattr)
+		return -EMSGSIZE;
+
+	nla_put_u32(rep_skb, TSN_QCI_SGI_ATTR_INDEX, sgi_handle);
+
+	/* Gate enable? */
+	if (valid =3D=3D 1)
+		nla_put_flag(rep_skb, TSN_QCI_SGI_ATTR_ENABLE);
+	else
+		nla_put_flag(rep_skb, TSN_QCI_SGI_ATTR_DISABLE);
+
+	nla_put_u32(rep_skb, TSN_QCI_SGI_ATTR_TICKG,
+		    sgistat.tick_granularity);
+	NLA_PUT_U64(rep_skb, TSN_QCI_SGI_ATTR_CCTIME,
+		    sgistat.config_change_time);
+	NLA_PUT_U64(rep_skb, TSN_QCI_SGI_ATTR_CUTIME,
+		    sgistat.current_time);
+	NLA_PUT_U64(rep_skb, TSN_QCI_SGI_ATTR_CCERROR,
+		    sgistat.config_change_error);
+
+	if (sgistat.config_pending)
+		nla_put_flag(rep_skb, TSN_QCI_SGI_ATTR_CPENDING);
+
+	/* operation Down 2 */
+	operattr =3D nla_nest_start(rep_skb, TSN_QCI_SGI_ATTR_OPERENTRY);
+	if (!operattr)
+		return -EMSGSIZE;
+
+	if (sgistat.oper.gate_states)
+		nla_put_flag(rep_skb, TSN_SGI_ATTR_CTRL_INITSTATE);
+
+	nla_put_u32(rep_skb, TSN_SGI_ATTR_CTRL_CYTIME,
+		    sgistat.oper.cycle_time);
+
+	nla_put_u32(rep_skb, TSN_SGI_ATTR_CTRL_CYTIMEEX,
+		    sgistat.oper.cycle_time_extension);
+	NLA_PUT_U64(rep_skb, TSN_SGI_ATTR_CTRL_BTIME,
+		    sgistat.oper.base_time);
+	nla_put_u8(rep_skb, TSN_SGI_ATTR_CTRL_INITIPV,
+		   sgistat.oper.init_ipv);
+
+	/* Loop list */
+	listcount =3D sgistat.oper.control_list_length;
+	if (!listcount)
+		goto out1;
+
+	if (!sgistat.oper.gcl) {
+		pr_err("error: list lenghth is not zero!\n");
+		ret =3D -TSN_DEVRETERR;
+		goto err;
+	}
+
+	gcl =3D sgistat.oper.gcl;
+
+	/* loop list */
+	for (i =3D 0; i < listcount; i++) {
+		s8 ipv;
+		u32 ti, omax;
+
+		if (!(gcl + i)) {
+			pr_err("error: list count too big\n");
+			ret =3D -TSN_DEVRETERR;
+			kfree(sgistat.oper.gcl);
+			goto err;
+		}
+
+		/* Operation entry down 3 */
+		sglattr =3D nla_nest_start(rep_skb, TSN_SGI_ATTR_CTRL_GCLENTRY);
+		if (!sglattr)
+			return -EMSGSIZE;
+		ipv =3D (gcl + i)->ipv;
+		ti =3D (gcl + i)->time_interval;
+		omax =3D (gcl + i)->octet_max;
+
+		if ((gcl + i)->gate_state)
+			nla_put_flag(rep_skb, TSN_SGI_ATTR_GCL_GATESTATE);
+
+		nla_put_s8(rep_skb, TSN_SGI_ATTR_GCL_IPV, ipv);
+		nla_put_u32(rep_skb, TSN_SGI_ATTR_GCL_INTERVAL, ti);
+		nla_put_u32(rep_skb, TSN_SGI_ATTR_GCL_OCTMAX, omax);
+
+		/* End operation entry down 3 */
+		nla_nest_end(rep_skb, sglattr);
+	}
+
+	kfree(sgistat.oper.gcl);
+	nla_put_u8(rep_skb, TSN_SGI_ATTR_CTRL_LEN, listcount);
+out1:
+	/* End operation down 2 */
+	nla_nest_end(rep_skb, operattr);
+
+	/* End down 1 */
+	nla_nest_end(rep_skb, sgiattr);
+
+	return tsn_send_reply(rep_skb, info);
+err:
+	nlmsg_free(rep_skb);
+	tsn_simple_reply(info, TSN_CMD_REPLY, netdev->name, -TSN_ATTRERR);
+	return -1;
+}
+
+static int tsn_qci_sgi_status_get(struct sk_buff *skb, struct genl_info *i=
nfo)
+{
+	if (info->attrs[TSN_ATTR_IFNAME]) {
+		cmd_qci_sgi_status_get(info);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cmd_qci_fmi_set(struct genl_info *info)
+{
+	struct nlattr *na, *fmi[TSN_QCI_FMI_ATTR_MAX + 1];
+	u32 index;
+	int ret;
+	struct net_device *netdev;
+	struct tsn_qci_psfp_fmi fmiconf;
+	const struct tsn_ops *tsnops;
+	bool enable =3D 0;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	memset(&fmiconf, 0, sizeof(struct tsn_qci_psfp_fmi));
+
+	if (!info->attrs[TSN_ATTR_QCI_FMI])
+		return -EINVAL;
+
+	na =3D info->attrs[TSN_ATTR_QCI_FMI];
+
+	ret =3D NLA_PARSE_NESTED(fmi, TSN_QCI_FMI_ATTR_MAX, na, qci_fmi_policy);
+	if (ret) {
+		pr_info("tsn: parse value TSN_QCI_FMI_ATTR_MAX  error.");
+		return -EINVAL;
+	}
+
+	if (!fmi[TSN_QCI_FMI_ATTR_INDEX])
+		return -EINVAL;
+
+	index =3D nla_get_u32(fmi[TSN_QCI_FMI_ATTR_INDEX]);
+
+	if (fmi[TSN_QCI_FMI_ATTR_DISABLE])
+		goto loaddev;
+
+	enable =3D 1;
+
+	if (fmi[TSN_QCI_FMI_ATTR_CIR])
+		fmiconf.cir =3D nla_get_u32(fmi[TSN_QCI_FMI_ATTR_CIR]);
+
+	if (fmi[TSN_QCI_FMI_ATTR_CBS])
+		fmiconf.cbs =3D nla_get_u32(fmi[TSN_QCI_FMI_ATTR_CBS]);
+
+	if (fmi[TSN_QCI_FMI_ATTR_EIR])
+		fmiconf.eir =3D nla_get_u32(fmi[TSN_QCI_FMI_ATTR_EIR]);
+
+	if (fmi[TSN_QCI_FMI_ATTR_EBS])
+		fmiconf.ebs =3D nla_get_u32(fmi[TSN_QCI_FMI_ATTR_EBS]);
+
+	if (fmi[TSN_QCI_FMI_ATTR_CF])
+		fmiconf.cf =3D 1;
+
+	if (fmi[TSN_QCI_FMI_ATTR_CM])
+		fmiconf.cm =3D 1;
+
+	if (fmi[TSN_QCI_FMI_ATTR_DROPYL])
+		fmiconf.drop_on_yellow =3D 1;
+
+	if (fmi[TSN_QCI_FMI_ATTR_MAREDEN])
+		fmiconf.mark_red_enable =3D 1;
+
+	if (fmi[TSN_QCI_FMI_ATTR_MARED])
+		fmiconf.mark_red =3D 1;
+
+loaddev:
+
+	if (!tsnops->qci_fmi_set) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -EINVAL;
+	}
+
+	tsnops->qci_fmi_set(netdev, index, enable, &fmiconf);
+
+	if (tsn_simple_reply(info, TSN_CMD_REPLY,
+			     netdev->name, TSN_SUCCESS))
+		return -1;
+
+	return 0;
+}
+
+static int tsn_qci_fmi_set(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME]) {
+		cmd_qci_fmi_set(info);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cmd_qci_fmi_get(struct genl_info *info)
+{
+	struct nlattr *na, *fmi[TSN_QCI_FMI_ATTR_MAX + 1], *fmiattr;
+	u32 index;
+	struct sk_buff *rep_skb;
+	int ret;
+	struct net_device *netdev;
+	struct tsn_qci_psfp_fmi fmiconf;
+	struct tsn_qci_psfp_fmi_counters counters;
+	const struct tsn_ops *tsnops;
+	struct genlmsghdr *genlhdr;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	if (!info->attrs[TSN_ATTR_QCI_FMI])
+		return -EINVAL;
+
+	na =3D info->attrs[TSN_ATTR_QCI_FMI];
+
+	ret =3D NLA_PARSE_NESTED(fmi, TSN_QCI_FMI_ATTR_MAX,
+			       na, qci_fmi_policy);
+	if (ret) {
+		pr_info("tsn: parse value TSN_QCI_FMI_ATTR_MAX  error.");
+		return -EINVAL;
+	}
+
+	if (!fmi[TSN_QCI_FMI_ATTR_INDEX])
+		return -EINVAL;
+
+	index =3D nla_get_u32(fmi[TSN_QCI_FMI_ATTR_INDEX]);
+
+	/* Get data from device */
+	memset(&fmiconf, 0, sizeof(struct tsn_qci_psfp_fmi));
+	memset(&counters, 0, sizeof(struct tsn_qci_psfp_fmi_counters));
+
+	if (!tsnops->qci_fmi_get) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -EINVAL;
+	}
+
+	tsnops->qci_fmi_get(netdev, index, &fmiconf, &counters);
+
+	genlhdr =3D info->genlhdr;
+
+	/* Form netlink reply data */
+	ret =3D tsn_prepare_reply(info, genlhdr->cmd,
+				&rep_skb, NLMSG_ALIGN(MAX_ATTR_SIZE));
+	if (ret < 0)
+		return ret;
+
+	if (nla_put_string(rep_skb, TSN_ATTR_IFNAME, netdev->name))
+		return -EMSGSIZE;
+
+	fmiattr =3D nla_nest_start(rep_skb, TSN_ATTR_QCI_FMI);
+	if (!fmiattr)
+		return -EMSGSIZE;
+
+	nla_put_u32(rep_skb, TSN_QCI_FMI_ATTR_INDEX, index);
+
+	nla_put_u32(rep_skb, TSN_QCI_FMI_ATTR_CIR, fmiconf.cir);
+	nla_put_u32(rep_skb, TSN_QCI_FMI_ATTR_CBS, fmiconf.cbs);
+	nla_put_u32(rep_skb, TSN_QCI_FMI_ATTR_EIR, fmiconf.eir);
+	nla_put_u32(rep_skb, TSN_QCI_FMI_ATTR_EBS, fmiconf.ebs);
+
+	if (fmiconf.cf)
+		nla_put_flag(rep_skb, TSN_QCI_FMI_ATTR_CF);
+
+	if (fmiconf.cm)
+		nla_put_flag(rep_skb, TSN_QCI_FMI_ATTR_CM);
+
+	if (fmiconf.drop_on_yellow)
+		nla_put_flag(rep_skb, TSN_QCI_FMI_ATTR_DROPYL);
+
+	if (fmiconf.mark_red_enable)
+		nla_put_flag(rep_skb, TSN_QCI_FMI_ATTR_MAREDEN);
+
+	if (fmiconf.mark_red)
+		nla_put_flag(rep_skb, TSN_QCI_FMI_ATTR_MAREDEN);
+
+	nla_put(rep_skb, TSN_QCI_FMI_ATTR_COUNTERS,
+		sizeof(struct tsn_qci_psfp_fmi_counters), &counters);
+
+	nla_nest_end(rep_skb, fmiattr);
+
+	return tsn_send_reply(rep_skb, info);
+
+	nlmsg_free(rep_skb);
+	tsn_simple_reply(info, TSN_CMD_REPLY,
+			 netdev->name, -TSN_ATTRERR);
+	return -1;
+}
+
+static int tsn_qci_fmi_get(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME]) {
+		cmd_qci_fmi_get(info);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cmd_qbv_set(struct genl_info *info)
+{
+	struct nlattr *na, *na1;
+	struct nlattr *qbv_table;
+	struct nlattr *qbv[TSN_QBV_ATTR_MAX + 1];
+	struct nlattr *qbvctrl[TSN_QBV_ATTR_CTRL_MAX + 1];
+	int rem;
+	int ret =3D 0;
+	struct net_device *netdev;
+	struct tsn_qbv_conf qbvconfig;
+	const struct tsn_ops *tsnops;
+	struct tsn_qbv_entry *gatelist =3D NULL;
+	int count =3D 0;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	memset(&qbvconfig, 0, sizeof(struct tsn_qbv_conf));
+
+	if (!info->attrs[TSN_ATTR_QBV])
+		return -EINVAL;
+
+	na =3D info->attrs[TSN_ATTR_QBV];
+
+	ret =3D NLA_PARSE_NESTED(qbv, TSN_QBV_ATTR_MAX, na, qbv_policy);
+	if (ret)
+		return -EINVAL;
+
+	if (qbv[TSN_QBV_ATTR_ENABLE])
+		qbvconfig.gate_enabled =3D 1;
+	else
+		goto setdrive;
+
+	if (qbv[TSN_QBV_ATTR_CONFIGCHANGE])
+		qbvconfig.config_change =3D 1;
+
+	if (!qbv[TSN_QBV_ATTR_ADMINENTRY]) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -1;
+	}
+
+	na1 =3D qbv[TSN_QBV_ATTR_ADMINENTRY];
+	NLA_PARSE_NESTED(qbvctrl, TSN_QBV_ATTR_CTRL_MAX,
+			 na1, qbv_ctrl_policy);
+
+	if (qbvctrl[TSN_QBV_ATTR_CTRL_CYCLETIME]) {
+		qbvconfig.admin.cycle_time =3D
+			nla_get_u32(qbvctrl[TSN_QBV_ATTR_CTRL_CYCLETIME]);
+	}
+
+	if (qbvctrl[TSN_QBV_ATTR_CTRL_CYCLETIMEEXT]) {
+		qbvconfig.admin.cycle_time_extension =3D
+			nla_get_u32(qbvctrl[TSN_QBV_ATTR_CTRL_CYCLETIMEEXT]);
+	}
+
+	if (qbvctrl[TSN_QBV_ATTR_CTRL_BASETIME]) {
+		qbvconfig.admin.base_time =3D
+			nla_get_u64(qbvctrl[TSN_QBV_ATTR_CTRL_BASETIME]);
+	}
+
+	if (qbvctrl[TSN_QBV_ATTR_CTRL_GATESTATE]) {
+		qbvconfig.admin.gate_states =3D
+			nla_get_u8(qbvctrl[TSN_QBV_ATTR_CTRL_GATESTATE]);
+	}
+
+	if (qbvctrl[TSN_QBV_ATTR_CTRL_LISTCOUNT]) {
+		int listcount;
+
+		listcount =3D nla_get_u32(qbvctrl[TSN_QBV_ATTR_CTRL_LISTCOUNT]);
+
+		qbvconfig.admin.control_list_length =3D listcount;
+
+		gatelist =3D kmalloc_array(listcount,
+					 sizeof(*gatelist),
+					 GFP_KERNEL);
+
+		nla_for_each_nested(qbv_table, na1, rem) {
+			struct nlattr *qbv_entry[TSN_QBV_ATTR_ENTRY_MAX + 1];
+
+			if (nla_type(qbv_table) !=3D TSN_QBV_ATTR_CTRL_LISTENTRY)
+				continue;
+
+			ret =3D NLA_PARSE_NESTED(qbv_entry,
+					       TSN_QBV_ATTR_ENTRY_MAX,
+					       qbv_table, qbv_entry_policy);
+			if (ret)
+				return -EINVAL;
+
+			(gatelist + count)->gate_state =3D
+				nla_get_u8(qbv_entry[TSN_QBV_ATTR_ENTRY_GC]);
+			(gatelist + count)->time_interval =3D
+				nla_get_u32(qbv_entry[TSN_QBV_ATTR_ENTRY_TM]);
+			count++;
+			if (count > listcount)
+				break;
+		}
+	}
+
+	if (gatelist)
+		qbvconfig.admin.control_list =3D gatelist;
+
+setdrive:
+	if (!tsnops->qbv_set) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		goto err;
+	}
+
+	ret =3D tsnops->qbv_set(netdev, &qbvconfig);
+
+	/* send back */
+	tsn_simple_reply(info, TSN_CMD_REPLY,
+			 netdev->name, TSN_SUCCESS);
+
+err:
+	kfree(gatelist);
+
+	return ret;
+}
+
+static int tsn_qbv_set(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME]) {
+		cmd_qbv_set(info);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cmd_qbv_get(struct genl_info *info)
+{
+	struct nlattr *qbv, *qbvadminattr;
+	struct sk_buff *rep_skb;
+	int ret;
+	int len =3D 0, i =3D 0;
+	struct net_device *netdev;
+	struct genlmsghdr *genlhdr;
+	struct tsn_qbv_conf qbvconf;
+	const struct tsn_ops *tsnops;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	genlhdr =3D info->genlhdr;
+
+	memset(&qbvconf, 0, sizeof(struct tsn_qbv_conf));
+
+	if (!tsnops->qbv_get) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -1;
+	}
+
+	ret =3D tsnops->qbv_get(netdev, &qbvconf);
+	if (ret < 0) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_DEVRETERR);
+		return ret;
+	}
+
+	ret =3D tsn_prepare_reply(info, genlhdr->cmd,
+				&rep_skb, NLMSG_ALIGN(MAX_ATTR_SIZE));
+	if (ret < 0)
+		return ret;
+
+	if (nla_put_string(rep_skb, TSN_ATTR_IFNAME, netdev->name))
+		return -EMSGSIZE;
+
+	qbv =3D nla_nest_start(rep_skb, TSN_ATTR_QBV);
+	if (!qbv)
+		return -EMSGSIZE;
+
+	qbvadminattr =3D nla_nest_start(rep_skb, TSN_QBV_ATTR_ADMINENTRY);
+
+	if (qbvconf.admin.control_list) {
+		len =3D qbvconf.admin.control_list_length;
+		nla_put_u32(rep_skb, TSN_QBV_ATTR_CTRL_LISTCOUNT, len);
+
+		for (i =3D 0; i < len; i++) {
+			struct nlattr *qbv_table;
+			u8 gs;
+			u32 tp;
+
+			gs =3D (qbvconf.admin.control_list + i)->gate_state;
+			tp =3D (qbvconf.admin.control_list + i)->time_interval;
+
+			qbv_table =3D nla_nest_start(rep_skb,
+						   TSN_QBV_ATTR_CTRL_LISTENTRY);
+
+			nla_put_u32(rep_skb, TSN_QBV_ATTR_ENTRY_ID, i);
+			nla_put_u8(rep_skb, TSN_QBV_ATTR_ENTRY_GC, gs);
+			nla_put_u32(rep_skb, TSN_QBV_ATTR_ENTRY_TM, tp);
+			nla_nest_end(rep_skb, qbv_table);
+		}
+
+		if (qbvconf.admin.gate_states)
+			nla_put_u8(rep_skb, TSN_QBV_ATTR_CTRL_GATESTATE,
+				   qbvconf.admin.gate_states);
+
+		if (qbvconf.admin.cycle_time)
+			nla_put_u32(rep_skb, TSN_QBV_ATTR_CTRL_CYCLETIME,
+				    qbvconf.admin.cycle_time);
+
+		if (qbvconf.admin.cycle_time_extension)
+			nla_put_u32(rep_skb, TSN_QBV_ATTR_CTRL_CYCLETIMEEXT,
+				    qbvconf.admin.cycle_time_extension);
+
+		if (qbvconf.admin.base_time)
+			NLA_PUT_U64(rep_skb, TSN_QBV_ATTR_CTRL_BASETIME,
+				    qbvconf.admin.base_time);
+
+		kfree(qbvconf.admin.control_list);
+
+	} else {
+		pr_info("tsn: error get administrator data.");
+	}
+
+	nla_nest_end(rep_skb, qbvadminattr);
+
+	if (qbvconf.gate_enabled)
+		nla_put_flag(rep_skb, TSN_QBV_ATTR_ENABLE);
+	else
+		nla_put_flag(rep_skb, TSN_QBV_ATTR_DISABLE);
+
+	if (qbvconf.maxsdu)
+		nla_put_u32(rep_skb, TSN_QBV_ATTR_MAXSDU, qbvconf.maxsdu);
+
+	if (qbvconf.config_change)
+		nla_put_flag(rep_skb, TSN_QBV_ATTR_CONFIGCHANGE);
+
+	nla_nest_end(rep_skb, qbv);
+
+	tsn_send_reply(rep_skb, info);
+
+	return ret;
+}
+
+static int cmd_qbv_status_get(struct genl_info *info)
+{
+	struct nlattr *qbv, *qbvoperattr;
+	struct sk_buff *rep_skb;
+	int ret;
+	int len =3D 0, i =3D 0;
+	struct net_device *netdev;
+	struct genlmsghdr *genlhdr;
+	struct tsn_qbv_status qbvstatus;
+	const struct tsn_ops *tsnops;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	genlhdr =3D info->genlhdr;
+
+	memset(&qbvstatus, 0, sizeof(struct tsn_qbv_status));
+
+	if (!tsnops->qbv_get_status) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -1;
+	}
+
+	ret =3D tsnops->qbv_get_status(netdev, &qbvstatus);
+	if (ret < 0) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_DEVRETERR);
+		return ret;
+	}
+
+	ret =3D tsn_prepare_reply(info, genlhdr->cmd,
+				&rep_skb, NLMSG_ALIGN(MAX_ATTR_SIZE));
+	if (ret < 0)
+		return ret;
+
+	if (nla_put_string(rep_skb, TSN_ATTR_IFNAME, netdev->name))
+		return -EMSGSIZE;
+
+	qbv =3D nla_nest_start(rep_skb, TSN_ATTR_QBV);
+	if (!qbv)
+		return -EMSGSIZE;
+
+	qbvoperattr =3D nla_nest_start(rep_skb, TSN_QBV_ATTR_OPERENTRY);
+
+	if (qbvstatus.oper.control_list) {
+		len =3D qbvstatus.oper.control_list_length;
+		nla_put_u32(rep_skb, TSN_QBV_ATTR_CTRL_LISTCOUNT, len);
+		for (i =3D 0; i < len; i++) {
+			struct nlattr *qbv_table;
+			u8 gs;
+			u32 tp;
+
+			gs =3D (qbvstatus.oper.control_list + i)->gate_state;
+			tp =3D (qbvstatus.oper.control_list + i)->time_interval;
+
+			qbv_table =3D nla_nest_start(rep_skb,
+						   TSN_QBV_ATTR_CTRL_LISTENTRY);
+
+			nla_put_u32(rep_skb, TSN_QBV_ATTR_ENTRY_ID, i);
+			nla_put_u8(rep_skb, TSN_QBV_ATTR_ENTRY_GC, gs);
+			nla_put_u32(rep_skb, TSN_QBV_ATTR_ENTRY_TM, tp);
+			nla_nest_end(rep_skb, qbv_table);
+		}
+
+		if (qbvstatus.oper.gate_states)
+			nla_put_u8(rep_skb, TSN_QBV_ATTR_CTRL_GATESTATE,
+				   qbvstatus.oper.gate_states);
+
+		if (qbvstatus.oper.cycle_time)
+			nla_put_u32(rep_skb, TSN_QBV_ATTR_CTRL_CYCLETIME,
+				    qbvstatus.oper.cycle_time);
+
+		if (qbvstatus.oper.cycle_time_extension)
+			nla_put_u32(rep_skb, TSN_QBV_ATTR_CTRL_CYCLETIMEEXT,
+				    qbvstatus.oper.cycle_time_extension);
+
+		if (qbvstatus.oper.base_time)
+			NLA_PUT_U64(rep_skb, TSN_QBV_ATTR_CTRL_BASETIME,
+				    qbvstatus.oper.base_time);
+
+		kfree(qbvstatus.oper.control_list);
+	} else {
+		pr_info("tsn: error get operation list data.");
+	}
+
+	nla_nest_end(rep_skb, qbvoperattr);
+
+	if (qbvstatus.config_change_time)
+		NLA_PUT_U64(rep_skb, TSN_QBV_ATTR_CONFIGCHANGETIME,
+			    qbvstatus.config_change_time);
+
+	if (qbvstatus.tick_granularity)
+		nla_put_u32(rep_skb, TSN_QBV_ATTR_GRANULARITY,
+			    qbvstatus.tick_granularity);
+
+	if (qbvstatus.current_time)
+		NLA_PUT_U64(rep_skb, TSN_QBV_ATTR_CURRENTTIME,
+			    qbvstatus.current_time);
+
+	if (qbvstatus.config_pending)
+		nla_put_flag(rep_skb, TSN_QBV_ATTR_CONFIGPENDING);
+
+	if (qbvstatus.config_change_error)
+		NLA_PUT_U64(rep_skb, TSN_QBV_ATTR_CONFIGCHANGEERROR,
+			    qbvstatus.config_change_error);
+
+	if (qbvstatus.supported_list_max)
+		nla_put_u32(rep_skb, TSN_QBV_ATTR_LISTMAX,
+			    qbvstatus.supported_list_max);
+
+	nla_nest_end(rep_skb, qbv);
+
+	tsn_send_reply(rep_skb, info);
+
+	return ret;
+}
+
+static int tsn_qbv_status_get(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME])
+		cmd_qbv_status_get(info);
+
+	return 0;
+}
+
+static int tsn_qbv_get(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME])
+		cmd_qbv_get(info);
+
+	return 0;
+}
+
+static int tsn_cbs_set(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *na;
+	struct nlattr *cbsa[TSN_CBS_ATTR_MAX + 1];
+	struct net_device *netdev;
+	const struct tsn_ops *tsnops;
+	int ret;
+	u8 tc, bw;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	if (!info->attrs[TSN_ATTR_CBS]) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	na =3D info->attrs[TSN_ATTR_CBS];
+
+	if (!tsnops->cbs_set) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -1;
+	}
+
+	ret =3D NLA_PARSE_NESTED(cbsa, TSN_CBS_ATTR_MAX, na, cbs_policy);
+	if (ret) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	if (!cbsa[TSN_CBS_ATTR_TC_INDEX]) {
+		pr_err("tsn: no TSN_CBS_ATTR_TC_INDEX input\n");
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+	tc =3D nla_get_u8(cbsa[TSN_CBS_ATTR_TC_INDEX]);
+
+	if (!cbsa[TSN_CBS_ATTR_BW]) {
+		pr_err("tsn: no TSN_CBS_ATTR_BW input\n");
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	bw =3D nla_get_u8(cbsa[TSN_CBS_ATTR_BW]);
+	if (bw > 100) {
+		pr_err("tsn: TSN_CBS_ATTR_BW isn't in the range of 0~100\n");
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	ret =3D tsnops->cbs_set(netdev, tc, bw);
+	if (ret < 0) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_DEVRETERR);
+		return -EINVAL;
+	}
+
+	tsn_simple_reply(info, TSN_CMD_REPLY,
+			 netdev->name, TSN_SUCCESS);
+	return 0;
+}
+
+static int tsn_cbs_get(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *na, *cbsattr;
+	struct nlattr *cbsa[TSN_CBS_ATTR_MAX + 1];
+	struct net_device *netdev;
+	const struct tsn_ops *tsnops;
+	struct sk_buff *rep_skb;
+	int ret;
+	struct genlmsghdr *genlhdr;
+	u8 tc;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	if (!info->attrs[TSN_ATTR_CBS]) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	if (!tsnops->cbs_get) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -1;
+	}
+
+	na =3D info->attrs[TSN_ATTR_CBS];
+	ret =3D NLA_PARSE_NESTED(cbsa, TSN_CBS_ATTR_MAX, na, cbs_policy);
+	if (ret) {
+		pr_err("tsn: parse value TSN_CBS_ATTR_MAX error.");
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	/* Get status data from device */
+	genlhdr =3D info->genlhdr;
+
+	/* Form netlink reply data */
+	ret =3D tsn_prepare_reply(info, genlhdr->cmd, &rep_skb,
+				NLMSG_ALIGN(MAX_ATTR_SIZE));
+	if (ret < 0)
+		return ret;
+
+	if (nla_put_string(rep_skb, TSN_ATTR_IFNAME, netdev->name))
+		return -EMSGSIZE;
+
+	cbsattr =3D nla_nest_start(rep_skb, TSN_ATTR_CBS);
+	if (!cbsattr)
+		return -EMSGSIZE;
+
+	if (!cbsa[TSN_CBS_ATTR_TC_INDEX]) {
+		pr_err("tsn: must to specify the TSN_CBS_ATTR_TC_INDEX\n");
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+	tc =3D nla_get_u8(cbsa[TSN_CBS_ATTR_TC_INDEX]);
+
+	ret =3D tsnops->cbs_get(netdev, tc);
+	if (ret < 0) {
+		pr_err("tsn: cbs_get return error\n");
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	nla_put_u8(rep_skb, TSN_CBS_ATTR_BW, ret & 0XF);
+
+	nla_nest_end(rep_skb, cbsattr);
+	return tsn_send_reply(rep_skb, info);
+}
+
+static int cmd_qbu_set(struct genl_info *info)
+{
+	struct nlattr *na;
+	struct nlattr *qbua[TSN_QBU_ATTR_MAX + 1];
+	struct net_device *netdev;
+	const struct tsn_ops *tsnops;
+	int ret;
+	u8 preemptible =3D 0;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	if (!info->attrs[TSN_ATTR_QBU]) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	na =3D info->attrs[TSN_ATTR_QBU];
+
+	ret =3D NLA_PARSE_NESTED(qbua, TSN_QBU_ATTR_MAX, na, qbu_policy);
+	if (ret) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_ATTRERR);
+		return -EINVAL;
+	}
+
+	if (qbua[TSN_QBU_ATTR_ADMIN_STATE])
+		preemptible =3D nla_get_u8(qbua[TSN_QBU_ATTR_ADMIN_STATE]);
+	else
+		pr_info("No preemptible TSN_QBU_ATTR_ADMIN_STATE config!\n");
+
+	if (!tsnops->qbu_set) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -EINVAL;
+	}
+
+	ret =3D tsnops->qbu_set(netdev, preemptible);
+	if (ret < 0) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_DEVRETERR);
+		return -EINVAL;
+	}
+
+	tsn_simple_reply(info, TSN_CMD_REPLY,
+			 netdev->name, TSN_SUCCESS);
+	return 0;
+}
+
+static int tsn_qbu_set(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME])
+		return cmd_qbu_set(info);
+
+	return -1;
+}
+
+static int cmd_qbu_get_status(struct genl_info *info)
+{
+	struct nlattr *qbuattr;
+	struct net_device *netdev;
+	const struct tsn_ops *tsnops;
+	struct sk_buff *rep_skb;
+	int ret;
+	struct genlmsghdr *genlhdr;
+	struct tsn_preempt_status pps;
+	struct tsn_port *port;
+
+	port =3D tsn_init_check(info, &netdev);
+	if (!port)
+		return -ENODEV;
+
+	tsnops =3D port->tsnops;
+
+	/* Get status data from device */
+	genlhdr =3D info->genlhdr;
+
+	memset(&pps, 0, sizeof(struct tsn_preempt_status));
+
+	if (!tsnops->qbu_get) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_NODEVOPS);
+		return -1;
+	}
+
+	ret =3D tsnops->qbu_get(netdev, &pps);
+	if (ret < 0) {
+		tsn_simple_reply(info, TSN_CMD_REPLY,
+				 netdev->name, -TSN_DEVRETERR);
+		return -1;
+	}
+
+	/* Form netlink reply data */
+	ret =3D tsn_prepare_reply(info, genlhdr->cmd,
+				&rep_skb, NLMSG_ALIGN(MAX_ATTR_SIZE));
+	if (ret < 0)
+		return ret;
+
+	if (nla_put_string(rep_skb, TSN_ATTR_IFNAME, netdev->name))
+		return -EMSGSIZE;
+
+	qbuattr =3D nla_nest_start(rep_skb, TSN_ATTR_QBU);
+	if (!qbuattr)
+		return -EMSGSIZE;
+
+	nla_put_u8(rep_skb, TSN_QBU_ATTR_ADMIN_STATE, pps.admin_state);
+	nla_put_u32(rep_skb, TSN_QBU_ATTR_HOLD_ADVANCE, pps.hold_advance);
+	nla_put_u32(rep_skb, TSN_QBU_ATTR_RELEASE_ADVANCE, pps.release_advance);
+	if (pps.preemption_active)
+		nla_put_flag(rep_skb, TSN_QBU_ATTR_ACTIVE);
+
+	nla_put_u8(rep_skb, TSN_QBU_ATTR_HOLD_REQUEST, pps.hold_request);
+	nla_nest_end(rep_skb, qbuattr);
+
+	return tsn_send_reply(rep_skb, info);
+}
+
+static int tsn_qbu_get_status(struct sk_buff *skb, struct genl_info *info)
+{
+	if (info->attrs[TSN_ATTR_IFNAME])
+		return cmd_qbu_get_status(info);
+
+	return -1;
+}
+
+static const struct genl_ops tsnnl_ops[] =3D {
+	{
+		.cmd		=3D TSN_CMD_ECHO,
+		.doit		=3D tsn_echo_cmd,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QBV_SET,
+		.doit		=3D tsn_qbv_set,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QBV_GET,
+		.doit		=3D tsn_qbv_get,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QBV_GET_STATUS,
+		.doit		=3D tsn_qbv_status_get,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_CB_STREAMID_SET,
+		.doit		=3D tsn_cb_streamid_set,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_CB_STREAMID_GET,
+		.doit		=3D tsn_cb_streamid_get,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QCI_SFI_SET,
+		.doit		=3D tsn_qci_sfi_set,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QCI_SFI_GET,
+		.doit		=3D tsn_qci_sfi_get,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QCI_SFI_GET_COUNTS,
+		.doit		=3D tsn_qci_sfi_counters_get,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QCI_SGI_SET,
+		.doit		=3D tsn_qci_sgi_set,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QCI_SGI_GET,
+		.doit		=3D tsn_qci_sgi_get,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QCI_SGI_GET_STATUS,
+		.doit		=3D tsn_qci_sgi_status_get,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QCI_FMI_SET,
+		.doit		=3D tsn_qci_fmi_set,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QCI_FMI_GET,
+		.doit		=3D tsn_qci_fmi_get,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_CBS_SET,
+		.doit		=3D tsn_cbs_set,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_CBS_GET,
+		.doit		=3D tsn_cbs_get,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QBU_SET,
+		.doit		=3D tsn_qbu_set,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+	{
+		.cmd		=3D TSN_CMD_QBU_GET_STATUS,
+		.doit		=3D tsn_qbu_get_status,
+		.policy		=3D tsn_cmd_policy,
+		.flags		=3D GENL_ADMIN_PERM,
+	},
+};
+
+static struct genl_family tsn_family =3D {
+	.name		=3D TSN_GENL_NAME,
+	.version	=3D TSN_GENL_VERSION,
+	.maxattr	=3D TSN_CMD_ATTR_MAX,
+	.module		=3D THIS_MODULE,
+	.ops		=3D tsnnl_ops,
+	.n_ops		=3D ARRAY_SIZE(tsnnl_ops),
+};
+
+int tsn_port_register(struct net_device *netdev,
+		      struct tsn_ops *tsnops, u16 groupid)
+{
+	struct tsn_port *port;
+
+	if (list_empty(&port_list)) {
+		INIT_LIST_HEAD(&port_list);
+	} else {
+		list_for_each_entry(port, &port_list, list) {
+			if (port->netdev =3D=3D netdev) {
+				pr_info("TSN device already registered!\n");
+				return -1;
+			}
+		}
+	}
+
+	port =3D kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -1;
+
+	port->netdev =3D netdev;
+	port->groupid =3D groupid;
+	port->tsnops =3D tsnops;
+
+	if (groupid < GROUP_OFFSET_SWITCH)
+		port->type =3D TSN_ENDPOINT;
+	else
+		port->type =3D TSN_SWITCH;
+
+	list_add_tail(&port->list, &port_list);
+
+	if (tsnops && tsnops->device_init)
+		port->tsnops->device_init(netdev);
+
+	return 0;
+}
+EXPORT_SYMBOL(tsn_port_register);
+
+void tsn_port_unregister(struct net_device *netdev)
+{
+	struct tsn_port *p;
+
+	list_for_each_entry(p, &port_list, list) {
+		if (p->netdev =3D=3D netdev) {
+			if (p && p->tsnops->device_deinit)
+				p->tsnops->device_deinit(netdev);
+			list_del(&p->list);
+			kfree(p);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL(tsn_port_unregister);
+
+static int __init tsn_genetlink_init(void)
+{
+	int ret;
+
+	pr_info("tsn generic netlink module v%d init...\n", TSN_GENL_VERSION);
+
+	ret =3D genl_register_family(&tsn_family);
+
+	if (ret !=3D 0) {
+		pr_info("failed to init tsn generic netlink example module\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit tsn_genetlink_exit(void)
+{
+	int ret;
+
+	ret =3D genl_unregister_family(&tsn_family);
+	if (ret !=3D 0)
+		pr_info("failed to unregister family:%i\n", ret);
+}
+
+module_init(tsn_genetlink_init);
+module_exit(tsn_genetlink_exit);
+MODULE_LICENSE("GPL");
--=20
1.8.3.1

