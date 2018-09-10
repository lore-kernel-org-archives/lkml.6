Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E0BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7562086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="40rLNYGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7562086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeIJNPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:15:25 -0400
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:9376
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727488AbeIJNPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpWmop25eAnOGPlR4KgSZ9hnWAYXewNbq6OF0RH1WZ8=;
 b=40rLNYGUVMegMmFak3q749c6/01oWdgjOsFc2xMS7geJwppepsagtVaG8u9EP9oHlHpl/OQwwdX3WzspZSKsZVInpp0cFViEXvu6oG3Pv7WZWKM2QWYNdEOMvWSsMA6WbACIcC6+AYfioq11suiMYUrRWOBYKMWd3tNmjqC2Klw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (165.204.156.251) by
 BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:4c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 08:07:24 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] ASoC: AMD: Fix simultaneous playback and capture on different channel
Date:   Mon, 10 Sep 2018 13:36:29 +0530
Message-Id: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: PN1PR0101CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::25) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85ddcce6-b2c8-4c77-eb32-08d616f473b5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2355;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;3:0lLNU0ous8T/JJ19PuDdbCQ45l2m6mSt9pch1GNNrbDzXkv9uCCUbejdBSEO6mUTZgBiAeHMaO2D9OwMksUVc+MCkD509dTCL9TlyLTVj5LhU++rNckhwpgg/KPcYSMrsNZulpBmO6WHOAs9H7ldtrDtrAsSf5r7EgAistXcufH50onlhgmIZNp98zAik4pGUiJC4FaP8mpD+AqicBeIODO0VDXZEcDtPPD58w6kJg0/ytMhgTG7LA0zdrdOybMV;25:1BTGlyCg4I3Sid6KTbdQm2ThDawev2DXCXeAkWQe4oYYvIeSLm/OaWtbUTtUTFSAcf/rOfeWOWhx1n2gPpDiw7lIKr9ax2q+yvBneK4jK2KSWnYffpHxqHnHT/ytEDgHWMz8udWa8kKh8pnQcJrElICrWdtLX+kQLrEduqGHjUapJMeeKpEvntkIjRHzVvSEuLA562VHljcumCvqtP/NRgY+cQna35Z7+V08IsIpM+o01kYqk5oaIaRRrDq9sOp3ule329Zf3DItiFkPrxtHUTgeAgJDZcw5xKqKrMBKi3yHLEFOt7QMxVwQ+I/qdMBmWBMqNtrEKwaspQErLGFqBg==;31:ybmRnhS7r8I0OogoeG09Nn3eNLAaDyCku8ESz/AMc1TD1izL8Eq72WGxCxSEhf1MRuKOqVY/ykjBHR2yX3qyPD4/0hbd1bQioVGcpUjd7oI+Utp0FIEcJSP9OP7qdznm8hz91WR3MP2XKEr1uHnVKXGDmjWx9VMZ8WmIcgwV4TSt7/DiK5N8zdrFWB2hSknTOjCjL/RtXwQhMiqvYN/irVbySuU9EsgFmMG1eOjbXiU=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;20:3d6ASkxOZJHlVSy6GHeYp1kHfT8Szmc7vnpPVONy/IEgBtu6vFjFR3T0zk6hpXiAHR9eWvR8tK4gCj3p4I5HkjoARlCik96q51nt2ANVM1YXyqi4eZuwEKdKkXiuW2hn46yWG0sBQGzMHz9sfvd2FFmVXlb4Uru27Tisc0EvNsUwDvC/fjOIIpVtk9HFpG/yjcUHuIw998n4m3d9J3y4cKiZI8ahauh7VtpJLZ/O2wKPZvLIAN+ekdsTVDkW0+qghuR4dspRTnj5o9m5VdOC42p2E5hcpu0X8qDpKf88A6FSxsFQKHuUEZ01YL9pmpvb4+MIMrCWI3xXqMRrdkqai1v15fvaqVdvufAKZcDySjCvYMoHQrcHiEZ4cAJTig+m+RJPf5kfUqwXJA0iHuRoTD9KcwvV6sJ9+1BG9l7BfsRZPKDizYwy6hQ2INqOQMcd/sS2BCWXhr4wh/gkUHJNDb/KWNDyCeGCJZXI+eVeqjaP8rQ/txAvu3Rg30MLTSkh;4:kNsY+U5pKjg25C98btbRsBBMJwRXo6YGS9FwDP8culP7QOYPAL94R/eGJTRA7VV67rYboF8ckrhBQHnmKu832zpFnmQPXQN1q1JbSjx+qL2SyTk00xVbjIVV9lkRzD0z5R2ntvUfqxr3QCxgw/YhVrBb+ha6+8/No2pPyvhP98+fkXAEqSjYmc0qvkj8KU01TcrdQPkJYHBBwGwD4tYu7nsNaI+C2vcbPvQMD1c0/RsiaOdsWLVsXklQTVaB40LE0DEJQXbRNZJlwMmz32W0mbgLkNnboh658YFzWQrGPXdvUk+jrJgsjmnVt7aXXhGO
X-Microsoft-Antispam-PRVS: <BL0PR12MB2355CD55808B40CAA33DF467F8050@BL0PR12MB2355.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:BL0PR12MB2355;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2355;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(366004)(346002)(199004)(189003)(50226002)(81156014)(86362001)(81166006)(54906003)(109986005)(36756003)(476003)(105586002)(39060400002)(2616005)(26005)(51416003)(956004)(53416004)(386003)(1671002)(66066001)(53936002)(7696005)(52116002)(3846002)(6116002)(47776003)(8676002)(68736007)(6486002)(16526019)(486006)(186003)(478600001)(2906002)(48376002)(316002)(4326008)(97736004)(5660300001)(7736002)(305945005)(25786009)(16586007)(14444005)(8936002)(72206003)(44832011)(50466002)(106356001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2355;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR12MB2355;23:PffBFd05xioe6c9riEAEGPDu3SjTyOHVMs2mIZDfA?=
 =?us-ascii?Q?sw8IpPnuI8cQPPo11yioxo03aCxBN08PvzjVg3VvyBFTFuPf4J+P/iuXbKxU?=
 =?us-ascii?Q?hp0mjWdpK9PvFKo1bib/VLcN6zbpbDZesGaS3SUdZNApvMNmfWa4VaF3RUIx?=
 =?us-ascii?Q?cf9zEWfmNcBEkVjv/2gOAjni1kuTTtM/touHP41Ibe4Pp9Nl+psnI2NE1IPJ?=
 =?us-ascii?Q?hZ9NswMaCMeQbIE3fVzbM4U00NRvPRieGVAKA502sDAmummLIZHHaJIxz+Mn?=
 =?us-ascii?Q?noL4kULYXI8UhVuv+/JfNNkaP6GmU+v6e+Du9HNpElILpLSLpvVr8U2qA71O?=
 =?us-ascii?Q?NS7VKsygDnxHMFQ2snwhroVgs1grHGT4UUeW1PgvOgpS46GRH60wTh6R634g?=
 =?us-ascii?Q?jq2fl8JO4rAYv6gXc6mxq/6+O/rnayaV6c+nX+ffSvNrfTr3tKe9wxrS1WCL?=
 =?us-ascii?Q?uSjjWGGTgfy63inPZUYs8Ww8efU3wYfmngyDlwiRAlU9GhKRGeYtLVzIYmqF?=
 =?us-ascii?Q?BcBqFxgknjZaHM1wOUc1l9wDNoTHCyrqsJke7fvNcLuwKiirXs1Iybc57w7h?=
 =?us-ascii?Q?JBbrt4UovyjRXzTJUKso1LhQBuxEC6c+jHHWZ3A2Uk3Au9sNrPAqlGxRs6Iv?=
 =?us-ascii?Q?c+/TNUpNjOySmopySV6SknwmYP+mE05b/vCwLby5jI/O9MgeAiIoH3aFeRUW?=
 =?us-ascii?Q?kAQKz+N1q68qx37hac9UB5BSl9zU6BwuXczo62zALxUOMqifSrrz6h/odGgJ?=
 =?us-ascii?Q?TLXOrW2Wyw6nVKhrqbfWY87p4YNop4hrGoc82MTAFaLEws3zla3uFVTfmT56?=
 =?us-ascii?Q?3NpnVCx3tKwA1GjpyQDqBW+de8llk4hsqrsN2xLg32wKglvTcjOnWUF5H5kr?=
 =?us-ascii?Q?K6Ma8jpRv/Y65iOi3AqUlaVT6VE0z4m5QZc3lCxl36EdAOjs9LdE9AXWpIck?=
 =?us-ascii?Q?wPE/o+vHJTK+oFhoRDroA/oWX9U/FcywUSNW/UMiwcMEaEvYPig3N4F4ULql?=
 =?us-ascii?Q?VgDOLo0VmVQYbm+aQbGhgKfshVgsCJYeDouXEdYBS0HUKOAYoqh5n9YyQs+y?=
 =?us-ascii?Q?swZZZq6yXk1nZdQxhieW6xTrX1fufIdxg17LbiYRmbPNjTHW2krY2NQLQYeF?=
 =?us-ascii?Q?r92ByDHSC4s3Hpgqv/Sck37Ql6kOPhyFHmQNAEpkFhqrhJCqQa+uGR6roy3l?=
 =?us-ascii?Q?USnl9YO/vRxj71IDexBJEirhFrj4fygSaaBKL1zXuZm77biBW2EATGdRDG/8?=
 =?us-ascii?Q?vLP6T9n2irOmU1smiM=3D?=
X-Microsoft-Antispam-Message-Info: cVsrwjA1t4Udnj2ZVo1rZk9ASUN4oIG5R0zCy+ITPmK+QgkEzkcnhaJEhPW5hjQJxYZLhz1IRYj9FDebffULNsBd+EC2XP1frH7N3M9zDofDaXdSEou0+9YMSDYLANKhTOkC3jfKkjn59hB0plgPQsnXtr/xpNjf/ahm1a583y5OZA6E0A17w9HkT7zjy3H+csJTQMBD9DEZVQPN6sBD3IZQK00bgyWHn36ze6Ficq1og9X2vpWS/FZEryY7DOo1Z/aDxbUiHnyf7C7kXoZzw8KsqL+EJsSxXiJR8VS7tI8znt5hygTiAsWJQu83tZ4xJn6rQjgKsjawOlvI36pqCx1tIkJ8qc/LUdxOjDEZfx0=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;6:LQ/ziJvzkP9b5I+rvNpQc+KmuB+kB3syeEdbW31bksUqB1M6lFdS0mbv1vh6Ijf0UOrKNGgjOHd5yvrlXq/ehJjen6Cry63t2soQyEuVfrw3hxsNwxCa13KIqPpnE5XZI6VdPSNMyWXCnhpyEx6rMyFWhLdrCiyB1N7zeIlyGFOnrT3c6i3+bpOkUIshiXLlaDRDExlIWV+5+1iuMV7mzhROfzFKR0QB+vCbimEagi6eoW2sW3YCdo8/XtPX0oEDEJzLDzalZowLkIEiGim+Ohws2eS15G4VKeIink6l0j97T5GnrJEvleOBfbYE/UfxdPepPRZnRPFvrP3YrFDlfO8hxyCiZElCxA9FZ4++yaVsCWBiBi0IVCj6DUxIyrm9D5Do9e2QcAmuTbCP8mWI83P54qSyeX5Dj5kQI3yqnTRsfqJAKTC/f173af15P0JpP7YmToc9mMFu2KaQ1sUklA==;5:sm9dBe0436Kak4ROnQgmMJgfVJgEsjWPDB+Llx2I5vq/wD7QWFcDxk6LxdTWjYPRpjdtGaHSuB0RONLxmu44nBtfM8KPU0nA31O+SjAk6hsxQ1fc21ss8TE4cTx+26t1fAb+FYsxocRht5kR5f9BgArUg4SrRIjUPHrQDEGAZoo=;7:KcgHwRn4zkmXfPdCYYoOKRlGRZdsQkpSynvSDNtGgv1wmvK6kkKH9gEBe/DMUeGvJ0Xs72/dXUTgoNSB+hk0EVjsS+28aT6YgR7Ryf6xCMBWX3YKk9rlmAozK1nNwKKMyvMQid901T6gKlFvHzRcedjj1OYxvbleZv3Urt4d4LDgHZCOVuUdD/RWut3/Hz3FwgPEb2FCOSLlbhougb6e+133D10PpOjtfF8qaZTfU3fyKPpOmdY0K3+XJiRxH9hl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;20:la6UMO1jfKJ4JCvIbws4xcH1kc5yJlFzPzQJ7IjdpqfrkEWxeZTVyem7LZRvT81FkqROOK282CgwNg0OMY4tOoJXehNeLlzQ51b425qLN33ajlVLJtP1i/jcxfcw5fZlhHe8ywyLWObVU5BeddX98RMrSDoeI6OyShGvSyXErbn/hGjeaFMM+yhf6BDjaSwLpjVyTaLhx8rBp+aLKK/zRrklFAspnShPK+2c/vJTjNWpRbHhtEyTrCsDT69vPBcT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 08:07:24.9105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ddcce6-b2c8-4c77-eb32-08d616f473b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If capture and playback are started on different channel (I2S/BT)
there is a possibilty that channel information passed from machine driver
is overwritten before the configuration is done in dma driver.
Example:
113.597588: cz_max_startup: ---playback sets BT channel
113.597694: cz_dmic1_startup: ---capture sets I2S channel
113.597979: acp_dma_hw_params: ---configures capture for I2S channel
113.598114: acp_dma_hw_params: ---configures playback for I2S channel

This is fixed by having lock between startup and prepare. This ensures
no other codec startup gets called between a codec's startup(where channel
info is set) and hw_params(where channel info is read).

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 3879ccc..b98ffbc 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -47,6 +47,7 @@
 
 static struct snd_soc_jack cz_jack;
 static struct clk *da7219_dai_clk;
+static struct mutex instance_lock;
 extern int bt_uart_enable;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
@@ -150,6 +151,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	mutex_lock(&instance_lock);
 	machine->i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL1;
 	return da7219_clk_enable(substream);
@@ -160,6 +162,12 @@ static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
+static int cz_da7219_prepare(struct snd_pcm_substream *substream)
+{
+	mutex_unlock(&instance_lock);
+	return 0;
+}
+
 static int cz_max_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -177,6 +185,7 @@ static int cz_max_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	mutex_lock(&instance_lock);
 	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
@@ -186,6 +195,12 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
+static int cz_max_prepare(struct snd_pcm_substream *substream)
+{
+	mutex_unlock(&instance_lock);
+	return 0;
+}
+
 static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -203,6 +218,7 @@ static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	mutex_lock(&instance_lock);
 	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
@@ -224,6 +240,7 @@ static int cz_dmic1_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
+	mutex_lock(&instance_lock);
 	machine->i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL0;
 	return da7219_clk_enable(substream);
@@ -234,24 +251,34 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 	da7219_clk_disable();
 }
 
+static int cz_dmic_prepare(struct snd_pcm_substream *substream)
+{
+	mutex_unlock(&instance_lock);
+	return 0;
+}
+
 static const struct snd_soc_ops cz_da7219_cap_ops = {
 	.startup = cz_da7219_startup,
 	.shutdown = cz_da7219_shutdown,
+	.prepare = cz_da7219_prepare,
 };
 
 static const struct snd_soc_ops cz_max_play_ops = {
 	.startup = cz_max_startup,
 	.shutdown = cz_max_shutdown,
+	.prepare = cz_max_prepare,
 };
 
 static const struct snd_soc_ops cz_dmic0_cap_ops = {
 	.startup = cz_dmic0_startup,
 	.shutdown = cz_dmic_shutdown,
+	.prepare = cz_dmic_prepare,
 };
 
 static const struct snd_soc_ops cz_dmic1_cap_ops = {
 	.startup = cz_dmic1_startup,
 	.shutdown = cz_dmic_shutdown,
+	.prepare = cz_dmic_prepare,
 };
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
@@ -409,6 +436,7 @@ static int cz_probe(struct platform_device *pdev)
 	card = &cz_card;
 	cz_card.dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
+	mutex_init(&instance_lock);
 	snd_soc_card_set_drvdata(card, machine);
 	ret = devm_snd_soc_register_card(&pdev->dev, &cz_card);
 	if (ret) {
-- 
1.9.1

