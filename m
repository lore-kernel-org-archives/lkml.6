Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6287AC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4EC20895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="V+bKPnLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4EC20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJMUwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:52:36 -0400
Received: from mail-eopbgr710053.outbound.protection.outlook.com ([40.107.71.53]:51429
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbeJMUwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQ7cMSEj0mU8CoxY+j5JS4MhJlWqCI3RHxHnEPqjzbY=;
 b=V+bKPnLr0ZMA8Amn3HEK5xcN5E1FFvw+9cw/TYvAoxWh/uy0WJ4OwJEd6E8IXMkC0wcK1sJM7L0CGnLRrOYxi9jfgBtUuIgKnS99vFIYbZOKmDtbegtPSQ9aGkHUVUESVxjnQlmR53Ng28tLKPZfeawA9qecMMXeoupjabiHOIk=
Received: from CY4PR02CA0014.namprd02.prod.outlook.com (2603:10b6:903:18::24)
 by BYAPR02MB4325.namprd02.prod.outlook.com (2603:10b6:a03:56::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Sat, 13 Oct
 2018 13:15:26 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by CY4PR02CA0014.outlook.office365.com
 (2603:10b6:903:18::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.24 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58104 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlI-0001Gj-8L; Sat, 13 Oct 2018 06:15:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlD-0007wb-2W; Sat, 13 Oct 2018 06:15:15 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF45P026366;
        Sat, 13 Oct 2018 06:15:04 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl1-0007nN-Qu; Sat, 13 Oct 2018 06:15:04 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id BB568604D5; Sat, 13 Oct 2018 18:45:01 +0530 (IST)
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
Subject: [PATCH V6 00/10] usb: dwc3: Fix broken BULK stream support to dwc3 gadget driver
Date:   Sat, 13 Oct 2018 18:44:47 +0530
Message-ID: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(438002)(189003)(199004)(476003)(39060400002)(81156014)(26005)(48376002)(186003)(5660300001)(6666004)(356004)(8676002)(336012)(52956003)(36386004)(106002)(316002)(47776003)(42186006)(486006)(110136005)(51416003)(126002)(16586007)(426003)(4326008)(81166006)(90966002)(50466002)(305945005)(50226002)(54906003)(14444005)(2906002)(8936002)(2616005)(478600001)(106466001)(36756003)(63266004)(107886003)(103686004)(7416002)(6266002)(2171002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4325;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT011;1:YIPC82+MIKLhsJ7/8QXxbvPfL+z6iyDbcWzhnysRUVOHjseUnn+uR4cdgNd3jqRAYY2SThmHxSAx7BK5plJ2+mQekZ/pqryXoJtJtgBha8Zpo5l5GwdLepnCnfW9Q4k5
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bb4911c-92ad-4371-a8a3-08d6310df045
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4325;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;3:iHT7TmbcRUKmmartzLV84fGMB/5+QID4LsJc9hsrz88A+G35uOHYp5otUUzZQJZYXn8t6vvPmHGb1vfm7DpSTkSDn4BYggT7R9unKXchhtvdbtp7Lp0ZMB4USR3BNCPaErmp51hOUGmXlFTYkuPzegXD/OKvuZLBXovv59Iz23jL5DP8YpEhrU9w5YxrzE85vFbXnWnVjiGkvHuG+bL0tXUF+3RuRF0YpkIjMWOlw15bhoGXMuCsAO85awx5MPiQk6MUiHHY5u0QhEAF9E0m1SoOV3wvfGx67EM85Mffk3YR3zYhsssH7kqOOjNZaYKp7vpN52h9eArFgmDsMDfgV7fKOY8B2PlaF+/jUzRnAXw=;25:/k55KtAXUprwKWOZQV7aW1omPBDo0+ZkX26+s5PNMQozTATu/uQKjyJGjXaeRcImJBTcBse6EDfwcDxKozoqGvIiPZrQAOSg4Tw2idDxKybk6uGwYCtvhc35q9f2PLqJpZB9pPX+DyXexVDfNUb2OCmy+59ZOfm+K6J5Cgxy7ukS74/UV7jR0fdk1YW710Dh2w12CnZX0HuqMPuQNpeYAZ7MjFltSra4m/sPKjEfJEKFLMLqASK1dpQgX5V3/ETVNCTUqsQfJqobcW6dGq/HB8SpQIT74YCsIRQAvfGOHyvuid1nRg/H9DyVzjdxAs89YcfSHpgUDfrb1+QZGW18/A==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4325:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;31:EAZ9wpTj/BrY4poqVbjPxxt6xTUIJomfD6vSYQXAwPD5spcoKr95i68ooSgi8iY/iYFyP+5wJS31LgvI3fn54FS2bqQeWgr4at07Z2hKJo8dg0/oJbU7a54f+LPYY+6mGaWKOWAWmerGXjkjFC2C3NoJS6J0v9+BANSNkClz3HQXA7eExYhXHVUZry9n8VUKu716tAg3eHey9lxE0TA60RnI95MJtotuWjCB6cjemms=;20:JI1rjNY0GEoEoj4L70mnFGg/2tXGUIdG8+Mlnzpca6xmcgVHB+AWNxXjKsL5WYJbkHAeLhibFHHzH9R2mZGet1fRPrYLD+gso5aAFc2H72+ZJVSXFv0onklJVeA5+pniXqYS7p+bfer7dhBtftjcBRkhQUzQhc3pjrLfeerL4Vib9lZbb1v/Lrg/+HDttXxKj8L5icR45AZONf8kD8f1GhLqLTIOA8fE++JzvP+uxhJ0CWkkL0vQmD//6MK57sVR0fqQBU1lOwiFI54ckwis/hMyHKrwzeC0dF9pFeWoO7c5i18DqXtkdxBqBdvkI69em9PsvFMC/576wI+/PursP3JK9dUc7HSETup3fsgRi5BVwOJM2gx4Iz57V9rr3E+ifIUsv/zg8l00IcLUbvenK2PNdBYzxr+PNXGTz+kCk9qYY/IN5BOq08HUmwEp6K+x3+n3dX/jZANCgyybrTZVQoYwx08x9ipj5s21DFp5137Vrs+Kg5m0StOHneq+qt5Y
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4325C025599967A041309D74A7E30@BYAPR02MB4325.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:BYAPR02MB4325;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4325;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;4:Cym3LGpKEF0MOIR8rf0X8ykhTzEPOUERTMkRPHLU+Z529haj+p5WuhLHKlRM4ZOhHAbCkMOZDNlykrVZ7cgmbrT/NFkL+buFDREBNArtSHzUfKQLj/q41Ebbnec3H238HAFExB3X/8f1fuR8n9eabMD5w5GitMOjbTYwGhgIz2bzxgNJnDZ5tDv04ptUyx6oAiju5piT7fBPr9/XnTWusu7+fBxysWh1OzyegObVU75gIXlmZuwExl5gzOUEE7XY9k4hiwTqxv0obARkLmOfwg==
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4325;23:GkgqiMKnjJCctGHImDom08DgFmqoxZwt5YfVNu7Hd?=
 =?us-ascii?Q?yZwkjym7uUYZ2AwpO2OX+1CofJLOHSr71iDmpI7snxMDrgTgbbDdP+XS+VTO?=
 =?us-ascii?Q?jJ+pHSYeufaUuodVuQUiu+PPMjmjzKzwS31mhkuVVhHz3GApsmwjOjOqlwmg?=
 =?us-ascii?Q?I4gh2DRLXT/vYPfqAto2owAulP6hsYKT4puA2R618CYRk9LnTQWZUtCK18aq?=
 =?us-ascii?Q?iP7fwcafZtY5j/qlWyyfke2QDKfv/+g078qU3YKhXViMneMRh/yjbWvEMrZf?=
 =?us-ascii?Q?RxoSJxSCupMawUfJ6JDsRtMjgDGZ0w84YRYWohZalWaDweq8ZKb0Mq9T1RZN?=
 =?us-ascii?Q?a4gckd55hmBs2V2IJadhE4/cvTw6v4Oc+LFhUTLqLPVSAGosfEAw1S9qBbyw?=
 =?us-ascii?Q?BcHLA2tcYruEDcgsUIz9USMBk2vzlECbuX09DcGVsEmOQKo2kzrWlw8P53Xk?=
 =?us-ascii?Q?0anuHa4hQMPRW8woCOwCDkpuuzz1X/ESNjiEPcp8RKR0h/xzpTfDVlLU1W6E?=
 =?us-ascii?Q?ZCK8An6Kp3u9/EOM5fB0HEeHYM9rCEnU7Ivwhg4SCbHCRGsJKsO6ICxU8p58?=
 =?us-ascii?Q?tpjPMidNN5ABw/leynax4vM6qUFWNZOuhoj4334OQOcC2pEGpvzzQqo5TvYg?=
 =?us-ascii?Q?Aq1fJg2CFAUmDJOGt4UDfrWFC4WplSCfMcqkGKLWlx0sDZxAfE3/FYGuImhY?=
 =?us-ascii?Q?1JBcJtrePg92mKF2y6T7mJ1fXQzMNHhL09Qtz/EWEDRZVB6aVS3AsKbRweof?=
 =?us-ascii?Q?q8oVGZI5RdEQRyXU0eaZMNM/s83PHTtDzmVTBBE1Z9z2hbI8z24NBBCMN+sS?=
 =?us-ascii?Q?IWHQT2EB4NwvuCBXWuDKpkXgYl3jkQB611PGpIYGzhVyLeQX+8Wv2ttMKZRT?=
 =?us-ascii?Q?5jceJfR7JKUUq575xr7HYepZevHXh0xPQWjQz0m9jeQ9zToVyfAzaaK7opCO?=
 =?us-ascii?Q?b+paxoeITH/QRDPL3z7VnSKteKwnGW0Id7Lox6s5IUVYK+QjUBBA3y+56QgF?=
 =?us-ascii?Q?QqxO3MXLrEuR5PEokOvv7UQSSWKGdXAULlT73YcmDAlGRYal8OLujzjpspVw?=
 =?us-ascii?Q?Atfciy8+H67Dwtj2TUtQj7bj9DwG9fUiZYkA2bGoyQdK2ap4MpPeK9XUgdmq?=
 =?us-ascii?Q?+rNZgf8dTKMm3TvZTV/EgonxH+LB5OGCTLgM2vOgtzi1g7K8fzedqdS9PB2T?=
 =?us-ascii?Q?aSx38RXewBrnkNs3I4W4JU0HeUVXmi3G+a2?=
X-Microsoft-Antispam-Message-Info: wQ7f9wtqPceTzc04q8ig8/2z0xBR9SHxn9/9OHN2+QL5l0cPEUaIEDYU95yS3zQIDjlLZuRXzB9PLmGhjz3oX0ZsqtN1MH/1PL4teDCi61vL1Zw6bGlRBGboTprlqxtWphzXDOHdGajkZ6ZsIB2LlY2GKn43XdaJGUFkkuH7KW1umDVmUnLwdrndW/9nWkJvVpovfcPCcyyezG/pIZgeyVe7oxt75Y4tamgo1DTsO9fI581UgJDYf4+axkJnLEMEft6JIaxesgVz0I7mQGuP5PfT50vPc5SSFv3LwsZG3Vq4MmqfFsCKwFa11JVaZekbQC1YFt8fRSESgWkmRjJLt/LJn5XwTgk0V38fatqqovQ=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4325;6:UGWY8MO5BFeJ4UbUY3NNRfM9DV/bWcuSiyrRD7TNDrye1C3xlKO+yBDsembc/VOvRaJOspA0B4oOyW/2YFLVj/8g9T54YnMxK+TsSzoMz1NtwxLZ/4kDjKrKIea0bBXoZgDzqaV+Y+j1+TKoCzu8C9v9QXtLvcRMu+DJTZTC1snh+W+aK4+3NxNzGWQ1czhRtA9iLqFSr7S8qkWH7X7i8i6gQW1R3tvl2CQiEk4IBfIXj24Hh+iK+o6fvHxHSXBo/2IxPmd3ih+vrpOhh7EFGP7QWeilnnA7L1JJj8LoiVZcDPdCJHCBdC85uXt6xWw3pCkfmoj72r3dC6Qr1k5wAvzCSHT4egWxW71YS7gI37gneyXnBUc//gVbzFdDM0vzzxmvACX3kBIfq/VNqheOILbtrTGkVZYLLdiKrGxuU2x7SutDJLU6fEdcqGDAREQZS1W30Cu6jsZYSS+ygy88bw==;5:GW/PV3r/xBMA63zL23S/VED3V6EsyPYI9DhY/ryeM+xQFe0Vbor37Oivcrf8ZF9s0qGDY0KCunsq6r2KB7hjdqrFCE35PCPP7FUA5xNJJB2fWL3C9a6aH07S6ShrEJu6UzQingrAAmAxa+DxuRlNimVTDu9mc207taKk7UIfNjw=;7:1JZhpkW6aweZHDMlJHWDwORPJxxxRv9hNUO8vjE5eLJLDJV+ZMxvD/gBoKiC/QLtQc4WTKwjBA6LqE2wMmz/oZCrhSUMY40fCpcPh12Ovnrfcn+iCxsS3Bi02avPEMO/hm9+hwxxU5mn7ZPqqoXqz6kfNxFQ2IBRTcusvemSPU9LbSrGqX+XK5s3BvGMUqH5loMewZp/y0x9OnWxImCUNebMv0BLK0aQ2GCLzQ3YPGXKzWK1kvIQwF7ByWCUyMk4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:21.1030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb4911c-92ad-4371-a8a3-08d6310df045
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4325
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the broken BULK streaming support in
dwc3 gadget driver and also adds timer into udc/core.c to
avoid deadlock for the endpoints which are bulk stream capable.

Changes in v6:
	1. Added timer into udc/core.c for stream capable endpoint
	   as suggested by "Felipe Balbi"

Changes in v5:
	1. Removed the dev_dbg prints as suggested bt "Thinh Nguyen"

Changes in v4:
	1. Corrected the commit message and stream timeout description
	   as suggested by "Thinh Nguyen"

Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

Changes in v2:
	1. Added "usb: dwc3:" in subject heading

Anurag Kumar Vulisha (10):
  usb: gadget: udc: Add timer for stream capable endpoints
  usb: dwc3: gadget: Add stream timeout handler for avoiding deadlock
  usb: dwc3: gadget: Remove references to dep->stream_capable
  usb: dwc3: update stream id in depcmd
  usb: dwc3: make controller clear transfer resources after complete
  usb: dwc3: don't issue no-op trb for stream capable endpoints
  usb: dwc3: check for requests in started list for stream capable
    endpoints
  usb: dwc3: Correct the logic for checking TRB full in
    __dwc3_prepare_one_trb()
  usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl
    fields
  usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints

 drivers/usb/dwc3/core.h       |  2 --
 drivers/usb/dwc3/gadget.c     | 67 +++++++++++++++++++++++++++++++++-------
 drivers/usb/gadget/udc/core.c | 71 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/usb/gadget.h    | 12 ++++++++
 4 files changed, 138 insertions(+), 14 deletions(-)

-- 
2.1.1

