Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2308C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853BE208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lFaY3N/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853BE208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934264AbeFRLuf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:50:35 -0400
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:19296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933631AbeFRLu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffd3eZVt9Xll/luLMgbKGF00JmC+hSAePszTXjMombE=;
 b=lFaY3N/Ek+N8RdJ+PUlJCURTXzsOlN4eHA59FEEVC3GmFHr+6LndmFodqis3dJBMhwPVVBgSyKWm9bL9onDv1P39BbhLmb6bvv0FbqTynT0UNTfQpbH/6jOy9zATSo3/AOd/PaBCnqnrxHnYkYVJkD1NE0RbClDLAIXrhtPMCW8=
Received: from MWHPR0201CA0019.namprd02.prod.outlook.com
 (2603:10b6:301:74::32) by MWHPR02MB2240.namprd02.prod.outlook.com
 (2603:10b6:300:5a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 11:50:25 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR0201CA0019.outlook.office365.com
 (2603:10b6:301:74::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.14 via Frontend
 Transport; Mon, 18 Jun 2018 11:50:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Mon, 18 Jun 2018 11:50:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36311 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfw-0002rt-EF; Mon, 18 Jun 2018 04:50:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfr-0000Qd-BS; Mon, 18 Jun 2018 04:50:19 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5IBoDLe006510;
        Mon, 18 Jun 2018 04:50:13 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fUsfk-0000Jr-UK; Mon, 18 Jun 2018 04:50:13 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 1FF6BB20891; Mon, 18 Jun 2018 17:20:12 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] net: emaclite: update kernel-doc comments
Date:   Mon, 18 Jun 2018 17:20:08 +0530
Message-ID: <1529322610-27215-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(346002)(2980300002)(438002)(189003)(199004)(336012)(2906002)(478600001)(316002)(50466002)(426003)(47776003)(476003)(90966002)(446003)(11346002)(126002)(42186006)(2616005)(36756003)(486006)(59450400001)(36386004)(186003)(103686004)(7049001)(63266004)(48376002)(52956003)(110136005)(2201001)(54906003)(6266002)(16586007)(50226002)(26005)(6666003)(4326008)(8676002)(5660300001)(8936002)(81156014)(81166006)(15650500001)(76176011)(106002)(356003)(51416003)(305945005)(106466001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2240;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT055;1:9xE5dwTskkBmOvp+eo9b0/eG3O26u/B4GYgWBku+scECQk+ZoH/5wzR4hnt7tuGiOYG1EFFBGSMw+6lzILMuSua3NNdm/zqKyp0kX4+d49L+2NGEjGUoTYBt1yrbXqP4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad301b5e-25d0-40e6-0e10-08d5d511ae00
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2240;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2240;3:wr50vNkKH8CUs4wnZNnKImycs4Lzqkt8xGNSc9gW+uFsbquop/+k/yx5Tqxqw5QgEnoYToaYtCJy5Bz9LJkq61MEshHP7nG8ix7NHL/EpWpADG0hkbHLNj+2y3I/WDXe/AusvfZ59k7cypEAaW0+cDxBvvmrKW9YApRK/+XPWEFJCKVrxlv0SzhYjOfgGKuMETjRpjmHJEHeqTcoT4f/q6sz1A9d6dcVwfWbRXyVOHkxr0Ds4V9gFvwnOf8MPbdsDBLdpHhZV+yxENXgKYGpffrwUvJeFrI4XsP5QucisOTBXacHoYNoD62mUkaODNjqC+9d6t8kuJrOZ7/FUTjynPhtPokqH2aaB9ohVMkHXME=;25:eJTb0059BSk8wGyT4CUEkeXjQrgbTbGmF8Gc98fKNksFMQMejHaHxr9901lHaa6uGS6xPiEEVnAzgbrh3l6KOYFp3hZbZWSw5mbnoBWtKC6k6qWUaNfMNEDXIq5N+Rdbg/a3mwdw/6Z8yl3UwwQx12dhbFFen/zSPi9sr/zyF3v83yAyBPM0iVupV8mteULOwZqojiMw20E7WRw85gYIwYwWhDEYUerRAfinvIlbyzocoQxPVanHnMXSrDOOj2VJy4aTCgtaTkbvORHNxuPmy2O+VI8+B8H5DkPEhWqBAH+ZxATNAfbihVZv0vY4VKeXhld7ghCSFB4xKqKOKVk1eg==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2240:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2240;31:BU4VZV01t1/M//3yzv2AmZPzI0janJK80c2F1+UhrZMMp+d2oZUMExauPISC3O3ANg2IPrJfHPOUlQ9JuNd9rcuXC9Kat65zpbsg1ea/rtYjiUVlSDPqJANtFt2CICiDvLpYTpeBUf9XtdkMjGzCiOAAXTQEFf50TlkXMDnyQnYR6BbhxSTMBlM2U0GGQIKuUIUzbTGWh4Tn8U1d0T3b2+yCwS8PM37eBpDDMEUvNB8=;20:ixgbskvUMU+ibbOfufBvIQrkG0OliGXtA8NRdEcltAtedmRX3scVprjlAcqx4YxbdbaMGVn5BeYrdbuX0OhIN2YNWiEOlXaEuWZjhDv0K+h+cHcEzo91RLs3yZpxKVqnHsiCwxhcY6akoqWY1Tw0ffOY0GeLHedc/SNW5woaXwOVfKcnO3zIqLpBPJg2LjShq9wXfHGOYEQ0Ui0rMujB3FxGXj132ACllbAJIgd158I62MJUVnbnQ+GHzopHwiXhPocluU3SYTdNh1vnkRtyxPk4NnQOIE94Av3craqKspzOUnLCsNPURI7n4RmW8VJDFPO/p7WaHV2D0hSjU3dIvcUxWRes8dJL3x7hM0fA9VApA7D8KKEYFctzsWNc4e3Q5xIodTuBZU12Qi8qxT1EyAROnzs5psIE7ptpyUHPQpyi28nY0Ql+RplOxtn7EIgXtFjAO6BzJTxtsmPLqcmMH9sepEFpqB7zEt52cfst3L1vPsRzR55Nyld2qP4wZsLj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2240F7C7B27266D675A7007DC7710@MWHPR02MB2240.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2240;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2240;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2240;4:XmRIsjw/FpMntfs7NXnQiv8VR4xh3CeDEBM2S91pbSZcW4s2Gps8BexEo3SFGZTm6WR+7Ip2bcNWEhSdcvKKR8OOU3M9A5G3RDk1Wigf3vjSQm/yWk/YeJjZckiOkPjsNYCgBx5cJimVDLROX0qrnEoxmln4xAQDnk9qR6jQ2ih5Nlzmr6ulNnmJLyItF+8rs/fo0ECxH9RCgwukMgAyZgIq4oJ6W1nW4sdeojxzDTnU9LxeicJG9oC1eIvVtSH75pCDVurZ+41zroPYoVRJTShBfscD4YB7tyiFfVP+fGNWQXDBzGDxvkbkfqJoXa1e
X-Forefront-PRVS: 0707248B64
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2240;23:hqm6hKa9MhjMrgQ4SGOPHu+bdwvTcBYm2lND8YdRX?=
 =?us-ascii?Q?aKrbxQUOAoFhLOuZyeP/S9jokKfwl/Ip4p1qrCSRfGlw0eb7UY4qSdwigW3V?=
 =?us-ascii?Q?SZ2xPlxozd4gAHFy3RhExnsFlRG94zAIEYV+cli5/h0IICgwAAwn6+rk9lbn?=
 =?us-ascii?Q?SRM29gHXT9dGnw0p54nWjkC1nie8nfhhUqCsn0zV9/OsKj8YoGJGcpzvsM+G?=
 =?us-ascii?Q?UCzPuB46wULWnT71xYod+fSErET3JH9uHHt5sPdG694CiS1R4MqcJ8xgNolF?=
 =?us-ascii?Q?oGDtjjyu0517SbsTCYwTacB12sb4Xj4u1JAYJt+0N+MWuTQ9FvuzT4YyLOnI?=
 =?us-ascii?Q?zpAQIT028RwqthJz+pm22KfqO5d2MN/Ya/lXJIEVvlxvK4I+0bxD4XZdjuGb?=
 =?us-ascii?Q?gEWffkaxHIkYaJdy4Ef96xU4R9WpOlbuskkuhguD82H3G+ijBzTzBuhTTwyi?=
 =?us-ascii?Q?zMyMSEVBycZP9DCq+zCKofyIq8IHAjO6P5ImrPGf7yBhmslPREbuD/r9LPrt?=
 =?us-ascii?Q?PMLjxlJB3A8RlnDQ47niaFtmeHKbI9d2b53jxFG2H1Y/eoz7aYzeOtiwZm8p?=
 =?us-ascii?Q?/xxo8jYxCqz8Zx3ZvO6YKj9d0e3rpXoa1cBwP3C7aqHbhEr53mB52AR7V/1U?=
 =?us-ascii?Q?QyPsUh2CZkXiCv//XXeD8JM7v6TP2xKkjbSnNF9tQgAPO3Og8zUnAIj0Y9lj?=
 =?us-ascii?Q?Ps63W3q8myEN3iObN3f9ODI+iHDCIBdYESZZutpFW7ZYORo/frTqjkmMAaoV?=
 =?us-ascii?Q?MtiJuI/SOYCiy8BieUJENUfQXLCs3Ax0jtE7TzBmf38qqk5XYuD32dR5cr/u?=
 =?us-ascii?Q?DLK5NZBEuk33SmiR8tOvSHLanGvk0M/R+gcw5WOSAJ3g6KBMr2cXMWpHm/DS?=
 =?us-ascii?Q?WJxlCtjsFUgzwaY1dUUzJUBc8CsXAWQ5oa/em5DpU6MHfWtWquFmBHF08toM?=
 =?us-ascii?Q?ej4sFhsRUZIDqDbwJ953Zc9h+rjoVlvYBe2rZx15UjSQMiBuLLUClBqjYEs4?=
 =?us-ascii?Q?67A7zEf7QXawQXfiO6rFWDOn08G9pyymO9syjp4axQ/D4VQW4GfiNGemy7Gj?=
 =?us-ascii?Q?iuaCWP7HQ4ch6CyNyVsvpKQrJFFgd4kfT4gLGuQPsG1Pi18uRlnORHc1crv9?=
 =?us-ascii?Q?Jpq7C6tgGOg4ktnHwJhNAWLGdnyC/qESn36OYN6xnJL+m4MMbnz5Y5rVrRdL?=
 =?us-ascii?Q?1p7nSdC1SBKG7Ipb6Uc5+ihEJy257eqKMxZiN84eZD3F0OwDyRNj2F+d59LU?=
 =?us-ascii?Q?p3ZaFKf9dyYWeMBvny99sFSQ3pUEaR6w6gWE+jX?=
X-Microsoft-Antispam-Message-Info: xWo/ifBeB8rjqYkSRn65nbgFN+HgXAAZBdR3KnsAho5EGNwjHPB/2pYXC+DyAH5iW94iR0XczUxC6ZHta7a+HQeM/kjmfgOAd14vVzswstDoGh6eCRdWtwubh0oh2UJ6f4/l0Qk3iLFJpnPHbatOM8LEOKAqiMaeIiHja2mH9/pny8GD6RhAuo4GScZtE7lh
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2240;6:p4gRc4mgQVVj5Bgj8VlDv8DG6Meugz+b2C6N2lU6yQg4N/9Q9HVN0tTB07HIFuAiF/daTh1UlhqsKlQbxuR/PS+yLodl5oUEgzNBo2U8JfhyjB7CEj4I4k0euD17y7y1m5NKC766i3j0ndvoPTQml7wD9jfUxKVGztLGvDuieRfG1vacigqRXHmZvEuhnRjWJhQA+DLjj3X2rzrwYaJ449BrILMvLp1VOeSn3iLHSSYou0a/S/yO/9EDcjqjUB8f/QNNKXKjGCxrTVnYSV/6r0YI4VGz/DoDGRqmnjrZqvzxDBsjbwx1aFyYSp8wi5A8s3fFS19Jht/DAUdCiLTmwfN+xpfuaRjxnJtX/MY6EcvzDB8BPZsmxssTLpg/FIN0n+iZnBz8d4YZbniTpsKbXjMfmonsoEy+wURKPRSde4X67AG5mWuYGFh+Rl8NG28y+fIR3/73kHRextnw2aoUtQ==;5:J8C3tFSE34rYGnc8oqUR7T37E1vYXu6WDOQzVkM/FuO0mJAdJx64jQ0flQCe/+0UaQ94HLqJVKsNVDr2EcAolY8JeaJuXiB5Dd8kN2XkTcTdEea6H9Dlb9a9qzqOn0MssJMhxTTkDx6lsg/KHhZkekurzWDcvD40hzzSPQgmrSY=;24:2Z5FBYp9s2QGXAf1Xhes8ZNaCID3jgxvAgh3fkdoU6mceL3ZXwHi/u/5YSgqgo7j05XO8smamk9QlGSLvDhKU/gbP0u82hgdG+E7+W0rVDI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2240;7:WwPX25J5DWniguShRvUwFz8oAV0BGzUz1JAC2ez8/8/Lo4iGF8Mzd3UvhstX26Fkkc7b+yAs40aThEUXeG8OmwToIulozISVvwexLLcGu/bqWFYAbI+N/SyomElM+2mRlkaqrQtxYdMR+0ymrRezM2Ykx8agjIjID25qvA51Jr13m4CQy8ivaXb7/H9QhwtSGJotoYZcn4sFtBYmkL02neEvBVOgjs90TRgaFtRKUt/v47Klz2EYRk2oOTWvzvI+
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 11:50:25.0692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad301b5e-25d0-40e6-0e10-08d5d511ae00
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2240
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

