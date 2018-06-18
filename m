Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7CBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8048A20883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="uTjXAH5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8048A20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937330AbeFSGA6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:00:58 -0400
Received: from mail-by2nam01on0053.outbound.protection.outlook.com ([104.47.34.53]:49431
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937104AbeFSGAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffd3eZVt9Xll/luLMgbKGF00JmC+hSAePszTXjMombE=;
 b=uTjXAH5CKmR+qa7AcXQdxbBfOP/mq5OirOFzjdcTYdYdi+ahSGId7j2ujkQMyMLbi0e51lQ+LPMq5RQh4oMfpmYcTN9sKlestjatHiCnJlS/iMOEDM/x1OkI4GWldwvk3j/aQuVskCR7L4Bxkn2+/tDYFS1jRECTLlgDI7HA3mk=
Received: from BN6PR02CA0038.namprd02.prod.outlook.com (2603:10b6:404:5f::24)
 by BN7PR02MB5091.namprd02.prod.outlook.com (2603:10b6:408:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Tue, 19 Jun
 2018 06:00:53 +0000
Received: from BL2NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR02CA0038.outlook.office365.com
 (2603:10b6:404:5f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.17 via Frontend
 Transport; Tue, 19 Jun 2018 06:00:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT023.mail.protection.outlook.com (10.152.77.72) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Tue, 19 Jun 2018 06:00:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40201 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9hE-0000Ma-Fg; Mon, 18 Jun 2018 23:00:52 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fV9h9-00046N-C0; Mon, 18 Jun 2018 23:00:47 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5J60kcK031737;
        Mon, 18 Jun 2018 23:00:46 -0700
Received: from [172.23.37.150] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1fV9h8-000465-El; Mon, 18 Jun 2018 23:00:46 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 8CFEF3C7276; Mon, 18 Jun 2018 05:08:30 -0600 (MDT)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] net: emaclite: update kernel-doc comments
Date:   Mon, 18 Jun 2018 05:08:21 -0600
Message-ID: <1529320103-7711-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--8.329-7.0-31-1
X-imss-scan-details: No--8.329-7.0-31-1;No--8.329-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(48376002)(110136005)(54906003)(316002)(336012)(59450400001)(50466002)(16586007)(36756003)(186003)(76176011)(26005)(42186006)(426003)(11346002)(446003)(15650500001)(2906002)(106002)(5660300001)(2616005)(6666003)(356003)(52956003)(6266002)(47776003)(8936002)(81156014)(50226002)(7049001)(103686004)(90966002)(478600001)(81166006)(8676002)(305945005)(2201001)(106466001)(63266004)(126002)(51416003)(476003)(486006)(4326008)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5091;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT023;1:4z8NFxuApF1KnKrdUAR4vnHPCoNdRv6Y+MRvTKWWyytArBLpeUVZ9IFPab/eS2YEBslA/pWDya+x70e3IbVPEww/jdiexoq1K0yVsoBwJV5nl4xHwAqTicJW+03RNJ0b
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b451342d-993c-4da7-5017-08d5d5aa0409
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5091;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5091;3:H5ruZApekDLe9hPz85rP3D/LkObh5W7evEGLF8qYUSlYSHAwnWDpp8T/gFP8jErtH9avLBdLjy+ilcZDse8G3YZH7E7gOTWwMslMedWrJCIHgvTVDszDXKJE6ptQPXP/0OT4aHzhs3l0lnYJT8JCIdBmBAd4lGjKuZim4gA2oyjX0bnwY9xl4sJDSmejxc+yDDYk2iWYV/4jWNvdlKwWDbKqKmxCEMFRrlKo/Jj/fYMpAQKoqGHwVVpIfa7IxM6iFbV/cb6bzmTrqC9DUCUDAH5TfGR8Z37CrLpnZ4VStLr87sUGqCk7ew5vxfIbRz+6aeyzCpDKphmrgKvhiEUxZVGfX9K8bJMKhiVZXwBgSPM=;25:rtTCpmyEyps9G7iWL/J+HhCcVAamQ1C+bL7QAle+0WwJ2EeLamdklk7lejYC6el+z2UYeLepwpq3OKQi9eCCz387jsiWI86QJpoSCrAJKdR9/2RREqnijUmJQCxCjtmwy2MHHuWsIas+25hB902CROrfqZBqsZ6y5Zi2fGvU4bAbmmG/hNDe7H5ChHnPwpbGPAeHmbOU+E0Vt4AVuFRxIi46K7KmHJx4eoB06UtEdc0iM1xpVMuyoCvV6LJ6qfoCdyBBq9aH9MA2eyQlUIsyQELFi5TF7g4arrsq+kJUwESwltGCKr8foDCX9rYyCHm3TTg8W/ikNMWKHXvCqp7pbw==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5091:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5091;31:pwmWVLtDPJg/yrHw7NoXMPJwmzma2X7ttwVYzx9cJPaq3Z40VDsFDyVYmT/SRd16oJb2vBfxx5IBIfI21QPG9PHhyqO01/9Nvq3b9AE2vEOBGBLEIYl+0PA99n2Au3PnRyMCC2WVB2NSOOQ9MHCRNDrpcWCendiSdYFTpkGJJBl96wBtRdnRtK4Dl/lJun+d91SZ85s2YquvidjejWZhT+HW7VTSAIiqDdQbzVRRp7I=;20:czVo9FJIBggc8TIUP0zjOhCLfWAwxEOI/YgiJL5IkGW8VOys4EMCOF9sygVt+ytVb9T8/qyWJoD34OhMjRPbCV/4AeOnvbQhRTHJO5mbo+tCuVopfHSJxCXuld/HP0Z+Zq/7EmENwwyxDiIZl0wzvNYOcO1ermlUuUWeEPPIhQL4srIZeQG0XJtKzTUXV4fGQFsf5jei+gGmEIwlXk+tqa0qp8hH6IQOX8JTT5Lp6kyooheKN2U4V3X+jj1wYzrN6SDSnKTW09Ozf2HbtADJ2Q77buRzg7B/q2IczdL2ckmBET3z/2PMxPmBrk/GhIc73UGS06yUvqjNs98hU7Iai3EFCX4JxdWrtT54/Kagubb9bXVvpj8Z6A+7SQKdat+HRS2hU+c7zl0dC84eMUe7Ye/YXAZsl1N9z9i8EH47nI3X6p5B5HITyrSDBgROP1rUr2hvvPOzQlkXHzNdadBepO9VPJoTlYwazPKYwytALUvLMAtogcE3TRtnWSUIx5Gm
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB5091C88AEC8054BC3103FAF6C7700@BN7PR02MB5091.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR02MB5091;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5091;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5091;4:gL5E5dBZK6/1TiDT/p4LtKf4RRNSdArLjLSDt2lXKm+mezzItL49dok7+pGh6fVRXjY9Uc4JGIEPF5QaZwH36HkOj19UDmjpZqS1CVP2iKlJd29vWwSoXb4ic16741nHPW6Kug87ncpmAJWS2UjMFCl4ecTloB+p8Cr+9BcSa2I5NIga8N7/gC6M3VC2jMwzRkkej9lXMH/WGi/x11YyT8P17Qo8HAZQw7Rj/aaVxwUwOghyecQsg+VdPevccJO6OPsFo67OK3xBX+tbR4K+gdlh408oOIxka9LbPs224i+a9TBPajj2I8h/w3JWj3uR
X-Forefront-PRVS: 07083FF734
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5091;23:44g1kKI6XNyjRVVtUAngYqUxzCZc7oQXjviyqqh90?=
 =?us-ascii?Q?qtN6PlhGFCN7ObbsXtooQP3CW0o9J/Uf0RIV21D/wZiPtMryMPprTKu09MEx?=
 =?us-ascii?Q?X8slkjvIONLPdL8EcMd2d7x7Nt0QaN5WByvyZtwERmveMGeBp2ShB+e5nzDD?=
 =?us-ascii?Q?mriItHjc1ALvvcWs23Gar1U8LTuj6OUqkdjQYK3S2J2AL74qqECW/8LKwCUi?=
 =?us-ascii?Q?rUnkzSDqqwEl2MpXcQgbCqodVlVKjGsCpI80w4X28VUbqiOSoEcpwYIRoKWS?=
 =?us-ascii?Q?GVmAchX8BUZfyhUz2w0fYm944Nw3XT1KjQwA4DnEwWig9jwzNpvvnFKefqSz?=
 =?us-ascii?Q?Tb7ZeCD7+M7pceE1pb7TPD1tc8NmKj2q0Xa80QrGDgcpKVe3S6LFDOfZv+os?=
 =?us-ascii?Q?ei+DIdcHc1XswKtTcNYbUgqLDn52XxxkQBCi+9kr3AaYhubxSG7wX+xx0jBX?=
 =?us-ascii?Q?VidVMDRimNriCcOkTv6SARHqY0pIjVzV+rJ5prROZz+D5y/PmC1bFs7QGA2A?=
 =?us-ascii?Q?V7NS7mgWcz+MFPvuxkl1c0rZEZe/PN2UfxOVx6xs9zj4Tc7O3iuKylqfgltk?=
 =?us-ascii?Q?y0N5yu6mpnQ5tDrwOlXlyNclQuLOhlkiOGJ9HUYLVmNRknUlZAe1xbECwGTw?=
 =?us-ascii?Q?zGS9A5GA5gSJ1rEu+rGhC+0wVvadPo/bg97WpIBpO22JcXpjzClpkJ7GWZL/?=
 =?us-ascii?Q?E62BczuAdDQbGACEoWuzV+k48AXw5cODuKtMvVsxIDdKB5JQe5PAOL0r7/gS?=
 =?us-ascii?Q?Dl5OSohtYkZD7KvOJZyHgSespCuocCPlvPb+/ZeFUqtGa5i34llEVVB/006/?=
 =?us-ascii?Q?GUuerqQ8/Z+pFWunwYchRNoz2+QqOansLyaiY409IzUPylnnfJnMjy8dgwCN?=
 =?us-ascii?Q?n92W0yhsQYsKE+nOdh/Q3Nm+yFQqNTmCjgl1hKwVroD/7GGcWklpjAu9/+LO?=
 =?us-ascii?Q?lHJgjhnIqh2FEigkxXNUcnwy1v3vzwezALHtwkEUL0pNb5kiWVzC3F7oA/jd?=
 =?us-ascii?Q?w+bzAGRzb6Lhy3heN3jeEPQ+YAE9VZlPby5s0noQqqM0MCO7D2HnM/krblDi?=
 =?us-ascii?Q?1ilrfcUBcezEnLrgQt04bCHQ9qUGqdzWg/7aRpIrtqneY/tXiBvVhSZ1nrd9?=
 =?us-ascii?Q?Adr4M1/tuuTq5ggiZozBtIPeEmDt1jSxPCrMxdHxlcbZMsX4J6SDu8bFrWuX?=
 =?us-ascii?Q?hdCxKacYXdGEWz95Paq9mtHHyVEAFO14eZj8nQJsQPy9ROzE4rccexVciKLV?=
 =?us-ascii?Q?2YJWWtOadFNSNg1oxE=3D?=
X-Microsoft-Antispam-Message-Info: 2U7Tw/yAPi/sP9BicSsQLwTf4SewkQJNtGhK32SG/Pu5Jld6lxdKUfzmP6XHrnG1ETXm3slR2C3kHtpCbmnFyy5SzTINNE6YS0jD83XMMM7VaXxZ/d3B+lIqSU2trN5k8/E9P1hbq4mNAad4R/KCOc+8gPtdkChmRAePzy2KuAq0BsWnR3aWFw9CgBDE1BZPA5vA2MtF4QJVJamndUNukho76XtGEUaNZ689L0LK1OXxBLQY6Q+JGn2cFVZstgg+p9+9fGit0eeji3MuSA+uFQ6e7jk7r3DlJxdkNxnLuiZBwDgiHjThg5JuybmQtfxjmU2NvoCc/dQOvn7/ef4wPQ==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5091;6:G9ThcnE8GHAPFwI+RuvOY3V8wMKOKihIKc194z1XBs5LS/6bUQy61aJSAr5pAjQA+XihsYQhITyzut00P7/fE9ce1sN+l/sHrz5PNnuwc08Heyzg/bmxHBrLMh4SgmlmsnlMRFHb7X7YpJ2b1nz9bKVZF1vYdINi+4zsOs76bfAhj9OI4VmCnfbnyNdtYl+oG7pRQJE+tTnWqUSr1Gv4hxrw1hZTW0or4byWXIynOxLqHM8r38m9l6n6lblbBnThgCxZn9oleIxoHv0dUEJBaVmiDWxhCH9WxufRqQFNJrDPm/ZLZPUeHlznnDiVyITooQtQOoCjXPGbJklBh+tNFXqTZVGPmtRQdPsvUDS6M0VM89lqCoXmLUUPYCh3kxAUhAkTJrMRABQG71i3t+LCchh3cEtOo8n6eyfDLFkOHh7Lm0DFC4bOvVywxE6fhqlh8+kRSnRqZizGszb1sfOJPA==;5:ff8TrG2ysWIqWPs4oP0YrYhb4nBcyX/CtPGpB48WQa1Dv2EpotpCfVn5Fy+qJU1sijHiQLMglyYV3JgPIoPBa8iEkH5mTVBBlW+dqYlb2Xd4FD3CKYazo3gymxBWHNEg0+z36THzbinzyRDxnij0l07esEBkCiZEYAAV7FPIGH4=;24:JRDnaiJRlxM9ytZ4idiLD1AC3KoVJ/8yQFJcFUQYr9osgqfqTzq7w92GVDG0UJbwPUgvsobx6KvHBMGsfrw+NXciNSdq+k1MOdXkXa13Wvg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5091;7:qKuVekWUm9s9uFqkq/IfcvHqSOalHe5Z/ShI0npUktwNjyWF7w5vAT8hMFEZ0j2s0L+NhVLeiKZ0vSE7QdZFGMzD51paduk87qvpYdMVOygKU1E1cif2fyBLOOAjSzefDnV7bhIziW9FwzZbor6XTmdN9kufdUs48F+YjbrJee/VaCODZIobz3aNBd2ElAoaDNvxl4b1mwOm+JBe3PoYlktr1uYHqx+fMD3Lyy/Galt9JQ/AEZnASXz6BqgiJMwE
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 06:00:52.9168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b451342d-993c-4da7-5017-08d5d5aa0409
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5091
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
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 8d84f58..0b41cc5 100644
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
@@ -637,6 +638,8 @@ static void xemaclite_rx_handler(struct net_device *dev)
  * @dev_id:	Void pointer to the network device instance used as callback
  *		reference
  *
+ * Return:	IRQ_HANDLED
+ *
  * This function handles the Tx and Rx interrupts of the EmacLite device.
  */
 static irqreturn_t xemaclite_interrupt(int irq, void *dev_id)
@@ -770,6 +773,8 @@ static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int reg)
  *
  * This function waits till the device is ready to accept a new MDIO
  * request and then writes the val to the MDIO Write Data register.
+ *
+ * Return:      0 upon success or a negative error upon failure
  */
 static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 				u16 val)
@@ -803,7 +808,7 @@ static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 /**
  * xemaclite_mdio_setup - Register mii_bus for the Emaclite device
  * @lp:		Pointer to the Emaclite device private data
- * @ofdev:	Pointer to OF device structure
+ * @dev:	Pointer to OF device structure
  *
  * This function enables MDIO bus in the Emaclite device and registers a
  * mii_bus.
@@ -903,6 +908,9 @@ static void xemaclite_adjust_link(struct net_device *ndev)
  * This function sets the MAC address, requests an IRQ and enables interrupts
  * for the Emaclite device and starts the Tx queue.
  * It also connects to the phy device, if MDIO is included in Emaclite device.
+ *
+ * Return:	0 on success. -ENODEV, if PHY cannot be connected.
+ *		Non-zero error value on failure.
  */
 static int xemaclite_open(struct net_device *dev)
 {
@@ -973,6 +981,8 @@ static int xemaclite_open(struct net_device *dev)
  * This function stops the Tx queue, disables interrupts and frees the IRQ for
  * the Emaclite device.
  * It also disconnects the phy device associated with the Emaclite device.
+ *
+ * Return:	0, always.
  */
 static int xemaclite_close(struct net_device *dev)
 {
@@ -1064,7 +1074,6 @@ static const struct net_device_ops xemaclite_netdev_ops;
 /**
  * xemaclite_of_probe - Probe method for the Emaclite device.
  * @ofdev:	Pointer to OF device structure
- * @match:	Pointer to the structure used for matching a device
  *
  * This function probes for the Emaclite device in the device tree.
  * It initializes the driver data structure and the hardware, sets the MAC
-- 
2.7.4

