Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755751AbeDZLRY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:17:24 -0400
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:60284
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755384AbeDZLRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:17:20 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/11] ASoC: AMD: Move clk enable from hw_params/free to startup/shutdown
Date: Thu, 26 Apr 2018 16:45:54 +0530
Message-ID: <1524741374-13523-8-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(376002)(39860400002)(2980300002)(428003)(189003)(199004)(86362001)(76176011)(81166006)(5660300001)(1671002)(126002)(426003)(104016004)(4326008)(316002)(6666003)(68736007)(105586002)(2906002)(16586007)(36756003)(109986005)(7696005)(72206003)(54906003)(50226002)(51416003)(47776003)(478600001)(8936002)(26005)(8676002)(186003)(50466002)(53936002)(97736004)(2616005)(11346002)(336012)(77096007)(446003)(305945005)(81156014)(356003)(476003)(106466001)(39060400002)(53416004)(486006)(48376002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0332;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT062;1:fiZf16ybdmhbvnLSHDj4u5GW8+O2b9zVA5SX7noPMeIF2vppTwpUL7nQZUzgH1CYe3EjM4AhWc76VG0FyHOrNCtg3PwVn8TsxkgMYqsTSTb1w26KhOepk55HMYd0IEdl
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM2PR12MB0332;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;3:5Bipu74NudiSBOzmPluzwZvg6SQsEINSL0DtgZvAOjj/ddBlYGayM5kGdXcOxRmtjn6Z3sL7GknKufswqqIG3ej2SPfpfo2BaX/cg8SlNZIouzCG+Iz1ABYDBsXb/LlpM9jAF/GphqAYH9zttSwVUhKDjn/5RhIezGcQrVtVmJRp270gARD27L8kdu/6qONgTo04w2d8jUr7F7SQMUj/thSKm0v9v4+nwTOODeGEzMbVMmZA8yb+gxlWlvdKiGJVcmM6dt0zspJj7DGwhu4x7UtXsexPizOuujq78byNYqCmWP87xYsltXg0RVSpbdbnqnOm6lBFrJfBGDTWEQxbaBhKcf8trbfYgcDQ01iIHzc=;25:7x0ue2ZiIMsmjRn+WdCgNfXNUtloYAOcQCH7KvdkuUTB0lFzrgdF5uTH7/qaypfx+Ko1iptvZvcZhAHF2psAA/CeqdnuB93AtDkGiwAhyy/K1Ybm5tXEhRtzuvZtFFyJs2yY1sUTadhcIFL+RSmqXYKD5hq23n3iSTaYOmBK6xDddDmSIcTD1ZE7Z1Ju4nP3F1+RvklMEBXA9/8nJJOhAsWzptM75v3eHY0dEHcfIm57A9VXVYj3qDYsH+Cxb1I6Vbea1n/KJQVKhssWlMgicZcCKKcojPo6vDZ6LQ6iSYA0/hBY7uWVcLYYwZrRw1U2BIOCTMGMWoNvrpyeLNtF5EK9cIvIxqu7zzw/nAmAS6E=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0332:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;31:J6YSziMVvjl94XavRKvdEP4O+4yRRj8gFP5x2T2yA6w0FoyQ2WmuRMa8qhNjxYapc9rkhDJafLTAYc9xXqHJrsXyLg7nGjbheA/vXcgVgywwfTdh4fe1LYu2xv0mGimxxpR8mwrhUZTgqZrOCddkLPyD/nkV1ei/2m55Ex87f4HIJRV5yg+TSAIHt6vyjAZAnjKWvPMSwKzEF7bj5njyLDJ1Wb2wa+PEBGe6/KiZq6Q=;20:peH+4zX6q8A7iZ4RMm/QFpsbWTjFzecDWIWlhdeTAR4wNr96UkzBs8XPILbPgKmmwoFifV0NOGe7hBJhQOo6bRodpXeoS9a9tfziH9YCppk/YQSVzm0HCh+uCIG2DKFZn2xcreVnRmzzzb67fFfEBf4ybi6SdjUbuayXrna7G1sCUmc+q0whfbR12Q1WNrsXDzkKs7hbp4vc/qhERnZDdI9UbI5OavFzqNsTFMPNfUU66JxdOXtqG2e2rmpsORwoeBGHfOZWJ+6CrTT01UuaZ55pKgxv72PB6ecY++KH/NXrqdLRnc/MGzGeydcjBPraoPFwuGTEGfXA+fQPDhokFRHphMs7Ej1M7Q5aaEsmjD2TNepFxwq5laXZMTsfhVM5QQupNuA2/h42/MhlMIG3cdaksqiF1FGtgoNd+VXYtYlg8wLFEhuBMv0qqlcNag2ltO080wJgloP5EsBU+rA5lw5uCHpSgitCgrxkRl3QeLcwhJCClNf1MrWySwNgZ3x0
X-Microsoft-Antispam-PRVS: <DM2PR12MB03320210FB47DB9D566F72FE978E0@DM2PR12MB0332.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93003095)(6055026)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM2PR12MB0332;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0332;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;4:GTEknSQ+fnTVYOrE6ZroeVbUL+l0y5+mf51YwoxZjw5AkPfpp7rcGnrqYWnzGxYniqBd340saQ475gf18Qlwmy53K7oy1sxS8/nz99dfRTw1CmNdcZ52hoqaV0Espz0YXOJjjJ1L2Gss7MuX50/+5upwa2/7vopAzPDwxC+Pj9F1L4gyV05cSyy8FQ3FTdumFu3Vhv1rQbG8tgDNQYDyaOI6z0PNyVbwMfd4PzV1uljRlzaCiqhYgwIemauNGQqdUXlLeNu03f9MJxV6x1VAQ3lj57BWUMb2wfvcK1wSl3Gd63/zZ5UegwmjmT087EDJ
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0332;23:hea3qphIol/zsmMYAzUzKGp2NZHVb3nHCf2/7MJaK?=
 =?us-ascii?Q?ilA09zS0Mn+bwseZzEx9sebqLJwMGzpTApFsLBqFZB9k13PbezNh56HOH4Zd?=
 =?us-ascii?Q?i/Qfb5XdN8jYUjTZNtqEg4aPO9NLW/5FIeNbfZStW2gB0kBPYD9MU2SDVLr5?=
 =?us-ascii?Q?keNXR4YfvrMAeHOb0dmzH0L7wj2UdhXsLms3h0TtRzAFmY0WvMit+n9Jt853?=
 =?us-ascii?Q?YFJtlOLjEb5Fw8ZJAiQSEFpQnLaAYVnMumRoBe7BIjIOKdR20D+M7Cn6W2Wn?=
 =?us-ascii?Q?EcpRAf2vdJ+8cnUAT8bl588/J2gRRNb41ZZwRHN2R6LJ/yPOsaQLo5b4eLtR?=
 =?us-ascii?Q?EvgeMHFdj9YlM3bL88sLAn5pL5kzYlg1ZRQzc2OZHxaTHUBFLpc5bAtzuayv?=
 =?us-ascii?Q?SL3y57zWEmLvkOqhW2+psL50RtsBUFqjILErOWL7DccHmNdIMbsbokkvMkeX?=
 =?us-ascii?Q?GN9rcp5puEvYp8g6X/xa+FVHLtQC3ecfRWebssBqoWOkXaAdcqJARxKtBlXK?=
 =?us-ascii?Q?7TmLbwM0w+KfPJyRAElXjKwpGaD/3pst/ztjmFyyyyU4KL8WrAhs0nn04f6+?=
 =?us-ascii?Q?TNGK9iI0D2D0wUT5lZHEJI4SMwg2b4SndnU9YjkN7z+qdJb3pY5Z6k315/eV?=
 =?us-ascii?Q?YXY/3POPul612TCGndJPW+SE5nB88XTUtDwE03T8b5Q8+uEQekbmoDnhWBiB?=
 =?us-ascii?Q?uUIyKMTR87lsjC76v4EVDCGcPD62YxTRzaH4fT0d2f4IF7FUW4uHHiCUuxJN?=
 =?us-ascii?Q?YIOJFtVnfg5jWgtLzGnTcIFvJUWvP6JWDBo7iB25HFzlMjJVU3GVYU38THQK?=
 =?us-ascii?Q?d97L3JzMiNjW6zKKi5oc+tHkiEsvx3OlNWGT+JZZ8Rws7k3opEk7WyPkZT8J?=
 =?us-ascii?Q?u4djgNbAIZFOvs1B/QBVIZeLd1SCWb5RCZIB3WHPNU91yzWTftDSimgdre5a?=
 =?us-ascii?Q?bnOs0HeK90/RsnOMsiRe1Q5qv/M01puyOTlb8DsLwzlrUwkVUhpnqRAXDtGu?=
 =?us-ascii?Q?RDBozXSQhN754NGpncyyFZFJ180cvOaevRc3ZtNyXrUvRaFQ8M74uwvWoiV2?=
 =?us-ascii?Q?8B2JGEh85tP+XUlXEA9aC1jsudiydH317I8olQkVnTzyyLoEp8ubG3/WVYnL?=
 =?us-ascii?Q?bOsn/MdAlSPCGiBlLbFnNLTnZnc2AOi0YmDVuwFkQm082mm0VCUqSRa5IHDI?=
 =?us-ascii?Q?/atcGmwfEUQ82rwYoCn9nG41hGJL8abGLE7pBDh7qp2cf1ZX02h7l+JCg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: kSjNAIehi6BOOQNehSnphgb/Bm1FqpC031wIo2jq6p2GVifJJLk7QXMIboSmnNhsw/6XJ9v8f1EpWNkhPnzxFaLsx87vAXa4GUvGS0wuMUoZAlPc/HqAIJCdwEus8fJ9GvDby6ZKFaEvTowzKID9zfhgRqwcS8qQVPxxIVtPxJDq3PQGpzZ+rvOG0fQgdg5N
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;6:b2bgK7xlVucL0pr8RQLHIp4biipSR4/dIuseesEASLqu4e3FYeMSagzhgeTaoR1NoJhakoHsCLbvwp7lQdnR8i5yC+8M+QJpqmYNRoZcSKV3sDorOTELGFP/Gvag7p82OEzxCGfdM8qMMjpgIrUGLNx0rnic2KxCm0MRrJM/vIED/2jblp+Mg82SLiCDrenqa0GrY1Iww1Xpj6EAxkZnH0GXgkXTX++A4jDTZgWA4+sFF7Q9CImgtT86ft4xrFzMsEr7yslLvPnF1fDKynY6MhA6yYQhFS2OfDutN9GkMRnKzkPQU+ebZZRWkndIGpMivLxU0MC0VkzFlv/0ZtQ1zeO83LwR7UYtqOmW45fdB560c+xP7ixtxEBG0n0OUDcsuHSfh9vVkczByZ6wqABwwO1DScMAkRyNqAQhNiGG/UezXa4ITGThKpDg440/Wi1Wun3fl7A5HhNMmHI1raMs2Q==;5:YcDPSghjfUe7ZlsCh20la1gESs7AqwV7//XJ43f54dcP2rzl0El9yY0uZr+ThcBUfi9dciChfng4QvE+Kpa5MA7AozQ43pjA2S+mpgcECPZfcvd7eQ7V8gkUj0WiuBlwu3RKcNj+TwtJ/EpqltxsJkTpuAMuEdC9hOq7GkGCLMo=;24:VbRF8LZkn4RL1qInXRePRPPCrt3jsnGjBpvfCpBqOyJbGwQXFIf7wq3DktAX2+Cl4y43jZN45l/1k8O4f3NqbMsJ1kF0KPUN5x1mTXjDmIc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;7:9q3L/vWlFQNwpEd+OJxcgbkKuIHRIAP86UcR/wrvHJV+jaDPyOFwj5Fb7ohhvnogunRDv6jn++Ljn2KNvvdDQUGYTsasFoTWqaHIlctfAyKMb9hMQaO+qQ+AeCJMgrdFIZGB1sicsY+a89HAhP5M4qsJXwXAwVJv61QTVyq1KstqXpVdCOMawF0/CyAobcIEwFVQYdKIjjcxSAgH+z7NsVv6kEpi0tRtPfMZeN0+sMJxgkZOGAKBbacNHV4OQD9W;20:CqIREcN63tLMFHCc/PQTwHFZr+qwD72+e0jQL0uYdI7IBzZFSjB8NFPC/WGgLopuYM43ZqhbvXBjCskBILpD/FBI4uD3dxkwnb2s0dT7ozOO41nCLb9rPtMK2d0J/C8fv+oFCOJn+eqyO7gOAtLzsrDPoCcWUiaLirQyw6BRwRRpe/7rf45ZN+766py6LSE3e2kD/f9TE9ySl4+vseKMg9Cz1620tHsliAmOmHniGt7949vkSaztRAIRAqyvIzao
X-MS-Office365-Filtering-Correlation-Id: cbf01bcb-2034-4ca2-5c1e-08d5ab6745d7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 11:17:18.1547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf01bcb-2034-4ca2-5c1e-08d5ab6745d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0332
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

hw_param can be called multiple times and thus we can have
more clk enable. The clk may not get diabled due to refcounting.
startup/shutdown ensures single clk enable/disable call.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 49 +++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 215b06b..6495eed 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -91,8 +91,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params)
+static int da7219_clk_enable(struct snd_pcm_substream *substream)
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -106,11 +105,9 @@ static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
+static void da7219_clk_disable(void)
 {
 	clk_disable_unprepare(da7219_dai_clk);
-
-	return 0;
 }
 
 static const unsigned int channels[] = {
@@ -133,7 +130,7 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 	.mask = 0,
 };
 
-static int cz_fe_startup(struct snd_pcm_substream *substream)
+static int cz_da7219_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 
@@ -147,23 +144,47 @@ static int cz_fe_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	return 0;
+	return da7219_clk_enable(substream);
+}
+
+static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
+}
+
+static int cz_max_startup(struct snd_pcm_substream *substream)
+{
+	return da7219_clk_enable(substream);
+}
+
+static void cz_max_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
+}
+
+static int cz_dmic_startup(struct snd_pcm_substream *substream)
+{
+	return da7219_clk_enable(substream);
+}
+
+static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
+{
+	da7219_clk_disable();
 }
 
 static struct snd_soc_ops cz_da7219_cap_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
-	.startup = cz_fe_startup,
+	.startup = cz_da7219_startup,
+	.shutdown = cz_da7219_shutdown,
 };
 
 static struct snd_soc_ops cz_max_play_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
+	.startup = cz_max_startup,
+	.shutdown = cz_max_shutdown,
 };
 
 static struct snd_soc_ops cz_dmic_cap_ops = {
-	.hw_params = cz_da7219_hw_params,
-	.hw_free = cz_da7219_hw_free,
+	.startup = cz_dmic_startup,
+	.shutdown = cz_dmic_shutdown,
 };
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
-- 
2.7.4
