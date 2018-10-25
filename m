Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A79AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A914F20838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UsoOxX2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A914F20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJYOi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:38:56 -0400
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:11040
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726973AbeJYOi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPlgHWwxxGeMmES3iC9R2B0x0FGDcuWpvXvIdyeQU0I=;
 b=UsoOxX2DT3EDGeul8TjIaZjjzq13+8Ys/DgWHz2smd0GRFccZ44D062nB9Tl7uUBv0oSL2fAahrjHbZGDk25ivGnH01r9vPIXA0uzZATeO6Oc7Pj1dX8ClLJLoycB/nQLUtL3245FenYEL5hZgXuQM9ssXoPXoAalQ4Gth9w9jk=
Received: from BL0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:207:3d::29)
 by BL0PR02MB4324.namprd02.prod.outlook.com (2603:10b6:208:40::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Thu, 25 Oct
 2018 06:07:39 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BL0PR02CA0052.outlook.office365.com
 (2603:10b6:207:3d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.18 via Frontend
 Transport; Thu, 25 Oct 2018 06:07:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Thu, 25 Oct 2018 06:07:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYny-0001Hk-FI; Wed, 24 Oct 2018 23:07:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gFYnt-00082B-8f; Wed, 24 Oct 2018 23:07:33 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9P67OSl030684;
        Wed, 24 Oct 2018 23:07:25 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gFYnk-0007xP-L8; Wed, 24 Oct 2018 23:07:24 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id BEADD1216D2; Thu, 25 Oct 2018 11:37:23 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v10 2/6] dt: bindings: Document ZynqMP DDRC in Synopsys documentation
Date:   Thu, 25 Oct 2018 11:36:57 +0530
Message-ID: <1540447621-22870-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(47776003)(36756003)(126002)(44832011)(36386004)(476003)(336012)(486006)(50466002)(186003)(16586007)(54906003)(110136005)(42186006)(6266002)(90966002)(63266004)(72206003)(14444005)(2906002)(316002)(478600001)(103686004)(8936002)(7416002)(6666004)(305945005)(356004)(52956003)(106466001)(26005)(426003)(51416003)(76176011)(2201001)(50226002)(48376002)(8676002)(446003)(2616005)(11346002)(5660300001)(4326008)(81166006)(106002)(81156014)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4324;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT033;1:Puh4sJJHHzONj6fhGms3VJ418FWXvDyyrCOFp+ndz4iM7JaM0LuK2mmAqYM/Ruk4UGRLRRErbFh4RLVc4No4CtBe0T2pne/47kUFjJw7rAq8SLliRFAKoHT0JBrKwi3H
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf832eff-5873-461a-568d-08d63a402afe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;3:sPzGt/KTUKYVU+3Usol5+T6v8tQTIcsCzy5fD3W9puGpNBkCHjXLtwpMVcWDKg3XscxLpmiLLwSxovOfaKEaJnG2iiqdtb5U1Xva1i+9wqWLfegiOcW30gBGtZbsgbiRmOv0SykGdsaEBBC2r/RxUuvBUinCbx6kGDSjmQvRWVniqa2BW7eokH7CXHctvNRmqDFwKJt3O+IRGGpGT5eFJihCOOfwJVdkPf5LVTxyOofbTthhd/6y4cIVoVy4vOEdlQRQNXdbnfhTksR0FR0I1vkKpjkFsdB2236jHOZ3FWKfxMSbdcafvFldmV2OaGmwc2imlnH4tBzp5g3f2I0SXcjJkHTJ2jT94rogXTwxvdg=;25:988a5zMgauWLhU/sycWkh7L+NH46Q/2Dcun0eyLlnmWgN/t7+wjB2IH20FTdJ84Q03Eq0xbaugy5w6YHchQjzF9bgFfQ/0e4CsfYHIvCkbBJWaS9jxS9RkVqUb2xvMVt4whMDDefUz8bJlI60RiWqUy5zJVtMxnLweDur2CNp38R99/s4KLr+7Koph92erNl3x6Ir+u0qe1WltmcpVsM90DalEytVvpgK0h0YU6h3dq55YQPcmoN3qaxDbckg14xv/EeSbe3U0mNRICKHKKBWiovdfWla+5mCk7XMd0FplvbzG5iaD7y/6rBx9HZaVO5i0PP1ec2yWtGR8fdMCR2UA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;31:DIBsPz9lZsprlrk61r9FM4F5DjhMFkf9Vn/tEfi3/2AZCAbxd/a5VbuC/EYSD5ixGPJULTWi+SEfE3k8gMLDR0p19fiLmshrEG1J9gOy+AWQTe0AMILjGPb3ing+YytSBx510OTzQmQKb01u6lEh4ub+Shqn5H3V0pBmAgkGl4fX26Qq/cHIoNUGzuoL5oQs6ouK53xsCco5bbtndDqfPzuGKe02knsfnDv80A6sUfE=;20:FFNpHAP/ayxvdkrWq9ol0YhcpvYZgwaYTU2cEFgNPwg9tTKU4kMc3gcakjG/9EpZs8Lb9fN+0hvrdNXll8kxQ1cR6c+JencNh0F7OEGts7ohF0I7UG+4nv/eiuydxbfu1D8FIlrcDbmcjY6yhORP5uurXFRc9Gd/ZBOAG5TIUBSYfcIy0P1qy4SYBpzbyV5xg9uLiUsrWGY94dcrJTofqYgrTQYwmkrtnXb908h7yL4yjbEHl0nL/9kx760C4zaG7l/lpjU+l4hBAsCym2HzZq4A68lI9F6twpVF43iwrLw0yFF6nkJ0fAgnapsBXjPDCqFp/iW3iQ34ZpXKuqtAjnKN0TIrTyaeMCmLWoacl5EnZaIhcoqSD4Mjse5vSUjPo2C2PksuzXTHLtTZXNG1k7nxlwyIMnE7Z2u0Fo8wnANoe11YeQJsxTt4q2OC1T4fjQA1Uc5aWxHg0yccqj/ZgbG5sQKlynX/XqS54pR32dbq2BMGoKPJziqL9M21truJ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB432486E3D02A817A5240C737C1F70@BL0PR02MB4324.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4324;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;4:KMS4b93hSPWwrYxJytBfEKTwQmezaftbL6Ssa9ZCv+r7OpbWWtULe0PAjULI2f2EvW3/g8cCUVfCpJguzSuy+ODRUECGsw5g5oZMyoPF8XSXk7N20vyRrkSznn9ILiIBnvbIP7kG9we5yHscSVHGq7+X2xpo0rJSefC1Ra4cIcP1gQMjrRBl9L1EZUSokdMSBxR+IxF9DdvMGDREuoctBaoriyK66bXuCm1IUn+CKGUtywwKJkf7w6MOLjfhjGZep6TbXP222+iOruHwANQVl4c1I8W2PyfOd375FE5Akwn+wwDb3mRZPhdE9pVEk43FB8Z9eXjIe5oQoclXdRVpKDArCIF8p4j+eB1lwiuArvg=
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4324;23:RMy6ZhWyak02L4lBde4CpkKB89Oi7gc8gR9Gb9XFS?=
 =?us-ascii?Q?COv8mV7H8s+8wKiLSZtjLCvVD4APYShXJZIbOaQHK9yI5QXsGT0PUF5Hp1nN?=
 =?us-ascii?Q?ZhIHieHFYMu8I1NzPxOFIA6bZ5M2IJNk3BZMOM3iHhTpB0Mkt7O9RXpMGjvP?=
 =?us-ascii?Q?yX5f5dwkAuOVFxFgHBWaUUZEkTmxlUyWoAsbaIn6C/7ZyYusLAHwmYsN/kt2?=
 =?us-ascii?Q?aAjJkP4InDogO51eFw22TK5iQGx7F43mHt1+GWLejgYMxfB94tsSq1M0TTAk?=
 =?us-ascii?Q?XpmOnRb4KWQzyenhudy3CssIFBkLQz7dQd6WRVPAiTODDdA813LYzvvvUNay?=
 =?us-ascii?Q?MGam9xl+qN+hYAZ1pys7LUKyiqQgj1zus2DEx1TRLnk6S/RMRZVJ5PLjSEe1?=
 =?us-ascii?Q?pTZIvF0T6atjLfW9C8sUjcteC4v9N+FysB6YuouDGzBJ3TgJ9PoGEsFh+pUW?=
 =?us-ascii?Q?wRYB4iXNK1k3E1tgQ1aK1JjiY/QWvUlxOKZSKUTrQuQ2rx97f9+ajeqAix7c?=
 =?us-ascii?Q?VBqDcThddeRM607R+MnI6n/7+xJfgoMwo21qjEo8kOQEjGijKXxSQ7pXpCeh?=
 =?us-ascii?Q?iYSd5NoI8REHj+sOgw+t04+bX5fOJjVMF8ipNzRtu6/dT9lm/oQh+iAzrea3?=
 =?us-ascii?Q?wGBpCYS5qR5f1Dxcthqif9+VLUz8tGghUaDLcti4hkD+NJxtpE4JsvxFL/yu?=
 =?us-ascii?Q?Qn5HL3lSeXReUdYqyqeDhHVw0Ba1EO7kfKj1PPLEeIhPB7fe596wHbrdjgRV?=
 =?us-ascii?Q?fVpk6G224Gr+LJaoDX+B4yCeVyaY/veHrYwh/y2fzTUAwXj73MbuZ6h5rYnI?=
 =?us-ascii?Q?k0YY80l9uk6gNlaVqSBIVnfIlRYMPZsZLozEv01H5OdWibzmWOfrtraM4CAL?=
 =?us-ascii?Q?bGh85fay+kxf+6HISIcG1JnJqNH83HHGRocXwnbeQADPAB2CjO2PAUXZvPXp?=
 =?us-ascii?Q?vygKIuPc5eICQv5uwEEIlxIx/Gy6uwxJZyrOfwhh+NcksQ7/7cFGRjBAk1Ix?=
 =?us-ascii?Q?ZNt26/Cmdipp8CSK4OgU+SkuyWd9WiVV2DixciOzspkp1G1RVHe6W4V95xo7?=
 =?us-ascii?Q?8M/YBtKZuePviQW3r5GRW8mGISEi5xhjjeFsQ9BFGVN9nEJti1deIYr/cz25?=
 =?us-ascii?Q?dOR9bpfqV7XmQKSS7ZKw9ZhTYaV4AuWHj5sxIog3yyB56aE4bTReb09DEb1d?=
 =?us-ascii?Q?xN4ds2fn0Wm5q2CO79mhyp7f462n6e5EnzKN2wr2eE/a6dRiDnVA6Uruivgx?=
 =?us-ascii?Q?tmrfa/2DouhHTTUJBk=3D?=
X-Microsoft-Antispam-Message-Info: iNtSuHldLzDH0lNgsYvxFr7DhQNJ23vC/MtipkOkDSQN6ECehcWpJmQkQ/0AKY2AdA9joL1kWGRexMChMc0zJUXQh0uLxsjzz7ssVsHXgcLCJv48qnx4/7C6t2/z7OwaUd8RUU3aKFcvgk96/zvTmp+LNnbtnQ3+B/LiZVCnlAEK3DQ/uklyyYOFANItb3whsrRWNVXTCRS8iKY0xAVowzTDdvN5k40VY+BVlFGNNF9Fq/j6ZwtFF+Z0AWqecK9lgySTKop6M81WHmcFu5pY42mpAO/CWgLFRfkFbjg1twRCGoB67WzZ0uo34QToxM8f8SC4W6qsvqEs3Nc+RVsidLyoJn047ajQaTsy1TEuRo4=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;6:tvTF8GGLjev4tjmNt9JuBIUbODsFm7pPuFbXDbBoIsMurGPcvLmAVK0oJLbm8xjhGkit5dI53fuvYZf7SvsSxiGC+Skv6wxjftM1WH5HgvbZ++2zmPUos0ALNIksaHr4A+pDPAYK+1MOboW62Md+fG2qJR89Tt5i7zBBPcCXz7SwApF+DGwaIwB8PFIBggqORp+ZFrXamgt3yjGJ9HUcGIUmdfiXEi2koYfVG9zKo509iX7i2M3HWorLwSyeKQWnyCrLoOZkVIclbYe974FdK59WFi6xaLQyBlKUQ2OGaePd4pNPWG4MQMLwO4M3HAfm7PYJKzfWYmWkp3XdahTLqJWnrXvXQ8fropgIamCGEQJ9ch+VmNAYAwYA/WNuoRlwug3f4atXinvrA5GPLcEFeFtCvNIXm6roXtJxXe06FdLXXxpyz3ao3j0KQgZX99Ykg4BVqTjByDB9H9NjCJ81Dw==;5:sXumQtSecYoRmGLvB87lWUCJMPac9k9I9jYcF0W6oVh1KCBQ7tMt9sWqZPYx5OTDjKRtQJOzPCPpVrPAFbvt3jiYezHDLA3kaWymomvGiNWwapb6t9ZxYa1vWQN7uxXIbzwVuacDtdbNPhooXk9gg4Ojs0Y3pXTw41Ws2JBMKcA=;7:Geiiu52+guEYTNmfyD8J+bGGDKQMnQuFcViiFPsOMXYQwoIe9L9fY4BYtkzt9EooplOzhXANuoHv8oo2nOevjGT5t7N1GS0wwz+ADaeSCA3Pm2CKy5qpubpvzNM9muE35QdLvwtLXzBrFg4aiWETvtt89vLGrD0TnaNbo+K7rYKmJ4EX6okJwVTEyFX9fWrLzZ6vaBhRXI3euKMW4pNhyxDTdZ+DQWIqwKQuZtcxcWaVNzybKqcwIwFO7cIHSMk5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 06:07:38.8601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf832eff-5873-461a-568d-08d63a402afe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
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

