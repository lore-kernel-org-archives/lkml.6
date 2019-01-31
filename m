Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F252CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0162087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="LyG4k+aL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Y2fOc9dK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfAaLxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:53:32 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36616 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732499AbfAaLx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:53:29 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VBqUlb024109;
        Thu, 31 Jan 2019 03:53:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=jNOz/m5aWgdwiVlWL9ehfgve2nZNmAVYuX5l/URtHbY=;
 b=LyG4k+aLjhymHCu0awjNF7VsZzRCJzF6BeCz1f1DPwvdkEQSdvH9fzAwfVY1lQg9LEhw
 QNd6MmnYkVIJ9guUXLt0s6dMgm9aRg07UvksXWLc2pPHdywqQTAy9eoBwXmxZT6U0OtI
 VufcWEO7xypaWn4SkFAC55PqVTxiOFJJ72aJ0GwHBCc5HvkNjQgiQdMg7KhhfQAdEKN1
 b9MJ/yLzFM5M0G3vJN2VgD6Vle8C57roV8TuKxst/KUXzpfT+ZoZ1Lt+BbApMaRX2BFg
 vRuWxqTIh2uJX+VWJyJeAqpg6PpkNqVSnUhVAc63n51G6Aa8VwMUZskgQVaIrXHMqgGa Ow== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2051.outbound.protection.outlook.com [104.47.41.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qbjukkbu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 31 Jan 2019 03:53:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNOz/m5aWgdwiVlWL9ehfgve2nZNmAVYuX5l/URtHbY=;
 b=Y2fOc9dKa/nSg93PfMnGNyD6WHC/ADXc0Z1qqMDihhG9F05ZS8K/Iriez/+ltqT4X+TieFKtGToBCyDdMw5G9s3pi/vIIBPQ7Y1+LKHujBay+YOY4H+dA6Va+jwRgjOE+1gE3NC5Kl/cLFBbt4SpTOriAdHZTNtXky2JTzeV6y0=
Received: from DM5PR07CA0066.namprd07.prod.outlook.com (2603:10b6:4:ad::31) by
 MW2PR07MB3978.namprd07.prod.outlook.com (2603:10b6:907:5::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 11:53:10 +0000
Received: from BY2NAM05FT006.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by DM5PR07CA0066.outlook.office365.com
 (2603:10b6:4:ad::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.17 via Frontend
 Transport; Thu, 31 Jan 2019 11:53:10 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT006.mail.protection.outlook.com (10.152.100.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 31 Jan 2019 11:53:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr4Si028139
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 31 Jan 2019 03:53:07 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 31 Jan 2019 12:53:04 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 31 Jan 2019 12:53:03 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr3Ce002265;
        Thu, 31 Jan 2019 11:53:03 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x0VBr3co002263;
        Thu, 31 Jan 2019 11:53:03 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <pjez@cadence.com>, <kurahul@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [PATCH v3 1/6] dt-bindings: add binding for USBSS-DRD controller.
Date:   Thu, 31 Jan 2019 11:52:28 +0000
Message-ID: <1548935553-452-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1548935553-452-1-git-send-email-pawell@cadence.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(36092001)(199004)(189003)(336012)(50466002)(476003)(446003)(2906002)(42186006)(26005)(426003)(4326008)(7636002)(4720700003)(86362001)(50226002)(54906003)(16586007)(39060400002)(87636003)(48376002)(105596002)(106466001)(316002)(356004)(2351001)(26826003)(246002)(2616005)(186003)(478600001)(6666004)(126002)(8936002)(107886003)(11346002)(305945005)(6916009)(7416002)(76176011)(486006)(8676002)(36756003)(51416003)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB3978;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT006;1:u0Uol0ojVZCoMxzjgryvIdWE5ge99b7UVcoaOB5EojKwDYeDbJ74bGzJS/NFrFo1I1Mhm5qGilcHFURaeuBBiqzI885OZ4j7LqCWDVKe99LcPP/mnu2BFkKM/tduP8Cy6xnZ26aUrs0yBK0aVC/LKIVFvAbGgluZ7dFpIrJw14c=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0902ae1b-4ea7-432b-c068-08d68772abd8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:MW2PR07MB3978;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3978;3:1HaSFIJ1UFvAO+MhaKLLqxZAynCvvWHCTr7r727HPW/piLj8useMFNndtHzdRXw7wJnGry79GnnjkNUd0oZgrACK/jrHsAg1AbQtIuIdBhSgA4CozuEbGDFlLrxBsRlCHG3fn75p/P0GdhGdmGFhbH4IVlxQ9l/82AXaasSHscKaSyxH5OeJzeWubIhb2eVojbicqBifaB6e0AbzlkYKKfo+AGKPhYRgQ1orx9WJ/xi71ejZs0P7+mUz5aCoZofN6Vc8CCAgPcAcp2FortBnYY+nMT7lqaR16uyX3Gfmz4NO+9KCgbTFrLvYOkHXQNWZD/B2PfvCZkayyggL9Bw3FdN/tVsztXbWrr7w5PShtJRvv9uLQlZ6xNfNhVKjZxgn;25:3/jl49oRUD8kJg7BUmFCe1/88Ks02l4LmMU66bW+0TYayL9/rH4FaGxkRWHsoqAf9A/6NqqAZQY+MGbM08lzCLME0SMLZNy9avs6TXlhbYSbWEHHegoSKt3wLRHtZ1BoaeXW2ehHNnAtYCu/vtL0r1+Riq56fvPrdNLRS7ZJbXKFoSiPZkADbS38X1DwaufKWeT8y6bj1pXl0k3tuiHHGZ1bDUPffRnk+GEEV9u7xC1XtNIIgBCxMyus6mm5BGFg1oqr1Cc5G3DZn4KD8YGF0flN2BP5prlUvxwaArHp1QYzz0sfbACo9eGKyKvzukwpEjyoUw9jSGw5qH7SycrtuQ==
X-MS-TrafficTypeDiagnostic: MW2PR07MB3978:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3978;31:/4y2bIewSYPpFABlks3sFQXv6mHzmYljt6VvK6oKSeK3itUuxazmi0egMyabEVX4/4XtdnqBnITL/NTgq+PrS1QvSVGyQld3APNf4UkM/ZzrnioIhc8jy6r2mtR4s2oGbJCiyhdmMeYX3CNx1ZniGns1uUqz/H040R7h9rF8j21sIFawcN9LKN0/wmD5ZxNQGYCvWdgtCPfRzdk1Et5TAZayOfnq/MZCCnEyOa1XHvI=;20:0j8mrPMmaYw9ZSeQQA8XnaXwLehN226hyd9Kj3SiaBPSkSf8AU4L1e/Zp/Mb8OqAI1CiP3UAKmSL+0mNngOneNzTVg7y4w1KHSvvHcLQ9RqcAn95s4gal3tDWdtxA33QDnQN/HQoicflXj3XcEE25N/t4G5rD5gxfK6xTTGJImf/9rsEfarpl6VQG8YJ5XM+UxG8H+V8YSbeQKrPnwaVTMAuVXMn0HBmqTWLZZBQM1zqIGoJq9YEK8xRh3bfnc1jc/dBmK4kpuOokYfWLtBQnzkIst+5TJUjfffeKVxohVk0/+zPfsAG1nmKpS+4akqbr2CAESCbDo4PkacFm7edR76UtXUDHy2ZkBvA97AFMQAmD6Qt/XBy5tgrB/S+6FFtNNRlqpH4MFkIbsYihaMRqpyhvibD3P9nfFwk9aqVUG5lCv2aCTIDKg68QfVRQ1rl9yu7GpzvkBGrOol5Oaw/8aRv7OBll6kaVkwOVBKxRFfEWo2NQMGW4I05g+2aU2pm
X-Microsoft-Antispam-PRVS: <MW2PR07MB3978A0F9A411B0D89286179ADD910@MW2PR07MB3978.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3978;4:Za6j7mvcYH0Mu3pIqClay3NRIVcPpDbvzBvU/CYPs1uwomRCcvqnJ1Eu2n/VPnUwxC2WIrNIW5r4E4CblPPMX/+hySCJH8mCsayPkJZ3PgFlgYFuJZuXmIoe+HkXJPCfFDKffd9fz1iRY7m0d6PyPIChaCpzpNnl4QXbmneDYgqOco+COMOWt0HQ/+YxKHkDmPsrVpRItgEayqx2YYJczW0bSz7bAmaT2r7eforKmmAqHKDVwSiMwcbAcpty6q1TYHlLHdtaaUnHqh/5/aRJkKg/RDYe7kaEEpKzlzD3jC8=
X-Forefront-PRVS: 09347618C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR07MB3978;23:oiyboxiSlUzOZx9bFGDgNpPe76CAMhpKl5a2faT78?=
 =?us-ascii?Q?AIrvE2xw96YbHYMREz9ZerszfbzHEom8C9V2/bOsKi4h283D9MYovLH+qrHV?=
 =?us-ascii?Q?HS9v459I+DLA6Az3A87XMGc+bsv45Q846ZCYtBiTsvwbKwewWPVZGkbaRUMk?=
 =?us-ascii?Q?xFwcssKfhVOgtLmBoaQZ5Z4RcQnj5SAFMmeeR1MBPeS6/Y26+UL4rEJTXdpU?=
 =?us-ascii?Q?0tCtl8vPiGmVPD8AHifT2EhYFUmsOiDhw6XZ5gE1DdQ3Ojqz7eJspQLi1xYr?=
 =?us-ascii?Q?8cA+robkBc6ARGd/v80Fd6icadkJYeg83A3sgrfHRnuiDwjdaiI7ICCMylgs?=
 =?us-ascii?Q?S/k9pzIzamq3N98IV1pTtakEFw4Mxke6YP9fhwfafhVRZPFhFIeHi8+d6PFD?=
 =?us-ascii?Q?oINevhYxlQYCrKivzLgsRqG8nDqC6ZOg9KJXXpAydykYC3irJzfp2e+X8S0Z?=
 =?us-ascii?Q?elNIhl5KWdVMH7QYW/1s2aPneoypy68IdSxne+MTaC37wpGhwiBNy2qAlT5a?=
 =?us-ascii?Q?nyISpZze9YrMv4RodGH/AKDg65dNsM3wSAI7m4zIWJAJ8o4mrTwKhDnJkCwN?=
 =?us-ascii?Q?8UDfOI61fErw3nrfKFR68jJtLYz1jxcRJ/7MNhS0fiQP160Jv8LaW2rVRhpt?=
 =?us-ascii?Q?P1d2n3grlCExEfgqpynUoF2cuPpRjuWK/jpaEFgOk0G49/Um/JvsowT704gu?=
 =?us-ascii?Q?g8S/D8X+GBOtTRXmDX4bNrer0o6lbcxV9xh6qXYpKGbyqV9pAX1vssbXNEWH?=
 =?us-ascii?Q?ydSJk5V6lEWY7m99fHlFUEfLJriXSrq6xxoiEgTiX/Urvudays8PLe9RRBqE?=
 =?us-ascii?Q?zM8OXiUzlWX3EvDHVg4EN2VDsQRj1ttfmZvHTFtjkhsru7nHlq02nDx7dVgA?=
 =?us-ascii?Q?lJMHgE3rjmHI2byvBC4PcQIKKs7z7BpVZjhs0xm2MytJ2iCdPOUApY6rX6Kh?=
 =?us-ascii?Q?/DKJz63ujYqUEGHhWaFnGmLrZmaiZocsu2r+VURO8VBXO+XTK3U/8bzClQic?=
 =?us-ascii?Q?lP5uxErE+rUKr2MJkGiMyypVeLWL5DMSMAtG4peaMM9CmyKDp8QGEUQyrwg2?=
 =?us-ascii?Q?gfi70d1zl5r4NYJPAsq7/aNpa7gGToEqWpnLQShPUI0uCE3kwF9XaGL1dszP?=
 =?us-ascii?Q?tejo1EmeHWAMW9P+p9/pf/hTLNpaU6J?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: WxGPeHv5M/QcOigOgC3tuckxVYr4+wXedhC1E9bxl907gdcBN9TtGkUxh7lpxUK89YRuX7vw3dbKTyvgu3ThlX9+c/PCOMVN+l1C3haAM7ezKOvQK+WMbwqU6/9lZD8vUhcvK7wyCtHecwTTvmzx3RU6NyTcIQ6H7CfT9eG7hZ7nU5LfKAuZC2CRhlfcTK7Adm8RkYnC7w4vk9LF/u7Nbe/5h5EuUwPmI6vEKobFzyaeOwKf2HuGfUIDiI0TPk80rSYt09Gtsfufh/VOxeJiop0OxIP1KBgsRlbh8rQUVrhw8SPJaDP+nOMjAcuQTcR63OXUKwOzqo6XGthqdncWVzT59fA+paqL45MT2cBH85idWRCja/oHcAJbmmBtOnC8Xw9v9zC/SHvUkP8TPpKJqjUt3ovjQyZEDoH0WeXdcSw=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3978;6:yksassvVTeE9UnHs1445JmCAXn1Q2GMEHrpzCzBX2RrigYlrAx/5zc6t+vNegI4zwMGLbl4i8ggAlUWOoQoA8nTd+kcMaIHMYaUCshfOypKLbTUpcIK43gIGHRnmmGRk3V2Hpue+LnQatY8hiFLYm2AOuvPf83icDnquvSQA4VTHr3i3610Hs2yy1ysJQ2XRm4HAoodfxYdtBiRCHqpJdhSZbdZwklNUQI/J2GBJoaHurSbM8oGZnhikqqCT7ootSswQPoy/e7EJicNbE/rspAnzaaEPNY3dFRRnsb87AV4vq1f/zdbrQu1xRlha0mgr23DIA0PikhyOvUALIDj5x710zhCWCGXVnQHdARLeE42qFqJ6j8gix+TlCblCIRHwz6S40YkTeib+pdROpI53wNIKgWh/ctqHhKN27kT3YYy4Kpt0ncbLObdF1LRDLBADmMqJbj+LWtpn8YhViwNoEg==;5:Ma/0eVsQnXn+v/TRWAiGQNog3L+htpJCGXQvZ2XCwqcL2oB/VZ8DV9nJ1fs6IPXop3XSYjUfY8BZqbBK6eL/hC1jS/RhGfXcVRcS9HE3W3NAw+FDjNmoly8d6lq+ezbHzMMISSmCXv/g6AL81xZjyfFkYKmMQFIL8Ap/zP7h27V0UlrKTgbdrrTJn1aa+WPgROvMHpUIIkn+o7h896vfXA==;7:XtBgRSuIHZT79wADbcQFEl8Mw8WNTY30vDSw4xrBTqb4qxPg85ZEWXN199eL7kDvjtUoJW1M5n+KXQikJi6JIk+d3MI6tT88LETvWV4+SO5iBqc6Z9V1EB5gvyFaPKi7GbQHIdLGIOaCMVcNIHHbyQ==
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3978;20:DmDbhwTyYvdeay4qhwZtQtRVgc+gPm7XyaYFF46oyl3c9TTsFm+mNtB6dyVFcqp91zPJszLBW+u5wAibZtnuwtfLRx+4UVd0FjSaU3jB93dD2M2PRzFP0ERfazZJopaZQRMCh/S7s9tnm+UtLbYiP4m56Tf0Ohw9aNkEavxVImEbbctfHHvYDeemJiXMu/H7MubtwGtcEHnLjgjaPCfNtR+/oU4VQLda12TQI011s8MRVP3Dz69kNezfyloHkcK/
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2019 11:53:09.7853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0902ae1b-4ea7-432b-c068-08d68772abd8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3978
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=630 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aim at documenting USB related dt-bindings for the
Cadence USBSS-DRD controller.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 .../devicetree/bindings/usb/cdns-usb3.txt     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt

diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3.txt b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
new file mode 100644
index 000000000000..6dc38be77f5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cdns-usb3.txt
@@ -0,0 +1,33 @@
+Binding for the Cadence USBSS-DRD controller
+
+Required properties:
+  - reg: Physical base address and size of the controller's register areas.
+	 Controller has 3 different regions:
+	 region 1 - HOST registers area
+	 region 2 - DEVICE registers area
+	 region 3 - OTG/DRD registers area
+  - reg-names - register memory area names:
+	"xhci" - for HOST registers space
+	"dev" - for DEVICE registers space
+	"otg" - for OTG/DRD registers space
+  - compatible: Should contain: "cdns,usb3-1.0.0" or "cdns,usb3-1.0.1"
+  - interrupts: Interrupt specifier. Refer to interrupt bindings.
+		Driver supports only single interrupt line.
+                This single interrupt is shared between Device,
+		host and OTG/DRD part of driver.
+
+Optional properties:
+ - maximum-speed : valid arguments are "super-speed", "high-speed" and
+                   "full-speed"; refer to usb/generic.txt
+ - dr_mode: Should be one of "host", "peripheral" or "otg".
+ - phys: reference to the USB PHY
+
+Example:
+	usb@f3000000 {
+		compatible = "cdns,usb3";
+		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xf3000000 0x10000	/* memory area for HOST registers */
+			0xf3010000 0x10000	/* memory area for DEVICE registers */
+			0xf3020000 0x10000>;	/* memory area for OTG/DRD registers */
+		reg-names = "xhci", "dev", "otg";
+	};
-- 
2.17.1

