Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A429FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6DC208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 01:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="JllGsPaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6DC208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbeHPEtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 00:49:52 -0400
Received: from mail-sn1nam01on0135.outbound.protection.outlook.com ([104.47.32.135]:12928
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727233AbeHPEtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 00:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sRyV54F62/wGfCHv8L20o9zQM9Q4nCdXFQcWP3LhRQ=;
 b=JllGsPaVH0y2Q8wErLpDXDb//cR1CdfgvIN1QZZH6TvZndvoQXZIvD9IzTmyAUvT6CRlqhfK3pjuPM5nzCpe+jqrqAtsTC32oUHUetR1xknaw7zJUEeioPdOWx6oIPqG9nYeb5PSdQQcw3XcbYDtoawEboeQbuWJNRLFyySEboE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
Received: from localhost.localdomain (172.56.39.147) by
 DM3PR1101MB1133.namprd11.prod.outlook.com (2a01:111:e400:5aae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Thu, 16 Aug
 2018 01:54:49 +0000
From:   Ryan Lee <ryans.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ryans.lee@maximintegrated.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     ryan.lee.maxim@gmail.com
Subject: [PATCH] ASoC: max98373: Added speaker FS gain cotnrol register to volatile.
Date:   Wed, 15 Aug 2018 18:53:38 -0700
Message-Id: <20180816015338.3734-1-ryans.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.56.39.147]
X-ClientProxiedBy: DM5PR12CA0012.namprd12.prod.outlook.com (2603:10b6:4:1::22)
 To DM3PR1101MB1133.namprd11.prod.outlook.com (2a01:111:e400:5aae::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c82ecd4a-1064-4239-5fc4-08d6031b40c2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM3PR1101MB1133;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR1101MB1133;3:jIXVW3OaQ4ufWzJOY7F3uwYF9DhHa24eLlamMqJPo4uRrnivH2N6F55S323ef6VW8DFcbEWdzFLkgXGJc0K0WsA+mSPrqI956OPlViUM7jfyeyky2oQbO7u9jRPXj71MEu1HrTkye0GLlQmZjiXAOF3eZmwicUCYSxj9cXVlBSTz4khsopQOiVHHmW+9tfzF+zMMVBef94Y/2wrdPO8ei/+UGtdqpTUSRLnvvG2TxTC3MTpAttKp9l75xN9QQb6X;25:tuLYLxsG9zdVlrI5P5nT1w0k+LR8FkAo3agEnpaA2MuwTjoM/GIQ3afWctgitzY9UjV5koxL9bGLscuoPiWNowmVXtYPDfuQsVxgS+4GZRVbkXcVwZOv/qYmvyM5tetD8zGqCj+a+PUJhv4Jxt4hAzw39DPO28+YhRS3A8LWiojuHHqZOcr/UL3jSbfCOi9FFfW9GQyg6G2afcYUG6GDPa3KpUuuTiZ6WPDAHquswAr9dl8r8481GeZa36JaUo8JUqKStS+X9NZGJDkN9z4655x/izQ6XyHhYIKUk5ylBnAYOcWSR4Ya1sQ4gS1E1oUZKvpk5fbteeaMP8b3yTlv8A==;31:z+kMGc0nGu2jLiMTTh/HsFPkeWRxTLQsRpQsetbr52lZ/HvuL/4zg1J2K37jciT+DyIo0EjUd+eetpG4J7yfqK2L3v5anqXGfvAN36bgFKrvCkxQGOBCirMghPy25j4fdoNE5+Jwa/vhCPNOmltz/kRNIUGdYrZRllaHmsfmEF6TmoGr2ROXkPdE6hKmnq6PhBCCc/npO6R6G8gWFcY7Na4KeWBbq6fgbbsCTynIPvM=
X-MS-TrafficTypeDiagnostic: DM3PR1101MB1133:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR1101MB1133;20:/Jn/akmQY+CjQUqjm5rJZbWQ66OsWnqQ7T0pOQKoUo3xWn3iQ+WzqUZnnSk0euaRkeQERQPqyb/zX/vsUeWjsqf6LFukaJp7a9Q4gjqA5dHH/s4fUdJTbD6k/v95EkBB1sbL9IFJpr8R1D+AoodU8uhHFmIR3DbwMZ7hgv7o/LiV0MoJMwmQoAMjLOsKsz+zPl6wM3XvOcIT1+QxGgFy38JXhm406SQojKf6440IFL88VrB/70tuGkGlO0RpkfLEBXkFj4N8q0VexcRFx2MWX1hXPu9lnQe87+gObkMQ3HVuZXdrbjjcm926u1ZidVeTpwOH0z8MXWcYC+EEjsF6+gWuokShPE9Dp7vBHJ6lHO9LzSZ1gfbmrkAteT/A/NFGrxks33DfwOX8aiKIBDW1uzN5NRDAd4loURpq3yNoNLuJBexcv233+VTbOcw5v4bCMepnxDJRucoyEhsKig1/4T92JqZGtSkZplHLBuo9IvbFh3yDUVkCo1sNU4SkU5Zj;4:KOnBUH9YLjYdSEjFex6eiN7KZWLHJmMB2XrZx9+xH5rr6ZvRt6esIalyTsHI5rVQT99joL2YSEOcXRpGg0Ms9DtRr4HUmRuFJp5USdZjDUV7AKCiRdZ2K97qblb65LUlEOAtEkI2zpo3PQLj8gii5vkRSVCQgVrM2Y67lagOFT1S8LStxUVeF7lr43/Bp+B6y91kfD6TPMK/EtNR8lx+xkz3GqGxRJMWDyQOwUHEVvA4Q+bbi2vqcvHxYPCGDwnhy84/rzpJ2sq01aIfCxtyLCUWGj8oOVgPlUkopZqUg6XchuZL5JBTdZG9VLsO3fSr
X-Microsoft-Antispam-PRVS: <DM3PR1101MB11335BF2FB7B11355102583AE73E0@DM3PR1101MB1133.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(108721460000369);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:DM3PR1101MB1133;BCL:0;PCL:0;RULEID:;SRVR:DM3PR1101MB1133;
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(5660300001)(16586007)(26005)(50226002)(68736007)(186003)(6512007)(956004)(48376002)(16526019)(4326008)(53936002)(316002)(25786009)(2616005)(50466002)(106356001)(486006)(476003)(386003)(2906002)(6486002)(6506007)(8936002)(51416003)(305945005)(6116002)(47776003)(66066001)(97736004)(1857600001)(105586002)(72206003)(81166006)(52116002)(86362001)(3846002)(8676002)(81156014)(7736002)(39060400002)(36756003)(1076002)(478600001)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR1101MB1133;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR1101MB1133;23:G8JLakuF4go2s83G7zM3ZL04QARlYSvbV/R8Iv6?=
 =?us-ascii?Q?82cQOa2agZDl887Fq+oDa1/uevb8pGqbwhjnWIMKDSKOGh8wdCPJrb+QiwWs?=
 =?us-ascii?Q?TJSeWDo+0BOu0bpnRgId3ZWfKJNJgV0KrMTdaqDLh8n/I/FJjexuBq3u8UCh?=
 =?us-ascii?Q?ZBuzGOFjVWQWRpaVzeNqDFD5/vXACDkLn2njGNSY2JFKvootDNezZwi67LVv?=
 =?us-ascii?Q?LXvqJgXXZmNCg0VUpIgJdqsxyHMHVIQ4B70SFUEcXP3ExrjJUdZlDVKy7SjA?=
 =?us-ascii?Q?qNuL4xscOWu+0lQZhO6jp9f2GdbF73nqxivDAekIqOVWCxrt8U7Y6BBJH/C7?=
 =?us-ascii?Q?NtCBfy4dhcENK6cWcE06aZ5KXG6XfthnU8Kb26FDcS1dwooYsb0wGUX5auvz?=
 =?us-ascii?Q?XJUcJufz1SGCotwdVOWzcxyEpSmTBWEByPkwAxvWumySqWlPjVK3iveZjr1C?=
 =?us-ascii?Q?bszl7jelc9Q63j6WV/k9RbPP0XVx8R/zpQ1cHeQ8rOhg0y+NoWkBzj7E/5IE?=
 =?us-ascii?Q?WlHs7AKjQTYQmP8xoQG71UEJIIrbLjEz0KFduJ5QWE/2xvB4zfBCkcSIo2PA?=
 =?us-ascii?Q?EHXtvhVbdSsQ/MCchSllcYDQrRXauzx6YkOOdauvVHBq/iWABTEViPoVnZbV?=
 =?us-ascii?Q?wA+vlQ790Ru+zoAE+RkH55evfOB8aj5edM5d0T7zWX/BaHZ5kdYvll5G69Iy?=
 =?us-ascii?Q?LmwVrVfsw6AsIv/DVahTeIjxf+SG2iIEDyeaJButCYIy1t2VGrAxVWSWUc/Y?=
 =?us-ascii?Q?WPs0CyHSEazVe+Cv547mxiQpVzqCsFrtA6CdH4uVw4ArJjKaaZg8HIWWEsf/?=
 =?us-ascii?Q?G56zErZEDSM5rpmXCTOe6d1ciOAdZ+Q+4ahVOgoX35zyZvKDhlynRJa2q/y/?=
 =?us-ascii?Q?/oVwMJOvR3+zNEQH/Ad/2FsDRrpaEqy+qN38IGm2Y7apy/ELsmMPcx/4h4wI?=
 =?us-ascii?Q?B+vThwW4qtMbGj2hV/XhMuJBfG5kInoKNezC+TZ23b5wa4PqYb1vikHNIfme?=
 =?us-ascii?Q?2vBF9DZcDa1f3XzVTimECs51RFsOUK2V0FtZdctTTzmfcyqWEj5s393P6BxO?=
 =?us-ascii?Q?oZHygfVR9yFty7DA9ehaKGhHknwboGO2HcGUsLn4ZjaCITRK+wZK4FCdjdI9?=
 =?us-ascii?Q?1h3yVte/QwTAmz2HPHmsCHqDZby5YtQnmIJugtgZiZB9H7jxih6idCOY6dtR?=
 =?us-ascii?Q?7Jz5VsyFCWJzWOuqRbv0VmyYxsj9LW1a0TY63?=
X-Microsoft-Antispam-Message-Info: 1q6IgZM861DHCImKexvbIGflZQ+3Qj51+db90g+3GnjsFi5KxMFzY7JC+ChCHrcVIN5hB5M7FYMuJPSDjgGOgomQ2A8RpHirSt4peIwtw1qgLaMq0jCMAHdCfIODiPkgaHCJuk8hnDzK9FJx1/LjFBFeYu1nwik4ZrgmUq0ojewf26YxiWSwFb58dgKfP1uOkQLyxcv0SDF8vl4IBJxUeOUsvzH3jP27qM6J+KrrBex+rVn8kahmOlLaUtoU+QtFvqhbzVs7xvtlEwNJRuQvwUifthNSBedwld+6yvulKWYaUJmdYuj1JAbZzB9y2sdgzn5BmFMOCHkAevFKjGgXM5Rw0Cr84yvgwtXDtf3lWec=
X-Microsoft-Exchange-Diagnostics: 1;DM3PR1101MB1133;6:oz2HJTynoYGQwQONW2gwS1YxdimgNlXaFPpfuWBnGfxN7VjPSngXzZpED8QVIW2yRLSSzOq1mOOkTUjoypkVJlQO1HVvyiT2Bh6FlzPA5hsVK08ENsiYH8nDp/CVPidxK5m27Ilx4DLBlGgQyj9cqK2Bj8LMor4lkiFU+5luvsHl9aqK+aUcsG9e1M/DpPe46fmpDt9C36MfBc++Ig44MXur6Q0JHuMYb1zfQ+h/BnHqrZDFqR2hbvHKp5zzYUH9b+CxCEfBOcFWzbqkRYIFN13xBotEo7aXPfarAWWKVkiaL4N48Easp8Q3cCanJmjIdFOQ9AJFl/TXxg9hMx4tCmNRm/sdHodwIdeE2K3+8kKg177a1Cwc8IEUWRcNuzPYF8xI7qXu0oHT/Uu9IGT8OPxnY7CtHwwKlLcJj9GH3IyE0FiLbv2aNBN8EcRKn2bjNqjNqiMlVLadCa8IzTGQjg==;5:yJJh4lFrmiZFTyZStVlXvMctfzOKPh4oovqTxQkIkRUIYyr2mFH5sSAJhhD+Q8hpG5qfa2GhD8uoRhitujPHk4WbleELlOVfeQsWg5dLQBtnVOfMBJ4mpX04rqiGaplBKKhKQWZuadFOQWi6ar41OCERVD65sqVXQ4RYcCp72Ew=;7:2gNyUHWoQpjAj/++WLx9Hbs3Ul3f+j2E0x3nAtBDBMjaA79TnSbZxs+scQPbkjThExexGr1fkswvxeodym3cCgGNmCoYUSg406LezTnIJaL+/xBjr6NFwc16d6rXtiP7+KFPAzLR4iu4pSThaX12l9e8z+Y4y2KUyPUI+NNCtUY7DzpXV7XRyQnkfH/U4rhvxhKuqoeeIHPGeyQOM2/uuuGfy3lZ7YmKpUHAqrNBRUezIFq0eVexhUZzh0WojTOQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 01:54:49.3203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82ecd4a-1064-4239-5fc4-08d6031b40c2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR1101MB1133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 Changes : Added Speaker FS gain maximum control(0x203E) register to volatile.
 sound/soc/codecs/max98373.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 92b7125..2764fae 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -520,6 +520,7 @@ static bool max98373_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case MAX98373_R2000_SW_RESET ... MAX98373_R2009_INT_FLAG3:
+	case MAX98373_R203E_AMP_PATH_GAIN:
 	case MAX98373_R2054_MEAS_ADC_PVDD_CH_READBACK:
 	case MAX98373_R2055_MEAS_ADC_THERM_CH_READBACK:
 	case MAX98373_R20B6_BDE_CUR_STATE_READBACK:
-- 
2.7.4

