Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELsVJe0ypWR4s2DUdwgkGn97VtOUDr6ZFlGgkK/NLyiH9aCu7s8SNWoxP/xnLBqU9fpCjrRQ
ARC-Seal: i=1; a=rsa-sha256; t=1521133576; cv=none;
        d=google.com; s=arc-20160816;
        b=AesNVfNFM/ZOCkkKolwLOjZ9urgNMpqKlBNsEmoEwhoz+sloiA4LD8Dbqu9iggANwl
         SY71nlIZYCKJInQf+wO1rp+jBaZPR0QPeDj+KAp5sN6aorWV6L/AsD1xTNJijumX+o4R
         UZSLPLxNdFTC4XQMoocN2AW6NKZcUmL0OplBYDWJNS7aeSj/FSAXBJsSeRGW30ASyMlw
         dZyin92ChhBffXXoCbHj+MBDI26X2uGSef7LNQSjoNz+acgZbCSQf3OP4OvM/lUfbR85
         e0dHzQNE8PZYaAZsvyLy26BRGX7YfwZS8Hn9UZ1c52e4xiNNGuhdppfOdVDNysNe/6ZF
         khlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=QAosbfLbod+jrSMcsNBDcNHNANBsW0lV/UXQZkZR5/g=;
        b=vGp15udZCj9PEZ2Kzo9z1EmE/NMjeTFxv0b/HXgKC9y2GVQe1jAVqlC4hiG1armrqZ
         YyxnbfKH0dr0EKX8IJ5ck/J/dq3Yc+30j3naiUDhubx8rKo1I4OzuznTD9sDeR/A5q/S
         HgirqOx2+Bl6zibaPfNM5w8k4jcgDh2Dl+TVtMvdIkOBeiKZpOAtYIL6GdjxdjopqeGt
         GhE1Je16WK9e1nzm56+8tjua/VAxH16zREDRF3p+TUmCuMA/XTa5IWepbNmUcnp78ieS
         YslIGMSnYYYTAlNAUi+OPe2k+w8NgljaOEgnCe+n6f87UjjwBXsdl3Jtho1zg9dQE6lS
         h31w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=lQmyCeaA;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.83 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=lQmyCeaA;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.83 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
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
Subject: [PATCH v2 3/6] bus: fsl-mc: add fsl_mc_allocator cleanup function
Date: Thu, 15 Mar 2018 12:05:33 -0500
Message-Id: <b26e9bd806eb3c1e12fe6aad9199571ad2a39a3c.1521132659.git.ioana.ciornei@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b3444828-71b1-431c-8b74-08d58a970f02
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3206;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;3:H9GlM/jkKeVTcFM2W7+AgTUVCFXtFEQJr2q1JPN5Po1Hu2LKP3jYiA9JTOmDYs2HfWlg4QI0hcFYsK2eLwsvHhRmf7bSQgTDDVv5bSfjoJW5jGbrk9tYGRpVik+DYC0m96qnY974MY50oVY8/MZwrfNYwUYBATfEoYvhVEzsjx/9zII4CTDJehTHKtACTDjK84FFzh+QknyYr7QWImIe+nN2RO6TKYbsc35acH6HR6MAbgiWoxh5SniocpumKyHe;25:nKj4MmrPuzvfLl73wyGC9YQHJeBvyUJw8PPysEmLuN3IB+941d+O0++vpGGWq05L0Y6lOBWOyvMqjSjC2NjGGW2egFEDX87AGMtO1Ypvsu/bvj4lpcZGHALf9a+m+YgL9VnyajdlQS3bFY/WzM36bup0qd+vLCedRkUFG5uLFIitvCklFzBp0VG52m8wlj/r413aDLG/66E1I3GEqUm3sLxkJgudFrXOzrb4srNskHyNTZhoLEVBXLYhklSJ9MjlLLoEYBFcWioAGFrn5WthnVLoVKH4LZlelf0wVJlQiTmRv3sk+1B//yuAd1POPSUeSkobBJHTalxWFplzl5pViA==;31:rSmWydo5MtBywinGOLkBGeFtguVljt4Qvz0tm10B1f0iWS4P7krhgPMbLKwOzMQR2Q6dUs1jmavvVkOPfQYos7WcTvgyba7kGk+ZBYMpNC3tHBxwUwGAKao5izxwp7cmiBVFMVkhf8RY/lXjPbtDv+sx8nkNeXp4cl4kzYMcDrmS4OhlKeCJ2TSqrNN+IrEjJto3M97IiOxnMT3gEy4JRjTo8jz/VJVSOq9SCb1R9lE=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3206:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;20:UW8JocithfhcF9ia1hx3ffrIjaIoHZbpm6EcdjMpkaBMUTW056y/ZkKdVFWDN/UVjj+0chjjZrrFo2HqwiSJIUVnbrGvAzIUrUsu+qb/+3yAYlP2O4ywcCjGb9v54OAQ0+HXkCVGNbJUlwpwtuRcJnT4uzWQmKNv5RZIugDz9BGbZvgBdEZBBcEPqUuJcScPK9NxIr/i2tZgi6ASPy11Vy9cg2a4IfjkbfNdWGbzYbg1rnaiyXuB/GEtv5LWPrXYXR5X1EbKAFSF0YM1fy5ac3twYDnSFW6YHUuXU0dBljLRF0XA+0HPhcbvK7WA0xken72lqE783xmOsijFUxItnXwyHFAwEKxYgcIBJWpUmDP3W+vomNsPYit3dvEp2DSnhfdcTxZ5GFiT57rYPY0JNWsJSP41jmS2oRw57n5svWPqLqCIFL33rYZAtyKtoom6GJwQjMySkuaUvEd4+enGjGZzxh464fCERu+LUAtJGAciMJItAqoJt93HzZ6aEiWh;4:ia0LT576xkMmT4XOP+a750tCflAQomdL6eT3wUTjvBw7YAwXOue5YI0ja7obSeJJpEhehKgG32QsVeEEc/Lm6JRPNyO01qYjpC4VFooy6bdiWATTQ0iIfVo8sTvrDe7ZqDHlIKDWczqqpLL54mIN18iwphp+dbKt0E03QZFxDVOaS7mP10B5xCc3o0dL0JXJiQU2xRavq8MN/j7B77lcB1u5ysopFofg/DkzuWa76lzyDEkIl2JdR8AhYDOBZ2T+CBI8kA1h4wfUNLSRnnmvV/ycvcgCSfjDhJPnR5fvk42GnHr1wUPQYQEOt4GhLzF2
X-Microsoft-Antispam-PRVS: <DB6PR04MB320683C3A2093225838F5DF7E0D00@DB6PR04MB3206.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3206;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3206;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(346002)(366004)(39860400002)(189003)(199004)(7736002)(105586002)(81156014)(6486002)(50466002)(68736007)(3846002)(47776003)(66066001)(50226002)(6512007)(305945005)(6116002)(36756003)(118296001)(48376002)(8676002)(53936002)(8936002)(5660300001)(478600001)(186003)(97736004)(16526019)(316002)(86362001)(25786009)(106356001)(39060400002)(81166006)(6666003)(26005)(6636002)(4326008)(52116002)(386003)(2950100002)(51416003)(6506007)(76176011)(2906002)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3206;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3206;23:J6pW/00mV0y4e4HpfpEzDWU2C3+9KQKxTc7N9CR6O?=
 =?us-ascii?Q?qLCyk3Pbo2N7fytRGBurZBlSI7foI3Kz2xSNfcmujF1RM8A0hUZhodMHkNE4?=
 =?us-ascii?Q?KdGaBHzCt7VW3OZeqgRgkfYC8hErK5drsBPJZPgP1Wnq43auTUO5T63mFdoB?=
 =?us-ascii?Q?arOpVzKYBenI9PtxVIhR6wds3Vdnz1ASQCX/zZu9D4MouXU5hhnFXGHNX+lp?=
 =?us-ascii?Q?jhJpB7nEA8utPrsxNJ3NwAyoKAG4h8uYDdRKNG2E92pKjOl5rAtVZs8Be7Er?=
 =?us-ascii?Q?UccLC9AXDWTIH0iObvR9lbfWrXJXK/0oMeR0Pc454/aAWzO4wCw9AmLdB0+D?=
 =?us-ascii?Q?CWtDNf4QvAEu1gdpsfA2GgFkDx3tuWddJCfoeBHD4xT7PwzXLwWgCyXadzXp?=
 =?us-ascii?Q?BWh6eumklIrDKJzjpl3hSh9/n/eZlr9wC6+v/t8oEeDD0c6b9fEgz5b8QQo/?=
 =?us-ascii?Q?bNr6PZTHAjcZ/HHEyhfF7I3lCpzcBiadwae7q+65MAGgXFzdHO2cURPnmFa8?=
 =?us-ascii?Q?CmEDcwnAcH+0fqcFEi+Y7J8ZVdby+GT2XoM7Ns5Fkv7WTZ3aelELSw9AXRhN?=
 =?us-ascii?Q?T8g6bekRKJK4bkiVvF/aQNcK59qoktxqfIcIAmmtGyIFy363fYMMI5CrAJsW?=
 =?us-ascii?Q?aq7XUWHjS2+04toVleUQp79j3hUedBUOJ11lkWwtLgIk1UJFC2SBUh7qKyeZ?=
 =?us-ascii?Q?ciD1QEmdd0j9joq8gjIgmD/ZfiE+8jA0I6RTW2u6eK37QuJohxxMhi13Rh0+?=
 =?us-ascii?Q?Z7dznFP3Zt+BW/zs+e+pFN8a2rbmQzyLBDCmpHaOCgC1/6yzKnERH9jgSVDw?=
 =?us-ascii?Q?EI+aTai5szWR0Elxd8KOv7AIm4hH/HlCDk4FYu8BzfdNwdt0XqO/y6TqySi1?=
 =?us-ascii?Q?0IG+qON862N8w2cQ3oVXiW0ynwAc44BeRWr06rLNZ0gB77W0riH5hecc/eYx?=
 =?us-ascii?Q?2RxJOh/CgucE6d8JnJ3RJhUaLGnAwjtzU6hVKAFS1IYUoXm4iswRRtc0HkD/?=
 =?us-ascii?Q?H22XymY8KEFZNqkiUN3SI25E72SuR+ojAEq1Gie/a26W40iXUUKkzt+FM7qh?=
 =?us-ascii?Q?MSMXvdg9FKWV73okx+5Dzty0kC3fh4UOD3b5uxYdU68ALBMyisI2O8hiVYm/?=
 =?us-ascii?Q?h5jrnoci8B0glgzXQ/L1aiW3p6D/fH8?=
X-Microsoft-Antispam-Message-Info: BUEeilgiEGPMBQWQNMZOVtKR+4bDWTD2L38Cv5mHuRMG0InGFj8i6fmO7eNqEJqaVp9eb/+VH936PBaspCccrnIknmpElZHYPeXQW4iCLuz3eH16jpudXhDUF2MbKqPENNJsbc5TDd0FWto5LVaIKL20ZWxmlAhfxlCRcgZqJNMijcrYrBFRx5gw1d6F3Nr0
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;6:riFiAKM21vrOds0eUIaBe2ALTK8EInS8ZPEs4cE8nraexWnRg5f0Wzy33Rp3JxL4ChZ+t9dHI7Fs526Hfx4F8kT01YzhW6DaB3UG9ffkEuB0U4joJr0IfL9sruanWdZhlw/np+++CTBy/XhrQhZAfnVmX6SYIwsV3nBLB5gFoVkDxSEemjjvc3lOVlEKLtf6WG1qHzWkeYNbosl/tghLBfhpJCnmoIdN0uXQymPkeRkypp7RtbySrOr9HXg8IvZFvCJzOWTo+eIytHveU8Lmc5p+7n8tCeOiHOpesfrCo+yI24JeLFvRzu2X7grto+TnD+1FWWhuU16jNnHXetF/UYNqFMOdYvk7XX5ToLJba74=;5:ckPuHObGgiMxcBt1bbLwZu4lHJMkTX+Sg9G4UaHv3DcR0NoWZkymfNyHqkiCoF99fTawOtwzr1o/Fo4lrhT8qlWtgyRWbD31o8+hw4py7bUbDYVmJkwvw5Iz9YZNSn+ySyhnb1UaRTWQ1hqmy2FYBUELpp7W7hJXVoHVsA2Nfcg=;24:QTiVv24WAxFWe3P/2ngPt1F25X99DyPj0A/hawPNh/C58aAD7NhQEDprwIAZX5YRKtfJUTsDoD/JjRBUc2p19bAYR2lwuhEUNLAGsOre8uM=;7:2Vny7UA8vuBCKv77q2CHiXyCllL5gAL3fjaRVLgsqtHzwunitGqEyaSg3HoDVhhiSDeaUT3uxn1mL5RX2aB0MiIhMshMDgSdlFRTCJp2bzxC/+uyTys5myL7FXC4zuRSkDYwf8vRpFd+qCK86IOnbXWq+TM4i9tD0f/xCKWlW8/AxFkNTySm7rqyj7fAPnh3EEtDUnbxL9Mr/g0VQ/W7owXaeOdVStv0IZ67Dz3eShB6WzrMvO7T9LJSGS2z611R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 17:06:11.6343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3444828-71b1-431c-8b74-08d58a970f02
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3206
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595024160328290410?=
X-GMAIL-MSGID: =?utf-8?q?1595024160328290410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The userspace support for fsl-mc requires a fsl_mc_allocator
cleanup function. Add the needed function.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
  - added the patch itself

 drivers/bus/fsl-mc/fsl-mc-allocator.c | 5 +++++
 drivers/bus/fsl-mc/fsl-mc-private.h   | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index 452c5d7..fb1442b 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -646,3 +646,8 @@ int __init fsl_mc_allocator_driver_init(void)
 {
 	return fsl_mc_driver_register(&fsl_mc_allocator_driver);
 }
+
+void fsl_mc_allocator_driver_exit(void)
+{
+	fsl_mc_driver_unregister(&fsl_mc_allocator_driver);
+}
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 52c069d..ea11b4f 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -525,6 +525,8 @@ int __must_check fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 int __init fsl_mc_allocator_driver_init(void);
 
+void fsl_mc_allocator_driver_exit(void);
+
 void fsl_mc_init_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
 
 void fsl_mc_cleanup_all_resource_pools(struct fsl_mc_device *mc_bus_dev);
-- 
1.9.1
