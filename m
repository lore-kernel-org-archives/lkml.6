Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36548C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB2C20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GEsWA7nJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB2C20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeHPWWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:22:24 -0400
Received: from mail-eopbgr730063.outbound.protection.outlook.com ([40.107.73.63]:36736
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725803AbeHPWWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLqKXyL5su2qIqbnNM1aGY3Ng16mCd3HPg67nVctZwQ=;
 b=GEsWA7nJty9dNtn1frlTUkuWz6bTkzZTa7YWh2/NVx5tlA9oxYJcWMOUamjgK6eSb8cR2RonG9Gzt3zX0kervFuSzrWwU8I4DVCbiJu/8RvKzgBXITsgQOf/L6cQj622uKZf0ZlxVI7RmP6OnvInrOOV/l33WnMM8NqogwvIKTU=
Received: from CY4PR02CA0021.namprd02.prod.outlook.com (2603:10b6:903:18::31)
 by MWHPR0201MB3516.namprd02.prod.outlook.com (2603:10b6:301:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Thu, 16 Aug
 2018 19:22:00 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by CY4PR02CA0021.outlook.office365.com
 (2603:10b6:903:18::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Thu, 16 Aug 2018 19:21:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 19:21:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNqI-0005ju-S6; Thu, 16 Aug 2018 12:21:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNqD-0007wo-Mj; Thu, 16 Aug 2018 12:21:53 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7GJLoLn021523;
        Thu, 16 Aug 2018 12:21:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fqNqA-0007vv-2Y; Thu, 16 Aug 2018 12:21:50 -0700
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
Subject: [PATCH v2 2/3] firmware: xilinx: Add APIs to control node status/power
Date:   Thu, 16 Aug 2018 12:21:43 -0700
Message-ID: <1534447304-12919-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
References: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(438002)(199004)(189003)(336012)(6666003)(186003)(72206003)(486006)(476003)(2616005)(50226002)(14444005)(110136005)(2201001)(36386004)(76176011)(7696005)(9786002)(26005)(478600001)(7416002)(305945005)(107886003)(77096007)(54906003)(39060400002)(5660300001)(11346002)(16586007)(51416003)(426003)(446003)(126002)(36756003)(50466002)(106466001)(44832011)(316002)(4326008)(48376002)(81156014)(81166006)(8676002)(106002)(356003)(2906002)(47776003)(63266004)(8936002)(107986001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3516;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT050;1:jJ5jpY1eB+1y8wGLXJCqtj3CPCZsOFVVCz+Hy2+RJ82vc3x7XzaTHgfQrDGP8svckryOh1ZbnvR/FP9eLUO8u0gJsnyyR2U/CY5ONWTKXajAf26SHWck8wgOXzPdb8AI
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bbe2061-7c2c-4368-8837-08d603ad89e1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:MWHPR0201MB3516;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;3:uwheLtm9ZjLoaPgHSN3WjbNd6UivPjAdSDDO0dSCLqgPrpbryVp3SdiujFGAfO9GMAbFWWTTCRvpaPzK8hZSD7zhUg+vNKOewxSkIzHw0yQtJkStfm0NOKTq6s4JCc3xZ7xNcs8lNwTrW4tNsNZMObvO58AzNS9i9E5PP9q5/wOgXHzVuSPHhlShHUbVJRe9bhp3EhS/iulT8SnogRH016sbOfhODcgOEkKede+eb0iB4C7Mbsf0TwIWwx5fVqIft6yrT4lxAc/2h3OFIcnAEOML/1JwWR4IRIuVmFGTzZVcVecIsNhUOqFAwpRUoiOP47VD3dghXN4NCrWvhYo180ajVpKn/9xOtU2JPJOGlKU=;25:meWymfO0F+OXAL+RjGq91FOiP/82tOzgza9t+RRRNN/IBxWiymeriLS45lkkvMKEnWJaiYHBZ5b3fE4WLH7n5wmCM0Xd/Pp6tZ2SwbHJJws/jKBS+FmdYrbtzT/KaGvkss9rgwAYstXlBpiWfQ7NSRu3I/eFlMV+p+Ij79QRF2arlBNioFpgP1yqzX4+a/ENC300gOMLDkjAGx0EIelZ7PD9BNpdvgZtwhLWgqWWcPO6Tb8o9FrlX473cgpINnb8Jfi+07MkuTFJXAbc0Uw31e0m5PhgufDZXUdU5UscvAqiT3nKdYA7I0BiAbPUTwxYTyRDtsGa1aFr315wp0Cw8g==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3516:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;31:M1PxZ6rto2Rzyy+oVJ1a/+S7j30H2ER5lKX/lGA6xrDSnHOg2GJ0N4+u91zX1Qoo8nS4iaFRVH9ME1FQG79UApnipmST/dShcbC/IF9XErhLJ9mJ8ZOnFH0zvj7deUPvML7aY2ukDnt3MLt1+gnXnDOiX48MwLB2YF460wulxLHe309tcoA61loJsRFjxf6KpqKRYPEQ1IcFQM4lAAntrOWyVJN+SWdFiUKBssrX9lc=;20:7xHkJiCSmgw8ctK2Jl2GRXdu0gNNXapQ7Vicx1KSdfw1iQpvvQl7m6feE2BtMjkHyVf0yGnsYcdsjuqLFRWVOLJLOgzFt8u0myZbg9HX2U7AIXwbEw5Fu0Vy86KMJvtHS6YDUkU+KIwRKt0VliJ/73/nQ6Q6kEDCNb6VFh+tA40ccY56kY8YiPdY/t5TPzFGqpKFZyHV2EeMUb0BGsXipixZ2JBaLmdEE9TMEbPlZSMpVIS9w6R9NDWeKBgOMvozpQrUQVqXUJ5+bGfhLs7QN0n/bY+BwI/T5YZU87rbPHf1Rh8V8g7PF8V6oGFeFhF7gQ1lGNMUEUJgQvkHj0JrVojZdf4yWwLH3DGThVLl5XPxW02PdxSLUltWsoY8Vjuqh0CAVFmCBjsDKRpQIaSqr/6PxsbIoGymDnPoAd8VzsjyQxQZytJL5tfW+ma1/mvpWa3ayVjfC6TJeZh0F6Sf7tFHkNqzF8B34h/fecNhBinDvDX9deh4FXfbF6WvSqXR
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3516E8D47773D5BABA9BD6BDB83E0@MWHPR0201MB3516.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:MWHPR0201MB3516;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3516;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;4:uZz9G6FkbU+E7qdKGk1ktDeZM7SwGqyoMC2OQduFQw7KkXbnsCuNCC9Z8QMPAu6Lzh4ZJwfBuwM5/WJlgKJuUDG7lh8Pc7qePSd7nptl1eNEFnmWyB3zqMa89sMpk2krZwN9pGYqdJYU6NRqcmM0Rs3A0spG/Iea6h0PP/g5lkSB852RdJqzUh+khgLoJgJ24geaLtHb7cU87puun23WHPn0kw83SbrS93+x+fvxW20r/pkcTyBmyOd1lG+yM3SdG8yj44PTqlNSbn248yRAU41MKVi9n0WlQNfqnZTF0+lnYr+cpjn7EXX5+2d8RoKm
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3516;23:j1eVJfcHI8AkXvqQQSHNrUzEntM+Mr5u70027+u?=
 =?us-ascii?Q?qX3eboCSybA1Zbw5lj9WxMo6HAKK/CviyUBAhKlQTnMCOdNnXVY7qy0MiK/A?=
 =?us-ascii?Q?icwgzRaIWtlmASXS47E2n9iqRPEtFFbr0GgRaBAzIP1R6P6Xie/enMVajW0W?=
 =?us-ascii?Q?OaTczKFZJW+1yTXMd2PYcUeuoMrlsKSliBUUWc5we+LQT5OBSt9yKfyDS6rF?=
 =?us-ascii?Q?UMtScMBiV6wVbK2CIR6/tpnJxZ3mv5IU36VNwLR90DIOhRlrJz1C3IazxNt+?=
 =?us-ascii?Q?ru6hr1TU/wwDxhGkpHlyoBFyhiFtBTATDME/KaHA95qzHNOISbAXDJQbWX4p?=
 =?us-ascii?Q?t79KAn83zQig9eS+UfzhbHZbJk7AkI6C3WV22/8UdmwpFkWR/A05kZ37pvy+?=
 =?us-ascii?Q?Xat7iGB5ap/7T488f6Q8u9291q7mE9k/Tl9Th+2yr90ZCubnHZ8Ywha8TtG/?=
 =?us-ascii?Q?QpDyamz6q2Bydbw3ervdDTn/iUWq0QKRlY2oySq10cNoVu5TZ1o6UEsxILWa?=
 =?us-ascii?Q?zcttGLYThxYxtQlfYRMQTTdWNBI0PIQg7pAwBbj/v0d/KTMynAZ/Tpr6Rg3o?=
 =?us-ascii?Q?5SduVsTPi/P20O7ay7PGkug2q9Cldms9Yl/jtnmnCuuL2QYOgPvEOWNXvhQL?=
 =?us-ascii?Q?FmQcuNrx1129owOYyY/ZjhU1lD5fMuMTPFwJn/G5kOpLxHRECRXPc7AbHjmD?=
 =?us-ascii?Q?efhGtVOCLEs+WAWACrbGyJMwbUK6xAXbEsLweyHY0m1HuAR5Y+fZEMtXVdvd?=
 =?us-ascii?Q?sycoEfkqCGaNZA5BcjXJ6hnMM3ISI4JeNdDFktUTxMt+nlRf8RN3xGFUrtEn?=
 =?us-ascii?Q?yxoqimFJStndCgcm1yxTBCpSSFfZbD+nuHKN2XUqSgh6vcuaRaC/sEYbWMP5?=
 =?us-ascii?Q?OMy8OQrExQWzXBRS9gHQC1wjWL4irQ2t3mvQz9HZ4Yds4oBZuaJCrsJtmkGq?=
 =?us-ascii?Q?0V0GzYo0VqJxRbt81nSKLsjihyKdj+7osuXmrvIoYgqEu8Uy8D3AKN8i2iRz?=
 =?us-ascii?Q?6EGkDwwr0ocSUEL6czgxnpOaP+OKQ++28ng3YAjfwDf82rxHCWQwWZSIZkxN?=
 =?us-ascii?Q?AL8pcUci1Y6mOfdynup2XbhHppdwCKbGoHFjPRtsOsCXwgCqJsfxUH8tcvRt?=
 =?us-ascii?Q?t25d+xfzzsgovYDgwlLAGZctse44m77mM4bpFpVQAGu8LmL7dhjNK/0C99pS?=
 =?us-ascii?Q?HsmPAGiAGTbzvsou1eKIRDaVSJgM0mcm88oy3nB1RD4nrsmVG624E48Qz/es?=
 =?us-ascii?Q?u8aEA075qAVxJ2rPMn6JpqREHp6Axs01PxfpCuQrJScfD+vunY6WKmbQrNBL?=
 =?us-ascii?Q?JMZPXljHzdToQL6Z3ntJ/u60=3D?=
X-Microsoft-Antispam-Message-Info: 32kkQqeX89Dd4PpR5dIw+tzTFrRx2Gpk2vsVAJ4Wp9+wSNao33x6aO920Syky5mF6vxNSYsM9g8dvrDWKz+5KFWNO6jJHH6NAVpEfu1Q8JMvXIOh8gUL6jP02NaI9wO1ieEP3Dwtu3qX8bmn3YeSOylenLmkq5aPaeVuS9nQf4fMN5lLTcJr8W2c/fSEnP4CN1+dFcOg3YzSkoz+CbiKE0Ox6jQPVNDaFojSCuo0RfFZts4OyR+FuyeBkSTzdHk3cgedT+cwv3d1E94vzkMTOddB0dGvceqMcezZtKVzV+5oC49g1d4Py6dcoLj/sb2P80sCGL+8o6mM+sCoH60n8WaRGCrZdjpJk9Qh8ec1oyQ=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3516;6:85KxmM99+0j3/hmW4PLikzm+hYMW2pTwUdxZQftKE0xfUJz/xPqhYeR6nOKzjg672gXzBQVCpSqrxnbmLJ6UWh9hZqQLfTCve1T1Aoe18i7zDF6mPkj6j+8z8L6Q4WGPnYLO+Prp/Dfnq52iEnTpDft89X92AHvJLfyrnqJHCYRwHEesoaEZuOdUNgtF4Nc7q/aI8sX9ZgVVAaKBNcrKF39KZTs7YKEJrrAVLKSwjC72vAoj+tkEbU4IpK94fzTmN/g+AKdyDHPtjoEkiDlWjoLgnTF/5Dui0o+c6VtszqZapmykYrN11yBax6icvsOHf0rOaoNF5cWp5FWrE1+BVlH7mlwdyWTd9mFV7wkS2dor8jtNoMzzY5aLIq+W0CgbiuXtagHSy3Y27OZJJyVVT/njRCZmppBB8HoSLAU8Kv5FdvTTr7uxkKnUm16ZtOaZx4eO1o79suzspM0viVt84w==;5:ImBKQcnTK9k6idrmng+XA7Tzgg6Ew7zV6Hn19m5fnusPiRm7g5sEicsKLODmlPHc8OToxDFdRSFRU9u1whCkR8kjFXrgPGn0D0WlmNZTtnhLemzOytKb4qTmmGCwdD+jY/icoLFuokQGgRGiBDQVJ8WfFS35bZ/LzvyAzVrLY08=;7:nlucYtYcFGvy9v6b5ddyDp3lk2JXBknxIYRcyqYOpomNI4zR7V0uH7tPEVQLvrEYLOV5hCDu696dghW1zwzdNA43I1AklP3dZXD8OoiEeklOTk/KsUpslum87q3rdlDpTTt/lfa63kcMAhORnJd32WsYou5goaJpjFv2HeKfCR28hu4QKMGltspiNLw2f/nTziN06VkpkzLlZCa4FEC9B1/VUi6W2UUP/Ar8K9yPZzVrVFuLl+VyGkmu5ptxckid
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 19:21:59.2144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbe2061-7c2c-4368-8837-08d603ad89e1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3516
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add Xilinx ZynqMP firmware APIs to control node status
and power. These APIs allows turning on/off power domain
and setting capabilities of devices present in power domain.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 58 ++++++++++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 26 ++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index ce6c746..c54696f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -447,6 +447,61 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_request_node() - Request a node with specific capabilities
+ * @node:		Node ID of the slave
+ * @capabilities:	Requested capabilities of the slave
+ * @qos:		Quality of service (not supported)
+ * @ack:		Flag to specify whether acknowledge is requested
+ *
+ * This function is used by master to request particular node from firmware.
+ * Every master must request node before using it.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
+				  const u32 qos,
+				  const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities,
+				   qos, ack, NULL);
+}
+
+/**
+ * zynqmp_pm_release_node() - Release a node
+ * @node:	Node ID of the slave
+ *
+ * This function is used by master to inform firmware that master
+ * has released node. Once released, master must not use that node
+ * without re-request.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_release_node(const u32 node)
+{
+	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
+ * @node:		Node ID of the slave
+ * @capabilities:	Requested capabilities of the slave
+ * @qos:		Quality of service (not supported)
+ * @ack:		Flag to specify whether acknowledge is requested
+ *
+ * This API function is to be used for slaves a PU already has requested
+ * to change its capabilities.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
+				     const u32 qos,
+				     const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, node, capabilities,
+				   qos, ack, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
@@ -460,6 +515,9 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.request_node = zynqmp_pm_request_node,
+	.release_node = zynqmp_pm_release_node,
+	.set_requirement = zynqmp_pm_set_requirement,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index a3ef7d6..6a1bdcb 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -32,8 +32,19 @@
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+#define ZYNQMP_PM_MAX_QOS	100U
+
+/* Node capabilities */
+#define	ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
+#define	ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
+#define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
+#define	ZYNQMP_PM_CAPABILITY_POWER	0x8U
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_REQUEST_NODE = 13,
+	PM_RELEASE_NODE,
+	PM_SET_REQUIREMENT,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -75,6 +86,12 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
 };
 
+enum zynqmp_pm_request_ack {
+	ZYNQMP_PM_REQUEST_ACK_NO = 1,
+	ZYNQMP_PM_REQUEST_ACK_BLOCKING,
+	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -102,6 +119,15 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*request_node)(const u32 node,
+			    const u32 capabilities,
+			    const u32 qos,
+			    const enum zynqmp_pm_request_ack ack);
+	int (*release_node)(const u32 node);
+	int (*set_requirement)(const u32 node,
+			       const u32 capabilities,
+			       const u32 qos,
+			       const enum zynqmp_pm_request_ack ack);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

