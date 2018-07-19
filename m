Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF8AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDA420671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cvY9DaC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDA420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeGSKsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:48:30 -0400
Received: from mail-by2nam03on0087.outbound.protection.outlook.com ([104.47.42.87]:64592
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727217AbeGSKsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XAvNXQBTqVK9pBcjB2PRE4BADGoO0JV3k7r876/7jw=;
 b=cvY9DaC+rAz9fZEtP5hfVCHzzcplg073BR2zqkmorRrMR1kDpsnkiOiaMR3KXFRgEm84ueizrdqdceUwZp/m++d5IOJgLVnXwgZw5WEzMlSagOZGWidw/9QTz2NAHpinn80BFN3UQy+idABcCp6wm2QZt52FHWR3hAhqnKCLlhM=
Received: from SN6PR02CA0035.namprd02.prod.outlook.com (2603:10b6:805:a2::48)
 by CY1PR0201MB1915.namprd02.prod.outlook.com (2a01:111:e400:527e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.20; Thu, 19 Jul
 2018 10:06:04 +0000
Received: from CY1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by SN6PR02CA0035.outlook.office365.com
 (2603:10b6:805:a2::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 10:06:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT037.mail.protection.outlook.com (10.152.75.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Thu, 19 Jul 2018 10:06:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fg5ow-0007dR-KJ; Thu, 19 Jul 2018 03:06:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fg5or-0003wa-Gq; Thu, 19 Jul 2018 03:05:57 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6JA5q8F015619;
        Thu, 19 Jul 2018 03:05:52 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fg5ol-0003vm-Uf; Thu, 19 Jul 2018 03:05:52 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 16B3C1214FE; Thu, 19 Jul 2018 15:35:51 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <bp@alien8.de>, <mchehab@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys documentation
Date:   Thu, 19 Jul 2018 15:35:45 +0530
Message-ID: <1531994747-15196-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
References: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(63266004)(81166006)(81156014)(103686004)(50466002)(2616005)(36386004)(48376002)(72206003)(44832011)(478600001)(486006)(6266002)(126002)(4326008)(476003)(8676002)(426003)(106466001)(2906002)(11346002)(47776003)(90966002)(446003)(356003)(76176011)(8936002)(107886003)(51416003)(16586007)(110136005)(316002)(42186006)(54906003)(106002)(5660300001)(186003)(26005)(6666003)(50226002)(36756003)(305945005)(2201001)(52956003)(336012)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1915;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT037;1:70Q6n3wmQTlPAxH4kbe7vhnZLc3qkc782wDF22e+ij+JF3eAPZyMBmrPt3HdrHppIR0ey06A+Wsh2Tav7vpAAU4f0qpuG2KyZMWpdGLqka5MEjs4kxscHzrGkgthKJzU
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c630aa6-e57c-4424-7025-08d5ed5f3c77
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0201MB1915;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;3:gUXKIm7xvfbImhtMboUqw3TqfIuTFIkLfdo6ZA/xQdXawQ4OEI3fx8yiOiKhjWYA1f+Jg4WbK18jQx5vE1tJHW+Gw3wmXFMkd2o6wlsJp8EwJ1yw+GZPIC4jevnxJghadFsjZRI80sttn9YioCW6/7pWBuWnc7z+IxiMdKA9vu273Z+XOpylF+qM7U1sMdG9POWJBzmngFQByR0pA9YSJZ4f477vfWdEvGszrf2ptUpVfgXDSOQ7vpJf4QeIlddH5kRN1ks87cW650+MzYpa2oEkwcLhZlePImmdDBiwI4jTHGOIESDr3wTvtDFZGkRC0DPMTlksQ24TmTV/wF1BQBact3/vRGpo6MqGhqaWsTo=;25:y/6U1+rSb8yliYBNpwEVD0u2YbMIxzeCp2573IXVo5UsqsDdcC9Eua/ArP1MpSSt07MMBwjzT1lpyOdsyvHfzwCflU4HI+h9iv29rSCnQIu/LLONtvwzv/MCXXUPohWjbsKQKeH9Rk+FdcakGih4mdD3Yuyp8OszOVq1+JZKJA7V1OIVeNPif1Glg2Np9VAwZs7xav6A/4rZcoYh9uRzijA+wSenFhhoXt7CUWFGKrHnb2ZSrtcc9jngKIUg/Rlw3nHXUS0S9ZIQWOLy0+63OBn5ZS3YkpTLxLMgaC+MHVGc/t936hdUS+ZfscYRncQNp7bkRTIQAe8shSSrS4Roog==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1915:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;31:FUwWHSK+xnb8wx1RBEaEr/vTH7T0hUd3o9kIO4pnVYGnbt7Sox5rACGiEsBNYNEBaHJ9WsZwUecNWYUEQBoQGMU0YnC960bxoFu4iOAaciY0KbqjLhZhSlXvqoIUfCgv789Duq7C0idbZDMBwyqrkRAhHyr93PSUMRA8nAjIE+vm0b5OkvWcm7B0ELrt61ZUyWtwEY43+ox1hESQ2RzQpeKpaccwHVit5CL1a8dqi94=;20:UsZdkVjynIfDeLQBfKRzue64LkWBWzzgWfkTc9GjH1tQo6+wSqIUJ3NxSrqM/rbRchtD2W7mtUBkF6uC4bal0ql4iKlwlQ9R+OV9b6g/1+Fctcx+Wukai9yshVb3p9tvGy0ItyerG19/Ty1YLd2sG0KIKJ97lpJu0Am8w/Mdujw1To/9ltinv1RmE3kBPjbzZ8YY/sYz7mhrDfbGr+25uSA1qhDvRnAPFEl6TFtsyzSu8uc+5WskY3ec54G+ANxCbi/ilNkO9ku8Sw1WaNzZl2nwTG7zSy5pRtYaLrbI3bILJOyUiVj+24nE95hGX3TpwgtJgKLCelbrE6OFtpvPk0cgTqP6cX28kXb+lmCjYIeIn36UaiOSckjf9m14BIDOKP2LbYk8QzilqBqCE/hCU00fO/Moq9Nc+FC78+zagld7kMJyEVK9AfxVLsc5kJVvAB7ZpKP97AuuZPIEx1wiqW8SbL2+VEF98H5LXuvw8DVtJPYhgDuZn1/K+/cv0tXJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB1915BD8DC7B375C6CEA28548C1520@CY1PR0201MB1915.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0201MB1915;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1915;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;4:fXknPSanpYJNvjlbWpTNuXv8sKjLNPjapJj8VWYXACOahnrEx+ugnoCq8f113fMPMbdn0g45muPhah9o53iqVMp78rI9zdJmEaGqxOBrqlqBDTknGk7H5ADfdYzrd2wQyJiolD7FU8LvvgDAYUzPqMKOoHmHEV6hFKaQAwuTFM1dphD2LJgmNg1TGaNOxZi7xnTaFNmZN4C9cJ6vFEJ5CCTLVADhvIbJhquFW67Ef+DyC/SxVyNO6h4HPwKvYig99CQviUhDrnKUKxCeI1JIwDJyw9h/8QXPFeiig7GVQA9ngSIZKAzW1BY9EXpjIn5H/PNlb9FTa73P7swnoaLlohC3PhfQrIqY/zgW9wCB4x0=
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0201MB1915;23:MpQpgwr09Hfe8JIR3x+02h8LE1o9X8RK9P1024P?=
 =?us-ascii?Q?0tiTZVEYQN5BWEo2ZnsZrSK93v0cEWaCuBt9hlBarKcZrMBF6RIJBl0GAKBR?=
 =?us-ascii?Q?uIaisnjvk3FGhh8hOkiJIjtGsWeitkR3mlykiAEgM4pL87ovbl5+kWj32RCV?=
 =?us-ascii?Q?d07r3zm+Qd3mFdNguQtVi/vdB0Hn2s9qmttlE5w6NpC/VPNSYOnaoFpzo4Nu?=
 =?us-ascii?Q?5ye7q1g+77pA9j2iI235unV9mpGPEQKqMuVXrUwc4ixNm9gQdHKAo1VphHIB?=
 =?us-ascii?Q?OroeXs63WqNoXHC/3oayFZj62cFqRoScbPZ4oyu0NGEEjG71Q77YKntALIF1?=
 =?us-ascii?Q?CB4CnYAhtycBQKuAtaSUCSNpv7ZUnpWd6i4akHynqBdkOR/gqEhO1th1p9PV?=
 =?us-ascii?Q?l1WrkSiHNRoPs51z9j+xIGRFUI03Qi3RhKrXLRH22QXQ7Tlp0pCle01tvbKf?=
 =?us-ascii?Q?a4tzGPvbb6CIdprGvEgaq8OhLsw3j3kS2pLDFjx3dMckw6AbjsLm1Shf8SKz?=
 =?us-ascii?Q?CKHOgPpX6SG5dhsESS5xhWUDWb3tbst8Ax722T9tvKc32HrTAUd0q2XaunuV?=
 =?us-ascii?Q?25RmFTH8Lag6SHOVNY5hr7/cgFx+te59rcsFoRvXb2K3mf7UbJfkf5quNoJk?=
 =?us-ascii?Q?JOIOJv4rv5WmC+KfO1Z2MOWJXj4dGr7IHGKyHYbsIsD6ge3/O83ixfXc5Fl6?=
 =?us-ascii?Q?MfoP72Js0euh3LDHggK/IVlEPEePU3lXlMfOgAKNDK2GhwFuYHLnwanrVc7M?=
 =?us-ascii?Q?X+CZ4L249aQvmfkPuxKd9fE9C2ZS6Lx2mqWsfXYfc7NLCI/SJCP3JgPNTonZ?=
 =?us-ascii?Q?f+szKSF8bOlySeMT6lwT9lkYmGSHDtH+uoLZY8CabA7F5sotvocF1s0UC6DF?=
 =?us-ascii?Q?6Abqsgbgvw4q3i+QgqtegPSSvrvjPrHGToCpiIVH7Fgqk8vjCZKmKji7CM0G?=
 =?us-ascii?Q?k+wcOTyjWdqvYuvtN//OfqwjwEj6i6GC+aDN5gQEoH3xUYbgfgyC46BM5k9o?=
 =?us-ascii?Q?oF3cKo7t/FBbWOnNuNxVulSGWsT1yaWNxUzPfwggPr8OfMRsHy5fNiWVzXea?=
 =?us-ascii?Q?D+lonyDtfQZO5qltbGk9aDD3fcaSuQOva2AnsovtbpHMxs5TXpaPl66rYNaC?=
 =?us-ascii?Q?sf38tcrGsC7WtyQiC+QNAOmLtpMIJoyBibiUYHkLNgoKrc73plFrm6ixdtBY?=
 =?us-ascii?Q?Jkcc50Gq4HhJ6rbYsdms0X43cdgfnTGby7wb6dOvvxvc4X0ECCjIBcx5AWw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: i7OYpZeqKHMkJQL+29ikJobEU9ywQ2kwKOeFUkipefL/t+4ofv49FY/i6hrcS/D0med2u6V4bh8tTjfF3U5J9JJNHDVdwCwytmCl0UQdAp+dZGL8F+U+/TzqBO+GaWMu7PFzI03CEsKrJ6ekYpQEV4gNJdkD9dYdBSdIMwAaoyl8vPVRFGi/j0hseyhGNud0NnG4HF286dJsPGHscYI5XfcDr9khS5yoXvWW6tIP4U/ZONB+QgmTS+E/2gC87Rwk/ZqdT7kKbQWiXXH6REXT6ldx/h9d2t3PojjtQ7c3M6O4X0QVfM39ejvlHvT/mE6IQDvvjrPYSad6Fc/l/4UzMKom3gXmQKTXLPrxyUFniK4=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1915;6:GccMkYl79jzVnOT+7D8rYvfDZpKINWmvo1J011w+p60zi5y7VcBTNVTQ3moAHtuvdiHRiSGv4hzQdp4teLomuqWHPJh9tGrzalYTgVLAecDCyTKZ+7OYwIl0hq1WO5bgnWlZdWaXzTu444AY74ckVqgEsaZrpzxRelMdvWdhOfSs/zyiVz8UMAYOR5XwCY8XtdZ4EwVH6IxnP5/nRFzHOqWgv8ypYRlRlY4H4Qf6RsBB7rW7u63T9cfmOljYtJE5IGDFJi34IpAGYGXRSV3u+eDHb7HEOwRyPE7bKjPWeQf5QUA0PnTc5qhBlnpuMyXp3T5L71vtp+jjv4OBb34dqaLVA3RfFABfwmixz/wQVdU/WwSi3ri8GlJCjqq1RGEv9mngqP5xj7s5A+7hmXeikFNbh+Ssx3wkwmm35CTOtPnHKGnC2iPhSletFmznrg40CMRYI5LPVy3lXahNdWNxDg==;5:bOudvkLRqRe30HgzqCfdZVxCBxgY3HlXgcAsArTSFkq4BYo17uvzj4DGtTIWezWcuEiyKhsB514/l2BAy0nIbPKZJtBcXCUi1yGqU6HXWpEyijpjWS6CQjmDZfk9jLfY8g92qI5xP5GkvG5sqc9Pl5a9r4JfnswTnHE6pk1+NdA=;7:ujy0lJrO7L2mIyKGdQRv5FW7k4/40NsrZ626EXZwQY3HF7eHJA3vEJzq5g99CzxyW8dsCNibnzZ2rhOt2kVSROXgDjhxo9UHfiNefLFAbywhKAkR1qbeNhYsIqF3mMGLO00Bts/JD0XUO6qmpIB8oG3rB0ACea+AnyHtMEtvcuXH4YgiYC3tjER8am9ZBvw4+epxklSw2C7nuF8C8GvhwUP2pRdsryc8894a1Gu0pti59i9XxltrT4jhitz8aMv4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:06:03.1648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c630aa6-e57c-4424-7025-08d5ed5f3c77
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents Synopsys EDAC driver which reports the single bit
errors that are corrected and the double bit errors that are detected.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../bindings/memory-controllers/synopsys.txt       | 25 ++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
index a43d26d..5d20b76 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -1,15 +1,32 @@
 Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
 
-This controller has an optional ECC support in half-bus width (16-bit)
-configuration. The ECC controller corrects one bit error and detects
+Synopsys EDAC driver, it does reports the DDR ECC single bit errors
+that are corrected and double bit ecc errors that are detected by the DDR
+ECC controller.
+
+The Zynq DDR ECC controller has an optional ECC support in half-bus width
+(16-bit) configuration. The ECC controller corrects one bit error and detects
 two bit errors.
 
 Required properties:
- - compatible: Should be 'xlnx,zynq-ddrc-a05'
- - reg: Base address and size of the controllers memory area
+ - compatible: One of:
+	- 'xlnx,zynq-ddrc-a05' : Zynq DDR ECC controller
+	- 'xlnx,zynqmp-ddrc-2.40a' : ZynqMP DDR ECC controller
+ - reg: Should contain DDR controller registers location and length.
+
+Required properties for "xlnx,zynqmp-ddrc-2.40a":
+ - interrupt-parent: Should be core interrupt controller.
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

