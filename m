Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELvG6ecbm5iCFOpnojTStFDs42tdAH5tScRfs0Skdu6ip7dnDZq1wi1i5HSbv/RQMos/6eGc
ARC-Seal: i=1; a=rsa-sha256; t=1521819588; cv=none;
        d=google.com; s=arc-20160816;
        b=a+pyIeIkPNNDmCZJPhkHJVAJzviNVn3E91qWsGnCveEI4oFCxnZLMmzJnoXpy2EiRu
         YHlaxbmPzIJiewgYQL0nsyKd9LOAfGBnVL5m7zKNOsQ9mr65JEtubp0helf2WG6X5OCf
         jhzL8a2XYLS6D3Xx/gMAu722BxYIzat0PvHBXy41CLBxeplPXZiobH1h2z81KnhPdsIK
         xDhkS26mu2MVclPdpA7M2rrCaYBUV6YMtlAEC5h+Wz4T2ZyEhyCaIXCU0gkxGdDCHh4d
         ewUQFwHREqMe6u1zoC8LIRdB/8fqHDg/zSthTHbxSzlxgfQvYmTWkmK3lX6oGbCfetxU
         arUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=UxdX58C6Xo+/AvtBzCxnV+vl+E/vYMIHzbqlDWF3DIM=;
        b=Lna2uFnDbeXNoe5bKkaD+ihXudZRuHAV9Gr2oYTGR0aTvp9BD0p3+wkx3IbTzpiKW8
         x83dkTVWnIOAf8Rq/vif52jDVjNrlxgrLOHKcEcsXpmdNGhKdR2mySXmUgmLgjW5TirC
         Q+QOJtMfNrePz66o1qnjibDRjgteUZhST8v3gUd0ve4C1wWVopYjVxxjhSfZPvPj/vKz
         fHBw5YsNrugmBzajJjiJ7u9mBY+nAtfmPQXAzS1MvFs7anEluYI6n032J5YcxKNU/5fQ
         De49EvQD4nsyIadqTvsrMbUtfD+J9jV8+4G/1oIxrdxF2CQmIj00iH1iHHzrKxZL5Rt1
         NpqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=xSTBX3aN;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.42 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=xSTBX3aN;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.42 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: gregkh@linuxfoundation.org,
	laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org,
	stuyoder@gmail.com,
	ruxandra.radulescu@nxp.com,
	arnd@arndb.de,
	razvan.stefanescu@nxp.com,
	Roy.Pledge@nxp.com,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Date: Fri, 23 Mar 2018 10:38:56 -0500
Message-Id: <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <cover.1521818402.git.ioana.ciornei@nxp.com>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:300:ad::23) To VI1PR04MB3216.eurprd04.prod.outlook.com
 (2603:10a6:802:6::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 502f3b0e-3de9-435b-c731-08d590d44df6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3216;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;3:qHGyjmOUxyZBctvThmW/S5RK6JbclQe+bn6zZbyfdWHhGrWSUmsBiLujVijlv82rFCKXX9P7UTkwqwUf1uRuPA8SEIqyD2Iv7w7SPufP3qT9sXra0V4fkQ3c0sOLPsz5e2JV7jQlAFNi4PRJ3iPCXrNN04fA4lxT7fftd7swqWnkALWQpXw1OU4/j6h2R+VVqeQ/KUaERX4F4w6HyGLFUkFvuUXm74qOl6rcKRiSdcGmNn7RSIFlDmPpNiQTnDiy;25:dyEWdFjxrpJ2AUIPg11gwqinGhDLe5Or0vKhVHH9WAhKLEjdSta2xLjcMHlQTRQbVEjx4ltbDs0XdhtDzl68/xymGZVHLLFzFB5gEQV8H960J2trPJYfmwMgbp/rK3a8YdTQXa7X4W30Qc7VyDeLCeKsijdIATVHb1rmq9qI7ibeW5aDKbbQ+qw7xK7HUyNgy+Lp57EiG0tQ1TrJsW25imZF+vzilMGc/6rRpKskBxErtyn1WC/41F6TVKfI9QvKY4CuUOFIsapw8Qfz6Ia6RDFV09/wUXsBUxWf4TPouyd6vUc5DADMKZdGQiy/1uQIcz9TNKVpOEyfU965FVcoyw==;31:dW6o16VafqJEcC99YTTAwzH6UACGSynBL5kSy7rTCnx0eRIgKeKCdu2TptyhhE0Hd/olMOtCwS1uW+aYYs3+UsW26+wtFUHmG4KlmSm6JMcwMJioLvREQMVqNfQDzp8lxj//fOMJPujPds+OZg96wkYtrIaQPbH5tpfjCIa1tff6BOQrZf8nAdkvAnrhEglrnqNUD+4ZUOm+HKr1hCU7tViNIZrvnkFtdHJ1EQ/hRA0=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3216:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;20:rbiGpX4H0BcvHdixV0AiFC8GpEKg7keL/R05g4O+MH+heFuyYSsKcl74Ba429SzyABWBNCDm+ZvWKR8ui1C27h19KLWEO6SpUNFahvlCHQLyp2BHQbZzhqkf3k1JGjTFbEBd+w6Udv7zBN8bkTvk2G/G6oxPPXrnXC43uWN4mE9rTg4BfIcIk/Zz8YeN1+Z8PZ2jZa/rtgSMkKZK7bbbvsyeIRlLbZ/0NVaTwZ+fVqkpy6s6LNplvDqqcpitwqzi1G4gqSO9GttFOAOpFIqYV6aAFu4nx/NyqpODKDfqk78li58R1WMOaFJy/GMYKlU6WFDKsrfI6BwKITKWCMg5PcIvvo6bcZ6VK7POTV+2FVfH5T1UEPdsFGNYFJRYXA54xSY283Ei4R2E4jKrQLmKfe3WbTRYAUstMqALJq7G8MwW9swvQrhBHPdoC0YhVerL5Dfc2V+gJW/apmidppXq4hTH9t+rnpm7U7ofXzGBEXBGXslnzviA3VyyWbDXdVFV;4:pXFcrttHmRhqxxwz+BirMO66/MXWwKf2/z4tddUem+3hW54HE+oZTxYtXNxqmp6VqrMqA6XLfdq0j96Yke++BX6u5FOU7HbBRXRn6ks/X6L7uPpma85w8URJAyB5Z1zuI+piSWlVB1FGAUKE60A8uG7tA5LULI3Yf0NMWfBs4NhyOvpqwF9L01+QNL7UlbNlxZjU4v8dRYZLkMJVBbTFwozPGNaXHaHq3L/NeNHkKYGutaeCkTEbhZrkqzzE6LHJEjRjatB/n6xphvEFGAmG2O/mXnL74dtUA6zaPsosO6rgBq944p2nUwOI2Gn1MoPURfAMiW3ozAGFuR1Z4MTlWI2x8CT9Keo4+lMkUnLgVMsgOMu8WVptmjJTqYcTy8XDu6ifjBvSX7SLKAcVBffzoP7D7tI66yRpKbcCCIPBIWs=
X-Microsoft-Antispam-PRVS: <VI1PR04MB3216C8181AC6F05252F0F29BE0A80@VI1PR04MB3216.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(35073007944872)(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR04MB3216;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3216;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(39380400002)(366004)(199004)(189003)(6306002)(316002)(446003)(47776003)(66066001)(105586002)(59450400001)(5660300001)(16586007)(53936002)(6506007)(386003)(97736004)(86362001)(966005)(76176011)(305945005)(7736002)(6512007)(6486002)(3846002)(50226002)(81166006)(6116002)(16526019)(8936002)(50466002)(81156014)(478600001)(8676002)(6666003)(6636002)(118296001)(106356001)(39060400002)(48376002)(26005)(36756003)(25786009)(51416003)(68736007)(4326008)(52116002)(2906002)(11346002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3216;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3216;23:OI7MQY3W3wG+jNUmpqPtjg6nP2LMUpQAp8zKiVQQn?=
 =?us-ascii?Q?X8Gsv7XMovqL/x5zJCmBW564c2NNVV17jait1qBYScEU7wnadKpqvvQhsGyf?=
 =?us-ascii?Q?73/JlE2qLw8iCc0W4BSzUMUIvsbzyLXLy7H/OW6I8CeXMOYDs3SK4OnvI2+d?=
 =?us-ascii?Q?JEsI+4X/3TJuezTpx6Bv2O5zNkoucnjFPlUV5R8Xv6wZ2XB11BnaHsATyLXC?=
 =?us-ascii?Q?MRKWNv7J2dsjB80aVWLWlDtv0tSaeiAvxyPa9QNW4ZQOy0y7QvM3iUCfMydL?=
 =?us-ascii?Q?H5YZkTjlXxBZ4sLe2D3R0UoxATzFq6g4Kk4gJxC/6xOD3gKYzY42v6hywLS2?=
 =?us-ascii?Q?5F7D7laHAvpGHSM/yGxJpE6ljkfBepvpH+J5a2uO+xqFJzw+FJ0IN3Z9/Ldv?=
 =?us-ascii?Q?QPXdKt7yiqx2aSEBXTIjAIizfXVD3u4B+L1CMJeiBixkSFTI5eEs/7bpfx14?=
 =?us-ascii?Q?fYTHmPveMmagYI0VmT9rLU8RHoe354aYyY67KhlZzegMh4NWA10a1eeG/1wL?=
 =?us-ascii?Q?YAnN53SD8eNVRQngmOM8BD/lr4ajEV4pztvjdIvAf6WLbxfRxLabxAD235tN?=
 =?us-ascii?Q?aEJ+NPaySQiiVkaMqJCZIwraYBpJtU7NCKAvUW4uMmYYWRnOsnNYC73czmQ6?=
 =?us-ascii?Q?1ZG/K72R44zI4NlnVXXFfdCatIW8iKOpP+LjAzGAQ1eowqq22wm84q7mQQh6?=
 =?us-ascii?Q?+VKY2DPG/9/GRTT/6mq4Vr4PQ1Yb2ChTo884vQXvrKVD/ML7GG/VMc5xaO8a?=
 =?us-ascii?Q?DxRTu9KgHfo4XSZ0AVjXhUxGALv+M6uxZHvZoEWiS4nWiZi+D5ttm2vz7LBq?=
 =?us-ascii?Q?Q/oAp8sjeQZSpkugLBWQkGx3DOxAtbwIoiJDWWhpWbMys6CNQRyq7m8jJLT7?=
 =?us-ascii?Q?xtT70QGd3n+HMBFB8YYuWzV2kV3wrsXwcZECzKMrXBCLKofsFaaomtfopkC9?=
 =?us-ascii?Q?HMS8UVv0ru7V3ehiEAprGZ8P+F5pBkgBDQYiqLX3fE/dBQDEt7zFRqlVCRfJ?=
 =?us-ascii?Q?94+r9I3KceQG8XrnpqdzgC7fQy6PFeBrNmWLv4JZBG47rg641eB4jbWaKfoD?=
 =?us-ascii?Q?5Suw0wVh6IiXb3jskbY+eO4pweQ8Qn6t9wXpcofqZIxRfZPXo82ron+4H4+l?=
 =?us-ascii?Q?Rd+qY5m3reMnsno3v+1W+ROQwQrf7DlwJJxGlNOzvtfCdZL1oyuXcCrKJA0h?=
 =?us-ascii?Q?+75gNj7NFCjEv5eWRMZXFdp7uiCuInygxH0xkIC69PR/upyMuChjzSLyg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: NvsY3kEPhpZcURjyD2+nxEjPRpntS9u+C3wSJoipmtBpvUVwIyhos/rMghJ55PetWrIAOk761LCR/Sy4BDWQQ1oaRucDi/X9FaPJSyAeZRc+5DrMjv7RUOKKfhDVSibC67XOTR/JfEjTdjAk4QRPSkuvJ5BDqPOYiT7btSIT7+kb3DxKELvav9XSSuBZL+MM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;6:M/pxptY9ukF71kj6fCWCjCVCkFtLVJ1lOG5ReEjQ9dumFH8kN+/cmb7w7A18vCg90GALTC8fryzU4FQojuXNk5ZNby2JzcgmG8nm85o7Tfi3c+Ela3GXj7MKFAx9mxey1suqmbLXlDvKf53Cz5M8Ou8EXWHRXpinUJZTVgnuS0iQCtyWe8vki3snvzoA/LUhUMGv6h4v9aAE/Eo7KwzHvVRhJY13QANbdcfYrCcCtLhYP2r/F0ST+aattGPGYVYybJzLYX4t1yWrU2zpsOVUU6SWbfHAJGeD7ONCr7BcITxCrt6ACpxBM0BT+K384u2sjGyqnFib5DICRwwqq+M4DpPvNOsa2uB0H6G0MLo/4Bo=;5:ABhmTZMpO39krk7OnGxSEa0O9YGEuS73+Ce0fV4GkAbnsE2+ycKKof3Ak0bZ9SfsqB+QzE3t7wsuBkuNtrQhGsl8kiDtL9w7jcUVUSssqhhW8s0nShSVqy6zEtztPfplvNDzHYC+0eOp3mwAwjIQ7mMVoPyeOHVhklJLTOXm9Es=;24:RkmxoqEAAXk3vxXuS7YX2n9NkHWfTbtxwxlRSdDk0pZrasNlvxsslzqwqBFMY7XgHGJalHwGlG00/5Uy39q3bIjhNLDNTv5vJJ+zAedxcCE=;7:HFXAjuqylUPMA6KUI5QlzzZuf4ZQYp0OC2wlGdSBC7vsnh8miJPpEcc9TR3E5ExvL2LWLh+YB8ULm5+IjA7NBzCEJp9PoQKRt6DsY5vWDdJHrYl1uKq13gnAY85o40+jozisyqc6DQLzR9S++O32f/WrtDiab97FB+gmKq+gCFfzxJXZ9t7JoEs63QH4k2FF2RW9GHPVr2/C+q/gZwy2dL2XXeXbx8+Y7B4xWLpPvmgCU0RKLFXnKuPlzcrNoZwm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:39:43.2028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 502f3b0e-3de9-435b-c731-08d590d44df6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3216
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1595743497041548891?=
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
Changes in v3:
  - no change

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
index 54590a2..e4c8dd0 100644
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
