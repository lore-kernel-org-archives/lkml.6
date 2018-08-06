Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62763C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066F3218F0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a4FA+GFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066F3218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbeHFPQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:16:43 -0400
Received: from mail-bl2nam02on0072.outbound.protection.outlook.com ([104.47.38.72]:63672
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727340AbeHFPQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0IBuBGWw+cYhbAuZm1w0BXfXe28C/3g1nvjBpQomsU=;
 b=a4FA+GFFm1gpdcSWrzQ8R3jqjhXML+nB9CTWjj4jfxJ1rBnxwHJ6/4hYVSiq4hBFDhYS51N29jaXNniqyUsKMxXL3cQDDVqx/Sc1NciU/NHfqw3pZ8y1I9Yi83xzqtM/kjRq1BSy71EepBWn4c0zeOrtEBkfb6ygS4cfGcTVh1o=
Received: from MWHPR0201CA0014.namprd02.prod.outlook.com
 (2603:10b6:301:74::27) by BL0PR02MB4449.namprd02.prod.outlook.com
 (2603:10b6:208:45::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Mon, 6 Aug
 2018 13:04:47 +0000
Received: from SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by MWHPR0201CA0014.outlook.office365.com
 (2603:10b6:301:74::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Mon, 6 Aug 2018 13:04:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT036.mail.protection.outlook.com (10.152.72.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Mon, 6 Aug 2018 13:04:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fmfBl-0006Cc-QL; Mon, 06 Aug 2018 06:04:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fmfBg-0005K4-My; Mon, 06 Aug 2018 06:04:40 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w76D4Xmf022128;
        Mon, 6 Aug 2018 06:04:33 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fmfBY-0005IE-Sm; Mon, 06 Aug 2018 06:04:33 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 0AFD2604B8; Mon,  6 Aug 2018 18:34:32 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3] usb: host: xhci-plat: Iterate over parent nodes for finding quirks
Date:   Mon, 6 Aug 2018 18:34:31 +0530
Message-ID: <1533560671-32640-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(396003)(346002)(136003)(2980300002)(438002)(189003)(199004)(305945005)(8676002)(126002)(4326008)(48376002)(50466002)(106466001)(107886003)(63266004)(356003)(2906002)(47776003)(5660300001)(39060400002)(103686004)(486006)(2616005)(476003)(90966002)(36386004)(81156014)(81166006)(50226002)(36756003)(6266002)(51416003)(426003)(52956003)(26005)(186003)(106002)(110136005)(316002)(16586007)(54906003)(336012)(478600001)(42186006)(8936002)(107986001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT036;1:i99YGSTcpWK+4nvjAgEIPtJ7cKSleQ3h1RLAtsgGE8jii59D1ORycbv4+6MWLTwX6Bv8u+RkZjl6rG+e+1zi9U3Z3wyeW05IEIHxmwXNAvDdS38XYmRcxq+0gqnSI+yC
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bb81c33-6cba-45bd-d3c3-08d5fb9d2f52
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:zZoWS5v2fmXliLJQubAxp9lnJvWM9q8Wwel812tFfL9uBT2yBctksMsTriihqR8YsvUgO3bJCGQIPrDSJdsKOKoROyU2/PvZ7PTv/QOviID2kIbJdCu1cV/PQEQuHRx2sbn1znejVWJYtYydesswc9gKq5MTkZ71MPShxkmHLf2DaY7s730HhK9bhTezJVM5HHlaB4eCpmarG8DceKSYskRa3078VIUNTQSw7JZuw5lLUM14XAzDdg8KIsYfbKZSmprvVUhmpxC1N3MLKkRi1mIXO/EOQZWb5GzQ+48CLyjm9VZMcu7ThB8JDjLMapQfgNZ1PdFmyvxGL7QjzMljRsJZ1B6NbotZOhNYCCAS4sc=;25:jSIFBcY2jbE3nvVta5Qwgm+iXo+92CrueZ9LyKnd3Oz5pwQDhXAa9RMOUT6DcRV/Mq5HCeC79E0dlqE5xHRU/nDu1YADlOw/feI8vLxoXkSCMudBMRBRPjR4IKyNgocnWvUC6U0rtIHPXrpqE0utesgN+8wON5RDZMUs/TzJBEsiSEig4jk+LO3rX28mAvd5yrCJBgJANGF+8sylVx9O44FjCABuB+qvUBjjBiO3Qjesw58bpSaaSc7CnMyjqVeqYfQ8LMu73uKZ0JGIzHQEJ+9SLivEDSHnebTNfcPTuBvoYfh4xsXdhxUm6bj1vRsYhJPz1hRiFDgxO6ixBqXz+w==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:0pVxjzxf47VW4YrnTnUjNCs7C3RntQ0Jdn/NjNEIXfAzqTr+pnpWawQLdao0MRT3fk0Jy+E3d0SoqUiEnrM3G/v/p6KA4zl34qYqNEHu5wnhJe75n/4Dkxo//LfX9DpJZc1VI5xXJSwx9zZk3UceDLYVW8zqrjx7HJOoN8CrpUpzjnSGSYtjcoZ1CvORka1Webf1lYQSDN7w3+UxBzr5rMRQqLd4wPYzxB+N4412a2E=;20:OwloDqoSYPczyTuMGZJ/piY62Z9vfG9o8Z/g/rQpK0UvV4v+cMOs6yEOOIn9OuxjDBg68FAvNdhKxR0hHqaeXsaj5JFn2zX79oFT1+L8aA91X0lxaPzXUwU82ZNP6MuUS/3cz3cr2XBxyqgmuXy3uTpnh9YvWT+Ua0FMAZcqiejNIPznG8NRfsR81ysy9NZIXmU3lSwf5510lGQ2kKYnUSzsY9iRpqFfaHVZIgByEq+K8Hb28YZ55DjjMrgOwWKnkGRqgYeBCmnrd5hTO1/zLHnabaI+QiL/obTAYgRHK1zMtPR+tkAmNhIxFli000SMp07F+Uf5kLJzrMI3+bC3riBPOKLKg+FrX9qPU+FdifzM1D34FTxJlPjBssnhcSpaZANzrTvx4MBlRLHLiXwRqpBh2Nhq7lokFo/z+0IvTaZo86Z9F3gCV5umPVSVR91wmqzktl6pVxu3zLdld0ePwjeC11g8lrZEz5kUd789I458tXcbC4Qb0AyFMAqldgTj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4449BB917D9B6FA4ED17AA3BA7200@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:tUwrXpIq0t/PIMWql2ICpchewaRLI7vHz8bLtH0DwQsmZjTziQ3DiIBnz1vHzM69439bRj8eyUJiyjhyEx1YLgECDpG/VKhpWrfw9+lghFcnVS6ty1VnivJ4P3fid+EJxPI2vmOhpGHkjOUwRJDMpdStLIpYxc69r7MblHYJCMG6+trWYp8qa71M4aVwSYuwM+KtQgygLSr6OPtJbEIzoYT2tgFzaDjRuMfGeQoNT9wwvKL8Vd5aMoBuUpP4Kef1y/iMoW4UkPiZw36R1wF7z74psfedqeaJvPcwbQYO3Dk3FKgxOSLU6821UoZdB4dH
X-Forefront-PRVS: 07562C22DA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4449;23:iHLpJCsEKjb1K1kF2n67BCI4pB8kCAesha7lNoqn9?=
 =?us-ascii?Q?0v8RKMzBolAwSsm0mpVtsWSMj1xGO3LPEMYFgu/LlskjwZK1HfB3E5Pb5rwl?=
 =?us-ascii?Q?WOk61qhKe1joi/HEiggnqnt40mWJH/0tpPGr3Z5g3htTHZkezRsUtBHstlPl?=
 =?us-ascii?Q?mCyDOYXGzVUKd9wpzl6lRN8m6ViXu4pdU8C8R/StMrns2pwpOJFTh01kKi4m?=
 =?us-ascii?Q?zHolaNLDGI3HCPTluMkh5lAlpiI7UJ4VhYfMLGKYB02QWC9FIkxc7WHgmvNj?=
 =?us-ascii?Q?JSC1UImrkJ2t+4cZvyXPALutBDRK+kv5z44woTQnRfOuML2Q1iVlXpB4htlR?=
 =?us-ascii?Q?ybckzCtbgquDC30MSns2uTn3PcGM6tCkXTpK1BmA+WSg8GFE6L62KEeieJyd?=
 =?us-ascii?Q?jEqP5LY5GFLVWigQiLDYLbvE/ptmg2ecNpX4ZNUYM1ILgiO3jbWwUhZ8UAK4?=
 =?us-ascii?Q?i2G6hieYf6irj2B1pz7Ik77H+APjrAGGngCd4pg06O5/udJQVh0qaoKYOL8i?=
 =?us-ascii?Q?zfTZKiVi/wmijbMEvgsRwK+/hCwzFTKpY8thpG6E5g59ZZu+SvSLffk1tHNc?=
 =?us-ascii?Q?hi8HvKiLH4MSMyPYoXzljysnq6CkthEo1ONpZuvdy/RpLuWAHi3vXolYaEG6?=
 =?us-ascii?Q?0A3XrYago3uyueGyfL6Xrk/W1A3/VNbUbq9Y7SXfsYT4Vsy0TOl2j2vdSNIV?=
 =?us-ascii?Q?GbE/6DMu6RHQ3hz45574W3YhZz+GuA0DeLoQ++fqh3bkYZ9tXwU/9V5wI56d?=
 =?us-ascii?Q?RxAFtBkhIOT8YAIr2jELlNTdBxxF/5N2PMxb4e7a07npuw+4YIIAA3tlB0wG?=
 =?us-ascii?Q?SRtdNUFBiDOr48e0POgVZ9OA+vnCFHapoXz0WCNH8jIZj1M2Ej4HVlx0pOBe?=
 =?us-ascii?Q?v6QFZe5vxFL42yHTXzbF6XilAe+j/OVHDtBN7kNgbgfmtyRHvfwqUFmwMo+L?=
 =?us-ascii?Q?DSn2pFBscIrdAwU5Lfnzx0rbHgh820YMB4rr4ZHG1e1zo7YCbgNfsCf0Cvkt?=
 =?us-ascii?Q?6UxPeY+YRicDyqVvZJOqUfgu+0f/Gg52eqnWK29NJJRutGrDYw4svnofLXzV?=
 =?us-ascii?Q?3Ssfs9s6ixZvXgBeGiL6WOArGaUE+0Oror4zoNchEeI3HLTH6d8yHESPzJr2?=
 =?us-ascii?Q?6tX7oj7CTuOXq99Zf4aa5TWiXzU+kGWeun4b98bjVVMdnoLv7vqpJEbmlK43?=
 =?us-ascii?Q?H1yr0Ed0mgd+jRi2gFR3lEOHcriFNpt5mJX?=
X-Microsoft-Antispam-Message-Info: rY+oI9i4tgYhiMA6fwIujmYdj3Hndtwqy7HGYb5USnOiM+kv2FRe5VnB8bh2e30ZmGyp6Q73PgXrMyynsZ+gUVK2mbLtFLWdOmWYMpXF6Sk7uvbUGXxS2WYg/6ueBDUMQGw5cxK4Pw3Sxsvfuc9f/+OdQCwfrcJLGKLysdYOwMOcV7L4AHAFhctYxFkJStlBXw/MSoUQO79PdcjmtuLmnAuk7gyVW6AGcw9paGzsBt8iKALNz92OtM1PHLxEHhpwNhXN42Z1HMiw0Ersx2/P6M3GV1hrNHrR4wFu54RNtdM/vJKKKjrqyOh/5Btm7En8F3fc3uv2gztk+UK600XhOmxP72hY4HMDvp3AqkoOoD4=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:jtrWi9lB28hLdTRyP+1D3YWuFSjy8fQ7VPGfcb6O4C/1NnO/8a4Z5NTduabSoCMV/N0Bn86mq8FBnEmy09HgI7e2TI434RXKpx59HzPJKCeo2sefpDpsIXzvIJtB1Tf3ER9D+KHnr1XcVTVfa1cvO9MIozj53BXD/kS9mTYFS7Izl8oiqI4le7SFTPNwf1EH6St8FvkDwXYnC1vUjp01IGStRm0ry91+95tzuLXKVNwBpuA/uCE4FK64GLinJD/Q0nRbAjgc1WM5DvtCt3YGWRH6D5O3ji00whAVdSF2Qpav8xbu1Jy1d9bzzw0UnWpeWEfGxol1m9/qqClZV21O+2CRHA/saHP8z6omosh4neAAAMlX4PyS+bRibutkyxAC+LZjAGCvmTpujqOrteJNtVgZH04seEgsXluudaAxe6HkM0pkZ5Q5e7wXCSOY0IQYAzpm5tELBn8S0WG0F0Gt1g==;5:ZfJkn1+wxXFV+Z6lvrMP1FAgebPt+QhquDFHxzqT8fWDuZlI/zIoxH7g+WmXaPcp/fbTTfLBRvjTQqBSlAEx6bMGRRfpGMJ3RPSOyZpyqafOwmx/n8L/k3rTkOFwDw2rx0w1tyaNA42MvASm1NBpbgz3MalfrGEPRIcR0U61UaA=;7:BLLNAWvnOK76WoeAkDRP8rbYioFQ2IO8GvVJ5yorVQovxia6MXE9bbS8/Ulh/nTFkUMuvO+mDJAQH3aQO8nGG/AWbIHnH7+KL9tk1B1lEChZZVKgzkQFcccYTKad+dqhtCFnDvMPKZ4AQQfR82S8gNFQ64Bv+doTy5K2DtMLlnwD5Ns/w4zL+FvA8/JTva7Z4y3bOiZhgLWrNOEPQve9DAxgoVTEKz9AJoCxF9w7sEYOvBIh++uzZwAGmXjVKlVN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 13:04:46.2687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb81c33-6cba-45bd-d3c3-08d5fb9d2f52
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In xhci_plat_probe() both sysdev and pdev->dev are being used
for finding quirks. There are some drivers(like dwc3 host.c)
which adds quirks(like usb3-lpm-capable) into pdev and the logic
present in xhci_plat_probe() checks for quirks in either sysdev
or pdev for finding the quirks. Because of this logic, some of
the quirks are getting missed(usb3-lpm-capable quirk added by dwc3
host.c driver is getting missed).This patch fixes this by iterating
over all the available parents for finding the quirks. In this way
all the quirks which are present in child or parent are correctly
updated.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v3:
	1. As Mathias suggested, moved the position of reading devicetree
	   property "imod-interval-ns" into for loop

 Changes in v2:
	1. As suggested by Mathias, restoring immod_interval changes to
	   default
---
 drivers/usb/host/xhci-plat.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1b22fc..b5a14ca 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -152,7 +152,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 {
 	const struct xhci_plat_priv *priv_match;
 	const struct hc_driver	*driver;
-	struct device		*sysdev;
+	struct device		*sysdev, *tmpdev;
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd;
@@ -272,19 +272,24 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	if (device_property_read_bool(sysdev, "usb2-lpm-disable"))
-		xhci->quirks |= XHCI_HW_LPM_DISABLE;
+	/* imod_interval is the interrupt moderation value in nanoseconds. */
+	xhci->imod_interval = 40000;
 
-	if (device_property_read_bool(sysdev, "usb3-lpm-capable"))
-		xhci->quirks |= XHCI_LPM_SUPPORT;
+	/* Iterate over all parent nodes for finding quirks */
+	for (tmpdev = &pdev->dev; tmpdev; tmpdev = tmpdev->parent) {
 
-	if (device_property_read_bool(&pdev->dev, "quirk-broken-port-ped"))
-		xhci->quirks |= XHCI_BROKEN_PORT_PED;
+		if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
+			xhci->quirks |= XHCI_HW_LPM_DISABLE;
 
-	/* imod_interval is the interrupt moderation value in nanoseconds. */
-	xhci->imod_interval = 40000;
-	device_property_read_u32(sysdev, "imod-interval-ns",
-				 &xhci->imod_interval);
+		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
+			xhci->quirks |= XHCI_LPM_SUPPORT;
+
+		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
+			xhci->quirks |= XHCI_BROKEN_PORT_PED;
+
+		device_property_read_u32(tmpdev, "imod-interval-ns",
+					 &xhci->imod_interval);
+	}
 
 	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
 	if (IS_ERR(hcd->usb_phy)) {
-- 
2.1.1

