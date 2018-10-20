Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9706ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EB721470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Ijm0P0fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EB721470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeJSQyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:54:47 -0400
Received: from mail-dm3nam03on0044.outbound.protection.outlook.com ([104.47.41.44]:58400
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbeJSQyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iR97A96RBZrJvXCbhD51CJFl+OoaJZAw7TATVbFyN+E=;
 b=Ijm0P0fxqXB1579K72zd9xK2xTpwp8S4lnL5oM7BLmcqtM4J5ylIbQ4CFo4pjyhcBRi75HbzidASW3B8FY0Jqte+4inpSPKvCYGDKEUNjTrjBXRLZbhXZ+Bm3JHIuRHyMn67HLp7smLX4qwqb0RhlyUutNjZa1+xnTHFkKnTW9M=
Received: from MWHPR02CA0033.namprd02.prod.outlook.com (2603:10b6:301:60::22)
 by SN6PR02MB4464.namprd02.prod.outlook.com (2603:10b6:805:a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Fri, 19 Oct
 2018 08:49:36 +0000
Received: from BL2NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by MWHPR02CA0033.outlook.office365.com
 (2603:10b6:301:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.20 via Frontend
 Transport; Fri, 19 Oct 2018 08:49:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT064.mail.protection.outlook.com (10.152.77.119) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Fri, 19 Oct 2018 08:49:35 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34838 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQTO-0002fi-Fy; Fri, 19 Oct 2018 01:49:34 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQTJ-0003Un-CN; Fri, 19 Oct 2018 01:49:29 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9J8nR9C000454;
        Fri, 19 Oct 2018 01:49:27 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gDQTG-0003Tc-Iw; Fri, 19 Oct 2018 01:49:27 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH 1/3] firmware: xilinx: Add fpga API's
Date:   Sat, 20 Oct 2018 14:18:03 +0530
Message-ID: <20181020084805.29103-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181020084805.29103-1-nava.manne@xilinx.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(2980300002)(438002)(189003)(199004)(110136005)(446003)(2616005)(8676002)(77096007)(5660300001)(50226002)(81166006)(51416003)(81156014)(11346002)(26005)(6666004)(186003)(336012)(476003)(2906002)(1076002)(2201001)(486006)(356004)(316002)(47776003)(8936002)(9786002)(126002)(36386004)(48376002)(50466002)(36756003)(7696005)(478600001)(305945005)(426003)(76176011)(63266004)(106466001)(14444005)(16586007)(39060400002)(106002)(107986001)(921003)(1121003)(83996005)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4464;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT064;1:K/9hZjiS+/Shrcz2tXeix462qwt2eiFH0U4+RhVkhCitfpAbym8+72ZBKqjEdhCy2QEV1SNFvX4vmPcMV2SbbaUEI9wcbtW7S13crZuPbVkNicRUD/3WegWD4CQ0mozm
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47b3aaba-d2e7-47f5-13bb-08d6359fcbab
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;3:T71+d6aowsj7gd691rl35TMZMG2LgeWRQVLmtbaGRaGByw+w1cBmDvmR12uno4E+LIqk991h++SGhTck6rHE1UuDUJHMZaxpu+M9Da4YoALjFbsh2IGmTHIEbIv/FspuNqnBBU1UDHe0Hm7D77X7ZB4pXg9RTbWE4LxHLg3yIHOuYKSJRfQVyrKdVxJxxrmC3M+F378o2b4lZPtQ0EaqokJPyOhvEB95w92htnw6t+J6fIG3slr+Ru42mV4wZzw9/HBVjzp1S0Ux1WMFRteAmbBY4jnV87w3fIIsKp7LOKQZmNPa2z3b01i+FcGa66nS4ntpHmyD9F5XQ3euROcc5KF6I9Xs2eV6DZmPG9wf+H0=;25:MitHLUEfnjrlLWAZAhzTf+o/Xv7Bdji6VzX2O/gdmsg1WGy4J43aStwNOvxtJEKaFB7Lv4YmIyoHqTt96Mq7p5u13N/YaRJ+guIaobeU8yAUEzU+GEhNzxDUAic3L8QXL1Qhv/FKjk7mwW0GBlU88UXiTWV3GTFW52d5m1mhAIlu3TaWFwIGFrh1/1jfHSebtQTPLj4nFEjcyWdcCWAOnDGMweDog+o0pJ1ndy2W8cLr2qVOOoQzTHmzBs9HVpg69y1jatuSnoTbYBs5RLehl2i7ODoYkM5wcRypHBJSeIoqP82tmR79xE180+luzxpNrLLfqr3+j+ejyK3hs4adlA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4464:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;31:0vW4CC9+gVVM8YR/8pLsVh6IS9HMKTYQFVRplX4eD0W81p6BKEUgei/He+gjCDvvMzz9xlCmePbYVbC3flfXqi2e+h+dJVUumfzXEge6n5I6Yo+QvDw3RmvyrJYPOjl9L9fUS4fDfNo6kvE9xtgyqGAKgZ37/5hXfp6Y2qrLVCS+PRuR7Pg9PN5oVCb+e/46NORquT+nakvmfbpcn5yxL/Jt2PnnU1qhJ9Ft4OegI3U=;20:WzTPIdBRnoGJnTzT+9nc/tx0TrBOYl0jbp9o+V0alShg2wMChsqYOBk0Z5BiSj+cpdGhRcm8oebNmYUy4J1LQuXMeQmXhOYsiim27Kar1ibAxnK83R3d5q5O92Kh3KE/1Qj8XJNaNsp4XONjykRjhVRmhL6prj0rAPcyjJw9mfUb8q1n6FW3zRVbbXkXJdWA9XfrrozTXBVmVUofkHDvVKxUgnF5atBsrBF2UUFoT4gPNcdIARkzY07hDAGKx7dIIq/IHBtZd/J6d6CK/YcAlEpwEl0CDToy4yAylokka+vd9JJ5oK2xghDmSTBxLhy3gF9hQYPLGAY2bhpU/JfUkwSJNDbKxfXNdAYfib5wFfol7dfYQSPNBzRGXIpDyN4Q1panGVlz7tQIQdYnjQdHjTIR5279rSEZv0pzcUGZjU7io1AjllJiOpNoH9auQEuvkD0NLV2ZmrDpVrqo3MDKzeJVaugWzhCtUmrlzUMW30u706VIzwMWnY8R1Pa3rkXd
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4464F4BF78EBA2A6F8F4DB96C2F90@SN6PR02MB4464.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB4464;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4464;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;4:OiG0g/fV71Av979Pt8yye5SuUJNioDfHdivEj0yzXWLYZu+1+eUilcqehws6uFnrxBy7bw/Sq54osQhPX+AxB4CkVu12Zgo39l+ijGMDb0SJsUQvShjwFeyl++lHzVIbfUjYjpu9hqo92L6ZRJzT9OgNznyhHBRa8KqWfUvixCNTP3eqTHqtDchZcl+PG14yg2XC+aPiTZb5/YOM9jDdv/ZTg71fYDG0kzUpOyxdsedp2VzAEZCpUXlOOJ4xYnVnJudxMxQ7gXAeNBFu2hvKfnYccvHdVyhlYYkrCwkaNGzYXukda9t+DADo0B9axSra
X-Forefront-PRVS: 0830866D19
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4464;23:/6EqjlOSn23h3UAOumbCpDyRqpqoYVIfV1/zhJbjt?=
 =?us-ascii?Q?r6ZU0Ia+R0ymOV+N79yZlAyBte6G4weUXYN8YVtPuF/SeY2Y5io2MlW9qAR3?=
 =?us-ascii?Q?ieC9uze7lLERHKJ1yLtkTgf5TQ51rx+T6U5rx/0IbW6rqsCqyzigtyaFr+2S?=
 =?us-ascii?Q?pf6rSQpFsfRbVSFlm+rE4GZMDCSFGhfGAA6uJpbwZmvbkcpkGmlT/7vQ17GH?=
 =?us-ascii?Q?XTmllq4jCiXyr3QaEZc8ll3WN7/rqppTePQ8NxCvi8zEBFyzZBWfwDRJY07r?=
 =?us-ascii?Q?8cbf6ZA5x1s0PqH5EAKWnRtyML4BzmU0uovjIjee8d/MgW7euxa9I9nNZvLw?=
 =?us-ascii?Q?blByVsOI2RwVVuJsvVsnTaEWLBrycHpy8l2iy7JFRikEy6D2L/0UeEKnLava?=
 =?us-ascii?Q?y9d4JyeQ1Fn+sOEBzPaubIP1tEOVF3bc0tWbRf4/Z6tZ07sbV/cLtC7pwpSd?=
 =?us-ascii?Q?7JjF+N2z6EvvywFTUQDBWy+oSoa6RIOAsDyVu9K6yZ+6dhf5PXH0yaWLlQw+?=
 =?us-ascii?Q?tJHQSWY0fKV4aceFInV5ydHwNDq1jYBfshfZy2/dJ1SY3eam3DrpejyfL6wM?=
 =?us-ascii?Q?l+KJG/jTJA+nbevDx7ECR0hUYHYz+bi2Lx8xAWjDYGAPX2U3ufSWG50EA5xY?=
 =?us-ascii?Q?It9u8AUr2K+R2ROaBJkXWOQG7C+a3AUfkiGHS8aef0bnCXno5Mk5UxTMemUf?=
 =?us-ascii?Q?QOvnb/qiWg5+U1kAwUDP2uQJoa5lbNwWN1EtKoXYzDniGVwwGLXEPv9x4G5N?=
 =?us-ascii?Q?X2KwrrfK02oA+EVZjUEyksNFmPpglCIjKKKFTlA9rVpempMaG040QDLZ/9ID?=
 =?us-ascii?Q?wXGQi4ozLtvBsBXP2Tq3udBRRBn46vHiaFjiJambbpxSMPq98a4f2bMx73Jr?=
 =?us-ascii?Q?LnIEVMllB+mBMKJkkNPeu/4CdscHT5r1I6sPcGvK8oklJ9TCEU1pcJAZexug?=
 =?us-ascii?Q?r2qBLi67DVPwNaf1g5Fq83DXNie9XwP/5ZjqKnPrxPcwzzQm0Gc/awjEQFRz?=
 =?us-ascii?Q?hjkEQ/fai98cJGUbACuKZdNIasSq3TWurudBwmeTysVd3USkJqpTVW2TmWpA?=
 =?us-ascii?Q?V++wV1DyQXPalDpSaXOweAmR3pJLCCTP7oLKPFeufRnUNm+fldvPl5cO6j/W?=
 =?us-ascii?Q?2i6ARdUxip31TIe/kihxhl/sQxR0rlym51JB3W0AtjgELbk/QqJMqouGU4OQ?=
 =?us-ascii?Q?uTgIyLcxvDwl4oqy6LC159ys+Aw5DNyE9k46fWHYKun3t/cyeaD3/JhzA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: jaxfXj4gcRN0BhEKz0Nt7uasMsL+AX/W1ch7oc42hchA2g+PhW9DvPo+sEPwcQjdqEGclrYSS+GLqCn+C98Ldiuo5zpMvK7mWDyyT28QGr9vXzp8c1KGzaeLerqmnle3OIFwFD6RBb584UE3D7SqYBoPad9bp62bs2wJr5dbDXojaBLvFnKalC9L4oblvDdnmhsJNzTbLnwumHb0J61FfULSGzfoaKs6qNfNRZxmJcurFQCLxu6W11jPrrCuB2bCXuVYLHYnoqHPToIQ34FZ115yYRGyEcF0BAasoutNJcy16AG9UTZ5Bt5acaQ4KBM76NnDLh+9e3pldII5QAlDeOCoaMI44TTs0zR3PILUGEM=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4464;6:3krhSLgMAjUtoUNJRByKzg4mrE1ZK+PccdRoj/Zr1icmTAZD79zWV2k4T0lyOT07+WKlq6LJZxZQ7wAaa0/RQCjXGLH5gubtJsbN+Nc9lXMDgsTFuDU5p6v5lzbpeGtvSyTI9K+68O++Z2JiprkSHWN/zkhx21xvQh9XWoD5nWTO5Dgnt/CjG9BDY5Ow+NcZWG1t1OfJjGrNAw+GjSzB4QE2i8TfE9WO6c+/Ur1YPaEiQC03u6VqrUe0rEFzwKvVv2yB+yoWRBaFsD1fQM2ClfDnSiTPP79eZVTwlpm5QJa+y8h/1eDMPmuzyV3ihvCatDgo+P7UBXYYHfLfY6hwkwUBPVMo/Ja1TpUAbADhrH4GN56QIKtWBv9WPLKPv7kmwoi+yPd6qyGeXQnAby/AraxD6xRv/4a9t4j6fgwpteXFde5AP2k+eOTrzub7WhYIV568bHfUtOfRjvWq/259Fg==;5:inL49cBNuFY7/ddk/lJ+7Hj77BdDqXOCrLse1IhDaPz3DdygIObjiF0BBmlOMFbBb6g8Q8wKjoO5aXf/gGtkIyecFCbCpn/DiVRrv8zJ++evQBcM18CsKvQ4I6rgwpVAyBp4VjUbBzgdh4ffyxRFsVtHv/1v+CI8JyeVW8oALbw=;7:khGlYlpW2eDZj7+SXoUJvV86gGFWnskdMa1+0JdFNAw+tzaB+sRHJhG516TkDiCHNZe21CvTnYaWp5YAkqYvxJ0RErSUMVR5EVsRUImSBynYyOmD5qlb8LRv/PI6zJnjCSVh5cSJ8x9BK73KFSzOJJ5qaU8f9RwGpnqIM80LMVO9uRlgMtdJQj6BNEh63cyZy2R1g6dsNz0f+lOqzDqmdK4LP8YWjhyNLWdV1ppfAoL+CZLKslOBZk4x2jzMcZBT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 08:49:35.0062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b3aaba-d2e7-47f5-13bb-08d6359fcbab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch Adds fpga API's to support the Bitstream loading
by using firmware interface.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
		-None.

Changes for RFC-V2:
                -New Patch.

 drivers/firmware/xilinx/zynqmp.c     | 46 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  4 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 84b3fd2eca8b..38a1ab1be03b 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -428,6 +428,50 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_fpga_load - Perform the fpga load
+ * @address:	Address to write to
+ * @size:	pl bitstream size
+ * @flags:
+ *	BIT(0) - Bit-stream type.
+ *		 0 - Full Bit-stream.
+ *		 1 - Partial Bit-stream.
+ *
+ * This function provides access to pmufw. To transfer
+ * the required bitstream into PL.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_load(const u64 address, const u32 size,
+			       const u32 flags)
+{
+	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
+				   upper_32_bits(address), size, flags, NULL);
+}
+
+/**
+ * zynqmp_pm_fpga_get_status - Read value from PCAP status register
+ * @value: Value to read
+ *
+ * This function provides access to the xilfpga library to get
+ * the PCAP status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_fpga_get_status(u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.query_data = zynqmp_pm_query_data,
@@ -440,6 +484,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.fpga_load = zynqmp_pm_fpga_load,
+	.fpga_get_status = zynqmp_pm_fpga_get_status,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 015e130431e6..b24400ee630a 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,8 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_FPGA_LOAD = 22,
+	PM_FPGA_GET_STATUS,
 	PM_QUERY_DATA = 35,
 	PM_CLOCK_ENABLE,
 	PM_CLOCK_DISABLE,
@@ -89,6 +91,8 @@ struct zynqmp_pm_query_data {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
+	int (*fpga_get_status)(u32 *value);
 	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 	int (*clock_enable)(u32 clock_id);
 	int (*clock_disable)(u32 clock_id);
-- 
2.18.0

