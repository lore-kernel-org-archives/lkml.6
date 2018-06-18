Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4EAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82E4208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UuxsHI0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82E4208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934550AbeFRLvW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:51:22 -0400
Received: from mail-eopbgr690051.outbound.protection.outlook.com ([40.107.69.51]:63907
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933830AbeFRLua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFI0Bb359RajYsl2LlY9a+iCpDcGa1wTgr1YH2H8PHI=;
 b=UuxsHI0Nq/r8b0jre+RlHSybGX2HkIArAg4jFLa/GxqCjWkCLmIfGTGnJYCpXq/o+wJ6NcdbZrdlGiSer+5W+set3MRdSdNpLFDFa6kGEWqHT/vyxV0PANfjz0EWHgMp2M1jAzm0T9Nc3o26swR1oh3BDH48DKj7uQslQy7qr1M=
Received: from MWHPR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:301:73::32) by BN1PR0201MB0770.namprd02.prod.outlook.com
 (2a01:111:e400:58::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 11:50:27 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MWHPR0201CA0055.outlook.office365.com
 (2603:10b6:301:73::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.14 via Frontend
 Transport; Mon, 18 Jun 2018 11:50:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Mon, 18 Jun 2018 11:50:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfw-0005mS-Sf; Mon, 18 Jun 2018 04:50:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfr-0000Qd-Qb; Mon, 18 Jun 2018 04:50:19 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5IBoDpE006509;
        Mon, 18 Jun 2018 04:50:13 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fUsfk-0000Jq-Te; Mon, 18 Jun 2018 04:50:13 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 1A59BB20856; Mon, 18 Jun 2018 17:20:12 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] net: emaclite: Balance braces in else statement
Date:   Mon, 18 Jun 2018 17:20:07 +0530
Message-ID: <1529322610-27215-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(39380400002)(396003)(346002)(2980300002)(438002)(199004)(189003)(36756003)(2616005)(90966002)(36386004)(103686004)(7049001)(446003)(11346002)(476003)(126002)(50466002)(426003)(486006)(48376002)(16586007)(316002)(336012)(42186006)(50226002)(2906002)(6266002)(54906003)(110136005)(106002)(4326008)(51416003)(76176011)(47776003)(186003)(8936002)(81166006)(81156014)(305945005)(59450400001)(356003)(8676002)(26005)(5660300001)(6666003)(106466001)(478600001)(2201001)(63266004)(52956003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR0201MB0770;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT049;1:cfxYPJen+d3timtHlAew/Z5ngZsCSPy698iTndDFoCAC2YQ2esriDDSbA8zQbqS8Rm2w5pKv6nq7ba52cZjgZcmVSnbefZCZz2EbjtT4zE27X4TFHF0mCN05OUAPT+qY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04991699-fc29-46f4-140f-08d5d511ae30
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BN1PR0201MB0770;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0770;3:q9u6jt9bn4yCfDDdlj/9/r3ytQHoegXZ77RxlMLyxmN0cWg2+Qjrp/uY2lufkmpRX/9GariASlk0ZkvCM9KXa+HN9Om4L25D7ewZKiCk2LsC2jVvN5vbRVEmrd1UiHg/hA+IRF2q2Mlp5SL4zCtU56Eb2m/+Hf+Vq/PNj/QA/WOiEmnriV8ojXJVJOCs+rtcXlpVbq6r6b/2FyrEGAGF41g3U3/ulcJ29mD8bhQA36tXTPSGYN7MvMH0BvzV027omy1tgbP3HpmzQPpivRUd/Dovg7HubnLOE+BPgcqPiR0GV3UNdOJuz7O6bYIPJ+QX4cAJZv6ZVzZLfKKm7FUrLkDNa1jDDGw5eRmXUNOLtI4=;25:JFWMj76c0o5sRDLygt2XPviIJujGn2oLc45l90MqCc6pmueLz4DlM8UOVL4cT39Fd5SLgEXyd6c43lV//Ul3zWWWKHsgNn+oWuLUbe6qq8KDWevAIrvEUgMh+33Sc3kMp8GwNZIsL7NFW5hLtwQbpMKCD9YLp9dH47uKziXkISi5ZdzdcHOOLAvUfoWFZgPpX/Hyx3UzEziRgvfLycsoonu0+ajo67Q6nuFYXPHA7PSryd6ZL+rewV5xrPja91hdb9TE7WeWtTpCU/vxG/flqtbS1aOZhluhZOo0aWCgUy6JABt5VeuRH7WO2AOjP10z8YSR2r586SvHi9foC7OnQd0dbDW1Bu8Yv6xsxKIhFNQ=
X-MS-TrafficTypeDiagnostic: BN1PR0201MB0770:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0770;31:37A6iNde2upOVwBJ9Od+X1tHPT+S0mrh/aWO6hpnad45JaxIAwrz4VyhiMx2uLR2mhD4kXqB1UkYwQGqc39hVHa9Ok7mI+JQ0D+rF6h4xDN+w2oK9wVMBJZt1JipAEHxT92drNriN3wU/DHEu2PyQIbYHpLYaIxsaqOVxmU41gkO3zwKnZHjiYrzn45YSkLlZXwxxt7HRQGGd3qh+yI1NjGuL1Yd4rRZNR6Ne3uGmgM=;20:QrmNfakov9MFfi5q8nyzs/4fhX5n3NFOLwIa7eoFwKEN8j3NxbewGLBtkzzd3wI6LE6YECqFA6rm5G3wnALB7G+aqqoFYM/v9Qj2bT6ftlJjyk1pDkvd92VyH5OLpf66Vd96Tt/bKQjpwrpOpTgRI8tGB0LU9EipyG6SwiZieNrw63NcxfMyozhDsHV+Jnc9aEGoUUmF0zHs3qxCBY1eJMauCTtqmijOp21VIf9ZGWu+iSQj9BXdz5E2BDdv7dKYW4q/s/Y70Hvl9k+8gzdp2Zfl7o7j+u0slhiPzD6wv9QpmfcshUySmEd7qnd0FubUA+Z0DxJQV9WCh7OD7KzdmWMgC0uLgBTWawnaJflOR4bKpPg4Wadgs3tHs5tvg+plLZhFmAj1WR89SXI3eHXuOG1hFEX3oh00gr2b0dx5tuXjjAIfESbPgiBKpDdBLoqEl3EevHgz2aBdLfbvofep8SiNc9/RoAzMDN+g0DjWdgQYjxLnsHbKq+Vjsy5ZQ3G2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN1PR0201MB07703FB66A954EB8CC1C00E5C7710@BN1PR0201MB0770.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN1PR0201MB0770;BCL:0;PCL:0;RULEID:;SRVR:BN1PR0201MB0770;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0770;4:4B8J0BQrU0MjJGhW6JcjV03kmjxPpNcygOTksaenoGYFbuq8RM1TuoUZDjQN9YoFIaWFSL8SeF/KEHe3P654CSIU2RNGd1F7SQFumU7Lz2qMcJBRumxQaIdTDQT//89AoSwF+Rbn9DMjUJ8NpIdLcN2hAaoYEU7kB1uNfW0AIxWehoq6H7dQuRRnfYfmexCW9VsujrIIf6lKXWMX8unWalCBT0yC+W24pf9R0U5zNV4h4bLSJ/9Wo6zkIpewmnP0y0xfQac+AmNOV+Ay88yMeY/DmuyAzKuB93QrTsF2kUawsiZK765G0d+l65R24k6r
X-Forefront-PRVS: 0707248B64
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN1PR0201MB0770;23:QQe/Ea0oVQq/PBvn3SxpevHoVBUf8INqopnuZYL?=
 =?us-ascii?Q?fiMEU/bzE/C07GolPbQ/H0sPswrwbJQXB/w7J6UQ7k9cvz2U7A8jNHhJ1caE?=
 =?us-ascii?Q?U2I7QKs3HUPWkLO31ifZnxklWrhpX38ixVxvmynEvE0Pa8R/J4NT2B/yfm12?=
 =?us-ascii?Q?YiWdXmyb+oQUskcDOTaJQPEtFBCAlNoF0+KQoHGH62EBDwbHpLbH9CsDgb3G?=
 =?us-ascii?Q?4Fr0YGpEudf+k3RfpZlhRuJmHUGtbJOPLUX2durEf8d4puH/L0hhOOADlMEE?=
 =?us-ascii?Q?OhmZ3C/yLh193SBfJ0V0jbTVdmj/w3lZ6DepP8sjRp9vM2cwOFTmUWBrDyC5?=
 =?us-ascii?Q?Iar0Ori51Q4iJJOjUhuTDkb2ur2rJ3cVOfU6fjnKslxFuD1TtAMprpw6VSOH?=
 =?us-ascii?Q?vJWoECBE3uxDfpeTOiQz0/zbCbko3k5/RJwkNGETODWfRTotj3IAAJhEBHDk?=
 =?us-ascii?Q?tmLzK9NwwQk2LjJuABF9UpHFStUEQOUW8bV5IPDasd71jEyVuqLexLnrhw3w?=
 =?us-ascii?Q?L1Dj9sXlDMlapoLk5ioSkZ7e5RcmRLO4wXd1u9GUSO+bLrHOKGv+VtOGLD6d?=
 =?us-ascii?Q?torIsD02qVNlyrrpb1gQc4htEjRkkUg5Cf1sdvlcMb9hv5j+TBkciBYAXxKQ?=
 =?us-ascii?Q?cKuoTUU2ApQ0T/DuE+qMb+WZwsX/Y9gRHZb1hF5H+SmZ8dB7LkDReKd58Xfp?=
 =?us-ascii?Q?OqR3I0ZotvQdE4/UZasWxILAoX/m9d44GRuT2CqFoBygqQ3IvIJHE/IyJR2a?=
 =?us-ascii?Q?RulYKVbKhM355XqhCLsPER/8H0yl8W1ZNTNQoN7XMEQT+xpJ6BMYYdE14hg4?=
 =?us-ascii?Q?dt/Gkvw6ETkioQnEikcyvhm7jRD56a6q2hHIYDLNE2cwRI1BkBEwGvg5vGhz?=
 =?us-ascii?Q?7GNSRf7K32v+pC7ehRPUv2q5wQ0lmIYp6f5VYx6vnZ8pD3xFMNm+wSSYDyqQ?=
 =?us-ascii?Q?1HWbi4hTopuYjQ1qjHB64iwEQ+9EUaGTF4wSxiklcKfvw3F3xO/DvXMG23my?=
 =?us-ascii?Q?oHkOtlv2ModlJ/OPED9jRhvJGtYgwPXAxLYduqvj77PoBaWTcgZVYd+8v6XO?=
 =?us-ascii?Q?zIDdLQB3wr3Pjb3CXN4/uXapzWpjOQ+l1cZxQhcF+yD0g40ma8CVRyX3rLrF?=
 =?us-ascii?Q?/2YaTAy2Ki7XJUAmVmDvT/oXCYqTUnhPedp8sKftNHbjgmKllP5m/5oQ8dQc?=
 =?us-ascii?Q?waZUBPqvzKvO6yt+gAHW+2MldQFmflFZk5pgJ?=
X-Microsoft-Antispam-Message-Info: ZsZug8UuUFJe6gNgT8hY5ECb1qj6HtJr3Dm7RInXC7Jd9Fdmq9KprnRzKIIWcjedrBFiHH2cKkce3n4vIf12Rx6y3IgNilxIn1+qrs10t2kugsUW+EdO22LzGcyMvB76XCDPNp09Oxk3Y91yXzSRiBI1IEWPAHzQ9qrUTywsLZbQkTApDbmculZcfGV4owk1fN95TlCUOfWaFfsBteuIWSYhljlKVuhyO8h5Rl0ipANNB8/8ukZHaMbkcPHILjIhHYrKD0H2/FUsG+Koqaj8T3v5zpG/iZKDk9pn6PnklGMRcwxrLPG9qr8emt4QR4OXEEtAWXqoeSWHxohFNyB2Zg==
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0770;6:lmYUXnrmjGRxN8xfsKRO7afLbfxokOjkVTjEhd4rcAIZibUEa3XfoVyytd7u+1wmxoTndQYPspdTTgRXdo8+1e+w4ObAMk1r65hIy1/SsjvmDardAEZ4LqiRTMyiok9vOKRX0c5kqRMJPNehOU2Y5qPzuT6D6XCsoMtqJLLxQibfdcdemSpBXcfpwtU3EXk2iSskSOfpmjGsOdBPzIKVPRXmxROnWmVZloN9xCs2DxdBokfpL4OL+dTD7125Rf7QtCuE4yatFIl5HeoQwxgkSTaWkkQbXw2b9ArDCs7XxqlQ110SJcJr/DWQikbT2U0owAVQKNXyK/wRvuVkqREnI/v5k3W43YsMxVUxkY2C4qpVPZEavpEpU0nYbQDuh2coHtQHVvO76ibnEZMt094wKqlwZTorNS7qiQmXOerrTRF34DJnut49cU5SkSYpju+r3wmT8dntPoggq4uB9Hk2uA==;5:mj5tRx2CnPJU9Zfn9NIUHU9RQfxyYFD0gjXpl8uyNYoAPRRVdKlHG6kLczRo9BLRRDamL4/cwW8s5JSvBCYoRdbfYyYYrPr5zch6+uOZNIYtWQnRwTevmsx4XKMJ9hbHrmJZzhkkWPNliVvSAh5f48rK5Yo6rivkPr3dQvkMZI8=;24:TcCP9HZyMGUoaa6U9OMEqopwEihSS2HbRK9oMbcFrBAYLaOgRCX1hNDTqq3W/OcKDZ94hlHC5NCEKFvSsLHEYREkVXevHdbdWqm1ul9c/gY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0770;7:B5Cl5W0oEdUJEFJopnsANZrLqZZtX+v1r06fpkryLcO6WhLML3kTq/vSRCTV8tFbhy71GRpjfpuCXcCaJBxMUcKeuo3TJzUxKBqavUQ0oQc+Kh3tq8lHoo/rRVfWIZQvSNiBaYS/bzxaJiQ9S88X/SqDTWiTZBwNwIz4mWZGOseVbL5AIUnc+OJEV4l7cjvmViiHTVg1l2moED4SyIyG6SezqFjEzbx3yWajEAXEJYbmCJT52I4l6Db8M7g7+oSE
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 11:50:25.4464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04991699-fc29-46f4-140f-08d5d511ae30
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0201MB0770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove else as it is not required with if doing a return.
Fixes below checkpatch warning.

WARNING: else is not generally useful after a break or return

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 0544134..8d84f58 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -569,13 +569,11 @@ static void xemaclite_tx_handler(struct net_device *dev)
 					(u8 *) lp->deferred_skb->data,
 					lp->deferred_skb->len) != 0)
 			return;
-		else {
-			dev->stats.tx_bytes += lp->deferred_skb->len;
-			dev_kfree_skb_irq(lp->deferred_skb);
-			lp->deferred_skb = NULL;
-			netif_trans_update(dev); /* prevent tx timeout */
-			netif_wake_queue(dev);
-		}
+		dev->stats.tx_bytes += lp->deferred_skb->len;
+		dev_kfree_skb_irq(lp->deferred_skb);
+		lp->deferred_skb = NULL;
+		netif_trans_update(dev); /* prevent tx timeout */
+		netif_wake_queue(dev);
 	}
 }
 
@@ -1052,13 +1050,13 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
 {
 	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
 
-	if (p) {
+	if (p)
 		return (bool)*p;
-	} else {
-		dev_warn(&ofdev->dev, "Parameter %s not found,"
+
+	dev_warn(&ofdev->dev, "Parameter %s not found,"
 			"defaulting to false\n", s);
-		return false;
-	}
+
+	return false;
 }
 
 static const struct net_device_ops xemaclite_netdev_ops;
-- 
2.7.4

