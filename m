Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F45EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEC5216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JuYCHrlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEC5216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbeKLPXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:23:51 -0500
Received: from mail-sn1nam02on0087.outbound.protection.outlook.com ([104.47.36.87]:43671
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727243AbeKLPXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si7r9IPs+b9ppnK7NZiu2sONYcqcnOQKd5E4+ZSb7M4=;
 b=JuYCHrlFNhPa5fyUYJYzkSD3fJZ0RVy1xAVlcfq1OwXwtTj2/allEqkgkfwItW1Aom6T9dcMCEve1g1BXBr9uXc+DlgiNFK4uspbau5a2mgyaHNQx93KSTRAB/vTRY1CeLCunAMaYnPErCoXe+tqqMAXhAIQvwscYgdCNsp8zrY=
Received: from SN1PR12CA0093.namprd12.prod.outlook.com (2603:10b6:802:21::28)
 by CY1PR12MB0425.namprd12.prod.outlook.com (2a01:111:e400:5192::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Mon, 12 Nov
 2018 05:32:08 +0000
Received: from CO1NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::208) by SN1PR12CA0093.outlook.office365.com
 (2603:10b6:802:21::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Mon, 12 Nov 2018 05:32:07 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT041.mail.protection.outlook.com (10.152.81.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Mon, 12 Nov 2018 05:32:07 +0000
Received: from LinuxHost.amd.com (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Sun, 11 Nov 2018
 23:32:05 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC:     <vijendar.mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Subject: [PATCH 04/11] ASoC: amd: add ACP3x PCM platform driver
Date:   Mon, 12 Nov 2018 11:04:55 +0530
Message-ID: <1542000903-19020-5-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(2980300002)(428003)(199004)(189003)(105586002)(54906003)(39060400002)(109986005)(77096007)(426003)(316002)(4326008)(16586007)(53936002)(86362001)(50226002)(336012)(81166006)(81156014)(8936002)(106466001)(104016004)(51416003)(26005)(7696005)(8676002)(186003)(76176011)(53416004)(36756003)(97736004)(47776003)(5660300001)(478600001)(72206003)(2906002)(19627235002)(356004)(68736007)(6666004)(14444005)(48376002)(476003)(126002)(2616005)(50466002)(1671002)(305945005)(486006)(446003)(11346002)(266003)(2004002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0425;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT041;1:FOh76GAVZfIMforRPBjvDmPMW1T3TsXnuz3ZxAygNvvgzc87Lnj9oRwA6v+CDfQoLyc2FfXdi+gJP0cDEbqThOpBEMD9vyJI8EtRUrMSspz6vQMXzy0znYsgf6/Hyuor
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 752e2bb5-d49f-4648-3fd9-08d648602fbd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:CY1PR12MB0425;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0425;3:Xnkq123lYHhTC3cLdHBFdv+GHuX4IvD69tR6PHnWnmZLw3HB35RwO5MFl1eY/8Nr99I9v5bs4OJZKJuE9x+jjRcBg5PISe5/b4k1NJVk2tKvYph0Slpw+/+xSvRD3lcqjws9558z9ZlNuv8Z71gRHbX4fsmQIRXDcfjTS9y74gGo+xi6iV/ljIr/TkNXQmjL2lH/FPDVVn4kt2L2wFv79B68o1bjNxpEyViiFswtpeBVr30Kwu83GXCjIwVN9uXBzbCubTOhSLnPRcixAfRzyF9sSxhSZ68sZ/BQty9VSz1nKQlRGhQgbLy99SLXMSO9B8iMlr0F/4sS0IF4p6LNlMnE6nH7S4QBKcajA567ArI=;25:S510Mtrf6v3MhMJgPvH/B9L5ePJaZA7DE2QjHVhNPXB1ip9hy8uaTIg38uZQ4PjIWBH23Q8wKPtbJUFnUo2Pu6hlLAJBNjAtuF8c4xZLFWh0fyGCbhc6brxpEQBoRi45eb1l+PXa9ZUNBImHRNpfcLQ04cl2M3Z8tLUKT6WoHpXEYwK4vdDnd0SH73DdLruG6FeXHuSHPwiWTT4ddnkag6MFW+tdEDDq9LJ29WJR8R3fjAO5OJfE13Y9YcRGLEyLfoX06JFhXBkFFb5WUFEXeChb8kzRGOcs+UMCdlVY1R+ScK31ykk6dbMVsYkqngWwGTTQ8TUXxNXIkEXx8yVLfm6wb6EzrfEBN6U311R5aUA=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0425:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0425;31:13NfIh3crMrtFt2Qs5cnChzwhc3IAvWKs9ndf2jdcnSZbzbeA3UZsVgF+hW0QcNQBvr2GPM0wtX6jv7ZgSFmasWJkJXWMO3Z0kb5f+umPptpdgVEr4am3DdbAFQ8u7TuTi0uPyS8v3wYV7lDEXgQrvyE/F2ShCJrHGM++nlZyIUuWnLb//Joc+JoiOFZqMIQqSK+NtKyKQNiaCHRf1dmmvfq/KpbVBA7lyu0xa0rofI=;20:TIF2jip28ni1JQpHMTyuKacnKA6Hibn29g+aY5UyNh2vfYMnGLl/EqR/bI/UsgrMkSTDvFWAnFHcIJEcqumIs6wC0YslVgvYqSZeHmudKodMealAgMrWLnlrRLKFYsXx91kU6Q+R8L4Mfxx6c6xjVhrIDXokdb+N7INs9L/C8VK2mbrA5saAaAmaOyefcbmpzeO96XwakIyin9BKTW3GXEWd7hZRJKt/cdy9Tj6C3Z34SMR+yUm53fuOVNbsqxulKkF2cS8j54Sj+NUMGZ/L567YraMvF4/d4i0IgeafJuU5vnedSqEmB8VgsVKAcz75qlySPZ6uCKSEIlOb0QOK+2sA2mjeHPjEl1/gcglGoF16bpJDl+XEvr2Q1KXNnjt8Vpgv8oGnmMcdUeRBjHZWUdtHFiqdyIMarqfll94jgEAES+A29PLEJwNEjKosf7Pbry3U47W/NYgpLuPilU2SNB5J5Zr7ESkJ1PaNSSLRSv6lq684xabu92X3W0dxoSaS
X-Microsoft-Antispam-PRVS: <CY1PR12MB0425CE795A050D508383265F97C10@CY1PR12MB0425.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231382)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY1PR12MB0425;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0425;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0425;4:Sr+s9+yxEM5/v6CDUcMC0N9kHAyDWdp3WtdVmCiG+ZYugzYWI+BGtSSGSRMUDvcV/Oy9Ymf4QRAFFjTQt+vVUe/rj06CS2/jsqIwwJvHIo9NApNYFhZXsWY8HXpNVvAYpyEFPUenSqOwQIQlX6i2PIMb4babxU2JmDfa/7qku9y6sMCZCYqjC/PFGdCuAD1zIciOc3BO7v4EjoUi6zU/S9JqGdhZWcEXG9ZD59drHSPJOTyR7fQS4C6QOaYdCGJ20aklU0mZAOybSpn9tySsOvfvAT7cztSfPJO3kEDAA2f+RHscZ7pzsbd5Xk3CQNSV
X-Forefront-PRVS: 0854128AF0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR12MB0425;23:5lzcserCdiP5yts6UmcoyLraXbFHG0wkxD9V4dqdH?=
 =?us-ascii?Q?txikfxBACyxBtzRyW6776sHw4g2ZC8YqKjtXHsUd2SvsYox/x9aT7Nprhcoc?=
 =?us-ascii?Q?gQATOisMuuPAo/bWxMmrA5kE9D1gng1y6UUee0wwBBGzQeH+Z/4/PBR9BCEQ?=
 =?us-ascii?Q?o6iUFYXVEx0ufr9X9eIvGYLcwggbjs6EVPcNwkQIrCI928ospcynunTYuzqG?=
 =?us-ascii?Q?lVxziclckQMn4lTETihAgz8R4e1IzV7seGTXg31+q83+DMLznqzALv8gaKAn?=
 =?us-ascii?Q?i3SCiYSHEAe/SRHG2A3OfhT4sDtOUWTL18YJfXGCB0d/5biXikmInSOQCz7p?=
 =?us-ascii?Q?48czVpQiTSCiv44+YGMtWcaGJJBBaVZHP/EozyssVC5gdriaujF4ajQkbTIa?=
 =?us-ascii?Q?q5tCc4FwfnjmOGybq+0Bw8qWeobj39GgtmjghPzRP99yii3nUSnMoAmHoRFM?=
 =?us-ascii?Q?5iH8XlMkeW86nIwpisUi6+SB/Y0TZDVUJHiv6U9fz7ok+CxWDkTwltlqx049?=
 =?us-ascii?Q?hW/LOsQez35uCa6OQEhPYUK18HDYj84PBI95h+hAsS6gimnHbFKuvrqx8Pus?=
 =?us-ascii?Q?wEO8oJhyeLur0WMxgyfHp7f1WnNyVjvQiVwFi7jrfmrOACU4fiXeoNQCViaF?=
 =?us-ascii?Q?l4nkTbNUdJ8Tmt8pd/xdqOkJ0Q2iavtpsaNQKcjFb+do+/UbM/olbVMPcIz6?=
 =?us-ascii?Q?Iwm6WdEd96OLx+THnyCJ/aL+Bfs/Ueh4STsxwZaOYmmYFr1a1K1y6IdRWvmp?=
 =?us-ascii?Q?wvLWC2fgIgGcJq8b0Jd2ssjurjWUvCN5lAt//RuQHi1fZONTiki3AuG5v/u8?=
 =?us-ascii?Q?dtXVSkVB7R1TvEgl2LyG2Z+bFs+uO5GR9dow0pCKbJX0C2nASvSYYYvCBrU7?=
 =?us-ascii?Q?kj/cx53R7duATmBKh+zy1NrA/m9rq7R1WCoBJAsqFqc9gzACygUofI/I7/U0?=
 =?us-ascii?Q?gddWi9U2F0UFZpftO+AuF7AuUdxLX0gkuSrljcW30I90T9oYeFfTlu7/dkw1?=
 =?us-ascii?Q?uG5uxirRTKXkXOamhZczYICez7vW7PfAE+9Yu2uSkPi7mefndC+2l6uFHCuF?=
 =?us-ascii?Q?1PzMOJAhCIEtEtLBk1POQp9ESvSklocXyqnFJCUKhw7FNCLQRifJ4GWWDBu3?=
 =?us-ascii?Q?NgxZp3WUlPsTdRbim7K55MWa/mwWeZfjROVRDByBXycsxczRBqTdl2pst66F?=
 =?us-ascii?Q?ArHiDe+nvtqcK4KrTmkbM0+WPF1colrOf7F7ZA5wblUzMM+Bo6+DbRmqHZj8?=
 =?us-ascii?Q?81w3ipuwvYWKldFeEaEt1+5w/4LHrXdvgAcVDdRhFHJlnW4HNAUeH2iDghp2?=
 =?us-ascii?Q?amUThdhgtube0EdY/q2SoQ=3D?=
X-Microsoft-Antispam-Message-Info: 8qoDqmwSASTqgCClNPIqYaX1CEjsSznE6ukSIGCYf2n+hgvxjdKADDTiqi5Xkjf8KfG5qFncCyUpCNZ5SXeX+6y2WLNWNT+wTHcJx12ymy+DTJGFWHXS8cBPwybecYnWu5cy7qRbGKE2Y1rEA9ceuPLOArP4pPbzp/GpxwI2TlLvzfZ6jIjlmtwRLax5ugLCSWHmzVytsWs+LorH/UFubKopshtHh1vU2mX6B7mGNN7SKNTJcxMKWhY2MOqrVDUFt1KlXExtXnSi2Df00MNczOnCxCc4N1mV/Akg5zcYqzWqowNRa8/1YyU6rGtCBQiIT2HZDbLvBAwCq+qe31sl8ZQaw+xoDdqgj4I4DDEE3FU=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0425;6:Nd28HHkwqNs3PP4RwgMbR0lHERVW6kJSFn/4/zgx2MJkf/qe76q4N5wz4TlJv6XlRoqNLVPmSscCJc8JnkBMrQuL1ERwqjUNoeYEaKJDDfNa3SLIhpJOweBDhrPCrJL/+vUM1sq9Zu6FNjWtU/ybbxUbTkVIMB+TDcGhWRiRsuCTWM6ETe5WooCcj6NACJ2JClHzNbeYgFnwH3mDdlI7cMET+s/DTJMkb0a2+f9wgIrLajPJWz8TWDFboqBkl9HzyxMpnyhwaSu/26j6XZ/KEM1twRRcPqOwuSDjoSMcRItPbctpqYqiemzjibwW8FGzjXoEMXCglbWfk7wPfdCjZkXT+Rcjbxi24/SOFRrvLqpuf5Nm02bw/PMs+ZoAQq0Sc3LGfenIYxlSvDU9rzf+b2kEIC6aWkFPdMZ40/oQRbdaFLKog2yQ0j13IOphW1+EYMuhC+ruG8wN91t+yZOWOA==;5:Q79MGdE76XMBWIDX1GE04L+qSeSDS7VCdtrZBE5E35X9FeOU4WVOAZoVGQeRxAKJCfMg9R0o2fJTUi4VMUAIQUkzfCpJAW3sjj4v2Fwf6TxMsJ3eVCivcOcr+jDovisgo1I1fZ/04nxKXT8YXF89bjsqhi6ev9khSGS7xNzax+I=;7:jO8U1bTh6cCJBdwDN0nYbbYz00xWnNyuMqb6WcpfAWmLSCW42IwYc5aNL6+kdhstrjFyGHe8xN+dKhx263ffYA+D/qi/3CYAYpLBbEReCt6m1Vubd5fEaEafsbdpTHggMlxKTf5/KoD+H31IAETDLQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0425;20:XhyPTqyw+fran4VI2AyXpWZTOa2xJtYIese7WlS16veQrPQTRUdiFQbNo41CkT6a584nOb10xYXT/9P+EQT7M/aUIx79PkLAP4B4JEKuGgYeaykRPI5DmqbzLSJiRSvvjrt2zsFEx6z++HVjlCxybt9qXSVNcMCwVt5Mcf7y9zwhUtT71088Mh1XyELqn+k7AGigEEiKYwnBTXP1mrf+V1qH2u9UyCrXnhmdtZqfFf+vEujDVQqSvV9juSujechK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2018 05:32:07.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752e2bb5-d49f-4648-3fd9-08d648602fbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0425
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCM platform driver binds to the platform device created by ACP3x PCI
device. PCM driver registers ALSA DMA and CPU DAI components with ASoC
framework.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 263 ++++++++++++++++++++++++++++++++++++
 sound/soc/amd/raven/acp3x.h         |   7 +
 2 files changed, 270 insertions(+)
 create mode 100644 sound/soc/amd/raven/acp3x-pcm-dma.c

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
new file mode 100644
index 0000000..3e806f7
--- /dev/null
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -0,0 +1,263 @@
+/*
+ * AMD ALSA SoC PCM Driver
+ *
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "acp3x.h"
+
+#define DRV_NAME "acp3x-i2s-audio"
+
+struct i2s_dev_data {
+	void __iomem *acp3x_base;
+	struct snd_pcm_substream *play_stream;
+	struct snd_pcm_substream *capture_stream;
+};
+
+static int acp3x_power_on(void __iomem *acp3x_base, bool on)
+{
+	u16 val, mask;
+	u32 timeout;
+
+	if (on == true) {
+		val = 1;
+		mask = ACP3x_POWER_ON;
+	} else {
+		val = 0;
+		mask = ACP3x_POWER_OFF;
+	}
+
+	rv_writel(val, acp3x_base + mmACP_PGFSM_CONTROL);
+	timeout = 0;
+	while (true) {
+		val = rv_readl(acp3x_base + mmACP_PGFSM_STATUS);
+		if ((val & ACP3x_POWER_OFF_IN_PROGRESS) == mask)
+			break;
+		if (timeout > 100) {
+			pr_err("ACP3x power state change failure\n");
+			return -ENODEV;
+		}
+		timeout++;
+		cpu_relax();
+	}
+	return 0;
+}
+
+static int acp3x_reset(void __iomem *acp3x_base)
+{
+	u32 val, timeout;
+
+	rv_writel(1, acp3x_base + mmACP_SOFT_RESET);
+	timeout = 0;
+	while (true) {
+		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
+		if ((val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK) ||
+		     timeout > 100) {
+			if (val & ACP3x_SOFT_RESET__SoftResetAudDone_MASK)
+				break;
+			return -ENODEV;
+		}
+		timeout++;
+		cpu_relax();
+	}
+
+	rv_writel(0, acp3x_base + mmACP_SOFT_RESET);
+	timeout = 0;
+	while (true) {
+		val = rv_readl(acp3x_base + mmACP_SOFT_RESET);
+		if (!val || timeout > 100) {
+			if (!val)
+				break;
+			return -ENODEV;
+		}
+		timeout++;
+		cpu_relax();
+	}
+	return 0;
+}
+
+static int acp3x_init(void __iomem *acp3x_base)
+{
+	int ret;
+
+	/* power on */
+	ret = acp3x_power_on(acp3x_base, true);
+	if (ret) {
+		pr_err("ACP3x power on failed\n");
+		return ret;
+	}
+	/* Reset */
+	ret = acp3x_reset(acp3x_base);
+	if (ret) {
+		pr_err("ACP3x reset failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int acp3x_deinit(void __iomem *acp3x_base)
+{
+	int ret;
+
+	/* Reset */
+	ret = acp3x_reset(acp3x_base);
+	if (ret) {
+		pr_err("ACP3x reset failed\n");
+		return ret;
+	}
+	/* power off */
+	ret = acp3x_power_on(acp3x_base, false);
+	if (ret) {
+		pr_err("ACP3x power off failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static struct snd_pcm_ops acp3x_dma_ops = {
+	.open = NULL,
+	.close = NULL,
+	.ioctl = NULL,
+	.hw_params = NULL,
+	.hw_free = NULL,
+	.pointer = NULL,
+	.mmap = NULL,
+};
+
+struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
+	.hw_params = NULL,
+	.trigger   = NULL,
+	.set_fmt = NULL,
+};
+
+static struct snd_soc_dai_driver acp3x_i2s_dai_driver = {
+	.playback = {
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+					SNDRV_PCM_FMTBIT_U8 |
+					SNDRV_PCM_FMTBIT_S24_LE |
+					SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 8,
+
+		.rate_min = 8000,
+		.rate_max = 96000,
+	},
+	.capture = {
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+					SNDRV_PCM_FMTBIT_U8 |
+					SNDRV_PCM_FMTBIT_S24_LE |
+					SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 2,
+		.rate_min = 8000,
+		.rate_max = 48000,
+	},
+	.ops = &acp3x_dai_i2s_ops,
+};
+
+static const struct snd_soc_component_driver acp3x_i2s_component = {
+	.name           = DRV_NAME,
+	.ops		= &acp3x_dma_ops,
+	.pcm_new	= acp3x_dma_new,
+};
+
+static int acp3x_audio_probe(struct platform_device *pdev)
+{
+	int status;
+	struct resource *res;
+	struct i2s_dev_data *adata;
+	unsigned int irqflags;
+
+	if (!pdev->dev.platform_data) {
+		dev_err(&pdev->dev, "platform_data not retrieved\n");
+		return -ENODEV;
+	}
+	irqflags = *((unsigned int *)(pdev->dev.platform_data));
+
+	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data),
+			     GFP_KERNEL);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
+			return -ENODEV;
+	}
+
+	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
+					 resource_size(res));
+
+	adata->play_stream = NULL;
+	adata->capture_stream = NULL;
+
+	dev_set_drvdata(&pdev->dev, adata);
+	/* Initialize ACP */
+	status = acp3x_init(adata->acp3x_base);
+	if (status)
+		return -ENODEV;
+	status = devm_snd_soc_register_component(&pdev->dev,
+						 &acp3x_i2s_component,
+						 &acp3x_i2s_dai_driver, 1);
+	if (status) {
+		dev_err(&pdev->dev, "Fail to register acp i2s dai\n");
+		goto dev_err;
+	}
+
+	return 0;
+dev_err:
+	status = acp3x_deinit(adata->acp3x_base);
+	if (status)
+		dev_err(&pdev->dev, "ACP de-init failed\n");
+	else
+		dev_info(&pdev->dev, "ACP de-initialized\n");
+	/*ignore device status and return driver probe error*/
+	return -ENODEV;
+}
+
+static int acp3x_audio_remove(struct platform_device *pdev)
+{
+	int ret;
+	struct i2s_dev_data *adata = dev_get_drvdata(&pdev->dev);
+
+	ret = acp3x_deinit(adata->acp3x_base);
+	if (ret)
+		dev_err(&pdev->dev, "ACP de-init failed\n");
+	else
+		dev_info(&pdev->dev, "ACP de-initialized\n");
+
+	return 0;
+}
+
+static struct platform_driver acp3x_dma_driver = {
+	.probe = acp3x_audio_probe,
+	.remove = acp3x_audio_remove,
+	.driver = {
+		.name = "acp3x_rv_i2s",
+	},
+};
+
+module_platform_driver(acp3x_dma_driver);
+
+MODULE_AUTHOR("Maruthi.Bayyavarapu@amd.com");
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD ACP 3.x PCM Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 83b1ed8..f3d3e51 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -5,6 +5,13 @@
 #define	ACP3x_REG_START	0x1240000
 #define	ACP3x_REG_END	0x1250200
 #define I2S_MODE	0x04
+#define	BT_TX_THRESHOLD 26
+#define	BT_RX_THRESHOLD 25
+#define ACP3x_POWER_ON 0x00
+#define ACP3x_POWER_ON_IN_PROGRESS 0x01
+#define ACP3x_POWER_OFF 0x02
+#define ACP3x_POWER_OFF_IN_PROGRESS 0x03
+#define ACP3x_SOFT_RESET__SoftResetAudDone_MASK	0x00010001
 
 static inline u32 rv_readl(void __iomem *base_addr)
 {
-- 
2.7.4

