Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FC52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="I1ifHujR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FC52075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbeGROeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:34:20 -0400
Received: from mail-eopbgr680065.outbound.protection.outlook.com ([40.107.68.65]:30289
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729305AbeGROeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvw5xKZoGCLr8p4uJUU0vPhOhhvqkw2o+laKQL9aTQo=;
 b=I1ifHujRs5nyaG7CCBVsOj7doODWj9RAa4bkK1e2XT1FcajEjGbgZc+ctrVGB8pDwc8ZiMaXKSsVDq12E0/HrO4sAaInHxm2wNqgaWzxHCQyl3VxaVvCVrtx9RBDqib8Xxr1Am9Q/8/76FpxyLEULd3A4sv3cDaaeEoz8FUdRh0=
Received: from MWHPR0201CA0020.namprd02.prod.outlook.com
 (2603:10b6:301:74::33) by BY2PR02MB1622.namprd02.prod.outlook.com
 (2a01:111:e400:5267::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Wed, 18 Jul
 2018 13:56:09 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by MWHPR0201CA0020.outlook.office365.com
 (2603:10b6:301:74::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 18 Jul 2018 13:56:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Wed, 18 Jul 2018 13:56:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1ffmw4-0000Nf-3q; Wed, 18 Jul 2018 06:56:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1ffmvy-0004qq-Vc; Wed, 18 Jul 2018 06:56:03 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6IDu0gd008863;
        Wed, 18 Jul 2018 06:56:00 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1ffmvv-0004qG-Q1; Wed, 18 Jul 2018 06:56:00 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id EF1801214FE; Wed, 18 Jul 2018 19:25:58 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <apw@canonical.com>, <joe@perches.com>,
        <linux-kernel@vger.kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>, <svemula@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH] checkpatch: Resolve improper warning for krealloc arg reuse
Date:   Wed, 18 Jul 2018 19:25:48 +0530
Message-ID: <1531922148-7423-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(426003)(486006)(52956003)(5660300001)(47776003)(50466002)(51416003)(476003)(14444005)(110136005)(36756003)(478600001)(48376002)(305945005)(6666003)(2616005)(8676002)(16586007)(126002)(8936002)(316002)(2201001)(81156014)(106002)(72206003)(26005)(336012)(356003)(36386004)(186003)(42186006)(54906003)(81166006)(50226002)(4326008)(2906002)(90966002)(107886003)(6266002)(63266004)(103686004)(1857600001)(106466001)(44832011)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1622;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT058;1:SaaPR4ovLF9sn4NCbTRS/PnkatT+/Kph+smmH91+EZMAACG67z5fb9hDXHu5XhvSWzlXc5GqfdZtIqJhemZcNScgmaDrC3wRyUDJR9wwxCLRQCwyYWrde5sGE8sdZz7D
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24704288-83eb-4d5b-8172-08d5ecb636b2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR02MB1622;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;3:yAL7bZ2TSA0hOMVuy9Wz0ofHzMQSRst6mGeSJq39tF8nqgsoJ6oDaxm8gxf9Ca79O+DQnlLMBeTH16dvtHJWUbBKRQi5UjMdqhOmlTmF7PrKp3qYtdqAxe0YCEg9FykeRDH22JelX0NBnp/eKclQ3ue1cpsTLv/EpxHWMwCc2wIxSsLP7ScF/DHi8px9s7MwoqiWkNSaCil6xq4azOZwjWfR1DlAC5tp2l0Drujf+oCO/5P/dOFI7qD0bwRJYpZqH4/7R1UBsCDuUShZN2/3UVOYuEP0uHoTBpo0GRve+zqNDaoRpDCQ6wYDjJm6oov3XUOC5p/p8Az0EzdaHB05lkZ3eHn/u1YKxdfW85HFFYk=;25:VdQ8QslvMhRYNQhqisbxmPCThjddjhQxrJv1ncDW5bbdTiszyFiK29od0EsC7vaR2TW8Byy7Cn8LW/x8RLiD++TMBKp0rpo3uOgnRwKYH4+o0JZ6r7MJeiRz1767p6A9vafDAy2LgvwO7bAccIkzjw7TSMj+ONPX0S6fh8mnSpY1A7CfH8PO+r7zAZ7dy24oRxwspLCYitp+0nppvHJsbXjxcbCi7kusRg7j43qhbmlqDbBuv0c0Es6pOvZyMeCbqjXAssO1okdbVLfCS1Fc3jv2KEUYaZp+mfSRqlBqHTxN2rZpqkMMIkVUyIQgUeV5+IMmqgVLc5oY7+4SWG+Sow==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1622:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;31:4A6kFAT56myrAzDS7SAVqPvroSpygBl1sy3qbO/3zQgxW0zoxN6PDzEWiziZHEXPQaa0fS6U6rbaYYiwMplYQbq225PLq9Mqy3mFJR8E6KzrN0u8Hg9Mrya+liZnFyM1uOaJhfjYujD/tuTaunjOeYGGYUk7c7+SV3fZJoAgKNBrw2iJPfGzpio9pIdz5SWtCFWPs5Dt+R+DVYsT90XCOqz/04GbQ6HuN8dwNw632Dk=;20:hsbWYKK37LeTIhuISgEmReSL6cXwckV7pvZS2ATh5PVY1NTN2u26KGuS5ODcQTXagzmBWGaB5tQYYh++8/rdV7gpTzJWT7gQG5o0B2fvYy3n6aqi8oyhjMUfasHdplkWGGUoRENHNcMMnai4rQratEB5IXX2/4A6i0WgMehsCkTs7JoQ01wGmqncKVMIZgmKf5HzKJq1g2WP3h1nxVtDBqXJqC5GY8VZV1k9BpP15hYcAdi6g0tZ1lsLUiv0jUJXD9ZZe+dpaE8SPrTU6lHQeH1e7JKs+qZZUe3Q5LsKhyWovIzblCPhq4hrEmZgP9gpED3d1kZJtvgpyXo1ABZ2nogvs3iRo5fHZh6vdNj4PYPRWAeZBzjJkwU8z0HaVccWcQElHJkMWpSxWPUQnb/Af6kYi/rgxAbudhUuyUGT+SQPq6Yz4zvxWX8nno0xaSufPMKxyahcoDOzzDi/NuR3YQpzLTj9EH5KAdkgZGomTB7yslO1ngYHUJ1ycGqLuO3Z
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB1622B49909196695C6293045C1530@BY2PR02MB1622.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB1622;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1622;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;4:zc1wpLEbRecG40MMY2ZrgFxMw5kGF3nmYyBFcdqyE7t3nlUfMfJsKb5NuTbpKZ/88pAUZc8exolS6/p327Bao365eh6MOCSPnK4YeDwrGA+5QMP2uuiW4D4nsyYZZS6dK30eJ7EPNVPxm/yOISqOx/+9b/7kydEs/yiqDrCHGewNfjhcuNsz/1imjfai4rC36udXUmj3sNTryqasrsPheODvMwyOMB/AMNuZW9TdpTVs2yxo/2qSqWJx5XUxZhgSFH0lR3xmBCrXuRiv5ili1g9Fzfa3N+m6S0wKQbRtvkU9o9O0AaInxZ2053bBkjca
X-Forefront-PRVS: 0737B96801
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB1622;23:WAftA9MhHvSiDwDIwIHlW4M/xpkOH/bXmUd/92DHl?=
 =?us-ascii?Q?5hJa1oKSE+yNU192Flu4Hm46FUO4X1UDYq0k+lLxtjcgFW9zQVvIcgJkwKmh?=
 =?us-ascii?Q?gYaylYHOIPLOcObXiijcWvtM17jQ0P0dv8LmwRPYeKRfFVmMxC6smHv/mnX1?=
 =?us-ascii?Q?doTjKgTJ4Pal7S8/pmSdTzMsOgDeYjtuF2BjGTxnlQ9ijtbjc+z08oUJgI4k?=
 =?us-ascii?Q?um9Z+9cE7gfj5j+OB8BjiLluL7+KWyDvs9oOF8weXDTR6d709KeMBgJxlEBc?=
 =?us-ascii?Q?b3qjyvdNMHFXG4UTUTxqE9ry0JxXZwDsfF9Njb2aCZZCn9o0rs3spU2LXaMW?=
 =?us-ascii?Q?WeUcsCUSDC8Op3u1lvvnqvnUR9uDZj8OdWplFG22CFsa5fkw32cq5O4W9zRn?=
 =?us-ascii?Q?y+jYzaVhWgwCWwEB7G3jQE8VaG+lUqyRvN3Qn0Q+id67exMJ/kcyzSU81yvQ?=
 =?us-ascii?Q?5Gz/bnxvGGq4RBTZh74+Gc0GTqIz7SM+RPXCEh6QeoCaPAI/4/xtilPxrllS?=
 =?us-ascii?Q?GOvNR3Bw+f3VwSs+kzV0SuqZDqspiRHgDBj4EbeJZfAEPG8NzKIo44LfFKzX?=
 =?us-ascii?Q?IPxm3/LzrRxZ7zvOIrf978YiKq6TFnRNITrWjQZcVAJMnhLGtcv8xPv2nV9p?=
 =?us-ascii?Q?LKkHDo4pKE2bylgcMyH7k2WSSQr+tXNfOUAAFb63V5+Gp1Uer70gPchMGLDC?=
 =?us-ascii?Q?rB9ddGyPcOCiSLuVIyoycNNAKZqpG7hh7ciFJJ3TcZoJM7qBLsl7q7Xu6d5L?=
 =?us-ascii?Q?23IEM7VmJ4ctUdx8zDjYqfEE7PmEu73qwasdPuIqY9889/wPlaLuQHWHqVuU?=
 =?us-ascii?Q?AOLNZxAc3iwCqh5jDHQw24oAgTtcY/4JAP5QCLV/7ntEw1MIG8w74FKaM59y?=
 =?us-ascii?Q?euavOzgG7Hmybfp77TcCywF36ItSowWFOm1x/AtVnFR7KGXEUbQ8aoEVIHMV?=
 =?us-ascii?Q?9Tt59p5KTF2L6L/2Q92cTtDECXzZVXPiYKIE6lBLv5qK094GvajIZwoVRbjR?=
 =?us-ascii?Q?9CrMRaBoDK9avqByreg3y3DSZPyjaX7oy8/fOR6TZYZmg5oIYnsx08V/neWL?=
 =?us-ascii?Q?w9KMcsoEXwOIDcFG1nTx9poyqVNxnhouacA4AS+870TuSX4lJQB6DX148fDi?=
 =?us-ascii?Q?ts1cVbwplNTr1t+SaQj33wIvv26hnxXi7SEHmsnb66cOcowk5O4kA8KAvAWi?=
 =?us-ascii?Q?37GRv76Iw4iBu/xD6XmxpI5zIk/2H0knYUN?=
X-Microsoft-Antispam-Message-Info: SwQDoJbKnIkJLcY/lUC6kz6ZIjF52D0lFXmJst3mNOMsuBHms55guWa0oI3OcgraG9x8W3Y8aQb2ZRrUahk7ebBKViAEzEHJ79vzHsiJ9ZfrszShOOG57hPT8cVCs52F3UB275qeOhZ7J7tIvLbHl56bIfHq7YnJyBEFHxTE2ZBNXzlcqdqTZjCFAppXmrsCksUzNnkmS5UZ/tY/rtd6t5PCuIw9EtgJghSK4FYb+KBSaBPPJyhe8C62BdjkB7F6YA5NvrTV0KYG4jtW4PKh4OsNBcJmCc5QvMLcqKamEm0LOOoEQ8bfLn2yikEePaGnZWDy003V89l37kFZ8nGrDhwGN5/U6lJIVq7eai5XiMQ=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;6:kRoN1nQxnPJJyZr6FckxEtM7qE0MN0Eo9bDmlnLheXPEMZy12/XD8K4ySyyDpJslvwjIpbqxpgDzhtWgm8k4YHQszD5uDln7QDN9QFDQLNisMYR8LRgERNVvCON7dzef4/t9ib+DQh3ds4/vG5ZmwYokPyxXQKKxBiVoRvdlZOB2EfR04hVGNQecWL4JZdHQIJG2wq7hB/Pq6DYJ6iAEnr//PlzZ7ky0LOILFSU8az4oRl2IN4SXrm2xgqRwnDt8oTzDgQXwIlrVDm9fzAwM4m6Uw9IzTenpl1FnUjmpyenvynWX4UTKtaNqGCOFBVoYslMCilAt37v/cbHB/UyWB8izIrdHI7IgC7ms32Sz3lPuZNA529st/Siykk7eh2fYOwkOe1rK6h677wLCxKGsLdyZb5kZOrTRpKXMJqh/jWXI2kUEdLs6y8o7YsUTG995DZaKR4JsOcR8Yc3bl7vq7g==;5:zijGR/c23QHmEOEgb9AWWIdTuFzEocMaYf4rsp7C7REQaV1K8JLVBNhO550OPP53ioYW2xGjMEbkXjtOReihw563uWO9kjxi7Llbz7jzbHKNgoBOMFSHjOBn6bIEXzC8fXbYQRK5H7eCq4stNgmTI+njwaUoTWrd6I3SUTszURs=;24:t4LsQfyfJFWFpkPsLo3gfFRvt1U35a/z51TuhnZfOA8VnGWUDYCVXzOrKDVqssHMl1TdSUUu7vXmI/rQeM+jmPDaofb2OxFw0Sh3diJIXFo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1622;7:ssTXJHa8FMaTgpf1bAioIHMFUE4AA+EB4LwKl2AqqNN7FM5xyihEhBNFa9gWqpGtQ4n96DsoV4MgoCDVy0TEzwLXbmuJ/9cTtJNxkVfiYnVSLv7HFCh6vlv4WKaqromCXDc4/COhC4tgD078rC5MzWDsJmPxKUFXtRkU3Prjpi70nn/1I57fGz3gJUEU7DwDu+cL8esX0u1Bg/pjijFQxk/CodJ5Qo1LqmYDQlBqhiHOdZsxhLyEkCVbOwSECcE5
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:56:08.6789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24704288-83eb-4d5b-8172-08d5ecb636b2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the check for reuse of krealloc. It gives false warning when a
structure member variable name and krealloc argument name is same.

For Example:
{
	...
	abc.def_var = krealloc(def_var, sizeof(*def_var),
				    GFP_KERNEL);
	...
}

$ ./scripts/checkpatch.pl -f file.c

WARNING: Reusing the krealloc arg is almost always a bug
+	abc.def_var = krealloc(def_var, sizeof(*def_var),

This patch resolves the above false warning.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 447857f..db9b666 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6119,7 +6119,7 @@ sub process {
 
 # check for krealloc arg reuse
 		if ($^V && $^V ge 5.10.0 &&
-		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*\1\s*,/) {
+		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*\1\s*,/ && $line !~ m/[\.|\-\>].*\s*\=\s*.*/) {
 			WARN("KREALLOC_ARG_REUSE",
 			     "Reusing the krealloc arg is almost always a bug\n" . $herecurr);
 		}
-- 
2.1.1

