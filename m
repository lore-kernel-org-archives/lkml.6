Return-Path: <razvan.stefanescu@nxp.com>
X-Google-Smtp-Source: AIpwx4/nepTKAHpUzR4W+SmpYsq8FG11R6LAsn2mJ9xwsshCvxWJC821UgYcPZMu/tE+dpKtFxkB
ARC-Seal: i=1; a=rsa-sha256; t=1522234236; cv=none;
        d=google.com; s=arc-20160816;
        b=EwZ7aPnyJ9GYVXBUzQom+LuJrg1o/7htcVidPaCgLDTknFo7tnJTE69wrYmLHD/vbB
         DprUxCB8sbiJDA/xXk/npihnnR0llLFwChi4G3D7MzRWkcY5q8JXwUlgKGdN1jqaPaze
         shXXHHdqg88IWGR74NWQ0JR3aTkEgYORkTH6cMESVszf4tu9KiuFY29UKOQjv/ah9obQ
         ATihzJ994crngNnToaQ4uUvvXRbBGgck/AOuiPcXZPI8NWRdX6s5sXlU3+JT0gkpzAM3
         zBkiY4dRSsHYEKKFvzWkz4+4qHVdA+U7WMmiQx2xWFk8tPbXOcM3Y3b0WibRpfB1jnV6
         KLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=gAc9ldbKWO3flds3fkegMsVCUmR1FAWGidyspTn1t50=;
        b=tDDQTRB1vJTYOsVfoDiap6FGHVPyyM3XvaSaK42gSnPbpJcIKu9zWWuG1KWUKhaxTe
         V8kFMTHxll8AZUiU1vAib5URqNAGyUmzLhDbqI7ns5Vjrk6gi2Oloo+rpNRkO8JVqzSb
         PqsL4xUtXeCsXzM0FgD/AzjQ1bmjZyVvfNBHF7fBrdoztFQ3ZSaOTwhO/zj1OeyhjXdc
         imrRehHfTCpgy8skhRKgtU7mjDvtC213eXVYfGmyk5SoBOhE+0O9P7U0hIrqNh3sHqb2
         iGA1dxZguy4boSMhYKbluM43uwoIRA0CBzPJ0uC9MJISystXJqkGmbYO091UUB+xSR+L
         3Lbw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=CTERfT39;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 104.47.2.55 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=CTERfT39;
       spf=pass (google.com: domain of razvan.stefanescu@nxp.com designates 104.47.2.55 as permitted sender) smtp.mailfrom=razvan.stefanescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	alexandru.marginean@nxp.com,
	ruxandra.radulescu@nxp.com,
	ioana.ciornei@nxp.com,
	laurentiu.tudor@nxp.com
Subject: [PATCH v3] staging: fsl-dpaa2/ethsw: Fix tag control information value overwrite
Date: Wed, 28 Mar 2018 05:50:20 -0500
Message-Id: <20180328105020.17165-1-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:404:121::26) To DB4PR04MB0752.eurprd04.prod.outlook.com
 (2a01:111:e400:984b::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03826a55-8c7e-42c0-68b9-08d59499baf5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB4PR04MB0752;
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB0752;3:B04bQCM6R69gYlTW/CuXpEWmtKFh6wm3VZJTvM59t44h8cVmKyD/onzTEaL59y9axpNAZl31Id1+ezNcWQ1FZlwtMJzUoKswZu5CbhzzddM6ZFO07tmdNusAQ/qNYSDCGVEmczFZ1LeBgx+kIi68+Z/k+iQNJ299nGbohgTwsXfmkvMfJE7WZWvgzHfdm3WntuAI/S4OPBv+UEsCx8bFxEk+zYY/cLwK4mJLxv7l6sCzRD1v5YoeGyZN4mJNMcxq;25:inUO/Ddkt+rNiCwveTMmFWaiJqcclxC+fJkkBh77yT+rjYPHKzLR/OtKIIuRA2NQKHh388e/RYm+uy+MS+mR0pS1DQw/Ax7gM6IMevm4bRxR9OPG7yofGN8UqBYI7cQ8q6avYPZ6Egt+iuwBSBhLNQPc0ZGnwrLcQL9aeJEjlCY2D3IO1MQxsYajRvGtJ/js7oJISzlPRpQZR9oxi491WsWvk3jkgBaF0zkk/c6drYnxntoOXJBrcGmEMc4Xn8CqpaSD0xTS/nnX27NFIbrsOmrRggoB6dfQ6G+5yFU+FPLZvwQNsTMEXGRTfS1nm+PReXUd09aDvED9mf6SNDRp1Ws94Vnx3Gysfqa42Wtfl/4=;31:XvXtgJRG5cxxxtbuj7WVAZyDq/t5XGXFNnKV+EWC9oVRR7v704d2wf0vHiLUsadU6M1hLgihpvTbuEUqxrbblO/keyHS7LDS9cp3NcOiYGlQtl5yEGsidND11jIaQwDlgmqUanS/6jXOiASVNhGKctsNTJoSBnlx1+4KdrF+OQKOimcGgiyQV85089xD4gJvksKmjiignKfK0ue5lHFxFZ0XW4dHWTuzXuVV6FaPnGQ=
X-MS-TrafficTypeDiagnostic: DB4PR04MB0752:
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB0752;20:qVPhfR2vcGzRWMxxT+FZhWwJAmM8emZWjc4RY+9sqIGMuL6qr+OyuPrx+z4IUsaFC8PB6EIs2AxTCQAJebDYeG3xIZqSIOy3UO/HGqgII3+KDb4Tc3kLmok64aI3sMIOjKvo8lyIpzFvINxmWPCnabcndfK2mpYPefyza0pqnp50ryTwg2yzyhoMKRZV2WGZGEYviw7Qxj1m/YLyb4fYJSIOk6mPy7LPJGuncb7IQxK51EkMFQeBOF9MIWh93+kjJp1k2QgZI5Mzddnikkl8Xptrw+FIUbLtOVoSjXCC9R5PMgdjzhieK3HPNEs1Cmd7k9WKQJELxWVT+57joJbjGWD8stKGgeGppBaCxeTdgKns4pGMR2pw6pT+2DtdC2AY8PY1+vjiGKp6n0DAJ+iJOk0cvj9uFw1ju4eI+kX/LNaKNX9T9BFFmpQEt0VuUh2F1vsm/KPYDCsJdRcv2hZNcoaH9HPRlGSdIhRCr93noRoa7y+bQQ7X9RW5KfCKVOOJ;4:Axv+rdVlm9EXbQpCvz5hpglIffAJilxm6xadAOqL1egHjiIWIjHfg6ZymFaAXVyQgzW4vQ6dBMs9PY3wQ5Jea/gzwWJKRLa0EV0IWrKNft2e4GT68NyNhGMcIbk8kibliE37hPsAwRYz2Lf7u3KGua6aNq8ZG0ZPrRpg4y8PJrSKj6/KmojT4zjgvKvVTfhpIpH6loBlveD+UAywDkhbTsHe5BwlRLFud77o47IlPdpSPdZBoArd2opExc15mQXRYQaFGtvBYEJMf55BBGX+NgPJb7jClmnevH9nI3HxJLByocoOnLawbFmITICT5aHewqWG1ujlHAeZu2Q2IexaqZ8vmFounH2Gc9IW2FW31ZI=
X-Microsoft-Antispam-PRVS: <DB4PR04MB075283853010FA85018F937FE6A30@DB4PR04MB0752.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB4PR04MB0752;BCL:0;PCL:0;RULEID:;SRVR:DB4PR04MB0752;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39380400002)(39860400002)(199004)(54534003)(189003)(956004)(6506007)(6666003)(6116002)(68736007)(3846002)(2361001)(26005)(316002)(16586007)(4326008)(25786009)(186003)(476003)(2616005)(478600001)(6346003)(16526019)(7736002)(39060400002)(50226002)(8676002)(81166006)(305945005)(8936002)(81156014)(6916009)(48376002)(51416003)(97736004)(50466002)(59450400001)(106356001)(47776003)(386003)(5660300001)(66066001)(53936002)(105586002)(52116002)(1076002)(6486002)(2906002)(36756003)(2351001)(6512007)(486005)(486005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB4PR04MB0752;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB4PR04MB0752;23:7xD004C8uuHoaKxcbUjKo6k64la+78qSDaygLl2UE?=
 =?us-ascii?Q?7txOHax254lAgfyUrL3Dp2pPJzVWR1db+dGzRZyvzFGzHJnj4Kp3x2OK/kZO?=
 =?us-ascii?Q?nUl4ilaJCHIFSW/i6uoj6yd3djM0re6klHFNoEtjFqJrlX1atgPfa+l1ZcjS?=
 =?us-ascii?Q?rmVJY6M/937HNh6XEb65TT4h9ukbAyhRtGOnHqcjQYWMO1LZ9V3qlB7adPoY?=
 =?us-ascii?Q?kkYdiZSYYGazkGUOT98UX+3rFNDNU8rBMNZPbndZBmXBOGFKBeZIKKhhW6CA?=
 =?us-ascii?Q?k7o8L4ccIgaJAsi3rvVwvTXFLG9VglGc8b6q5SUzsW1f7wDJb9Tbhe1C3TAJ?=
 =?us-ascii?Q?ZdLXwNqVjTYg17aHzByM46Xwjz+VeAZbLfpTt309LissIznEg1c5LzFM0wGN?=
 =?us-ascii?Q?fdynOqBSMUllbi3XcAvGH43qXd0FQrPcStXYII7r/rS7aWgy43kmicZR10Q/?=
 =?us-ascii?Q?XgdyQgYUClhgXCyPj2yQxTUGV9fRTDzYwJzeGukCBcDrxRA8Z/2Th+uO2bOq?=
 =?us-ascii?Q?qclrfXex5agciMp5c5oBYaEZkF9UTFyMDjIk8NZUksWQZuzYPOoZmXmBt0x3?=
 =?us-ascii?Q?nRiVxZO8sICIvjOVpe45Azy+g2K/yhcoJHd2brUyJMO+4Q7t86WQN5YTF8tE?=
 =?us-ascii?Q?IDCuQVExZSFGUUWcKTaGZ/HvflVtBtQqBFLQGzmDJ2ivYoHnPEwKdwc9FLiF?=
 =?us-ascii?Q?nNqlg0NmJ89izj8EoX+atOKIAnYwqyxmLzz3OzP1hnJFHjh5k4M8q1unAywY?=
 =?us-ascii?Q?2FT8YiBqSOx6BjGkyV9t/8RDTIxnHVPIw9tJBwEGTpMlCuY52LP2+0vjndnz?=
 =?us-ascii?Q?kPnOJH2KQdwzUZKkKJsuhdbn+XUjh0eUAjF6UVnZ55qK5V4aFAhPe7xJSQSc?=
 =?us-ascii?Q?weBHAJMrNSz5XANEKq+drlE6levb8Bm0Cohsl/aGHxRpwGC5xJC7LAFHMNhz?=
 =?us-ascii?Q?nbYnX/J4BCsRfLJI11DlpeuGI8W8H1hgkU6nR4lQ//S8tjTYIrSDPwkyN4yo?=
 =?us-ascii?Q?LHuIW88pWCedZLUxulcsQ4KhzSiIuUVqxsoy+iFecdwO4GDB9PfuoyHlCk9S?=
 =?us-ascii?Q?PlffjQtYSJuWK4OUXFarZatEnOwbbK5Zne9uFQMF53mWIu66Rys3ZX0uwU1C?=
 =?us-ascii?Q?9BMxF327hhOcQgWn/0aNfduYu5+lJDHzvr4I9IMAUjCntyvrmb9seaeL0Tzk?=
 =?us-ascii?Q?qt8GqzL9EF7Nxn4jvJF1t7SIIi+34F/EFLVwIvMN1nrwzPVqkNE9ZjkEDo+p?=
 =?us-ascii?Q?U9048/fVReCPjDq0VNvJwMOnBvJN7jdOxOeH6GunKz9SmriDG944YNTdgcwC?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: JNnKGKgAopjxM2enj0UaW7Vf/o41SCrp45aj83W6CHUfWex8ISMcNHs+Tc/ZlDghTBiGIol9k49+Q25IxGm7rdLY38xczeQLm9c+aCFtmCKXcaHnmGfv2Pzj+vyktjIlvotynCC9d0z2RjAiTzQm4JY2hnaNfDxbusLvGO9G9CuM5I/k16WNyHbmsMq6sRJu
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB0752;6:uXSc87ZG3XmUkJGOVvxtgynzjLX8u1Xzcf0hKBDmXWKEbpKRZZ0U4jkM28zGMobg9qpz423x5xRDnOmmfN3/OFH/dYCfaL69H6eO5MQFHxVUyalAQKU3Z9uPAq4kU7BEmDSAqfnVynfSXZnxxGb1h4K5KBXa2xXVKg0XsHihTOVQGzgvmVb93aJSx7R0YDCUwveUoedFsMdVUy9kpS/reWJ35sohwkCZya8c2Ck9AOyDPhE7hqSuKcVoD+Uak2o4ZhhTp1tnilAelIx30h/NYVV/zXKdK4upCkI0a6Zjh8vGkquaickCI43i54QSVORTg7RshYjAIlRggJnR3Oiy3bi1D8o8qOqfaiMbJJEgdZh5wYnvxBZAxBenE4QYKWJ48gPuj1OAYcgviqiZv+HWXh616S56NaQchwc21GQb4VOO5hYdUge9LtfpwenCfVJuONdxCT/Eza1C9aoFfqsl2Q==;5:+05A8RcgMGLkRK0hRdnyMPZH1SFnpoh0cw5OI/hPLm0plqb/K2PE6rfMs/xoWOKBQ6zM4+jBlBEWxDpeazdxdSxjUlPPB+d5pp6hE6IAeuF9vV0J11dAdN2UjDAhIpwW0jia8XfV7c4UF4HMHgTP3OAFuljodNMt4cDXCj8bdD4=;24:sHtld92jagwuossBaBRg12fWH5TFEMwosHJrk3R28jHOyOemFiEc/b/paQFxEXx9v5FtadGMPZupbq3YGkob3mhAFc53M2gfm8RrydH/0WI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB0752;7:y+bwMj6kcX1yWOzQwZb8vnNj3fl+5e2w1kCYKN/MsJEqZ+eEDr1nFTR4Y4GznpxW+ZlzcAySalwForVKZoZ0TtdQX7G49iH1MxliCxdC0cOw8J/L1eL7u24CLpKv3+LUBQdPa4GzDR2atpEJaJMBPwrMSUjKXbnkDLaV0axzMs5v2wojZYRnJXeEIqwhWg/FS3EDVt4HBBzJUz0aJgFnQRs72M7fjPnKCUzKG0lzmYZpSDgVxKW2md/0YuAX2E5/
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 10:50:31.2377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03826a55-8c7e-42c0-68b9-08d59499baf5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR04MB0752
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596162968947581995?=
X-GMAIL-MSGID: =?utf-8?q?1596178286180636618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The tag control information (TCI) part of the VLAN header contains several
fields, including PCP (priority code point) and PVID (port VLAN id).

Current implementation uses function ethsw_port_set_tci() to set the PVID
value and mistakenly overwrites the rest of the TCI fields with 0,
including PCP which by default has a value of 7.

Fix this by adding support to retrieve TCI set in hardware. Read existing
value and only updated the PVID fields, leaving others unchanged.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog
 v2: improve patch description

 v3: use the updated MC command stuct name

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
index 9b9bc60..cabed77 100644
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
+	struct fsl_mc_command cmd = { 0 };
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
