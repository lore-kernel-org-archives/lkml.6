Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BF3ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84242214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3TfjQuLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84242214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeIQTMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:12:33 -0400
Received: from mail-by2nam01on0082.outbound.protection.outlook.com ([104.47.34.82]:24016
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727375AbeIQTMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPlgHWwxxGeMmES3iC9R2B0x0FGDcuWpvXvIdyeQU0I=;
 b=3TfjQuLatOPQTQuuHIBJt4LsHMR/JR7/GEmvkE0zUPjvGMApRlTGANzArP7RGB/i7XxcXCqK1k3berb/kG7U2l5HS8X4TfmJjqGo5hlYfXtFI0RzUppCdqL0fca+6l6+6KEg7H0f+8Km8Msfjr/jxlj6JSiOwt6lC7RPRRee6Ec=
Received: from BN6PR02CA0041.namprd02.prod.outlook.com (2603:10b6:404:5f::27)
 by BYAPR02MB5109.namprd02.prod.outlook.com (2603:10b6:a03:70::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Mon, 17 Sep
 2018 13:45:04 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BN6PR02CA0041.outlook.office365.com
 (2603:10b6:404:5f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Mon, 17 Sep 2018 13:45:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 13:45:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51886 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tpn-0000bw-24; Mon, 17 Sep 2018 06:45:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1tph-00057c-T7; Mon, 17 Sep 2018 06:44:57 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HDil26024405;
        Mon, 17 Sep 2018 06:44:48 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1tpX-00056L-L8; Mon, 17 Sep 2018 06:44:47 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id D38A412142C; Mon, 17 Sep 2018 19:14:46 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 3/6] dt: bindings: Document ZynqMP DDRC in Synopsys documentation
Date:   Mon, 17 Sep 2018 19:14:30 +0530
Message-ID: <1537191873-6582-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
References: <1537191873-6582-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39850400004)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(2616005)(103686004)(486006)(44832011)(336012)(7049001)(356003)(47776003)(2201001)(126002)(2906002)(6266002)(305945005)(446003)(52956003)(26005)(36756003)(4326008)(426003)(36386004)(14444005)(11346002)(186003)(476003)(8676002)(316002)(106002)(50226002)(48376002)(106466001)(54906003)(81156014)(90966002)(51416003)(50466002)(76176011)(6666003)(72206003)(478600001)(81166006)(5660300001)(63266004)(42186006)(110136005)(8936002)(16586007)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5109;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT023;1:+UMw3aZdV1C2r03KIBnlVARTeWet6oz8FWWZZl4YOIrhBww12H5kaXdV1N5/zZ+7QMzwRxhQ1p0vGeHD9aMfbcRwrkfHG51gnwXO64I29ET6RcCIowG6YLd8cYZE+0YT
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cedb1e4b-6333-4b3f-7917-08d61ca3c579
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;3:IQstZD5Zr77xmLQmP9/kDd4EI4JBjl0QWRa6ApAjJEM7GLJxj5E9S/4tqwwS71KBQgPTLT0PtCVBoGGby0/DI6sVyjQy3Nny2ocx5TFcdq0wr825BLswsks/oxZX5hkXDjsO2QVvf/+Q+z+71R9e3wQV+vYc9KV1xyoKs5U2N8b/h3z8HscAnBQW0QuNKBWRlCRrB0iAsbq5TRnTyI7Vu+Ju3s/x3M0ZeOyCByMaIZhEqlH4XhOZ4mfU6A0hdkZxS5sEyCVZZv6jo/hz0N5L7QaZUmsr1ZNfW34agybo/2QFLXhguv31HQH3Z3LkYsG5RFqUhYmlnf67P+uzktFf6GloKyP++bHCCKIpx/RiyHw=;25:8VUsKAZLyvbvGxAHQht1j9whEuNNSWb3SinlC1bv6PbGwpsFi5oPrWrMEpCVnu4cmxJVWafZ1zfqS12WnEJVcaXIvlZFgXWla+OBG+S70caimeI6lUOLAVaXKDdmU1gPDjxL9yC0sttsXJt2qTVJIQXLAhbopHTLi+YtZAV6bYaVsX7MMb1XvL3PuOE/p0NG+XJ9RQVZ2LpQiqlJPt8qqMovzGP4pIo8JgmDWMtNzTeTELI8SI2bFeD+krjIX8feugeAPg3dVn3qBPJXqqIzJTADpLf/LdymGZT65li6/n3iF5gvPtm5OxuSuKzMzWK31CUQGE9JCs5/JwSBY8WmPA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5109:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;31:65VLBMO8DEvqV2m6qkjYF8SO+DEzA9jIIWDvCPuzFhbjXd2oNUzmyk/rKDvTTJ8e9zWXlFcqmAVM22i9ITyrMjZd90J6iZF7eZWSjCwcPz0OmPWfd25MzcrUviUqiNFKFf84kuymi/hYfF4A50721aUCVwXK603H9XKIPL7d7BtqyvoyNiJnbQzGOjTuqWgnsjkPNG3h8wsDzgWWhrb0Y2WzDSuxfwg6vJnQ5dhd+1M=;20:h1hSD0UroV9md6rS4CSud291nA+ngmhyvgwoNSNH3OaiExY74W/HGKJdKzNOv5saCF/FEB+zOzyd4dZLDHM9so4Gv5x5yvJ4/0U04ULuUBbPM4WhT9y78geETH9VmtrPckc2oDpPWdUpKLr9EneQRVNt9KQy/KCCnnOoN8V/LAI/khXolHZfQptmlGpm98ZNNn7bO6CQr+iuwFDFb4ls+b8FUqJM48MyjOWE0xLkeM3r/6JasfdekflZArT7q0JSh2365Cs4/jk39t/mS6D/mFdPD+5BNj+wbM3oTGUC4l5U3VJqsS8RdlGuv+3TETp09LcKyySKQUE966r/ztxPAKH0uIUjow4Tb7lw5yrtA38FoPZBc0N2ucdR2XJ7JL91mjkxI4RLxnQDPkbXS4k8LLu5cagdu5SCM70TJbqyUXvmEtVPKzopqmmiA4sjTZL3UQTmbEoEWSNsK4hcfGH1SwqqdSvG1s/s38RWtqAjKAetu9N4eqXYVEIZOvqSwA2R
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB510941285CEE78914DF087EFC11E0@BYAPR02MB5109.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:BYAPR02MB5109;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5109;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;4:U1Bza5ZV5NmQuUaCRV16WNo8+00LPvo3SAD1g20sKPwa5dSRt9kakATU9Rvdcg1urigul7G2PYKnxiJiVdfaYOVyDT6RlioRN8eZv/0RJlhw80UaZelz7SjZFRdUm9SJEt39abvsNNynu9OikaEqkg84jhaC8pM6wmU7JiGReXhHJtaRQmUdBlMV8Zfr7I+aPIgV1cHb05DNCoK45IUgB9KB3iy2ZOHjk5mX7IWJdCU+HWqsWTpI4votGC1f8lHIvgzkAwqGpTBXqEmaZpMpn81It2e+oVD/qozan++lDmYGArk1MtswQ++Qx5IsJSlVpNUlcBiEsPHrB8CIqlZ9mNLkNvjFGc5EEJvPDnQRbv0=
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5109;23:Ah9VhdLCUu2RFt4JoK+kPGwxajfxEyG6Kr7abN7aX?=
 =?us-ascii?Q?XauoWKx1odBU/Db0yL/h6a/PqYm+0BEVtPO927uJ8iiJp0rk4+fSOQHhD089?=
 =?us-ascii?Q?BnO6YZ7yCqkyTnqs1xK5S0UxRqT1wQfWQ0StXK/g3KpNTafRGRA/7LZ2Os5A?=
 =?us-ascii?Q?tQuNP2CeG2lTB4m2FL4FZWBvrWyipbF5iUHnmoAc29wtG7hRtz0MjAVXLEoy?=
 =?us-ascii?Q?M/ZICDvUi1BpefMXWFrATHaEF3RRlvhkBJ8/b+708gS4Ka9lsLoT4xgzfNdu?=
 =?us-ascii?Q?n6etJ/20Giza9FvB2LYX69Cfc6J+bb7P5E5ncENgJgiMFcLEGMNkhmsP8JyE?=
 =?us-ascii?Q?8WqNvNj25KIT0ty2AFN/Zyzv1C+LIlaxuA48AGXGH3rkN+izDQh5NT7JCM/n?=
 =?us-ascii?Q?Kq0FJckH6qrCKc6oh44Et48FIKLL1TGlpfAI1E2kmzf7yg/hDsXSwV15IvxH?=
 =?us-ascii?Q?ovOe2UXnToWvkyXnOo0x1OUPjWoyjP2Knl+Aud6Y27c/h0D03LaTEyIHJOKm?=
 =?us-ascii?Q?91/TC6Y/Qc1XatA7FuWfvJXOEZhSaX/394nTOJb9QfnkkJfl/bEuQh5Bqf5l?=
 =?us-ascii?Q?WnbySrDBNVde+aYvrk7Gl1ejXaqFhcMTUf+Dbi7zqE3BAdP+8hfQSo0nFOVg?=
 =?us-ascii?Q?mEmnPeci0jWomQH9mD0ewF2eNLbPPWT58SN1rcTwzkJDxD9Emw3nxAF+uyrg?=
 =?us-ascii?Q?82At46jy6jWnQcb0OjrHgnu49yHLd9w4R4vkvmFFFbpvA+M8QxR5VvHYeI4j?=
 =?us-ascii?Q?7qb4bjGrFCsBLKw+35vdCr/QHsFyx26zyDlU/EEK65k60s2BtClkB7udkV7X?=
 =?us-ascii?Q?0c8UouIXC7odKTE/4bwVgNCK9UkvVdqkMOuSJ9QKJOAtJViP4X6INoSiUJZb?=
 =?us-ascii?Q?sql9da7lMMc3ZIUHBrLoYNH/tFhCyLmXu9Uf4Omz6mZvtLbalsAK3se89m/a?=
 =?us-ascii?Q?5FArTV0kc/xO+xO9AC+Z/n7ZCDqS9min2m74CsPZzz1nGoQ/3YUM22MRpwIo?=
 =?us-ascii?Q?bmUpKJWvEzRYPY9kcXxSu5NkVagI208SHEOCBsqWB1EG7Z27MSuI8s3A4BKP?=
 =?us-ascii?Q?WLFdYkQqRmo5uGBLBmD0kPe7wh2/5UYcE0KsZCbivggLBpMcAzC6KBXrBPpd?=
 =?us-ascii?Q?2l2SshqKGFx2i8QOk7eMMOMTSmJxiATFaojOPhI9Z6aUcEkOGA238sreenFo?=
 =?us-ascii?Q?sOvgR9TG/Gfd307/IJPYwGAx07mTZSWGAyfKN1b4zBx24F/E+EQlOvWFPjoc?=
 =?us-ascii?Q?9NILoNSnNTyIuHPwjDVlnBv+HV+6qmuCj0KH/Bg?=
X-Microsoft-Antispam-Message-Info: MwVfcS2MxQnPltjD0YbTiqBZK3sZW4fJn2YBIfNXSQXCw0wlwICkdvyISyTQwv6l8HQeCnDRi338HMgaudNn+FzhT8Pu5E2G1IIo57VWoU+iEdRUBQE+6vdx/Gh5TTwpOHl4OoSLix80ATdnMEgrJnNdrQGkd6wYOxpNx19paOGs1CxW4CRpKq9ZwXQZB4JmYTQeyUDE4bx+0i4/N5eBf3C3+YSxersXUgVID80sFwMe1z1nWK/TL1yzlm4B/GTiuMgeMOd5KSScunQJC6K5UGq8QznmP1awpZMgR/GjIirvyEkIBsu2AI+USAYIIsG5j3shXf0JnDzfU1Ti2Tg7G1rfP+lm46YeMxTATogRlwE=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5109;6:9meSdIAUOlPtmluDoYg1inUyGDdR86I2+RfLeTYsFQxBejbUx/ha5bPNPhM+qI5Ln7imsM9dlwsUTmdGPaHBSUjNIA8TkGrfJAvu1lxtLBd/51aQUrnmAaDEOjJRLPman0O9x+Y8qgTP1gSmy15lPZ0+TjYSMjVst1DfrhZCgkKcRX/t0TuAAN1k+nGLdbRfWDLDDsQQycXylQXE9fldnRnwyoGvk01bHfNTxqwet2yRhxkAOavykIJh+f73KDAgKUZh5ymzVRXTd1tNFPEwfHGQrPDYSX2lAQHwwvTgrphc8ub/LvJx27Ioj38jIiQafPZdXqacnjopO4pA8iNuZJ6ISZ8Hmjfq4CIsulDCd+2WAiBG+zxula55BrD7+SjINIBo9GHLxCO/Nn2OKBGa9HxwfRIduuBNqCgvyaZIxSMpdyfoEYf6qb3WMbMFAkVyJYthP34act8Va/4AVffJEg==;5:NEF4Zm4w28TS7OVbhcL9a8L1HNpcSLXc62AlMA1Q6+zE5Ql2FlgwazgbNHu7KVEbsWkb64E14P99Z2+2VrGGrVHxUSuwtMq5hkzBYKFXmePAyfoNyAy1O+2EHHkHF1zAinE61DyDoy0pcVqCXyU0Zg1P4wm9dBu6FaSLSGHqes0=;7:iWeDpml3jepF4PwCEVLOoxIC0B4y08SVgpbtsU2XdM7GorhD8VmCyvvtwHqWQrNjoYEfe8u2BC9YR9hdj2Ld+Sw8pB3dCgLtSNJuenuHFtNpsEaA+u5q4d5elBUW4TovSupR9GzmOBjyKCC5KQbbWBYp7Hd8F+Ea9PUhd82JNRjnGUzRCewARZA7ULTQe5Uo0fzXEZs+qJJAoT5x/DR58Ewu1Vi+iYkYsfXnyJoiEEaK2lFx9SmTqUVhXVlO6jt3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 13:45:03.4541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cedb1e4b-6333-4b3f-7917-08d61ca3c579
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information of ZynqMP DDRC which reports the single bit errors that
are corrected and the double bit errors that are detected.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/memory-controllers/synopsys.txt       | 27 ++++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
index a43d26d..9d32762 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -1,15 +1,32 @@
 Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
 
-This controller has an optional ECC support in half-bus width (16-bit)
-configuration. The ECC controller corrects one bit error and detects
-two bit errors.
+The ZynqMP DDR ECC controller has an optional ECC support in 64-bit and 32-bit
+bus width configurations.
+
+The Zynq DDR ECC controller has an optional ECC support in half-bus width
+(16-bit) configuration.
+
+These both ECC controllers correct single bit ECC errors and detect double bit
+ECC errors.
 
 Required properties:
- - compatible: Should be 'xlnx,zynq-ddrc-a05'
- - reg: Base address and size of the controllers memory area
+ - compatible: One of:
+	- 'xlnx,zynq-ddrc-a05' : Zynq DDR ECC controller
+	- 'xlnx,zynqmp-ddrc-2.40a' : ZynqMP DDR ECC controller
+ - reg: Should contain DDR controller registers location and length.
+
+Required properties for "xlnx,zynqmp-ddrc-2.40a":
+ - interrupts: Property with a value describing the interrupt number.
 
 Example:
 	memory-controller@f8006000 {
 		compatible = "xlnx,zynq-ddrc-a05";
 		reg = <0xf8006000 0x1000>;
 	};
+
+	mc: memory-controller@fd070000 {
+		compatible = "xlnx,zynqmp-ddrc-2.40a";
+		reg = <0x0 0xfd070000 0x0 0x30000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 112 4>;
+	};
-- 
2.1.1

