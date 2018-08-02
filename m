Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3ACC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A0D21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RYf5SXRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A0D21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbeHBOn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:43:28 -0400
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:22022
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387406AbeHBOn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSrjBbxZmbIdaxZmw4sBJvFApEDkBHZD2je4KbNmhjQ=;
 b=RYf5SXRIgxEyp7UicMRazNt+1b2HH9X9yl2zL0WCJdsDbhWt2p0iWzRm1CSE6tFTUx9chnmngjC6Yk8VSQAh2V7p0EFv96YMo0CpxIbO1+uIGmN/cKY9c1guDJ1UEI6R/qLw6Q5ugO+yhzMMnuUZRbRW4S+bc+9FfRi+/Iy9kM8=
Received: from BN6PR02CA0035.namprd02.prod.outlook.com (2603:10b6:404:5f::21)
 by BL0PR02MB4323.namprd02.prod.outlook.com (2603:10b6:208:40::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Thu, 2 Aug
 2018 12:52:19 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN6PR02CA0035.outlook.office365.com
 (2603:10b6:404:5f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Thu, 2 Aug 2018 12:52:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 2 Aug 2018 12:52:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flD5Q-00022n-Ud; Thu, 02 Aug 2018 05:52:12 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flD5L-0002XR-Qj; Thu, 02 Aug 2018 05:52:07 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w72CpuCK000736;
        Thu, 2 Aug 2018 05:51:56 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flD5A-0002Vu-2i; Thu, 02 Aug 2018 05:51:56 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 4DABA1213E2; Thu,  2 Aug 2018 18:21:55 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <mdf@kernel.org>, <edgar.iglesias@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        <bharat.kumar.gogada@xilinx.com>, <stefan.krsmanovic@aggios.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys documentation
Date:   Thu, 2 Aug 2018 18:21:20 +0530
Message-ID: <1533214282-9977-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1533214282-9977-1-git-send-email-manish.narani@xilinx.com>
References: <1533214282-9977-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(8676002)(44832011)(50226002)(36386004)(54906003)(356003)(76176011)(305945005)(51416003)(14444005)(42186006)(316002)(110136005)(72206003)(478600001)(2906002)(81166006)(16586007)(26005)(81156014)(50466002)(103686004)(52956003)(2201001)(11346002)(476003)(2616005)(47776003)(446003)(486006)(336012)(8936002)(90966002)(7416002)(63266004)(186003)(6666003)(36756003)(106002)(5660300001)(106466001)(48376002)(107886003)(6266002)(426003)(4326008)(126002)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4323;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT014;1:ql/53PASZHTfV142It95sQcC6kmlBoXcVgrxCjZpxm4Ki1ZljVQ6uTI0EhlNH+DybHLfacCIRsHIhrofBlOieXIg7MicSkE8FO9M0MGGSrA6mitMLK1Jsy9Z3Fe1QqaM
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74d3b3dc-bc52-4985-129e-08d5f876c79a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4323;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;3:lrNfshYL9Qfz5ZyvdDk8rQchVx6/Miw2EnpKVONvHB+bAYSt/I1w5GVkTsBh9VbQRUd29gllHQv+BzY2Y4zQ9SWu9qNTPMq6XhPzfozvdcRjJGs0eb2UNH4rCmCoorr9hjibqU57n4xyQqvgTTANts/DhByFX3VXdjirRVWSI3l88B9kkazW1kmCM505UqdQNWlq8swWQmwTsMTptV80j73bOCOz4h9YtSF9YuzCkV7/YjW4P+oT/BPNQ7GF83heAwK4Sy0s0Bj8nZDvHYUd7PwTb2vlB2wGT1Rhp/TmVg4FIF+vqEixxZqZrCEoms+180AOMeHSTGH6e2EcJKJGOhp4DtydbHQIje7i4FewyOs=;25:qJDYlGF4t0QZnz7OTQBM5fa70eW5uaTHJvNFn1zVIOeUeMnoLl+dWNxehI/WuJhk1jC0ilnTpsx4frF17aaLn7eLkt1Gh/h2r14RAnM4g4UrA+Dw7zBuIlZnkDfn1l9nPdUcTS3a093y1Aph+qfdC+YNKfEryxsYx32KhtRewcCzPaLMat0iWPDJk2Hm2zRWLV9Kb1e//CYODxC0gNylSNC2AqYN77EJiVbpQpRly7726ojLAqpDEr8awxwNJ9/E3A3biye7OiSgYfQP15unMMfHORx8++8yRq2G5boklWBk/Nf2B6PvPj5ahomJrVJwI9MPlhcFXjKrj5HjuChDHA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4323:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;31:uEMtkuMv8vI9WLoblEnZvy1bmdHpe8h2uGVqUZNEvLnyWRAgbWXscSgiv9OZbE86ifwMOe2sYNXGIofKjizxlXbVoeTzmxOnTH7lPAQgVlBfJcZpb6U/nPId8u01ZbYsatJzQ8fzOa7PthfnkfPxhE5GzFV6c3uwIPTZxd8G1Ui/XaR95j1KMDEUbG04wWgd9N7Zuo3aIqRxX7fv32ahA2mjz2pFCBlEfxa0E5Z5dUw=;20:qOJOxHxuQXpxZLE65EgMDtcjJDZCTueWbUU5cJ6G67R76ycGtG5X1CsxAPDJekjGteEoWOSeqdQpoGR9OTDBf9mXhxsqWggVxO/Xg3C76WbSLe66rsmD0OWXURLbhLW5KVgZVxJDzV2dEz+fhYiHtPz0HZXfvdqTS+orsMuYUsRRhOHkeJMr117ooTZfvBJD2z9VC7VzxxTEicZLj/81X80X6Mlaifqpr04NQDHmueFqmZ/V2v6hm1SIYU1nD7CIZZqzJ49yUYjJFPQGqq6NPk+juK+N9En5k5NykueaWzd2yt0NLr/Atj6qeHZVLgAtKb7TUwHKJVjkXnNVkcB+i7FFufCjaEq8KL8aAFK8wDKDjW6tH7TSZgXt21wSxS+ZA3294Ws5owh905k84XQFh9/XIqv2pHcO9CIbDQ2WynK+xTYS5lJTF0ABOLwdTvLKnN6iiCorzEBdsXL6FrNBm1CKB8samuaUhPlTe3uD+U2EbM1/UZaUeeyfJ9CwiB3s
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4323D21C4BC21EC681B5715DC12C0@BL0PR02MB4323.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4323;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4323;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;4:PkDl0hmG4JmelX5CfkqTXsmb0Vdf5ASao/O/Dfb/PE00vstDtbyXuQpdoAa2EbccTWS1BOe94va2D+OJh5U7CuyriIWBhzmpX/wr1ZgGQtlJ5eCmLCM+2bI/zMcwqakdJ24bXP+1Xd0771lvFxZqrLFUOe6M1QGOxNJBcWNsSVQMpbkuyIfpn60QcPzjGfpo4/bX52sAQ8Qod5olf8ySF1YAWTicVUL/HJRHkQrASqtNn/ZxgpvPoDbpojgqIDVMjZ9Npl8NWE+r3UGRN7vm1c7WiEm1KVctxfpDm49ud+R8URoYXMI8m7/Ri5oSRopY6tAoRRavNQ1kue+vKl6sp5PaJhHjWrXbuRkszdn7iGo=
X-Forefront-PRVS: 07521929C1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4323;23:E1vBO0AsLUFclM+RMdEgbO4osq3rwxLc1F3jj75SW?=
 =?us-ascii?Q?fejQEBLk1TpzRnfZIIktAmhyboGr914F3MSbWun3/EtklFhzwjECVJE11yU1?=
 =?us-ascii?Q?H/kkuxQni+3fzK9DCGaeh9iBreIRA9X2BiL4mnfkCzEZ1/nWffhB5cJbFDzC?=
 =?us-ascii?Q?xbm7mcjszeufbyiQmB64sxxvVZeRGYTcvPZaRinVX6o0DKd1Xj8p3b+IgSNI?=
 =?us-ascii?Q?QmUCrdEns6TNF/b0GE7KxnVKLblLKga6crlbfe1RmER9flXWWYQk0dOO/T9a?=
 =?us-ascii?Q?+t6Cp+8l8wtGdQ0LYelmrgp+DtWFE22zw8MQibTj3HtNw4bc5+VRgGabVNxz?=
 =?us-ascii?Q?RidvM4E6yGq5vkNZwGCCxSl3uFfShC/uyqhl6dglvgXjwkc3onGsm9uVlO/2?=
 =?us-ascii?Q?IjQxe5OjjQWoLwVSd1gxz0n3G0inVeOpBNTOYov9vNIzMlCp3aDPJbxfT/Na?=
 =?us-ascii?Q?4FK2A4m6qeXd9Xw2IHvbHi2XYc8k3NRgZvOoqvheWYwzjsv2hqGY7LG06l42?=
 =?us-ascii?Q?IAvNw0NzNkS7Y9nHLNsp2wjC1guYrFegu4sT/h95XPvKTQWcHQ/4tG3KSy4Y?=
 =?us-ascii?Q?zaeLAU34y77PCUs/0ZZ3eVgHO0WrCZMh3ANha8yU3AVLWiZZqDyYek3ID+2/?=
 =?us-ascii?Q?Ri0I/7XTLROF/Y6yJi5SBlJ35OEtYRVJGw4MQ8qtxyrauXeCmxpLuHnE16fD?=
 =?us-ascii?Q?zKCzmmPNa1f5GZ6HBaMdndcpU2/nvDrlUoHWltV6Rb/KikxexFxSNmBrkOdG?=
 =?us-ascii?Q?Yu9PcEZbya388hEqT+7HD1XrTgpsjheuiUixQFivEshUEGV7O9x1KX5/X5AZ?=
 =?us-ascii?Q?MYH1BtWKFitD9im76wsD1ilRUPbPsWLK59SZADwn2bTvZ78sjDb2e3a8JbM4?=
 =?us-ascii?Q?uDCnKVO5vaq0UI32xjIuu9wjwhzIPc/JP4/MYJiwl+HsncUIMjndJBPT7JM6?=
 =?us-ascii?Q?yyCbpwqoIHbHR/i9GKazbCO81ggSBWc+j9hC6XeCdFjKR0g7GgdV9BVJQFWL?=
 =?us-ascii?Q?epXyrqc1XFIuPM8oSTiRzJ9BxGwHRWAGMSgQ/tIn92lvSZayI3bc3JWXNGN5?=
 =?us-ascii?Q?ontodyYc4PotdoqfJz7oUpyCdj5FW6+jXulRMJHY4m6sR8N4XFc1/2A5dbTf?=
 =?us-ascii?Q?jb77rnPoO5HgFQqaqIp/05HEvSERdtGSq7uVP+909D+qAXMQdMwUsViaazrU?=
 =?us-ascii?Q?RsnyN6OozfHO+39Gqq5ixRKsYi9h4mrXDiD1nWRDeezdjID2iObXGiHtpGMv?=
 =?us-ascii?Q?ly6SCqKKuWXtpmrNZOzPgyJrExLc131UZmlPxZVzuHicj5Q0IlKHuu06n2fh?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: lq1uSDmwD7nS0Xe007yb/kutmuY0xDXFGbPvtSjAv3Hh7oEprH2JrBqomb04W88R/xqdZKuWJypnPk3QgXtBriBA92guyDeg1z/T4P4bYzbw1g7RdZPE99AqiJWcrD0G19H+nfguXyTXO2E0STXUoMxcwWuCO+P5EZ1hhKKWYgbOgGqz6mcgfPQrHMHJJ9m3Fd8Dh/v1pFaeK+jIgTM8tjthPUNrYlXZ1w6JdYrytoP404yuQMANA5n4kuPscMncPKurq9Eg7T13a7eDnh+ULAj9ZRz/tgfeleVAqpXiirwzUHKblqGBLbvibgrlvQwbU/ngdl7/dvRkUXjpNNFjup+5+fssCWMvSnogHLwm+4k=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4323;6:3K4cLHyzrUvbO5m65bqLb8Ku38hqYdeaxfpjpqqaj/T4dgr3S+W1SIVOrQCO2Yjb2Q45sNnnIDHzYk6lMmdhauR3HcfTObSrBk+pQ60J4082u7Tg7rD5WbCtQpKXhYz2Zje38snyXuhLcAZ4KiXx/dJQnng5iZCo5KvaADp8E8X8BK3GvnXaZysMr7n3VftrdUcITYjdniA29jB7IvWjtB4Ll1P6KCGmul6TZsmFg9q8F2MUW/biE2dIkTxsfvj1Vuwvaw0vtcLXip6J0NzleQij02dL2x0ej7c6rD19gLaObZ1tE3lNKXzpnlHLKmp+iGBP/VNNx4L9fqbsh88M4Wp2qHxElttmgrHCsP3jtp3QuOyjP8bBBbwopMsnWbs0u1ezIl04hCnzKsIidltk0R9gGunxhrSwVzOKO7rOWKwA/cqmqtRfu+aoSWLX7hxXZ3Nilwr4WcrfspSpGKB2iw==;5:yrK0CHvEp9r5F0S9uupBhWfFdu1aXcuDr85QN43W6HPLvb5cudGZUUx9HzAe+WWEOLtOZzYHC+IB0k5wKc/U46byyfEJSFR/z11WPFNFIOYzLd0gYd3osH/4WD3r0a0ppKzxfrtBhwKYbFJ9grhWra5MxHH9Px696L7RJwW9dd0=;7:kjOeW/u7XrB7oNlvkFDNPjyCZzmbh09+JJk7uqbFOspNi1NIm8mz3rbMvDay9YJ4zEvYKS4j1Z+THv452xJlPfnAZF0iXwc25S3ydnOqK0gvZTnsJfI1KBBBVh911+hc0TmNphyQNzK25JG1y8GLGACcrZyFJzEaCdjDep8fSApefAqmUBboq/B1aXpi28Waj2Wv9vr9UDzkm6nFIhrrbjTumDOPMHKgrr/5MYUUfXcTsTwutu4S9RmearL7NN1Z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 12:52:13.7322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d3b3dc-bc52-4985-129e-08d5f876c79a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds information of ZynqMP DDRC which reports the single bit
errors that are corrected and the double bit errors that are detected.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
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

