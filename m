Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1155C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658A920868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0hyE3Cfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658A920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeLAW0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:26:31 -0500
Received: from mail-eopbgr780080.outbound.protection.outlook.com ([40.107.78.80]:42176
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbeLAW0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l7RDY0jb/bNTwK1A9iSd2ZDibGvt4+OPlRPcHRwtEk=;
 b=0hyE3CfsRQJI3BAyC4ZZFdIfZ4Y19Q8swtfzytADZ4jhpy/+ROKWfNK4VnygU/tVwUR/yhXIpBoN1DleWYMT8qJOZ6kYcL6a0wBvAhyQZR+Su/eVD8t5zVW73j1me16AXHR/HzIyd9hBBarBEknIGpme2nJY0PJ1WRVUpXsY2O8=
Received: from SN4PR0201CA0046.namprd02.prod.outlook.com
 (2603:10b6:803:2e::32) by SN6PR02MB4334.namprd02.prod.outlook.com
 (2603:10b6:805:a4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.22; Sat, 1 Dec
 2018 11:13:45 +0000
Received: from SN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by SN4PR0201CA0046.outlook.office365.com
 (2603:10b6:803:2e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1382.22 via Frontend
 Transport; Sat, 1 Dec 2018 11:13:45 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT047.mail.protection.outlook.com (10.152.72.201) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1382.18
 via Frontend Transport; Sat, 1 Dec 2018 11:13:44 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DU-0002W5-FZ; Sat, 01 Dec 2018 03:13:44 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gT3DP-0001kp-CD; Sat, 01 Dec 2018 03:13:39 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wB1BDZCY003405;
        Sat, 1 Dec 2018 03:13:35 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gT3DK-0001k0-PU; Sat, 01 Dec 2018 03:13:35 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id ED5586050E; Sat,  1 Dec 2018 16:43:33 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        <martin.petersen@oracle.com>, Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v7 07/10] usb: dwc3: check for requests in started list for stream capable endpoints
Date:   Sat, 1 Dec 2018 16:43:28 +0530
Message-ID: <1543662811-5194-8-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1543662811-5194-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(396003)(136003)(39850400004)(376002)(346002)(2980300002)(199004)(189003)(51416003)(356004)(186003)(478600001)(6666004)(2906002)(48376002)(476003)(305945005)(486006)(50226002)(2616005)(126002)(36386004)(26005)(8676002)(426003)(446003)(4326008)(11346002)(316002)(42186006)(107886003)(106466001)(36756003)(54906003)(81156014)(336012)(39060400002)(16586007)(106002)(90966002)(8936002)(110136005)(81166006)(63266004)(7416002)(76176011)(575784001)(103686004)(2171002)(5660300001)(14444005)(6266002)(47776003)(52956003)(50466002)(107986001)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4334;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT047;1:xExEvVXWj/CQCsbwA0rrO/mv6E1zjHy27PK6+abi5ONjv6wktY/llhYo95yO4tYZ+2dot8t/HpcTVlSJznqLcpkuMKSDojIdxuvqNX67w53xUbrnSJLtBlHlGW933lzJ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b929a3b-36e7-4232-821b-08d6577e0f78
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4334;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;3:OmZ0HFzF8+Lqwy1PY7z//DpTJ6lWEHDYxntvsT0ZGvDrRMwSdggp8imOf/s4V/LOx3buGG5vMpHAPhqTjXJ0MPB2T3L9t3RDhGps8IR5mxYij071ok4ZGgJWwz0WxX7LqyC1tmqwoWD/Thw2tJTYbO/XNpk2Cnkpr+yPI89CJLe7QjwWPeqpv1u992b88OUg2Wb8e4Ejb/mEIfZKaMR5aPQvZCJjJVFgs5uJ8NTJoa4p1N1idDk4R0lEqZiHQdqK/kpFChN1oY+6QQYuMO2t+in6jZ62Wl/AWe5TzihNinSFdOgUHK+aqNu6Cpg9uwg80GOJHF/KJiSk1g1Ksww2hXHqfkhfDjyJIvNV5xjjK70=;25:JderzwMqXGxfZEQckPdJyjRRG+U8te/axtjMH+jK+A51K/o4FbDHSyFuttqEwDi1UroEPwGQNY5EsiXY5Ve4PbqE4SFNTnOkcmDiMnEGRk+/7vfPDmx5PqIYvbExgCPHaA+Q56HcGgldEL3pfqNiESBAZnpKPHj+R118oXrVASy/vxR2kTfKwgY49uUS999UjpYheaytrxqc5gMAmf0/hjW6bqg/26H/tpS0b0jq9PqNZdbwKLma9coomv9Nayj6vCHiPQLTclkkssH9zWp5mWTVkE5H3iaRUYpifrC3kok7daaxQACH+QeUQN2ACf727pJWiES2RR7L2eg4X+JWQQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4334:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;31:Y6RCxFPCYEk8IFzONvVRudD08E6qNg5I2IC/85xGWKAScDYGcw1ouLIUPgnkAGOiCrnslKEyobA5WyQ8QYO6WnTJFZ9FId7OHendaZ8shAU/fH2J+vJqUiVizZL815OICi6t0Z9SmGIkXQpYNrajHvJ+DochUC637nWXc51CRge6mU7oRTX1o5yU/YraZbCq5FPURrtH0A0P7lMv9XlJy5T2RSKe8ISwenfZqkWaP6U=;20:p/68svC6Fd2zoX6dEyskd+nHIFBof2XJrK+DazFTdmjKt+4gz/IWJs/AAXyptCLapDnB0bqiB7Lr5dUr6epmfvYgp+LlfRqNF20od2hR4L7LiKxNB8DjqufoWba5si40H78Fh0DKGVPJNBZYKyWd9GltF+lbm81mqKMyc3VX2omVW/YAYPf8gb8uXrhW/Cf60uANJAA5guZqEd2ZsToFhev2stcI2EP1ag6TTdSMbWe42r8MVNyd+16GkkkfQv6lcNSURdWA9WTVW5IAC8k6u/cTnhvhAuzGqKffTb5Uq1EJ73JyWFd4ZdAAOHkRGkPcfiHkoJSMIw1Q6Syl6b68XB9WMbMA+gzsju8ueIGGkQHza+zi0z5i2Y39mSyF/DOJWAKgP96E68Ti5yIIOri0A71sx9P+LYA7rjFiF7Ygj/mrV9iDsIs/LbmDy4q9NXf87tzgoitjF7bn81DfZFjL1B/I/BZoumeSTZ0xHyaF64pkKQTZfcww6AzQPShI7p7i
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB433440DA387E19CC3C079F23A7AC0@SN6PR02MB4334.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231454)(999002)(944501475)(52105112)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4334;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4334;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;4:AfbyxyqsOOzdCabu+sN/yEWdhG+BXgU+zAFbGgx5Z1AHwifM84UVuRckoziZ6TmRLTMaNaXysMPigC7eiBMRMjqUgIQUtV4qHyTOAvrZevrTrEG61hn29p7u2RQ4d1U1DvgY2lqDAnKmn7vIfUDsDB+dKIXioMwZhVQMSK9JyKHyUmtBP9QDa7dXeqLaom2is7OJKOYNbO/3R4fve/SLeAXwazduySUV7kEa4N6whjqNtO7rAWRDbkKxX6JkBGNsVY73CwvhAKWEbbiMjOsd0A==
X-Forefront-PRVS: 087396016C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4334;23:ZCp7Kluer8feQBJdCNjw0ik/vkN0iFgCRafuF+i5v?=
 =?us-ascii?Q?JZcFLBBRg8QaW4fu6mms1p6MevC7bW8zAqP4h4NyQ3yuq84Xmca1QV1SQHZh?=
 =?us-ascii?Q?H7rRl4xjT9uJ1U9YV11cpzymSn4UNHh1xZclb5G370zZTfeGjAHsrAVQu//c?=
 =?us-ascii?Q?PbCRjReKBXWKwoT4e6bXw/vSds6vGjgiuGxe2ezU+ZAkIrmGTrFWmZUWZZGS?=
 =?us-ascii?Q?4GSq+xjPTKP0QIeDD3ajUl/TZUrm9LRBAjcf87Ozui6iLu0UIeImU2Vs0CLn?=
 =?us-ascii?Q?FD8CsL03DhGz40DzDQs0VSZvX6i3w5qq9wq/kJzKHPrEfZgAgIAOq+lfHmam?=
 =?us-ascii?Q?tpfFPokMVZRcKBWdKxjp15PrsVQvzWCnVtx+xYEr8hP7wPpatHHzEzlBntUj?=
 =?us-ascii?Q?cpeTMvMoBexWiS6zMJmjbpnu0tTFCgy6DrE5/L+UZq6d7s8uPWc4ffSJAwjC?=
 =?us-ascii?Q?tfj8Uiwcja5oX17ofY60yE1y+g5sVuGH7ALc1cT7ESqmIllQ19ng5pk9SQtt?=
 =?us-ascii?Q?SmKgfQNtCYIjsBFz5+Q/avOT6IPIW3QpkbI7ipfxgACKHCFKHYH88rAfZH6E?=
 =?us-ascii?Q?G7MxsYi1L5hc6zvKUc93D4gWeCN6z3ehxW/9vZBRtCJoptnmBr2F0T1gmtxP?=
 =?us-ascii?Q?a31DwLWl9UU/8MSefeh4yimEhzYmn0HBep+0HBe8MgqmB9IS+SklDdfmxrVK?=
 =?us-ascii?Q?aCR1utmbjD6+2dMskYyLL32eyR0FE7zgklE6JdvsFcaMG99EgDdfNemlSOcN?=
 =?us-ascii?Q?LIH+xoDcbLk1l/Z3ILRB9aDGdDyzCkzKUR3enFJKalVSoi4WQXEVrohdWI+b?=
 =?us-ascii?Q?2SvaJ0OrY3UWjNa9ybEIDaLiCVnzKHcQL6MIAGMyUn7+/X6NRi90BFGzQyVc?=
 =?us-ascii?Q?tfhLnn+DmFCWGoaFtpvyOA6BFAijpAnntOdjWSyqPcO5jzyz065JbKKmQuCz?=
 =?us-ascii?Q?iWNy8e3/EIClMLOK7DXpsNQe/JiWcsYDyteHXmOhCeqmfyV+Owe0qBnJCBJs?=
 =?us-ascii?Q?WwebOIxg4oGUOqKWP6H7tG3jXxjPHjg5z61hKSi9//LdgLL0G1QHQI5u5M6d?=
 =?us-ascii?Q?lCedW7iYyvndDNWmcc10bV/PbtgezIzl8NtbaFZCUz8cDmUJ1/B1BCNAAzTU?=
 =?us-ascii?Q?0zcyrIaETMa21x50OdUB9tbgVg1vd3zrLmjm0j8B6RcucKFfwY6OTLjnoq6T?=
 =?us-ascii?Q?j2fZVQq+G+U3WK8sYJ5/43Tvijy5B80npdwYRoAuVXbJD6lyprNMB2Thp85c?=
 =?us-ascii?Q?Ctp5OIjTeJ+QYbDqJ8X6V0z6I+H8FrfS8+ykvNx/nXkat51wn4OrWoURHzkO?=
 =?us-ascii?Q?c66G38o9zG37QCyfd7zFWIPQf1MjnOWc5od2loeGgg3?=
X-Microsoft-Antispam-Message-Info: zAufC6ZVBd5qSnb6xN1VbssY7Rg17F4GWULI7KP8o/9vaHJuGPHyAoXRxMn0sWkH7/2bgokA+glWVwvjzWgxopFXX9AbX6J2qW2x5HUxD2l8m7SbEeMKk074CKES+d3LMyJCLfyUyOaEe3+oH0BSvIcA7zHaOWi4z6UrgQ8CA8Y1cFqozi216jl15AAPAQZa0bgdNjG4Jqd+M7vktN5d3vDaxtxBuRQIyqI909XtdpuozL22wJ2b/1XVyQyYfmApVhsUE66zQS3V4p8PeNnjbqY16nn+QAl7Ns/mGUpsYsnl5umEN+PfyM89Itwv9UPoAtt9iUzAJDd4W+kv2MzU620lPuiDoL8GwFP1TcLl4Kk=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4334;6:U5npnSDWDGq93wogYqF4zNRtVxyrgiTr3/1WQgsk6LM/o2BPzBhYgdFVyQcFvKuVvSIXLaxpBiQBwtWBr+YcEAVRrShBN8IKZX100MUwMO+79V0ICKbq88I3mE79tZx9Xa7O103/DG70iqBbS+sZHZQBP5AHUD5lxqq9IcAkG4FNEGiuMxjISUpRadAGOtYZKW4vdRt0iGXvk3NFn7ScaEKLC2bVPM5F3TPvBBveiSLMjaDMOXtDqnqirH0DeHwbz6TpslPrXsGJUWJmVyUoPTJtARdlLZALZt9KezeJ9ZKUUqX9Khwiyi52+8Di3dH2U2rcKWOZREX6ULkZoeNH4jDS8x2qyxkgSQqAJ4zn4vzvKpm2FoUNWTHOnpsh9o8Lo1tzD/tvwX9PWYyHQVZWl96/7CjnxfZkF1B8KOG9+iaNhVY8nDYK0nEIGqTHexb765/nBWN+9J4Y7/VPuNw2kw==;5:K6+QzRUN/I5IgiQke+7V86ng1C3/jYxfZckVRua1Od8nLSpqJQqqOT1Epra/2svjRgGeEOfZqcIT0sdvjYeUBwpwarHwWeYzekLTucFtX13CR+lQCe1FP2F7OEy7fkOD8LEeMyx6EPBLgabeg/Jy4CjFxwlGoeQne3S4Glg7ovY=;7:nM2B5wL4/8odFWwP9u7SjMy3fadZcIHfdUiGKgV+NOU+jiUW83j8nfA8omKQCEP7zao4pyjP40TuJxe9+oH8t4S0mZkVaPrdQyfBgkzWYua1tcbgnRdb9svjjGPlvZgwypo861jlnCiMk4M+weDJtA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2018 11:13:44.9367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b929a3b-36e7-4232-821b-08d6577e0f78
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, uas layer can queue mulpile requests on
single ep with different stream ids. So, there can be multiple pending
requests waiting to be transferred. This patch changes the code to check
for any pending requests waiting to be transferred on ep started_list and
calls __dwc3_gadget_kick_transfer() if any.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v7:
	1. Reverted to dep->stream_capable from dep->endpoint.stream_caapable

 Changes in v6:
	1. Replaced dep->stream_capable with dep->endpoint.stream_caapable

 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 78c9bc6..d0de7dc 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2413,6 +2413,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
+	if (dep->stream_capable && !list_empty(&dep->started_list))
+		__dwc3_gadget_kick_transfer(dep);
+
 	if (stop) {
 		dwc3_stop_active_transfer(dep, true);
 		dep->flags = DWC3_EP_ENABLED;
-- 
2.1.1

