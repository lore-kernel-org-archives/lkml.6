Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8363ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BA52064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="g3Eikh9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BA52064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbeGQUez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:34:55 -0400
Received: from mail-co1nam03on0087.outbound.protection.outlook.com ([104.47.40.87]:2340
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbeGQUdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2QTQ7dW2ZMMAbJ6y03b+7qK6GagaBkaFtRTfFZ6wc8=;
 b=g3Eikh9VpI71ckqgeUwXWWBmSITfueexo4Ml9rm5cY7TmbhExSylyoB7ORe5dlLtXOyT0zBNx8f2BNVdZ25wGB0WLVpuobd1ISsU4q5CH5Wgc9fX19ErWRV072rBxM/xvUe95noHlCBEeTFf0Ap9yUA5MwKvn3+oxiVzn/vfQ5Q=
Received: from SN4PR0201CA0068.namprd02.prod.outlook.com
 (2603:10b6:803:20::30) by CY1PR02MB1625.namprd02.prod.outlook.com
 (2a01:111:e400:5299::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Tue, 17 Jul
 2018 19:59:33 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by SN4PR0201CA0068.outlook.office365.com
 (2603:10b6:803:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Tue, 17 Jul 2018 19:59:33 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 19:59:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW8C-0001ad-Ar; Tue, 17 Jul 2018 12:59:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW87-0004zI-7a; Tue, 17 Jul 2018 12:59:27 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1ffW85-0004y7-4T; Tue, 17 Jul 2018 12:59:25 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v10 01/10] dt-bindings: firmware: Add bindings for ZynqMP firmware
Date:   Tue, 17 Jul 2018 12:58:58 -0700
Message-ID: <1531857547-16652-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(77096007)(54906003)(486006)(44832011)(106466001)(26005)(476003)(107886003)(2201001)(36386004)(50226002)(110136005)(4326008)(8936002)(76176011)(7696005)(9786002)(106002)(51416003)(426003)(356003)(48376002)(36756003)(5660300001)(50466002)(81156014)(81166006)(7416002)(305945005)(126002)(11346002)(72206003)(2616005)(336012)(186003)(16586007)(39060400002)(6346003)(6666003)(446003)(2906002)(316002)(478600001)(8676002)(63266004)(47776003)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1625;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT030;1:9Ox6C9jf2LmVMigPWHv9Yja8XRvEI3ThZl7YRtuBxVD9XmpR27V17x+9Wk4p0B1dLcnxACeTWhdcZIbwBoVIgP88rORQj0zIHdr07Q2isbn+RYEqwOfQLJ7Wx6cHXcQF
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 596a4ca2-fe02-448f-d045-08d5ec1fd0a6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR02MB1625;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;3:stDNXsdg0Tm/D4wNFqz+nEYy8/0rx/4uzojD9m/Hmp8mxA+/ftRSSpezedFuxyzTq0svgbMS0yJIKiyUdXRQqBS3kofqoGxVsJEBro4QGGCyqAHnCNOEuhvrDf4+PT4NNKyNqiQSIMPz7OCJ2mJT+7lw6GP7uVMmsLFqCs93G4cyekA4nhpiKnixDozyv6IrW2K9//GBjTucCYfQBB0ItK/KSpfnhZfhKyMDfVk5ZH/Tp4cb15moJnmRoNU+suOtErku8se3fCY7I9Yc44Ex+nycQwe3EoP5zUJVfr+Djs6ECZYDARi/KEW5bN6VjZvwP+FO1WxtmIaS37ZOZ6dbTm6v3tesFlKFlJ5anuhDE48=;25:AxReOcJU4oEjuLfhMwc4FFmNVMXT48ox5kDJc3EzzLPPNkJaBdlTZQGP8SXlC2DICLIoJ0s0Nuk+DrdlPNsnaqcoyo9xCEPJbcqzCYUCy+MzL9xJxuEpkSiTCge+Besd1LDiUSPTPnF0czZxt1m83lCrIZCR96rgDa5D5BJiIzA2kUTGAJQloItHDy7kX/nNC9zwT/r4Qem8FKvxXCp+/Vfwp6d9gEtzGUq7iTMLwWBGSz5c6HZSfzQE6Tty3I5hVg+ABQF6YOl4GitmazYBzfKUCkGw4z9X1BEcN6wCCmpt38QWWBeB1xOOz6si2QfhhzGy2DbNzGpESUJcL2DNNw==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1625:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;31:uXxUYTGzgJQGZK/yH+iSlWd+JYmwsQ9HpICmYrrrl5o3rC6bgcwKd31XqBxrW7Uw4EfW/3FML1DcVqO26dTCrLv0aD2sTq6B4BwnTqaIeSB889iyvo5aOse017lLBTrUTZw96JqAzYCY7YVtB6AhQvToB90Os9wqDZAQtsRR1van02g1/wP7Ql8YPHJqwDBKwEPGjiPTHHCO6jRek2HB1zka1V3hC1RxRKim+ypmyzY=;20:XXsAh8GKHquhuAXi1B0RdibJVhXpkzpebXkX+2oEByAYoVauxjg7P071mRXHch7hDpE1IrGDu0l+6+qZXWkzC8mJX5BhSxpvpeqvKprzn3v/K1BT4xhRfJhWs9oip+YsEPnhADFstmDbBo00ekZ3+aOUfTwSlZG81KWvlO98YImEgNjmLxtV3Gy8mWqZgyhO9kAdYZJPiyVRWdjVSCxPZhirgXKgdt+nU8m7v85o0Vkp5o/4ve1vQqCZ69+u/6SCYvovZ1QPb5G1UR1Dde2RjmsKEKYszFdtQB1K+oCeUzY+xXAXmzhNNlfm4cQ9XMieUGst9zLL+raE0pV2YeFe6xD7OYViU/QnLV9VfYi1FdWUQSzYHjApEK5ySrs3ig1PdEk3feNscpPRMep94D5VRbFtFnxe+IKlQSBqBbP/YrcNwArMuvlSlJROisLTLVWDmYwFX5XXfBFe6ULoOpy5Ffol6fAsc77IxnDOJmfs6IeWfzYhZujdynfL1Qi47csD
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB1625586CB03865FC0B701C6DB85C0@CY1PR02MB1625.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1625;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1625;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;4:pzpqYUKXsyGZlZGvzkrd4Xstu8AU1+7gP2hPJ0nGK8QoImx0xR1wylnF/feuOOp6D4dxL8w5Gq3KNIABpMABVdZLUZFNPR69IkOb89viLwUWLM2BQcnqoyObTITcKbQ14qoP3dXGd1091p2Q61pksLaF+UtQwgFYiFAxhPbrqweX0yErKRCT0+6YCG9h0zhZ2U7EEyBkU1Zi02Llmw/Kn1ikvkDf+zUITnEY0bvRWoNkvt852NRgWDMpJpbnsIsmiYBkhfPmdWMmeMTRxGCKLj5psBl9zJPTjX/PabyP4taTYw3T7d736Kmu+Cv9Mz7S
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR02MB1625;23:HcYFVFtjQ3emETywfWGQv0APY7Ge7+ZCN7BYMJdiy?=
 =?us-ascii?Q?yZRTkXAYFgjHLAv+pTnVYMlCGijGTjiE/uF/Etw/rLJt45nZzjKnt5KvlQ9C?=
 =?us-ascii?Q?AEZt1SlvyrUMvZbMVOWkOcjK3Ukex4LmWQrBoqDRw0yi509T0nDgfRxkkDn4?=
 =?us-ascii?Q?I3Q4v7qPK2nuagHRFjJSgLN2eCl9z5gwqXRCzZ8jKYYjqiVST773mgAGbU47?=
 =?us-ascii?Q?3Bh2LZEZVj7UHMYT+JV0GKWnxxQggu2zrHHq0MFz83mosCP6vMBw2QAqfeYe?=
 =?us-ascii?Q?eSzV/QTDXXGk/Co/vQFIkSEbdYzwSTpsFdsRIUAMzTpbXPJrYQCEkKC5Bw/y?=
 =?us-ascii?Q?QChoBNKXPIeIl7O1l3f4JqY5rMLyAECXHWPVzAM3cmEfbSo95ZGZIZRjgVSO?=
 =?us-ascii?Q?FWAzl+O92ZRtzNngH92q4K1LsnAXa3x7nw6Bo6hQm94Q12xh3vmf6SAbTLnX?=
 =?us-ascii?Q?6ibowQ/ztoH765k+UBygGNP1k3TQLgcol31BqOm+MWmTgUInKUa/ZUI/X/S1?=
 =?us-ascii?Q?GT5rMdaFAZ5KnGMyMVsgcasIv3ObeMP3Cm5LfayuFkLU+lVTPD4R/h4J9dyM?=
 =?us-ascii?Q?swOTWotfc7lTe+NMFehwwnpyocFvPU9hd3qlFRihqGb+FZrpzlFA0PMek5rW?=
 =?us-ascii?Q?CIEsKecbR9WwE0EOdLbQHfg04yqsGmlV/63gKYGJI7gjaqnIiUmdBJ9YnLaN?=
 =?us-ascii?Q?dqnivjrWVp0W8aSJhjQcQdn/pI4+rE2qw3Oxo5Cb4XGyQOeNEi2P/4iTFrNw?=
 =?us-ascii?Q?9EmF+hscSWm6jFubWn5pYZtGkrIM2/gVTh9Q7g1JVUqqT2ACqdYuq4q37N0r?=
 =?us-ascii?Q?qAvsmYibDB8eb7qDg3cGXZxb/xqXlTDAuiljWQ7DNdEama41DL0I1jYxuZW4?=
 =?us-ascii?Q?sEGFbIP1fG328prQnzeNybm3vmZf0+Xq63vt19ljVxb+dg1ZRtIoH9lHXgkl?=
 =?us-ascii?Q?EmBLvZk+LaGkLVJTD+cKOunzBfhFxIT8Y5IOhbVzI00lW6B153BXbDuXHOTh?=
 =?us-ascii?Q?melHDQQMep9lC0WN9sfAIq+Fv6EiWgfXSKk2i+Eq69Irofyu57rtjgPH4UoV?=
 =?us-ascii?Q?mG5u+59lL+Djj0Ai03jWshhw6GC25r1dY+DmZEtxDX8sDbYMTlnhSL0yTe6s?=
 =?us-ascii?Q?eJCJyqVmUDYN/FngNA5JU09nRn8F27+h2rFAHKScVbnHg9Vo0NtGS3utLZWe?=
 =?us-ascii?Q?6jQwwgQfoBGxFPutpqcET1ae7k2ECqwV4SVkkjUhgXNbLusibXsWk+Tf69IZ?=
 =?us-ascii?Q?S8hasBg4cV9NJVVai+HGOu3tCZQ0h+M8W6WizXN?=
X-Microsoft-Antispam-Message-Info: 2NnTsF0627DMUWllUGx3pDya0tLSjhVBEGNxYtIKn7JfTuV43lpXX58Rhf9Pf/y9it+xQ56FJRr645ylrBux6sRNVnUiJEv5Sraw0Q+VPlgIC539RPMbxYa5JNLU4gtq5WRqGRKWpDGlGRnjdXgaihFxzT65ZZ3j4J1e7nKjoThIM53ULW54yymiM8ne0NUf4Ye8sH92dBX0RRQD9YnClOXijIyXCkIhPXPaBZIG9NjH1JUK5ZzuZm08S2uQWalapt6hjhXPY0AJwJBTO8+kYG7bLZ0cXsVMpvzUo5hk7oDtpsdoVkQdwaWAVrC/9D8Jf0fWo7PZI4gmIpks5W6UDNBEbasd2NAEjR6nYGTsCL4=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;6:CnpVnD80E6XFYRrkJdoMhourde80hnCPNL84ITLfCFVSM2rIMAtK6NtippYXs4G9JlJod4K7xS+ZQY87HjBuz4zD/mNo9v5F/sR8r5GOY/f+/e3jCaghtYd/OYfJSHReXOChCY4udSz5Bx8PCvJfhdxJ6wXOVdsvzEjkhdy9T7Kvc/I7+CB5/u6d5iL3PqbkluDPTlSv/0AjMTZdA8ZdOQqBLEgWZNVxFH3OosIawpKrUO+EdPamGCe0G0VasFJlC3lo8EaKBm+pObIClE6WwR5FpwJJ5l0UJUlmjayODI+3PWYbfg/qCTj0c1sv3mmTYvHvyx8kzYnou2/MnV2ruOeaz6YzcDwD2SEO3iIqelPo8oBzzcA9jJTLY3uRBlA66xC/e0JW2bK04Go0k+Wl0dP6tdVZFUlXfMbBhqViLfJ/1ebzeDP2v9bU5p1mZVdUTIps64lve8Ct8HMplkfHZg==;5:HSjvUDibZqbn1MYogoVGcxOGEbHJLtg1PHQZMZlBCheZrH2WIVvNOZTZynnZp3Y9fOXrDFsYT4rrhsEtMNZvtejX+skMWXJpQhFRJU3mMPyqAQzg2ljqVucOGAJWPqKLvWIA9rpkjHToj8Jwx+N5ZEuAqEeDy1fcGkqfrqghIF8=;24:MONJII2xR+NXwIxezqlEQRNuXYUXy0Ehk1fTmwjWFrR1Nnny4J6h+Nl1jkGL1hMKTuWOQ/Mt+MizdAc+HcrcblTjmII/0Tc2otYL2cS9Nis=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1625;7:lzgsQIWfq22aAjFolChyHXi/2poDsrOD3CmU4ZDU2ZjCdnhmvoF37DMiz120lNJBMbKPqeo5VH26itQWHG/aLZ3fr8XIRVG999NNEIbjkv30+7rbebAJkhnJhszvuzL+hcUEmtYmnlaIi/oSVm5WTlxAzFxU3ygzIvUnZQHP2qbp6PPOEPvDEUCX2hNvcn/ryoH7SKLhYXKCJ3ebm4rOU1TiM+tDZbacUfXg+q6kFqDaw5DvR0gtSq8r/ueaTwuT
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 19:59:32.9652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 596a4ca2-fe02-448f-d045-08d5ec1fd0a6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP firmware driver
bindings. Firmware driver provides an interface to firmware
APIs. Interface APIs can be used by any driver to communicate
to PMUFW (Platform Management Unit).

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
new file mode 100644
index 0000000..1b431d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -0,0 +1,29 @@
+-----------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Firmware Interface
+-----------------------------------------------------------------
+
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate to PMUFW(Platform Management Unit).
+These requests include clock management, pin control, device control,
+power management service, FPGA service and other platform management
+services.
+
+Required properties:
+ - compatible:	Must contain:	"xlnx,zynqmp-firmware"
+ - method:	The method of calling the PM-API firmware layer.
+		Permitted values are:
+		  - "smc" : SMC #0, following the SMCCC
+		  - "hvc" : HVC #0, following the SMCCC
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+	};
+};
-- 
2.7.4

