Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8C4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D74208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rJGXX1p3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D74208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934742AbeFRLwM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:52:12 -0400
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:12864
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933523AbeFRLu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u68EaC/+Rf3BT1GMhpaBtVmLhkJFNvZ00jMaXBmW0DE=;
 b=rJGXX1p3QhwirPXSGM5/05eIBRxqpchb7sfO6SiHSpdJRGloJTdcSVPRmruppyTELjF4FioFuBxmA74jZ3D16jQQQnbc0YRJADLq6E6KkBH60Q6pf2+lo4f+ncz0hXye/Q0GVLENtWsJt+4/sgUsNB7npOEqqqHokvn42FOXiCg=
Received: from BN6PR02CA0075.namprd02.prod.outlook.com (2603:10b6:405:60::16)
 by DM5PR02MB3734.namprd02.prod.outlook.com (2603:10b6:4:af::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Mon, 18 Jun
 2018 11:50:25 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BN6PR02CA0075.outlook.office365.com
 (2603:10b6:405:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Mon, 18 Jun 2018 11:50:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Mon, 18 Jun 2018 11:50:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfw-0005mR-I5; Mon, 18 Jun 2018 04:50:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fUsfr-0000Qd-G0; Mon, 18 Jun 2018 04:50:19 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5IBoDpB006504;
        Mon, 18 Jun 2018 04:50:13 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fUsfk-0000Jp-TD; Mon, 18 Jun 2018 04:50:13 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 15F09B2047F; Mon, 18 Jun 2018 17:20:12 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <andrew@lunn.ch>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] net: emaclite: Use __func__ instead of hardcoded name
Date:   Mon, 18 Jun 2018 17:20:06 +0530
Message-ID: <1529322610-27215-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(50226002)(36756003)(47776003)(50466002)(336012)(48376002)(81156014)(81166006)(7049001)(51416003)(76176011)(90966002)(478600001)(36386004)(4326008)(63266004)(106466001)(6666003)(8936002)(103686004)(52956003)(6266002)(316002)(575784001)(42186006)(106002)(2201001)(59450400001)(356003)(305945005)(16586007)(11346002)(126002)(2616005)(54906003)(8676002)(426003)(5660300001)(110136005)(446003)(2906002)(186003)(486006)(476003)(26005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3734;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT040;1:zlVl3mLh3+PZAtuxshcjyyF2wH3ONs/jJ6YwElkIsMSTKDRVc6eCCulaXG1KvdQ4ZyRvvC4YgDhJl0JKDhSTVZccwsC7c4E4SI/0FphK566yqME/hgfXs6uEMfEYTh1t
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1305a797-90c3-41ad-4b18-08d5d511ade1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR02MB3734;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3734;3:2Pa5CNsp1JgYMRdRMSJaZDCEXxid/Vy55kpBeM3l5hkg9OlINMMzf4E/wmvPOXRAc1kiAccDHSzPJ5wWqhE4G4JubqeEc9chGQxVy55QKZOm4jPVmtsovNEkFCdK6anSg5DtenMCJE9zCkAx51Odw0TDPbaieIcqfG2z2wTpks/7mZB4TiX0XK2eKjJWp27IR7Im8IswZFz+qTwLbGrknDHcfSNYaBnwi2XN8RVw43HMLp+RsoMERWR1xNoaDUmyGsjKziaIhLmd35mUH7+RfYNezrCsSDrua5cORNYpIBh40cLZZNXCSiuv/vV6kqcryJMl5OcIMLsteHCo8X8EcYzOa4fTrfX7QL+VsWKWZp0=;25:yo8s870WSV2StEhS1kxG9EfN+V+2vpF5qPGH634XYSpcHBwxlpv6VMfovBHypU7alhF4ghJJ9TOHUj5gA5uQYYywPDPqfhrKbuXgTSYgOZDdU5kJ95Vqj1qtZG52wm7wHZ6iLKQv6elDMSyyuHQAnzZYiaGbWt71ZDw6w3pzyv44aaZbsKtekTWy0S44rchY61VSRmTnAil6GOTLDahJLTKJ9Li6febHY33cm0uVt0OJk5N/M1AZBsO8PnivQuBLOrnmgD7ncaM1XDWJMo0vmF+FK10h6SpMYn/rdZSoBm++cZ2xnFC4klBkh4LEYv2nrDFScGmFf8AP4UEEHTP32w==
X-MS-TrafficTypeDiagnostic: DM5PR02MB3734:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3734;31:zcaOFdiu70FDYWNopqD9y8bGGLoa8nE0Cot877NPaPbiquIjsDIV9TZXUSaCUgLqZCEyPqtiCGBcWih2/ZFR2BbWZCDdTVqSw5z9U4JnVTaqXWOjRG+Jq5axaznfqr96Dvvk/c0r8SEqSmNVcVGjz+eWTQWZrGzFhWDN5KBP3bq0tlJYThk3PEz2hNrCyKBHRci8wjXAE2Yp/XcQN3piUyz2FsmBgIPyU2IHv0cYzWM=;20:Fd/cOtsM4lYTeDzn6LubQUzUboyRYfVkgvnohBlBgsMNOVV9ixXq2Hd9q9pV8pLSMhV8uNlSl6D1avUTJx7EBj0ShnkP2HK//uO4bZQiks6szH3ZsdT+IwIpaPfwjejHoF4cjwEUKDtibjr5YbcZuDy8v4reimCsAHc3MF38XjZa4bSm91Cd8uKjJwkehRjmX11UnYGWtyRltfuFprZ+oImEXiV9Xs3dnZaJsWNBeDXorRdg808lRn7BkvOslXSuMQPOglDeBLqLw0P7s6tJ2Ppp50hBNoDPT0f8B7xGwo71QtoHqxDPgWgPo7v7HzrUIDmIYQ1pHJblI3hK8ph23VYUiK7a1PiSXFadmmKkm4By8+R/SC1+sPnvoj/6xUK5jirMMT2cC06GTw6TzSrvQEq7DKhyRMll3mjH5nbXWqZ233iNYJ/zyaiaZBJjsSjFCbLvlJ0mkLUJfJH4yQX08LLMaSks6NssL7fYZ2kgUEk9EbSVIA/fr/Tvc+UQBiJ5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB3734B88A1750F3E9666BBF07C7710@DM5PR02MB3734.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR02MB3734;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB3734;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3734;4:KC8mGrswkk83gRqacsRe0ZHzk21r1KxJxp8ccF4wrTBcWqGM9ITi68/MoORfc4zPTQlpwwitiPAFchTgETuMzu92N0U8CqkBCv3R9Ir4loeYBZR9UUU7XK18hgtIsYuPbV3UFNDcKuIIWeMMm2UEAcvJxjsqyGqfTNk1oIM+sV2d4bgoS5QSSevhQ94dKZxgghlctTeEREBJKBj75p3++pKVld2WZDozCxntvYrS+VS9+Dx+0nOsNBYsz7QwiL1dLAsg/H1gfy6tDadsUlNPJeBsBmL2TnW3sk7BxVp18/rIHUPhXJWJQgrbwKnxNIiY
X-Forefront-PRVS: 0707248B64
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB3734;23:nrZbTljm0TRnT05/UVY0VRnkTKZudkCoeAUGtY2ld?=
 =?us-ascii?Q?oNgWrZ5P65vGgQ23kr/U8Rak7vPAopth3s+QVEmlJ0od3l3xp6fXgMkvp4YT?=
 =?us-ascii?Q?9k9YiLg2/terAcf5m6LZqw6uEzPQCTu/vMNXYfLkrdAF/sZVHrgyAuKBCVYD?=
 =?us-ascii?Q?wUS0tQH8+qcNPnoKa/QKuh+RZTtD7cIXvNn5c/TaByZuUXQmgg7z9fiFk+cb?=
 =?us-ascii?Q?xi3i4NJHlqy4epGaIIyh6JLmAoAUYbRCgS0MjrF86DfwsEDio5NavTzzG+nv?=
 =?us-ascii?Q?QojwhWqRAJF1QaHAKk11XtHC+R9gHK3adPjzpXjYcyt6jcUGa6LHk28W6o2R?=
 =?us-ascii?Q?2dAkLLK9wiiXn6xzIHBMm0DUs6L+H/8v2Bg8gHZRjFpPEoZ2JsMPZb9y6njv?=
 =?us-ascii?Q?Blp8xntN7u+cw8Ck4Rwz4T7+NPVEDQ1bIgMql8sxwnmpxoQxekjNG0fGQyt0?=
 =?us-ascii?Q?fIq5b4io5gIAAslpxO02w1WdCkLWEd36F9DnvwJwqnVn2F17hSVsFM0DRDGK?=
 =?us-ascii?Q?2DWy+UB5+tTDbT3rWHwERCIr1Orzl5gaJLXHxLcf4IRy4D63Rn41L44c9wjq?=
 =?us-ascii?Q?lOTlaQnHVeaS3duwbSwqkQWtdhsmxgx/lSTeJj8Zath3ZgnAD5CNmoS/qnTo?=
 =?us-ascii?Q?IaKhHu3bBubTcWqoM//YF6IfpbqO1Edo2U4Bvn/xD1WJJj6K35/D0Yuun5fN?=
 =?us-ascii?Q?Rdjp+oarM0gNTBOIGiiCsLGoGew7/aG+scHvBOtg8kMTF9kwwg1WjKUbjXns?=
 =?us-ascii?Q?Cbw4+e/2MaXKf9ZItmDLo+vzAdybUrR9V7gFpv3OAywanUzXZ+svcF7Y8268?=
 =?us-ascii?Q?3yjDDQUdJhwYbip4CrXkuhLM29QeLbypo/F5aWwDxZvC0g/Ny/k9AHWj08Go?=
 =?us-ascii?Q?01NyQOic4k7xX8s4CVM+/R/CkS/uIOTl9fEEu3pzt9izB9itE/jEQibaunNj?=
 =?us-ascii?Q?EdOfWOBlhO8bbn8dr+gvoEmoVbUFwCGOz5ITz4jbV9fE0CjyOHHyR/B7aNTa?=
 =?us-ascii?Q?K8ZRcSz/RaUZoSG6BbtndtKvY0HKrWfBrptsZ+rzDekIHXaTFhq5Zw8mcaDz?=
 =?us-ascii?Q?/XNfNY5dAcp4plMzJLheXLsqkvyvCanE9F8KiCONMTCuamBsONTZrsbWywsW?=
 =?us-ascii?Q?O1ajvk+FZpcV6lHo9fLxFg+6gQtP5Ia/PyAO/+wDmt71hYMqb/Y4eBjSVnZa?=
 =?us-ascii?Q?SE3LHcMfbX2RSWOqTbcBi5667lcVA+hLYPq8Lfjtne402LHdSuYqCQX6g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: wkqqSTYnviT/286ts+BcsjZKvdS0IGswsALUCPY8DUtO8O3pRnN0fMNVR7hwRZmeZN82BQn1uF0x8iY3jkpBTbyNU8rAY7OFN802Gd89BrDpjebsbouBIoyWCD2AYFJYETzQI74Anqk0upkm1EtuzgtYG4capO6IBeouUyc6seDhltdOg2ECIUVveiMvBDRQqd/aMcynO4BkRldFuk7z31ZaEMViIO44lkWwGEaOnNzD6QiYrFeEj+vh/Ly2TGb4+efX208Kb/gdZOhjZTHkmz+5BBvY01WpcoC5L3Tu4MzVvCU94xxLQQLJz4UvoF6lpxrBMhAfZGK0lFuCrLUWMA==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3734;6:R45l5g5TlJj5Y+Q7iatoP3zX2whSgxfNSNd4oKnosRk98BLtYmlsq0WMyhjjUrR2HN2byPVhsgcVJ8uUmEZczW5Vqff+AH38sj0ipK+elFA9QKcyLJcMFhFXGBU1isAdF3l7Z87MRxFkDgNgTAnk35cCpmBg/dAhscmq2lQ/TZfwQk7H3sCYHJxB3/x4a06O9rqrNsaNKbmLBtxNNRyIlRUXzC2l4xAizKHsxTWMrScdBXkSmBXLeYDm2zF+1Ow3D7uCGAyQ7RseH9VMJZZcT8D8bErIEyRFNpzkqM1I7WwKD7S5Ni5Xa+hUyjsd6R+yKhVOr7D0OZ+b0HYz0IYaxT+5B/ijFTgIMgILsjUZZa5Uwf5Ejz3984uxyYE18khKQeqy0mHEW85u+Rpjzey5PT3jUNRFZKLHXO1maVD08VoIpR51nB6rvDpPLK466cuP4qCsPDgooyDy6aVimQ3SOw==;5:T1K9T80M+HEADoakuhMkDhCXA7YniwuRSS/lWUrfkLT3zlQfOkjDZ9qseIW6FntyfNZpU/JnS2881G0GFSQWF3JT7TWwDu5aoZvtCuvEf+HBzI3fZL435ERhlcYL1o2xHczEjXJko6m6K8xyI1uUMBcEp3y6KKjzgJilPWiJpeU=;24:nrSo9DqqDw/jspMqjKmkLMRMwr6umul6dK83t2dAPTHe7I/l3aKiI0EFES3O9ZZCwzMkX1eZs6g5uN2xNVajZnHAOK0rv46DpiUWbwb8ycY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB3734;7:L6iDHu58e59dQInNh0O0sbfBTnFR9BG4Twj8lt9+g6qqcwJ8vvKtlSalqy/5BJI55eaOQs4KRD7kPKKF2xkcXKk+LWkFW8HajRpbCCqAkw6Y+jmMHsnjvIf5KTx8IjhEF4ffTjnbrPdPPjEGnEONg0xzmDMdm7lIb63VonpGEJSVr26E1kLnmE15d9qQyyViYATzKeRNUOwxg1/V/Pvl8V4sTsbKcKS5clt65xdQe0ylko4MNdKuI/qPy+/HeL02
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 11:50:24.8832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1305a797-90c3-41ad-4b18-08d5d511ade1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch hardcoded function name with a reference to __func__ making
the code more maintainable. Address below checkpatch warning:

WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_read',
this function's name, in a string
+               "xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",

WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_write',
this function's name, in a string
+               "xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 2a0c06e..0544134 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -757,7 +757,7 @@ static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 	rc = xemaclite_readl(lp->base_addr + XEL_MDIORD_OFFSET);
 
 	dev_dbg(&lp->ndev->dev,
-		"xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",
+		"%s(phy_id=%i, reg=%x) == %x\n", __func__,
 		phy_id, reg, rc);
 
 	return rc;
@@ -780,7 +780,7 @@ static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 	u32 ctrl_reg;
 
 	dev_dbg(&lp->ndev->dev,
-		"xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
+		"%s(phy_id=%i, reg=%x, val=%x)\n", __func__,
 		phy_id, reg, val);
 
 	if (xemaclite_mdio_wait(lp))
-- 
2.7.4

