Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELtA6AUDDoLhJeTOVntUK4bi/wIpl39NcCd8MwG3Uu5Af06NNxRQCiT2gp2akbwwtdLAwAQs
ARC-Seal: i=1; a=rsa-sha256; t=1521133579; cv=none;
        d=google.com; s=arc-20160816;
        b=MPGIYILH40FHpV0tNikfyR9qOmGng6VdVIFplve7WyfGe6j77wi4KHWXK+QC/b53zn
         4bufuRXF2BGvE45umUztab9vifyJObyk0Htlh58SU3zsUoE5nFM98quLqITb7U66f3ek
         kwClYfZ+10riZUH39zS8M8oHD/Yk/18TIRO5pDLMeSOTsmS08aaqhNqlinbwzygWxmN4
         QzfaRTb6Q0W0kWlNXIHu8iT4Q3Bmimqb1rcpNfsMEXiGrch1pPzOeogDDULz03qWm3gh
         fvPUc83bUK1rGUFkKU+4SpcxRje0odG9bS73yrN94VgeSeLXyM1Kw2sFy2rEhRG+NBHl
         24Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=1JywQAvxH2LVT+KOYuROvmGbUWQl46xikx0cxicOulE=;
        b=TpfMUIcUwbEK2ZlmKy6RYipNLxQJxs5AL0pzz6ZREQaJe9vW6ljaUIc/UcpQ1DRGnx
         gQ7K/UQ8aYPf1LbrtSTgnqsGzIycdqtIQSKcuj/c7JaLfziKopRihO3ZfCZuFUfxUXew
         v4LDliQnNXNBKgR3QQFbDPXobqj+Cthdab96TmNSNrglcPHOy9pVpgRBfFrpsipHoN0u
         XXIX4jRyr3fEzsZQ9S8WpsS0QXAkgqqnZ2GZciNPQd72zEj1c0CzXOKRwv7WOt+jwHhC
         KpKf6+biG9IQdCgRtBBYxD0D0EYx+zg1nQz8L3JfUTBsk05SXo79JfDXRqm+uZc1RD+u
         b4ew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=SMf9+q3X;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.43 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=SMf9+q3X;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.43 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: gregkh@linuxfoundation.org,
	laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org,
	stuyoder@gmail.com,
	ruxandra.radulescu@nxp.com,
	razvan.stefanescu@nxp.com,
	Roy.Pledge@nxp.com,
	arnd@arndb.de,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 4/6] bus: fsl-mc: add restool userspace support
Date: Thu, 15 Mar 2018 12:05:34 -0500
Message-Id: <21b27906ccf93dafe5d24a2e3aa093402310581e.1521132659.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <cover.1521132659.git.ioana.ciornei@nxp.com>
References: <cover.1521132659.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR15CA0039.namprd15.prod.outlook.com
 (2603:10b6:300:ad::25) To DB6PR04MB3206.eurprd04.prod.outlook.com
 (2603:10a6:6:6::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa1578b1-d210-4c1f-3fe7-08d58a9710b9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3206;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;3:r/XvH8Ys8nhz7uHIDCazicfEKEbLyFis4Gyvh4iNJFwKEZFk2jYz7m8sg5+xRStPpEk1XKOpnYDe4+Xfm0ds5v12b8e87A/a5nt5CgBBk9qX1lLmNnCKNE918drz8/uR2XMFsU1RDLRHFod6w+2hWWKZfS+DegrX80VzdnsHL5K/8LJxTEXyXkFYkhcenvm1gAeTPmasbkw8iYgQB3JiNb4FvmszjwlchlKgtnadsIQluU4F3qyG/VE0dS6H7eag;25:aHtI0mCRajNeI7ic19oMXrVtg7fM9vxYTLZcP5zsOOe293Y0gHDrPnoIs88P2ZxHRvBMpBiTL718W11hbieiGhlPJQTOfN1x/6JjAl+RbnYeQ1O6k02U+y3H9e3czOW8DWgtZM0uchlMF3PW87TWzs+BQgAjRlTI5Av5n+xnGe+AjykvU0qWBnRIeplm3c5mXSvyGsv4wBu/56j4LvEJ3aaN4RPlWSPHRL4HRhIGyE+45/zPDRXhnY6StNT0DnGVUIrvi7MXDxFgXXtRg98gHaJBd2p5NI2RJQEHK6Cra49Yq0yjxn2DbrySdemcvHidFByrwZgvWv67iMSsT1auuA==;31:KtYvI98Fwz3Tj1u1eZTtCRysEh0aeqoABaxqjCXMfNg3Ufu6dyiXLG5qgT2QPZxPYrdrAEj9LAlc7cV5GSb7MfTqsFFcVejfh2foPlsmEd67bbg+EfJj6mmS3BI7ZcY/LBNjpSjRJLPOWBl2fITMeAWd5HiMFhnpULQw043SYUVnV7k1PRaAVUrx9sDai02xhiirSOWnrUu24Z3ZVTob2QiT06cgNqb1Fj0UO2MQypI=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3206:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;20:iahJIPoOEqFGTiTga4S4p+PS2yDqKRZmPg8jpeei8VeUFXmJ/uI9fXz9U0ceXyAvDeHj0wKM9e0FQYHZRJPegGMW7RIGwCN3loDAJoglh23nc12fJH6aGzJhrqW98uSjlZEkr7fPctCjeI2C0QOSVfRutmgiTWheEVqNpEGQ419HNTz972+A5+2RXlmvbvMnmHYEU4K/pXuWn9OhwuvZa4MlNIoi3b9mGL/FFS9z77ZUTKfGX8gVnH4bIZgUIrhjWpmAFVV6pxzbP+lkh7c25eVNSOt5k5HJbd0RaGVXcdJWB7tl55vyGcDUt9KadGZO6vxxQgBivGUsPJvM/qQTh6MCzcUjsHEUAW0yLW0tL1Hfo70lZNuCl36rI4i7w7i2VNKi9RQK4XiarB/Db24t69I7mkBnrX4ajivME687djho7iKtULBzvBX4rbjlgczC3N6lJq7ex7woTfun8tFdD8qSFEEUi1guoXHOTMMp0Oi2YxwQZ38bpSt1ZHsSaUTT;4:424FOp6S9cWi/FZ/uDY17jtSwETmii+oMx1615Gp4NsOE4eHmxcr/S3ydA1Y9CGhLaqxqzK1fbHpWBnvUOwmNoPgEP0dntqNm5oEw/a1XmkZLWGxH39s35Wlj8qIIuHDY+SPPYPDhqVK36AG6v9IJdmQA5ILabh4qVudkn9dthm/QTuHRC5y+BWawaxskCjIHa6pYbpdu5FHX/+/zRRDtCbBnNeqVOwXq53CtTo0cVjCEieb9CLJmtjEb4z9tt1XNfAyLUeOxoO69r6OoSMDYTJX+C5RjulcnJBKcVGt4Szng5Pr5+wBEAnrOOMv14/nqUtMx6rC7poCPH1BIRfVAephiW2eAOVG+AM3EPD9pyaTMWVhjo5Z2Pwb42mlb/ztjkerZ6vCvra8fFU/tsQsOmqixMNMXw8Jd/fzh2PdVAM=
X-Microsoft-Antispam-PRVS: <DB6PR04MB3206077C765CBB3BCDA1E5C2E0D00@DB6PR04MB3206.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(35073007944872)(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3206;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3206;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(346002)(366004)(39860400002)(189003)(199004)(7736002)(105586002)(81156014)(6486002)(50466002)(68736007)(3846002)(47776003)(66066001)(50226002)(6512007)(59450400001)(305945005)(6116002)(36756003)(966005)(118296001)(48376002)(8676002)(53936002)(6306002)(8936002)(5660300001)(478600001)(186003)(97736004)(16526019)(316002)(86362001)(25786009)(106356001)(39060400002)(81166006)(6666003)(26005)(6636002)(4326008)(52116002)(386003)(2950100002)(51416003)(6506007)(76176011)(2906002)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3206;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3206;23:vnokKDNkqjjW4gyO+k2uHI1kVv54I6aV8JfJiyIbT?=
 =?us-ascii?Q?yQpg4iCJG9k2u0Ey89SROO2Mazmqv4pCRA7iXKwAmjKOHJOQBZ6OxhzW9V7n?=
 =?us-ascii?Q?oLg3C9pLru9LoCLCK96HzfmFFi5HP1QyNaWc/OhgJCx+JCWczpiOPZ3hPubR?=
 =?us-ascii?Q?P3cx+xsrgOOGfhvWpElB2YBOv1/RDKFDzJLKgeNwam7OWZlHlyqOJ72bKAB0?=
 =?us-ascii?Q?0EQvza9zpAt+G91o7FzGKfsTfrJ4EwvtFsY7voi65z+SEzViKB19eu1eagjs?=
 =?us-ascii?Q?n1IdSRvtGWEQTWsVmZFNMeAwT9MHGgq7cD1Ur6BJSNFKw9Ck8lt5EacdiSEW?=
 =?us-ascii?Q?wVkYy2DPy9KGWq4EM6TX8Jvb/TCBJ4wzwLkyumyjyJum7QIq/TBXV16Gd6do?=
 =?us-ascii?Q?g9t2LSojTcNndiBxw0dZILvPGkgh9BPBtRdhVSs+ZZch3tMRHRgyaulR+8fY?=
 =?us-ascii?Q?CwLT3Vz7we8XmxzP/2fiQQnIdL//N6YFLu7aHTyCWdeYxe+4Z9gxtVnSWI4P?=
 =?us-ascii?Q?sDAuvXx01KG4tAqpzqazImNsKjFd0eY0TikoGRgsSPPGo+eHV1nBy8KF594p?=
 =?us-ascii?Q?eXPxfSL/Ks5BLZxa7sGCAsnq0Q+I2kNMmeLf4SAzZXzeSH1rY/himlUebSz8?=
 =?us-ascii?Q?MEsdiqUlvCXZPZOpf0QssWYjayAXsktNUHGApyJCt8E7s4RCywVJBGETPJE7?=
 =?us-ascii?Q?IUdfO+7X9dB+MFssyr+8J90YEKEb9HWNpkATOu6arf8VsQsV7Nrx1kMCpylx?=
 =?us-ascii?Q?+JzlLFXpAwBWD8W3dVSXe/ihlz3+fQloiCaZRKVxn0xdc6ufAyjMRtdJbfQz?=
 =?us-ascii?Q?mqlF0GYPnLwZ+IybjsWACrn0RaJw8CWjM/fKoZfbKDyuU5ZA1Hz71w0v8jWy?=
 =?us-ascii?Q?QOv+l1qSZObmyWyyxGc9n3yUB3W85s47Sb9C8HFjaep0C3RwoqSeijS9bGQM?=
 =?us-ascii?Q?RejH8gnSZtB7zqe6JeylObCwoqxJ3avLSXwr2MKQ5QfeMCJ4gppfIbH6MRSM?=
 =?us-ascii?Q?pjfCvi9pDpyJtYvQjFpDaM1+00/zixf754rHMU4lkkWyOY4mNnkwtK421cg4?=
 =?us-ascii?Q?aMX6DETMoOyd7MlMRH1qIXwxpdrZATpLYzr6XLX9Ga8h8dw8UD/OimD/VJxb?=
 =?us-ascii?Q?+aHutHqbuo6m4gqYrn+/eI0doDti0tsAhK40P1qiw3iWEXHH+bTccPWZde3G?=
 =?us-ascii?Q?Hd+N1lHy/LXX68wf1531lKR+poQ4rM5DRZh?=
X-Microsoft-Antispam-Message-Info: mixhVtVYMhVqrnMLB7+I1/FtsveQW4vGJwaQLMXyyb5SUOG4sH9R8fYIzxiucqTTvn+wJFg5LiyYEk/2LE48bWurVubVK/7co0gzCtLBs/qJhl3YNA+hcEpb8TiGibdK5q1oJnBzRvwYYC2bvnZSNG//a3uFAaHHJbA9TdiCqsV/DWCz0Wh9zUayeEQwdGP8
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;6:jdRb6U9NKjxH9nAyoOFKEAYf/yFqKaf5dTkuPw0mXExzPbBZWP386nMcCfs+vhI8inzuRYuJRKMa2sW8kX6yYUjOwrtgzWBM2iajbRkfmtZXyxB0QYrq/cDlJkNpsreMM+BU4JyCci20sBlfKGlbwLwWiNrYpkafoaTFiggEe7iud88egwdPOhuevh1zrQGeOMtBhn5LIxFSTZvDKy17l/hKMg27Ja5ivOiHsn7cAWwweb8bFrqpsAotosdSEWEfMCKDWyD2KxaYjz06yI46L6WSAxYtJOQwzW8cIFZp8e1S4YHtFbO6Y0D+H/2Ua6TS5KQwAXwRhA+yO+pfw7gDojDOZi0vm5RiZVdyCdbQ2Wg=;5:PovZ7dOl/Tl7MsyJJLJ3AruUhxk7YBza4yz6RNOh6YZejtXfZbZ55pmur2b/RjzOwXjBGF6THOx0cj7yb2P2Dm/oIT/0u7oteRU9FqEf39IpWQRKmYbov3yRMsDcpeSZE1qqKuplND2oCLBNKqiH8GJyhxQRA0zI5Cd+x5qfdDA=;24:WOV7XOLc9NUSSm842wmwYCJFGEDsIATBxQMC/uj/XVIC+cUk0AGP2Uv3PEzeLUkhW6Rsuq8hNHnUAAk8YTQAmJhiLsTEmUnS1bzCescYZ8E=;7:Hsuwz1+1O/kWTyL7o7GB37lFG5ansrwv2gmCz0+HCgm8TNt5vK9FStRBAsOsen06FIXp+mrQrRtPDqiM25cmTWhrzu9MwFr1AdhM5DJMOE5/5sjRxBOLGjiEWtLJ3YU+ynMc41CQTtaPbqR+y46m9klSwCHpt3YSez579hqU6w96TYiO1yE+dGqTclFJs505XFj3NqWwPzGj7hClPzplIXm5hnfP9vi2PEjQMTY/3VoQDTetDfg71VQiYO7KeNGK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 17:06:14.5250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1578b1-d210-4c1f-3fe7-08d58a9710b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3206
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595024164535316092?=
X-GMAIL-MSGID: =?utf-8?q?1595024164535316092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Adding kernel support for restool, a userspace tool for resource
management, means exporting an ioctl capable device file representing
the root resource container.
This new functionality in the fsl-mc bus driver intends to provide
restool an interface to interact with the MC firmware.
Commands that are composed in userspace are sent to the MC firmware
through the RESTOOL_SEND_MC_COMMAND ioctl.
By default the implicit MC I/O portal is used for this operation,
but if the implicit one is busy, a dynamic portal is allocated and then
freed upon execution.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
  - split the bus/driver changes in a separate patch
  - moved the ioctl in the uapi header file

 Documentation/ioctl/ioctl-number.txt        |   1 +
 Documentation/networking/dpaa2/overview.rst |   4 +
 drivers/bus/fsl-mc/Kconfig                  |   7 +
 drivers/bus/fsl-mc/Makefile                 |   3 +
 drivers/bus/fsl-mc/fsl-mc-bus.c             |  19 +++
 drivers/bus/fsl-mc/fsl-mc-private.h         |  48 ++++++
 drivers/bus/fsl-mc/fsl-mc-restool.c         | 219 ++++++++++++++++++++++++++++
 include/uapi/linux/fsl_mc.h                 |   8 +
 8 files changed, 309 insertions(+)
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-restool.c

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 6501389..1a2d132 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -170,6 +170,7 @@ Code  Seq#(hex)	Include File		Comments
 'R'	00-1F	linux/random.h		conflict!
 'R'	01	linux/rfkill.h		conflict!
 'R'	C0-DF	net/bluetooth/rfcomm.h
+'R'	E0	uapi/linux/fsl_mc.h
 'S'	all	linux/cdrom.h		conflict!
 'S'	80-81	scsi/scsi_ioctl.h	conflict!
 'S'	82-FF	scsi/scsi.h		conflict!
diff --git a/Documentation/networking/dpaa2/overview.rst b/Documentation/networking/dpaa2/overview.rst
index 79fede4..1056445 100644
--- a/Documentation/networking/dpaa2/overview.rst
+++ b/Documentation/networking/dpaa2/overview.rst
@@ -127,6 +127,10 @@ level.
 
 DPRCs can be defined statically and populated with objects
 via a config file passed to the MC when firmware starts it.
+There is also a Linux user space tool called "restool" that can be
+used to create/destroy containers and objects dynamically. The latest
+version of restool can be found at:
+        https://github.com/qoriq-open-source/restool
 
 DPAA2 Objects for an Ethernet Network Interface
 -----------------------------------------------
diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
index c23c77c..66ec3b9 100644
--- a/drivers/bus/fsl-mc/Kconfig
+++ b/drivers/bus/fsl-mc/Kconfig
@@ -14,3 +14,10 @@ config FSL_MC_BUS
 	  architecture.  The fsl-mc bus driver handles discovery of
 	  DPAA2 objects (which are represented as Linux devices) and
 	  binding objects to drivers.
+
+config FSL_MC_RESTOOL
+	bool "Management Complex (MC) restool support"
+	depends on FSL_MC_BUS
+	help
+	  Provides kernel support for the Management Complex resource
+	  manager user-space tool - restool.
diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
index 3c518c7..2017bdb 100644
--- a/drivers/bus/fsl-mc/Makefile
+++ b/drivers/bus/fsl-mc/Makefile
@@ -16,3 +16,6 @@ mc-bus-driver-objs := fsl-mc-bus.o \
 		      fsl-mc-allocator.o \
 		      fsl-mc-msi.o \
 		      dpmcp.o
+
+# MC restool kernel support
+obj-$(CONFIG_FSL_MC_RESTOOL) += fsl-mc-restool.o
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 5d8266c..0ade415 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -792,6 +792,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	struct fsl_mc *mc;
 	struct fsl_mc_device *mc_bus_dev = NULL;
 	struct fsl_mc_io *mc_io = NULL;
+	struct fsl_mc_bus *mc_bus = NULL;
 	int container_id;
 	phys_addr_t mc_portal_phys_addr;
 	u32 mc_portal_size;
@@ -863,9 +864,18 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	if (error < 0)
 		goto error_cleanup_mc_io;
 
+	mc_bus = to_fsl_mc_bus(mc_bus_dev);
+	error = fsl_mc_restool_create_device_file(mc_bus);
+	if (error < 0)
+		goto error_cleanup_device;
+
 	mc->root_mc_bus_dev = mc_bus_dev;
+
 	return 0;
 
+error_cleanup_device:
+	fsl_mc_device_remove(mc_bus_dev);
+
 error_cleanup_mc_io:
 	fsl_destroy_mc_io(mc_io);
 	return error;
@@ -878,10 +888,12 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 static int fsl_mc_bus_remove(struct platform_device *pdev)
 {
 	struct fsl_mc *mc = platform_get_drvdata(pdev);
+	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc->root_mc_bus_dev);
 
 	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
 		return -EINVAL;
 
+	fsl_mc_restool_remove_device_file(mc_bus);
 	fsl_mc_device_remove(mc->root_mc_bus_dev);
 
 	fsl_destroy_mc_io(mc->root_mc_bus_dev->mc_io);
@@ -931,8 +943,15 @@ static int __init fsl_mc_bus_driver_init(void)
 	if (error < 0)
 		goto error_cleanup_dprc_driver;
 
+	error = fsl_mc_restool_init();
+	if (error < 0)
+		goto error_cleanup_mc_allocator;
+
 	return 0;
 
+error_cleanup_mc_allocator:
+	fsl_mc_allocator_driver_exit();
+
 error_cleanup_dprc_driver:
 	dprc_driver_exit();
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index ea11b4f..00cca7d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -10,6 +10,8 @@
 
 #include <linux/fsl/mc.h>
 #include <linux/mutex.h>
+#include <linux/cdev.h>
+#include <linux/ioctl.h>
 
 /*
  * Data Path Management Complex (DPMNG) General API
@@ -492,6 +494,24 @@ struct fsl_mc_resource_pool {
 };
 
 /**
+ * struct fsl_mc_restool - information associated with a restool device file
+ * @cdev: struct char device linked to the root dprc
+ * @dev: dev_t for the char device to be added
+ * @device: newly created device in /dev
+ * @mutex: mutex lock to serialize the open/release operations
+ * @local_instance_in_use: local MC I/O instance in use or not
+ * @dynamic_instance_count: number of dynamically created MC I/O instances
+ */
+struct fsl_mc_restool {
+	struct cdev cdev;
+	dev_t dev;
+	struct device *device;
+	struct mutex mutex; /* serialize open/release operations */
+	bool local_instance_in_use;
+	u32 dynamic_instance_count;
+};
+
+/**
  * struct fsl_mc_bus - logical bus that corresponds to a physical DPRC
  * @mc_dev: fsl-mc device for the bus device itself.
  * @resource_pools: array of resource pools (one pool per resource type)
@@ -500,6 +520,7 @@ struct fsl_mc_resource_pool {
  * @irq_resources: Pointer to array of IRQ objects for the IRQ pool
  * @scan_mutex: Serializes bus scanning
  * @dprc_attr: DPRC attributes
+ * @restool_misc: struct that abstracts the interaction with userspace restool
  */
 struct fsl_mc_bus {
 	struct fsl_mc_device mc_dev;
@@ -507,6 +528,7 @@ struct fsl_mc_bus {
 	struct fsl_mc_device_irq *irq_resources;
 	struct mutex scan_mutex;    /* serializes bus scanning */
 	struct dprc_attributes dprc_attr;
+	struct fsl_mc_restool restool_misc;
 };
 
 #define to_fsl_mc_bus(_mc_dev) \
@@ -561,4 +583,30 @@ int __must_check fsl_create_mc_io(struct device *dev,
 
 bool fsl_mc_is_root_dprc(struct device *dev);
 
+#ifdef CONFIG_FSL_MC_RESTOOL
+
+int fsl_mc_restool_create_device_file(struct fsl_mc_bus *mc_bus);
+
+void fsl_mc_restool_remove_device_file(struct fsl_mc_bus *mc_bus);
+
+int fsl_mc_restool_init(void);
+
+#else
+
+static inline int fsl_mc_restool_create_device_file(struct fsl_mc_bus *mc_bus)
+{
+	return 0;
+}
+
+static inline void fsl_mc_restool_remove_device_file(struct fsl_mc_bus *mc_bus)
+{
+}
+
+static inline int fsl_mc_restool_init(void)
+{
+	return 0;
+}
+
+#endif
+
 #endif /* _FSL_MC_PRIVATE_H_ */
diff --git a/drivers/bus/fsl-mc/fsl-mc-restool.c b/drivers/bus/fsl-mc/fsl-mc-restool.c
new file mode 100644
index 0000000..c39b8e8
--- /dev/null
+++ b/drivers/bus/fsl-mc/fsl-mc-restool.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Management Complex (MC) restool support
+ *
+ * Copyright 2018 NXP
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+
+#include "fsl-mc-private.h"
+
+#define FSL_MC_BUS_MAX_MINORS	1
+
+static struct class *fsl_mc_bus_class;
+static int fsl_mc_bus_major;
+
+static int fsl_mc_restool_send_command(unsigned long arg,
+				       struct fsl_mc_io *mc_io)
+{
+	struct fsl_mc_command mc_cmd;
+	int error;
+
+	error = copy_from_user(&mc_cmd, (void __user *)arg, sizeof(mc_cmd));
+	if (error)
+		return -EFAULT;
+
+	error = mc_send_command(mc_io, &mc_cmd);
+	if (error)
+		return error;
+
+	error = copy_to_user((void __user *)arg, &mc_cmd, sizeof(mc_cmd));
+	if (error)
+		return -EFAULT;
+
+	return 0;
+}
+
+int fsl_mc_restool_init(void)
+{
+	dev_t dev;
+	int error;
+
+	fsl_mc_bus_class = class_create(THIS_MODULE, "fsl_mc_bus");
+	if (IS_ERR(fsl_mc_bus_class)) {
+		error = PTR_ERR(fsl_mc_bus_class);
+		return error;
+	}
+
+	error = alloc_chrdev_region(&dev, 0,
+				    FSL_MC_BUS_MAX_MINORS,
+				    "fsl_mc_bus");
+	if (error < 0)
+		return error;
+
+	fsl_mc_bus_major = MAJOR(dev);
+
+	return 0;
+}
+
+static int fsl_mc_restool_dev_open(struct inode *inode, struct file *filep)
+{
+	struct fsl_mc_device *root_mc_device;
+	struct fsl_mc_restool *mc_restool;
+	struct fsl_mc_bus *mc_bus;
+	struct fsl_mc_io *dynamic_mc_io;
+	int error;
+
+	mc_restool = container_of(inode->i_cdev, struct fsl_mc_restool, cdev);
+	mc_bus = container_of(mc_restool, struct fsl_mc_bus, restool_misc);
+	root_mc_device = &mc_bus->mc_dev;
+
+	mutex_lock(&mc_restool->mutex);
+
+	if (!mc_restool->local_instance_in_use) {
+		filep->private_data = root_mc_device->mc_io;
+		mc_restool->local_instance_in_use = true;
+	} else {
+		dynamic_mc_io = kzalloc(sizeof(*dynamic_mc_io), GFP_KERNEL);
+		if (!dynamic_mc_io) {
+			error = -ENOMEM;
+			goto error_alloc_mc_io;
+		}
+
+		error = fsl_mc_portal_allocate(root_mc_device, 0,
+					       &dynamic_mc_io);
+		if (error) {
+			pr_err("Could not allocate MC portal\n");
+			goto error_portal_allocate;
+		}
+
+		mc_restool->dynamic_instance_count++;
+		filep->private_data = dynamic_mc_io;
+	}
+
+	mutex_unlock(&mc_restool->mutex);
+
+	return 0;
+
+error_portal_allocate:
+	kfree(dynamic_mc_io);
+
+error_alloc_mc_io:
+	mutex_unlock(&mc_restool->mutex);
+
+	return error;
+}
+
+static int fsl_mc_restool_dev_release(struct inode *inode, struct file *filep)
+{
+	struct fsl_mc_device *root_mc_device;
+	struct fsl_mc_restool *mc_restool;
+	struct fsl_mc_bus *mc_bus;
+	struct fsl_mc_io *mc_io;
+
+	mc_restool = container_of(inode->i_cdev, struct fsl_mc_restool, cdev);
+	mc_bus = container_of(mc_restool, struct fsl_mc_bus, restool_misc);
+	root_mc_device = &mc_bus->mc_dev;
+	mc_io = filep->private_data;
+
+	mutex_lock(&mc_restool->mutex);
+
+	if (WARN_ON(!mc_restool->local_instance_in_use &&
+		    mc_restool->dynamic_instance_count == 0)) {
+		mutex_unlock(&mc_restool->mutex);
+		return -EINVAL;
+	}
+
+	if (filep->private_data == root_mc_device->mc_io) {
+		mc_restool->local_instance_in_use = false;
+	} else {
+		fsl_mc_portal_free(mc_io);
+		kfree(mc_io);
+		mc_restool->dynamic_instance_count--;
+	}
+
+	filep->private_data = NULL;
+	mutex_unlock(&mc_restool->mutex);
+
+	return 0;
+}
+
+static long fsl_mc_restool_dev_ioctl(struct file *file,
+				     unsigned int cmd,
+				     unsigned long arg)
+{
+	int error;
+
+	switch (cmd) {
+	case RESTOOL_SEND_MC_COMMAND:
+		error = fsl_mc_restool_send_command(arg, file->private_data);
+		break;
+	default:
+		pr_err("%s: unexpected ioctl call number\n", __func__);
+		error = -EINVAL;
+	}
+
+	return error;
+}
+
+static const struct file_operations fsl_mc_restool_dev_fops = {
+	.owner = THIS_MODULE,
+	.open = fsl_mc_restool_dev_open,
+	.release = fsl_mc_restool_dev_release,
+	.unlocked_ioctl = fsl_mc_restool_dev_ioctl,
+};
+
+int fsl_mc_restool_create_device_file(struct fsl_mc_bus *mc_bus)
+{
+	struct fsl_mc_device *mc_dev = &mc_bus->mc_dev;
+	struct fsl_mc_restool *mc_restool = &mc_bus->restool_misc;
+	int error;
+
+	mc_restool = &mc_bus->restool_misc;
+	mc_restool->dev = MKDEV(fsl_mc_bus_major, 0);
+	cdev_init(&mc_restool->cdev, &fsl_mc_restool_dev_fops);
+
+	error = cdev_add(&mc_restool->cdev,
+			 mc_restool->dev,
+			 FSL_MC_BUS_MAX_MINORS);
+	if (error)
+		return error;
+
+	mc_restool->device = device_create(fsl_mc_bus_class,
+					   NULL,
+					   mc_restool->dev,
+					   NULL,
+					   "%s",
+					   dev_name(&mc_dev->dev));
+	if (IS_ERR(mc_restool->device)) {
+		error = PTR_ERR(mc_restool->device);
+		goto error_device_create;
+	}
+
+	mutex_init(&mc_restool->mutex);
+
+	return 0;
+
+error_device_create:
+	cdev_del(&mc_restool->cdev);
+
+	return error;
+}
+
+void fsl_mc_restool_remove_device_file(struct fsl_mc_bus *mc_bus)
+{
+	struct fsl_mc_restool *mc_restool = &mc_bus->restool_misc;
+
+	if (WARN_ON(mc_restool->local_instance_in_use))
+		return;
+
+	if (WARN_ON(mc_restool->dynamic_instance_count != 0))
+		return;
+
+	cdev_del(&mc_restool->cdev);
+}
diff --git a/include/uapi/linux/fsl_mc.h b/include/uapi/linux/fsl_mc.h
index 90892c4..bf31472 100644
--- a/include/uapi/linux/fsl_mc.h
+++ b/include/uapi/linux/fsl_mc.h
@@ -14,10 +14,18 @@
  * struct fsl_mc_command - Management Complex (MC) command structure
  * @header: MC command header
  * @params: MC command parameters
+ *
+ * Used by RESTOOL_SEND_MC_COMMAND
  */
 struct fsl_mc_command {
 	__u64 header;
 	__u64 params[MC_CMD_NUM_OF_PARAMS];
 };
 
+#define RESTOOL_IOCTL_TYPE	'R'
+#define RESTOOL_IOCTL_SEQ	0xE0
+
+#define RESTOOL_SEND_MC_COMMAND \
+	_IOWR(RESTOOL_IOCTL_TYPE, RESTOOL_IOCTL_SEQ, struct fsl_mc_command)
+
 #endif /* _UAPI_FSL_MC_H_ */
-- 
1.9.1
