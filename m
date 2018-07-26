Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F470C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D59220673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 06:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tnsv6MrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D59220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeGZHUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:20:13 -0400
Received: from mail-eopbgr690061.outbound.protection.outlook.com ([40.107.69.61]:4136
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbeGZHUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG1ZZf8rLVqNhDnOOr1dDVU5ZkMonhDv17lSP5CNVPM=;
 b=tnsv6MrShRlOph17vBYLexheZm5dFTNb/yjUy6AuLjG1Yn1a7ZSeU6DUe4K36hZnTgTyZUADGR/fqGpZ0l3aWgIryKkXX4ora9X8UjRamZ/aLhsO7Xr4Jvj84LLZwXmXGnI0/olR50DK/Gxj2+BXxxK5atb9/yRpZT4jPNqcGgA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 MW2PR12MB2363.namprd12.prod.outlook.com (2603:10b6:907:8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Thu, 26 Jul 2018 06:04:47 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ASoC: AMD: Fix build warning
Date:   Thu, 26 Jul 2018 14:04:08 +0800
Message-Id: <1532585060-26060-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MAXPR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::13) To MW2PR12MB2363.namprd12.prod.outlook.com
 (2603:10b6:907:8::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f52bee72-d176-4b86-1f66-08d5f2bdb602
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2363;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2363;3:17Duc7+uN2yNpqkDz9P6VmOi6WY16/b0cu4Z0Y61F6qJbUgg6DU5RheB74sGCrtDmg/1iOhPW0lO1j9t6LbB5Wi5BOWwQ+DQW4HMyQS8lXXYOuQD/ACE0AJQvD0GTzNK/39b8uJKkWZeIoLx00WJZMW05x2gUVqxUoDWu6Puqtve9O0MNzQ/TZOPYjqvxCxWvd0yzmyVMl7EWCrAQNHXWEH0NQT5RrTP19m6J9PT0SjbuOqgM3R1XmX9EW03IgFI;25:BGuPnUS0ph5xmvt7FPA13G1klrvFA5zgR4Ui2PnoVfGsIWus3GajqcM0j7RlMPlxx7CxpU81WjOsZ7hhw8iKViOX3/ZQsoAsnlkYPErYd893Tj9CaPQKtjrnDS8/59WzlDwzFEVNIuVPgxp7JPwi/iyU1ICGhUgTtslglw1ONqLrB928J3Qeh0lAsBt3uDGCfIFQfkubwma35+/qRkCTJhx8mfUYCPpbhbxOXvlcm43RmNJghqkpDGv14yGV3R99T7S4zr1Wp67StEMuU4CR+XhjLpQnaZbF/jgmLK/thAix0ZIt63EWJ0VS4mCzC4McVytFPvJ+6XFlTEBRDdkjZQ==;31:u1i/vBjzJi9fw/kVxFsOsvKu8JKXjO0VkDuS8BZFfPUE0oNK+KGfPLFFneoUlHAC1Vx8YBUYwKoiTlIM84pi7bifgc8EugrY7i8IjJe8Lb8BmPAPmT9aLu3Dm58+II591quMAmplOx1286YA5CMiY0NufE0CHVMHqx/tt300LGW0diZPl7p7h7qeHdmzc1jtvRGp4zvQniQB9bFX7cJ2XZwto1R5Z2tetSZQvfeYEig=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2363:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2363;20:ExFI1L1N0Ct0EsousmYPYc78F1ms7V92Fd6ALo/RHGdztcItCqFLBOeZF0KU5Y5Uy+m2RqiiQIk6QL4s3g/RgwCyK91Exi49bivkY/gdS/AsySPQlDtI0bCL+MkGEM7A2Hfa8LCrprlT9GICaDsnCaAyXjhSiegv452+xARNUGSjcfj35qzPWQ2/AMSJf1UpRXZJrMRgWHhNofUlQ6+s1KTheshIjitl7qQHTURv5RMSGuUlWeICQTjRl/92MUOBCvh56f9/LeEYFDaTgla66wyOeB5AaiCq5tHOo/DPQo/yCsKVm4j2g0iOJXarsyUFKClY9WAlw9LgU9tJf7cjaChKQ4WBRXUsNfkyCG8uJLVOLvpxwjnmHGDdwNyj18mpLjdR0AdnjPvU9bN6xx75t1ViapFxJktTaAfcIt2cZmy67SZwn03ZCxAfsK1UNgrgRH/MHyaOeeIBl2Zlg8hgYcz5g8HoPCH0oErjodJpgseHPUnW9op4NFAgI7ncMS1e;4:ZI9QPtOtvJw6URB469l8eDk+mmH7h1NguRwGDRjXgdYVZAWQeVKINAENGzjJTq+s8ESCj4A2VFr6XBszh8Esyxnt8fahk+gtAUsBGsJSAOd3kcmx2PGIdDNivytz1F+n0sRWp4qTilThEzZIjq57XpnDfH8zwnzgZGV5KTPORUd471tjqH1hw5hlYLxTsFVQ+H6wgr6rhitVhKX2aduNu/SeYe+Np2COKA3isIb0KB4Rw6XX07e6IHc0zEuuIuHzvvpwQOy3RY9vnPvRKxmrSQPT2KvHhd9QLspr20DmiaiYRdscH1Ya8ORTngfNUKFn
X-Microsoft-Antispam-PRVS: <MW2PR12MB2363CAC734212DB6F61CD0DDF82B0@MW2PR12MB2363.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MW2PR12MB2363;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2363;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(8676002)(7736002)(50226002)(53416004)(26005)(109986005)(386003)(51416003)(7696005)(25786009)(5660300001)(52116002)(105586002)(16526019)(97736004)(3846002)(4326008)(39060400002)(6666003)(2906002)(6116002)(36756003)(6486002)(1671002)(81156014)(48376002)(478600001)(106356001)(53936002)(86362001)(72206003)(68736007)(54906003)(47776003)(66066001)(486006)(16586007)(44832011)(14444005)(8936002)(305945005)(476003)(2616005)(81166006)(316002)(956004)(50466002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2363;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR12MB2363;23:ye2B60ZoOoK2OPSoMY7OJzr0MViFB7Ja9YVc3Apug?=
 =?us-ascii?Q?WKFw+15zXadQIDshbm29+CinuN60uVQvApktTCZ/W4lV7KGLVlcgynHE2jgE?=
 =?us-ascii?Q?dvSrGhivgdSvSCiArKPVXfsZW9p0ff5Yu3dsoiAJe+OiKGLdMhS3viI4Njd2?=
 =?us-ascii?Q?LDik+DDCVhx7VgAsC93Kh6/NxbFaA2sZtchLpKpWxKJfblbX/is4kNnMCFJN?=
 =?us-ascii?Q?ijet6pVSGyk4ehUFy4D4qNsx1hebPufSvsLS4XKvgqzzFilh8prXQmoGYhnD?=
 =?us-ascii?Q?sBHkJB2sCiAH4WPOH9/m7cPb4yyVJi87jWUsaRNv1qSXZvRdd6Ns5vMR9poM?=
 =?us-ascii?Q?h+8ACvze5tSsscRNKaIyZGoqWtbJK7d4ZI5L0xaoV7P4qLBnqpjQIaZUYk5I?=
 =?us-ascii?Q?xu0cZp5CiV4ByBhDzSKOXKftRHE9fotyEjGdbeXcTMsdzkcUDPw7ojb/96Wh?=
 =?us-ascii?Q?zd70hO7WVm4fwyjv7ezOu8rTJVnoew1BbEB+p/E+0g5y0/X9lg+VclV102ap?=
 =?us-ascii?Q?Yp6s1k2XTE31pCQBA2RONajadIkOUwAKbUjIDRFiGnsW8aWn9JCjlzt8H8Va?=
 =?us-ascii?Q?5Kt9iwdnAOrbGAnN1B3tXa2bWbRaxChkylRWxES1vAKTeaOD3qYaRIDjZF/I?=
 =?us-ascii?Q?poF5fOFXavig6Jih+X1dUAzwHHIScEeRNow738i52WHXncjUdwhF076dyjPq?=
 =?us-ascii?Q?X1GG+2aIDhpQfe8pDti29eGdNxQuG0UlBRDnhQwV905qm724CuTmGcZoVrPo?=
 =?us-ascii?Q?So/ESru2YubZBi61vDBWXLPD3cYpS+s+KR42YTJEW7mbWYt9FKNYDETtpAyn?=
 =?us-ascii?Q?0Yp+HK65x5L622XPDWil8nHoZwj7mvCX1YLOLSwdGb5uSYHDqUDBJ5P9bVDz?=
 =?us-ascii?Q?eEA03Z7ctL+3Xexp1pJ3TxO//P8QbV0iVWSl4k+RkSixKQ8WjoGyoLjWMpxu?=
 =?us-ascii?Q?rnwe5LUEYFYBFOF2d+eot8xxv6+x1bxtmv1U0XynN1k50EwvdiuqHpfm5eqO?=
 =?us-ascii?Q?+T+qrtpIrjTQnhgrYpzqh+NhOU9agdIbdyxwmmmQZ78Xa/tMQFaU8Y+NOxWC?=
 =?us-ascii?Q?7Jp8Cqz/s3PuZsW3RHa3aybYwFSLHMSGIWQ1Yml2/GZ9Reio577ddlhpdckz?=
 =?us-ascii?Q?0OGJHysQXmk2G3TcCiIShsY7HIsHGKqykj2YVoo7zkFIpgLnu7CO2UMCFiXJ?=
 =?us-ascii?Q?F5kgt+IIWZDDUN/GfOPPYl/c7kE2ep8NALMznivjZbhP4/wkwH7DgMjfqr6L?=
 =?us-ascii?Q?+PDCK1KpudC501yBIc=3D?=
X-Microsoft-Antispam-Message-Info: S6Wz5O+LkdK2Xn1kR4T9ks+Bi3eAB6OQxHnRTNxij+iH8cGt6piMjB3ZtmD2RIarOpxODba3dG4U4FffWCePAYD0SuhdGX1jzzSbjIFC2abTs88TPyqCWJ8exH7orDu7xEmUucX4ORonRivGqo1AhazdQ3RZrwF1WLNsdow6jfAg2CTmbkcTiSWO1aUnPTEP/ijQ9G2yyunLhSJGo8klBCHG0NY8BA6emUtRsFcr6fISTYqUhLqRfkHZAyTav82FGV1r5KpXCQrvEgw/MzxNB7J/es3nBRqiUdOkdEdTbRHhSKRu9NHJ1uPwdtrg4lh+x3b3LvtfX9hU9Q0AmJB1/HPy2pPCpaQaFzchazOfNzM=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2363;6:TWwNSbmq9buuyvfesR30Cd9Tso3x5T/z5IaiQbprwEdGegx62G4rw3x3OmzTUkdsl++/5R2pxYVMKv35Pn5YJbUHSrTrTrvBmEMguNIEpAiMpCalH0Vt+ZETRNL+Efsa1jp6x4Kxfs0w394GaRwByUjvBzGl9ffW8EyHicenJa+aklVRU0d7KuBO1Ryz100StQDCnkblKytzo5An+H4ChKLcmhFfXolaEUlcVO1nU7fhWp2XwAKtKvknF2OZicHEwSGIhZrFcSWQQEFiVr/V+bHAvnpbckU28aaK9UDzRNk9GThfwzAoxDl9ZjYeN+CcKRnzSWJw9/cNZISkUUqwwCdgC7boBq2/9s7iTQVHnVJz5HGkrbrhLkgU2GyIS0jNz84BXLm4mSm0U7BafdmNfpaTDkO6CQ+WR1JzGNpZiY7AYI9RLpCU6sps/al7LYAnyEXqOAaasGqoIBatwvxtrA==;5:45gq1oTYpmOIL0c2qLs2BOFIX4VNlNkb/H5JF6NvEe2UEtN9kwwi8tcRiGp5/bgVL+xXP14+mHD4R9sw2MpQS3GCSsIfrqxnc3vzpYdQ0l4RkFKGwa5O/nxzGOXLDCXFCOQKjDsLHHZ1Jp/ZmMqPcpVBccyEGt6eMnullkdgBAo=;7:qo1XlkFehz2bxfTWsMD91Aq4ZvZwihrBrrtJuz2DckmgwMDIso4dTJULIZ1hIQacWSLLoVxSx188f6LZayNl5zO0gusrbwao3egz6mbnlOQOG3DQZFnZN5BzbA+SoAGK37TymwqoLDbvckDUImxvIcm/L9W8dq8krvWnsT6yYD8+H/0nQyADHTKrsUQzW4jvn3F8jl7mtGXfITGdbIaR3Wid/l8HC6F5rC0DQyDI1/iV444Yo8OkqfaWIH/nTxde
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2363;20:TGB032guXSAjcN1VUln7dYSCd32H0/5NKKCg51PJo0ZQyA5eeSWfvAQSwj5xfix7hSITYLEnf/cedBjqqZNPZrDDGCYzGOh/WxoY8BfBSr7qQxOXBtxdCnuO0Gx7GV+slWByW+YAbw6nCW9+O9U6nvY8IJJgHLFm5CGsd8GJb4SQE+xlhza65Cs/l2MZfz/Dd0WYgg+d+8AP7bZzTO4Tx+dVa5ti9ci/L4pi9WLoJBj0zFj9ao2H8ZmeFoxtdOUf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 06:04:47.7094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f52bee72-d176-4b86-1f66-08d5f2bdb602
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2363
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes
sound/soc/amd/acp-da7219-max98357a.c: In function 'cz_probe':
sound/soc/amd/acp-da7219-max98357a.c:367:3: warning: 'ret' may
be used uninitialized in this function [-Wmaybe-uninitialized]
   dev_err(&pdev->dev, "Failed to register regulator: %d\n",
ret);

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: closing braces missing
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index cd3cf6e..8e3275a 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -365,7 +365,7 @@ static int cz_probe(struct platform_device *pdev)
 				       &acp_da7219_cfg);
 	if (IS_ERR(rdev)) {
 		dev_err(&pdev->dev, "Failed to register regulator: %d\n",
-			ret);
+			(int)PTR_ERR(rdev));
 		return -EINVAL;
 	}
 
-- 
1.9.1

