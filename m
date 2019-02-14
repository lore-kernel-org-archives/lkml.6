Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF04222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hbwMBi+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393205AbfBNADa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:03:30 -0500
Received: from mail-eopbgr740047.outbound.protection.outlook.com ([40.107.74.47]:26526
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387940AbfBNAD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR5XeFO+figSswTHOWnV4OfPfuj7oqOVLTwqqLiK/nY=;
 b=hbwMBi+uX2qVkOtDX6psYPu3/juTwjL1OEcj0isUZpUD78wiAQcwQqp5EFNJV3dkJYOvApN/DqfD6+hyXe2TEx3b+JwtMnL80pIs52oZhgCTtHobkmILS5C0Pdchyz5+U+dP0glrVnkUckKgMJzldni8NAnOc1cVQNsUNMBe1U8=
Received: from SN4PR0201CA0037.namprd02.prod.outlook.com
 (2603:10b6:803:2e::23) by SN1PR02MB2158.namprd02.prod.outlook.com
 (2a01:111:e400:7a48::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Thu, 14 Feb
 2019 00:03:25 +0000
Received: from CY1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by SN4PR0201CA0037.outlook.office365.com
 (2603:10b6:803:2e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 00:03:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; android.com; dkim=none (message not signed)
 header.d=none;android.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT053.mail.protection.outlook.com (10.152.74.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Thu, 14 Feb 2019 00:03:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1gu4Uu-0004gw-Bl; Wed, 13 Feb 2019 16:03:24 -0800
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <hyun.kwon@xilinx.com>)
        id 1gu4Up-0001Jq-5v; Wed, 13 Feb 2019 16:03:19 -0800
Received: from [172.19.2.244] (helo=xsjhyunkubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <hyunk@smtp.xilinx.com>)
        id 1gu4Uo-0001JN-Ga; Wed, 13 Feb 2019 16:03:18 -0800
Received: by xsjhyunkubuntu (Postfix, from userid 13638)
        id 3EB232C740D; Wed, 13 Feb 2019 16:02:16 -0800 (PST)
From:   Hyun Kwon <hyun.kwon@xilinx.com>
To:     Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
CC:     Martijn Coenen <maco@android.com>, Wendy Liang <jliang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Cyril Chemparathy <cyrilc@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>
Subject: [PATCH 0/1] staging: android: ion: add the GPL exception note to header
Date:   Wed, 13 Feb 2019 16:01:45 -0800
Message-ID: <1550102506-24731-1-git-send-email-hyun.kwon@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(396003)(346002)(376002)(136003)(2980300002)(54094003)(199004)(189003)(7416002)(51416003)(4326008)(106466001)(107886003)(6266002)(4744005)(126002)(476003)(2616005)(486006)(36756003)(44832011)(14444005)(26005)(2201001)(63266004)(426003)(90966002)(336012)(52956003)(186003)(305945005)(106002)(16586007)(48376002)(50466002)(42186006)(6306002)(316002)(478600001)(50226002)(8936002)(54906003)(966005)(110136005)(81156014)(47776003)(356004)(103686004)(6666004)(2906002)(8676002)(81166006)(107986001)(921003)(83996005)(1121003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB2158;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT053;1:6kZaBwi6yGs0lXX5EyUZOJGSM28WwHy//ph33KBhfJfALC6cjSOVgdkhaHRDbe7HjogPUj/a3//B1DedCqbeRTbq/Eo7dN1WZhX2iXgvfpxqqfyWB4BQh3wHIF0AJPwPHzMR0Skx10S5/m5OP8LMskFr4rmCaP58mEuD7sK8Uu8=
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 937dec4f-6217-4a0c-81d2-08d6920fd770
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:SN1PR02MB2158;
X-MS-TrafficTypeDiagnostic: SN1PR02MB2158:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2158;20:LMVkBT+F9cphAkoyCrYH7Rh1c/DLkKP6b5sBbXIyCE0RJlB+XXQU0yKY4HLQierQn0IZ6992O+257Qef6KfxSofeIYnj7/4x3If/VG5y2RvxwcN50cmS5gRIM0ULFgok/+QtdIzW/DpzHWP1jrKSfzLl3fRFZ7jUgk1dWfY6HqZRWZN5ldr3RbLFOTBt+zgzI/QtA7L8K5Jl9IMfx+mGQzKsW0eh83m5h2spR+6Y2erR7TuhSty+P67RU4LXlOGYHnSe4tdH5HWyH+wCuCZrOid/G0/o1MpwXfbHbhxsQgiJpT/SkRhBPF8UNIQ9ynB51wQfXtV6kaGCu+AYYe8bnxQ7QePxBp4uDVRFV1fywsPk0roEpfvq4Nrm4ERy0eNt63RGotf0jRw40AMOj2OTI+nHwzvi/7xS3BQGBP2yW3bclZTNUgmdn7Rnm/blz+C/nIPuKZJC2V50wE6BUxKAp6t3JHo4bs18rd3KYzGqQhnX/oeUi22BkVcYjWjf1cFS
X-Microsoft-Antispam-PRVS: <SN1PR02MB2158DBF32A3BFBC90558C939D6670@SN1PR02MB2158.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB2158;23:Ue2MEyxPgYehEB9gUy7rLNHzue1xBgky4TpPz1mhc?=
 =?us-ascii?Q?L+SUXEyOpAAZ/rG02KgFL5V6JacGT2FooamJebQpNtvT6stOA+xD/cus4LP7?=
 =?us-ascii?Q?8uI0ooCtZ/DaXJrq7V7vuAyWQ2wRMovbRy8GDEHTH6P+r/E1VURp50kdE4l0?=
 =?us-ascii?Q?NH/PJ/+/QlEd/igwq/BzPi1XpgJ5gsrLcPhDhvAWptwvzDS/W2eZ5rlXemn9?=
 =?us-ascii?Q?Dp7ffAVLxrRSptehDowLTfM+fCIee9zqnjK6UsK58FfsxYGmazWjBrEbZMUU?=
 =?us-ascii?Q?HZygbYSAzJRMNkcFH1aj1l7C8c7r1BaN7iZith+/eNhpKSuQCB8itbYv2JIg?=
 =?us-ascii?Q?DQEDmnhDPEv8ZYhR+JjzAvJOnhJ2sWvZpthlOH7rb2mR6Kl0xURzXDwg7nYf?=
 =?us-ascii?Q?tmgZHXSJyUboSyvF8Z/nRvtktXyasgovZstqwGUxQ4Ww+m9kywrX5rOkI/oG?=
 =?us-ascii?Q?Ug/bjnLiqoETbWFulUbI9cAPQhVQkm9FKTY088zp1mQWOoYRk5RCw9igR9sD?=
 =?us-ascii?Q?aLA0nqN2k43bcnKBAT+Gxhz6TwHo3yZ3jCsjDpN8YhKWWps532fJLDJbgIQl?=
 =?us-ascii?Q?tD/lU4Z5dcORkTptH65s4Nfcu7t9io7h43vhW7yBI1FLYVwd6wxj84DH9d+i?=
 =?us-ascii?Q?tntfXUlCMVOXYwoQ3ZSoXukculYEMhqoVXNEMNyKyqWdlH/NNqW4ctaXNAji?=
 =?us-ascii?Q?f5bjHzpG8tjYVYAG3lRGZsEpqXfT/wNjKfEbphz8celRy2zb8gNCacnlyZga?=
 =?us-ascii?Q?2I4jHdsj76PLbDplDT5FS/v2usTwP0zpe2aRH23Hn/4U7EBKPg7BjvVdrGMe?=
 =?us-ascii?Q?Lvqm+3Rn4cd+3CO2PlKesuwyLICsHW07Ou9Vi3cVmTS4PAfhO1Q6zAzhCQmF?=
 =?us-ascii?Q?QWM8C+XmDJKlA3NbzVAc8lgihXv5yDIUWGfLdHeALbAdcMtGND2TuUOKCGwJ?=
 =?us-ascii?Q?i7kOsSTZ39OBqX+ZFnYMWURCBlnpDZCToEl74IW3ul0yt9jXn1OO9JgxlkhU?=
 =?us-ascii?Q?GAfpyL5Jj8zsob27WlC9Apbkh/dLDjYeDBu9YEaw64w9Do9fZk2RDrZiDf0f?=
 =?us-ascii?Q?vwIwYKU+ABY2Q1Yq8g+6vphibtLhuyHJ1/xdBsiKHW22aMmTHqUu8cmuTELr?=
 =?us-ascii?Q?jOsXCFd19+Zu7fkN9snSJLMfSBM+UNTK8/jQUDc+CPcocN7IGMAJbOc83GOw?=
 =?us-ascii?Q?7SxFG3MdssWlkzCM5wmRBUD3NrpgNyPOTnUYOV2FfcPy8kTmg7XX8JXpcbk5?=
 =?us-ascii?Q?RLHpBF67QGbg+HbMj4=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: zimF+AY/mRKdQqOpzlc8zPTxuDjdhX0UVKw/kTqBjZuVA9kxjau42bPOgzKtaHO+33nZaQLJmdcNQkB0SxQvQnQb82W/FL05lwrjHg/EnaIBcjaQ1du1yYBHvxOLpgkjYS2+mfPRagu6yGizdh3WvMNTS5l28e3kaummrgBIDYrt+dEf+EAVSHp8hPNRBxr5odtbCajSmnu/7oxDJsq5VH8NeYaiVL1T90KMZhfC4Wf3kWKTVAl8pm7jHJFzwfd5uOWqmzpUYo6SBlxaSiQduDnTpQ/PYNTqQpFdnrGxM8j3TbSWiPpgxaFvVrQ9Q8qXHrV+DcH9Z62wXmmihGJOV6etYAGMaJmwyqAaLULJv84neDQ/i3fNSf7mCt4Tos7gNTbzxtH6XUAdYu3/qr3A9phQuJhzSnMBqgGjC6qROK0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 00:03:24.9178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 937dec4f-6217-4a0c-81d2-08d6920fd770
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB2158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wonder if the exception, "WITH Linux-syscall-note", can be added to
the ion header license, to allow user source code with different
license to include it without being derivative of GPL.

More specifically, we want to use this ion header in a BSD license
module [1], without enforcing the GPL license on its users or
on the module itself when it has a copy of the header in its source
code.

Any guide on what can be done would be appreciated.

Thanks,
-hyun

[1] https://github.com/OpenAMP/libmetal/blob/master/LICENSE.md

Hyun Kwon (1):
  staging: android: ion: Add the GPL exception for syscalls

 drivers/staging/android/uapi/ion.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4

