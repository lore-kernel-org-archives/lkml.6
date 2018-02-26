Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeBZA3w (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 19:29:52 -0500
Received: from mail-co1nam03on0052.outbound.protection.outlook.com ([104.47.40.52]:11127
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751817AbeBZA3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 19:29:47 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.cooks@opengear.com;
From: Andrew Cooks <andrew.cooks@opengear.com>
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC),
        linux-kernel@vger.kernel.org (open list)
Cc: Andrew Cooks <acooks@rationali.st>, linux-acpi@vger.kernel.org,
        platypus-sw@opengear.com, "Tobin C . Harding" <me@tobin.cc>,
        Andrew Cooks <andrew.cooks@opengear.com>
Subject: [RESEND][PATCH v4 1/3] i2c: piix4: Fix port selection for AMD Family 16h Model 30h
Date: Mon, 26 Feb 2018 10:28:43 +1000
Message-Id: <be68c29f603153cf047cd893c6b9d6423073632d.1519601860.git.andrew.cooks@opengear.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1519601860.git.andrew.cooks@opengear.com>
References: <cover.1519601860.git.andrew.cooks@opengear.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: ME2PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:201:15::14) To DM5PR15MB1210.namprd15.prod.outlook.com
 (2603:10b6:3:b2::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 887a3fd9-aeb7-4ed7-1010-08d57cb00999
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1210;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1210;3:GsGcZ77ZCZd7avKXl1I0frqwzlemUa0zHsg6U4Inlwslc52iby+thz+EVCQg3FuTFS78g82TlwNn3DE/Ju32iZlkRftpiiChQhYVDfVZ0zSCqfvTvhiQYb9FJmvM1d00WDcNgpYm1i8sK9V6sek3hovq0R8zA9zEKCw8w0H7TKlit7KZSBjI9VXBctdBT0OEUW//g5BfflFS5zOFAKuHMIy3sSc3YS8qm9hmsi8PsxQ+22IeETTPjc4bpX5U0/QN;25:WdlSK6TGTZJuUCH+fU1GBcSTkMkmaVFaNIiu3GYh5zQ/VWvm7KQ2B3YPrNfmNfXiQi0Kvz1NxCPYnMIFvwze12pZEgVQloZmAPWlL5Im4AHr9r8oMJYuhIwaLPIU3ATQnmRPIW8/cBoFD+7/IswUh0VV1s+ZCRIjINj/nJX6WSM5awGsG3+Z1+XzpW6QfrHDDTGiJO+VDqfGTzRZtdAk/leLR385megmT+S49kJkk4oqSQFIkXBSIupIEMk77X/DJ8jrTsPmpjNjjHZoleEfdkNQWeiwa8CuvCtr5lDVvivULk4IEritAQPeV4PrGKI6BLYqZPth1k98Kr7FJcLn2g==;31:ud5Q0BMyWYzXw44QEcipT05CTLhimy10UrEaf90PqbxCGf3MxsIxTyMuJ1QUvAjXiiW12I51PJodR6GMuIEiAfjHUoixRBBJ+NMCIIUi1Qq8R2c8teMOnR8lk/01CltBrHVokDXATaeyK2wZI7T57gyDGLfMNHgBp1JYIWYyrlzk65Di/i/gOY0aC72PlTcOhoN1UJoFREF8X7orNUdP9iVyeq/vEYk0rb10HNqJ98M=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1210:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1210;20:U+8wqHwwojQk+iNxUlKuTx8oCz7zsQstqydTL0PH6im9I7K60mlHSAHA2XDtcOvjAq5TiVjS4mE8UB4tRcWooFHmco3syPnysguYC6dU1k02NKfyJCXG9Y+BJ0jEho4du4zn77wZ7KJP62aQZua1Tufr+7dbXMJSarEkiYKMYIw=;4:jKX18F9Wd6dPe6mnvucbNEthWA/mXXfwHLVQzZ2HyAwQ3dA3RHJ8ZWeutvJdvem8csxvMS+XUg1EGru9RVI6I/rS7vgprlF7DN2font663uXAZUrpf9w2h6ZXckO+b6jFsURDAugOIOKKvqm5McFUmjDuF4yNxrRapretQQUQALrP4Y40532xeYhNh0iCzxGXu6vsu7b0AJ0c4sbAU3XSfNuWMfPiGi6UqODyV+aiHYpSwhUjzinOsr9dD4sdO0y7IjH4ywVQyNfrBz8JXHXwg==
X-Microsoft-Antispam-PRVS: <DM5PR15MB12107983D2F0B81A4F7A4A20EEC10@DM5PR15MB1210.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR15MB1210;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1210;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39830400003)(39380400002)(366004)(199004)(189003)(66066001)(76176011)(52116002)(7696005)(1857600001)(97736004)(68736007)(54906003)(110136005)(118296001)(6486002)(51416003)(50466002)(48376002)(59450400001)(186003)(4326008)(16526019)(26005)(316002)(86362001)(575784001)(25786009)(386003)(107886003)(305945005)(16586007)(105586002)(3846002)(6116002)(478600001)(53936002)(5660300001)(36756003)(7736002)(2906002)(106356001)(8676002)(2950100002)(81166006)(8936002)(50226002)(47776003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR15MB1210;H:andrewc.bne.opengear.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1210;23:DNev7ZEgXPdUhbvGbkkT1uZwCkZGcehvgHaiY9//R?=
 =?us-ascii?Q?w4fqW+ko9pYFw0W3XGMceHgF7Nts0dbiXjpp7XeQ9J6tzF/RkJVFA8qZoUEQ?=
 =?us-ascii?Q?/0xgOcvT7PlouhVXX2Vzozj2S+9evcIWXFPdFasip72Su1fH+RwhJBCYcu1N?=
 =?us-ascii?Q?nvjvEzkw+cWfNnnxUps3Y2WrHu54bxXXjre7f1MOUQ8mb5o+1icW8jbQ0JAJ?=
 =?us-ascii?Q?Kxh6QIgUkICwGn7scQ4m+CGD+zMcvNJa897ZVsTZMW7ZyaQC5f2vbAOFtBEC?=
 =?us-ascii?Q?ozY3yTSnOsGWmxjTrWgb8V8AlS6RSj9sbL4WX1no+mRgDhiiAtk9XEhi8O/Y?=
 =?us-ascii?Q?swwZpq28+cDXffHsHS2D3CQYVXyBTlX804kHI4dgjW2mF3PqZ/M2padf9Ph4?=
 =?us-ascii?Q?WATM+5U+Q2k7mbtXR9PclQA1Oe2hNqo/0O9t470KThGv7zREzl6aDZL6fg9y?=
 =?us-ascii?Q?TVqKibyPaEHn6JQQz7u8RvtFP8HQqSWePQak7t9cxirnugIXDQBgQnL/VQLi?=
 =?us-ascii?Q?spuoMqnB2TmPb+A5hPYKSnmU0vjn1Ewh+Ptn/yMO8n578wNbzv17F+IS4Mnc?=
 =?us-ascii?Q?OHe/bofCiucV5FVWsSsF5g26A9dNGPsAv+I78ShZsIFd34VU+1g0wkAl0PQT?=
 =?us-ascii?Q?yXseOB26E044P1mbQpzYc3QxDmlcTLoxNWbJVwPxN6JZwREGQ9PVy4ssf3Tf?=
 =?us-ascii?Q?/TkF7QZaXXaym/zV/BVVmNOjGwwaRXhhUZAi6j4VOMphoNzbDKNqDdu0Z0Lv?=
 =?us-ascii?Q?LCv2DfvS6ynNq7qxxRDipvdVNiQ5w8GU+jWelB72gry6zTjSsU1Wb3OM5mjL?=
 =?us-ascii?Q?n1/6cjrAnXO0BimVadAikZJ3hwzIClV9BbSl5YYr9HoEsH0VYEBKtPynfEAD?=
 =?us-ascii?Q?Welm7y6voq5x3FZ7SCmT65/oHVn4UjFX24sTbyb7T+utWMbd5iujFJ0Ls0x2?=
 =?us-ascii?Q?IopKU8a1H71m3QMHTVJMYk7AZcuVM9JqqLp0xZcQZeCVf8ISuHDCU67tRJDU?=
 =?us-ascii?Q?ZkAGPeHX5n47PYHX/dlnbtVsJTQmqBwEZAwSb5TwVxhpYgJAbjuayG+vLQne?=
 =?us-ascii?Q?xuEnd+5UjTROgLpzvZxIO3VyfrooBv2FzHCfHq1w48VKl6urUF4YVo1xehoY?=
 =?us-ascii?Q?2+qiwZ2Su3sgSoKaSA6AfQ1+IPk7mzhQsDdH69HF9TYLekhf6Y5RXb5ucMDx?=
 =?us-ascii?Q?juMLIGWs/+f2P98UkD9Rvj8yK/r/j0CLCx3?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1210;6:cXG+LMJ1aQa/ELir4Q7ERYRB2Gf1hIXi5NUF3T+JR68pr09WQTi1kHkTpxkgfyBR02gIv1eRLfj4310qd21WSNk3I4IaEwavndHOe+BC/qr38c4v707VfDJ7lbSdTCpvMhMxmhf9snFxNN295wnH9cKYRvA0++QEqZ4g/Fui28i2mcp0du0KY5S3w4Waq3CrCPPaogKe5UjIXZ1nHyT3q/6xTvaU4qxxElnhx/eRVV2ceUS5JgHXWfS79Ygzpy+YZXMd3V57Ho4kerQkl90f0JzDchH8jBD238uGHdwC/w/QLVMwJSwX+yaNvSoDnJNYD1JmWvHMwFGngIyQ9genHcUEU7KaIQBqxMeaCs2V5oI=;5:JJeuTf/j23WHZedbhlCWrPne7pST7kD8GCaoeJXoO3l4cfth5kP5q1lLZCiYPWtUek10Tzp0d7NarbBd4pNiCocOiVfzrLeSNoWih+w05+KcvXPgQ3FPVjmINNHyvEdBro5dy1zCzzTJLfPfmgMZ3jAsQP9HkB+b/y3D65P3Xl8=;24:VPZGmfJO+1O9ngi3LPkfdXN48ZSWrTr/NAmSK9BC4hM6lTbBEk7krTmmUPs6HLfjOk4fra5NoLFhwC1gF+vfIWLCc1ZALfxH87BzyyH36dE=;7:UvLXOaGcUmozYa/gPItPcwhIQ4ZxW+nz1xNu9vPFBV1RKZByqg+8FLVCdScN/ThIX4zKzPjEr6hrkTeSuXWAOFAzHS2K6wofEBRj14ThqaPJ5zfBQbR2PirLzIo4VD0oUzXApdQ2qFl0rhk7O2ZtkYOwCBT6Thd9hqF9oG6aYot6LxSR3Yvmz/9jQOKX8KnWnYRr70J4qWLji4qehIaI66VC9VWG4a0sCr75UFL//PcnuYkdAfubLg6kyUm1TDlq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 00:29:42.7720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 887a3fd9-aeb7-4ed7-1010-08d57cb00999
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Family 16h Model 30h SMBus controller needs the same port selection fix
as described and fixed in commit 0fe16195f891 ("i2c: piix4: Fix SMBus port
selection for AMD Family 17h chips")

commit 6befa3fde65f ("i2c: piix4: Support alternative port selection
register") also fixed the port selection for Hudson2, but unfortunately
this is not the exact same device and the AMD naming and PCI Device IDs
aren't particularly helpful here.

The SMBus port selection register is common to the following Families
and models, as documented in AMD's publicly available BIOS and Kernel
Developer Guides:

 50742 - Family 15h Model 60h-6Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
 55072 - Family 15h Model 70h-7Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
 52740 - Family 16h Model 30h-3Fh (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS)

The Hudson2 PCI Device ID (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) is shared
between Bolton FCH and Family 16h Model 30h, but the location of the
SmBus0Sel port selection bits are different:

 51192 - Bolton Register Reference Guide

We distinguish between Bolton and Family 16h Model 30h using the PCI
Revision ID:

  Bolton is device 0x780b, revision 0x15
  Family 16h Model 30h is device 0x780b, revision 0x1F
  Family 15h Model 60h and 70h are both device 0x790b, revision 0x4A.

The following additional public AMD BKDG documents were checked and do
not share the same port selection register:

 42301 - Family 15h Model 00h-0Fh doesn't mention any
 42300 - Family 15h Model 10h-1Fh doesn't mention any
 49125 - Family 15h Model 30h-3Fh doesn't mention any

 48751 - Family 16h Model 00h-0Fh uses the previously supported
         index register SB800_PIIX4_PORT_IDX_ALT at 0x2e

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
---
 drivers/i2c/busses/i2c-piix4.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 174579d..5c90a44 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -99,7 +99,7 @@
 #define SB800_PIIX4_PORT_IDX_MASK	0x06
 #define SB800_PIIX4_PORT_IDX_SHIFT	1
 
-/* On kerncz, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
+/* On kerncz and Hudson2, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
 #define SB800_PIIX4_PORT_IDX_KERNCZ		0x02
 #define SB800_PIIX4_PORT_IDX_MASK_KERNCZ	0x18
 #define SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ	3
@@ -359,18 +359,16 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 
 	/* Find which register is used for port selection */
 	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
-		switch (PIIX4_dev->device) {
-		case PCI_DEVICE_ID_AMD_KERNCZ_SMBUS:
+		if ((PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) ||
+		    (PIIX4_dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
+			   PIIX4_dev->revision >= 0x1F)) {
 			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_KERNCZ;
 			piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK_KERNCZ;
 			piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ;
-			break;
-		case PCI_DEVICE_ID_AMD_HUDSON2_SMBUS:
-		default:
+		} else {
 			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_ALT;
 			piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK;
 			piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT;
-			break;
 		}
 	} else {
 		mutex_lock(&piix4_mutex_sb800);
-- 
2.7.4
