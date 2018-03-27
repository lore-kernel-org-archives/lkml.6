Return-Path: <razvan.stefanescu@nxp.com>
X-Google-Smtp-Source: AG47ELtlJkp+4911gxBc0ATyxLYJBqGiKrL92e1xES/Nb5D3BIPNN4heBhUBE71vjCmPGeqNayOl
ARC-Seal: i=1; a=rsa-sha256; t=1522156264; cv=none;
        d=google.com; s=arc-20160816;
        b=kUsRPDToCj/ZG8RXuPwqOfhvxvP1shUsIlrLndRPqouPsinrkyD8T3FiyXPVXZtQX9
         cqq3CmWpcqISA2Tp60mpTSREgiQjYJkeX001IY6PmcrmCbgVE1gh28BtoilZyHhQWIxQ
         EHlpTarutDv4qHpYsQSkLRr9afUEHLQz+UIR13EebCwpRnV/88z3C6ugguu0Bxc4fbQh
         3Q6rlikSVlCA1HKKSoNrONbiZTUTnehgny0ifzFa9u/C2ITqMrkgrhsfxM4XWQUdcVrn
         ReYB2mB9CA4+fTdHVIHs5DotuMlfgo/dtHtK8qhweH1opDWt3gMg5zpfMJcVLuuadWX8
         F9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=osTVgj8XLTSHb4VeUCdawSQG0je9W4KNu9SEIjSSmuQ=;
        b=cniRXaiNVf33NJHNZcybN0/6NOKsbRggwzpIcVfytXMittWXOceeppeohMV8j/AesI
         kqbszRD9oLQqUhKo+7Z5ZgRGJBSPEdK2DU7694ebySmpCnrutHyz8fuff5BZu0m+YRKk
         4H/kWryb/QEtIM4Phw6iAv8qgnjpLOOaimlnNdJ8eK+0pkD1VCsLAz0t/Lb6Z2Em6NJZ
         HP2u4s2GYxAYC59acud6T2hEGJTX3HHW4LbxB2PSp1oHZGWmcn5w1ZaZlWFNYBWiSK7t
         Xd4IUl8+5tls98zEA+3FFTKjQ8UdE0ZNTagJgu11YhLhc1cVai12R6WkswzsdAcLR1UK
         7HUg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=p3YhluMB;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 104.47.2.67 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=p3YhluMB;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 104.47.2.67 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	alexandru.marginean@nxp.com,
	ruxandra.radulescu@nxp.com,
	ioana.ciornei@nxp.com,
	laurentiu.tudor@nxp.com,
	stuyoder@gmail.com
Subject: [PATCH] staging: fsl-dpaa2/ethsw: Fix TCI values overwrite
Date: Tue, 27 Mar 2018 08:10:50 -0500
Message-Id: <20180327131050.30581-1-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: DM5PR06CA0103.namprd06.prod.outlook.com
 (2603:10b6:4:3a::44) To DB4PR04MB0750.eurprd04.prod.outlook.com
 (2a01:111:e400:984b::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fca46fcf-1df0-440d-88e6-08d593e43029
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB4PR04MB0750;
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB0750;3:rmI0lYJNHBj8VhsjLzCooaBZJjR/GiIagB0rOjwcN5xW2/NmzW8SSODI/i4R4NydIR0ekH+20D6gHNwg9KMkbrEP4KrXR2iBzo2HWbZlRVvyqvDZRIA9OLNy6nTJAJz8+l1NVafzSTUORfj7IEq2NiY5rx/skSgtJ/Y0NQm+UWrrtTV2tArSZcvNAdZIHef/a6u15NuvIq/vHL+4dYxa8HdQhXa3f21FpKcgLTn1j96o2rSfx1rmOVSfMInAaBAG;25:ATNBNOO3KZF7U5w5QqXIh9bDbcvlXp6wau1nHbwcajiCdQVKMKk4PdGoRaBzSEHDNPQHxUeDTp0psakLnnY9jlMnJaUE8mVphQLZ2Qe+xsbUW5I4LJhB+rtkYEm6//jp+6YCiN3eIKfqqJuanHwNKH7g+VEUp1hYf3qcks+RyjPO69I4jYzIv/BVP+yybI4wyADZpoSP13XhAbK0+3b71JCHCcu+AXS3wmcdSC2uqSTgWgQd9tJNhVi5OLbo52qW0uDcrIIp5odsCiEtLn4f/6+ULFdQJsezSz7wf+BW8y9+81QsLTV0Y9Ocb1Gy+3bTHn4GltWxVhf0Wlcn937AfQ==;31:GTt2myrC7fSXampfGB6yIwh9LUbH6khC1E8G7STim7UkrOY4szL67yCQX/GJkXME0FD6PW6Ct3nIWIrP90COWcw+icdEiUftwAB83T85G3rqReEC8w3jwdZ+Zdn/ziTgDLOjDfdfx3+KtSnpOYUfysTqeUCOvQXO5enEnbdBV+IT2JsW0cJQEXsamIqSL+oCcxqwuH7gBeQ2FxbKy6Wtp3PXY3lFet8M2Y8+XE3Osz0=
X-MS-TrafficTypeDiagnostic: DB4PR04MB0750:
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB0750;20:grJwRff+47Jx7hBVI8rh0rjrwIqLYOqeXcklVFV2Z5mfjWHlV5vyT+nP23YxMuLti3pCUGIlVMII798+guEjSlOimEgYlRLsj3HGhHE0QFWaUUlnTAwIIgkqKTHVc6wk5ZsbAyyUayatd69tVp45Hwxof0+J6V5tIk5BhjhWngfay1S9BuIBpdIxP1tJ+L3GYtaouLScSu6HKrzJc3HJZLfT8JzqFdpxw6e0zgdh96y6Qg7pzfXHFrBN+LiLSGuDVuWnK9SSDPCRtT1lbzFsaM5rgq1y8sU0F+XRE32C6gO5kfvzW20OCo0XeWd3d6RsAuhhb3NvIm2HC44zhJe2e3Iwyynd3cIORJyH08Kmwk8391cjzUa51ZTjVleEqYVAEHUML2tYGAFCSnVCrQr0mnIuxbvkcaNy/RL8ZXz71NFV3Lm/U8SuZVbFyKsfmjXNITur5F6U5gJJq2fVdEOlr/o4mPzzkGe1nVakUNTxLWhq1/tyWWMcfubC3c7TBh2b;4:ODQxQzm3sSfLFHoNE/tQ+ndrKzPHt+cBgn8GL+zecZUv3RhEtuLI39tADAS5bWPamlMjnb0GM4T5Dd3Y9cKwATcERYv8cuq9PrLMSang/RoYB4cUdgnhc77j4dWL2/3cnOfzoX0ssyGZCCFJrpX0o4c4npA2bPGb5NUT8D0dCfL9LJydKCnnXeS+Ha23oD6MXJYL1saIehDvL1bxit2XHsf98YMhtSnPwC1JxYc8U4839A7PPT3egEgc+CjlnIwapV9OOZfukhDQQIrVHSpEDVBp2fxO+upwaOddUTfwzEt2tdQ2Z+kzvmMOpJmZY8gfpfym+BG+gpJm+Y6ItJ1aeFD9sbU9oEx5JB9AfLQQRq4=
X-Microsoft-Antispam-PRVS: <DB4PR04MB0750F65E66F0CA6C1E42EC3CE6AC0@DB4PR04MB0750.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB4PR04MB0750;BCL:0;PCL:0;RULEID:;SRVR:DB4PR04MB0750;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(366004)(376002)(396003)(189003)(199004)(2906002)(52116002)(16586007)(51416003)(105586002)(2616005)(53936002)(316002)(106356001)(6512007)(1076002)(386003)(6506007)(59450400001)(7736002)(26005)(86362001)(1857600001)(25786009)(956004)(186003)(4326008)(16526019)(305945005)(6916009)(50466002)(81166006)(8676002)(5660300001)(81156014)(48376002)(6116002)(3846002)(39060400002)(2351001)(478600001)(6666003)(68736007)(66066001)(47776003)(36756003)(8936002)(97736004)(486005)(6486002)(476003)(50226002)(2361001)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB4PR04MB0750;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB4PR04MB0750;23:SuzgMR22uaRGVPG+OQF6RXZa4TMR7k5bOBipo/Qtf?=
 =?us-ascii?Q?7QccDydy01Il9FNJWo5rxJwz3X3oZ4ZN+FULArLCduVEc6giEoNMaitm5gso?=
 =?us-ascii?Q?Evw4dp3TpJclKF00ZaLGMmPVgMydotFZqxjYFE04B4z2TrSmaV3QdMaNHr4V?=
 =?us-ascii?Q?6yq/Jv67gILM8bzi4mckYz7YodJnwaU4v2xyv0y3nCDThNSoza59xAr43uir?=
 =?us-ascii?Q?yRC7ru63QxlVZ7qUelxEjYyRvmOrWGxcYkthpELrY3Xx+V0KJhKXFVhzNBgU?=
 =?us-ascii?Q?UwMWS4EGWjZyrp517c608srsis9rN4GrSCwTfKGEWWYifdzy9LNnqrT2Wj0U?=
 =?us-ascii?Q?pBQ9l/tb/bKJxe2bPPJb2Kvojfa5idc7WmAN3zyKv3/oMy1X/k4rkMpJOxia?=
 =?us-ascii?Q?wwsfaoyE0jch3iQ1n5rJmNoQU7rWuQZsgJwLtx0tF3j0yk55tVJsONPWGrGm?=
 =?us-ascii?Q?fiGoqwNhSGeeqLNs6jHDudz6FWzqEKbEah6e2HClQulNx5K35mJola6e8zGC?=
 =?us-ascii?Q?5s1N5JJd7Nm7obHP77YjkgC0bACPyGnGc5UbgCLEO1jo9Es67kewiciyezdR?=
 =?us-ascii?Q?ieAfs4eIngfaFbQHw69g2mon3DKl2H8bx6nf6vmVYCiM5c3LGB0tA749MmjS?=
 =?us-ascii?Q?i5Z/d82s8jkvId2WxaSSQirL45nmmcLwY1TOSHLOKhXp8iBzQTGE/3wRQekH?=
 =?us-ascii?Q?d5vq5snCttsXxSgSzcgxTFHp71d2LSshXTnaJw30mlQUYNXqMwdBNsu9llat?=
 =?us-ascii?Q?4W56xChXlGJMf3llRlAsoWcS1fHhRS3gseMWttQJ8BMCcfv+5X/Ece4v1tXs?=
 =?us-ascii?Q?XBLfe/+3JK2QkXJ5mACzSi5WEqoszfCf1PkhxqqZ7J187oHgt1sRCsfWnihT?=
 =?us-ascii?Q?LiKFJGPbK6NqQk+Jz/WCrWVOy+AoRYDo5Is+mBCdACaWF+l5BiHTvITO8JXP?=
 =?us-ascii?Q?Kz8yal+aGC3uLdfzUeuX0hxdhOap7bGGKFCd/2i+0BKxvhl/8h3rgprOPNXF?=
 =?us-ascii?Q?QUTttbSnazwYa15ksgGiRiMMpWY/7TFJP2f0UhV0XMKuSgYnAIbmA38t3Azp?=
 =?us-ascii?Q?oZY6e/fHOKMIfsyM8YyCDamYdYczwVuZiJi0jAy/qZpwLZTvZmnHyZW1Xcxc?=
 =?us-ascii?Q?qNW90utYtsmlprm8RGT5s8H/eHJMh/Cenonj6ICC6NaB3UCpjFead+Hqufky?=
 =?us-ascii?Q?Lt7bRLEUAxPFJiwwIWJxoVWEBwRcFGJjzSqCM1/okMo8F/r960ehm3cl+aGT?=
 =?us-ascii?Q?pNC6+/agZD8xLPxqITYLp6sakDR8tGA0pgSgRdo?=
X-Microsoft-Antispam-Message-Info: K2F87i+NZTjjHofFl0dDhQMsctc0oGPJO9nXRPKrzXxEctpBYVSwSqr5RCQBu+KvpG1zKUGyMd/wMy2zUbJPQRj/ao3fS+kqdjS0vNvEDkSwaUpLPuD1ZW53s9ghOjF8BGVHzu0MBF00iBCgkTr8a2AskgfapYosg02qRNmHdnJJd9s6iQc+XiQzyuB76TV1
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB0750;6:6NrwtAGfvKrR0z9+lXetqqDRdpifeHL1EEUHuOhQMm4cr8BHZjuaSYEyVn3q5akdobbB12m8dUeQNkgRHJ8+MoNxpJq7JkIPPu79yieC/MAJORZGP0wPaJmq7HVluT1eohe/rd2ja+nvi7NFtOnve201aBdLbj4EC09KkZpxfONP2Vv5BpBo6s1kf2IdNrAwHUB0Q6TEq+KAO4+1LHienl+hFiXzGnZStw+xYwG8efuUORrk1TxinHMVls1cdU8KzgJgTaqvAnbg+EijErGvP/dyTA68UpRnyZp5A6R/PPkiETUjJWoVJ80NzLzGviUNWXoFJy/nlT24NDLnjg/KcPZVcqjCD6xdMkEyKBufIbtj+UmQwlUpDN3iUcyP0rGuGmfMutWubhZQsAIPI+rGQGntLamxEx32EWIrmt9jZ90mhPweFOo5SEZuDjo7G1yej0sIGn8jsK7MJoMElmcEOg==;5:s+9MWVlnmtpfoWSL6+4trEIOO/VvUmInchrJRFZPLoZ81yN8lBiWsZlmNeBQ+yd/7aS4Jc0mhKjSoonQzERvHQfCtnIzISEWu2lqU4N9Ndm5baiXB6T3J/pv8ps+NiYDU/+0kYqi64+QLmQrNlYzpT8UGVXZfHVZsXu3qNax5tE=;24:S7iVoVN+4FOwbVrsBhFp726pLmuPvZRgvenVS+NeOwO+/hCoibsOzIPTqq3d0UuL/4scO2KVK0XlDWXYwex6bwanRZnc+U+iq6GvzaFJgOA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB0750;7:4BW9EHom4e50e0kQaBla8zTa/Z02CnGjugmqsd8Yp1oUsNxHyneCPV54vOr3lKlP+6lG3D3h5E7viUui2R7YkVwyAhsuYjcqS0ewDPQmk+b8aNx3hHslQ27JRkBn6m33/8oUvf/rPLGUY+rhxvrrSAlSP9hIzRzt1nbjKqICAuTeLms3N9f0Rrb2nD/r74Z3KGNR+3OebY7QuhasWryPs5VJLrmiNYTqPKNmZ0OsAAiI5SbQJJNoSKIRxQb/Xb2l
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 13:10:59.4054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca46fcf-1df0-440d-88e6-08d593e43029
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR04MB0750
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596096527090785384?=
X-GMAIL-MSGID: =?utf-8?q?1596096527090785384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Previous implementation overwrites PCP value, assuming the default value is
0, instead of 7.

Avoid this by modifying helper function ethsw_port_set_tci() to
ethsw_port_set_pvid() and make it update only the vlan_id of the tci_cfg
struct.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h | 13 +++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 42 ++++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     |  6 +++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    | 37 +++++++++++++-------------
 4 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index 1c203e6..da744f2 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -49,6 +49,8 @@
 #define DPSW_CMDID_IF_SET_FLOODING          DPSW_CMD_ID(0x047)
 #define DPSW_CMDID_IF_SET_BROADCAST         DPSW_CMD_ID(0x048)
 
+#define DPSW_CMDID_IF_GET_TCI               DPSW_CMD_ID(0x04A)
+
 #define DPSW_CMDID_IF_SET_LINK_CFG          DPSW_CMD_ID(0x04C)
 
 #define DPSW_CMDID_VLAN_ADD                 DPSW_CMD_ID(0x060)
@@ -206,6 +208,17 @@ struct dpsw_cmd_if_set_tci {
 	__le16 conf;
 };
 
+struct dpsw_cmd_if_get_tci {
+	__le16 if_id;
+};
+
+struct dpsw_rsp_if_get_tci {
+	__le16 pad;
+	__le16 vlan_id;
+	u8 dei;
+	u8 pcp;
+};
+
 #define DPSW_STATE_SHIFT	0
 #define DPSW_STATE_SIZE		4
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index 9b9bc60..3ea957c 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -529,6 +529,48 @@ int dpsw_if_set_tci(struct fsl_mc_io *mc_io,
 }
 
 /**
+ * dpsw_if_get_tci() - Get default VLAN Tag Control Information (TCI)
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface Identifier
+ * @cfg:	Tag Control Information Configuration
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_if_get_tci(struct fsl_mc_io *mc_io,
+		    u32 cmd_flags,
+		    u16 token,
+		    u16 if_id,
+		    struct dpsw_tci_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if_get_tci *cmd_params;
+	struct dpsw_rsp_if_get_tci *rsp_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_GET_TCI,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if_get_tci *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpsw_rsp_if_get_tci *)cmd.params;
+	cfg->pcp = rsp_params->pcp;
+	cfg->dei = rsp_params->dei;
+	cfg->vlan_id = le16_to_cpu(rsp_params->vlan_id);
+
+	return 0;
+}
+
+/**
  * dpsw_if_set_stp() - Function sets Spanning Tree Protocol (STP) state.
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index 3335add..82f80c40 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -306,6 +306,12 @@ int dpsw_if_set_tci(struct fsl_mc_io *mc_io,
 		    u16 if_id,
 		    const struct dpsw_tci_cfg *cfg);
 
+int dpsw_if_get_tci(struct fsl_mc_io *mc_io,
+		    u32 cmd_flags,
+		    u16 token,
+		    u16 if_id,
+		    struct dpsw_tci_cfg *cfg);
+
 /**
  * enum dpsw_stp_state - Spanning Tree Protocol (STP) states
  * @DPSW_STP_STATE_BLOCKING: Blocking state
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index c723a04..ab81a6c 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -50,14 +50,23 @@ static int ethsw_add_vlan(struct ethsw_core *ethsw, u16 vid)
 	return 0;
 }
 
-static int ethsw_port_set_tci(struct ethsw_port_priv *port_priv,
-			      struct dpsw_tci_cfg *tci_cfg)
+static int ethsw_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvid)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct net_device *netdev = port_priv->netdev;
+	struct dpsw_tci_cfg tci_cfg = { 0 };
 	bool is_oper;
 	int err, ret;
 
+	err = dpsw_if_get_tci(ethsw->mc_io, 0, ethsw->dpsw_handle,
+			      port_priv->idx, &tci_cfg);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_get_tci err %d\n", err);
+		return err;
+	}
+
+	tci_cfg.vlan_id = pvid;
+
 	/* Interface needs to be down to change PVID */
 	is_oper = netif_oper_up(netdev);
 	if (is_oper) {
@@ -71,17 +80,16 @@ static int ethsw_port_set_tci(struct ethsw_port_priv *port_priv,
 	}
 
 	err = dpsw_if_set_tci(ethsw->mc_io, 0, ethsw->dpsw_handle,
-			      port_priv->idx, tci_cfg);
+			      port_priv->idx, &tci_cfg);
 	if (err) {
 		netdev_err(netdev, "dpsw_if_set_tci err %d\n", err);
 		goto set_tci_error;
 	}
 
 	/* Delete previous PVID info and mark the new one */
-	if (port_priv->pvid)
-		port_priv->vlans[port_priv->pvid] &= ~ETHSW_VLAN_PVID;
-	port_priv->vlans[tci_cfg->vlan_id] |= ETHSW_VLAN_PVID;
-	port_priv->pvid = tci_cfg->vlan_id;
+	port_priv->vlans[port_priv->pvid] &= ~ETHSW_VLAN_PVID;
+	port_priv->vlans[pvid] |= ETHSW_VLAN_PVID;
+	port_priv->pvid = pvid;
 
 set_tci_error:
 	if (is_oper) {
@@ -133,13 +141,7 @@ static int ethsw_port_add_vlan(struct ethsw_port_priv *port_priv,
 	}
 
 	if (flags & BRIDGE_VLAN_INFO_PVID) {
-		struct dpsw_tci_cfg tci_cfg = {
-			.pcp = 0,
-			.dei = 0,
-			.vlan_id = vid,
-		};
-
-		err = ethsw_port_set_tci(port_priv, &tci_cfg);
+		err = ethsw_port_set_pvid(port_priv, vid);
 		if (err)
 			return err;
 	}
@@ -819,9 +821,7 @@ static int ethsw_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid)
 		return -ENOENT;
 
 	if (port_priv->vlans[vid] & ETHSW_VLAN_PVID) {
-		struct dpsw_tci_cfg tci_cfg = { 0 };
-
-		err = ethsw_port_set_tci(port_priv, &tci_cfg);
+		err = ethsw_port_set_pvid(port_priv, 0);
 		if (err)
 			return err;
 	}
@@ -1254,7 +1254,6 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	const char def_mcast[ETH_ALEN] = {0x01, 0x00, 0x5e, 0x00, 0x00, 0x01};
 	struct net_device *netdev = port_priv->netdev;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
-	struct dpsw_tci_cfg tci_cfg = {0};
 	struct dpsw_vlan_if_cfg vcfg;
 	int err;
 
@@ -1272,7 +1271,7 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 		return err;
 	}
 
-	err = ethsw_port_set_tci(port_priv, &tci_cfg);
+	err = ethsw_port_set_pvid(port_priv, 0);
 	if (err)
 		return err;
 
-- 
1.9.1
