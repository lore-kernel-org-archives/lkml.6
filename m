Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603ABECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA35D214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="niDY3U37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA35D214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbeIQTxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:53:23 -0400
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:65408
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbeIQTxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRFLOamB5d6g6J5tbeFJ04z+czbe6CyCzCs/jWCyjFI=;
 b=niDY3U37eqg8TpCiZXRya1fYeMOrSAze0L1kBu14VnYdV+m8dRsvTa3y/WrrrCwBic/gh45RCm0yy2gMFlv3+SCIkYnixKv+pF2L5fFd7z0qTNWQ/8+FsAa8tXrF0ugZKBS8ohK8rIeQUke48LxfaGw/5/BYDTt7153xhHSzwJ8=
Received: from BL0PR02CA0067.namprd02.prod.outlook.com (2603:10b6:207:3d::44)
 by BYAPR02MB4471.namprd02.prod.outlook.com (2603:10b6:a03:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Mon, 17 Sep
 2018 14:25:42 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BL0PR02CA0067.outlook.office365.com
 (2603:10b6:207:3d::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.17 via Frontend
 Transport; Mon, 17 Sep 2018 14:25:41 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 14:25:40 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:36847 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT5-0000sV-Sz; Mon, 17 Sep 2018 07:25:39 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uT0-0005Mt-PS; Mon, 17 Sep 2018 07:25:34 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HEPN0u007864;
        Mon, 17 Sep 2018 07:25:23 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1uSp-0005LM-82; Mon, 17 Sep 2018 07:25:23 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 6D8C6121463; Mon, 17 Sep 2018 19:55:22 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <sudeep.holla@arm.com>, <amit.kucheria@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 2/7] edac: synps: Add platform specific structures for ddrc controller
Date:   Mon, 17 Sep 2018 19:55:00 +0530
Message-ID: <1537194305-9243-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39850400004)(136003)(2980300002)(438002)(189003)(199004)(126002)(14444005)(16586007)(47776003)(426003)(2616005)(81166006)(72206003)(316002)(8676002)(63266004)(90966002)(110136005)(2201001)(44832011)(356003)(446003)(52956003)(11346002)(42186006)(54906003)(486006)(305945005)(8936002)(476003)(4326008)(81156014)(6266002)(103686004)(336012)(478600001)(2906002)(26005)(186003)(50466002)(48376002)(7416002)(50226002)(6346003)(5660300001)(36386004)(36756003)(106002)(51416003)(106466001)(6666003)(76176011)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4471;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT019;1:FYLtmTYzbz+m0rMnTEz6DPn5QOw0h4Io5Be4wkoLg5q6JAOVj+VZ3B82frJUU7JZqIdibZ/M4NSQ7nGCf3FtFkt9LrbKXZysZDzfnkG9hYHnUA9HRgoFU4oXoBz+iEou
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e30180a-1bc5-4d0d-1119-08d61ca9723f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4471;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;3:P/KKH+t7U8OwpZHLEqaFrYDLljFMty+IamR2Xr3/5vXUdj55bIA+0GGxBdjQhhQFy2jrLNftcDm1eljDbJJNGa3Q0Vu+ckIEiZVSPw9aicbQH6Cbsre3icPnJYEtHVdd8oMD2L6n6iI3Cm4UbAeoMTwRN5Z45F1LCkza7DL1xBio3XJjgRVSrrnRpBYnASrJ+qfetVpKz88NeHyiV260DQ2o+M1yl0gcq1zk31YTou93dkf+dNJIBBjdlQVB0UZQ+pNxLN/SCJF9QNM8dy1DZ9Xg9rohifnWYYsDDWndcpfOIAa/u7ZOthxG5srWAzZ0ypk02l5gVoqjV1CgZEF9YvsmUIyyg8kmgXQN7juHTAw=;25:cQO1xNkptaj2V5O29cXMYjxLcdRw14+sVcAbLZovtX2UB8tTM0mu8g8CmKeXg0eXck/+LAe68sPWTc9RH1gRvJYwSkl+OjD0U7kvCN7/U/rn6GtZ+xywjRLYMgDNUMd3Tc+VXQZ9YrsA8eNv+tppcRPUhxPJX7wI/Tq/bLkt/9z7KcHZkjobHTzRoD/4sFnWzNEkLl6tQ2PBjsa2n37YSIN7ewb5fiPdifcEDyr6qCfrgkArjNb/6Uc2JQXEb8zbtlMB43KLVvQ9lKzADHbY6twZsxr3bRxensuM442Q3XASL/a95V5nd2uPWoRK9gJC/bF6k5mwaEw7tR2jMgdj8A==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4471:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;31:AQQiYFei+OMrmHrTFwQnlwWFHyxEdweB/kh8uAI4V7hhdB/5Lut9qFDb7m29vdz8jqDiviHXgKNGwh1Z9EIdX4A6VUQ0PyF2i3H/AO9Qmth+htseZsZaqHpjUcqJVUmzbOQRe0TcuzewqmObuQ52ONvditSdDJ3seOlE1EvYyMJ0oVD/vlmzQ4UAgdToaj8pTjMvO7WT1MOpSMkQ2WtR33gNDt2cGAwFJbs+Osg0knw=;20:kZSYbWQDH6mP/hO7JgeUBTgr0o14H059LjLdEM0RgabW8emr8kARAvGHPkV1oKavdotne83mjrsjYXyT4jicPhq9grgxT0UK+4664RwmXSKCGDhe2OyP6FZ2/f9bWeiBcczNBgNt1+UNqPwbQXGAlTpUTVjD5eLGp4w3ftrRYuarn7zG2UGKMpI97ERRah+CvPiC5TlT77q4645SI7E0/ZAxUyuhTlKxuV//as/4kK9mX/WcjzY1l+xZBXfE+AaIBWC90uFfq1WPlMgM+ONodxxDGmxXs+KWv1kHrpczje5yKW9I4q+oRryuuo8OPQbR2EQL2Wo10+RomteRxCQIo0l+u/ANpbitKyR38/TBmRGvjxOLbM5R8zGhKFa4GlSAT5ySfYofPg79xI3EDStwfHAfjQeha5KAapEDUf2SupvUGCew8FZOp6sY7q6JOGB9xJBK/T0U05WYfD1r/qaSUXnWQyiBQjGCVfb1/rF039mnRYGIhZUOET1+AjhgrZQG
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4471D3DF332661ADABB019B9C11E0@BYAPR02MB4471.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:BYAPR02MB4471;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4471;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;4:YKeYgAmAYZyhpojf7o0HNJV+phZsidzZggO2I3xgJnrLJ2XqTgJMcm4JEN2ayIgauT6T6i+/3T9y0EPXuidkXwZ09Bj2WwJtBUBvkD4bzKUlBeNR1jTIhcXA1QXPiMSSQeCD9Xbla7u1uqR1ZMPrt6BUdiNzHYzHR0pIAA9otEtu0Ru5wPZUuou41VFuhfS6wcPETFLgesvNCjoI/OEhWpL4IZcYugj1sXOO6gx2VPUpQtdfiflZFbvqh1t/uQoYXeIqBALPFvEHIX0UMwi68avs0UGHjuXNwgL2tw4TCa4WZsH6KTFmAkQc1/GFAkizqhuRCgAAnS1SduByG3FE2PPQsi25ySJ+Gf4fg9zUBG4=
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4471;23:ufa3Ocw4qn5Yc3U8awLq5Dt4kQL4OWlxLXnh0q5M+?=
 =?us-ascii?Q?HYB94e0ExrZ0h2KN0MezGAerZWyYhsHfc3hIrNoRRhnj+/giDqgfF1lCEwcp?=
 =?us-ascii?Q?njCbPuasAXLPtWnENr3KoUiRi8seN1Rabt+r6vb38uOmxU5ToPn1074qjuZR?=
 =?us-ascii?Q?wazMfPBWyIlhpmdDVsi9kQ+NAVhZxE2VqQpJP05PHDG49LtHjZBksVLi8lJg?=
 =?us-ascii?Q?WoFXdFzQQw2DnQJE0VhYyeohxL/SviE7J9m0hu5hGSFydzyeakrgFjXa3wKv?=
 =?us-ascii?Q?wjngx73p56uVFWaePWFKGP1820gzdQa8j/KBQUXCdFakaouxhAhmghOKNRqr?=
 =?us-ascii?Q?rDgL37Qw/wOaWOLchTaZRRtn9dLPhZsjLOsCrw06ljgdSWBvo7bVqe1T86+M?=
 =?us-ascii?Q?vnR5wANAn2QpmKW2hpHpsBwXv36oEkEASOZ5m1Ijexv/xbObQaoQC40W6+R9?=
 =?us-ascii?Q?8BJp6RLVdo+twvO1iNWiNZBfp7PMrkn0EaxkHBUgUV7AbwR4zO15FlhEKCys?=
 =?us-ascii?Q?2T/HtZknnggWFiLdQLfU0Lr2j8pZq7BppgmtYUnD/+glz0MZ5u4vHfL2obDN?=
 =?us-ascii?Q?rxXrvRMltMqpp5OKYRhZ1bsXEadABA2nqS+Ya3CnV3wDSGGRc/Le0A0H+sqT?=
 =?us-ascii?Q?ZBB6Fzcul1mVPnk+Rfo2XFMYko/BlJ3qFb+jhLCzhLS0b22nBIILCdLmzrEq?=
 =?us-ascii?Q?6OscSAp8oip8LCSUhvJp34jFAz4kpBCCBGEBxWF1qw9BMSKUbnrO3ufV+a/b?=
 =?us-ascii?Q?0OrQlaedSST8Rf2ADWkt6n9iLV0fDEwmfgYZpz/tQeDSb934MaRT6GsO8TBO?=
 =?us-ascii?Q?fqwlZk8h9yUO5hBWWLP4IAVnL0HPYVDR/Hgkec96CgS8WiMlISnM5+6G28ZD?=
 =?us-ascii?Q?2jvMME67/6B5UnekkikHkRRJ1ARec2vfwD0dzVfkws0UYr+GdACBXS+LWjtw?=
 =?us-ascii?Q?CgFpL3gWwzLaq3xyGVR1WO6ZgceBAyA7VtwvaeZ3P8sMLpOLVtHACXUIiMcr?=
 =?us-ascii?Q?6ky7C5eGODz7N94fMx9TvcqiWyQ1vZkQRmzP35R7R81ZBrIAilaX5KZgaZeN?=
 =?us-ascii?Q?RF1Fp2KFeT9EbmFKGQUXjTvBqozdg+3noEnooo1bVeGv25JsPH+vtMbOZmv3?=
 =?us-ascii?Q?jLbd8RydyQDzsM5LPnfnBoJlPaoTGdR+9RiqtluGOmf3NE0pBZ8xhABuor7k?=
 =?us-ascii?Q?jZDy+Rhy/umsX3qiRVfXaZg66W3+BDzELY4TMVcAfPzMrlqVGIRcXcrw7Y+s?=
 =?us-ascii?Q?cRl075DFr0vmx43ME7YRxcg3PMlDbpFAVH89VAoeNVN56xj/cPNwQ4HeTu3z?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: yy8wHHChY9Nv/7m0OSq6rStIivM81x9uCJI2Fz0QliT0h3+TktkW9xSLmcJJgE9YMts6bwql2mwwO6GcF3PmCk+29r2pnmpZD0tmPJv0uO43kiqHzn5L2VRBK9fnAkICbulI5pZ796X4w2QnxbNwjn5YHHAcsKJSiEv8qB81W00PKMRtj44g6BwRvw1HbYz9eMHQIia785DoTsQr8aey6qH5RRlLrfVFugUJij5lTPORDQdD6wvzNsQuqlW1qri363mN0wtCp66ki00yQ9RuD7mmi/3TtTo/6dt6lUn4bP/mJi5li6LKlRkXMKmXmyw7qouOT1EYRIwSsmHzETRaSYWG3wOENmofVXWDc2+6ors=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4471;6:ivyvycMx7TR5p7VmSq7HH+pnBkqwbhQPBE39tue8ZH6ExP2Yq9Ygc1gTjF8wlJCssjjv5kvmgQ9/SNvaWNCNEz3Vr+TDr9o61oCt9lVAwOFSPxFq8U41RYH9INAStfGsaKU+b+NHsps2R/xASQ5aH056aqe1friI5wEUku8RVhopaLwELNlhfdHy26P6rxdprvMq/SEa4yOBYt49nSDoWkTD9pZbQoSOe2HJFesIzaF215LI+U/l1h5tNvjVWmjEd16XEWhGTSF1YieJUaqROYAzjkYL4NiapdUIe/QgBLG0eNXaWpDIrxI+UkjoEplw3XN/uZC+0f+Lll3y1Jr3ElyerkVNBvDT9s7zFx3kZ4Y7xVczg5SIDsh8g2TYoIJpUrZyNPJX9ck4ognzh7Hdw5ZEhXgzYoroh4XlBGodOpeI8J9C8MndEd6J8ISLE7G80WyXU/u6of84GlvLMBziAg==;5:Xz4qGO+wY6i8TEmQLOcmzpuhaS9OlXLDUCnnXuGF4pzsQT2f8HQpUigGg+mv3JYjJMgdArRgof1IDAJvHKZrxZdS0qj1sv9syzzI6FdivCOLAnS11pEazJJwmI9ofSyolWzbwtW+o5X2eR4tw1Ekkawex8N72/USOlyDzh/n0mE=;7:cgqE4gvHhIjrjp58mxyTKVdcZblSKWI2IsHN1HDn4IqxYG0dUqs5ThxjMNc+a+P+5Gr0MBy9RbEgiNnaF3T8lVIc8vJ+8tiM/c6bAX4QTHkstICxWj66bZlh2k6s377HCWpIyXPmrAD3q9f5h1e9cQAJ80Jj7BZxpN0+6I0tHr369IFUsH0pX4bN/mj0amsplg+WhyuXnvpe/Li7ITFKThuuILhjWbdR/TfsfEnxH95V1ySyfVhNSGCdaaS9evCD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 14:25:40.3790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e30180a-1bc5-4d0d-1119-08d61ca9723f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform specific structures, so that we can add different IP
support later using quirks.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 91 +++++++++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 4963930..eb458e5 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,6 +22,8 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "edac_module.h"
 
@@ -130,6 +132,7 @@ struct synps_ecc_status {
  * @baseaddr:	Base address of the DDR controller.
  * @message:	Buffer for framing the event specific info.
  * @stat:	ECC status information.
+ * @p_data:	Platform data
  * @ce_cnt:	Correctable Error count.
  * @ue_cnt:	Uncorrectable Error count.
  */
@@ -137,21 +140,41 @@ struct synps_edac_priv {
 	void __iomem *baseaddr;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
+	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
 };
 
 /**
- * edac_geterror_info - Get the current ECC error info.
- * @base:	Base address of the DDR memory controller.
- * @p:		Synopsys ECC status structure.
+ * struct synps_platform_data -  synps platform data structure.
+ * @geterror_info:	Get error info.
+ * @get_mtype:		Get mtype.
+ * @get_dtype:		Get dtype.
+ * @get_eccstate:	Get eccstate.
+ * @quirks:		To differentiate IPs.
+ */
+struct synps_platform_data {
+	int (*geterror_info)(struct synps_edac_priv *priv);
+	enum mem_type (*get_mtype)(const void __iomem *base);
+	enum dev_type (*get_dtype)(const void __iomem *base);
+	bool (*get_eccstate)(void __iomem *base);
+	int quirks;
+};
+
+/**
+ * zynq_geterror_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
  *
  * Return: one if there is no error otherwise returns zero.
  */
-static int edac_geterror_info(void __iomem *base,
-				    struct synps_ecc_status *p)
+static int zynq_geterror_info(struct synps_edac_priv *priv)
 {
+	struct synps_ecc_status *p;
 	u32 regval, clearval = 0;
+	void __iomem *base;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
 
 	regval = readl(base + STAT_OFST);
 	if (!regval)
@@ -230,17 +253,18 @@ static void edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * edac_check - Check controller for ECC errors.
+ * edac_error_check - Check controller for ECC errors.
  * @mci:	EDAC memory controller instance.
  *
  * Used to check and post ECC errors. Called by the polling thread.
  */
-static void edac_check(struct mem_ctl_info *mci)
+static void edac_error_check(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data = priv->p_data;
 	int status;
 
-	status = edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = p_data->geterror_info(priv);
 	if (status)
 		return;
 
@@ -253,7 +277,7 @@ static void edac_check(struct mem_ctl_info *mci)
 }
 
 /**
- * edac_get_dtype - Return the controller memory width.
+ * zynq_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
  *
  * Get the EDAC device type width appropriate for the current controller
@@ -261,7 +285,7 @@ static void edac_check(struct mem_ctl_info *mci)
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type edac_get_dtype(const void __iomem *base)
+static enum dev_type zynq_get_dtype(const void __iomem *base)
 {
 	enum dev_type dt;
 	u32 width;
@@ -284,20 +308,20 @@ static enum dev_type edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * edac_get_eccstate - Return the controller ECC enable/disable status.
+ * zynq_get_eccstate - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
  * Get the ECC enable/disable status for the controller.
  *
  * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool edac_get_eccstate(void __iomem *base)
+static bool zynq_get_eccstate(void __iomem *base)
 {
 	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
-	dt = edac_get_dtype(base);
+	dt = zynq_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
 		return state;
 
@@ -323,7 +347,7 @@ static u32 edac_get_memsize(void)
 }
 
 /**
- * edac_get_mtype - Returns controller memory type.
+ * zynq_get_mtype - Returns controller memory type.
  * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -331,7 +355,7 @@ static u32 edac_get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type edac_get_mtype(const void __iomem *base)
+static enum mem_type zynq_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -356,11 +380,14 @@ static enum mem_type edac_get_mtype(const void __iomem *base)
 static void edac_init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	u32 size, row;
 	int j;
 
+	p_data = priv->p_data;
+
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
 		size = edac_get_memsize();
@@ -368,10 +395,10 @@ static void edac_init_csrows(struct mem_ctl_info *mci)
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_FLAG_SECDED;
-			dimm->mtype	= edac_get_mtype(priv->baseaddr);
+			dimm->mtype	= p_data->get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= edac_get_dtype(priv->baseaddr);
+			dimm->dtype	= p_data->get_dtype(priv->baseaddr);
 		}
 	}
 }
@@ -406,12 +433,27 @@ static void edac_mc_init(struct mem_ctl_info *mci,
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = edac_check;
+	mci->edac_check = edac_error_check;
 	mci->ctl_page_to_phys = NULL;
 
 	edac_init_csrows(mci);
 }
 
+static const struct synps_platform_data zynq_edac_def = {
+	.geterror_info	= zynq_geterror_info,
+	.get_mtype	= zynq_get_mtype,
+	.get_dtype	= zynq_get_dtype,
+	.get_eccstate	= zynq_get_eccstate,
+	.quirks		= 0,
+};
+
+static const struct of_device_id synps_edac_match[] = {
+	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, synps_edac_match);
+
 /**
  * synps_edac_mc_probe - Check controller and bind driver.
  * @pdev:	platform_device struct.
@@ -423,6 +465,7 @@ static void edac_mc_init(struct mem_ctl_info *mci,
  */
 static int synps_edac_mc_probe(struct platform_device *pdev)
 {
+	const struct synps_platform_data *p_data;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
 	struct mem_ctl_info *mci;
@@ -435,7 +478,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!edac_get_eccstate(baseaddr)) {
+	p_data = of_device_get_match_data(&pdev->dev);
+	if (!(p_data->get_eccstate(baseaddr))) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -457,6 +501,8 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
+	priv->p_data = p_data;
+
 	edac_mc_init(mci, pdev);
 
 	rc = edac_mc_add_mc(mci);
@@ -495,13 +541,6 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", },
-	{ /* end of table */ }
-};
-
-MODULE_DEVICE_TABLE(of, synps_edac_match);
-
 static struct platform_driver synps_edac_mc_driver = {
 	.driver = {
 		   .name = "synopsys-edac",
-- 
2.1.1

