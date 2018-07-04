Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8F8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D1A24207
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dBD7ViV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D1A24207
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934406AbeGDJEP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:04:15 -0400
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:26899
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932324AbeGDJEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceLU0lATKF2Eq+g4YBLjW9fKmEkuHdOPtV++CMdp8GA=;
 b=dBD7ViV5H3/po1VvnDVOmqmjT/WnV2vCgYJV5bSFIqEu2flKSxRGnEWSaVV6aOywWN7lDBSXqMQUB7GcRq+vnxRiqS3qzVU5IwIN6Lb/YTYlxmN/cgFJTwksvB5YH8sx+g0fhH+hPlP/yYB7zsf8DdJDWZhenYACcLSm3b+Em4k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
Received: from amd-Z170-D3H.amd.com (202.56.249.162) by
 CY1PR12MB0458.namprd12.prod.outlook.com (2a01:111:e400:5191::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Wed, 4 Jul
 2018 09:04:05 +0000
From:   Shirish S <shirish.s@amd.com>
To:     linux-integrity@vger.kernel.org
Cc:     Shirish S <shirish.s@amd.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: Fix NULL pointer dereference in tpm_transmit()
Date:   Wed,  4 Jul 2018 14:33:40 +0530
Message-Id: <1530695020-21888-1-git-send-email-shirish.s@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR01CA0092.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::32)
 To CY1PR12MB0458.namprd12.prod.outlook.com (2a01:111:e400:5191::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28802b29-3aec-4a40-ab0c-08d5e18d1996
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0458;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0458;3:92AxuhWXW4nKzCowPrre1LGXfTgxbUallFq7LHDTM0AkySU1gUK68Ll/6Zhmyu/fMlvsyQ6KfH97EdAVovjShEIUK3rF1rddfC4TvKgT8BgJ6S9EODrQCaLEf/qcGgubwdYJrVrNKw6p3N+S0jOVF/DL5PdynNGQlYoci8kahzrKzTw2f73bQbIErAkQ+J1KbLo0qkQ1w0HbI4Q/L/ovaLQFZ5ekOT+79i2sN0ROHBedrkWU1mJA/IsvUTnDc9B5;25:PxExKtmvZ+8xCMx6DUEZAQ0P3hoIJUk/uD/Vgk7/gRrb4aP80qNLAF4VGn4c8EIos32ponSYKtWqmoIbSNUEIR8PZWmolWx49QUuehdLd3BVBDAjasIHmXXLHmpiv4MSCm0yp3QBvzagAnkD0iskBkjq1bH+GmjMJvgz8rgOkeOeTZqTw8EGMdzCZ+DXl+I4vBL2KeaBRcgySl0lviT8V0EEcqtIN99NoStvqOl+Ys5RwGBmSYY+3RsmmhIdfHEv5wzeymwQsraDS81tzosC5jH+24Qgv/SNbudSL1SgehBN5Ax/iNef1v8DD/GEFMj69kATD5MXKKuL4St+J8s6Nw==;31:pswdC0mkEgWEAhhEhkfGHzN+5n81ldK0fFLweaYhBbqqiPIGiR91wYKgT0uSZHWzT1Hulz8/BBU+Db3f4OQa+iaUly2yiQffLNyUE8AK6JdNlkPwfwv4oxt4okpSSELlhh3UfGLrLvF211DbBNN/e4eih1vBRlKRQBF6ifGfJc8KLzY83i1bR7LmiI145xubNYcmwJBv5nURCGVc1+udN9HaIYMUDJHddkh7LfA7PMg=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0458:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0458;20:+CEtpFz+kk+ylXwEpQEmSmxwNyOfizaRY1+Y/2iFHZc52nqwHKq5mebqKMIBIWeo4YwEZWbwN0ON+LgTLz+UnqAJCAWDyfnyl1m1w1VY6vjXjsfD9GNlqtIla/i260MOG0s/4UJ4BMdlFg+TyH29D+UuwjmjEPntcnTRvaibZUEer0UoEH85PPa5wxvXktVjvlsGJq3Kwc5uZhzoMMX5eUVMCTlafmShMyNzZUOw1xG9VSDqDmrRwWhp6GwCduW9vLmzdJENg7QIYI6jQhk2JyD599hpJYtWxsEVmGX0Ogj7h4+YtCbmqwE2yItD4lr1R5orXQAtrl11/IavVyYmDwyNG1nLCa/kSDYN6oblIleFpwDfA41JERqyKosLcOz9L2n5KWvGMaI0A2SSB6qOdr3lQinU7iKo0AaA9SQcyJrrGEjf3eXEW4zFyKApbQuJ6NVcFZ1V632R9ZdpcPZF+CnqH6/naLtePvwoAZO4NnznpwJBmJsYkkRe7AdmH9j+;4:gZixyVMrY5LEw7EiwK+S4vgkqyaV405D0l9M/1Oe91F1/KvB22CihIsBzoNO3DxzSW588h7JCgnkUlrlxeSbOlkXan/BuMSNstVZYM53s6b/gqh957u4W8DrPHAsPkT4A3x/XMejQ4CKSKRKb45NgDVJA9k2eLNnZyC5/wBCxvW1VGGaKqAM2xgYLui77ilsqZq93SX0ksuLQ3Ar7ogrAP1d0npdhFKd50fpqcaYpajaspGE8dpd19FIwxtIc6KQR5d+bh+zWQgkgXerJMgRS0V3CpOxAaSdzzH8ZqfpoGfxvKlSjwOFymknxUZYoN35
X-Microsoft-Antispam-PRVS: <CY1PR12MB0458EA70442A143313182560F2410@CY1PR12MB0458.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR12MB0458;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0458;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(2351001)(6116002)(3846002)(8676002)(25786009)(81166006)(81156014)(305945005)(106356001)(105586002)(8936002)(7736002)(53416004)(6916009)(6666003)(66066001)(476003)(2616005)(956004)(186003)(26005)(16526019)(36756003)(47776003)(14444005)(486006)(386003)(1857600001)(52116002)(51416003)(72206003)(478600001)(7696005)(2906002)(68736007)(6486002)(54906003)(50226002)(316002)(86362001)(50466002)(5660300001)(4326008)(53936002)(2361001)(48376002)(97736004)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0458;H:amd-Z170-D3H.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0458;23:HCjxzSJhe4kmYLElyvVReolAyCujTGG9lcYhSlHax?=
 =?us-ascii?Q?FBTjAaxC+AlhTVoNR9mREC4P9zTF1+XdercPpwEVkVVyownqW5TW27Fi3WN/?=
 =?us-ascii?Q?bSvDBlT5ol/B5rwCHBf0ofpoRXmJdJBzHRTwAr7K7JbV9zbrQ34BAJ6a8JU6?=
 =?us-ascii?Q?Vec+vN2Z8NNmLgakbJ2qXQv1hJ6/vAUpTyem81gkieQbmHuq48IeEr/gOgAP?=
 =?us-ascii?Q?DOrRZlxlZpnakn4mkXkf+2eiNsToelGu6G7h93GlmvBjr2xIQH/mndCdA58k?=
 =?us-ascii?Q?wEsdaHzHeF2Om2mFAZCc5IoJYsPgmt2fWRv80M9hFCY98XRMtS140/p2DlQI?=
 =?us-ascii?Q?fX0O3qDzJ71yHh4s12ladc0327EMxlZPB4PG/E5+Ew/RuEvJzLwI+HuZ5XVB?=
 =?us-ascii?Q?x6Zj4jzbo+qjI/itUN0a5Ay0l3ySgHiylYZ5adSAKz2vTIeTM6UDacf0lKVm?=
 =?us-ascii?Q?ZQicqjyb+j0IniBvhSnBkuUUWnfbVVdpoYFTJDis4t95SEho7RtgbgbpQX9M?=
 =?us-ascii?Q?drzZaMIQtzgZY+M5rl3w9phmuJFOnq24D20ji9755T87hgGxFJRWLH4+sONw?=
 =?us-ascii?Q?xAGsOFgRJNJeQw63FaEgfMCup2Fzg+JWHMuZy3eW+9IWVRueHFbkBq9xN43h?=
 =?us-ascii?Q?8PbNGfw33njFAUP3zqS9H7wV27eO6EDWTsrTUYDfMFsjw7Y+dnd0MglNmwPI?=
 =?us-ascii?Q?Z/j/SiS1ONtJAH0Wp4JogL51sFAqz6Oau8+LFLQai48/MAj2kKuaXhm9zruw?=
 =?us-ascii?Q?CqepX1sqek11hFxDfdcuCwCi5ZxFCXAfo+HUqAeynN9XlHIABFSzhFphBfOj?=
 =?us-ascii?Q?sGBwP4Z7lhLQJeIw/WicijXixSJ7QrYEWNW2wh46qaD2QtkqqmIg7Y5Y6sQ6?=
 =?us-ascii?Q?eBUrTQeNHHgwFHG/NGiV9+3wcn9aOSyoYYYn9ivTwlcCyZsz4DXhO4FE6q08?=
 =?us-ascii?Q?lIU+nX/5XKCSLc+gF6adCR9paWj9G01rWJEugWWiWG3wr1EiZYNmJlDdiiLJ?=
 =?us-ascii?Q?9WxfnIzlkL1NA4KHNWn27rif7vp+uFKiCSZdCA8DAUW3Yyvip7uZS6ep3ggI?=
 =?us-ascii?Q?DKBJtsBgg0W9EsFJaET93oP7xD8GSem/ifrQ/g6RPZxJ0glmlxhUhqbYqytN?=
 =?us-ascii?Q?04IwOFa5JcJmKidBWpYnykeZVK63J+pUKB8FtHNcw/O9XrTtAHJEW+CRkoD9?=
 =?us-ascii?Q?hZj9eJMaPgO1EyCmgi6Xw168CtY4aOSKZ/FC+VfkGDEpiOKXKocjylU6w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: oYQYJo22KsaAk7p9aZBOlnmKfK538q1zUSeW8zwihQfh4leIWNXaa3N70OGGuxv5TzofddsPElL42rHDPPZxkoNDqBce6ulL4sYEevX5iy/GozBwcWo9WNr8dorUirs4FkH39QQl/XHY0uMNZNwdhxELidlfdMoUsI7NTDjRowoB8rZb6K845j8C3MCHnDhEBihNRHKSSwlIfTOocMYNLpRvFfGhkdTuJegqSdpQLZ9gVhLZXhA13XgT7vLK3/FCI3UJ60p6DHADkcXa6t9q25gGLMQsGIqjkPrtf0uDB3NNYWnCp4gGu+OlccWKqH0My8GeVWWk3OvZhGoq2bV97wfv/pYoj/UpGFBRM2HSjSg=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0458;6:vugxEmB471pMbCmKnhP/MN7hyQQaRksPcCIcOb1wA7RdvZfCvtYJXAneaIMEvGtgP3UED1cF11CU3w82ILy4p23WxOx6UW9OZSSPzp24DI7X0kSTgfUnAFEw8tOSZBGmJZH8KWdAvSflEGf5SrinUn38gVaEeayJqU3wY01dagdWyxes66ekvl8V2ZJUdfClV4fdSXnBEQRsCc3isx2ME1L8k6i1N+/b+bc0Am12YfHkj4DfRrbN+HeZGXlw7OA7Ycxg4FUFAuA5XBSwwiLBHvGM4w9aug0DjePNbM9RrUqSjKXZpxXDBvtj7ODv94eFu6aNMa47TDP4oD0Z/A7Q03CkJozlJSAEXMMbv9RtXw5vwIshTH7sPDs7hYMuepG8BIEnXMu8j6Qwc7BoVFCCG/mIhCTYbSYUQVj2HjdKavRmMl2tTo/JhvYMgtoawGEQZU3Ja0IRh8x4mxYkiXkGUg==;5:zX1xIU4S1zTMT6wdwUUBmSaAazz1nzJXvE3q/3A9UCERUxewTr+tZzirGXBA4xm9eaBMGUneMy3HIo4k0fDwJB4OfXWkKCa/DsZQThrfdchdqszIkp8jF8MhNNt1PxStPzlTyZLvrhpBucC6mlaUhIKkW1XBPzNx8kREYgFt8Ec=;24:M4PmX4ypkzrsEqoLG3VF/9K7ua2TGKZfzwlGq04Z2f10aQc5abomQ+3bwDZtJAZDTjWxeYWzN6ILQ3r/fcTLM7ah0dwV1cW59stc2kGTBHA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0458;7:V4AQwrXMGu0AGDtNsQou3Zlhz9uakGMicz/9WAD2eKamPzsF+E8i+N2ENDxfkwgTVUPdZH7+4h0RgCyRZMtYNxdHWQm9qcDtcGIn4BuaBV3LqU99tpALJWoCbtQx1rssCogyQ97/9oOmAd1lq7JDHkAKXQw03ON8AFdCNxSVk2fyMgEFc1xqyfffgo0U3OomSBxUU2HEFTxXJQol9Z9DQvhzS6WCkKduEa3x0ImgvoJwORYF7wi2WXeUxcVoe+Vl;20:P30mNu6VfuTyB+s1uxNTWxxYZKqmuvZrV/mEOteNqYnvsUdd6vwSFyPcco+j7z/Ov212mxel9S6TWfaCHmULs1gPBCHBXJa69nRUsDrGlRcaGzFSvaO0PWsUBdgv5okcOlEVrITqZ7UAU1n88BN1yfTOCxcPTZs5ioV88XCetmrxj+806zEvr02nRcZNSHffAbSzLGrnbMfy7gbclQeMNYwCjT5xScqjOiXad0IPtYK56QOzR8VQzuNvMKQ82XSG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 09:04:05.5297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28802b29-3aec-4a40-ab0c-08d5e18d1996
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During system shutdown,
tpm_class_shutdown() when called with TPM_CHIP_FLAG_TPM2
flag set, makes chip->ops NULL.

However tpm_chip_unregister() called later in shutdown
sequence tries to access chip->ops in tpm_try_transmit()
leading the NULL pointer dereference.

This patch fixes this issue.
Below is the trace for reference:

BUG: unable to handle kernel NULL pointer dereference at
0000000000000048
IP: tpm_transmit+0x267/0x565
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
...
task: ffff937c847fe580 task.stack: ffffa79f80b04000
RIP: 0010:tpm_transmit+0x267/0x565
RSP: 0018:ffffa79f80b07c08 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff937ca9bc8000 RCX: ffff937c847fe580
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffff98e3cd40
RBP: ffffa79f80b07c88 R08: 000000000001fff4 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffa79f80b07cd4
R13: 000000000000008c R14: ffffffffffffffc3 R15: 0000000000000000
FS:  00007ef31f747740(0000) GS:ffff937caed00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000048 CR3: 00000001243d2000 CR4: 00000000001406e0
Call Trace:
tpm_transmit_cmd+0x25/0x70
tpm2_shutdown+0x69/0xa3
? __radix_tree_replace+0xd9/0x120
? idr_replace_ext+0x92/0xb6
tpm_chip_unregister+0xaa/0xdb
cr50_i2c_shutdown+0x1e/0x41
device_shutdown+0x157/0x193
kernel_power_off+0x35/0x6e
SYSC_reboot+0x120/0x1a3
? do_writepages+0x36/0x6e
? do_writepages+0x36/0x6e
? sync_inodes_one_sb+0x17/0x17
? _raw_spin_unlock+0xe/0x20
? iput+0x87/0x1bd
do_syscall_64+0x64/0x72
entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/char/tpm/tpm-interface.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e32f6e8..b14d196 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -411,6 +411,14 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	unsigned long stop;
 	bool need_locality;
 
+	/* chip->ops is made NULL in tpm_class_shutdown()
+	 * This case is hit when tpm_chip_unregister() is called post
+	 * tpm_class_shutdown(), hence exit early and return
+	 * transmit operation not permitted
+	 */
+	if (!chip->ops)
+		return -EPERM;
+
 	rc = tpm_validate_command(chip, space, buf, bufsiz);
 	if (rc == -EINVAL)
 		return rc;
-- 
2.7.4

