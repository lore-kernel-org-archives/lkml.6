Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A26ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24DA206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Xuh18fYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24DA206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeIOTtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 15:49:55 -0400
Received: from mail-bl2nam02on0052.outbound.protection.outlook.com ([104.47.38.52]:2531
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727291AbeIOTty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 15:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+a6g0z3IhGz+hFHlwJszfJpzjxTMVuw8QXQm62YGiLU=;
 b=Xuh18fYxdiuDgGrprtCW7bY1n5Xq6DpR3nVpdmKji8YGRuIj9Sxw3fZfN6WqzMXPDz2/fph1KRcIRkC7wSlx6rE157Y0X4QsWSaJbWQXhfH2JA5QbO4KMB7J00t8pRci0JKLtGVas2SQFSrTs9PgAr872412lWNpHS8YifYri5M=
Received: from DM6PR02CA0010.namprd02.prod.outlook.com (2603:10b6:5:1c::23) by
 DM6PR02MB4474.namprd02.prod.outlook.com (2603:10b6:5:20::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Sat, 15 Sep 2018 14:30:41 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by DM6PR02CA0010.outlook.office365.com
 (2603:10b6:5:1c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.14 via Frontend
 Transport; Sat, 15 Sep 2018 14:30:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Sat, 15 Sep 2018 14:30:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Baq-0003U7-TM; Sat, 15 Sep 2018 07:30:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bal-0004sf-Pb; Sat, 15 Sep 2018 07:30:35 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8FEUOWV024958;
        Sat, 15 Sep 2018 07:30:24 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g1BaZ-0004qO-NK; Sat, 15 Sep 2018 07:30:23 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id DE921604BD; Sat, 15 Sep 2018 20:00:22 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <apandey@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v5 6/8] usb: dwc3: check for requests in started list for stream capable endpoints
Date:   Sat, 15 Sep 2018 19:59:59 +0530
Message-ID: <1537021801-23896-7-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39850400004)(136003)(396003)(2980300002)(438002)(199004)(189003)(2906002)(446003)(110136005)(16586007)(186003)(54906003)(90966002)(316002)(126002)(476003)(336012)(486006)(106002)(11346002)(426003)(2616005)(106466001)(63266004)(50466002)(5660300001)(26005)(6666003)(48376002)(42186006)(47776003)(39060400002)(305945005)(107886003)(76176011)(50226002)(81166006)(14444005)(81156014)(36386004)(6266002)(51416003)(8936002)(8676002)(36756003)(4326008)(52956003)(356003)(478600001)(103686004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4474;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT024;1:q0U3HFt6dkIetY5UCsw09/tUfTARbOwPaHQQ2Hl4lswRypaN2kLYrgAKfwiBoqwSu37uniwkhqYLVGHP60O8QMBTfPFw6Tg+fia9NiG43lVe+p2GuzB7ZtPyJSdOeTTA
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd5651f2-0e99-43c1-c0f4-08d61b17d085
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4474;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4474;3:Y2OyIpkW4buzcwtLKnukmssjPdvWG4zACBe1gX+2mAdpjzTURrMeRKh7jvFDYarg4qGvd7RLjoTj3K5kcno3/i0T9A849f6q2f3hKvj896yQiPfvkzYTaUgIiwt+fguV21AiiCHgpeNl53YXw6C8uoYuF6FWNeP8FmSmScfnhepB8GSsP0Fr6jVjg4YOaw9U8wDocn0KjThRwoEw2xcPoCw6ubz6m/WNlku6CgCSNfqixZ5lRaP5e0nqRUJ62Hl0rb8erM62pKJIRqE4gBJVpTLunv4IIvFiWoS9z8rjKV4S69oeDPUVjTSA3dkRsjbcujksONiugi8YwAB9EswDS/bws3TTxgPyu/lQr8SAruM=;25:6BORBIX/mkohoRS9nYdWzbs79vmgxosX2uOs4mMrIDfCNHO3ZidLXSxI29NQSqFVWYREnBoqUUSxpJ2UgcR2SY0ogk+TPeOTn0fkSEXo3WncBYo8m5IgabVL7NWNjSBQ75tMVq/pwHe9gqBfBuAA0jPAYQqWzNauz6at4GVgW8qN+k8229mUrT2HmNZpx1FwIDKuRTVKqIS/kdyrTHO9TkOI/XOTzIIQzTwLAz0tmEH44lpgj/vL7EW37zj96DD0LAcWo4fbpQxFql/aT2UQaUdB0DAupffJ1kDomlWnYoq1u072Woeu3oVpfRLC18hrW0bzpS0rEQ3DrMeKx2ennw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4474:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4474;31:vki6+dYWxxDUPsjM1jQ6UfrJFx9QD+1KqyGr/ZYOp5hgHopfPqgMe3+7dLt6uLQoJcVQKIy5wOtq8rVgv3wK4CU2CWWs5/lawRy9lqWMnmubLmB0z7nfSei1q6+Ei6zwGbhGBD0ATi/FcNWPTYprYY/unVoxA9J+DnkaNaT8JwBkmB2LGlcCr0frbRWQ2LSq+nOWHNPKLfbf8+NJKgY66SGMHcJZt356TVsaKPCb/0s=;20:mQOHLiIJ9vhiYZFXKb7ig6rj3Ggfvh/IXTqCc0L14yDbEB5ysWkuYJ2qPG1cQk21AHTYPhwG1uaEUp+/Ckr2eQzIXTI4owWiNalL7JAkSzvy68hU2OpEEt0R9oNgpoWuD3lF3mBWlOibMaOl2BuFK0YkHJeWIKUQ2m8qUN90FLuEUfrSR/zfquf7qJEADK8xoXvFa3OV8djkKXFsFPVSpl74Nzp1sQXwt+yNwZMKI2la2utcFFM4ZviX35wiPzp8QdYkhx9nDUC5t6J2tZ9QLrOExqpNY+fxZ10TfUAMmFknQ6xgeTHb0dty0ZwzyhvTqxpWFUFjc0hrPcr+vzw6UXS/VSlNnH4IMRYOzyPwV33je+xrTyYmJIeD99ALblTN8yJYitrbniQeS7l4tV0lgb/goed53y9EYD1HTbIGBbdmSk8Y3zUiiQRebXyyGPvHQKGxwL2s35+ns5UHL8KdpPrWiVzyiKJxdsPwPQpaq2YoxFIjCUTlfpvmjBbepfmP
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4474135586CD685F680C9E57A7180@DM6PR02MB4474.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231355)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:DM6PR02MB4474;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4474;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4474;4:QvuybYiHU0udOUSqBsGWeUSMAkBP/M0p7Ah2zVYRGmjMO7Kl33YEdZ+h9mrvDJie8KGiVgjdOX/xQ1MM5w7wmoXgFUhGrISzRlwHPVKNAYy/VCoBg20Hod/PXYm1hPtttvdvr+jLC0b62h868feg4Ee6Puax+vpHMgjzQQTeX0YhWiuGRd00liCOLXeBkZbZjEIjxZh+YjLDWNs5aT95sfAEDTTA17Tht0EdT8gf0gHOJ6NLcnb/nfywtY9d5Egj1IrcXsBaxKr8j2su9dQSXlTHpJmQu4wpphoBxwJTq1apmwUW2GoXS1FyjAaLlbTH
X-Forefront-PRVS: 0796EBEDE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4474;23:wr9fOyKrQHzFDaRPczrRWVMDqPjx2GvnxPwbO6TOk?=
 =?us-ascii?Q?0AsrNfgfbfEm5RFyp6Mglx23tp62yVg4rl5od9TyW2jk7I6P+/r6Oc/7hWzL?=
 =?us-ascii?Q?0KS2SNI24le9XLN+lB6mTIjM0yuM+eT+w+rBLDsVE14PUs3CAJZarecRnBtf?=
 =?us-ascii?Q?bpp691dw5byttxxGmjgYNjDyZmzlsdkFQUokarxjTQWE2wA2C4ZLf4ifvPkz?=
 =?us-ascii?Q?9DJKW7JDxodjoBTAzqAp7ggnzgHPiX1625D4K70k5d6AeAs8AjddoT0CzGvX?=
 =?us-ascii?Q?D3nxApxDOvyFfBF3J4tJyPA1F+9fCTwI3ldkF++HK4rD8/I/axdw1czHL2do?=
 =?us-ascii?Q?4BvQs58Lq2tmG5Ejc5D3Qz8oNF57VuF0jM+xwCyT6vcR8pHOEYproNlfGRqY?=
 =?us-ascii?Q?lhEuxzKCXovzZrdNCN5HKPESnjkGpl63Q6V/aFczPCjwz4573UeNon/LKeak?=
 =?us-ascii?Q?7S/oVqMa5vi7innzwiMLw8r6jX+XHwWAgRPx44kyj+NdZtMNPro6z8K2jKRo?=
 =?us-ascii?Q?nhZwCmJdj2nuEKpwhRjuC4wwM0Q479PY151oGBTgQX1HevCuXkm6+1Ll0/HM?=
 =?us-ascii?Q?VVppIMwIDlFnkSK4VV9icHSlZKKkCFj7squYl4pBv/FrhfTQ/zJLD0nH9ykS?=
 =?us-ascii?Q?itDip7rrTd+b+DwGYQ4vMl0rcLDKBvY1TPEXR070XGtn09mS1H1JVbO5dNey?=
 =?us-ascii?Q?d3dCikiXF+8MqnHtn4dNtjBfInzOVNRsPmgroWl6ecmXyBFrW5ZlqMQ1JD2j?=
 =?us-ascii?Q?5ofq2mp2GIBOaKSJ8fVmy301Boc4Ic1c7JWt/T/KZ8qn0O/vmI2rk81ZpvQE?=
 =?us-ascii?Q?7QGOhF7WdgLvQZp0JV2GUmQmSSAtaZI2r2GmdfUhkGP+aFgZpMvbrQC70CHQ?=
 =?us-ascii?Q?Y7W0KfXdmNstImyPGpJL0gJ0fyToD3w+cA96Cn12fGLCwaleZ/sL1B00E/6r?=
 =?us-ascii?Q?YWBmGVqno9XDtzi1VAM31aY64hYuckRHfpm8E+lAeLmO4y9OFBRNqW06/u5c?=
 =?us-ascii?Q?osAPv8717ljB6zcvW/PU7XNXmArmq42Dy0cpSPoyvPopUjFatuDPmfJTxucc?=
 =?us-ascii?Q?R6go0UYs76K0KSXFJJs7fc1zaP+kT6iCLnmwOeNvrjDPU7CYHNsq5HOz57V6?=
 =?us-ascii?Q?4rrhkva7kk7Ehb3Ag9BzuFzOClHeoxdjGdRXAYkE5jc4QWFs4fMes2uV4Bm7?=
 =?us-ascii?Q?fhObuZCCC6vbGNo2FhvFVMTZ08NSFb2AJz0?=
X-Microsoft-Antispam-Message-Info: wE7TIS9oY3KQaPQ4EmKXEBGuf6SVcFtnTO9EuM7iSXAcqkR/8yhTXswxFFU9FkBuPT5OW7iMydiOo5eD8JJF+unQSFq+MHZ1uIytsCpFo25vPbMpxnEovSX/UZ16ssGlmG5kcdYJhpwt93Y9nu7cNxvleRT/6s9nJctlRqNuW/fmyR0tdxwE/9C4nM889ODFlidBxVRJkMo1OqmmbQHPCIqL4Zw391U8VHHXpRParGcvve+KFF1ZU17qGTBd2VXC2U0+hhBVd/Buh2Q4YSWLR8Xs1UdEVsqaqd7lzCYcHm0fqw/IJYHiWtH2N65Op4w0ZCovqDdYrwRk/T2ie5b5Hm6r4gs+UGumnsmANWELcbA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4474;6:oV0Hl8dUKm9CvdWsAqyAr9xeZoUKWFckATtIO+6rgeKc6ItfNiIAs8E27ldjetBedX5JNcvA/Ll63a8tz85m5X/xV8KsHs+1mh81hL1LqAwB1RaSh6uEOfr2aRu1KI0g0cM+ZAVfoXeZ956fukfWSEMrpJf4Ra2pTORAjSDabll5fnTj0fDHxOeewBjrb7lnuUoKI5fOvIB6MbOuhWLJ5Pa+roFHQ8oOp9DEE/bK8qtOZJJmnj5BOFPGp6VHYFegDaH9gkyd60Q5TrHZSCQp7/LLdiZEkgxbeYvS3oRrrqtshTPmPHzaxrgz6GYnhlPfK4swUzSdwBk2Lg24DKRgVe00j7ElWBD32rovsSud8X+9I6dxCP6sOQXmheAJ+2VyS/QEPgHsLfdR4Sq91gdtSgC3exh7+UJJPRFiVY/ntZ9ngA3t1SJcsAhxRzzpeGytNMtM46Mlvyh3SrZjElU7Mg==;5:bF4D+Q8FiFjdrMM5sqixr8aQj8n/Va0GR+y/Z0OwD1XzqTH+crGXI10D3swuwvym98E4NsiIj0xZ7yM4rlN8QFdYV9JuNzxivaxQbZB6LOEdH1rfB0frs5rXSvjhpj/ZRnDj1ccchkC9AaJqW9FXIAH0ezNgJbiWCmI7Hlid8AM=;7:tf0npyW0liXrcCqY/95lg7BiEmuN0eQjKSyr4+jCnSewOIH3zNw7Bq93pRkdVjN850kjMoCCajrsvHmM+ItLFqGC9h4GMhGbm0OdjBOBRNEkfpz6Ay8qsjo6MwZBO6/yVS6zN1rYhKgpN49tAAFFw8bNctdt27na1Rly8nGEoeuOGYdmDvCrG74iE3aPIwj5rNRyAggz/va85sHONKP245g7GFv/rFNMug+rAMjUwVHSGuGsUhk3k0MZtF6tGHyd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2018 14:30:41.3295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5651f2-0e99-43c1-c0f4-08d61b17d085
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4474
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, uas layer can queue mulpile requests on
single ep with different stream ids. So, there can be multiple pending
requests waiting to be transferred. This patch changes the code to check
for any pending requests waiting to be transferred on ep started_list and
calls __dwc3_gadget_kick_transfer() if any.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index b2d68f1..1cb7df9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2433,6 +2433,9 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
+	if (dep->stream_capable && !list_empty(&dep->started_list))
+		__dwc3_gadget_kick_transfer(dep);
+
 	if (stop) {
 		dwc3_stop_active_transfer(dep, true);
 		dep->flags = DWC3_EP_ENABLED;
-- 
2.1.1

