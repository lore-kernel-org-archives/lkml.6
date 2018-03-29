Return-Path: <peng.fan@nxp.com>
X-Google-Smtp-Source: AIpwx4/fFmSsa0mDa5+P2OSkWkTN7QWOseTbXhTiR5VPKe2doKbGli60qm8K7n33yTKFkHvl01At
ARC-Seal: i=1; a=rsa-sha256; t=1522325967; cv=none;
        d=google.com; s=arc-20160816;
        b=LDX88CkgTvRcyaJP5r23ryxM2yTAQwvTtZr0UHXC+wbfbCDv9Sd90VqNWqeec8kKJo
         6e8UFIIf6bAG2ISsGs9vOeX6YfBrwvHoJy6W9j6K7Oebawwum2QlpE2lv/pw5cuoFDBJ
         3wxF3RMdcIyjyJQFFocst0+yxhMMe7WUzygjRYdzaO1Iq0yG0cAY2q4UbyBbPKI7Di2b
         I/JgceBTFBJYNnHnFG3RnqG81x022cWnoNoBlwutDqi6kDEWxI1HKJHNq/0yZ8u34aFf
         TWYJnY+6rh2WJuieC3jzYs6/AWIqD2u1FMEIgPZDyC8BcfIQsCyfuSqGr2S7Jgx9MBNK
         aZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0K1QPOPzjDvWGRHyEKujFUoPwBq16m1fajA8KiHMOdQ=;
        b=gorXLM1BQHbME3Z8yvtglvCUJdDWg28Fyqz5tKNj6mgBAzfHCyeMJeptEED3GwLJaG
         s01Qb3M4RdsjR0cW4IzXiu1eyrhw9m34rLRH6qTnofqGtByXxhD2SwroIcgP3KlRg1YR
         YT0D9PHyZfi7tm09lvwmpLHlUVIyKhwaUgDCY8V8tmTnQ04ggrJK+pqkBodgSP7eHxbS
         GwaJZtlUcNWpC72MX0Wdtf+bVx2TwM+RWT3VNnrnz4Ll/p8ccpWvPsx/m98Qby1saCz7
         zjzoEdYfouLvjEKQd9RvlXj5GQsZOaJZXYVJ7ttafESB8H3RJ8EkGTlzDTGb2K73CLhb
         +Vdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=CKOKZ+t9;
       spf=pass (google.com: domain of peng.fan@nxp.com designates 104.47.0.44 as permitted sender) smtp.mailfrom=peng.fan@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=CKOKZ+t9;
       spf=pass (google.com: domain of peng.fan@nxp.com designates 104.47.0.44 as permitted sender) smtp.mailfrom=peng.fan@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com;
From: Peng Fan <peng.fan@nxp.com>
To: broonie@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-imx@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: debugfs: check pointer before access
Date: Thu, 29 Mar 2018 20:21:54 +0800
Message-Id: <20180329122154.25291-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [92.121.68.129]
X-ClientProxiedBy: HK0P153CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::35) To AM5PR04MB3219.eurprd04.prod.outlook.com
 (2603:10a6:206:7::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 890f02b6-02a6-4b17-9c51-08d5956f4e47
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3219;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;3:Saw5aORkBjleLq66MEFqQvsESOFlgD9LBGayCuaPsvzPE8I1oEDQ/ABVCVHXjAbhJKSm3w5qtp8YufePwTnFeUyredS3coTZW0e8vxZ+/68nF114RXVT74lGvaz4E9UV9rICW37DSNoN/2jxGeN7tvMRqHbO8v+D5OwiF7TUvmM2P/mOcjwdDbUvOxvNauBqj+qy7LPyYDNQmyx7X2gR1/1CMOOFAw3r0FY6IzlWKfQZYJdZAb4OfNB0XXIShBDv;25:5ZgU7JNlCVUsOY+wQv5mRtAWmQVszmJ+uwwBPPsYMo2euC+SQv0x62G6I6Mc0ZKlmL+0GnmbWep9vs2mpuEaI5vF6kBorPQ++UN0rPN0GI5LM350bt2yeFtWmhYfs1czqWuOgBeOEFFkUKurg+Vr++fzd3r9FtAOvKM/K3doqvee+QMUzV4ExNTZw6ITbKkplmUtdQLe/bHQ+jGiTT6PKp4Ni+9QvmcuEHTR5nHMhZOnD33xFfwpc7I6NPYK4t251CBE/WzCFiZCZQoyZNR54qiFVKkJdGe56hZ44Kyj3kaDiWf9K7fXw8CBNe7s53a1mbbHisDEUI+d9i9NVav/Hw==;31:nSpvaLqf9sfi6YyQ7SZL7AK352AwCQdCg/tLrlqLO0Hu1QybQzKEUHYT6AHfAGlNvUQlXfltQVrBLEqPRvOrk80dNJcUt5HDkg0ajVs4pKkfrbua68r4NQae9f/XE3q7twVrZXWEoA39NzYmugug2ywBYjUE776vllfOXYqMPCyTJca4IzQAKAbWPk1Oqyw06xW7PyoDrFXfYVVF5Btv9IHQ2o7SsRcqVHhYjiQx0YY=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3219:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;20:5aeq0McArm49h1orkj5RQPuPVQhlArsYTuVjBL4nDtsqNnLGrChz+Dx/v7VjlvTLrAa+rBILTb9jYh1RMcZk2kNXkuLqYHMWE9avEQK5nMd5F6bJWlt6DQpUEPANFV8Ycp+0gSaKb9RRBQsFstUzgVUcfVifYyJD4RPVEqnS/AbuHYYnvcyPCXr5+cTTpkZewjcBL9xP78URqV5V5dVbGBTWD/8wWreK8ftMnRhTBoQfBN2j36I/1CFTSWxhd0GDaag4UQmP1+He+toTrgTY3dkvi8SwifQbDloOx+ix6Yhm9dN9jCSNPIgjoOBKv0RcbV/AXvvFEPDBS+sX4e20z/numIS/1zy+eOPX97yc0HNPEVJf/2MNmKvX/l097SeFNTVgdw9hTP+72zlzoyFfXXwMFYpT9GelGtk6ODzSb8tUX9ozNA+e1FVTh7LARbzvmBm9W79hnqmcLuK4KFZFEU7E1uBi38kXKwjM+A91WIkjkjysfTT/mDcMiSYya3se;4:FRNmP0xU1InNtwjSw4LBRCpnyl/M+83rUNsJNIG0tLScTnOh0oK2q93kYrmSbdJ2jHzIYsAcfzH+D+gP/+auwIStzCYnusFzfgrc0NJLWQZSTQiPW591QE3Mrsk9KdD4NrYpfeO3Auc/TtqcXyJ4KNaifpAiUiY72ytMg1p8jYTnfKf255Y3QbVLduBZn8NrHjjGOUb7ey6xUrDKdAT6RhJhKTlIihdtCbUHr58tbmGDaCnIn4Wy+kLguYNSm4E0UTzfiszoEqcermeW+kEAr+dvNUf/7gNKDVzTpjW0LGwE+zdZegVjqPFW2Eq+IWiYcvEZ6pCp4AhLfI4yWaIh6cPBiCh4t5TLVpjmDAlqWoM=
X-Microsoft-Antispam-PRVS: <AM5PR04MB32197BE74F9F2ADF3730029988A20@AM5PR04MB3219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR04MB3219;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3219;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(189003)(199004)(106356001)(1076002)(478600001)(105586002)(66066001)(47776003)(26005)(48376002)(25786009)(6486002)(1857600001)(97736004)(186003)(16526019)(4326008)(3846002)(6116002)(50466002)(5660300001)(68736007)(305945005)(2906002)(36756003)(45080400002)(6666003)(50226002)(8676002)(486005)(6512007)(53936002)(81166006)(81156014)(6506007)(386003)(316002)(7736002)(86362001)(476003)(956004)(16586007)(486005)(52116002)(2616005)(51416003)(8936002)(59450400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3219;H:linux-u7w5.ap.freescale.net.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3219;23:lorCbBbdEUq6L/mP5sLELjFCW4hW0nMyCAhg9XfwV?=
 =?us-ascii?Q?P9e52RSRF5mlgetiLM4r6PwsAweQv4qpX9/i8dq6HVcnfy5gN5I/a/rUhu8c?=
 =?us-ascii?Q?yqBb/vxOg+cqFE9/JF2CrIZMVlSdK1BV17s5CB4tleHZxdUp86yys8tNs0EH?=
 =?us-ascii?Q?STqzluOFLaie0w1PlERtESs+LAf9t2ZxEKcd3bSQguvAMOlSPWBhn1CzXp51?=
 =?us-ascii?Q?ni1+lQ77JEoxGTbWGLKkMmPYeLLNhhrO6BzN1fKzbd7zQEasnM5+ot1J2h7P?=
 =?us-ascii?Q?xU1xAKjWffpiBB8KH5H5GX7wR0pbaExHg6tCoOle6kg+W/+TBKoL7ZGcjZsY?=
 =?us-ascii?Q?gNL6pgYAk5k6+tuSrdcxQmp2+uHY503XD+YHR94q3y1d5XNt4TbuDwCr3q9J?=
 =?us-ascii?Q?q8BaFR1OUjAnKAFAnMig8t/D1zPON6t07ymA3ESXGhkGI9UFjm5e+GOJq13z?=
 =?us-ascii?Q?HUga5Y6ZwiKljV/YAzNYtBVX49pVfN0k0Czp0ghSDar3lc8j6M4t6YPdv3Nu?=
 =?us-ascii?Q?V2o9YPNtwlmij9D0dYmgQNi6CYfL+0OAurIbD7If8ML2AekqNuA77o7/6FUm?=
 =?us-ascii?Q?SInFGl9DRyWz6a07ArdxlIn7BmesD1OLpPI4hBNPwiCIoh7Dtd9VrAr4FOAb?=
 =?us-ascii?Q?e9NMNlbnTQ7Zk4VtZ4r+sAYLJUJR1jUVnC80cYL1a7w741wQMPUCk60yv31C?=
 =?us-ascii?Q?DFISfxkMvkDEkGcrfcUEq70mDHRBHKdvbITFzj7u26EAi//7Ex6zSTKP5kQI?=
 =?us-ascii?Q?HrO/14Fnod421zdDK2Q6vq8Eg9ILEA5/ejTqGB+5RwF2paUawTlFyTBRCB+T?=
 =?us-ascii?Q?hvh8wdrp4TLrcjPEBplyvm6glspD0nyLzz57q085v/rCxZXLhgH5albZdo1d?=
 =?us-ascii?Q?Qg/waXYWxO8SpImGxnzzElO3QxxBORgFMOdJZaDDUI5qa5oeJZwu7moj22JM?=
 =?us-ascii?Q?jRXMyfKf1EfxK2Q6zOj1UQwu1A1wPwqrrFhaTm5cfaSgGK4R1E7/hADcXltC?=
 =?us-ascii?Q?vn7oHDOUhLgx2t+QTLexena7wMZbxTeH2jVzwJS4TIhrEYk0G+YbhTTqbLqO?=
 =?us-ascii?Q?09LyXq17/4JvX7fRMobvMTDqFIq0RoLsXPRokcUA53RpkRriCDBokUrWhZfw?=
 =?us-ascii?Q?dPLnSt6dtlAf/tWXqquhfZKC4uX8P2XHAr0tjl87Ftuyc9arZSzrKIYxKFE0?=
 =?us-ascii?Q?B185Knxt3Gh34vhrlVJMG54HadUm8DbAnfI?=
X-Microsoft-Antispam-Message-Info: BqCHeJ3MDU/J1UE2BF9edaIabP9z62uwY6lYFFeDo7BKeVO1FnRXJ74RsKH49TjHuVe94rENz7y991sPY5gc+Z0xhPinir9/an519RlW7GcZ+j90DnyvMOX9WLkBIE8AFWBuio7F6/V2MEfICCZDLjqokNkwppeSwucDWKWimwTUndBN2LUSQaIisOZqURDC
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;6:YWsIdgy3opnrLstpzdS3G0i6cpjMCc2YSVBKrI2EK7s8VOHCXdddhPvjEmnsLbAnrxivf7SvKvA5zLQdjovBoC0PAaNQWPRMiKo7ENI5V+RXdLQQXiFdtm1Miig70RRflhI2KCuWKDlINtc8yJrTnpanXzeLbmQAwGUuwqcYPAkRrqxLCHoJhi1QKQdtegLA0dwFVRo8E2OidrPIs1aDPNlapvxB93wRyqb4/ZfKgiNSSKcE4mnVCi1b6x0lhqi3t1GbLsKe580WhOIc/SIpAe4/1ptNT0+rlDZJfrD7jQAl+g9Ee94IrMi/cNZ3k8XHfz2giQ9e/k6BrijOnuyBkPbsZgiKKoL4gSCi4XwqyTmWdhnLczqkS7ExbdzjsHYPyyATEnIhyGGIqsCYzrlIDvNXWSoTK9f0Wb7OFA0BUakF4BBq+3bG85cp6hJxCH0Y7wwUHn5e31SsiLuMNKRvsg==;5:jHFjtvPBRgtu2bnoFy3mKj5IcvwAqWJSyfLbn/piUGK0cMfcCrQUGWJJfeRFIDKhlPH/bSWySq6Rfw+wVDfEXun1CX/VayUxos9VBQSYvFXnRz/NKRHNS9atbfPDOrUGm+cGn16akdIdug6A0FhddnuPzDDkMa0HmAryCkan34A=;24:3ahpY3u0pYaTfEVahEos1xEcleGZeFSMrQlEM9A6YxagHlrOCvUBxIz2uXiLvydvIcjL0zDkvTKYfWZ+kGavJo+3siZkb+Z1K9W2aLKEZL4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3219;7:MLPpPlTpgAnaX/tFC1QNzshi/gaPzMteO4/kcdZpL/VtRe+nW83/gTDIz4s51u9lpi3RyE+9AgR0bcXo86Zpy3sri+r+yX6sHjRk7zeKJmS2GjNWeafFrXVkti2jhRCW6nOHpmJATwAVSFc+n6WxlhYHdcwDVDeptNfnFpC8wRvwFAEWUgxkN17yUPK0YLyznZ4c/KEe0Q78a+XQwsjafoeV1fXpP+Ee//N6mVXLmCxQz66L3Z8xMgBoY7cLXFhT
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 12:19:21.0642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 890f02b6-02a6-4b17-9c51-08d5956f4e47
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3219
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596274473682349198?=
X-GMAIL-MSGID: =?utf-8?q?1596274473682349198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When access the /sys/kernel/debug/regmap/5-0033/name, kernel reports
NULL pointer access, it is because the driver point is null when
accessing map->dev->driver->name.

root@imx8qmmek:~# cat /sys/kernel/debug/regmap/5-0033/name
[   26.553924] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[   26.562052] pgd = ffff8008f779c000
[   26.565457] [00000000] *pgd=000000096f40c003, *pud=0000000977872003, *pmd=0000000000000000
[   26.573857] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[   26.579436] Modules linked in:
[   26.582500] CPU: 3 PID: 3757 Comm: cat Not tainted 4.9.88-04623-g6be68dc123cc #1700
[   26.590155] Hardware name: Freescale i.MX8QM MEK (DT)
[   26.595204] task: ffff8008ef513200 task.stack: ffff8008ef4e0000
[   26.601142] PC is at regmap_name_read_file+0x54/0xa8
[   26.606110] LR is at regmap_name_read_file+0x38/0xa8
[   26.611076] pc : [<ffff000008638444>] lr : [<ffff000008638428>] pstate: 60000145
[   26.618476] sp : ffff8008ef4e3d30
[   26.621786] x29: ffff8008ef4e3d30 x28: ffff8008ef4e0000
[   26.627111] x27: ffff000008c62000 x26: 000000000000003f
[   26.632437] x25: 0000000000000123 x24: ffff000008d6c710
[   26.637762] x23: ffff8008ef4e3eb8 x22: 0000000000020000
[   26.643087] x21: 0000ffff8ba60000 x20: ffff8008f72d2000
[   26.648413] x19: ffff8008f6921800 x18: 000000000000037c
[   26.653738] x17: 0000000000418170 x16: ffff0000081dee00
[   26.659064] x15: 0000ffff8ba84d00 x14: 0000ffff8ba91d98
[   26.664389] x13: 000000000000270f x12: 0000000000000001
[   26.669714] x11: 0000000000000000 x10: 0101010101010101
[   26.675040] x9 : 0000000000000200 x8 : 00000000c00000b7
[   26.680365] x7 : 0000000000000000 x6 : ffff8008ef41ee00
[   26.685691] x5 : 00008008f6ce5000 x4 : ffff000009402000
[   26.691016] x3 : 0000000000000000 x2 : ffff00000906d728
[   26.696342] x1 : 0000000000001000 x0 : ffff8008f72d2000
[   26.701667]

So add check here. When the driver pointer is NULL, return -EIO.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/regmap/regmap-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index f3266334063e..d1097306d2ab 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -43,6 +43,9 @@ static ssize_t regmap_name_read_file(struct file *file,
 	int ret;
 	char *buf;
 
+	if (!map->dev->driver)
+		return -EIO;
+
 	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.14.1
