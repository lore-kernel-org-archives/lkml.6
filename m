Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83400C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2734B20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0rbenGX7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2734B20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbeHPWZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:25:45 -0400
Received: from mail-sn1nam02on0057.outbound.protection.outlook.com ([104.47.36.57]:36000
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbeHPWZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xvIp/Jeg721Icx+a0+eTvA6fZ+J5HSKBu0nfw7NJPI=;
 b=0rbenGX7jjMcpU5+KfJ0VevzY2zpsfccD8cGFqP0RQsvTC2X3W0VlsIwGnt+IB7oQH98BUlWdnw2EnY5Aekxi7ostZiLFqZEJwQE+/VnkVzlwIDl98hY2tvvkTTn3HU4yFJOxnDsynVRHhbwMmuYNlxj1u7Yc2hjuvK9DuZn4N4=
Received: from BN6PR02CA0027.namprd02.prod.outlook.com (2603:10b6:404:5f::13)
 by CY4PR0201MB3508.namprd02.prod.outlook.com (2603:10b6:910:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Thu, 16 Aug
 2018 19:08:28 +0000
Received: from CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN6PR02CA0027.outlook.office365.com
 (2603:10b6:404:5f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.19 via Frontend
 Transport; Thu, 16 Aug 2018 19:08:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT044.mail.protection.outlook.com (10.152.75.137) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 19:08:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNdC-0005Z8-4d; Thu, 16 Aug 2018 12:08:26 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNd7-0004An-0L; Thu, 16 Aug 2018 12:08:21 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7GJ8Cut016986;
        Thu, 16 Aug 2018 12:08:13 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fqNcy-00049q-PM; Thu, 16 Aug 2018 12:08:12 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Date:   Thu, 16 Aug 2018 12:08:03 -0700
Message-ID: <1534446483-12156-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
References: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(6666003)(107886003)(50466002)(48376002)(4326008)(2906002)(110136005)(7416002)(81156014)(5660300001)(106002)(39060400002)(9786002)(36386004)(72206003)(478600001)(14444005)(54906003)(81166006)(8676002)(356003)(305945005)(36756003)(336012)(476003)(316002)(76176011)(106466001)(186003)(2616005)(77096007)(26005)(575784001)(126002)(2201001)(44832011)(426003)(51416003)(11346002)(47776003)(446003)(16586007)(63266004)(7696005)(8936002)(486006)(50226002)(107986001)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3508;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT044;1:kP+cD/hf3Oer5jVb+K420zEJ7EkqwCFG+Eig6mlsUkfReCN+ve4H/2QiyYVV7+r/mZStnzygIl8KLzbbXO2WLgYE3Yg7HEv0S8fpMgN2q4X6l/Eq2pSzsYF0F2weYmVX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24015a8d-997d-4766-c9a2-08d603aba5bc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR0201MB3508;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;3:AvWVB5l2s88iEXeTNnIjLcdRJ38wtzPO8WAWWMf6nlYnZWD3EG5Jryr8hoY2q+i/VLo+DArg07KW1niHi0FWBWwgYYWwSeLFj5Ja/pHknh4rxj27D4YG+nxK8THbxcUa8Winy4E/wlqAYFIDY05U56rYGADZIIt2EmKZGoWoPQoRn4qu2mctNpczJ20bvvmc1DWwhuKVEOTj+FZZ60fnvsSsLT7yb3m9pIlzvzkYNfAtppjrCgVrWa2ukC0Bs3ShJm0V3LfTE8P8PDqHRao0FlRwHDjfX6qFuo4+zcXkVr6qoWgyuCmOrVwhnr542IRU3pKMBAaryAKhv0plLLif14efWhPKij7nKpGySM6r8oU=;25:bF/8j+hzo4T4Zs3exfVLVl3vfucvHpWf5y1/5CuDU4XbC8d/z7hvvgo3CEWlVjmBftgje8BrBCnVfAJfXc/++Ymsi6H5mDgQvvqYBsJDayl5MQG2afi1Z4zUZge8KDLPOh2Ctt+otVpWrK8RGX7Mx0p3rXaKpflClx5QBpQpU5o3i4AjtqaVtBZtE5R+cass0cd1L2KMdk6vSZ7YrLkx8Uq17cJu/HpRqNgYCH5Rs1HPESosxMS5gptqxhlJe9n+IIObKjkpTYOU4bmjpfMCoijvKYkSnELxbg3SkGxlE2i2XVF3+PDMypWcet5XBsjCg8iD/3ZhtoLzvtUrvc9AMA==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3508:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;31:BKmrkRvw/Wy9LTxAaFFs4NVT7fB00be4tzWc1VsCFSeHT8EQZpHzibP0yqtFD++Bqc8BwzUd8OQNp121P+CBNXNXYpYQVKnezJlIheZd8tgH2EJXl5VHi4lQPE0dEf5Hg9YEhIrvddsQH9V1lStW7RjX1Hd3e7V/r3/nsTY6zpICkyzC4qnC8b1N8R179Cxgas8xLRq/E854fNFGTanvJhK5tdLmIn/+apnnjJXchzA=;20:2+r4nn+pG//0GsdIn+eRVjO6omcg6qeOLXBsOaiLDE486ORugUlyIhp+WEYc3x/GVmojjUx0xBjhodhRlIGLChz+nbteBcOueICIOTAGigy9J2YsLenY7qhZhSgaj9hFIJFyvnl5jQW4r/KdWWN4KIZnYEcNVb6yFCIqZU+Bh5MIpCOix24QAHzlbC7k51N6P4oIJXL0oqKmJrIrHL38r7Y3Kg4qSOJ8hmloRadIpmnEmrMpGDi4WUtYstNNDIx/ReBlKsQpdXogyfK4p71tvhiU1yY4MYe3wHIeQ5mvHd2ym3iiYMYZS9gk9JQYjT8Y3tDi1wH2B5a4jlOD+SGBoe1jFnlny0mvk6aiKH39tgRnTBlw0G3FIwELkoErUtZvHD3QIcqadP0yuWyVNhbfXvG7mAk0narfuJjHAxZD9o0U8rv6c1HGbPj8a9jHMRGhDo9oHGxEZkoPwzQN1rEFCunYsvdyWYrzZJYVUAnaZY3NIQ0Hxj9nTQLhv04DrOJ3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3508368F2874115DAE78D359B83E0@CY4PR0201MB3508.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:CY4PR0201MB3508;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3508;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;4:s0w0pipYw8zkNrFjMqmM9RQOKpnZJ+a1X+llgf+FPyT2p8zWAKbbmRG/zVje9K4pUpt7F0Gvum5LHq2t5xTw1CKLTQEGUqxkpg0PrBoP3bapizJpvg6yyPZBKjPfWgE65gRlOT9oXSSr4pkVpUu6iAFZa3+ZEKm7g64TgNhiaeI/QUUx1IbZejSZtTmkGmKEKWu7mkFVpl77ZlFd6MMmyEH/s+VSb/4ZJveD5DzYNC9MqwJkoMpHqXq72uillEHL++yrTDcCIxJ/Yo4XaBN/tk3tOzoeIW72TSyldSNgzsJ7qcpvbDgUzAcMKtJAPr/b
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3508;23:fc9SsFQ7IrFH3ioRPOWHAUhbZwF17G3CWtIrW10?=
 =?us-ascii?Q?k+FycIBTA9dzvQ053NVZOXiUZTLLI1kTimbPpsoKs07lE+S5GUSE2PEtBVMe?=
 =?us-ascii?Q?b52BlVk9Gz4h+lyxA9tdAiq37ZWc6kRXaYp2oIbes1y/aRoNYPb11wSPikM/?=
 =?us-ascii?Q?GSVA50Y68hUl1IIXO5xYgewIuCEa3dPpZpEQ4HhapYT3a0pt8MmuA+rZmAvf?=
 =?us-ascii?Q?hwHiUM+7up11SbGADG+sikWBnOFP9HhgchvL7dQzM7O/gXj4SPL/35CleutK?=
 =?us-ascii?Q?DWwtoWaah2jsJ5hT1BjoOWjCA9hjPxI6kMMlIs+NjCUBGU2FnLoHGbR716Sh?=
 =?us-ascii?Q?C+eHSsLMluE5lWjiowX6FcMi18iwwljdxO/sOcDky8rXXBZjtsk7WqRucmPq?=
 =?us-ascii?Q?zX2hIfb+KEGE44aSs6w/ssFIEg+niaesnl7U4+UvL1V5VlQ1nAYTKyE5EcLP?=
 =?us-ascii?Q?dvD7qOyceezjCxMsHS3poOyIxLLhNvtIVR81X20qfhPG6xdFCRi+1ygmhQA9?=
 =?us-ascii?Q?YoamIZVtHN1mVlrwidI2MNBcj9+mte4EteyEE8paHM2884nAXrJqR3EJLDZz?=
 =?us-ascii?Q?p0AbmCdI95BrcLBwnbXA6uKQIf8K08AmdK/iSX+YApthL997AdeCBDvF3vHa?=
 =?us-ascii?Q?njX5k+0Y39UrE+DVR7jT0MjIe/zvpauKHwmMe3WTJFkyriPUloWKPJBFZn2/?=
 =?us-ascii?Q?Z1qTDx4Nc8eP4z9oHCqtn9BRtmSZ+YzQKdlapH/DohiS/jj/POazaHzV4B0h?=
 =?us-ascii?Q?FMaGljSjj4dSuQgmEGyfVvS1B01mgOCQ1HfSebcoIWyaMDlgJ1bkpi5Oo+4+?=
 =?us-ascii?Q?wez657bBKhbJDhe9Mki0StZfDgnUFvbZHQeaBBA4H3Ww7RWxaYOBG6mSGkai?=
 =?us-ascii?Q?3kuxNgCvR4PIlDiJz5KXr8OFztwKVPRdhqAOrg1yeJPw1WzqymE9o4ZefFZR?=
 =?us-ascii?Q?sz0UN0aD93iMEdwwhy0nsHkPH/HURLXNiYt+uLM9Rcgn8Pq6KWLWIBu3npov?=
 =?us-ascii?Q?modckh9j/L/CTY+H88Z9bMFNrS4oe9LunWmPE1ymTIDHiK4Keni9mPlV1uPo?=
 =?us-ascii?Q?3QtEs5u+VmoLRJab6p0DmOT949RhaoG0PxTadtwNdihXHuAlc8DEgb38hjMg?=
 =?us-ascii?Q?gJuuMDXw1+7kryr6Ym+1B+C9jx2Z8Y0zpYlWbM529+79DCDDPrxX+DkKjRZm?=
 =?us-ascii?Q?v1Ym6aHYk5uXmJCDE+oFcTy3/MqMekFNA7gri4re9Gs+D6SHWH3T6aJbs1qE?=
 =?us-ascii?Q?ZFEm+R4wa8XjKifz/gL77Pq4se5LtGPIKkIESmXc3qLIawwB9GFc50vDc7WY?=
 =?us-ascii?Q?X60kFM2n/o38KzpruAtDHIG8D16QvT36XJSkU5XSZybhV?=
X-Microsoft-Antispam-Message-Info: TCPIywUw8i96T62LTI69xWfsJCErCE0+ADoH4bzMQsQMenCbB0lZFAcSmfyDE+x2AKkuxEr/VqCULhd07xqCDSg5JG/smtmtesle6ezdwW7Z8A1x9QmJbjek4l8dm0i5eMIZ5/AzSh3mVxoOCuQLC+kkzAr8CPMWs2axDLqnwu9H2bWgd4E8GDIkJ7mIpfrta9cigbDQgpdQLzml2UvsRr2N5OXW1RDcDlq7CXu3PpBcU2VWDDonyTXclYkIamdaxvRNIWWcRpJrd6GSfXD457m/xQT11TVKkrDeSJ2xzczUZYi5kfHuuwV2+HEAbO4fliwicz4JMsLyCI0iN1casFPvU2VsUpTuBkziEU27y3I=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3508;6:LZeTGiQ14ZYMF1kQWePCnTECSz73j52cUQtpXi08tCzidmw5In+6rMkc+RWlnY0PfhdKnKi0FnyldWmdF5cgfXvMsBdnkSvrWNcm7S4e4ffdJPHLU6mCOvMFYD8yt/YVfWsETPUMeg6wNS84P8dClsL3I+mqu/Y6CZqlMSFFFLZ0nmOTM9tzDC101uBdpG+vBLkTXZAZw0hBVjlJz9DYMNTX8snrEPst78hHRd2939UNQUQAikO+7TiFKAOXbtlKsAUhZJxfex7WgPKWYNcc7RMsnjDVnA4gYwVPycfkhXmdVSshitsbRWVHx6y+weD4Io1+jl0IojcCVc24XVB8cNnxNXx73yVbKXBjBXdcQCgHF9K2TnwtWfQhd+Y78XoDWyKPH5QFgu95Weh1KxSB8j6Cmd2KvR/TF1C4Vt2W7Mo3GE91ZRIHz1tUnBb/Uhr5ZzMSutqZSUTqjO/eVKISQw==;5:aDdpszDC6lRjBj8jT6ZknW90zKxARt0D7R0Y1d5vzCPaTQjCCSqmQvM3rlaY+dQ3Jtpcfgp2orq4Ee4WglIjYoE9wWMtpeoN02Gz6ZCPgSszZoWZrczSB7V9hUZqDOQEmh5zAFBx8jsfhQHaBingv2wFZ/znK7PsiiFWnyhtLBA=;7:vcLmolcL0excX6qXldY1NN6xYeKgoVVPkUmMANBY2rQaH1cAhK5VGSiXpHCtXxpFJBgiXQysi+VX7Lks7NRbSLUjTGY7bEaZi8XxJN2xVcGkNg5sD77d4exzHSmbtJHJqxxpsXtK6QImTq17gtp3jo/dQz1A0tbA+OsVoXBlDUqgVDNGvRT9vY7m0InJ4Mi6iwm7qFXN0RQ+W9NAbHUNwyPlIrBBgnepegbfLXspkCuHGusfYA3RHXf1lhq1VmA1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 19:08:26.6438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24015a8d-997d-4766-c9a2-08d603aba5bc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/soc/xilinx/Kconfig        |  11 ++
 drivers/soc/xilinx/Makefile       |   1 +
 drivers/soc/xilinx/zynqmp_power.c | 230 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 687c8f3..5025e0e 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -17,4 +17,15 @@ config XILINX_VCU
 	  To compile this driver as a module, choose M here: the
 	  module will be called xlnx_vcu.
 
+config ZYNQMP_POWER
+	bool "Enable Xilinx Zynq MPSoC Power Management driver"
+	depends on PM && ARCH_ZYNQMP
+	default y
+	help
+	  Say yes to enable power management support for ZyqnMP SoC.
+	  This driver uses firmware driver as an interface for power
+	  management request to firmware. It registers isr to handle
+	  power management callbacks from firmware.
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index dee8fd5..428b9db 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_XILINX_VCU)	+= xlnx_vcu.o
+obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
new file mode 100644
index 0000000..9071948
--- /dev/null
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Zynq MPSoC Power Management
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Davorin Mista <davorin.mista@aggios.com>
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajan.vaja@xilinx.com>
+ */
+
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/suspend.h>
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * struct zynqmp_pm_work_struct - Wrapper for struct work_struct
+ * @callback_work:	Work structure
+ * @args:		Callback arguments
+ */
+struct zynqmp_pm_work_struct {
+	struct work_struct callback_work;
+	u32 args[CB_ARG_CNT];
+};
+
+static struct zynqmp_pm_work_struct *zynqmp_pm_init_suspend_work;
+
+enum pm_suspend_mode {
+	PM_SUSPEND_MODE_FIRST = 0,
+	PM_SUSPEND_MODE_STD = PM_SUSPEND_MODE_FIRST,
+	PM_SUSPEND_MODE_POWER_OFF,
+};
+
+#define PM_SUSPEND_MODE_FIRST	PM_SUSPEND_MODE_STD
+
+static const char *const suspend_modes[] = {
+	[PM_SUSPEND_MODE_STD] = "standard",
+	[PM_SUSPEND_MODE_POWER_OFF] = "power-off",
+};
+
+static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
+
+enum pm_api_cb_id {
+	PM_INIT_SUSPEND_CB = 30,
+	PM_ACKNOWLEDGE_CB,
+	PM_NOTIFY_CB,
+};
+
+static void zynqmp_pm_get_callback_data(u32 *buf)
+{
+	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
+}
+
+static irqreturn_t zynqmp_pm_isr(int irq, void *data)
+{
+	u32 payload[CB_PAYLOAD_SIZE];
+
+	zynqmp_pm_get_callback_data(payload);
+
+	/* First element is callback API ID, others are callback arguments */
+	if (payload[0] == PM_INIT_SUSPEND_CB) {
+		if (work_pending(&zynqmp_pm_init_suspend_work->callback_work))
+			goto done;
+
+		/* Copy callback arguments into work's structure */
+		memcpy(zynqmp_pm_init_suspend_work->args, &payload[1],
+		       sizeof(zynqmp_pm_init_suspend_work->args));
+
+		queue_work(system_unbound_wq,
+			   &zynqmp_pm_init_suspend_work->callback_work);
+	}
+
+done:
+	return IRQ_HANDLED;
+}
+
+/**
+ * zynqmp_pm_init_suspend_work_fn() - Initialize suspend
+ * @work:	Pointer to work_struct
+ *
+ * Bottom-half of PM callback IRQ handler.
+ */
+static void zynqmp_pm_init_suspend_work_fn(struct work_struct *work)
+{
+	struct zynqmp_pm_work_struct *pm_work =
+		container_of(work, struct zynqmp_pm_work_struct, callback_work);
+
+	if (pm_work->args[0] == ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN) {
+		orderly_poweroff(true);
+	} else if (pm_work->args[0] ==
+		   ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST) {
+		pm_suspend(PM_SUSPEND_MEM);
+	} else {
+		pr_err("%s Unsupported InitSuspendCb reason code %d.\n",
+		       __func__, pm_work->args[0]);
+	}
+}
+
+static ssize_t suspend_mode_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	char *s = buf;
+	int md;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md]) {
+			if (md == suspend_mode)
+				s += sprintf(s, "[%s] ", suspend_modes[md]);
+			else
+				s += sprintf(s, "%s ", suspend_modes[md]);
+		}
+
+	/* Convert last space to newline */
+	if (s != buf)
+		*(s - 1) = '\n';
+	return (s - buf);
+}
+
+static ssize_t suspend_mode_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int md, ret = -EINVAL;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->set_suspend_mode)
+		return ret;
+
+	for (md = PM_SUSPEND_MODE_FIRST; md < ARRAY_SIZE(suspend_modes); md++)
+		if (suspend_modes[md] &&
+		    sysfs_streq(suspend_modes[md], buf)) {
+			ret = 0;
+			break;
+		}
+
+	if (!ret && md != suspend_mode) {
+		ret = eemi_ops->set_suspend_mode(md);
+		if (likely(!ret))
+			suspend_mode = md;
+	}
+
+	return ret ? ret : count;
+}
+
+static DEVICE_ATTR_RW(suspend_mode);
+
+/**
+ * zynqmp_pm_sysfs_init() - Initialize PM driver sysfs interface
+ * @dev:	Pointer to device structure
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+static int zynqmp_pm_sysfs_init(struct device *dev)
+{
+	return sysfs_create_file(&dev->kobj, &dev_attr_suspend_mode.attr);
+}
+
+/**
+ * zynqmp_pm_probe() - Probe existence of the PMU Firmware
+ *		       and initialize debugfs interface
+ *
+ * @pdev:	Pointer to the platform_device structure
+ *
+ * Return: Returns 0 on success, negative error code otherwise
+ */
+static int zynqmp_pm_probe(struct platform_device *pdev)
+{
+	int ret, irq;
+	u32 pm_api_version;
+
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_api_version || !eemi_ops->init_finalize)
+		return -ENXIO;
+
+	eemi_ops->init_finalize();
+	eemi_ops->get_api_version(&pm_api_version);
+
+	/* Check PM API version number */
+	if (pm_api_version < ZYNQMP_PM_VERSION)
+		return -ENODEV;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -ENXIO;
+
+	ret = devm_request_irq(&pdev->dev, irq, zynqmp_pm_isr, IRQF_SHARED,
+			       dev_name(&pdev->dev), pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "request_irq '%d' failed with %d\n",
+			irq, ret);
+		return ret;
+	}
+
+	zynqmp_pm_init_suspend_work =
+		devm_kzalloc(&pdev->dev, sizeof(struct zynqmp_pm_work_struct),
+			     GFP_KERNEL);
+	if (!zynqmp_pm_init_suspend_work)
+		return -ENOMEM;
+
+	INIT_WORK(&zynqmp_pm_init_suspend_work->callback_work,
+		  zynqmp_pm_init_suspend_work_fn);
+
+	ret = zynqmp_pm_sysfs_init(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to initialize sysfs interface\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct of_device_id pm_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-power", },
+	{ /* end of table */ },
+};
+MODULE_DEVICE_TABLE(of, pm_of_match);
+
+static struct platform_driver zynqmp_pm_platform_driver = {
+	.probe = zynqmp_pm_probe,
+	.driver = {
+		.name = "zynqmp_power",
+		.of_match_table = pm_of_match,
+	},
+};
+module_platform_driver(zynqmp_pm_platform_driver);
-- 
2.7.4

