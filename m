Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D398C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17EA720843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 11:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fdXJzKak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EA720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeGYNDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:03:19 -0400
Received: from mail-eopbgr700089.outbound.protection.outlook.com ([40.107.70.89]:20992
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728681AbeGYNDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1HYbFZf06wbl4+n380/yM5FFp4PZV1jNF/qtqHzlI0=;
 b=fdXJzKakw1c8cUPBF81h4YfGASsYf8YReJDPMaP/Y2yfCRpYdyn9Cepf7pcA3D0wzMuWfdX2bJPPIX5wfnx+cLMNVgNakMDBZAn0HEVcj8WJJOM+wLq6qbRJWTo7XdQKIVNo00CUGCgWpn20WhxB4cCaJgb/sn6cVR1cqVrGL7w=
Received: from DM6PR02CA0027.namprd02.prod.outlook.com (2603:10b6:5:1c::40) by
 BY2PR02MB089.namprd02.prod.outlook.com (2a01:111:e400:2c1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.973.21; Wed, 25
 Jul 2018 11:51:49 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by DM6PR02CA0027.outlook.office365.com
 (2603:10b6:5:1c::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 25 Jul 2018 11:51:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Wed, 25 Jul 2018 11:51:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43621 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKX-0004Q2-0j; Wed, 25 Jul 2018 04:51:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fiIKR-0006Z7-TQ; Wed, 25 Jul 2018 04:51:39 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6PBpa2P027042;
        Wed, 25 Jul 2018 04:51:36 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fiIKO-0006Ye-5h; Wed, 25 Jul 2018 04:51:36 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 50E7460504; Wed, 25 Jul 2018 17:21:35 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH 1/8] usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
Date:   Wed, 25 Jul 2018 17:21:24 +0530
Message-ID: <1532519491-19502-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1532519491-19502-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(346002)(2980300002)(438002)(189003)(199004)(51416003)(36756003)(50226002)(50466002)(76176011)(47776003)(446003)(81166006)(103686004)(6666003)(8936002)(336012)(11346002)(81156014)(305945005)(356003)(426003)(476003)(186003)(126002)(2616005)(107886003)(6266002)(36386004)(15760500003)(54906003)(90966002)(106466001)(63266004)(8676002)(26005)(106002)(478600001)(5660300001)(486006)(316002)(52956003)(110136005)(42186006)(4326008)(2906002)(16586007)(39060400002)(48376002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB089;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT018;1:kewXQp9Hfc+urMiCVgUzOB+6icLUOMJTvUlae1+YCpLAUvLyoBRKZK2ZJ4pMHkoOaYIZIdQqtuA9USVWLmbDOPwUPVyP689QodQMEwRQoT9P+RNV1R3COcoTylSaex+p
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95be1d91-dbfd-4fcf-4a1e-08d5f225007c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR02MB089;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB089;3:X02zkmVh3auZC2ifs1DrsH3ybjhWsjnNSxs2CXGpqc4Zf3QIFdDDbp8I9V3XOonck5WC2Xj3kyLTGfGfuJPih/UlFN7HOt4aa4RYd6R/brk+HMBeVoADgY2vB5UriSdDqaYfyafjIRRi8deUIxDPtQv26GrsPW+F6NoHzPOzgnvzDMZK3f6o1ewWMceadDTz6VxV+05a/8l/jKynQyqqKXxLw2L0wMUG8hX7iuTjY5+wbuxrDv+aNo7HHD+eU52WUBdi2jIiD4fTJ0da3CFcUNuFTq1TqScE3QjamimMxzIjntbgH7LEBQO79Og15pfpt5VFKrpni3wy/RQNbLUFQ406CzwRvNh103om1fcTq+k=;25:RAXaC28PPBzAUSGne4wh2s5717axjk85QKdmN6NXzemtXz7YGxqV08du/G2dCUHEFaNaUwtqsoGIrePqlRfTr0uc3t8vJhmrAkYYTyTt3zBhym4DXEAn+Tk3xSY3kfW8BNwu85GzLDWBXEWV/F/PnBOhHd0ctc/UYmXuKUFA8haYxglb6yF0y9oExCD8UhMk4JPUOxoOZD3m5p+HmNDuUHlfuoNy98nXTW0LKtpyOHn4X7jg1wF1kk4YqHHBRWnFWSt1aWALhaBX6wTIGxrnwqGPTzZmEk0AEfulkhFza/nC7IxrEswr2gQipnEuOpQhCW6u/acsJryHdEnju1zPEEGCsyQBPgWqy/yQldrrGlo=
X-MS-TrafficTypeDiagnostic: BY2PR02MB089:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB089;31:xg03r+lzHFwlU00ZU9eS+eM2nq2mGKaradQcmiR0EKbjT/0lPfpy2aHVrMV0C2Lm6iI7DM+jmYgM/IDq+bKVHuNnmG7VJbTmsdKBqgUSms5oFRPlAGRoZ2j9niT5AyF4GERo+IMwQzXy+uwJFEi2w7vsGigDv50OVkXEbHqv7vTxKhipxCh1GhW8RZoWz5Ve3s9OCvn//siSZe/PTMuTLSWBmH9QiKo4X+DAwZ/WtS0=;20:p5/Ib0OMidALpmH5vkVb/JL1zNoIomG3BDYW6c0zGIYU8X+08DWtAtRVc7tn5BLKcnmbll8qxh5bwp5Pt/npngQW2bvCZNYWVOy5ecoPTCt56o9eGXiyWL76oYWqJoP3BXp/rRMY7wU4zIwcIW9wxzybsUALanAeBUmG9P7kNf01myp/OnL9d79epAJ8Ga4bDUKAJ/AgJV5tFpw3QekMDjvkA6/2FuBwz3ZK+S3lB0+VFiwbabfd7PLVSs43J9U87X2pVS2rJWcFWcLO+me3DdsfzWZlkvUKQ7qLo9Bb9d++0kAafPDAZpeIqixSHGybMZ6I9mb0/XdEXPccEN+zCUL5e/yXCpNuNVxQuOWMKnnNPPLOPI6S0C1MQWNhOmB5iewWGCXjYgFzX8vrfdfQy/wo1lFwOHn04NLofzDjzMFgm7urnnMZnHbr9KrbfP7V1WByczFEqPIomKGI7cxNO9QujQ78rmLUu6FmVndV8EE6cLgOWvmu/Kq6FVk8Yw9f
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB089CA7EDDC4CED4F19DE390A7540@BY2PR02MB089.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB089;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB089;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB089;4:O82+pP0NaxavoXWpMLwn6MV31T4d/0SSPZlZixqCpWSGvl7GM85aFp5izLbhjDHzGS7UWniJ8zkbjgP/N1nhnWGUYlWivF/cCS2X6vYS03DJO0RD2jUFOoOUkjLmaEd8Pq9h200FPYY7KrvnY2wyuJz+hyrMMsaqUP2FFiRxL3MAF8hs8mnpfbtXKK7jZHWaGhqhrSjr8sLFjPLtQ87k550XhwMqkyI9DTfnijUZAU3AbJPAaB7cf1g6KGU8ne4ivP/6hEiBf3988rxn3Wy89RXu2lXL1m4ylXRjJkkaeQ3y5TwPlbj2Z1WKuMBA538Q
X-Forefront-PRVS: 0744CFB5E8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB089;23:HNSfxOodrpPNg7UCvg2y8NTDUZoZTKd+YfzYCXNyNd?=
 =?us-ascii?Q?+liKkd5dl/CvqdwsjSPgKpL2Vpf5XpnwN+ZJgndidCfANZ1ASOvomsDvOa5X?=
 =?us-ascii?Q?TIWyCAv4QXQDo5S689h14KHRvPTS7SqZa6cLHCch10WWTQP25Tj0um0vYD6j?=
 =?us-ascii?Q?BjFUiKxIVTYsvg5K2Jo0JW5TqgqShppbhlEo6P3TPCwcc+IdBrYiFusJXQDX?=
 =?us-ascii?Q?BEqpJ668VTSlvh4xXNdAEUOMdjIDqnmuJ+WYZY53gF9Fjrxoo/Jg/Q2z7AVI?=
 =?us-ascii?Q?wM6ZQOOCXYY5ivUBfkpiJfnJV/+cAgb9CiutI4c1XugrlX00l7iLldqujr9l?=
 =?us-ascii?Q?7Dty9qZ5VG2B88jG9j3jtS6PXnAuEgaLuAaqtrDmD0QswBMuUMcyI0wx04SK?=
 =?us-ascii?Q?Zvf4rBtJMUEPBz2tUADcBigO0qiAuBIq9mn51zkyEjReTgP8WB0uJGdFaYPA?=
 =?us-ascii?Q?wSy+v0Kga7F0m4G6o/vkO5ITvXO898Fwu2QtCuvtDXd0f+AuVBaHPa84sE0L?=
 =?us-ascii?Q?761IvxMIHuveDw+ooaVLrox4DTXRroNZs9/yZYep0RY7gRNrnhCWAsd7uxYS?=
 =?us-ascii?Q?q2Ibaws/AqIPgn1vQnZ7IMHQ1o1OGdrdh0xmPKZoLYmVDep91X+uO59K5Jka?=
 =?us-ascii?Q?tbcf9VEkIWTQNQpdWTex48hX4nz9Yw8nF3qanwsKHyrSNQxY1YRjpwy94geY?=
 =?us-ascii?Q?FQ0kiIVO15NKOGmcXr34JqK/xKJ+T3viGsDwu5+lV6whp2HT/7ny+xqyKImz?=
 =?us-ascii?Q?0yBVoiplpvnUhFQk0H+RLzEEyReVdqXpHYnFLB9rkNWfM/K93n+fRdbQD5Y0?=
 =?us-ascii?Q?t9YqaNwTPuF5U8OtQODjV66xwjY1bNPDbcje4vrgMgOy4bEw81/1+ZTXYF5o?=
 =?us-ascii?Q?4g7CRDOjZou7MvWOF3OihJvTE9tdIJMooctuSYEemUUbmk1/b/I7C9AIlsUp?=
 =?us-ascii?Q?fm6zDCo5zZjiP1QaBm5HRH//SNg7m+FW9Lol0ADS9+m72YPTUBAWBjrwyv2e?=
 =?us-ascii?Q?QB5MyiGKMHQ4NmVMlHOkJKedUHbhDPRmrXaCQ5U6BkhMqaJVkTXiobdXde+g?=
 =?us-ascii?Q?PJe2Cdf8RmbizGXe7lctmM4oVKLifOh7U7iT2t80Xqgkr4rgtCV76gfMW3mo?=
 =?us-ascii?Q?Mq/+3UxLelrkhbajcCkfztciQyIO0oSUehPRUSrn2oHvq8FmihX2x+sqvbM1?=
 =?us-ascii?Q?kTVTl3og4SMCVVdGinW3dYxRVw3mc0XqYY23pPdOsv8Fhi2W9JjoUZkA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: pUzIX5rN91CNfgLbecwsvX6vI+bEposIYwSh0E7gzzINwmL5MsrstwduW4LJm31ryfm+mR4jBkn2sAGB7J4JgwWYFo/3FopKa6wIXs0ZtEXs26LGT7/4y2tuBUN3IEIR39rcpycMCcwcLetGH845zb2pjZKFF5UIjrYkQmCEcwA/cKj60oETfwU/pGOkedPiwpfquLwNFAb16LowLonuhJD0k0QG3S90SKO2b8ctJB2kAsUFPd2fNdaiuJKMtbkapKfghy09G4dnqOlEVPs/DB2IjnW36OU0S/YgItmLZBGuj1Lb+NVBz/B7LixP8oVJx0vT3cqxpn/Ukiq/oZCfPkZgaAYpNlIuaG1CdhQah0M=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB089;6:11sRUexwtLEXHLfmgL44i+ylKgCmBT19ZiJhui+Yo+MkUKkuvJc+RVjfpAZikVxQCPi3yeSLvUezPUsL3zJLp0WcGPaJLoV3tZPFn0YSvNndY1I6ctN++YlwjcnOYO8f9ugcTestitrBmnYgETDD0IcUapE9zcyY0zZCvqASHRfHlFYQPmF7PzFnDb4LnUyItdufE/xzXCpRYF8MrKLkvJWw9tYaGYmdHW3NZtGMXmIvHEuskBaaM98cYNLvr8ojLTw6Bgg82uAXlx9F6L2oaQE3KlcssRBewfhUfI1kiJ9VyVKdw7nqKa1unE33mhScg4FgoYWIdD7YNM3SWlGp8lzFMj2PuPoUo5QH4k98uFksj2juEl6PpQgVWTcua/m5rL8c8+HsGUXwQaa09ZqXt3o+tx3i8h1OimR8XEQ2lhMHHqjQAzPQZFGTHdCwIwhrPo2N7MmV4JatQFIbMDyTeA==;5:pmphov5VMeXIbh7baKs5cEgxXrhzotmgZN4Ui2xILrR8bbQ7/wKlS84GRqrbgEBrhyp+3Gn0+881aBdQgy4+6Q7PREkf8cCx22uEwNayBVjtKO1tPSFO7fkE0o7K7kbGJEOE6AB12aeRZlw+9+gjVvEx7s40897SYDD3VHq4AyU=;7:Pej50ntQuhAKZhoST321ubJE3/r7hNedzIjzqcelWDYOPH1YEi8AOTB7wv1M35ZxUbtEXUtAIku/O4LEXcc1lhHOTOupQw6f+s+ykzQfIzHUgiUARrYx1ho6TBJ/TDqhvbYnQTte4RSdQ3NJT6OIAjmDB2MfHqAcYb7tp8pAbbSrN2JjfEEdaShMLSqMHH565nvBql+/mD40ndnYADKT47s2BAP4rSzzuXUy0/bhOEMW+AB/M9pKm3U865t+y4t7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2018 11:51:45.9274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95be1d91-dbfd-4fcf-4a1e-08d5f225007c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __dwc3_prepare_one_trb(), IOC bit is set if the total number of
available TRB's are zero. The number of available TRBs are calculated
using dwc3_calc_trbs_left(), which determines TRBs full or not based
on HWO bit set in the TRB.
During preparation of TRB __dwc3_prepare_one_trb() is always called
with a TRB which doesn't have HWO bit set. __dwc3_prepare_one_trb()
depends on dwc3_calc_trbs_left() to calculate the free available TRBs
and set IOC bit if not available. Since dwc3_calc_trbs_left()
determines TRB available based on HWO bit, there are chances that
dwc3_calc_trbs_left() wrongly calculates the present working TRB as
free TRB (since HWO bit is not yet set).
This patch corrects this issue by setting HWO bit before calling
dwc3_calc_trbs_left().

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/dwc3/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 69bf137..f73d219 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -990,6 +990,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 	}
 
+	trb->ctrl |= DWC3_TRB_CTRL_HWO;
+
 	if ((!no_interrupt && !chain) ||
 			(dwc3_calc_trbs_left(dep) == 0))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
@@ -1000,8 +1002,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
-	trb->ctrl |= DWC3_TRB_CTRL_HWO;
-
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-- 
2.1.1

