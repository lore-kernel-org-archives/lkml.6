Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA5C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B5D2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ssLZbMy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B5D2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeJDWao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:30:44 -0400
Received: from mail-cys01nam02on0043.outbound.protection.outlook.com ([104.47.37.43]:12648
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbeJDWaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPlgHWwxxGeMmES3iC9R2B0x0FGDcuWpvXvIdyeQU0I=;
 b=ssLZbMy5s4yEGLosZ2yakv8tHwZTIUlHwDessYqvuWZxDWcgsdM20LFx80bzVXGsbAZhE0yIRpQNcc7i63SWqXHImcesO5xLxIfx4RJi4H3gK2kQFT3HNVAuM6+Y+To8bW5l2XWg97Zt8ZT1uQvZhLpRK1ioQt3lTlqn0qi2cKE=
Received: from BN6PR02CA0040.namprd02.prod.outlook.com (2603:10b6:404:5f::26)
 by SN6PR02MB4765.namprd02.prod.outlook.com (2603:10b6:805:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.20; Thu, 4 Oct
 2018 15:36:12 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN6PR02CA0040.outlook.office365.com
 (2603:10b6:404:5f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.21 via Frontend
 Transport; Thu, 4 Oct 2018 15:36:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Thu, 4 Oct 2018 15:36:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85ff-0001OZ-5u; Thu, 04 Oct 2018 08:36:11 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fa-0000EC-2A; Thu, 04 Oct 2018 08:36:06 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94Fa0rQ030960;
        Thu, 4 Oct 2018 08:36:00 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g85fU-00005s-CJ; Thu, 04 Oct 2018 08:36:00 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 921DF121465; Thu,  4 Oct 2018 21:05:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v8 06/10] dt: bindings: Document ZynqMP DDRC in Synopsys documentation
Date:   Thu, 4 Oct 2018 21:05:24 +0530
Message-ID: <1538667328-9465-7-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(36756003)(16586007)(90966002)(446003)(5660300001)(50226002)(54906003)(110136005)(478600001)(63266004)(2906002)(8676002)(426003)(106002)(81156014)(81166006)(106466001)(336012)(26005)(2201001)(52956003)(48376002)(8936002)(72206003)(186003)(50466002)(14444005)(36386004)(2616005)(7416002)(6266002)(305945005)(44832011)(4326008)(103686004)(356003)(51416003)(486006)(76176011)(316002)(47776003)(126002)(42186006)(6666003)(11346002)(476003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4765;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT029;1:HLIeRtopSgrdCgQejnV0+ocKKH+bLC0uNvBFK26jRtla19zDb7QBDYqPjZYOATlX1jHsERxKgYGmFWhxqbL6Zzaq2PXYuggq6f3/FXIatD9VzfZo3C8pMO2xAEVqxhvG
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1c5880f-a88c-443c-042b-08d62a0f1d15
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4765;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4765;3:NVBPF9v0TiUMsAC5ieFkAl5uBEQSl2S+aaXEE90r+Jz+sFPU5FW6fn1LvzikGv3m4ErNIcc0qzvpJgkxUVZpEflp61cm0as/qutQ4dwxFehgoEGYLDGub1IlidGSLWYjaPykDG+Z07VSn9QLXzBEidlZepN3kEgFB9oIHap18QtMR1n1uNShIlkpqqBFUG8LH60kDW6SNJX/ULASNIbHaRvBIg40+6BBTei0hqn2NZjOXXjzZvMErdSn2MUIV6YSnkf/0ZJ4cMZGm6s1eXLCj7eyHwHOBO0hOI9QTT5iqpAc4/ZnCK9ug0LKb8WXrfhCZk3XWoyiqAlnsFrIrX9mCy2Kj5aNSaVKpH/Ib1AtMlY=;25:QXpw7xSSuTWUBmgao0y/DbvqmkYpqOhDzn2+7uM+cCgmQjR4FvEMnuFoz0D8izjwKz0SGSQJSTWIK/067iFz32zszmQq5Bz4oC0pX5jNp486bU+KrA46ykgu/r7aX6dGpQ3QO6YMa9bReK/fmuIqxGkxwzV9DYcPOgiuoXuM9KIgpu+wKSpNBtjbYC39e2FbRFQaRZmxtkC3e9IoF8vu6TJ9lL0UhtIIDHveq/bgBgzoe+k7L4Wo60KNgeM9NdFi0UHfiEgQoHJlLN/aHsbZ3GzOWz7J3F95z03u+T1QJXG4FbOYrLTQU5JIRSCRYUnz+N3b3IpDYmwHs+NpjjwFaw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4765:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4765;31:SXe97/OVTxVUg5n5snEsckTXfruXkUdKpaujRVmCpV8zcbQwaci1y7XSf5pznb6ylYZjccQfbM+ATV6aM8MJCtgfsv8FE7OBx8++bet32sRo99KK+8w728cxueu6tODNdjqVkHYUvV4OLphHAJZJudriOELRwIhOQfQO+SYR47lppvFQmml2sqZQpDoGGZYQVevlTdGgbhIaxqaq83nRXsD22VqeMLcujFNwiCpD3WQ=;20:UZAhwx9uep+yooDrCw1Ge1hh00j72ahMZn9ijbVJkvvEwNU7vQcj4KrvV7pEucJ9ZSEbcq/xT/6i/lh6Mbo42oyciZQW8v//7T1gz67OPQzi4Vd8FOMRB+9XdPcRIjHEeGBgsuF+Q+OhSAAcmPlQxeN0IE+dp9/jKildZvfhEtbiXLviO+WFo1XiG5+ZF9dLy7T3t7v7VZTX5Bn+aSSh3NII2VTqqJd5HALlE3Gg3kioDCab8X9MJAIJvfrLQOXJ5CW4F9g4s3KdZw/qmzhY1qGzT1pRVVn29Vuh0FbtXf+efgWpSNTGFuwv2m+DcsP6g11eHPMNZVYwQwm5bZY8P8sD4AOAGQ150x7NftbVK71PTecnGL96Og948Ps64V1H3NxabZ4EQoCHC4uprwUFleBv1eSC6SKKs5dL+XVWRMuI3wALSy62YcR85YIWNZloXN6c4t+Kx84CpYc9+DCZ3D+vezsxWQYEug2N48zAvVFBGv8UmIbzr/3lQQkkOuc7
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB47655920127AB43B4E48B697C1EA0@SN6PR02MB4765.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051);SRVR:SN6PR02MB4765;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4765;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4765;4:g8KOQJwTZK4f7bpmxqMRlpARA8UUekcZvJ9ZZ7XGNQ2q9D16ipzPW8PiHVglqAgbTYHgils6c9HpOwKSR4vjJsDmdOzgv0Ssd3D91K+hnI/SSOa8DBXEOmfOXioIoYrGjQRJQJAIizECI+owlwU1XRXlkb+Hs+SeK+DUaAk1vuJHDjsjDJdlzP4hBm3Hr9gbVZYClmOUhB7RydAMZR/sMoEtrof/u9JHRobKMcoCIwDLtnmkPTC6AIxUJR219s57cdHWLSiSbE5jHOR6/acvFRJYnlBbzeisTTx2Np4iQa224ZfoVX3JSl1pWT30CcY/9A8qSenEDb78eGOvYbf6TH/zhnwA9u4HrXqxV0Lyit0=
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4765;23:3/Og/90ILnYjTQ/lWYz0hCjNSRJsFRFOp2aFVwhuO?=
 =?us-ascii?Q?vbUsfYmWEc7YTKhJExXO0CWswDxGuHzLIFpYEXNogbh7fLMXWLiDaIhy6ufL?=
 =?us-ascii?Q?t4Hc722CJwI9id0F7XmE+B4t4dQpO5I+g0FZyRxC0f5sftDnjgUmGZAewAaa?=
 =?us-ascii?Q?dB5TcIyBu6Hk4gix7M4SWA3E58MPeCtjSeVwsoOVarN16zkVj7+39KNYUgp6?=
 =?us-ascii?Q?bEs2OMAo2BKTLH+8Cj00FB8Tz2lBrykoaTqpm0IsIHbUyjTNaSLllmRAIHFy?=
 =?us-ascii?Q?ZQ55R8PR3pS7fN7bG6WszpPzZ/zVvqmU6m7IZpEsLFy64nnyCHAF0v7uE1HI?=
 =?us-ascii?Q?hvL0MRwaccIW3565Nxu4Ci3yN9NXsiD/aGfgCWDzVViEikTeQuF8Jf9+Qf7U?=
 =?us-ascii?Q?UrTFJnDHwCy71O0oeV4FD6WouvhNSDjPohUsbzaTCUfhrR/MB3p6Jb4A0P0H?=
 =?us-ascii?Q?w/qAab8RF79iUvk/daVv8Qi9pO9+ah9x8WVNOWuWhwT/BzwEp7qMkkdg9Qch?=
 =?us-ascii?Q?GjU6auGl5WjcaPxIn9T9ihzbH3SG29Th3CFZu0d/6nPFXykV9m2FD0HbsE93?=
 =?us-ascii?Q?77ZwmaVIqPNfpaIH08hV6MsOaygvCBarBCTdhl8bHaKKxyY7lqERyFt92AnF?=
 =?us-ascii?Q?ZlfVqBOLp7qs7yeAyWIf8ZRqoB7EecPBvFxnF9yNyWKndDbJG/n1VA5NLg1D?=
 =?us-ascii?Q?ucr/x5xxcEYI6WyzH1PYW3DFbNtlMTtKm+gwWDM5/CmKFo7xaKY0nU3mZUSS?=
 =?us-ascii?Q?jrOxbYLQg/+X2ndBmfiZbei4IMJLCU+nUgvEJl8p2Pn/kRN/v/0UIXL9LEcj?=
 =?us-ascii?Q?me4bE+Tgn7cyapwQMCdk353lJWTZxvJi9sHEOVv9v8FYYNlrjCDSb5zVJpf0?=
 =?us-ascii?Q?3dRi6eYEazTFGCEqWNkDTxD7x4bb5pDeTJeajFDstCoBJu/HIf9OV3jd3Fxr?=
 =?us-ascii?Q?jLUcYXpoZ5PsXTPOyu+echQ7/aop3/Dt0ZyNwfxlqFbLea3ULmzWgy7RoJEW?=
 =?us-ascii?Q?f0la7Zxf9DX0nNRJ4IiFR5d9YRsmHBSXtJ5XqNKL2lmuq8CQqxJXDbBRZrB9?=
 =?us-ascii?Q?iiphgSvtl96Kj1th0weh4dsl5Oc0SeYOmfrklBqq051l39IBGh9R2hEXNzJy?=
 =?us-ascii?Q?6RDGB1/SLTrKEHMJVmxJdl0tuB+whomr1+61Vb3bC4YBgcs9wsHL9gn7qnUr?=
 =?us-ascii?Q?oeZboodyDKWL23pSMSlispGpzX2j0oABxVil5XSIOENGoZQFIWX6ujBBkdnd?=
 =?us-ascii?Q?fA0u7IPE+xgzwllTA4=3D?=
X-Microsoft-Antispam-Message-Info: krw7MfVJKmYjtrb4ZcN1ymYuj3iixfi4K0kaERA8GFYBj/Hy+cRoniyPk+vPkSa8976kWWJmsojAeRMue2XgtznGjSnfwkP7i/7sO/lS08mKrU9FLvvuZOT1Q+vCAraNvzsSaiCFVHGD3m4iTxJv9c2w1POC5TB19lzbpTxaVDrLH4KDPsppCk0V5c0gfFc/BqC02ilczmWPuv6Mirn/GBMuNXvGI+VoRguCv3JM6ziGbVJnkIVxrAVtuf4wdQ2XyPnBkiLXQWU0d990oFO68pwXNF94a0fv8x9u7Db6ZB5gX5owoe1V2Ya0WsEz8zLBbD/7JsUxl9l89bX7JvPNuxMSbu5cq5FEzv4j7xDdsOU=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4765;6:ICWRB2xe7jGg0WWJXreAdY7+f8oHkSnqkqa8a8pf3iwjozNaiywryGYV4Nq8BleqDZ6x1YkKiaSkqvX13A47fYfPnS6Nah5vfP3ET4SSnCIEakFLHn7ZPM8mpkO0lclklmquXOznl74d9oUl6DiZLw06hTZbaHWuNMp4TAuWKn2ORdDsF3M2JOQtlEdhpztc/azHAv5T+1YhDKaiXxHgFoBztTKgYtPLPq+n3cGZOwH/9ZotHFtDmDnQqneDFo1vh9eXj7OhBtFKyhMiIKWS7tXfje7Ofp9Zdfr3T0E5+DqbG111kjkBFA8u+5h87Vep6Sq+qfcB+vuKOYLMqrux7RerVd9Gs1uJ76y8r+HhT69paSq+9j5g4el7eEYoWyIrH0048uIyjGWlmjjJkX1ZF1XABfiM1cX7m8E2mV4YtUGBGtI2CkkknhPjGMvp6y68g39Ssw+yFU6+WENxZ/29Rg==;5:Ke6yuuw8NSTzmBYIM/WFmklY65o7ua2jeglX35jqwdvcc71EkU116dQlu2H/7XDHAPBFIoctuLQxwn0ZdP4lScEXcqUN9C55ZSTPvZfhu5pcs4tb55vzBuwAbzg3704ko/liqi9/Wd9bW9Y6pvRzkRGeqAJ56atNiUDaavLvItU=;7:XifYbkVULzU7/4RFKVrFeq36YZyXbLBO8MlCIDkVprfte78JcHPg8/AmHv8bo+COvqJcw41xWzr9vyFe3G/m/gIOf+0ZlJ0lsAJMniNpSpOzhjNkkb8L66jp8znlSrDWwsC0HEosU1/qd3g5huba9IQVDD1T4w9qdjmPXNo8QfgmWt45CjqCvMiRqlffkrSMTHyRs1u+rFehcC7oHXjkpPDsRksoh7ziK4wVrzeb0uRFhhGn7ZgsMOASOA1kcOP+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 15:36:11.5765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c5880f-a88c-443c-042b-08d62a0f1d15
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4765
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

