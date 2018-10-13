Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EC7C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4572520895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="msmUpizL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4572520895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeJMUwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:52:34 -0400
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:39159
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbeJMUwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwO0gynIuiSeFOqpYikhwO8EgXv+TT0af0sAaaSb6Vs=;
 b=msmUpizLutYElku4pjpc+CdGrS+kMOYjdrJnz1+VUefDps6FpC4Fzvcdx3WdXZTmuzdpfPi1D+a1Dn9/w0gOPuN4wCjxWmpPx0CoocjZZU1X6A5d7HEiWS2W2S9zRj1JEpQ9pgT8qpxV1tWeFi0yJKo+/pw1w1rq5u+rOa2R7Mc=
Received: from SN4PR0201CA0033.namprd02.prod.outlook.com
 (2603:10b6:803:2e::19) by CY4PR0201MB3508.namprd02.prod.outlook.com
 (2603:10b6:910:95::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.23; Sat, 13 Oct
 2018 13:15:25 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by SN4PR0201CA0033.outlook.office365.com
 (2603:10b6:803:2e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.21 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58048 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlH-0001Gf-As; Sat, 13 Oct 2018 06:15:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlC-0007wb-5v; Sat, 13 Oct 2018 06:15:14 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF7tM026432;
        Sat, 13 Oct 2018 06:15:07 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl5-0007om-2a; Sat, 13 Oct 2018 06:15:07 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id A0C23604E9; Sat, 13 Oct 2018 18:45:06 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH V6 08/10] usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
Date:   Sat, 13 Oct 2018 18:44:55 +0530
Message-ID: <1539436498-24892-9-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39850400004)(2980300002)(438002)(189003)(199004)(316002)(186003)(54906003)(478600001)(81166006)(446003)(8936002)(36756003)(81156014)(47776003)(106002)(7416002)(50226002)(2171002)(5660300001)(8676002)(11346002)(26005)(42186006)(103686004)(476003)(4326008)(126002)(39060400002)(90966002)(2616005)(356004)(426003)(2906002)(52956003)(110136005)(336012)(6266002)(16586007)(63266004)(51416003)(6666004)(48376002)(107886003)(486006)(36386004)(106466001)(76176011)(15760500003)(305945005)(50466002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3508;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT044;1:pQ3lPVU+I5s/wHSa7zB+ugUGvQXhL/VlQWuKDCcVr3tlZl/QjVTGNbVDl+VXj5cW72/1WEfpa8PEmo1csHic4KoJfAPrbz+HW+ZF3b5eHupfn4VUWmUzxkqb7ICZNA20
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af036af6-d6c6-4899-5d4f-08d6310defc1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY4PR0201MB3508;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;3:5XWlwQk6VwpaZetWoYuVx5xf2Rxqc60cNVBcx6o7PQ9/VvcJskMOB5uU1l8t7GJCjO27jDBHXw82qZ4eGZMrgSvbnNsuoeMYlvuaGjU8puNcd9ZIehDbMLEWDWq6Pv0SadH1rSEj1Vw8RYfDFlmcjoCB8k5gIRntQIdwT+L2UdrXgl8un8sDl4EAY4nDJTd1pvzr0fYTgVDF7OFRwf/xWWA6WRfPRx1yR6wAI36MRxuRX1HwCY5Jgd5Ku548kG3uWsZ6IRSbbGrHXN3kf/WTHaPsjymvgqkj27+IdfvM76DeYycVS/JktYQgD1B5RHV/i3ANFHdQgA6bMwN11P1f6V8H1XTFnAALu6pe2y/FhUM=;25:VbGKe4Mq6oHonJNEbFBTlDCM2rk1zDDAOQrRyuOajrdH2ti8Sz1RLcWQApmkv6ClOOx963PKSj+Ehj83h97Ll8OxYbczzhPFQ0T6h5+Wou7YQK1MMGcA3ZfTL8uP28No0N13UgABw3JPh4jpsRV5Klh52p45ALygtbS06gnwFUiAFuDn2/YX2BMKVZ1TlX/7rMwA6cGqn/J0lGkvos6bDfPfcQz/cQ1Ry7+Gy0MCj8rbQGBABYlZM6vAXoWs7xymx82/e7QrJUFfFaQBLIUKeQaaKfz0u3D43kK6t7MiUDVEiREnlWH400yrExmUjGEj2C5SReburaLeZC9QQSVFGQ==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3508:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;31:P9sbuv0CbdsO4Qto/jFEotJocwvFQzd6WQ2+7G4QRuUb5idStEogCcJ368eFdxX2BP3KXz//V1asAbG4uIH58UTwdUqUvmexbNbtfCCdMp4Kl0Glhw4QLMeNrIlN1WGu9mnSkR27pmxipk8Ka58HdQP93ppKQ+toNhidoyw9TxcHWptzcst/e2OcnKCq8wp10nB7KijBEacmzy8x0tM2isi9VkZ/pw+LyivPDEK5vRI=;20:ub7wId8gCwi6u9+K3H1gUIY8wHCgs7LbyWznVfIAtKE9wC43bPezEsyiaJKILiCzjIdLcm9WKO6H3vE0jtlWonnERJVCVZb1+vhE7YwaIIKlyuYOh/04TJ91IiJ0ZMxlQTNdVD5JV7CQIpYXIwzLHNO7oPhjT6+4c3PkbJsr3J2n6vxoUWKl4YIROxZwI/dfI8xj7NldSj+UONkl7tBbAoKsFQSSnE+GjOYaJazcE19RTXjPTNCHeEk1mAcEsUNSOng9XeDqnveoh977t/GW+la8vq0G5GMtNhFaEKaiYPiTekyD9Q8T/U4NJEYFxsenvdqbf3UuEvLig0aAMRJ60kc8+MYqtdaTSt4E2uqBH7N4GM+w47WbxYkJTOomLYgM59YuFvADfgL/ZKGmrGnSWIBVeHk4BGZwn++/AKMG13AC17i0w9g/9F9+TvAQ7Gu8VqoU3LuPJD6E/t91Rq0iviuIH4AJ6NqSmky0S277OsoLSsbZuFJYXbD42JMwwX5A
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3508372351DF61592ACC27BAA7E30@CY4PR0201MB3508.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:CY4PR0201MB3508;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3508;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;4:blU8/O1ch2ZZruqJ9iqpMiTY3wK902zMCZU6sfeeO1P09RyBvWeccsuyBrdHDOJ/v5QMpP5o2LLZcWjyTYhNmH2/OP7/2g1aVt4wUcTctUcGHEV7os31SVF3lacAiXhzfmcFGSwpE9ebOJHe1ufD1In7XP9jMnZuGLI1WEQfDU8DPIu0jCcRuHGGfsJ6uBpOvNwFzTT/z7W34zMTUvhzDEA0JSHDms4BHT4KcdHhtQ9chi1yx0DXhvM1WJQWYmMRRWSoASO8qN4Wvo+Iggsgg1NgqnVYqfDBtYkAbPzz2hQquNcY449MAB3PBM8GYLnw
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3508;23:7XdgA+PZsgLkXO5y5fStJwOU847T4tadXDXUYwQ?=
 =?us-ascii?Q?1b8b55LIKHK3UmE+bZXZkBZLbxkXWY+E/8lh97MTEhn9jSsklNU4V79mkN1E?=
 =?us-ascii?Q?AX/ron21EFsSU6+41wz2pjlSU2EbgCoSMKSl7Gfl57Tnn2Cn2PlkPsumQOEK?=
 =?us-ascii?Q?UiZnSrtiznQSi/w7r5Jv/9e7DZzkUzkaTpVBt1AKvPj+/wy+XG0U41P/wSdv?=
 =?us-ascii?Q?ijGCbgBcRUYmFse/Tq8uMkIeVyzpTWWkd9kZ6M0Bq6ZGsZJGSko9nezhTyjQ?=
 =?us-ascii?Q?FTjEowdZYctIGemwijQYFb5xCwEtrZGCdz4AFn3YfJBpi6WBaAp+HNoAwtGg?=
 =?us-ascii?Q?Sd8+6tvJVS8Gk5rFI/obxnOfO+bov1+lmOIIvb+B/CR12XwhWhCuZTqqRLjx?=
 =?us-ascii?Q?lLxsOrFXi6/UokYFxqFF5XIXyS9JRWO0OffmsDrJMuxWbux4KYzAOqMV6zBt?=
 =?us-ascii?Q?n6YTIR4VNfB9aCoW21txUI4wx0cyXpjsx6rF1BDjsZsMqNgwY2HSANZR/8xL?=
 =?us-ascii?Q?UvZv9Tl2dhKl7gqp84Ub1Cqv3DoKAlw8SswZUQ8V4wpUem1BEueQile7Zgju?=
 =?us-ascii?Q?9kHhrJptWI1iyVkjxSIIh5BO5Swp9DqIyKkgtRtHbxxkr793D30Jrg+FTb+z?=
 =?us-ascii?Q?ithAmXEO1Hh+HUjpc8AWu/W15KJJVz60/0L5W3Oukf97KKrSAJ/m6uwN7yG6?=
 =?us-ascii?Q?xEw6MwqYzvaQXwHyr8H43lj744PqUu4PHrNZ7MqFEk5G8PNkLZ0LuctmI6JD?=
 =?us-ascii?Q?TlA9yniF6ZqsHu3mkkPrE3EXQfNE2JhqVa5hycJdmQHgQpOFw2nDfULJOzIE?=
 =?us-ascii?Q?nWAEeB59kSd/JeLq+X54El1IkyVo6CBYQsm7AELhjqO8Yy/txDi+/8gMsAcp?=
 =?us-ascii?Q?g1J7JjdmxMld5C3IgmsOlOTvqw/Qob4+olFjbKxk2ubEMXUrnVhCGwoJN04V?=
 =?us-ascii?Q?3ck02AxagLgU7YmaJDCREbSKeErKGLbOS2G5OYWpTF01tGSKeKATx+SIi972?=
 =?us-ascii?Q?RByn3f/2Cap5jf/rxNnzPo9DjSzxqByRbS/zRL8FkRocshwjymld2zDhOj5c?=
 =?us-ascii?Q?r+QJ+NzQdG/oTyA5u8nmrP301Lg0v0R9x/JnEGj2ERnkz8KVcbMdRQ78BCBM?=
 =?us-ascii?Q?qhiX8q5bYPNvClnc0PXXROWOJgiGJtgiO356ACfne/LMQzCSvaEurMzu4RQs?=
 =?us-ascii?Q?7rgoS6z8nb+X5MQQ2uMxJjZm5r7tpKFHac8yDhRK9vvLEcgmbiMsxvBZ5Hvu?=
 =?us-ascii?Q?G54bN1UNXsQhcOSQ2l3BgX/NHHANEkb6Pzs/E1YbK?=
X-Microsoft-Antispam-Message-Info: /KKhJgNXnPZL5h4hbR21eSdrLhorMm8Z3lc9xG+oY/pxa0rFIaJM+QlXFQ9hNuLNPcQ1Craa7chNrxj2vu86DEY9oMGX7hCYCJ1YEPwhXRhPpp2dTxa9YzjhVIZVnNREkc5j4RXaP6wzQJlqak4Jf9yiqjwq4QTlyjrox/zc1weOmYzVLjUuHC/wSyvXQvs7s4TbgMCJGSDhE+Pxm6GP0X6D+MSScB3IlHxTz1dKPNb4okqETOtDWeaYdZ0Qjx8eiazwM/8eBrtBJFx8uhEG+Z85EP/j6YfJbPAmQqJI8jc6bzuF8oTqK8y5yCvOIqo8Dv7IRgTltT5cjayc8PK2OcIcTHFnb17EpmDkJfqLuhc=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;6:BSwP6ZezRHw12LWPvPzLQxxBhl9H//I/++SUF3Rc7KQ8MF3KWQf7pQZygPVal/L0S4DnTwG7yNAaY6HwWEtJdWietaFJMWL3MMixLC6LQsZ6DxqZOz+pqE6b66c7VOfGrlA1TjUe/cAa/FESPs+V5MGYKeuwfygpcT4GLs9dZkvU2SZl8uf974qGwMgv16YKbMxlCk6FfFmIGc8hX0qcbfxyfhpQZFonO7+ij2tPfoRDgNm0VSGBrWIlsQApMV1wwEpTiRJnKf2QaG21jbkowD8bzJZ4wVM/acChsE09ZIYqty+VEgg59Bd4YWbCK88djyXPqzaRRpaRjduPZPJHEB+VyRtQLBvzg6V7FV1RGFOZ8VE+wBwonKztywEOIeoQH0FjWRVTDUIHTTmheBwVvL+lFOqDhobJG87WA626i9PG7JHrUgBBYaYxMiyefqSKoYdDPnW8MB3tfbLkMN2DgQ==;5:qfzinYCiKL9jPQ4q3xxk07Rg5EVeJM0zlCHpokZSjTx3mVimtMUhlCrd3zhRXtb2krNqjpHfuaPOyoevgEUAjjLa042Ybc2jdkrwbEwfy6E4NGkvGl1KKpGxnC5iwRHxLvKtyUrPX627cGmK5QcRcDJwubhkAXBBMhZ31uFmOlc=;7:S2NB6Uy9c+vzVU7O6Usn+68W3es8cd+OFvHd92A+h9FAYeI6WBRAb8ZR2EDwf9qPfwrZBP4xJNoOH0KfSLv5cyD0QVp1Bv2R2foAgazJWEi8CTqQW/bGlEMMzhdSGsMSXPWNLYfpgberiHaRELiVSwhijQjYYqpfTVsGq9pAi01USwKPpS7ucLkFXPsa85JNNMB1krkeuv0AiYCSWYhrP0T9HGysVYLOcvLe6qlkg+PuJt6RVaBWtfIJ3VRCgZn6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:20.0953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af036af6-d6c6-4899-5d4f-08d6310defc1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Availability of TRB's is calculated using dwc3_calc_trbs_left(), which
determines total available TRB's based on the HWO bit set in a TRB.

In the present code, __dwc3_prepare_one_trb() is called with a TRB which
needs to be prepared for transfer. This __dwc3_prepare_one_trb() calls
dwc3_calc_trbs_left() to determine total available TRBs and set IOC bit
if the total available TRBs are zero. Since the present working TRB (which
is passed as an argument to __dwc3_prepare_one_trb() )  doesn't yet have
the HWO bit set before calling dwc3_calc_trbs_left(), there are chances
that dwc3_calc_trbs_left() wrongly calculates this present working TRB
as free(since the HWO bit is not yet set) and returns the total available
TRBs as greater than zero (including the present working TRB). This could
be a problem.

This patch corrects the above mentioned problem in __dwc3_prepare_one_trb()
by increementing the dep->trb_enqueue at the last (after preparing the TRB)
instead of increementing at the start and setting the IOC bit only if the
total available TRBs returned by dwc3_calc_trbs_left() is 1 . Since we are
increementing the dep->trb_enqueue at the last, the present working TRB is
also considered as available by dwc3_calc_trbs_left() and non zero value is
returned . So, according to the modified logic, when the total available
TRBs is equal to 1 that means the total available TRBs in the pool are 0.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
Tested-By: Tejas Joglekar <tejas.joglekar@synopsys.com>
---
 Changes in v6:
	1. None

 Changes in v5:
	1. None

 Changes in v4:
	1. Corrected the commit message as suggested by "Thinh Nguyen"

 Changes in v3:
	1. Corrected the logic for setting HWO bit as suggested by "Thinh Nguyen"

 Changes in v2:
	1. Changed the commit message
---
 drivers/usb/dwc3/gadget.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 9bf1688..2d4b184 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -913,8 +913,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	dwc3_ep_inc_enq(dep);
-
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
 	trb->bph = upper_32_bits(dma);
@@ -993,7 +991,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	}
 
 	if ((!no_interrupt && !chain) ||
-			(dwc3_calc_trbs_left(dep) == 0))
+			(dwc3_calc_trbs_left(dep) == 1))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
@@ -1014,6 +1012,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_ep_inc_enq(dep);
+
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-- 
2.1.1

