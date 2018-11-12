Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F96C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4A1216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 05:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ucXvMgVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4A1216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbeKLPXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:23:10 -0500
Received: from mail-eopbgr760073.outbound.protection.outlook.com ([40.107.76.73]:59296
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727243AbeKLPXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve7ha8JTvwRfncF26SouVXgKXq3YhF3UBZR9W3pt2hg=;
 b=ucXvMgVFN2TVAZtVjiKyNe5ujSz9f4Kavj+IIFfROCpecroqpeJeNy35WyrzfR4aLuecEK6J88IEXBrnbg6QY9upLcH1nIk/FemqRdSOl5BYgly+DvfHQ2/HLtb338Sz9aZYG2Ezctz4Co+MGxfISlePWt8qLMD2WjNOjgA0Faw=
Received: from SN1PR12CA0093.namprd12.prod.outlook.com (2603:10b6:802:21::28)
 by SN1PR12MB0622.namprd12.prod.outlook.com (2a01:111:e400:c428::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.27; Mon, 12 Nov
 2018 05:31:26 +0000
Received: from CO1NAM03FT008.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::203) by SN1PR12CA0093.outlook.office365.com
 (2603:10b6:802:21::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Mon, 12 Nov 2018 05:31:26 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 CO1NAM03FT008.mail.protection.outlook.com (10.152.80.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.10 via Frontend Transport; Mon, 12 Nov 2018 05:31:25 +0000
Received: from LinuxHost.amd.com (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server id 14.3.389.1; Sun, 11 Nov 2018
 23:31:24 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC:     <vijendar.mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Sanju R Mehta <sanju.mehta@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Subject: [PATCH 02/11] ASoC: AMD: add ACP3.0 PCI driver
Date:   Mon, 12 Nov 2018 11:04:53 +0530
Message-ID: <1542000903-19020-3-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(396003)(376002)(346002)(136003)(2980300002)(428003)(199004)(189003)(356004)(6666004)(106466001)(105586002)(2906002)(53416004)(104016004)(305945005)(14444005)(50466002)(478600001)(97736004)(81156014)(81166006)(48376002)(1671002)(47776003)(8676002)(39060400002)(186003)(2616005)(54906003)(126002)(8936002)(476003)(109986005)(26005)(11346002)(446003)(76176011)(16586007)(426003)(7696005)(72206003)(51416003)(77096007)(86362001)(53936002)(4326008)(316002)(5660300001)(68736007)(50226002)(336012)(36756003)(486006)(266003)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0622;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT008;1:ypfJPxKdblJn1Q1phJxNLhPeLOMKfvplB7JQZCLA/8d2S2Ay1pmKUlLiSOVGEWZjuDBwTZxUATErDELLIYJfaW0tCd7soOjflwXSviu8KxOCf+Z54I7AtNzt5k2CNLaQ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38c3169a-8aa6-4594-2431-08d648601720
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:SN1PR12MB0622;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0622;3:oLj5kI8lqGE44lTFeAOtOzve9qaJUHBDysJjfepJgw9Nw6hBPsvdn+jog1ENUTSd1V+12ue5cRxjOwKR5wod22UMuri6Cln6uunlw5qY7TCPgLGP/JzSYdT0jalcodojRSRMWBvQZF02vmNeajDBQULAnf0zNhRzkIrEOPNvuzfzRSBsfelfoROuf6yCuFlpMvgWuygd29yAETtMCzfRv0wIYnU1zH2LFIdPpDZSkU5wEB4n+U4wFUtpYSVCj6Xg5R4MSevPcS24S71LOv/Rxq/+yraeU7XloNOAi7+bfhGxH3llzFFqvan2uTlT72uqU8yfGPZKMdhBF0cwrRw9z+nKuenn1zsG8qz63FNzFd0=;25:pJkXCoi6YANrhIxrQLSjcnnMwKh5Uzcoxy1De0h1YXq59K/gpXcD2/D9q9DiMWn+Yge1idX7xR5hb+fwjZs5r4T256dG+duwrxGs1Kh1vS6MLQ7DMGw/BzvG+G0/HhxO9vb/+HXB3cBLiflFO30QDFyvH5KB7ppYuno2CubWRf80RQ7x9kvIQsd1BxrHXvmRnedorIm0+y3jJAqO/pPWE0krD9e8967WSMHnIIJ6v3G/Bm/3WmgJ0Y2BNIoYLp7MX3L+XowZcFBkCA3ytqxu6om7OovJO+3Zzu3IfcqQ7LVfHZzr8x5sLN+nAoMUkKd0/Dr4FBE50zlIItHQv6fkoI9BelOywV2tyQ60lRbYDwk=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0622:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0622;31:HfDBiqvNhCsUounMhRWH5RuJfTR9IARp4tWgRmJrLlUhz945qpAeagMafBb/S4gz8nmmHLp4y7fuCKQbmHjluiUTFdroxSAuvXtvPgj0uZzfY22asWByk8tvLztqB04U1Vvq9kFpMhXa53M3ePZXZL23TdY4QwcUcHe+gO7YzX7PyWMaWeWx2kuKVXMHLayhpuZz+GY1nJP9zRoJNqDxz1EwOhYHjDg9qSAjGr53zdc=;20:gYd0vWL0bxReBtR2zXPCfC+WN8jQ4engLs/ntm2Ed7syEAqttHfDAw61hXa8+6GClBF6Y6lFvHCSoAERa9f6HhFWdCh26TQY2TLx46YoPHeY+phN3pUv+enSRrLdS/QVkENOFAatAl+9SvQ4RNQPmXr0GN2vGukAk5fcgp1c9K/5SzYfz7t0QhbzMz3fGfAstxdYTOdnW0BvlD3aFAJYowJo3UICFzMR6KiiLWapiVrkUZlyJxLhUPbxnk+UCBQ/7s5gnW4wjpIHDp8DZ6K03mB72aKONHYQiurl0Uu89frSHy8xiKMhd8pdRnp7eRgyGq8tHncEYRAdldIV+n7LE86uF6xNudSslqEj/XX5IWip0UGhNmEzh07p2yxbgiVSA5gkb3orRzcn0voli4OsaGZokqQuQdEofiJJAqsL9fGI0t+Jfbgi8a/HQQaA9acYuvZF+S3HMoPWZjNlCaPl3i4oktKfawqN075KwfGHOH2mPdm5wVHtY1zFlQwpXZBI
X-Microsoft-Antispam-PRVS: <SN1PR12MB06220F455764F86A746F2C6E97C10@SN1PR12MB0622.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105112)(10201501046)(3002001)(93006095)(93003095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0622;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0622;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0622;4:pP4ejntTqRBr36GbZ1p3zSur5GLmdNydHAkxy9C2b4E5QPQ9ZmAsb/iZe989ApDRzR3xPK7fLG8whBnCL5wAPjeU8o4FqfsW/QBqVH/qxgmZaOySfu4QUDHlEG0BZqrtrg0LIYjg7nSvetof6dGJx/KY+FSVhwhgcRu2aZ+kWodszhewXXLCQpynJZNUvRFV9P0wXlVFOsMsB142RHJ3vSmz81FC2XQt2YGKj/DnxKSYYy/aBp1YHiFdD5Fgp5vuocJVmBI2vAOKzki0LfJsF6OnH5lTD4FLclUNZVtQ1LNX+Hks6HMlHXqR4tnhyE8U
X-Forefront-PRVS: 0854128AF0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0622;23:UgQYLol3JRc5/N/bACve/WYVU2gDIUKa6AGu2YMbm?=
 =?us-ascii?Q?TUjIHiYaXBZfW3sHN/wT4rM2u67LtAmWPw/vO4VRK4F06EnSiqWFDL92kQqf?=
 =?us-ascii?Q?+9ZDJp8fma5V8QDlS0vXIH5fUaSVjRKv27x6zoGAFe7y0+P7t1WNACjbfcKv?=
 =?us-ascii?Q?Ha9juUvmuP0KWJy54MskWlR8HOxNKnPTRL+3I7OIzwpLtQ6a4APHlHSiYtUQ?=
 =?us-ascii?Q?I7VnpfPn9k2LzfoXYWs7Sk35MeVWmxQjMOcWT/6XKybcRSJk/bwo0Rk2pzrU?=
 =?us-ascii?Q?/5I0EdzisCtVAYnT3ESSGDg6hg5Mi+dZ67m+H4R984Bj235+mq/mUGxDilgJ?=
 =?us-ascii?Q?y4P26RvlNcJyPTF9vGc142dMvmgWY/F5gXoYb+XOlgq/R7pvCw0EF0KHB1U3?=
 =?us-ascii?Q?uTTDa40M8mMAWXa0bY4rm0IFVJ8uM57oFRH5KANtLXLjoDLMg65jO0Y2eafl?=
 =?us-ascii?Q?Ikipr31a7OnOAMWZLjyxbvIdvA5auFq2Kll01zDnRqQm1/xomGPAwX/oHWTA?=
 =?us-ascii?Q?KrX0td52DZnPMOH9NB4EbM6lRKbVBksyOXVTc+2s0Dpqn48ZOnX4oH/gEp+B?=
 =?us-ascii?Q?A2yc6Fm2vGyuYjHyeKrytnCOfVVxbfTRErccKRKBO3lvfdUYw3wPjrUhDyCO?=
 =?us-ascii?Q?QlwKtRDSeBxWfL4jDw7tBGXgqZEbNYFfCERg/TT2XoHPQgAm0+JhgcoVCzCD?=
 =?us-ascii?Q?ECAZ37oN+g5TLBzq0mjH0Z2srfusHv8kARKi59qtDxLtk9Gk+IdyxpIfQq4y?=
 =?us-ascii?Q?RPhVzvfDgZa2EnX3z+wy2xAi7p45IVSA/P5AB7LFVBok19oc8VZ5M6OwjOsK?=
 =?us-ascii?Q?5hn7CnwM9/rGYQCCNDFRp4e5lXbXSVIsMt7xIqPKFe8kbmGypGfnJPyS4XfO?=
 =?us-ascii?Q?dMmIaj8KOjYLYhZPSf28Bc60oTXF0ozuXGOU0inRt4tzMcM0eClbyInv2uac?=
 =?us-ascii?Q?iiCp77oJAgK3N0XxTaa4P58OEU/ixvNu/sakjMD+OzzUEnixcnX8VlydfaCm?=
 =?us-ascii?Q?IdJr9PfCaMCBHMlZ5w/qEKThlVKlbFKKKzJCm8UnGMjbMY+L2RoMW7Nmsgx1?=
 =?us-ascii?Q?poZSLLIjnaOTKzwTrZc6Wkgo8S15443zXfC6Imu1mx/RJO+RyRG0hhIvIUUQ?=
 =?us-ascii?Q?pXrwLWfJy6GOfDc6YDNYeDohnKFOJPbBqs6FUv7xKnXtNSHx81FVLmS0eLnk?=
 =?us-ascii?Q?SRQHe9il8E9QM0nde7WRy+JjdiBdiSuJY3pZZWYYkO7FMbBl5H8+4SVPaIuP?=
 =?us-ascii?Q?j/k024KxUotPz6dS+s=3D?=
X-Microsoft-Antispam-Message-Info: 0Jhgp+hDenSQ289ephNMrW8ibqBh5SHhcnFIqCmqiSaORaGO59aG+J3626QNEQd2sSN2sbEe3kKuZ8CPx+WHYTwr1/VBzUVMLBcyO1o+Fb9dkY7mKG9UqleOyN6rW28l8331/P+4485gpK3alUWzhi4u+v+qjvQ1f3+2qzFwIND903tszyzUVyGxEXzeEj0/x0Oa6d7KClVohAgvHnx0G6Zqlig9aHqDRazaB8r+4ecyfKtinQtwHGp38naDwpoI4NE/tyAQhXixEKtwZN/Nw4aSIQsep6PLptHy2W7GYdbiBqopySnH07A0gk4Q+u+tjbgXFoEBZLLH3NoXBjErM0Pb0BjQldG7deW1QM+IE5o=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0622;6:fY/q6QnGMKt0+8fQjiWCWH8sogMZG49QV7UaQN8WS5zXuS1Zs7Pq3bc07uJFN0jPhJ+n7wUI0nEyckB21DWVqMBKgTM+r2edciVoWsxMzmiAjp5lMaZNyf1NQ/7eAsA3FmxMWmJD7/q/isfTe0LHPwS7ps7rIXrvAomzPirhER6VZjPpGexbJ3Oz+zx166GNnHRnP2Kq1inWof8gNIbRo3D/4on3akp4n+U5GRrmT4N1YKHd1/0IWk3m6IwCfOC/gGpLan9cpazGYjhRtOF9v+WI4HUWGkC5pAyzPMYjhwgC3htU5q2lvXxE15ivwd0kpfnWZFnVlv/YA1wEKQjIlfyvFcoSFA0G3rcFJKUN6pXYV668H0ZS/0sZXRkOkuoz3HRn4TADzEe0wHJBPe+3Gd01gtYlPZSLU38ugLVy9tuBKePHBUXLvu5RkCPIrBzFRjcNATWSlLpWhsviJIMlwQ==;5:DAeqY+FYOrdWhoLhSCGLLroVIbteZIC90Lsf0z1RM+TL4dPGUSIP6r+l78hSCdvL8UaPaN9Zkhzrx7TfhYWMm4FeOqETg2DIB1YOOwkqwQ20WmKDr9B5leqYPTWuD1DKrBSwvtrzh0AFVfWPLiZfT/RwqeUV7Bi0eMrSw1rxTPo=;7:ANrJrTYUgQTikMvc1QGZvM4lVf2O7IXOdie85lYRwpxrQ8BHKnodRz8fSsC8YfarvbmNW9qbROGNyxL+OSDp4pXfJH2IhuW7NxHCVvGx4SBRQv7rOXNwUDll2QcAEb9r8ox7ImIYmfHiv5rz9EkM7A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0622;20:pWbnXE1RgZDjkAvu3ghAKo/aMznuBJJqnD/EL1UY1ImP7+uPTBasKyTNYlGsxYzd4yzrFKOLnzXQhkGYrW0k7ENhhc9Nru3WnB3tBd6GKEhyaQeeloqGzkA5SwnOiU7rNOaO3HdgDBRB5w/wDmdL74o5x+Xq2VbWwKDE31owjhokV5/+m1LwwUUeZUJr68+fJEhM2p8mkbrcOi0yZHpFrInlCYp+0tWDewi4XYLR4T4fFE7yFJhS9hoH/6qKtOgw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2018 05:31:25.8109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c3169a-8aa6-4594-2431-08d648601720
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0622
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>

ACP 3.0 is a PCI audio device. This patch adds PCI driver to bind
to this device and get PCI resources.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Signed-off-by: Sanju R Mehta <sanju.mehta@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/raven/acp3x.h     | 13 ++++++
 sound/soc/amd/raven/pci-acp3x.c | 97 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 sound/soc/amd/raven/acp3x.h
 create mode 100644 sound/soc/amd/raven/pci-acp3x.c

diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
new file mode 100644
index 0000000..e9b4df0
--- /dev/null
+++ b/sound/soc/amd/raven/acp3x.h
@@ -0,0 +1,13 @@
+#include "chip_offset_byte.h"
+
+#define ACP3x_PHY_BASE_ADDRESS 0x1240000
+
+static inline u32 rv_readl(void __iomem *base_addr)
+{
+	return readl(base_addr - ACP3x_PHY_BASE_ADDRESS);
+}
+
+static inline void rv_writel(u32 val, void __iomem *base_addr)
+{
+	writel(val, base_addr - ACP3x_PHY_BASE_ADDRESS);
+}
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
new file mode 100644
index 0000000..27588ed
--- /dev/null
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -0,0 +1,97 @@
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
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/io.h>
+
+#include "acp3x.h"
+
+struct acp3x_dev_data {
+	void __iomem *acp3x_base;
+};
+
+static int snd_acp3x_probe(struct pci_dev *pci,
+			   const struct pci_device_id *pci_id)
+{
+	int ret;
+	u32 addr;
+	struct acp3x_dev_data *adata;
+
+	if (pci_enable_device(pci)) {
+		dev_err(&pci->dev, "pci_enable_device failed\n");
+		return -ENODEV;
+	}
+
+	ret = pci_request_regions(pci, "AMD ACP3x audio");
+	if (ret < 0) {
+		dev_err(&pci->dev, "pci_request_regions failed\n");
+		goto disable_pci;
+	}
+
+	adata = devm_kzalloc(&pci->dev, sizeof(struct acp3x_dev_data),
+			     GFP_KERNEL);
+	if (!adata) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+
+	addr = pci_resource_start(pci, 0);
+	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
+	if (!adata->acp3x_base) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+	pci_set_master(pci);
+	pci_set_drvdata(pci, adata);
+	return 0;
+
+release_regions:
+	pci_release_regions(pci);
+disable_pci:
+	pci_disable_device(pci);
+
+	return ret;
+}
+
+static void snd_acp3x_remove(struct pci_dev *pci)
+{
+	struct acp3x_dev_data *adata = pci_get_drvdata(pci);
+
+	iounmap(adata->acp3x_base);
+	pci_release_regions(pci);
+	pci_disable_device(pci);
+}
+
+static const struct pci_device_id snd_acp3x_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x15e2),
+	.class = PCI_CLASS_MULTIMEDIA_OTHER << 8,
+	.class_mask = 0xffffff },
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, snd_acp3x_ids);
+
+static struct pci_driver acp3x_driver  = {
+	.name = KBUILD_MODNAME,
+	.id_table = snd_acp3x_ids,
+	.probe = snd_acp3x_probe,
+	.remove = snd_acp3x_remove,
+};
+
+module_pci_driver(acp3x_driver);
+
+MODULE_AUTHOR("Maruthi.Bayyavarapu@amd.com");
+MODULE_DESCRIPTION("AMD ACP3x PCI driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

