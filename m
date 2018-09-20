Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76B0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDA121525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="z4PKu+ux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDA121525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbeITPOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:14:08 -0400
Received: from mail-eopbgr690054.outbound.protection.outlook.com ([40.107.69.54]:61120
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729095AbeITPN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRYORuYtkErMNwzoyadgD+Zogugzel2v4Gz9LkllaEk=;
 b=z4PKu+uxLFiP2kVYV0MYS6pYezIhPpHRC2iObj0k4Q5qudobR+g/d2EG4pBfh62h6Vy/Baf/7NWivYzDPbssTM0sHMQdZMlwNGFO78pPc9yNcEgWmVwTQMl58h7IMeFlAUyA7RdGmN+QpthAb27dzHNWGsMfLcQ/g/joO8e6Jqo=
Received: from MWHPR02CA0040.namprd02.prod.outlook.com (2603:10b6:301:60::29)
 by DM6PR02MB4761.namprd02.prod.outlook.com (2603:10b6:5:18::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Thu, 20 Sep
 2018 09:31:19 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by MWHPR02CA0040.outlook.office365.com
 (2603:10b6:301:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Thu, 20 Sep 2018 09:31:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Thu, 20 Sep 2018 09:31:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2vIs-00015W-65; Thu, 20 Sep 2018 02:31:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2vIn-0007oX-2g; Thu, 20 Sep 2018 02:31:13 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8K9UxOA013095;
        Thu, 20 Sep 2018 02:30:59 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g2vIZ-0007cD-BR; Thu, 20 Sep 2018 02:30:59 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 7CEDE12167E; Thu, 20 Sep 2018 15:00:58 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <adrian.hunter@intel.com>, <manish.narani@xilinx.com>,
        <amit.kucheria@linaro.org>, <sudeep.holla@arm.com>,
        <leoyang.li@nxp.com>, <jollys@xilinx.com>, <rajanv@xilinx.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH v2 1/4] dt: bindings: Add SD tap value properties details for 'xlnx,zynqmp-8.9a'
Date:   Thu, 20 Sep 2018 15:00:42 +0530
Message-ID: <1537435845-6682-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
References: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(438002)(199004)(189003)(2906002)(316002)(2201001)(54906003)(7416002)(81166006)(16586007)(81156014)(42186006)(110136005)(356003)(52956003)(2616005)(11346002)(5660300001)(476003)(446003)(217873002)(51416003)(90966002)(478600001)(8936002)(26005)(47776003)(76176011)(4326008)(305945005)(6266002)(103686004)(72206003)(50226002)(36756003)(106002)(8676002)(50466002)(186003)(63266004)(6636002)(6666003)(426003)(336012)(486006)(126002)(106466001)(36386004)(48376002)(44832011)(107986001)(921003)(142933001)(2101003)(83996005)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4761;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT062;1:icCQaOQfDXD7xVuesapodfx0G3Kn2Jdle+6XC1IXlIrm1m2REgxjQ9Ycj5mJoGTWbQ4lRwIRRKR/tQ2toEELWdwSN7YrP1Qlzu/EZrKetJk7H8HideUqvY+Z+PKAYY5V
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c742191-094b-4b98-39a0-08d61edbd215
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4761;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4761;3:l3Ujd/H9ewSrOvwbywzzm2Yv98jjRcM57zNrLbl/5zO5iYyjD7pwK7Z8psyUVBYdBQjFbXOFLyUprVZwW7JZXaU8fLNn21lrQdeWZC2Rw28IzWINJ8NV1NuDMDC0kqHhD7dq8HnksCrT6qi8FU9wNdDSO0p1YMUwI6svZBjK7yMzn7ORH7D6NybzoACtRQE6Oy0/wKTny6MBbuX9ppXpY+TTFFe7LP3RgMn55TcFhM/sOUGxXuxqdvGCCRR5EAc/f94KOk0EEqG0THHHJdelzU5RLG/JM6KQEwVnRuQwWlDdqNKd2NJzy7FtzV7Ib2bOykmepPB5lLMrEZ/bO/O4VpKJFdzuT2xlEU6Pu2X2w4M=;25:RUUMLsgrHyCPd+YNm2hikv+DgkuD78YDghVqqfes8xDtFhMWuI9oKE92LhO+LIs/1siY6+F2ciFHJ6XhWY2njlMjIH+pdRdScyK4yJa04uEommfzE3WYp40cc69rrpGvQveXX0kbyTIgMwY+rVx63hE7UsL4AVTlo0lJejUsgispFrtltThBopUK1ltzKbcLH7BSprmi/8UqJtfOWIoUCELvti1zaw6CZHCE7qwzIcuDO4farguC+aA61ESWazCFe/Lq872cqPU/SmFhbWA8xpoMJkNVbpRU1e3QCIwZC41IoqxDFTv4pvCgRpsJ5fT4tQeXASZEMPiQHAe0m2hQaQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4761:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4761;31:/lNKFzFYMTkTw4qniJgtTan+f70qTul6FzLug5Yy9LII6NGMUNkI02FdXX9RIVQAE2vDwRZjNVDU0DbQ4yjIfb9+xY325s9txY9QEmfo1tp2g7WhaUUtCI3uFj8zHUCt5NfFzbHlFErte1PTsL9WDJ1b4qmC9D4FEc8HaQgTG4kRMFDK4kHaHuSDnRT3djoYD90+lTN9wNfCYudSsH8NAb2h8RWwMAfQCyp/m9MF0sA=;20:+LfB6pDG8HOScorz0RtKfku/nEAT1jrltgk5Yjmx8qf/HpJIDBetSSxMdmQcgROepTO905a1Xl244TxBWeR3nCIQWBJ6phKap2Ptuvjky/SQCEYu17bKCX5mrbdwHq2R3HKTL88prYDAG65ev0P7X5Td+Ftk5nM4sNjfu49Dq6CjCbqgEExBWGRu82Tdh7qNwAHizbdxRaeu7BzQ8H2ZVbUJ0PWw4R/JJAdnYA/FwOIW35MebjasaSaJMV+kNKzeXVz8BDYkZyVsaWIt4Ftaa1EotoHtGM9nAUM+/NLiLYyDio3LKlK/Obgq3ZCnxsBduPaxbY9cjt379WgsVIswzFldMTvYtNHckmFg1gxCO/9qFXbYjigD/2TtoDyPUNWjAfPJssH7Kd4Z44Shd/gUAUQnYGDs5avczUg3IysyfRpZuCzZFDAJvX1zdSc9lKCz7H4aBcJHA4+rkXJ8/+Kh74YAj9+wCqpTV0T0OiURY/BtxOYbSwbpi8a8r9EbluCr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4761F3F743714C31E64FD94BC1130@DM6PR02MB4761.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:DM6PR02MB4761;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4761;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4761;4:TBZe76Z0f/wzYeq3zbVRInO+94O811I57IgtQlfWlcZcpfIAY8avy2H38NJ5wuddPM6hz6RNIiQXVjQSxnRIqqf6KY8tzV6MiOvZekXSZS8mG49dm4v5mSMdkWludOEobjew1wx0knfM7Noeaj2Uy2wGtkeLHHNc3DkIlZr7rELj0hXwpVvBu9UGFrVSCLsFkNWJfDgtirr8sl8CX0Mux4i4DBI2HRRf1gip0BZ/wdVubclUs8wf9kx/gDOHTjLnXte0uT0lnA4KR7YDez42qULI+kR/Q7Y4oE+RMR78LJjrU5pJdynx0qavqd8qcgJIWm2kA3LG3VdmUTqPe9cfDCa/7wXQ5FDmuffhyPg6cY7IOsj6DgDnKmn9j/1NWSTE
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4761;23:mDvwABCUgE3FRDCkOE9aqbznMij0j3L90lOzw8HLl?=
 =?us-ascii?Q?nOUooX/zdwPog9StnDJxmTK/JccITGzachfSHB0VnMUrhQKyMhI2pIrTZ6sV?=
 =?us-ascii?Q?U2pHnfcioC1X4nI7nDiWMDnojZF5fu0X2VnwYp5Z3SIqB83GsE/FhCYp8YeV?=
 =?us-ascii?Q?mJhn7dc7KdJY4YEketuJFgTScTGy4dHZ1dZ3MHKKMAxcyNl8Djiw1W3epmQO?=
 =?us-ascii?Q?HA07JSZqymSyvTYLO2hy/lICzpwK+1g8fUh5JuwAeB/OJXnX8TP2j9l3mwYw?=
 =?us-ascii?Q?3d6oar+7qjF0KqT4aDo3Ym2+1jjxrXYUMNoKClhSus9X7xHb9T7Bq13beFpM?=
 =?us-ascii?Q?5N86xR0DIGZQX1zGRVEj2+a8nuFXO/CPvwX9X469r3DwWd0YtlAIe8wIKn7a?=
 =?us-ascii?Q?XvMUIRuCmspYU/4kBgnLAE4kAymHBEPdXOgX3JoUp1ZwV1oLbpmSyEvHwVac?=
 =?us-ascii?Q?oN21VdP9K8XDe+Bqhp1SjQUBM0HPxmZkr/kAVv6aI4HC8SQuHQS4Qy/36Kvg?=
 =?us-ascii?Q?y/EgrFXCEEQ0W0q9tIq8IZf1hgfZxwqTnhW0eI+/rziD39Id0+0TPA9Htc1r?=
 =?us-ascii?Q?zNYYxU0nNbUUqGY6H8sdDJjb2Dh4kuRsgDNS9u9Qbjrks65gvZoxshDpbsvD?=
 =?us-ascii?Q?ADinH93vEcajDF3KBEqDDkhwW77DGxnKSUIwlKf5ytPtiT0jyJrQ3c+Eodx0?=
 =?us-ascii?Q?LEbE2d2LvsVPpb5oluZ8pFZSp8UtNOzQ4ADazfcYxLsvvuzC/8n9laNFNiiG?=
 =?us-ascii?Q?F7wO0zRypoZ7atNAHryqHyhwf6E4rk9TKa0VxmBY9PoUG5JA7B5jFrdg8+fe?=
 =?us-ascii?Q?koEWVIEAo2lb8AQfBOSUFM/AiOG9L2JDL0tuDGuMYVIv+jHl9sx0Hj2P1Mue?=
 =?us-ascii?Q?v8vngaqOt3nVrBFFvznSnXnPCFrPFyJcdk8whVnhGYOqD0NgSk5hy5tuakjc?=
 =?us-ascii?Q?SQWTebJcy3TBmVOkot2m/QUE8t23HwP8Dik92RzGBiNQZRcv75GH+TEGPg6e?=
 =?us-ascii?Q?wXNcUz1NedYq4Cbt1ky9NxzbMZ4G7dRxWdJs14j6xUfE13mNUEuOxGOp+67s?=
 =?us-ascii?Q?DxlN59JPqBCdOamFMI9qpKyM7oTLpNVyzdtCLE6qOPG1ZiwR83FRpv4Xle/R?=
 =?us-ascii?Q?+8vNoWABzYFTEJV508HLNTaH7kuVZfMMthbiriDWWSP/2uMZQN9nXHHEscu1?=
 =?us-ascii?Q?RbAY52z/YI+TbRVPQ6nLJ07BWYIp6bvwsEw+Fuz6RSYXZ2RAB/MEqZ3081f+?=
 =?us-ascii?Q?c2kPGuWMPEOzixUpxUHjTLmXP6Vi2PQsWzrQwXqyqFu0Coba8veXjIqix9Xv?=
 =?us-ascii?Q?bZXZOZ6AnjCJnO8e1twbFfJWMiIJA3gh0kioSgMT0137DSDzI+xpjAOpEGR4?=
 =?us-ascii?Q?loHGQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 3A1CooeFe6G44Af7pgzxT8MJciYj5TRT2BGefqXel8z/VfzqF1eqSFKcnYuLKlyUL0jbwrK8o6RYIj7+1erhjT4iaFS3agMymsnFi8INbG2g3tDFqId6HnSBO0/MmKd6s2/57mt5wmbD6SfXS7+6Sy2rISkBJspbjsTB5yiqaIaQwXCTJ+ZXY3kXwFg1XuVZTOsGuCeQ0d0CKMDMAWM3hYOmiNrEHiz8oiZZbw+LWNobsHW0FqMCSiji1E7GhlPxblmCCkYp8N0qxK1UXFdou89ew2d04YjiX2RwX9foslyQJP/qyZ+qlXtPtUyyQHX9/j4YU6bKz6oRKGNC90oxsPPsxMVMIeOmFmbLe+Eb3oY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4761;6:7Wv70FF2T0qNWj6ljzmAswi4HhAc9CdepZFyzag4AruPi/Vf+CnLdZrWeGFaH5hcaoBbLQozh2rqZYLQwvkBmhj/I5toh5O639PBbOUMaUUAD68CENifRdycW8cmc53mz29UXIQP+7FZmdpKsTlRh0E5SPMJlkO7Hwi7LaMmAxhMui/h/2EkBgJhMu9X75YsijDsoMIrhqCElbbnUeduCImzRMZg88gwMyjeoPFK2Znezi1jV+Cjc+yez3VYIrVxvp1NY+LSdIXdDT2Kio0kE+B1mOJ/m7cTM9WiE9UuFolb87JuYqwAekUkDUbuqRISVWZljdx1QBub12aXZVjmrUOjMHjEjmxH3ppyHXg2MX7Wcf7c3KBvkbds/RKMG9tMJl6zmxytYMzSKMGD1cgaDU1b0tm3P6cz1uTyszg3ZYm+2NbI9uWtDwUUH78qHWD2m+eGPW7LnwUvRsAg59y38g==;5:MWg84NZlGAzTjRqesoBq8gp1ymYhjIK0yO7onmh/gPdwqPJd7TcM0ar8mxgNdixOcMXpbvev6xfc95Mp7Ua2289Oc761S1xBffoxnJ2YacZk56cNdfueBERf/c/8cCy6z42RNoT4+EmFDq5Jvc04zQiQuV+vpsKE6IYCoUHUZkI=;7:mvRTTViLq5zL1TmJZZCQIgyHLTV8V6i3AhrJw+f9Jrvne+lMQ9RZlMggcZkWvY1iI4G1SRI6hw/pccI7vk1zmOMNuBdcUSd9xP9WYxzABBTBA53F0g1sporuIP/sGqyrvfmgsgQNq/SRKH6LaIU8CSCzEdC8nnnu8z4E3pBfw2DVJISYb5rbYbsZk6Y/LA5ZPMZzt5gh/C7pb10XE1GIR9ibb880tQcYkmqtZ3yw49kGGelBx+LwI66KeprH53zs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 09:31:18.6406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c742191-094b-4b98-39a0-08d61edbd215
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4761
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for MIO bank required property and Tap Delays optional
properties in devicetree bindings.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt          | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 72769e0..6cc95fa 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -27,6 +27,7 @@ Required Properties for "arasan,sdhci-5.1":
 
 Required Properties for "xlnx,zynqmp-8.9a":
   - xlnx,device_id: SD controller device ID. Must be either <0> or <1>.
+  - xlnx,mio-bank: The value will be 0/1/2 depending on MIO bank selection.
 
 Optional Properties:
   - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
@@ -44,6 +45,24 @@ Optional Properties:
   - xlnx,int-clock-stable-broken: when present, the controller always reports
     that the internal clock is stable even when it is not.
 
+Optional Properties for "xlnx,zynqmp-8.9a":
+ - xlnx,itap-delay-sd-hsd: Input Tap Delay for SD HS.
+ - xlnx,itap-delay-sdr25: Input Tap Delay for SDR25.
+ - xlnx,itap-delay-sdr50: Input Tap Delay for SDR50.
+ - xlnx,itap-delay-sdr104: Input Tap Delay for SDR104.
+ - xlnx,itap-delay-sd-ddr50: Input Tap Delay for SD DDR50.
+ - xlnx,itap-delay-mmc-hsd: Input Tap Delay for MMC HS.
+ - xlnx,itap-delay-mmc-ddr52: Input Tap Delay for MMC DDR52.
+ - xlnx,itap-delay-mmc-hs200: Input Tap Delay for MMC HS200.
+ - xlnx,otap-delay-sd-hsd: Output Tap Delay for SD HS.
+ - xlnx,otap-delay-sdr25: Output Tap Delay for SDR25.
+ - xlnx,otap-delay-sdr50: Output Tap Delay for SDR50.
+ - xlnx,otap-delay-sdr104: Output Tap Delay for SDR104.
+ - xlnx,otap-delay-sd-ddr50: Output Tap Delay for DDR50.
+ - xlnx,otap-delay-mmc-hsd: Output Tap Delay for MMC HS.
+ - xlnx,otap-delay-mmc-ddr52: Output Tap Delay for MMC DDR52.
+ - xlnx,otap-delay-mmc-hs200: Output Tap Delay for MMC HS200.
+
 Example:
 	sdhci@e0100000 {
 		compatible = "arasan,sdhci-8.9a";
-- 
2.1.1

