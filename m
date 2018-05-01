Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeEAUud (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 16:50:33 -0400
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:19776
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750766AbeEAUua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 16:50:30 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=permerror action=none header.from=amd.com;
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
CC: Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/10] ASoC: AMD: Move clk enable from hw_params/free to startup/shutdown
Date: Wed, 2 May 2018 02:20:01 +0530
Message-ID: <1525207810-1305-7-git-send-email-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(39380400002)(376002)(346002)(396003)(2980300002)(428003)(199004)(189003)(104016004)(36756003)(6666003)(26005)(2906002)(305945005)(16586007)(478600001)(77096007)(4326008)(72206003)(50226002)(81166006)(81156014)(8936002)(316002)(54906003)(105586002)(39060400002)(8676002)(126002)(476003)(336012)(446003)(426003)(53416004)(11346002)(97736004)(486006)(47776003)(86362001)(48376002)(53936002)(1671002)(50466002)(68736007)(51416003)(7696005)(5660300001)(186003)(76176011)(106466001)(2616005)(109986005)(356003)(266003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2421;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT025;1:UxXEjQJoqseU8Dy9h9vQj32pDRfBoE7VMg1bMyGyIjxhy/R0813lD5yqKmBycn66fXYgglciniXQWy2sLakuT1z8//ASm+pUjEZTr7UUMZaGvJNHVDueOnpL3CuO97Mr
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR12MB2421;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2421;3:XndBeFYTx6ZvhJY2PKxOrKrbTj4nRJIRYwhf9PPu8Nr6634tWYoQTlIBJYfaNmpLNJuJrMgBOsibYPo1VQqG7u6JldXwPrbRzydXPdQyOSmlCw6jwJ2blgwj7ttlCPBGa6kS6fig9qH0MEYKaE4FgVroZXb0Bn4iGPyY17hY+7hYIUCxBx4geZG4oVz9Ryi4gMlQN+Uz4JnZ5gZ1coHoy2tATRgFxN+X4AvP4gIJFXgQ+zwQJfUt2NCXFO+/gfaroqmiLQ1GQsfD+sKvSn03DRF0BkbNcsAwDnNWOZt4xN9ma6WmWcGLzUCHNnJcfu3eP49ysCcBemsU36PoSBUnAGoPwSauo77fR1XI+ko+0i0=;25:juzEDXLJLArHxTXGF6RaBo8YENEE0EPCk2py7bDQpSPJcHRUz6WlX5KZ5XR16aL0YREHwCKx7UmrXXG2kTDroou+mUgJ5pR/xhj37Bg1JrjYWxykuXXp5u+yCN98DoUfzWZHhAs+bqmgRflSBriKEm6A8xB8udQU1o7UlDnb1qzC0gchx/dc0uDrmOJkCI6GB8C/BJ1CsC+Z4HK2khSGVfeQd1DM15cSCDcTQFQqAnXJiTvHEbbtGbHEMZqsIJx27OhHwDhDjLulaCYPBDTuaESILy8Is/TBdL8OQWzUg/MngYD48kNith05nnJ3AvFTQvhIC/w6qZqOS33p0rZ+qg==
X-MS-TrafficTypeDiagnostic: DM5PR12MB2421:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2421;31:Q0RZxiZhmGfvYEQKP/KpgzBAXerVBfzKADdox3UCU9gpncr3b7OQrRumMq1J542zv3YvEKFfoUqGLHN6XFbsyKw/ZPho2ie2FHfW4hcr+oWstPX5Z3UF2WCtnT8kpGyRR1RGZokjHG/G/zQK/wv7smVZET690LfOyEimcGNOjTDx7Cv3/sBYtc4tnST+SFpIGcWF5WS2ElhuSWYM1JNGkru0bUFQ2Newc5297m74i/0=;20:DglZLvrPoZf41QvorpJ631xR98hT8wPbCbn1nk3IzkVlPvlwe20zhL95Gx5X2J93S/Wzzw27XfPeGqxWACbw4Ao25gbFPjyufh2DqkEgr986nwjHiB38Qi6gl1TuAVuZF+qg8cuK8YcMbJgPoJkZJiwgPHpMwBrO4zs7kP/WdGWwb4Y7Yt7B9Gys9FHuidNsy2csYIs1c17ndlnPSKQgrO9i7pCmJjuchIgcvVWGn4IJUZy82Lk4o4rYksZwjmgrB++0U1U8JkKWyrNrkYUyO97OlWUlJukTh0GqUdi4mEdVlOZ00jjhLuWwqSsBZYq5lefY9hrj6+QhIHsZjZi9aijgwegp3cbgvdoxPJFK+/jxlbjDikMkX4iiIlyDFnMRtzXqli/ESyXY/j9D3TTKHmVNbRrVQ99IxXQFk5sbhL+XwHnsU5fnx2OAqcqjhZQRn7f0NJxa6cTxs4/A8NpxhdyNJEYgf1bVmyLtKXO0FGvtQbN/5RNJ6//tDrLfaPO1
X-Microsoft-Antispam-PRVS: <DM5PR12MB2421F773601BC5DFB596846797810@DM5PR12MB2421.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB2421;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2421;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2421;4:wFblLmCmNL7whg42aE3Ww/h0i++JoC511w7DciqZhgz4SKlArikl/gNoNqiBa8ieGAYZA88WJrMrhdVc3nGQ9NVTwxDmMFM7xGks6HqR056gNuV8URWphdIARAcXQbEi7UYOUGdbECK8j9sD2CMkrCRP7Sc3P1D/Q0e3o/OU6hFxre3EcWHvfdjp7zjY4l5B1QnYjZw+5GqoHjKcF3LlkNdWJt9fHmv7x0dIIKVwPaYN9soeX5wEHjAMNVZPjiHZWy1Xqa+2oGpXJSW7tO8xYYQpe3rYCCj7lNRhbaWPJj4dUJ7zM4uJx+QW+Kj0zBoF
X-Forefront-PRVS: 06592CCE58
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR12MB2421;23:tRkUh78n5AMSAz6anFSuFLoB+A+4PGgf2S+IAjQax?=
 =?us-ascii?Q?6IGpfp7b5mYSYBwyUQ8kcNfSdfAQoxh1lqEutn0M3WnppNoE2AaKMvZOINa2?=
 =?us-ascii?Q?GXmfmBeJAKo5SbsE6uUMZRQh+mhGZc+POC8OIiFMMHngYo/aCL2P/Wav5VjP?=
 =?us-ascii?Q?vYAkbNf2i2hGg0GncQQX3Pr4gaheTUdU9xIiwP5J1D+PmaOplcDZuppBbRpG?=
 =?us-ascii?Q?1KeZn8N4XvjJzB+c73H3ykSqEIVZAHIWGPdD1tTkf6XD70X7/Du5Uz96NV75?=
 =?us-ascii?Q?WuDYDM52EvigQHnkqvoWIEZ0LZwp+7AQLxH7V69NRWROUR36i7BGB+Q4ZxA9?=
 =?us-ascii?Q?RJwq/NnuyH0x82qXRS9twKYCo/zl/sUPotKmWnbUbqRCxaKoxBiFJgK2vSxc?=
 =?us-ascii?Q?ndpkI1tKEY/adBe/Xa4RYmhMUQ3sOjoL+XaomSIYefXqIbboSmc13FpEJnsZ?=
 =?us-ascii?Q?caqt2sbURkB7MQ2TG0kPv2q9EWM/AcmA80aCi/PV4Kq7VvDA+y7RZ6IBZ2j4?=
 =?us-ascii?Q?BeRWH/CT0EDUesbhSS0jPVBKLH35Cjb4nHSD+ZeMdtdgS0YBC+p06l6ovare?=
 =?us-ascii?Q?mKCmUaxd3wD5WyBcZsAbYzy0nxTswoWbcxwDB/TQoUyIA/80KlmvWCGmF2D1?=
 =?us-ascii?Q?aHq9/tXM6U5QicEl3uzcNaz1cVoZT+8elvF3xHklms5CdsHa2zkpOfm0myQ2?=
 =?us-ascii?Q?7f3bmdANoqioMuxZvKuMb1xaEtC/e3BPhtIveXESJ9I8qHqsXF1O4YajpTK9?=
 =?us-ascii?Q?atBvy1daB+ONHcnv+nfpMBy611igmMjDtgkJ+BtODDWl0LKxqx7JeykZLEaT?=
 =?us-ascii?Q?si6B1B7w9Nc6wcm+xVH9+SN/hTOG/fzYsZa6wa5AYBVApEStev/18+B4+EAN?=
 =?us-ascii?Q?IDJ/uWwCUxRTFTnJM+lj4ZAtXUPc4UDSqVpf+2f2nMdilNtKP+yS1kkW51tT?=
 =?us-ascii?Q?v2rVI8mHUhAtXQTXL3etbmW3Rfz2Xu7OE7kFJnNP93XOUZ1YVuM+8EEyy54Z?=
 =?us-ascii?Q?dXVksO02nHpIUA+ujemckRpNBgZUK2F0xlLXvnsvftxddUSPHac01CqYMcbM?=
 =?us-ascii?Q?4lBUngi/5eUY5Z5vXFwEu49M0ZI+HLGHQalsGIQT64PqFjWwmDvlDqLF/XzE?=
 =?us-ascii?Q?ZCqXS/pmZUVXgE8OPzi8e3/V6Q/ADRb6H6emMck2OQoJ4JaLXpbPQgeyTUo3?=
 =?us-ascii?Q?ChTrfQJ8xv91xOxZ7zncTj22YCDNCnf9fq81tmvIxiDVVIe+gzwQJbIYpySu?=
 =?us-ascii?Q?WBOiWpUhKp1sCIyWVbE1I7rvNIWq07/H7gNsLNj64TiWctNoI/elHagZCmUp?=
 =?us-ascii?Q?Q+PTIYJvb95JiJcRTXNacUxIMP4UDnIVEZZTLIfKDh+?=
X-Microsoft-Antispam-Message-Info: K4fpo/ldTzMzhOjh0jhCDcIFMKdOPgeAD9Rv6OrSaIsIzdLClxmCQLB5fCGnthhXijXf+shd+4yvDQG/tTfXfhRW98Y1c0vSk4MlNcKIt2IO3mtlIm2nszm3G8rIRebNFW6Ru243Sc62jeiRO23vIouV79kutYL/soNhvE2bFLLJf7qfffI/ZdlfiFxm1R6X
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2421;6:oA8MDi/dsdI2Kt5ovB0q7iq8SQu+kcr9ru96Gmzw7SmIxedw0Jgr777drp7G/htMkVZ4mCy9RYvXm3rDjRFlevdHoDcyIXurpspRFijRE/CepDg4xH4IeBYVCSEX6DJiUDL1ukwQeB/XiBGzOEs4Y/PootLg4x955rUlj07wyfe+hTbsX3LWA2B0DBh3daJpUb1GrArUU7GOxzZruRJriHEnvBnFxnhBREWRDCEOtJ+v+3Zmj1KzNlMIP5CTD0yzOFaJjzl8bQxjTDU/C9I67gBMkVY2N6reDESudsMtD+N03OlWbBCPP+BDl0l2abvS63NCUdvYr+Srm1lc1KSenb0LhwofHJBRdMmDXgATbeKld5hNMsaBucLLpnL7fk6Cdjsxh4QASF401ESySXrRiYvq5dZdqc3ue73eAhy75KHLGSAHOeCPstbTsHngzj1uyAZVLC6ZlahhHXuxgnCe5w==;5:nfZ7k4mCUxl9efQ7rDyMS8/+PiP6J5ySxxfVqA1imXKC3xHw/ZMRdGglZppF2H7eIiYoXN6zgKUJOxa22GB2zpmrjnRYQPhtFpYZ/BLbpXO1ypNdbIejmuaRkKp2RpaMoyk3nunRZCBiIk27oMIdYsdeYkUPHhMRekI5I46yDBc=;24:+/LyeGeN598EaQT7zFzaIsyMDbPyCC505TNoGY/lw2+iZW5WedpRMY2awkaksgfWkJboE6dew5qmwqjcJ8g+3JZtZxX8GB6OV9D+k/Is+B4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2421;7:FXAOyx6pRJQ/QPFZuxjVJG9EWfEK6uX3Ugz7OZt4ugIJzrCti+GRpLV+SWC9rpJkDVV18p7iUMhTVeoVwPGyTf6WxUfrkTBir2UxjQH+u+AZah46ImTE55mnq4I4QDGtQVN2xlpch42RJ2RyYoerwwiN8r+35KWiEtJBtcDXabeOHuTrTf1Nwo1AIpwCEReUNb83qXqfbraa2iOw5Gb7Caa8A4/1JW7JWSVChpvs2eT20UmKXeN3iOAMIfgnsgzh;20:d3AYp7C8ykICCP4r+PSeZdI0Hy3c/evT8g5G/3Ox6nKWgUXfk/4EQ5HSJZKqK4q1ES/05K9AT4TowT6C3VXmwZl3vV9qM+eeN4466bK0p9LxCXZ1Ms0JvlARGdv6X2NB4J9UkfXpgG50lZnO/cEjoNti+EQQcue3HiTnFSAYl1NwA089IujY+osVPYU3UF0nzdJ15c75DsKatg9DhBCBtzSBjVqiHrRm4CeD0TqXHbD0+HZEGo4GhEabN6AzgBT0
X-MS-Office365-Filtering-Correlation-Id: abeed655-d439-4358-a554-08d5afa52ba6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 20:50:27.5224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abeed655-d439-4358-a554-08d5afa52ba6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2421
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
