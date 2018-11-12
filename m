Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0134DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AAE216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KINVMD7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AAE216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbeKLPYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:24:51 -0500
Received: from mail-eopbgr710055.outbound.protection.outlook.com ([40.107.71.55]:64847
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727826AbeKLPYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyttfU8y5bIYk4OKaX7A/lC1Oi9coxj8GT1DdtxTUAA=;
 b=KINVMD7Z6lsFA3icwJq/5pvrWBM4d/pJ3NfPdXfb0R+LC83fGSJIm/1o55pJkUE/GDJcLJzmUwibqZLNg4819wGUfjKC3/8gOtcUIYyeT0muMdGr5B9XaAvb9s5ve1q9Cf+xBXykoH7SSzvs3wsAJ+jmhSs+wDu7VSln88TiL5U=
Received: from DM3PR12CA0059.namprd12.prod.outlook.com (2603:10b6:0:56::27) by
 BY1PR12MB0423.namprd12.prod.outlook.com (2a01:111:e400:51b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.25; Mon, 12 Nov
 2018 05:33:13 +0000
Received: from CO1NAM03FT013.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by DM3PR12CA0059.outlook.office365.com
 (2603:10b6:0:56::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.25 via Frontend
 Transport; Mon, 12 Nov 2018 05:33:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT013.mail.protection.outlook.com (10.152.80.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Mon, 12 Nov 2018 05:33:11 +0000
Received: from LinuxHost.amd.com (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Sun, 11 Nov 2018
 23:33:10 -0600
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
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/11] ASoC: amd: add acp3x tdm mode support
Date:   Mon, 12 Nov 2018 11:04:59 +0530
Message-ID: <1542000903-19020-9-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(2980300002)(428003)(199004)(189003)(106466001)(105586002)(81166006)(2906002)(356004)(6666004)(53416004)(104016004)(81156014)(305945005)(48376002)(1671002)(478600001)(50466002)(97736004)(47776003)(8676002)(39060400002)(186003)(2616005)(476003)(16586007)(8936002)(126002)(109986005)(11346002)(26005)(446003)(426003)(76176011)(7696005)(72206003)(77096007)(51416003)(36756003)(86362001)(5660300001)(4326008)(68736007)(316002)(53936002)(50226002)(486006)(336012)(54906003)(42413003)(266003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR12MB0423;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT013;1:QCTV3wJVNU6W/QXzYwiDSXYENeRQVYXlVOKxiT7ShonDocVnoDO33m16InlOhvi2d3PB1FQCwSyrK+y/lTBQ08NkuNi+rW6igJpWL4U1+Dn61Nta+Le/NuqS4xfSDF0U
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9901ff04-5ba4-4959-aca0-08d648605636
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BY1PR12MB0423;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0423;3:DcJ//PwUD/NrGIwKcw2BFZEAY5di+vnXYxjhPNsxAUgxTIGVnbhg1SWTR3KzAzHwOHO7Xa04Dcg32mcuOqD9TUVtWZDsH0RFYXNcb8/xl9NPP0IIoK4O9FDgHlUvqgioo3XfTzM0U1n+OTOO3WZg8Ty9LqZSqZCbfPLXbe0aTGSr9FY8h0/BAr8pUVZjJPg/uC4eK5/JGeIMynpUmBFl5TCShBIlCSW/xZA1jx5CkS1OXWeEADpCSuabh4j2jj6frCvj5XRPS1Mb3xgsSMV/VnqmyE3oGucyJJZr5kKQAT4R2dKiLM1EGnKooDbKlmyxDEWx5mP0zZ7bDcEpE9KRq5j//rmwrHFURRu6tqPk+vU=;25:F+/+nfWXO+eZ94EG1N+alyYukL1IwmY/z8lq1WpAFKGxYGqiaEVqz/y6E1I9uiVna4coO/uNdBMygrCJqLyoBx68beA7pUj9Dxq4fTT0sGubKuVT6hysTryWbj/Wh2+3AOeUzPzeA3sggc9ioic1movzRc77vVu/IG/zBVlJw6HVKsMJ9HR9ArFUs7+4XlthRw6R4luZUXbRnSV4sOrNhOpZVHoqp03SS4lfe6CykMVxjOKEMbEVgg0jXEMdgYnPr/gxbbEUaPBhI21RyuNSr8swlvdlKfOg+ebhqj6LvDF4VlAG9uD6lKII3Z4ccEcR7CDZPnuMFCT6gtwXr/J70xPGtw4N4c4XqvJ3HSIOffw=
X-MS-TrafficTypeDiagnostic: BY1PR12MB0423:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0423;31:X9LTcMr8W6WTGRmVbh6uMp2TUpV7302yudjlXZpws/Hy0n+q6+dBgiIK//LW8pGlPLZVf/pMypNwuHFcM/aKSwYNkvuw5YRmXvIoIVdVna4atUsZhD7VtbSThqJUvAVbtF/+coBdQ1cfc+f5RSYotdaJkoGlSny32mB7p8zBbIzNS/spsipGnPGs6OfbpCA70EVkv8DQcCWU/4W4EMXvhyAAlVLSkbfXRaznYvdQ/1k=;20:LWGmrldHzZbacRtinWv00uhNobF4gbByi2ztMMMx+vvA0or1Xk+SVc9mSnQM++j0yq66qiamfOek3hpaF10Wt0IYQkFnpgVbqWTr7iO7SICxDvlJxHLUeeJwqG1RlL1xBr8dVPh7L9qptvOsX8BD+4Een75CEWBeKNaX9PQzubUISZgmFMwd3sIGhjj/YxDH++RGgkNHeiypP2nrIjcnAUq7CeYxx9PhcgKgnfzOFdyEBi1r7ovb+l3JSvbTwRVyrqHHieYwGpiMNOrXmOm6TBj46SJMVYAzorSeNR2ZKuNsRPdUeX2O/VTo0/eFypCDjsh8sr+cfdM+5uctwha/6MZRHbUkzeO3g0aIlm6174XHRpjixM3unjnBVZ1Hwz9Ta6fplfgvyPp/kWB8NQAXINsoryABzTOuELz61razYHwxTLOctiK+cKzBeZLGq5PkRm1KXAiu7gvspu0gauQ8HOv7AkEKpiF4sJDTKPdJd5aoUWZAKluFmF7dssp8IxCo
X-Microsoft-Antispam-PRVS: <BY1PR12MB0423D7A8073B72E37399B8E797C10@BY1PR12MB0423.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231382)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY1PR12MB0423;BCL:0;PCL:0;RULEID:;SRVR:BY1PR12MB0423;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0423;4:Tod3c+fdYtDX1cODvySOD3w0tiOmKfIG5e2bIVZ7OI4hXsVXRR0BWOrj4qtZv/Pi0ALrOKG08+N/nYlVxM6tgVM+C2JYTi/aFo0IeW04ubBoDTIHrOktsVvQhrSp9PHubhDgxrV8RLl4X9seuqkKlHfndaer92OtY1+exqo0Ap4gjLpiZs8eisvoLyb7EekM3XOVMUgwzu/aUt7XupH/g+2CnYm/GUEikHjv46LTTg/CQ689cpr+M5E7tR58ZAb4kog75hXODToFqoawiLh69wyZmpKH74Pm5jGNNPS7O/gbO11juLBEyvtepLW9rLrp
X-Forefront-PRVS: 0854128AF0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR12MB0423;23:6PAlLcRvqtN9wh+iwqN7xY770e+UPr2SjJnL/vKAY?=
 =?us-ascii?Q?ipxuQ4JXEq6QqgfdCQv43nSZEiyPchIOnXB+1DWZ0+Aioh/UFnwjYNGeZheS?=
 =?us-ascii?Q?9Usf1qXBdtwFCHQCLxndH7bjWROQuPSColXRCVGb5FUcPvXuYSYr0N+vd9gn?=
 =?us-ascii?Q?mVo/yt7rQj00RJ2e9UlgBnqOXL7ZTluiM1myPtkhBOf+aN/u7AiJ0iJKqF/y?=
 =?us-ascii?Q?gRlnvvnkDaFLMnolAjlwDcAADSTOhcgJPOJTai3ENTnQ0u2DO+5uUEkPQWN1?=
 =?us-ascii?Q?DLjbcrA830tJWQuUYJ1iggToFShhNJ8SmAxqEWELfxvwtAow++4mfjnkgS4k?=
 =?us-ascii?Q?FGUfPqkxwbT0PWbNTk6oLZEVriCkKnm2+/NpyyhAywrkhACc1xUyujFK2kfF?=
 =?us-ascii?Q?qCHh0I7EiI4qeS+Q1ogyYSzTZGGTdtMAPuQYJ3px7s+Jq40U6ltEt50NLOkI?=
 =?us-ascii?Q?kWo/p12ZBocRmzrkPauPOt01WoR18BSxSmhSB2v4tysNTowA2bKOrEf5FhCD?=
 =?us-ascii?Q?biV9VeaDUT1M8qcheAUDBjL/XTLWF+PdBh0B0kKgA0ZjDx2fpUYNlVebtchw?=
 =?us-ascii?Q?9O2EQYAauLqdgMN59Vh+o4CI3LAHwVkSp0O5UlrZqaARPKEc1h7hoJn6ixia?=
 =?us-ascii?Q?BVzojwBW00cO7589/oM1Bn7b5/lXCauCmH8Lqs7xmAvjPHhiL/eEW8P/ZECL?=
 =?us-ascii?Q?6ZN1qli8n1+faAdixhl5gr8OmbULtsi5YSvWadLPN/nkCo8I2S43yoRlVp+B?=
 =?us-ascii?Q?J2RGGUVBjxq71Zx+Aqg3OnOQB8T1JpIGPHP4DTWunAf0UM3siUeRswUuuYie?=
 =?us-ascii?Q?83+I9eSyyOwVsOhA1lzgqh5ZL0hArt7ERjVBOA+65nZssQuyJLNuDJwnQ1SJ?=
 =?us-ascii?Q?2/axuBvMGsQjUt4KB5JIUKDkm+yoIHwChXoYF0M9JAhTAaS9s7Q6gfSF9odE?=
 =?us-ascii?Q?QhBSwAQAZ6hZp0qWsizQ54tq9dVynzRhs/3RGY3ksFuV1t3fI+86ADkUlxUs?=
 =?us-ascii?Q?er66lMrSI9CRmaTYOVleopNQ1nf5lyuxIbJZXt6SVNKUjqpw8YzyXg9vIEwP?=
 =?us-ascii?Q?AcM+2JwHsguqDiLFDrQCNReYDqOapJBQdkjlAoSCP6N8wKJxbICgG+pWHGNu?=
 =?us-ascii?Q?CSkUW3eyI5g96t6Zv2/yCqGwxxs2SG1Gn0/iCWfoADxfvTIIhK6q2adf0VtD?=
 =?us-ascii?Q?gHLoXz6EbAtSCN4HcteoARFvM5ftpDycgI3m77+NV2BGK4Sg1H2cRscs+zLq?=
 =?us-ascii?Q?SjsBApmTolyWSkRadRURBY3jpPwBCuogYOfgLXl?=
X-Microsoft-Antispam-Message-Info: nkZCNi2Y0oxKiqbaBstAjQX5aJONpZ9mocH/cuj6vpb/tc9z+oMavavxJzNdflN61NGoYWNj0mOX0CJ45odwlcdtAVtBF2G9LOmW0v3gqIBNUfuogmGvHfhYjS4g4eDLvLE8t7JmGwZr5kLFN8ig6x3VyfXfetVQz8NgcmGwhqgjPFbDb94uUJ1LR7k8s17l+wuWTyqFBWfIvgRLajXNk60/UO1wv8kFe4BIu1AUz4vAatTDa20NzSkPbnFEf6qoBGLrotogthYSDTtJ24C10AGFaXY/hhK2wdCCJOCjeF5w6eoMW8HO3MRT0QhkHX1uj9i9HM2txCdGaTAy2fibzt38Ho7mTkso9OdImBnSLS8=
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0423;6:7AIeUTH/1PcKC53ZU/1J5Gqs/TPhHUCYiAcRGoH7SViQq50TvjoIeY/ctNmQu0TYSs4jTXuhLxlWjWEGnxhHxWe646nEwfmprCAMap+Qf/3u3ywBUj3QmToGQ75LOabC+tfa2msWR9ZVb0rTXi8ds32eh1llL7aoHoBXlz02X5ACucemPOFEPogo/wwOIp7e7rdn9QVTVYKkA1PYmLqxFDe0RRz1/5ceiCUk7l2RKHbDNe5ZUb61djZny7f2e0oQCI1oBLDQuiJ1EUupesQ25qLCJAPO5Yy1CkuoERcXekJUgigUue4Crrlp6IAJ4okP9ZF8lOYfChV9MB7Rq+pqI7NyHZubC7ZaCWxw7zYLaOUuutPzRnKr2xjnKcxc6WY84kyMYQeQIzFNJMdg5dOF0FISOVQ1s634wWNWCp3i1xDLr9KQ0fNlYzfb49ovSsUv+2begPjCeWFtcuPzj209Xg==;5:HMsI24dvaaaN7GmMRpfRl4sdX9CNOqKIj+7YzYCTGaAIP2ryZCHXoIYoVnoQTmU3OI6y0WrSl70RrIv9VLEZclQjmz13cvrDM/XIm1AHE3zGadc1B2viFeBAUoeb9PRZPXYby/P5Wv7WCCixngUbFiPsqip9al86u2M8g3hN7dU=;7:aFVC2+E25wD+3KJlHf7GGEGt4JAZjc/1kN7D+nLFayqwNFEWdFZx7r9CbrVLpeZEzE6n4rZqgtflFavYEaUj3BR4dEtatL7SiNJdyPSG3tBumsiy5rLiq0N08D2gEdLy2F7BeZmYpHHXgNUskn5QjQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR12MB0423;20:ZuLvle8aSeNV26qffgnlXlSLFkoOcEAtTjlNEbc50Imzx7IdMEAgtgtq9LS62Qq5cTAnZqUSeVRuHJSE3fwsy+HQpp4//Tb5KH/mjstr0tnSbbe7roY7vrP1C3313aflTjS9gMeKXebQ4ZnqGvbyKakyXQUw1AWUKr6XOWN0rwqgm/BOBetnXcaMAXHOQS45xjQ8oE+eyh3D4RFo1m6TjoqFnybcCC4EGYJMB9hw16jXxlk/8B5blX+yp+8GX22/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2018 05:33:11.6550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9901ff04-5ba4-4959-aca0-08d648605636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB0423
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP3x I2S (CPU DAI) can act in normal I2S and TDM modes.
Added support for TDM mode.
Desired mode can be selected from ASoC machine driver.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 62 +++++++++++++++++++++++++++++++++++++
 sound/soc/amd/raven/acp3x.h         |  7 +++++
 2 files changed, 69 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index ed2c163..15a5f3b 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -27,7 +27,9 @@
 #define DRV_NAME "acp3x-i2s-audio"
 
 struct i2s_dev_data {
+	bool tdm_mode;
 	unsigned int i2s_irq;
+	u32 tdm_fmt;
 	void __iomem *acp3x_base;
 	struct snd_pcm_substream *play_stream;
 	struct snd_pcm_substream *capture_stream;
@@ -423,6 +425,64 @@ static struct snd_pcm_ops acp3x_dma_ops = {
 	.mmap = acp3x_dma_mmap,
 };
 
+
+static int acp3x_dai_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+
+	struct i2s_dev_data *adata = snd_soc_dai_get_drvdata(cpu_dai);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		adata->tdm_mode = false;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		adata->tdm_mode = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int acp3x_dai_set_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
+				  u32 rx_mask, int slots, int slot_width)
+{
+	u32 val = 0;
+	u16 slot_len;
+
+	struct i2s_dev_data *adata = snd_soc_dai_get_drvdata(cpu_dai);
+
+	switch (slot_width) {
+	case SLOT_WIDTH_8:
+		slot_len = 8;
+		break;
+	case SLOT_WIDTH_16:
+		slot_len = 16;
+		break;
+	case SLOT_WIDTH_24:
+		slot_len = 24;
+		break;
+	case SLOT_WIDTH_32:
+		slot_len = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_ITER);
+	rv_writel((val | 0x2), adata->acp3x_base + mmACP_BTTDM_ITER);
+	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_IRER);
+	rv_writel((val | 0x2), adata->acp3x_base + mmACP_BTTDM_IRER);
+
+	val = (FRM_LEN | (slots << 15) | (slot_len << 18));
+	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_TXFRMT);
+	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_RXFRMT);
+
+	adata->tdm_fmt = val;
+	return 0;
+}
+
 static int acp3x_dai_i2s_hwparams(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
@@ -510,6 +570,8 @@ static int acp3x_dai_i2s_trigger(struct snd_pcm_substream *substream,
 struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
 	.hw_params = acp3x_dai_i2s_hwparams,
 	.trigger   = acp3x_dai_i2s_trigger,
+	.set_fmt = acp3x_dai_i2s_set_fmt,
+	.set_tdm_slot = acp3x_dai_set_tdm_slot,
 };
 
 static struct snd_soc_dai_driver acp3x_i2s_dai_driver = {
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 9f33e34..95fef85 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -32,6 +32,13 @@
 #define MIN_BUFFER MAX_BUFFER
 #define FIFO_SIZE 0x100
 #define DMA_SIZE 0x40
+#define FRM_LEN 0x100
+
+#define SLOT_WIDTH_8 0x08
+#define SLOT_WIDTH_16 0x10
+#define SLOT_WIDTH_24 0x18
+#define SLOT_WIDTH_32 0x20
+
 
 static inline u32 rv_readl(void __iomem *base_addr)
 {
-- 
2.7.4

