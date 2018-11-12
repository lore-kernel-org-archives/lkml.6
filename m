Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6626C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1C3216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DZLwEeTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1C3216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbeKLP1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:27:47 -0500
Received: from mail-eopbgr790059.outbound.protection.outlook.com ([40.107.79.59]:24192
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727243AbeKLP1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o3gh6c/gtUi6dtloy0BDJpUedMdwvUWYX2k/zUMJrk=;
 b=DZLwEeTJN3Yb/x/Nd8tygLA4p/OVSxKMqoOly5eVNU3ryk8xMshum0fP08UdGXBWC99MOjyLnngQvWwBNBL1ZamBPQQaY8EIwKrF47szoPyTZAV8IvV2F48/+iUqQJRro66G5v0lJNMg9ILF+b5l0Uj3EB8C5y3Q5sM3oJdBETo=
Received: from MWHPR12CA0062.namprd12.prod.outlook.com (2603:10b6:300:103::24)
 by SN1PR12MB0623.namprd12.prod.outlook.com (2a01:111:e400:c428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.27; Mon, 12 Nov
 2018 05:33:27 +0000
Received: from CO1NAM03FT021.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::204) by MWHPR12CA0062.outlook.office365.com
 (2603:10b6:300:103::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.20 via Frontend
 Transport; Mon, 12 Nov 2018 05:33:27 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT021.mail.protection.outlook.com (10.152.80.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Mon, 12 Nov 2018 05:33:26 +0000
Received: from LinuxHost.amd.com (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Sun, 11 Nov 2018
 23:33:24 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC:     <vijendar.mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/11] ASoC: amd: add acp3x runtime pm ops
Date:   Mon, 12 Nov 2018 11:05:00 +0530
Message-ID: <1542000903-19020-10-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(2980300002)(428003)(189003)(199004)(336012)(72206003)(2906002)(53416004)(305945005)(54906003)(316002)(77096007)(39060400002)(7696005)(26005)(51416003)(426003)(47776003)(4326008)(76176011)(14444005)(186003)(8676002)(53936002)(105586002)(16586007)(5660300001)(478600001)(97736004)(486006)(476003)(356004)(6666004)(11346002)(8936002)(50466002)(446003)(81156014)(86362001)(81166006)(48376002)(36756003)(106466001)(109986005)(68736007)(2616005)(50226002)(1671002)(104016004)(126002)(42413003)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0623;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT021;1:45Y4ClKIN2DTHWobpsggCkbVnAFYPfarZVMRxFSg1jfo3RxCtnmZXO4fub48Ei/KKj7UOqCARSi8ZYE9aZRHUsA6tBgJvHe0WYRMCubxKuFURR144FgxJAqwKC8hXNQT
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a3103d9-a0c2-480f-e527-08d648605f12
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:SN1PR12MB0623;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0623;3:buFRXvl8Sv72XcwowT0w3XeSiAk9qvgVh+llYcF3OeaYhUumOadf2uIr5TVrv9mQzUwJQhkfKWmynJkcS6JXWZF3xqNXRhbP3/+OgpGXLghYy8cU6lkZy+PmJIiWiA8/g8B/JtehSPxlsw+/B9f7fphR7NI1GI/SXOJ93q3nvzVypm1AYlA26l6/Hz27wrC92EDGB25/AQJtZTSTlitPtKjKzmlLoW5lrnlGdIzL1zcQnQyALR+xBrBV0JxFE80qXSgELhSZbKPpgdhh86FLkstetUG14sKM3k6opnKpwct0+8giJs8LBf3SzX1ouu2JQ9LMx0o44dV9vfLTlfr3hKTs/alGtN7q1MzNorO/fp8=;25:oTEcNplNLoaS7EvnbiomwJbEdgS9F1KUu4wlSUBT6qHL3fX6C1ykmdrA/O6V4PU9rn6AXBaM6cdPPwRXZR19rKYahMo9nOvfLzCczd37S4gdL/sW7wr5L2/Xl8iutQGflQ0FTV98mXXBkkmW9VZwllr761b9xenenLrLHUbmzoJJ3cx3ISvoUSG+TcBe9ekHNNM35ZthAeR4BOgdDSNKNpy2TA1Fzk2mtVGS04WYdgRgou1dSbRYSIQ+7qRQa1wgpwe2IzdfNMe2gYSGCejBPoQuocHvBRgkw0so/vtmZUErQcTTg/NhvXfGlo2AJbhdqwobH4bNYo8xjvFjgafi6fnZLMa+XhqONCLGs2YmIMs=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0623:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0623;31:IQnYvT2qRg496agFxjqFrrKJZUT1DiFGH1owh1RUQffihiap7GL853MqCC4nAFWxWDIKe+KF6j6Mae4SNVaYbKPIiyPoAkhCzE1mjusshkRz2z5I1S/S3XHudem4E5T0jnugbEWmakqdujvhIB0mImcyAQvanFdH3f87jSatcTBdxRUV+AMXJ4Zz1AUhftfB5uaP/fHBzTQtT7hKuuSJw5yM2FA8/oyRT2anur1SbIs=;20:+PXAqgzJwOiLF3Z1MNvmHpf+5sR7x1AF3GQNVrJENKUjVZZ3VQrjINy+SQgejox5EE9hw5Wmw1B3F/55wZKWjkaP7MNUsdalUt0yZ2Q8teKo4eEnm5isBC2dw/gzlGH2G40sCuYAsWZmZY25Tr42DTDWbpZcerVmo6VTC4cPX2E3lS+gMSbWZC6KW7RKusXewzeQYJk/kLwlaT2CupchytqfENnDzgLdyOZ90Ec5EI9zvkAApUjn1XS5M/ys1ptkNDB+Bqi4TUOBwOkbs02080Wm5g/ZbhSrUVq6xKUOq5p3BcGbbZoASc5SWx+AVCEL6QJ6ijrOmRj8shMjXiHmfDcQuZeWdH6uroDi5Ljgm4ieCt2bvDfV9topRWt5Cq2QjKmWLHNEPxZ2vKnufZWEShT0hWcz3Dn15jch4n8eqTqzFf5UhsTrDF7uJ9Zg7Dh5hQSCmP1sPcoHlT6V/9pgFKDOlFCmjFT478awwtk1FsxH8e5pR458xEaq4otMSiDE
X-Microsoft-Antispam-PRVS: <SN1PR12MB0623BC8C36A9B94FE6747F2897C10@SN1PR12MB0623.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231402)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0623;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0623;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0623;4:OOAnt43sG2lEQVElt5QgafLFAu6i0WOVKjJDBkPGST0a3Yhh365cBUQeaag2TwTOshj3j8xoIMEBK0Eo618k+xE8qyY28UWgaXGVZp3NuhyEs2PddfA6QHp/JXYgJoU/llsrHQuXUxfdy8TVZEJqZqxwuU1ARqIS2MFi0wm2IlL8W3tq2RgyzbDQT6jyEtL7L9F+cl2khWDKLdOLdEqVVzEGMmaHOQloXORUL3NjCbA0Nj4XzHndVtKODBV9IqIxEmZcCs8NZ56uEzCeXrLhI9eEkcjMcDgSsK+LoB+rTHOtFl1uirt17aThor0n+SlP
X-Forefront-PRVS: 0854128AF0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0623;23:w2fFlqeJypt9jTcfAyJ9C0DxTzF4r4QJaqvl3fSLy?=
 =?us-ascii?Q?45zgdMQKubegpbk0OWCWt2OL9oUJjee2p9PXqJoVd/B+ZTj8B/E7u1cs/yXC?=
 =?us-ascii?Q?OFKEe5rbs6PsKnmD9oMDg6hnnhYKquqRIdR0FAn7gOQtPNm+W98OZaDF/f0M?=
 =?us-ascii?Q?bVL73ADhyEdSlfBNaD61SgJMrurf7QwHGkJQSBuu3sYejlFKUVGWmsAhfhKC?=
 =?us-ascii?Q?MisCkAc+/7myDS7t/siPDTAqKNNT9bPH07K+ma0sHiCjkMRkO/rsOG/O0aQP?=
 =?us-ascii?Q?iqSCvFjaCpaw/Scm74BLRcguyNsxbT+dDn5jNUplb3i6Vf0bTPR01CWydUqO?=
 =?us-ascii?Q?lQf1ItiOnnpRqOZScrAQuiyZDIJF9nUCMwzO14pgYHv+YTRxbugXk++Y3idT?=
 =?us-ascii?Q?FayQf+CEe83R9xoefr9+NVDOscE4dO6aoFRme/3yeCI7MQFpY5A39mtAz1It?=
 =?us-ascii?Q?avtOFnGROOnwDkT0Vj+n2CEaOWXsbel2ZPDpEd90Ur6HYf3rui7qsyA07Q/x?=
 =?us-ascii?Q?NfVfj0Tvenp1YQLPaAzFA+EIldvZBDE9z8Rp3wHFm0EEJOrR1tujZVYPBFtP?=
 =?us-ascii?Q?LTYMasqYIegMaQw3HRRHgR9Tcm0EO0e0NAOEhKwtJNuP9gczf4Ph8idiEJ3n?=
 =?us-ascii?Q?UafOyW6kNhohBdjIofzsPg0rYtdP68lMinf7H6scKImOGnkPRbHU3psCRw0a?=
 =?us-ascii?Q?b9LumBEpJzgWacX8MXi7DbdHrvH87jlcTez0x1Rad1NYmJn5iBqs9SJiQ3CV?=
 =?us-ascii?Q?c2q+DSWQ3jBX+mqFCWfEXcFU62XFVONWs5juPBZdP2hBqSOjpaMUZmdhxfcv?=
 =?us-ascii?Q?qT5jq9FcXoisO82woOsmm4f287FJOuvUR77O/a8IErKDalnnBi+tbqZGxX+M?=
 =?us-ascii?Q?V2LR/FGuWSMLIV83BU5CN3iWM51l0EDmLgNujkJTBiux/jCISwlF5dwznxm5?=
 =?us-ascii?Q?Z07SJxk5i0jAsqhVtKe81QxjKKGbA9H0C/vjUKYNLKRmlRkoYxL0XeYSaCxf?=
 =?us-ascii?Q?sJLfP7hKNmCCe/hu4MBSqQv0yZfIIz5d5TTqnys9FbUxq96hYmYbSFQvlVZz?=
 =?us-ascii?Q?HV7/WdzQoZJSA4fPd4xMUfAWLckH2H6UXONkmH2kgdODFEFnyzCw6GI2PmGJ?=
 =?us-ascii?Q?Lz3aVtuCdpf3oJPgqcV7VKeGY8CAxbJJP17+oMxGhNjCXW6ykExXAncqJjfm?=
 =?us-ascii?Q?NxyNlqQtsO7V2E872kQ6sfCJ7XUIjsi2X9ZI5VVpHz49ufjPRS000GsGdT2q?=
 =?us-ascii?Q?a/kqgvZUecu45QBQ7cek74TqMgJcSm0utxNUKrk9kPkcUvCzE15Uhzczdrwo?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: jP1Rjc1HsI4dD0WB1lDjlLE6SQSY71kKuzWvGJvncTGht5qcUJZsAWzyR9qIBgMHUHxicX0mKWgfcqjn8xk7R28RJ0lTK3JwC/06g8wQ5R/1zE5K/++9Lu7VBoOmIbRILwyy7uywajEno5V7XZeF70+LA6XNeUvJJFDkTAm6r4W4NZQDbZ2qhro8+yvL7/VCQu1R000WahT6d2tn+X8z0qVyRvZ72MNAGX5fiD/vKCkAgQYTc/GUiQfGsraRsp65NgOJ4BsoxlqKWEkCk22oHHt24kYSELNpV/ho01WR6KsPjgpvSPkkhvOYZpxWRMY6qk0rnYUfOHBQ6BKc+uVT/R0YGjM96y0QvhwY8xrTCp8=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0623;6:Ly6aCLK7fnkM4x6w/zNFgjSReAA6IOIrVP8fEOVoaA5+nHHyFMCb4RM9rbymwm10onZId6KlNkXvTWriqgFRXZjru8AifBUeuuhRQxf3SEz8T7hjtaxHPasoeIFSa94u11H+DEjPlMG4ZTKgfZx/8teWIoGBPJA4gSP08lTnSKa5xArbUddvxbvnkuVi+ZZIrl9nIKRjACqBzz0HogsXsmw771289oEaa0//HWvOHmTAoF/LIMT0yg8rn/D2SjX90oWR4gBuOmYouiWJE8OwOC7ieL0pv+/E7MHg+CLRh38djnVtXNkpsrkxw7Ey3OT29Wfg1e5TuV35yZfkhIZP1slhcpioCURlHTv4sFLKmv3W+vOW42T3S/VhHwz5B9qCpPcJx2rO874evxZ1ZX0jC8vcKlWRMabqeLFA3fk6yWMBGsrfguJcDh585DR+Xqx/3pxYdXBjWAz4q4+C8z7nng==;5:MRZw7Kkyl7tP3+Kdu/NW0JGpsM8KjZZvEAde6t3sGu4x9xOeOfVfchf20agqWyztF4EHwnS2z19U06/RkYbU6xAG5JsdJ7WrPppH8PGvEHkirbVWopn11KaFUxEnsb5N73XpduetYIiOe8dCTmg9QK2XLe47jHz4dq6RiQBI1EE=;7:ly4vruXfVKojEISETbyATbl/c3LgR16RTv4QuBBaM2Tn2pc+PYHyqiu1BN0VQJ7cCfk0YWAof2x/qaRF9QLw0VlCBysvdQMkK1N5byXEAhQPRmwn5994Q6nKp1G4ssiOzRBwrIafmtk9oBQnJ/IlpQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0623;20:k4nsJe1fLx5/cqkeN80ZonFq/jL/ZPZjihWw1xMX5qjujUEkPfr436oWXHuGkPdT8fQEGqKNrDGt4U86PUGUz6Q86JRcGeUi7N3fzav5MI1jO8teCdo2mFep55qUpAdv2WiET4LervUeCy0oM4Xg61j+0EDfKnrdxK/MUJUHKtjCXs5Qbdi81LkoBUx1PPD3+ewGorMrpbSAzq0gLhMq30k26cm34xgzMyQmxP6FR/IvmZ00DiE6PrYSYZvinqXs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2018 05:33:26.5356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3103d9-a0c2-480f-e527-08d648605f12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0623
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added runtime PM operations for ACP3x PCM platform device.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 15a5f3b..710c5c5 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -660,6 +661,9 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 		goto dev_err;
 	}
 
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 10000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	return 0;
 dev_err:
 	status = acp3x_deinit(adata->acp3x_base);
@@ -682,14 +686,49 @@ static int acp3x_audio_remove(struct platform_device *pdev)
 	else
 		dev_info(&pdev->dev, "ACP de-initialized\n");
 
+	pm_runtime_disable(&pdev->dev);
 	return 0;
 }
 
+static int acp3x_pcm_runtime_suspend(struct device *dev)
+{
+	int status;
+	struct i2s_dev_data *adata = dev_get_drvdata(dev);
+
+	status = acp3x_deinit(adata->acp3x_base);
+	if (status)
+		dev_err(dev, "ACP de-init failed\n");
+	else
+		dev_info(dev, "ACP de-initialized\n");
+
+	rv_writel(0, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
+
+	return 0;
+}
+
+static int acp3x_pcm_runtime_resume(struct device *dev)
+{
+	int status;
+	struct i2s_dev_data *adata = dev_get_drvdata(dev);
+
+	status = acp3x_init(adata->acp3x_base);
+	if (status)
+		return -ENODEV;
+	rv_writel(1, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
+	return 0;
+}
+
+static const struct dev_pm_ops acp3x_pm_ops = {
+	.runtime_suspend = acp3x_pcm_runtime_suspend,
+	.runtime_resume = acp3x_pcm_runtime_resume,
+};
+
 static struct platform_driver acp3x_dma_driver = {
 	.probe = acp3x_audio_probe,
 	.remove = acp3x_audio_remove,
 	.driver = {
 		.name = "acp3x_rv_i2s",
+		.pm = &acp3x_pm_ops,
 	},
 };
 
-- 
2.7.4

