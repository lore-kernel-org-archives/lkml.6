Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF410C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE15218DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PXHeQO3t";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="nNkVw7w0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbfAaLx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:53:28 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36592 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732255AbfAaLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:53:27 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VBqLP0024071;
        Thu, 31 Jan 2019 03:53:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=sO1EaMaYgsyvn+tRi9ew2qo1I3rDX9a3LFCnWIpIlEA=;
 b=PXHeQO3tzET4+G9Em/O76LG47rZirpxRpFeNUAetd3N1QX6hS9dZFXokJKeTo/JKAfCJ
 5IG/Vp2oLaKSdtvoS1cEjbj2GW4/gPKJ3wM71OUEVAO1cxUPKOqrngGnLt3Qn4bI9nE8
 k0w7Cwvs2HnYMoygeAENCRhfg/Pj75L2ZVj4DEgrfgruIfA8pE/wJlM9YwJVBQ/Sfw53
 5Ixi4geIrNVAeIl5bvm0S6aqXq8MW2vQRhgKi5zTNg6PMCoxWUwTxqX5bwo2GWPikug5
 uemWpES/bTOLs5vs7Jz0dvNSjdiXBY+VNjhNuL/doSodXRufpTVkBQI0weZJ+6nCEjnN dA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2052.outbound.protection.outlook.com [104.47.45.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qbjukkbu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 31 Jan 2019 03:53:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO1EaMaYgsyvn+tRi9ew2qo1I3rDX9a3LFCnWIpIlEA=;
 b=nNkVw7w0wThV8dEDAATlWPcWAm6RRxVOQz6ClOQaqXmrRgj9YvOJmv4S3jJl9YFdY6SYGjVX546Bf0C/T0ni5Wnz4W5G5KO7Ua9ri9gFkJJ6qcpr8SQa9MqKHOVEkN7CnwFDJ6ZA6Hjz5NvOv4s5tgjz5JUtzL9IrjV9Plbofb0=
Received: from CO2PR07CA0057.namprd07.prod.outlook.com (10.174.192.25) by
 DM5PR07MB3099.namprd07.prod.outlook.com (10.172.85.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 31 Jan 2019 11:53:10 +0000
Received: from BY2NAM05FT008.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::207) by CO2PR07CA0057.outlook.office365.com
 (2603:10b6:100::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.17 via Frontend
 Transport; Thu, 31 Jan 2019 11:53:09 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT008.mail.protection.outlook.com (10.152.100.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 31 Jan 2019 11:53:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr4Sh028139
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 31 Jan 2019 03:53:06 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 31 Jan 2019 12:53:03 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 31 Jan 2019 12:53:03 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr3hh002226;
        Thu, 31 Jan 2019 11:53:03 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x0VBqx2B002059;
        Thu, 31 Jan 2019 11:52:59 GMT
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
Subject: [PATCH v3 0/6] Introduced new Cadence USBSS DRD Driver.
Date:   Thu, 31 Jan 2019 11:52:27 +0000
Message-ID: <1548935553-452-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(36092001)(199004)(189003)(486006)(316002)(51416003)(107886003)(54906003)(8676002)(246002)(6666004)(26005)(50226002)(16586007)(8936002)(4326008)(42186006)(47776003)(39060400002)(36756003)(356004)(6916009)(26826003)(126002)(106466001)(86362001)(7416002)(7636002)(87636003)(478600001)(336012)(105596002)(426003)(2351001)(217873002)(2906002)(48376002)(305945005)(2616005)(476003)(4720700003)(14444005)(50466002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3099;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT008;1:i7yPff2tJXrgTcChxJXCC4wYR55LO5hj1NRq1Z6tnu2THXl+03Fcg9tKjEoG5jt9y4/I3jtxVaRHdOJhP2QN3H6huCc+Woroj/KwHoUhG1vqhkMXMKIBwwX2hffRmgSpEtTddzDauzs839nSHvTQUnUaXmQXVCMcrshBDDYxzQY=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a3cc7b5-2d3a-4643-fae4-08d68772abb6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:DM5PR07MB3099;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3099;3:KAgm4959k0nFGJJtPZHNCN/4iyiO9+bE6nGioqljG6y+2bpmni92+nSBHc7nF2uTr6MOC5k/AMLbOXRXBDDLzcrxsZtOpiDVhtXYA2bAnUiYZzeuQxJdP0uMEdo15U3Cbrjy5ICrUOmUVphLM7DewT1gTIf0QjIuIRQqiJJVjph7cfR9NUcTiz9oOUuhEy7skUGIcVW76d1BEMBctkZjZkY2m2d4gLOKygKH2Yv4kb3Nc3o1uBJH27R9atXpd3+my46dWkHtuhKX94ZcY6l6PeOCSkECsAmMfrMY8l403G1L2xfUVQCTcRdjrQRb2mLFEQMDYlcZgis1L84i0Q5i18+ic75YWHnsu7fD8+3fjg6L1IUU8XpxUhQXInVU6H2v;25:Lj9xQlwqwH5FWmJJnfnNpFvGTMaHBwDTmbdVrkkNKZOHUc3rKp5lhbUvNog4ejqE/74llzk6NQntvS1+agY8OpG/04rabxXLNN1HmvS0j4B1BZqOHUClQdmw95Pjbt7KIJV6C1yjrneg/zTk6/ArpuhNvmcaH7IsxXdV465wdvnXocPFCUd5v3WaL5Sw24BcMR/vFMMpVfQK+62qZfKUpkUhZBa+FCyiSBRVJwCZfONCe12UQMgeARzRwSdmZ43sQs1rWBvs1aRm+9WARDdTFdxEF/Wznlsts4+JA8Hux/mZJWJPr1nfahq0ODa3uBeotmWEmGDVyTlH+aAGcWSYSQ==
X-MS-TrafficTypeDiagnostic: DM5PR07MB3099:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3099;31:y15a8NXgaPV7vDFAE8pzJKKgNqVk5nu4j+Ull9CoBv8crfh1iFLOWQZeyCWdMCpjnngMjKePt0vTI+cgFukSdqgzPwLTyaRQUearhgOvO21/kfxnVh6sQoVWRfjVaPcXwuYA0ZynIUMEgKkDpKvWfwpaY+cCjSVWu/gqZGneVSWtKqKmLfBGDEOsh2FRO5/1lRH6eDpxWth/SuPGYGZopvo0RcdukStcCeKu92+xWLQ=;20:XDxbUUlZ6rFHwOEH+0zz+TfZQTDZHTpI/sM2LqSA26cj5YpBhATnDcc6vwgHhkyNYtaU7apaEWj3snCpYkenCkHwfjuezUVnPL3/Wol7WDJfoMXupheC6FoZ5TKpNxZ9yb5yRogBFcvMSCDg3DhZCh8n5zOqxAxYsYGjZuBlFMlg+aTGjJ4Pa1BRetLZae8zGass+fm6LRMP2c1Oj1S5aooPQ6p6GvgRP1VyHKKYleFdNqXL/uQ5Katqt4/WkgN8fJQ53xP8fiLFIhJZP2MXdlQK0MG47toKwQi2g2dTQ9ZwIFGZfXfipBGvNaeYz+6z+43lYNU/7pvtg6tUoL6Z+5ZlsYlUMKK4pjNWBu2LS/q7sUAua7xwc/x9yXdzBHyjUnSJg7h6DH5Pwl3HMlJpAzTfL7xVangrSy88yLqrL5jJJ4srX98Kg2Dghuim6NMRKyBh9wF0pdQLhS5O/FbtQee3ruIn7kmId1cdGPHR9R7lX0+n/Pf8xP865c+arGtJ
X-Microsoft-Antispam-PRVS: <DM5PR07MB3099645AA8B72664152CC0CCDD910@DM5PR07MB3099.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3099;4:aKmZy0I1jk0UgjALsBYemb9l9ifkKszLlcYiT2yHPPLvPBUaOkT6UeyiDmGDmpnaW9OZxqVOovKauFjfRed7km1yJxljMgzyizku5P9ALHw+JJc5CxKfbTWVC6cco89TO42UKXDUBsLKJ+mBggClR+7bTEkvkl+ga5t/0PBZ9BEa9mcGThJqTntNp072hTiQCdjDDgh7kCiDiCwzM2lGFyKIrzUdE6hNo0h6uBcLpopiM4QcLCG7wO9u9aN0a85n8A0XiSs/teMo5X+wt8qP1TjEJy4mqXm1aT4MUdWdFgY=
X-Forefront-PRVS: 09347618C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3099;23:TalDiWmFvruG1FcmAEhudbT4XLUWDE1Y2eOS9qsWy?=
 =?us-ascii?Q?SS07FHKBu6n0q7DrRc0A3Hf9WlvbYNcvWEhLy8WR6pevRk3mK4h/VyYvMLKl?=
 =?us-ascii?Q?KRInUl5llVJoIQl7onZXIUA/QIKAYioHJjQXW86tKzzNNQShqDoNyqVcx/Ch?=
 =?us-ascii?Q?GlKdoUrwxuceIg5rhZdnPmi+UguvTrkqnJzFEMtRo5v/hrUTMMNMWrfwXx5m?=
 =?us-ascii?Q?3QnUmGTN8jkw3JoC6peiFQnYQL/KhLiRMyn1B+mPomwHb7oVE3GGTYKgxVrm?=
 =?us-ascii?Q?QxDQMY5Z/+vIPVQ9WD6M5AX7MKEuy+wUKkTD6tLRIVBl2pyqokun2sSLc01R?=
 =?us-ascii?Q?s+3Pyh/2sDOMwOQw10qggLYmXvIM5FVZTZnbUXJJcYCKa3ZAD5zBA42BCZly?=
 =?us-ascii?Q?e1XyfZjHUK/bq1+h1K964HcAAcx0WGG32a+7wAlz2UF9UKvF1vuUwuuqJgOB?=
 =?us-ascii?Q?cAspQXaAxU140uCkuWUy9tooqhAOAivAvKT5ap8tyE7LIuF7v3gE48krJ03X?=
 =?us-ascii?Q?7ob7LdHY2NMf1/1bgCIzJqoxh8eQr6GFXxYTHbe7AezEBeKKjfnSxfdiJdBt?=
 =?us-ascii?Q?IoqJMBX1+B5Q22LxNoBw4NvK+HSLcF5KBBk2m6jNkTEL8W5YBbh9J92VWCJL?=
 =?us-ascii?Q?TXOCXR4JyB10GXJn+emUyVRuS/z1Q/MD9svpbvCWfdhra4+faqXE9PthJFXo?=
 =?us-ascii?Q?UlwEVPcVxT8Jn2rnloeXeFc/hkjh19OG0d+fTOIC6xh3ZBmllcRNQEJ4s8tc?=
 =?us-ascii?Q?w+B/2BsAja7Vsa3Tw5wj7PURhRb+ZbWwVyKT1t/CY3jc9CBraR5ST3ztUf23?=
 =?us-ascii?Q?RxTwWZsqjBdejyxIFk8QsWcqG1yt6Sn5y83cHaQeC9zbAbkh08rgBdMjAyfL?=
 =?us-ascii?Q?kyeZXmw3BsJvKCiOkPqedYV3csRFSYTmi4EA5hunQdzCSPItRfsUjvPrfF3B?=
 =?us-ascii?Q?JruL1AE/YOCR77WBxkBdIDfuvETcjZhkabgUGEuV1HEpoonQTWQjkTZl86cz?=
 =?us-ascii?Q?70Aga5YM9lcCoW1E2ookltrR3e/NUo81JZck6EzQw1gX2whrGqh/gZYMmugF?=
 =?us-ascii?Q?EyalXO67hAlnz7OL2CU68HtATjX83yU+LQffPZI2WKE30xLA2RL/1OSKMIwf?=
 =?us-ascii?Q?2zjrBCG7DI=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PogHRFIoV/NfgPTo2NwBkqkv7n87wuU6HdMyn+9++/UfcbsUFTalzroE0YkonZoUioC3how861F+EI4ZWfsJOsLvgHPI1ysyIhcpFZ5L9aRloaHHGJ4dsKmRdT/ymhHA7BOU28CysB7IqubUxY2mGpZPr30mC4mruxTQUlYHgDVIDowJSnn4swXBSKg4M9Y7SmLFn3KMs6ABB3QY3i7CNoXT1785h/LGnbvJmSJAguQf70OaU+AIfJlFEW1N7ADpcvwdI14aoWIAcAwDy7ZqK5kjL1/7xxMyW5PdwKLdp2QVPQtYUUbQSHnDTlcBI3bhljSTGm+OSNA/QfNdvdAu/Kty3plzAt9JuUz2eEdPvf4D99S6m+UkdwayBRN/pTDU+3Vel33GNG6BbVZHa2HFlH0sQGbiuxPEasQf9/rkojc=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3099;6:Xmd+a8rPZ3n0dKcmHW+lH6aMsPynOzqAcXwvkykObl5Xb7hCNlWILJs5N0iEMbekiEZaWvBmYE6sxZB0dHufIAttOx+ViZxCBLPvekxLTbChzK0o7SKh8RKhteQbU3bDTiIzzV6+wHTZfsxbldCfkFh7bCBEwnyuDHSLE7j2c36bERAAumAC1Zx+VK7YAJOxCaKY445FPFvZrX6LmWCtaxoZUejUmajs8GwMn5fHdmIND8XVc56EEoLRqkvbKBDGSFYUniY8GyCnpeT99QOnguMNVvWtk+e1EizYZWZyfZVo+AINSKasHJEG0K8DE/70YSjAzhR1KySDUJY1yz015BeXWAUOog/NGWHOj7L36vDX2qCXA8rZq8WqyBmnKVVZpICAvEDCgfv/QfxijzyZliENzfErLQvKg0Q3CoZnyL1n0g5vfCPO5sS2XqwuAO86E5u15oUnEmXWiNoLfphmBg==;5:1x+H2nvOkn50Dqk63LUjQXr0V2EDaYUBrEdYBv3hHwlMKVaDWbS4lA9GUhpWjJtKo/94a/afOdHaoSyWncyvtMIoPUJ9ZE/eIDj1Ya1ybOBiGnct6Xh6ULbdWkA6MPY35wVE+GkS+yiAGakNx9Gze2yce989HMw5YDY8ixI9IaUImw8znq2CgGjJaX6yZ9eKSuJ2OCPfDAVSFddGoZl3bg==;7:iADEs3d+r6i2iG9OVQrsxDTI7famf0ooN1NpE9jyGYYK7rZm/aSWKzdfY55q4p4YJ3HLWi7vr8MlgGJXwZuu9jTnTN1MYVkN4S9GQ53ovrI+IES4rk8MffLKNLqyNaxx0hkCoDQV5kM+9b66AS8QTQ==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3099;20:ufILPy+xfQyBeEgXAIUaOD355MlN5Q8v34C9TBLjEEwOIUlhX5So4zHRhJgNoF0v+5oGHu4R9BRXEczbEYhwNwlNEjjuHSXCmVIW+rbqBcMFPS73ZHAevfOYHcdjCVqrC8pszQsMo+KfvddU9Km8NneLHHPSwYJlKF0PqX/hs4RA/yUT9MvT6L6qnCJaOIZU0m3f5ipnTsXYb5uY8qIkRWZ2JjSWuInYz7ucoj/Re+fSG7MJpSs2OkKZb3WyNlr5
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2019 11:53:09.5700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3cc7b5-2d3a-4643-fae4-08d68772abb6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3099
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduce new Cadence USBSS DRD driver
to linux kernel.

The Cadence USBSS DRD Driver s a highly
configurable IP Core which can be
instantiated as Dual-Role Device (DRD),
Peripheral Only and Host Only (XHCI)
configurations.

The current driver has been validated with
FPGA burned. We have support for PCIe
bus, which is used on FPGA prototyping.

The host site of USBSS controller is compliance
with XHCI specification, so it works with
standard XHCI linux driver.

Changes since v2:
- made some text correction in Kconfig file as suggested by Randy Dunlap.
- simplified Makefile as suggested by Peter Chan.
- removed phy-names from dt-binding as suggested Rob Herring.
- changed cdns3-usb.txt to cdns3-usb3.txt as suggested by Rob Herring.
- added checking error code in some function in drd.c file 
  as suggested by Peter Chan.
- added reg-names to dt-binding documentation as suggested by Chunfeng Yun.
- replaced platform_get_resource with platform_get_resource_byname.
- made other changes suggested by Chunfeng Yun.
- fixed bug in cdns3_get_id. Now function return id instead 1.
- added trace_cdns3_log trace event.
- simplify cdns3_disable_write function.
- create separate patch for work around related with blocking endpoint 
  issue.
- Fixed issue related with stale data address in TRB. 
  Issue: At some situations, the controller may get stale data address
  in TRB at below sequences:
  1. Controller read TRB includes data address.
  2. Software updates TRBs includes data address and Cycle bit.
  3. Controller read TRB which includes Cycle bit.
  4. DMA run with stale data address.
- Fixed issue without transfer. In some cases not all interrupts
  disabled in Hard IRQ was enabled in Soft Irq.
- Modified LFPS minimal U1 Exit time for controller revision 0x00024505.
- Fixed issue - in some case selected endpoint was unexpectedly changed.
- Fixed issue - after clearing halted endpoint transfer was not started.
- Fixed issue - in some case driver send ACK instead STALL in status phase.
- Fixed issues related to dequeue request.
- Fixed incorrect operator in cdns3_ep_run_transfer function.

Changes since v1:
 - Removed not implemented Suspend/Resume functions.
 - Fixed some issues in debugging related functions.
 - Added trace_cdns3_request_handled marker.
 - Added support for Isochronous transfer. 
 - Added some additional descriptions.
 - Fixed compilation error in cdns3_gadget_ep_disable.
 - Added detection of device controller version at runtime.
 - Upgraded dt-binding documentation.
 - Deleted ENOSYS from phy initialization section. It should be also removed
   from generic PHY driver.
 - added ep0_stage flag used during enumeration process.
 - Fixed issue with TEST MODE.
 - Added one common function for finish control transfer.
 - Separated some decoding function from dwc3 driver to common library file,
   and removed equivalents function from debug.h file as suggested  by Felipe.
 - replaced function name cdns3_gadget_unconfig with cdns3_hw_reset_eps_config.
 - Improved algorithm fixing hardware issue related to blocking endpoints.
   This issue is related to on-chip shared FIFO buffers for OUT packets. 
   Problem was reported by Peter Chan.
 - Changed organization of endpoint array in cdns3_device object.  
      - added ep0 to common eps array
      - removed cdns3_free_trb_pool and cdns3_ep_addr_to_bit_pos macros.
      - removed ep0_trb_dma, ep0_trb fields from cdns3_device.
 - Removed ep0_request and ep_nums fields from cdns3_device.
 - Other minor changes according with Felipe suggestion.

---

Pawel Laszczak (6):
  dt-bindings: add binding for USBSS-DRD controller.
  usb:common Separated decoding functions from dwc3 driver.
  usb:common Patch simplify usb_decode_set_clear_feature function.
  usb:common Simplify usb_decode_get_set_descriptor function.
  usb:cdns3 Add Cadence USB3 DRD Driver
  usb:cdns3 Fix for stuck packets in on-chip OUT buffer.

 .../devicetree/bindings/usb/cdns-usb3.txt     |   33 +
 drivers/usb/Kconfig                           |    2 +
 drivers/usb/Makefile                          |    2 +
 drivers/usb/cdns3/Kconfig                     |   44 +
 drivers/usb/cdns3/Makefile                    |   14 +
 drivers/usb/cdns3/cdns3-pci-wrap.c            |  155 ++
 drivers/usb/cdns3/core.c                      |  403 +++
 drivers/usb/cdns3/core.h                      |  116 +
 drivers/usb/cdns3/debug.h                     |  168 ++
 drivers/usb/cdns3/debugfs.c                   |  164 ++
 drivers/usb/cdns3/drd.c                       |  365 +++
 drivers/usb/cdns3/drd.h                       |  162 ++
 drivers/usb/cdns3/ep0.c                       |  907 +++++++
 drivers/usb/cdns3/gadget-export.h             |   28 +
 drivers/usb/cdns3/gadget.c                    | 2254 +++++++++++++++++
 drivers/usb/cdns3/gadget.h                    | 1214 +++++++++
 drivers/usb/cdns3/host-export.h               |   28 +
 drivers/usb/cdns3/host.c                      |   72 +
 drivers/usb/cdns3/trace.c                     |   23 +
 drivers/usb/cdns3/trace.h                     |  404 +++
 drivers/usb/common/Makefile                   |    2 +-
 drivers/usb/common/debug.c                    |  265 ++
 drivers/usb/dwc3/debug.h                      |  243 --
 drivers/usb/dwc3/trace.h                      |    2 +-
 include/linux/usb/ch9.h                       |   19 +
 25 files changed, 6844 insertions(+), 245 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3.txt
 create mode 100644 drivers/usb/cdns3/Kconfig
 create mode 100644 drivers/usb/cdns3/Makefile
 create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
 create mode 100644 drivers/usb/cdns3/core.c
 create mode 100644 drivers/usb/cdns3/core.h
 create mode 100644 drivers/usb/cdns3/debug.h
 create mode 100644 drivers/usb/cdns3/debugfs.c
 create mode 100644 drivers/usb/cdns3/drd.c
 create mode 100644 drivers/usb/cdns3/drd.h
 create mode 100644 drivers/usb/cdns3/ep0.c
 create mode 100644 drivers/usb/cdns3/gadget-export.h
 create mode 100644 drivers/usb/cdns3/gadget.c
 create mode 100644 drivers/usb/cdns3/gadget.h
 create mode 100644 drivers/usb/cdns3/host-export.h
 create mode 100644 drivers/usb/cdns3/host.c
 create mode 100644 drivers/usb/cdns3/trace.c
 create mode 100644 drivers/usb/cdns3/trace.h
 create mode 100644 drivers/usb/common/debug.c

-- 
2.17.1

