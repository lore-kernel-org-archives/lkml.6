Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C0ECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06757206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="m3MT0DHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06757206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeIOTuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 15:50:01 -0400
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:4224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728089AbeIOTuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 15:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR4ZtAMKW5HOR64i5BnkqO7WlwIfsS6Q8T3WMRxy9ws=;
 b=m3MT0DHOKy68KjjfCTebrZ5Y+8n1a9XZxtsmFBz75/9zE5+k3M14zPP8J3GEOJaSLWze+h37xb4bTnv08sz0gxoOblFjHf2KEek/b6G10F8q/WKF3FE02OdwSQZIy7ES5ZOwV8EBED6IQI6E61zJBXf1aJfUQ+x2lLGAEl55AB0=
Received: from MWHPR0201CA0064.namprd02.prod.outlook.com
 (2603:10b6:301:73::41) by SN6PR02MB5120.namprd02.prod.outlook.com
 (2603:10b6:805:68::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.14; Sat, 15 Sep
 2018 14:30:42 +0000
Received: from SN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR0201CA0064.outlook.office365.com
 (2603:10b6:301:73::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Sat, 15 Sep 2018 14:30:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT022.mail.protection.outlook.com (10.152.72.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Sat, 15 Sep 2018 14:30:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Baq-0003U6-OO; Sat, 15 Sep 2018 07:30:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bal-0004sf-Kx; Sat, 15 Sep 2018 07:30:35 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8FEUOGS031555;
        Sat, 15 Sep 2018 07:30:24 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g1BaZ-0004qJ-Vc; Sat, 15 Sep 2018 07:30:24 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 9C1F9604AD; Sat, 15 Sep 2018 20:00:23 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <apandey@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v5 7/8] usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl fields
Date:   Sat, 15 Sep 2018 20:00:00 +0530
Message-ID: <1537021801-23896-8-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(2980300002)(438002)(199004)(189003)(6666003)(81156014)(47776003)(305945005)(5660300001)(42186006)(106002)(336012)(16586007)(316002)(51416003)(356003)(8936002)(4326008)(103686004)(106466001)(81166006)(126002)(2616005)(110136005)(39060400002)(50226002)(54906003)(11346002)(8676002)(426003)(6266002)(446003)(76176011)(486006)(476003)(63266004)(107886003)(478600001)(186003)(48376002)(50466002)(36756003)(14444005)(36386004)(26005)(90966002)(2906002)(52956003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5120;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT022;1:wFHuneXmt4kNbpeteXPIzl9g5ubpRs9wRrSK+bZttOBvzioAWILD7RxdB19qmPQ2aHm3mtEbB5pgOp+9pfO0Ku2aHeOs2WQ+AQUWo4EOiv3TOh7e2AvX0H+YqctKdq29
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 364d41ed-52c2-42df-e2a4-08d61b17d068
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB5120;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5120;3:+BYK2ntAaJV9YFnNeYOhF2rHK6SPDqaifBp8lZEpwckYquZiuH893jI5MDJnx00KS2yIezS7b9u3zo0286gTarVvKHq8uiWeVyreiy7rI+Ka3gsmCfeEhaTCIRtwlNOzl6lCOeL8bkCoVz6V8Jl655JgmxNsnjg4XvmcKHnMxl89VBaE/JEitjGcxFH7iIBrtuq2ayMa1yT+wHAlg67stdzMjitoTWUnwD6nGH0imzl57PDbLRoCA4zCBg40XraWNu6ebEpH8y/aOMKurMerbCWn4Z2uWT3xL4tiUQ7AkrSkFZZkVoFNdSLvVsOj3W87xcrb0R1l6Ikwh5KsXYx1cMcClLJxOVQK3SiTiWCUnus=;25:X6yMPBEWy8u03deucFsF8PYCarUO0ZpbqOfNNLwFpVzyAT6+GTlpws7pQ7u+8lKf6mdG85kF7fRcDf/0WWJ/iFaGHJP3sUGBN8Uj2RsAOFdsUX4hi2AaAY0ka/I8JL4p7L7P0qUgRoVlL1A39jHofckOlkmi4MZLevqqzQJKCsblKhzmRHy6KJDISpDuPUhDMzStp7fyts9JrnQ3f0h7qV7cYPKS1vGqse05XIuhgO1GSbgHjGOWBfzwglyKZ3UQeO990hLvqndff2B2BLTrPONqTklHR8O+H+0KxaG2uKwYngM6SA0HrNJorqp2frRHr1QndGURY8S5YovF6q/q5g==
X-MS-TrafficTypeDiagnostic: SN6PR02MB5120:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5120;31:XV/3ET52kuGPXW6vipXaFIBpxazka1k9KTYBSmAs+mQIn1lt3IR6Vuu6O0xnkJnKwjcpsxiYwiMop007x27cjW5ThyBTdAHL5VYU6iaubHBW8dsoL12nJSbQI1ZN7QwrofRG1NwexPtBJKul0jMR0G8VNa20t2F5ZLs/pyCVWzUs3860aH9PTK/yXu1POJtptwiLjz5+fJD4IcfoyfLOO/pUu5coNs6yN0aMZv3FlFE=;20:B7dyp7MKH/3tJ4l2he0pPWiEKwArU6HY3+Tdrjc1SeZ0nRpHzvhi4DaKQ7zrN2Zj0mnHN7owlM3/GBdxkLlp9i1ovhvm0ntqNVXjP+wpuLTjnMplh1pCj2J7SmEC8LP1HbdOzUEcWUk00tuUXoJnph4YQ20Xl0S2liJwvzb/rwFo/3v4sBpSF7Z3h7qRzFE2yTKVC0/6Lj1RLRyqprMpCKZ1QpiI9iuo2HcaSOELxAxnruD0uGxUqMciuv7+34k9G/qu6yiBIkB60qrigrUk3QzI7EZmZGwZkBBIki2piEoFqCNvGxGazDI5yDJJIn+vBvX9+CUfYWud85t/XEekDUIPPpR7YM60u5ICk9CMIl2gbPFw77Sdf98rwktrFZvpPD4UkzAwdrh4Gn1Pu2B0rCssDrRTo+VOUqh5bBCqjNfCMUIR6KlmYg53qC0e6N9KMEePppQSUayb2XYnUSM9pPAtxeXGlWzIYp3JsW0hS9P5duvkBOi6vgiaUOBsWXcn
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB51201AD081B7386088B7935BA7180@SN6PR02MB5120.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:SN6PR02MB5120;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5120;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5120;4:ckrfPdxZ15e+k5b9idEct6DRK4VqpCnee2rJQpVYs0Rn6OQ1ufDa7iWRSbaL68WuBE8bt6IEXmBZR9MWPN/HnSXchnvyeLkZ0QGNLTQKK6CxqSVNUdarmSKqHCr9GJN1FSVmrjmyaTqeBdIBLTSPmz15mesC/+GwfOF0P2O5BTF9qTqoCmqTQsVrQVTLYMJ9mdFqn1wxoXUy6mrfiDyc96eOqxJdZPh3Ey8MyupKMgB9zxfMCivOznV+3JYz0EYvJrSCkgFbmR6tRX3WFIT8BfHSyDqMLUUFLFyV5RHONe4jAVNtTOUkZpnY+erDFh2e
X-Forefront-PRVS: 0796EBEDE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB5120;23:ZRULma1fAvb4HengUYDiPyaXoPIAYDb57TToxXAmd?=
 =?us-ascii?Q?va/x1h6iImbTdELTbzMgPzbHdn6gpvSh+D+PUUkm+SIHXGj6uyW7/n+Jv3b2?=
 =?us-ascii?Q?EeEJrCkTntpxUT1Xb9LT89GNlv9QPHuKYtBTVaLeuWnIXdZmfLe1uPfCIpUR?=
 =?us-ascii?Q?kaCyI+5yJO2BAqhJjBtbCOsUcN5iWZ1TFsx/vHNVwKRweo3s0Nr7zmEm+7cV?=
 =?us-ascii?Q?gk4ZRBl2mZ+Y0dOlfm5eIgha/5H2sd4sbnC5pVV2jSPcSY+xCVNp7O8EFLDC?=
 =?us-ascii?Q?oQmAN7FKP/4WlVZUC9U4L28cMXYnF8tbkMQE0t7d2j/Kvqh3HK8m1Pg5jyHJ?=
 =?us-ascii?Q?uyfzf9MUCN1DStSRyWgXpsGJbqo05BCuu8UVsU9g60re0HWsmFrcoDAvWOP/?=
 =?us-ascii?Q?Vqt93hdpt3Sr03baJdWULDE6KkQQrNeYuG3zlv10l/nzFBbbWzkrfnpuzBB2?=
 =?us-ascii?Q?tynowIMANYU+y5R1ypXQYloJ/TDeaEirrI3Nh1hNNirCZUW12l5x20niaQ/P?=
 =?us-ascii?Q?dv1nhpH7ZeK6YAA4OUrVeWWFCSTCwzT2ypBw2ISUYHVmP/fcPydps2FtSQXH?=
 =?us-ascii?Q?gEWxza8dZKhk1WD/5UPEzDD8dXfQm71du+XWQxVq1N7fSV3u05NmnDPkZE+f?=
 =?us-ascii?Q?hRi/xISDlIr4e6cCqB3+U/CkT12oa3b+xjZUtkT/OZYIzeCeBDO2uUh/q/z2?=
 =?us-ascii?Q?nHoEqq0vDo0F/k06ycBbRQdf2FHPhpDrb+22IxypQZmQ/hyTuefHkaahpopB?=
 =?us-ascii?Q?+nXtCIf3V9x/6B3n807XA9NTt4O/JQfKqNJygrH9Ap9bSlYa3fs4klgloksC?=
 =?us-ascii?Q?RDKKF+nSTdc7t7b86xcuLE5yycVsFIj9aaL3uAYcnfOqzdr2P8EqTn20U753?=
 =?us-ascii?Q?boTRDkvcaKSYHKV3CWRJyNmLhtdAvte3ln/aeQBbWIakJgcYgFJ5qs2cNLww?=
 =?us-ascii?Q?eJCqOPubN+5tiDgeL2bpIOLOgjiQOFwOjJNiT01+hoUEjP5ROR3Vw0y0kPjq?=
 =?us-ascii?Q?RuMCO/Bwxd4+yczB6yZefPBWmu1KUyWeHF5ob4v8IwjnX3ptIRrIvltQ1Slg?=
 =?us-ascii?Q?hIlBCEcU5G8FQtFMV80FNWp9nhnW2fcXOxxtq9TC25qKPv5h+bCpluGwN7bd?=
 =?us-ascii?Q?iftpZJLONo7d9IJCx4MjclIqPmrSaUcu216xsvQEfPXkiNgE3n1h6iZQycXH?=
 =?us-ascii?Q?y9JUF5zdqbG5+h94v9n69PbkbHn9HS1KuLn?=
X-Microsoft-Antispam-Message-Info: x8zgO/B9DdIy2smIo14dwxZOEDfBxIT4jRIHnkb/fZZ3sFofTnUxelbOPFAJK9IqEaC6fEAuaDqo3P5m/11aHbeWDWmp4o/UT3yfLWpB1HpxpXCyhJueLClOftVHUUNtHtfBuoZESy3iawDQXdmZsanSF4DjsQEqr4gyi9/V0FYXoRiHJdGkldVvvt9DvoDcp/4+VGV0MSiFw4fiMjns9UyjgqhtfHBE7mCkpCRKiXzGQLm8Avt48ku0UIKaA4uBz9D47qtxUruEdNFh727Uv0ifOGUoAaBrlgOChPucP+SIDHiBOA5uxpz40mqDorklTAZpgqwoUcI1LBeGQIf3bYnqeRQv41WbHgpOFSg2Dck=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5120;6:t5OeQu7qeIe/iNBjyEIDbD3kjmzVnnsPTPtPtYR+ph3Jzh2IxwxRniH6m4EBtb9drIWGt3+G9gh+sN54tl7A+ehWuxxFkTVTdlgcChO8PClv4b+JwWe85ajf9684MQg3Y/bNnTZ5qV6PkCq/tG74/5u5LVUN2HJFJq3t5yNyT1kcIcrYL7C9tXFYXKbBLZXJhRALX3Jncg2A3uaoGZl8xAnncfmlQCd4pKIENrsFCxmQdlAlQh1Xh+KEVS7pO3EV0wi8TIXAUGWB8+6bubBZEf6I0ukn2Nn8VvnhzG/wEUOBXlc6yHqmiqfShIgeRet6ZkFs7N5aLoMvQPtrERIglCBGbifYNMHbOEsoQ5Zyhb8HRNmbkTOOZAXyh9jHO9eUUSi2fQ3UXMyAt0boKNlB8x/36S3tLljyBGtnyFS/s4qyYpAqbiZNLikwHVN8qPhmsttZJdH2nuPpsan9WX0GPQ==;5:Td1/5vYADaNQhK2Z8qPHjIqb5mE1HtgxADUW8MNlG2Tlbci8W8pwvnMcIHi+0YVwGozWdZAmJdndllT5rwBTHi4MFyAgFW/aVPQ/THjqMRdLO5ZwBjgCjQpkkISWdM9FezSkAouWvegzaKsFq+HZ30xoNW6nlZfaoWsJwQkeUCw=;7:HeVFk2Eqkm3Oi/YWVS0d9CoY2BDI5anBzynNNjekD7LFUoAemD9KvsrYJXssYBizPcuvr8Y2f+Duc1tpdkGAmjIB+FkkAdac9QO1wLXLihxSGgR4BQdyqSUGtN+N9izmUgBrOxtL8ytRIKzMC/xC00+IkMOCnPtUpGAGwEcQ6nfOKZC/hWWvuTS2GqRd0mtpPC6UN4fHyMo6vBkUR45hu0Jix3qJ9oB86t8PBkW/x0iPwH1eVrdDM+itf7EXUEsq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2018 14:30:41.1423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364d41ed-52c2-42df-e2a4-08d61b17d068
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The present code in dwc3_gadget_ep_reclaim_completed_trb() will check
for IOC/LST bit in the event->status and returns if IOC/LST bit is
set. This logic doesn't work if multiple TRBs are queued per
request and the IOC/LST bit is set on the last TRB of that request.
Consider an example where a queued request has multiple queued TRBs
and IOC/LST bit is set only for the last TRB. In this case, the Core
generates XferComplete/XferInProgress events only for the last TRB
(since IOC/LST are set only for the last TRB). As per the logic in
dwc3_gadget_ep_reclaim_completed_trb() event->status is checked for
IOC/LST bit and returns on the first TRB. This makes the remaining
TRBs left unhandled.
To aviod this, changed the code to check for IOC/LST bits in both
event->status & TRB->ctrl. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1cb7df9..872c956 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2299,7 +2299,12 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
+	if ((event->status & DEPEVT_STATUS_IOC) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_IOC))
+		return 1;
+
+	if ((event->status & DEPEVT_STATUS_LST) &&
+	    (trb->ctrl & DWC3_TRB_CTRL_LST))
 		return 1;
 
 	return 0;
-- 
2.1.1

