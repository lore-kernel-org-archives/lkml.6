Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2005DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B027120BF3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4UcgAiC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B027120BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeHBIdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:33:41 -0400
Received: from mail-eopbgr680085.outbound.protection.outlook.com ([40.107.68.85]:44064
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726021AbeHBIdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNuZ5Dp7FYzxgLQ1yTogPeGNpOAmm8QAD31LORhMBqc=;
 b=4UcgAiC1ZAKgvUl8AkV/IkG7CBEu6OUQb0IgHITXQdlZUIPL4bSNIUReJaFhYgXlTfWI72AWSQCy/JBkc3RLccSV9LM7O5ntNmWjndunl0i8mX7gNBI5bfi6BXm1OWnXECNHbmUU4Z/BJ+KCXxOeA6Fg7r4wbK5DMNXhzyuujt8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (125.21.194.1) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 2 Aug 2018 06:43:45 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] ASoC: AMD: Set delay value for the capture case
Date:   Thu,  2 Aug 2018 12:11:56 +0530
Message-Id: <1533192134-11626-3-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
References: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR01CA0086.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::26)
 To DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ca2d402-fe1a-4fee-8f67-08d5f84350c1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:+HW0DQ+NSITfjy+505Z+JYkKUHhoFh8z+PcbVxNnqYcWaJLWCQRjAChcnwlEgce2ZBs53bWzg2UHKnJDuUUlzkJWDv90rcJ5rzyNmttnqf8fy3734wzo3TBnYw29N1zvvCIb+g/YsED2yrxQWub+OWCnr3Zw+HNdRZK2INIxowKa82AmLkdi90DsnovwOl6H6S4s3oPsiW3fdj7LdtGeJkqyvpPU/Ks9ay0WhmD/UcD1Q1lV+cL60LrVdXwzAX0a;25:IDZkb0GHWagosEZN74P3GRSyHuedg2045b0K1MeXNvir6eXpOiyA4W6nD/z2/xPOn5nOwzVbD75wYCn3D4mVUGuHQhpbk81pogjosUtiggScXzInH6xWaHDpPyLBoP8bEQgfU/dyF6JZxcgGlZIVyCl97BQ6h4KONWOqPwxGeY2PUMS0zkq4TFuNQblH0gaWWs7WhaIEn/+bu1yLgNSKPa2xEKMkX4QjoLuCNZfIFLQ4UTFzsicWuunLWTwjCGF3OMKFceJgD1fPpKCCiPlKNlWgEkqAXZAFXrzpmljOEbqysseAa4yuFiiPujBBN1O35wv7IK71jv1AR2AApgqGDg==;31:vrr0zpKwAU8fFGbkCrXKWFxT4Yry1y+fHI+2agbeVTELnux+jZt2izA9fvMXTqKS/pS1NXBnSsPgMeetRlDJoz2plmp2giT8uhIqQDDDwEbsAyqYOg2/8A8mI96KcGoxrjq8QWgbcAWqvd08/of24HP4o0uq0/CCOJ8bZnAq5ZTXigHfT7+C6AqjilwsGz0SEP/+xdR6/ky6BvrtQcn3BMKcP2SD4Zlz+P/viHnR7As=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:fQGsghatvS2RUMS1QBlnE6sr8dh64KyjOtXFkfYtKN9E3+Ig+7X/TR2Weogyfs3cVGqMn+xwD9yM4mRXhERdS6fesPEOH3/eiPqdGLRg6iJgBGDM++rA6iyNOL0eBwW+0EBAeMTWRPaM5VI5FdDnWmwof+LWVkDAcSSle4KM4nqdzcRxSqRK3LL8TQIdD+7APVRKkQNJp3UnYVffKizhZVKB2bog0V8QteqgjbTSV0utof56SmrNQFYYY479Z9g/EJ9Sc1JjsPwDyYaM1uviZZxS2zOGl33fLVBINNrNFkRjrCJqtoD7qpCdTd61oJuz6wnA9MnFN2TFhfecvz/Ky8ZGYgoWsMDlvJ5eLnNcTjbgLTBJ/IfZo3osw3fjRfdAtMPmFFXTn1miKDWr8Yt3T//COWEkNL6YXwvYUdQWeYLRBbniUvul1cu1d7Zuo2yF/AoIQ0nOHTNBZxtuqm/x3oSeLjsrqh0zw7JmgrMV/ysuGNgCd62QmO9NiXq75eVb;4:+WjGa/n09iN8iLWut9eWO2ohvzXyBiwQg3Ydwm315AlD7GSj+yXdIS+KYh8TMSKP40G+eU1HZlf771MrWMgsVdxGDp0g0VRUmVzGlWBDb5g6gzKVVeKP6K6z05SS/QXlQudeyWgxdq2dUyr1mxQOrEivR/8tWVdcX3sTEPSC/uaF7lhXeYYxyRRVn3oJWXgYkUN74TeVsk/eTVTlpBYvXB/C4qi9klmwVEwBkypZfNEKYMEYgsl9zQTWnyLrt1JONzwwtiiSc0geKE/nmAQLH3qzyxK4iqo1nRqtMDmE5fgy/4tR3ntdvw9F19P4LNja
X-Microsoft-Antispam-PRVS: <DM5PR12MB2359D463FE4E58A3D39B4379F82C0@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 07521929C1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(366004)(199004)(189003)(51416003)(50466002)(2906002)(6486002)(8936002)(8676002)(39060400002)(3846002)(81156014)(81166006)(109986005)(4326008)(36756003)(48376002)(44832011)(486006)(1671002)(25786009)(86362001)(476003)(50226002)(6116002)(68736007)(66066001)(6666003)(446003)(7696005)(26005)(105586002)(106356001)(16526019)(53936002)(47776003)(54906003)(16586007)(2616005)(5660300001)(956004)(53416004)(7736002)(11346002)(478600001)(72206003)(76176011)(305945005)(52116002)(97736004)(186003)(316002)(386003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2359;23:lZChComXOFPxfCqCzntsuKvwj9AVx9qX1+aIR8ZLN?=
 =?us-ascii?Q?Hbv/H+CsOpYjqOaboqUMbUz0A/5CfRQ9Q2k9y3+5ddgWOmMCneZhFUko8n8u?=
 =?us-ascii?Q?AOG2NDLeKzTtGitypqO5awrqzFFxwK7ljZ78VHHBMvl6tcmD9+e6Mk+SlSfl?=
 =?us-ascii?Q?OXUDx18573VQSLtwDO204pZrawRTF4Kxyzlxe1f/3aj9cCZa+NZGEL8BDwsy?=
 =?us-ascii?Q?58f6gngAIXuU9iHpJ/49GoZ/3tdtNTQ5IQEayFtzMlVI1raD94hD+EZAktq0?=
 =?us-ascii?Q?YXFa+loqFC+jJ+GZasgIxmkroJypuDNSTDv+fSxZH4eUKtTXcFhH6YCNz7El?=
 =?us-ascii?Q?/YmaLTouL8wbwmLCT4ZpBM/lTBDSVDepL2SE5DhepJeZZXo0vMvqaNzeEIWu?=
 =?us-ascii?Q?U40ZM/9hgABr5DxQdihfc8gnNrVxxCoov3NK+4tiM6O6Nt/Kn+YhBpXCsbu2?=
 =?us-ascii?Q?DNN1i04IfhHC7tQ3N2zIUV/e1FX2U+30RMrRETwEP6gd3jJCa3VWmplsXlGA?=
 =?us-ascii?Q?1dhl43O1zdSPK/OYL4xtXO8+cZWhw1hwcb5hu/pwJuqgidavusT9721hOoDq?=
 =?us-ascii?Q?CgpsSsYBkv7xupkKObpPx8AOLHvLIwUTO2ji4bjaKy3Q2J6bz083dfOmgRJM?=
 =?us-ascii?Q?/JXCQ3MgGS4mGgD6SKlv4FjqWM4VMC9AEvS/L3mzc5zajh7gpNGPqbd4Dc5Z?=
 =?us-ascii?Q?7RZGk4OpKWp60c0agWCV3SQ+ruompHLpHPea3ENt8TKwHUkELE3D82hJ3X2b?=
 =?us-ascii?Q?Wj8JNcI8KNPQttebqL1a4lPV8mc1B1g7wiF9AVq23Fudwe7YfBJe97xp253N?=
 =?us-ascii?Q?ZtaZz/1yz+x+33R5HiF06+0EgoJgk6dQETZBQoeVuhpe5F/NUz8DSWyHZT4+?=
 =?us-ascii?Q?qdwnvHI0H4VtJqg3z/2Rnb1/80Mh+LpZFV5T8mq/ZwPTV7Ral0o9nZ2yP0Fr?=
 =?us-ascii?Q?uy3WB00rwaHNMN+0bn6hKhqxiL39ghHw+Hr1PQplv2W3xUYJ4B5QFhP7NwyK?=
 =?us-ascii?Q?5P0Y+w93j2ZplEGsEXhtAjKuy7QwLcAdvQiA8ofTNSH+UUZXkFMLL9RlF/jk?=
 =?us-ascii?Q?Vwd/olFqIgNIdZJEWa2bHcNkpqyGiuAtHEQ0Qkfeg4nFmHdYo8EMg2oSQiuQ?=
 =?us-ascii?Q?DDc7Zq4pnOF8s9xeefdY8kBhKs1C2fY/pEzHDh9ESxcs3pUXcRahoXOquuvt?=
 =?us-ascii?Q?z/gNl2xp+LO4MC4PLiqFco/CAsMX1QHClkPTbQtKBgyuq8U+uG0mou0rcyNH?=
 =?us-ascii?Q?xvcpBZVC8Nqf1n62oUPhWsQvccSN6oQ7/xYK3zZAl1xXb+1U67u/fjL9O2j5?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: WsSUE2emGSRNDWIcfvLPxUorKY9ULt7dZuG/6vSyT+OWbv1Zvh8duSmzpY1dTgHGcuLfH8hcPZAmMdPFhCDDo9VEtQAbkvKs+tkaNNAmOuo0ACzyYH4Lwz9cZzyUB991EGqL0IFBGN5Gvea1M5bUfO8u5uxSUqeBq5kyRVEBO7BDzKOFw7yfYNTJDFLeRDjNxeHEL77XsDzltEfNWk6fWZgYtB3a9bfmHt/6hbdMmnYknx0Mv3u/6jHp5xRRsWJnn66krUelAnzKmbeQ/2sPvPTOVutRe4mZxIlBnMUSZRkMJNdsRnaLXkcxEvhlPurbAuzVie6VhJOx2rR1/shSNWR7dv/FV1IxqCtg8VIVeBU=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:glWbXKz4TpRXA0yjmqbsKdrmiNxtPjMECjoYNAXWwyoXGIiqLSsvPTEU6iUR2LT4Cg0VVGOhN2EFlTbu4xGp6PyDRdT5+HnisIG2JpQZvg4WxdGKuHU/7gOAZ8TSkZwqCx53LbNE08P9RrsIOBqUi4Ve5FWKryQ7fP5t/LV+LgIxocYdnbcd2tjoJqFoZhS78B7EueF/tD3lmIIZLNhbc2sACHwqyZqHw4K0xbL30fkYev34zk8ajU/AAWJRdchMnycFrG7nEpOfBWcoBTMbtsdC8mXhnZ0DFjmb1HnWPOSPSTZoUZdJBf2e8wn54jkiRZIaMsSDQzxN/QlKG8N7U9rd6KK22Dp1TSDklTKjPnpgi5uxsEHDciY5FHYAl5lCGSNTJO8usaulIG70EhvJaaiqEvrrgTnha9XP/vIaLDqPGXIlW9ZZwEb7sq+rQJy4nz0ZmNmRV3o4YZknSCk9qw==;5:WfapyprUjOIIMb83fQdmjYyL0BfW0Q0VhNN+XOJnySE2a2+xH60BzxKtJEeNVp4++kO6Q0RZukoomgv9UxmB/LMFE8eo5NpWZbGOSE0fZ7nI9V1THVFaaPOJYc2ZteAUuZU2M8XjCnWOPdRuU4N/STSeVuEOj0ZbhR6154VYHaA=;7:KOjKjjgY1bEjpnNXWgwwgtauGglVlIccQqN+km2JYZSXWRvtaFdw9djdnX/VF2ht9NDfVnJ+3OCWNu5i6MzUbV8RAxmHuXUAhhl1vf+v/kDhhadQU0mGmebTpWW6fszPR4e+cHYOF7abAnotmTDUDpuf+fZ4dML5YrKrmx8AmVNmLlemlB2uRugpfKfZ7j5osLXvc+V7p9Y53uZE9Ny2psuFygUBb/Mi9JBJxmzW42wI/WrwgGxEB6Mz34r14v55
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:ZvaZHJAuQLDbnO/zL2sFLcZq+kr/VBHVdK0p/eme95hXkBkVZPmQ+o4z5StR4wv9cCHw41xMweM96Lo7Hl2AW3gds5D0q/cmhy9MVZ1L4ca6a/Y7VMBdtfgpgKdQhZqIqxlGN0d97AmOu9joDo5s3hs/voDcxc9eL1mNdT93nuFuvmxiY2Q0SWb7nYSSYMWQuUOaA4Ts+N7TJHVhW/Cfnxrb3JM0JJC/1L7OIJd53HQnLm/lR4K5llI1ZwAfd+wg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 06:43:45.4409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca2d402-fe1a-4fee-8f67-08d5f84350c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP->SYSMEM DMA happens at every I2S->SYSMEM period
completion. Thus, there is delay of x frames till
I2S->SYSMEM reaches a period length. This delay is
communicated to user space.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 6240a77..c24611c 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -922,6 +922,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_BLUETOOTH;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH10;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH11;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_BT_RECEIVE_BYTE_CNT_LOW;
 			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_11;
 			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_11;
 			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH10;
@@ -944,6 +948,10 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 			rtd->destination = FROM_ACP_I2S_1;
 			rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
 			rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
+			rtd->byte_cnt_high_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
+			rtd->byte_cnt_low_reg_offset =
+					mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
 			rtd->dma_curr_dscr = mmACP_DMA_CUR_DSCR_15;
 			rtd->cur_trans_cnt = mmACP_DMA_CUR_TRANS_CNT_15;
 			rtd->end_dma_dscr = CAPTURE_END_DMA_DESCR_CH14;
@@ -1002,7 +1010,7 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	u64 bytescount = 0;
 	u32 dma_count = 0;
 	u16 dscr;
-	u32 period_bytes;
+	u32 period_bytes, delay;
 
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
@@ -1011,6 +1019,10 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		return -EINVAL;
 
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
+	bytescount = acp_get_byte_count(rtd);
+	if (bytescount > rtd->bytescount)
+		bytescount -= rtd->bytescount;
+
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
 		period_bytes = frames_to_bytes(runtime, runtime->period_size);
 		dscr = acp_reg_read(rtd->acp_mmio, rtd->dma_curr_dscr);
@@ -1018,10 +1030,9 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 		if (dscr == rtd->end_dma_dscr)
 			dma_count += period_bytes;
 		pos = dma_count % buffersize;
+		delay = do_div(bytescount, period_bytes);
+		runtime->delay = bytes_to_frames(runtime, delay);
 	} else {
-		bytescount = acp_get_byte_count(rtd);
-		if (bytescount > rtd->bytescount)
-			bytescount -= rtd->bytescount;
 		pos = do_div(bytescount, buffersize);
 	}
 	return bytes_to_frames(runtime, pos);
-- 
1.9.1

