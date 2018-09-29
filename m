Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22203C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA652206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="D3cBB/zK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA652206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeI2Xrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:47:41 -0400
Received: from mail-bn3nam01on0049.outbound.protection.outlook.com ([104.47.33.49]:3712
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728412AbeI2Xrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0d9lixS6sDmmDK50e4d5xFSUlzOtfXf7O8ibMaXLUI=;
 b=D3cBB/zKB+ameQjuPU6fjxyDKMqNCbYDtnfo1ceyF15dAKHotIk0RG/mEjM2bVrdBal7aYZGOf/TACUrDBxK3WotZIJsZ6CVirNu6zmldjTiw3nnexTI8utRUWDlJUeMNarqPeP8hqb22/DoX+P0X+dwJ3v3UCCoYIYFbH3NgWw=
Received: from CY4PR02CA0035.namprd02.prod.outlook.com (2603:10b6:903:117::21)
 by BL0PR02MB4465.namprd02.prod.outlook.com (2603:10b6:208:4a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Sat, 29 Sep
 2018 17:18:25 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by CY4PR02CA0035.outlook.office365.com
 (2603:10b6:903:117::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.22 via Frontend
 Transport; Sat, 29 Sep 2018 17:18:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Sat, 29 Sep 2018 17:18:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40020 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1g6Isp-0001Aj-UN; Sat, 29 Sep 2018 10:18:23 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1g6Isk-0001eF-NK; Sat, 29 Sep 2018 10:18:18 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8THIHGo003733;
        Sat, 29 Sep 2018 10:18:17 -0700
Received: from [172.23.37.150] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1g6Isj-0001e0-E1; Sat, 29 Sep 2018 10:18:17 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 9D7D23C31FD; Sat, 29 Sep 2018 11:18:16 -0600 (MDT)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] dmaengine: xilinx_dma: Refactor axidma channel allocation
Date:   Sat, 29 Sep 2018 11:17:57 -0600
Message-ID: <1538241480-13844-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.537-7.0-31-1
X-imss-scan-details: No--4.537-7.0-31-1;No--4.537-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(346002)(376002)(136003)(396003)(2980300002)(438002)(199004)(189003)(186003)(26005)(2201001)(97736004)(52956003)(16586007)(110136005)(42186006)(47776003)(50466002)(4326008)(48376002)(54906003)(103686004)(106002)(316002)(476003)(11346002)(126002)(446003)(2616005)(336012)(486006)(426003)(478600001)(6666003)(5660300001)(8936002)(81166006)(8676002)(50226002)(63266004)(7049001)(356003)(36756003)(81156014)(106466001)(6266002)(305945005)(76176011)(53936002)(2906002)(90966002)(34290500001)(51416003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4465;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT056;1:dFyNchQExlK5q/PiL+khcFF/O2+JNJyHjLdHC9MB0z/FJmYp79CaMq/S1E15GlYBvo7nzOe/ctkk9WriSN5IlIRBsVAyac3GRA5I7x3j4PMDJO8rIIx6otyKTs4y3Kee
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6b095d4-12f3-412e-8d68-08d6262f905b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4465;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4465;3:gxIm8bH0WUPG/ABFnV1pTfbCtB2tO0psqKbE8oZU7xRzT+RdwaWo5phRZNJvCfYG1TgAYFwODRkJ8rJ7e5cx/QrnvZfgMaB++N37oAyPP9A81CZ/yOpRAfV/Zcg6xsIGa2eQnVLjzoxPucrSeGJdu3L/yF2JSAR7b+CjD6oSU8NNZZqU+l1VOx+lRCcrplMsNtCj2lEongsEvo/0V9idrT3t7KU9ZhW5UhUv9Uifz6SeKQRKuXWOrn5O701YnnOPGW92798GoKx3ETyLpqcvUxBPQJW/kfKOPYE8vuxVuvGHYESTzTe1s08B0i/Lx4/iwu6gfVYPRnZZyK/yFWdAuUjCzjI4qrFpLZ6qTZOHgvw=;25:UAPGh+f9fosGb5pbyhp21gNUQ4lYtUlPPyJfGE6y8UehL3+9Eyx51WI3hQ65daUu8xrJ+5wul82qiG1AfM/XiAlslwNKIJtWWu0gwnErArUf3n79smGKkbpCu19jauuXVh6TYTI5+J/ZvkX0DqVfwfCTtB/inJv81R9ZvIXRr1WmU9snpAAkkyNqgO86uTUd9yiXPkpuXH5MqUXLJQUBLPG6EhMJds13p3gumDonyBvr4jaCSxzh7tjZiTyPbbKQp/eh2Y6xj21Cg6fm32sW4h4M69zx8uWFX2mNDdz3NujOcR19x6zB4h/o31tY1PUoQNzMTvR7ga4W4ZvFja8XKQ==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4465:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4465;31:LUWKNf7PcjIiyQstCPrdsLJ/XhLEWFWOBtry0U2iAeEK1ynPofjqijPv2MnY4tjdofxqtBh1TRjmhWhbZOmnOAFw68IW8XWJzVUiWGLasBExVjEGbz78/bzlzzNTxQCNh1SqM3C8RWOYAKEAefT8zx4TW+OG6claQf5gZ2PJXCURtv/DT/tYzvQqxSIOC/adGoU6E6iCWKSaM85n/VgKIlFWYE3QZbd1MfIcmxU6v3Q=;20:ymaZ9EoN45W/RuT8pbAgMQJLjZEd8ehzpEXCRBB2MnvQ3Z7v1d5m/B4YKTUCwi+oJ0hDp1di6BMCf2LYKEmUPOUqZ+8KXf76QsFZ/BapbfPqvLPROKHz6TFi3+r5re78GwheYXwLgpQr9B/R+uGRLNcnOULmH+o8AKEawZRF7+9AKcr5/9wLRFZd0YujgvMKpGbELNFbzU1ZxTblziiBN1imxqIiavfHQ7Rt5+f0Rm77v6UEuC8ZRx1HOl2WUdFODfL+dUMUFFW4s1BzSkMRISgK/zHmXE1S0MlUS6Y8ZJ8EuI8XyixZBUH3AGhg/HZwdLUCpR/Pa2WojthqEVwJgSjolzec3I9oGIhCJEPLyKBFAgXzTkYjxNpyjj4zuBD4EUSpF+YtPdFCC0hE5bpJq7yKr2Cw5IK0SvuCtJiOHIUJCZUzmIf02wWj1h0OHfMs8uWk9wqTeEl5Lnenvc+PEVibP1O8oQPv4jqgF+CmdlAKXUn902g2ioIkT2beBxrm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4465D7D7B7AC9AF0A72B3EF6C7ED0@BL0PR02MB4465.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:BL0PR02MB4465;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4465;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4465;4:ZNb+oNGi8TpW6JHr1gA2CtKVATIIDDVgNXSLes7dtXZOevKWHrnIfU9H6QtfDQZ5y/BYZK9bzzs+bVy5OygsTwswyx7OCEshvCe70XUvRQ6JQ4NsfHIPwmK5/dbraj3L0YomSKrAkRhg5JVanwxJeefc6GI+H15shVeNSlGrLsPrinJCZFcK10b0t+qb+UqbFL4l1One8n2sIyY0jhZzjLkxRiEdHZQP7kIBwvMAYLyHwps8dQ9bUo8+jOVojYXWSNu7G1aael5dcprpGzOwvGhYEN+y4MqQU2+JUg5DoPuKbUR674VNuoAhpJKcGzU+
X-Forefront-PRVS: 0810818DA0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4465;23:FxbRyptw4yiVeUFb8nBYRKipolIJ8ZYa5yMmWHF5n?=
 =?us-ascii?Q?28em8l/s4BGhb4G20bpQA+U9ifMQCO9FN/fPk4xdeAygtH9q0GBns5kGn5UL?=
 =?us-ascii?Q?7BWtNayeuPxqf/KA4jUd546pGvCOLe6uIRzSmpjo4mrumqhjHUS9GR2eSZ3Z?=
 =?us-ascii?Q?kFWd0Aylzg/Ie5HB5HYl8rUhsHAv2LJrIdMv32brYGySQBB208RFpPXl458M?=
 =?us-ascii?Q?G1a3f2MSPRqCIGtmdBXxwEXD/DU2ra3MkPhXp4c9RCT8yVBC5WZSJc8xkNtP?=
 =?us-ascii?Q?+PBH6U8e6f5GEwAEyQ2/3dQXfoin3Af+jOnbH90ZfV0W8Txg0sXCaERvUHD0?=
 =?us-ascii?Q?RvgoCz1zgH57QZVtvweRMrU7/HmP6IbQx1UA/5xQcY86Uhzo7O5EYsPJdvhV?=
 =?us-ascii?Q?Z+lnyzJr9w3AU4vI8l23WLitl8RXS0+a99xHeurfwuy4gPYZtNgtZmp4Jbkm?=
 =?us-ascii?Q?szBKoz8fp1w8yUn5jCHJ3DKTy5Qeq/GOHewAUz4SCG9JL4RuPEYKumZwZuvX?=
 =?us-ascii?Q?/EWyNdwsz9fL+Xpy31HE2cR22uYZw0R8n3YoBSV0cqOvCir8loNbTFSL6awV?=
 =?us-ascii?Q?qy9k/W5tfBrMB7vA+NjltwPrGV56RBIIC21eqt0IjyvdFMHHpCsmLwVj7UV0?=
 =?us-ascii?Q?+AnQdS2VRsJNTR0JraJ9yeDyIjikR/I4syOMTNv574MIAVABcanyBfE80AdB?=
 =?us-ascii?Q?wZ8PRhugmc6eS8UtsMpApyrouzzcv1sodgJeGDwUp9FEXG8bG3BckYt3sfE6?=
 =?us-ascii?Q?FhegxbREk4rYpyh20Z9AitfV2+RctFi+O1gyZGKf+UoVh/knrtDZF1/7sUb2?=
 =?us-ascii?Q?lSgufvIA1lvLKPAANuUR3PMvq+9GIDXRbvJMLdQQvsUnoqLPGIgx2N6v0ocT?=
 =?us-ascii?Q?/ns6K3QNVx2MbHMhst9JxqhubnjAaFffEIyR8iKUOltzw6KqDLgYfaGdl6U9?=
 =?us-ascii?Q?ecXTZWr8TigYS97CWdR9cak2aGC0OFFM9Aiw1tO4OAqrFTgVGh5+qFwyWo5Y?=
 =?us-ascii?Q?m44/G9nzRBXXviTGHe0Zx/IY+94s84wRt/BWxCoI6WLWcjhRuBlXmTpfmaXJ?=
 =?us-ascii?Q?j5Ena2bG3r+CexG6v3sIOq42hSvwPJJZrmMuzBuZspJNIUMGaHIHrxqqA7Zd?=
 =?us-ascii?Q?UWEWFZkOXXpDyYm6MZ4rBOVuiVjVCp509c4DJqzrEN0FLlUAGjTifDmYrq7H?=
 =?us-ascii?Q?4ar8K7pfW//Crkxvto5DdzzZyuSvEcse5KF?=
X-Microsoft-Antispam-Message-Info: z02bc25ZFJcjw3Yp/jNBYeAodRy7TgMkV2ZSsJ2/2o5yNA9z3+xMVIrDRq4HHvgvUXQ/ZhXCUpRwg1/bjMuac1rgSxKhjBzI/2+i7BE+21PuaNgwQ/0c5lJV2/L3D4NP932AOsfdDQSWyxYrSYoVMpDt2aWf+gHPRmiLtcXjjZQIxKEgNg8BIVlLqkoD/ZNfuBXl4aybBmCAiIbCDiKGUajnq9ODvBvJAXuGPdeNGJVAnAjL1qklbIVJ9FV2Q6qXgwWdTc5TjFjlBoH7EddNMp+hw0Fmeuh6HLCTOwmTaD9KIDbP0KBo6RvZ/Y+UnZTtVrQNaowSYO3HBa8Uc/J9ls/RB7Rqkcgz95PKILFTii4=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4465;6:7bOs45cXG9fVnVyBG7T4PFSlJvUOZs7oIwCM9q4wegTuFmpZF5PMbQoF6SnLvM/Y3a+g8/z8mAwUO9DYeD3NYJZdwqF7fyXFj4WjX9r8YT6AmSMUxwrBPe6Byh7RKYVQjfD+N9Qeit8DKKvkKpCJ0N5/R3NKbxjPeP4SOv0qibx76IuEO66bJXJmvLAEmGinElBXJ+v0GPpQRev320KRiL4wgcGSojQsDOuSjn0sCLS6irKhVwAbhH3uTpdhil08zzBSJT80ZMAxJUgtHT6wjgcsL5gx9XlJtmZk4VCsijlooO7XIrKrzmUGTtu0Zgdb+3kEl75C6Fyq2TgRqr4Aelw5xPrPjO/lZRFv0BAVTOl3QEnaufObxbo4m3RVFycqJ0hII4maxdBlrdh5Yr6s1UHh9XQ9hvryPj+urcl54NyMJop+NfRgXWVX9K/ryU1PXvlrbB9JREEeQ4i4B/5uyA==;5:Npjnsb7A39wmy7ESRInWRUAb+cSjCs3K6ci4Bu1f7X/srU3blorM6aj661odvoeCkzaVMW/EwyKDZg5y/85uJ5lNM/K+Wh0yPojE69zoTcsrt24UYLSmZ4MmQYrWhBl3S1jye7VVTkGhSmZUshni+H7gi5Rh0IvZEfPiGElAL9I=;7:LL6g2+iMJ97OUjA9M1xyOWQ5ssVu4Cx3poZjUbKWMJReljckOwNTWBPgCw1ObpNfod/bouFBXs7WnzXLwpWuGLvndBIsXaJCqqnrrNTbSO4fOFR+RQMSMhQ5uVMt4c4mhDXCuEHSkOvLipge5umSzYztLFsAj9Sj/5/7wtZK+ZjNJca9jGx7KuXJzJM5Kyr02Sso2OfTpa26jm5mEw7UynOvH805T00pvvlyZ3Vgw+6ZmAu3N8bqwAh2XlCQewtr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2018 17:18:24.3303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b095d4-12f3-412e-8d68-08d6262f905b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In axidma alloc_chan_resources merge BD and cyclic BD allocation.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes for v2:
None
---
 drivers/dma/xilinx/xilinx_dma.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index c124423..06d1632 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -887,6 +887,24 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 				chan->id);
 			return -ENOMEM;
 		}
+		/*
+		 * For cyclic DMA mode we need to program the tail Descriptor
+		 * register with a value which is not a part of the BD chain
+		 * so allocating a desc segment during channel allocation for
+		 * programming tail descriptor.
+		 */
+		chan->cyclic_seg_v = dma_zalloc_coherent(chan->dev,
+					sizeof(*chan->cyclic_seg_v),
+					&chan->cyclic_seg_p, GFP_KERNEL);
+		if (!chan->cyclic_seg_v) {
+			dev_err(chan->dev,
+				"unable to allocate desc segment for cyclic DMA\n");
+			dma_free_coherent(chan->dev, sizeof(*chan->seg_v) *
+				XILINX_DMA_NUM_DESCS, chan->seg_v,
+				chan->seg_p);
+			return -ENOMEM;
+		}
+		chan->cyclic_seg_v->phys = chan->cyclic_seg_p;
 
 		for (i = 0; i < XILINX_DMA_NUM_DESCS; i++) {
 			chan->seg_v[i].hw.next_desc =
@@ -922,24 +940,6 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 		return -ENOMEM;
 	}
 
-	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-		/*
-		 * For cyclic DMA mode we need to program the tail Descriptor
-		 * register with a value which is not a part of the BD chain
-		 * so allocating a desc segment during channel allocation for
-		 * programming tail descriptor.
-		 */
-		chan->cyclic_seg_v = dma_zalloc_coherent(chan->dev,
-					sizeof(*chan->cyclic_seg_v),
-					&chan->cyclic_seg_p, GFP_KERNEL);
-		if (!chan->cyclic_seg_v) {
-			dev_err(chan->dev,
-				"unable to allocate desc segment for cyclic DMA\n");
-			return -ENOMEM;
-		}
-		chan->cyclic_seg_v->phys = chan->cyclic_seg_p;
-	}
-
 	dma_cookie_init(dchan);
 
 	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-- 
1.7.1

