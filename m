Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CD1C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4575A2706B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0u3ajnVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4575A2706B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965075AbeF1HlS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:41:18 -0400
Received: from mail-eopbgr730059.outbound.protection.outlook.com ([40.107.73.59]:46160
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933998AbeF1HkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQPZtY+yyoWa4n+OKGfH/vSTwW1fWmjYjfFbp2zbo6M=;
 b=0u3ajnVrbF+vNEiKPEkytgaIRjKHGAHmYXmEfJwIeJqkHXtxTyxIzR9YQM9N9cXvxYAxEGkrXXTne46yvU6zZ+ubJBY6Q66767WEAT2mhYZT1w8pytB3MH7dZ70ydjlVIcrO15HZRokfqN0QfMQn3GyzKU8dlYsgf7GEA3MP6/g=
Received: from MWHPR0201CA0090.namprd02.prod.outlook.com
 (2603:10b6:301:75::31) by BY2PR02MB2151.namprd02.prod.outlook.com
 (2a01:111:e400:c506::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Thu, 28 Jun
 2018 07:39:58 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by MWHPR0201CA0090.outlook.office365.com
 (2603:10b6:301:75::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.20 via Frontend
 Transport; Thu, 28 Jun 2018 07:39:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 07:39:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34912 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRX3-0004OE-Ne; Thu, 28 Jun 2018 00:39:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRWy-000195-K8; Thu, 28 Jun 2018 00:39:52 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S7dlM6022792;
        Thu, 28 Jun 2018 00:39:47 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYRWt-00018B-DH; Thu, 28 Jun 2018 00:39:47 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 93A37B20953; Thu, 28 Jun 2018 13:09:46 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] net: emaclite: update kernel-doc comments
Date:   Thu, 28 Jun 2018 13:09:42 +0530
Message-ID: <1530171584-20673-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(438002)(189003)(199004)(36756003)(47776003)(478600001)(356003)(4326008)(336012)(26005)(186003)(14444005)(54906003)(16586007)(106002)(486006)(2201001)(90966002)(476003)(36386004)(426003)(6266002)(42186006)(316002)(2616005)(11346002)(126002)(52956003)(110136005)(446003)(81156014)(50226002)(51416003)(76176011)(81166006)(8936002)(5660300001)(8676002)(2906002)(106466001)(48376002)(50466002)(6666003)(305945005)(103686004)(63266004)(15650500001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB2151;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT027;1:M+bjIGV/is6oJt0IUFLhBKejte/S6BO8S2Fnl2F3x5XOqFDvf8q9J/FFxQ8IXyfnllHUVs4wi/S4X9JJwOjpzaWWhrCr/VnX7/v0q/HuYwv74ak4cD+klxmcClrwpjV9
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99e3f6ff-c521-4c02-e87d-08d5dcca5984
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB2151;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2151;3:ySJuiy7klPoZ4eNdDdck86QIRdmdIskAj/vpcznThCnuU5J0h+IxkoVpQtY+mN9LFn4QNE5Ak93zFwp8JXqZ04hnfj5INDjWLw854wxR5NHD7ZFM219R15d1DwGM9MqNRleT7k5TSx49ImEQ3l7z6iQ65Cs8dWA00ugNFf8vsCue9MVW2XmOuLttae+qhNohzQVca0B8vlsmMSJYGxrrbU56aHJ0dNXh0v1WrAB5dLWtetwjIehQcUBpbVSQAQVODOFJk/h6M4xn0SYRqG8jcx8xyfvnG5ZtiIK7wRoifX6xgWjnlhnxEtT4xvS4hB1WpuuEjB58BCxPL+Qo89hEJexYEThjFCXnnK+Wpiw8S+M=;25:v4a26iqY6VUDX4r4i4NQy7AaiNJQCpbeTfUnZKPeeHbaQ/Rr0nbyymuK0Yo340om27S22+zAeLPifXuB7N+zbQCx/FKQWIoBqG6HJdQLvfTWXZkSw57tsPfKUYieCvZ5f9sxysYBSTkv/f008SO/ruhCl0das9KwLnCyJ9hvgugTVJG/Hvd06441DkZ7jMXpMlnktK7pj5ugtHWKS6LSpKm0hjGzA9H8TSp6EL/ufeM7hc7tp4i3X9hYuqtd3v/HjzWgY2h2U60PZQeiHfg1ZfEaRqj3bfMikJy5XknmT7az4Xvs5nRT0On/iGHd/xa6p7dsTxPKwa05KXhr/9g1Bg==
X-MS-TrafficTypeDiagnostic: BY2PR02MB2151:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2151;31:fHgpxAuldf88Z7jzuBl6hDyAeSAOHt5pT5meTek+R5NRB+rLgjyrtpk87g96rjIVK1/dZb1g/FHjtu3zSmHcyWr/qKLn1RNyw1B2YuUX4mdKvgbNlK5VsBnU2b9rbEijwhdjG5drCA/EIDWy6Ll/pM+lugSa9JCH0JfKQGjDKIEtXc5e8n/dmU9x0Coz5HzvQ0u/oGO1QJ3QdTsvZKw2y0Ld7Q24o+1F3qy/vyQt6/E=;20:QQ7RP9OtlQDsv6qEIwLxbyzaFOINY5ZsXx/SqQOh7O1NE1jX7pwvUpEBuD9r5Qmbb34Vr2y9Dpr1SUfr3hvvSGzwtU8PSGTPSj1mQnY6VvnfPLoFllSeVlHPGscEFCqy7+pJOct2PJLh25v7yG8TRQB2nQaUrrWw+/1OUSq4gWwQvSXgj20r43t9zM7YUHKPNJrZNNFABkIQeGNsFayuW9bO0oI5xXg3Q8J9dSOCRhvys6dlOY1cOe3BcpNFQz7kZrW1C3r9aHV7P52i51XlTOqqYkxcQGGEsjzf4Oss2NuOfO2Y2oFpovjqHbg8MECAunych/50CIH+GJ/2GdriaQ+R+qyLhGER5bT3df/zJyI1MCPS7lObp339IvJbso16UJZjHv4RVAmncH+Ou3wTH/jE8dcnTLY0OTfa9NvfPw0MVovdGOut1K1NGVuoMojpV6GwO5WPIaptujZl/8nSyh/6/4li7My3fGuh6XjdzL+9g4JXHloqj4g2MCWhtrcm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB215100DD4E71919263CBBBD6C74F0@BY2PR02MB2151.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB2151;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB2151;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2151;4:tNtQsPmFU3Xkvr8AVuJiej6TmGYUafOCH8Zx1tTyorCuORZ3hXbSdvyCg10WbjiYALkyD4+vulU4mIy5sOb5won0olzEBjAZN6MEBd7zeYockx1dOSsYURPyb10VhWn/uos8cdxE8S8GFUs/Qu51ZSWR8HIkZ/qXC2/IQxH+q48HLXsJ/YGBf/TW0rsBNtTs8ddbs/0V9UPPbzku7VmKiqYcYgWyPhU4LrKGsgQMG0Rff5K2al1WoLh/7d9iUYZIwQ0HMRJB5abTCENspzy3XrR+yY1baGpwxFOP47qRYFv87QbJOgHbUA4ky7vhaBd9
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB2151;23:NCxACX2x7wGOFmNC5HAQSiXUU0CoMgJNSGUo+pEQQ?=
 =?us-ascii?Q?inyoD3gj7A3D/w4kCFMiuZbzDwCI+nKAClZlmQ8wnKHcEX+YMdygtZYz0UPv?=
 =?us-ascii?Q?IyGfv8OE5e5lS4rXhEqCYIa/ZYMzO8N0kpyJTYC1mcVs3znD9tv6kDsV7Tvb?=
 =?us-ascii?Q?JMzWYVJA8kODN4HcL3R63SRbBKwXZX5CYvyFxTN6gUsYuGlSc5RGdsOfrTxs?=
 =?us-ascii?Q?8+8YqCTqIrKD7nLzX14sKqs/XDHkAiqgT0AzDP4ZIofu9zku0C/ZGcXoZ1ta?=
 =?us-ascii?Q?x1qiurS34xH/wwQdzevaxocRVyOn1c/npVYn65QEdKdONxZmnwYwS1MezBFq?=
 =?us-ascii?Q?AhKi/RhURovsuI2UDkBIcCGXiQsvlXeLi0R6q6OggVk6pN0Lg1AjxDLJAbuM?=
 =?us-ascii?Q?ziQyzffZcbVmBJbh1rf38lJEPyF/9UcwbTYDFIg1nxL2Gadpov+hCQHIyp/x?=
 =?us-ascii?Q?dLG39B3vq5ZLBD5U+LGZGjUMyPmfVr+RQhxkfopVAaB/kNvc4XoCCowARctb?=
 =?us-ascii?Q?ebn5QKta87u2jzPb58B8GplOurr+3Aexku6Z4pOfj33XQVb1KeouaBtWOcmU?=
 =?us-ascii?Q?po0PR7tvhDAtxd8vP5kOwPQC9prAtjtUf735nrojynqgZa+Rdmc0Uef6aD7e?=
 =?us-ascii?Q?uyDgcbNnj2a0WE1UkkeNmZwbXLDa4JKAMLFO4INc2vaoajEXpvywLhUXwAk5?=
 =?us-ascii?Q?GLU1CLyVMwnsLFiCGPaeF77W1kCKJGspgjM1q3qkEoosNXchMqJQ2DVvUKcm?=
 =?us-ascii?Q?14NEWyiOdbRe88mC7MD3sm7HUgwt5T40USAUfQj1UucSks9XXtPEpNEHdRlY?=
 =?us-ascii?Q?cJCm+tbgryVKAzW7jcl9gCWboKFZXVpTmuKw5ck1G23Q1U4e5NE6JYjRD6Hx?=
 =?us-ascii?Q?KqPN8uBiwa3Et7onOVt/NWwMCnqxv4cQXcLBwpnUdj/opycHoPX1KN0dE8mj?=
 =?us-ascii?Q?MOwxxyBD8K3nSm6Bbn/ZMlzQiaTmRNX3jwMqP06tqmy6m4/n2c//8Y/KRieW?=
 =?us-ascii?Q?nVDrnx7zdSSXDBWrv6bOmHfEueS4EKwjXUWWf+1uXoKo8WriWdcjZg9eaThp?=
 =?us-ascii?Q?Ho8a7sNmYmQxd7uoTri7R8DdhisRt8XxU0aAV/gUKC+FeOUAUNCbTVcB+Y6b?=
 =?us-ascii?Q?T0LBfHvM/CvZm314Fo+J1jgmb4G8CWD6W2HOkzR0/kxs3A7UFQvDNqpNOIcX?=
 =?us-ascii?Q?m31S4+kHfEynVbLQeGyYxZDxZBNZEf9WxZv5gb14DEVl2IXPdAokm/q8w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: b4P2k78eFXUMIGrxnDgk88gavjVz6ojHKLAm4oterHd6kTYS8uDfwzVtUzoD7+5mZ5IT4AoaQfd+2HkvIuLHBZgC2rNfJ6POsASdPZZfrb/V76NeCnPZOIHnu63EwIyereRGXjfnBhVSlbvl91RpakHHTFAyG2JSfVP60U6mlU66tr955snk5fSd3ed1D6zdXTGMiiioAzyfvCA6iCVd/P7e8x1X8XfmFJW8KVk8JKbuMCZYmhN3QG0ZP49+IRsNU7smaROOpOjzr12AwtXhwi04gJdIr6qrtCBhugCvWvw8iz0iWPBmIyMbKMRFBb07UcCZAruGya9qy2dh1PwqwxYuIuFB81lYgsbaYcdFYnE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2151;6:7WT5G0Z+BwlO+bPJ7acSiS8whD9k037daJvhiNeThaVcbJpwySFkMQgfgeyETQCHfJ9XvrQwRWF2cDxq6QYKYlMeh6JqtNKduYPcdatlSKPblbqZiverHfqrx4jQqzwyU8Yhh1zkTKBYBgcsBiZ1M+PZdhDaJ856HcaznsXeU/TH4Wv4pvwhD/9yGFsBcss/9ALZx6mKKP98wtOm151GAHlompA7zpbaDehGtGirR5GlGAaJVdNVF7RfmqI20YcWZawvJitTJtEtITbuUik9HZlpGlWwJf4AKNyHivLGfBWk4ELM6nEed6z21WHwnITF6FtUYerkwpEpH50H1VpGspbi8cHSwwRJGL/cAHfbsCjaHYAICZWUWqqP6lRH97MuX7vcVXlSzX5UoML2/SPAL957s5aOv3k14kqNX7dSH+1ipUHSx4ZQSF1D9OnMAHP83ZFggoRqE03/M6aTCQnCRQ==;5:Z8OXiyR7YvPqsQr14XJfNjCjE8UrZ0l8aenkYddAoy6c6ZoVqyqPPeNs6Mod5epH1M4d9PvMNIpMQyfHMcR7pgNOtp9IvU8HOGjnwMw4ws9MELujqDPWkvrKgHlTBEfiHql7g2M1nIn5aUK5bxUc/xuQtqh2TKNC8tx+07yHMng=;24:d3GZ4zOweOmzyZbTbQ+ASf9ohv1s7yx3QWgJ1tvkE2Lao+GhwDQUbm2SXwZYvCxu7JXY9i/w1ldY2mnZqWPDotcJDH9XKyWAhFgfZEX6q48=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB2151;7:juVw7i1yXKOfS1S93hw0qGtA+c7bFKZBNfZBYI4NPG5ocoUOFEt6e7fr7YHnqfSFHBLYB7sgsspLy/jk7x8rXO41iqTpn/FRwl0rCAkQJw12rlyzhxk4iFrCmMFAIW7reh3GS6P7zWIl59KT/yh6kvX1wB5TKvTwaNOqE7Hy2OtCqMGicxJtSgsYK+DwXIizGy+jkZopOGYbh5cuxHntYUoRJCBES1iJR8ZvSg/RhGqpa+MJShmEofyyGGf2UXpQ
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 07:39:58.1961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e3f6ff-c521-4c02-e87d-08d5dcca5984
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB2151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below kernel-doc warnings:

Function parameter or member 'maxlen' not described in 'xemaclite_recv_data'
Function parameter or member 'address'not described in 'xemaclite_set_mac_address'
Excess function parameter 'addr' description in 'xemaclite_set_mac_address'
No description found for return value of 'xemaclite_interrupt'
No description found for return value of 'xemaclite_mdio_write'
Function parameter or member 'dev' not described in 'xemaclite_mdio_setup'
Excess function parameter 'ofdev' description in 'xemaclite_mdio_setup'
No description found for return value of 'xemaclite_open'
No description found for return value of 'xemaclite_close'
Excess function parameter 'match' description in 'xemaclite_of_probe'

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes from v1:
	- None
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 51f84f0..2cc9353 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -369,6 +369,7 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
  * xemaclite_recv_data - Receive a frame
  * @drvdata:	Pointer to the Emaclite device private data
  * @data:	Address where the data is to be received
+ * @maxlen:    Maximum supported ethernet packet length
  *
  * This function is intended to be called from the interrupt context or
  * with a wrapper which waits for the receive frame to be available.
@@ -488,7 +489,7 @@ static void xemaclite_update_address(struct net_local *drvdata,
 /**
  * xemaclite_set_mac_address - Set the MAC address for this device
  * @dev:	Pointer to the network device instance
- * @addr:	Void pointer to the sockaddr structure
+ * @address:	Void pointer to the sockaddr structure
  *
  * This function copies the HW address from the sockaddr strucutre to the
  * net_device structure and updates the address in HW.
@@ -638,6 +639,8 @@ static void xemaclite_rx_handler(struct net_device *dev)
  * @dev_id:	Void pointer to the network device instance used as callback
  *		reference
  *
+ * Return:	IRQ_HANDLED
+ *
  * This function handles the Tx and Rx interrupts of the EmacLite device.
  */
 static irqreturn_t xemaclite_interrupt(int irq, void *dev_id)
@@ -771,6 +774,8 @@ static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int reg)
  *
  * This function waits till the device is ready to accept a new MDIO
  * request and then writes the val to the MDIO Write Data register.
+ *
+ * Return:      0 upon success or a negative error upon failure
  */
 static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 				u16 val)
@@ -804,7 +809,7 @@ static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 /**
  * xemaclite_mdio_setup - Register mii_bus for the Emaclite device
  * @lp:		Pointer to the Emaclite device private data
- * @ofdev:	Pointer to OF device structure
+ * @dev:	Pointer to OF device structure
  *
  * This function enables MDIO bus in the Emaclite device and registers a
  * mii_bus.
@@ -904,6 +909,9 @@ static void xemaclite_adjust_link(struct net_device *ndev)
  * This function sets the MAC address, requests an IRQ and enables interrupts
  * for the Emaclite device and starts the Tx queue.
  * It also connects to the phy device, if MDIO is included in Emaclite device.
+ *
+ * Return:	0 on success. -ENODEV, if PHY cannot be connected.
+ *		Non-zero error value on failure.
  */
 static int xemaclite_open(struct net_device *dev)
 {
@@ -974,6 +982,8 @@ static int xemaclite_open(struct net_device *dev)
  * This function stops the Tx queue, disables interrupts and frees the IRQ for
  * the Emaclite device.
  * It also disconnects the phy device associated with the Emaclite device.
+ *
+ * Return:	0, always.
  */
 static int xemaclite_close(struct net_device *dev)
 {
@@ -1065,7 +1075,6 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
 /**
  * xemaclite_of_probe - Probe method for the Emaclite device.
  * @ofdev:	Pointer to OF device structure
- * @match:	Pointer to the structure used for matching a device
  *
  * This function probes for the Emaclite device in the device tree.
  * It initializes the driver data structure and the hardware, sets the MAC
-- 
1.7.1

