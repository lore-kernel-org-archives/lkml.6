Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDA0C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF2320833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t+GjDU4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF2320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeIJNBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:01:08 -0400
Received: from mail-eopbgr730064.outbound.protection.outlook.com ([40.107.73.64]:18940
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbeIJNBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGjJk1WhGgn2rOQ6EvhKwmOPXAMeK6A4IVGBURYf9zo=;
 b=t+GjDU4jMv9G3hoMTzUn7XRvgveNfGwe+EJJOsZxWlyCxchsGELzk+8mgj8drd/hGW8h5IFDSY8kb96zZndSTNWyNyfXyDkOAH0rmH5HIuLqo//m0QOfTXnmFwBBC+JGbQfE+DCRuuOaM4tJoKoKXu2LHWno/wlQP5/L+RJ/Hig=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (165.204.156.251) by
 BL0PR12MB2355.namprd12.prod.outlook.com (2603:10b6:207:4c::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 08:07:33 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] ASoC: AMD: Ensure reset bit is cleared before configuring
Date:   Mon, 10 Sep 2018 13:36:30 +0530
Message-Id: <1536566815-3271-2-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
References: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: PN1PR0101CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::25) To BL0PR12MB2355.namprd12.prod.outlook.com
 (2603:10b6:207:4c::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43fc20f9-8e03-47d5-5963-08d616f47b5b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2355;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;3:ukIAxS8feAUPzRgBhWsS2z3X/f8jL0m6Ix2vnMkO+oR7TenZiOPBC1++VnD988vwPdwfCmixDs+ZYZK1x4hk6rzGWJPBwN2IxH5B40sSLuY7qROMqXF8tu16BZWzEo/v5kH1+Bhgdd4QCmJeeUadxOmsb9aTohSoDgVc847gOeIEEDX/IEKFrXqhWQZjrSZUJxiE/CLnPd5dfDfRbpyzm0RE1m5GZYZJ5smQwo4rjOYjgnub5RFOr7xGedyt0XK4;25:+kykjCuI8DQF0VrVFI1fK7FY+gbFV1RCMpsdnRQfG9YAW/+nTodXNfxTCQY9kEQvWW4wMNffy0WG48qgPA/ggcHSrOnfj30hXSj/h3ZaecvAYtrUHtW8cuPi7CuKw+LONQXJ0fu8UP0lAUQkARiwya3KwK6Xumv4lzw0ytxzWTGvPJkuBoEpmb6fTI677ZMcyBQW7EJ3pLDjwQzWpoemwlbRK5PNBJxsrJWwqA1u5YCnW96FsxxjDeWpggZypK34ghYBAmqfi15PduQ/zDiCDtgZMRCawsUxOp7RPMgoK9vCX/zWtO0CvmeP8npHnSR9Fv6muyV71B9ZQYTEaL7ZBQ==;31:WpTyGpMU/CPnbZHIimShDvu9gGb85mKUaLlC4BYjyJJZFUmKonUCvt4rLA5C4xlDpXbVKebI/I7YSTq2Tz16hQu66VWv1KJwvpbaa+3FJfQj+ovcANsy0VHQsiwR3PEM+dR8aLKVwlhPkF1xJ1Z1cvDrwJ2YU+FN1stKz7sB//YZMs900Pg7YlY0VbLZC8huwDXv049Cukub0sFfVo1zoq2s0ZnvCvvTYxa/zwNEjJ8=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2355:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;20:OKhF3VU1K8sHNTqQEsC3W/a0HWJGxbvlP8xjOQ8OPLfNPfnVma5bmPdzVN3TotBeX1YV2GMwe1Z5zsMixrB4NC3pJtaRsnfh4toA7KKcRe+voAIL/g6s9gsKO9j6u/4bSgOXjW5Yv4Knvj0luv/oUayKFlXLwaBxmm6S6a+WGWlC9OffZHdklauy5T23SX+70yGm+5CEzLyIRYxZg8UlPW9UBWQjs/4e33QnG1kJ2EO7PVL1CBcuB2397Z8UJrfQUVyOTzmRbdAUt7o2DtPhB64jTtBJ3Wrmj3Rl2hp4/G8otnGQaoXI+lz1IS5NTwmbbjADBd0oHoIarTVRCJHB0X/YPOb4bqSynIaTEdmJ/mDmBa00SdbTJvMNk/wORHOC6wvC6MfK02ktNJaYDJvy2X+2xg9s/5EH+wIZePvNZv7nlpTLbdF5n4E0jnUqutEIeoyKF9oOaU1fS9lXV7GNylSMPlL3iguxDeEKNWq7t8KlkClasLjO8zbp5ZT9C9nK;4:V+yT7fiaPdK43I0lJa1QSRj0zxECCmOiLJGYNoWDZU5ueAoSlag3ayHjhO1+5vhEDel425QQOskNMoUzvEwcBOApUqVzFnBl1t5OsgUdttAk0y0/0pWIRrZSudI8pCTksvZ1bGCSsd5JfWApKTBj8cRdfGJ9cBZPH2l+gm7o+fYYwH2HhS4GI2SftfhdHo6zG88ayWHxBa2MgreD61und67XszOcim74IPTVaQb5HlMFrJsHbGO86TqSkfjVU9aXsCq6YLAnJXQJpwnKvGACZWwT9LW6wfCZaubpcgKKzHdj7yzbdrfZ0jUveVvEtu+k
X-Microsoft-Antispam-PRVS: <BL0PR12MB23556C70F02D9D68F9E22B9CF8050@BL0PR12MB2355.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:BL0PR12MB2355;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2355;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(366004)(346002)(199004)(189003)(50226002)(81156014)(86362001)(81166006)(54906003)(109986005)(36756003)(476003)(105586002)(39060400002)(2616005)(446003)(26005)(51416003)(11346002)(956004)(53416004)(386003)(1671002)(66066001)(53936002)(7696005)(52116002)(3846002)(6116002)(47776003)(8676002)(68736007)(6486002)(16526019)(486006)(186003)(478600001)(2906002)(48376002)(316002)(4326008)(97736004)(5660300001)(7736002)(305945005)(25786009)(76176011)(16586007)(14444005)(8936002)(72206003)(44832011)(50466002)(106356001)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2355;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR12MB2355;23:IYRoRAhfvh4IAbGATnOEhkyr7NSUFqLLIhY8f/6rS?=
 =?us-ascii?Q?vAxqwrFrxlsBXsavIVP77JfsaLeWAfEU3UCCHtSpI24wQ0JRWFow3L37mR1W?=
 =?us-ascii?Q?y9xqgHAoOLw94Z2rAzOtb9+o5PdhybzlJ4MBFzZhyyMc7tsDzp6tIMsYgeF7?=
 =?us-ascii?Q?GH/dEa3olEJYPV2B5NElxJRWs39xNmQhe3kVkJ7vWk42sNmDQe6gcplF69Ne?=
 =?us-ascii?Q?xD19iSP17VhZ605VnlmLaCI4KnlJZoQ7n+nGUv2i/zjpfgirMoc3a+dOJhB/?=
 =?us-ascii?Q?Tqv9mldwU2NR3BRS8kIgp1k3F8qcvnPJQX5rjRvYFgNOs5wwoy1bSdLINLG+?=
 =?us-ascii?Q?LwkfSZzR5Y+eV3q1waTrCxmq6xhPcHm+1mAYRtV1kwpkP6F00AjNfVBFh4EB?=
 =?us-ascii?Q?D2P1hC/MJPi+HioEXSYUiM4UdlVpVvYplMwgJMhaHsQEwwRVW/EOOGRNj2TS?=
 =?us-ascii?Q?fOY3OH2w2TbS5OPwUWitA+GEIIqKQe/e5zPz+mu/6filRBj6kw6QfUiQjL+s?=
 =?us-ascii?Q?MhZFyEbzJTHQLzi0BroJln/RrP1B3e2Fk2czwpIwXSVxSmrPa19UeVmeDtd9?=
 =?us-ascii?Q?3FgYEpu2TLtjpjSRNIprgrRQUaEK5dEFjjF5h7E4y5jRQYoMBF6se8ZVNEio?=
 =?us-ascii?Q?+3UbyMlgqaPw7LSVjZYcuYK1ehi+2K+BU2DXJV9KAjJI7Gx0lDCq56Aur9g/?=
 =?us-ascii?Q?I7u7OfG4fWWaA53iYjZSVrBAwx1sUaR/XrS4ciJbGmC4XG1T0cN7kg9GEODY?=
 =?us-ascii?Q?2dD1LvhXfTI2EhiVjzVJEAJxnGTkUL2JU79PqlmxRTlkwlnBTJwdsTq9LYvF?=
 =?us-ascii?Q?64i//Jw5jO+VQYzA0MSHLYmJqhBHGTPdHHb6wufWS1sZR/ICv1cDB6EIjeQA?=
 =?us-ascii?Q?0SZbcVER9HrQ/Fmd72uqMHfQUibYlZJEX4+KdUKlIjEjRVBVVrquBRi+a9Wb?=
 =?us-ascii?Q?hzdIMuuMHf1mNud43TfeB1CVyfQFbJoRJM2E/lWiOticJ6/P4U6fX/BRgk2Z?=
 =?us-ascii?Q?oh4fUM5mz7S4KjMIsO9+7MK0e7q1Dj0egdQUDF2FLwzdClF+tHP45pvyII2b?=
 =?us-ascii?Q?wwHGU+GHQXz50ys1xcI09FLxvloiKBotSY+9XbQIl2tOHqULn8E8PktyDw0G?=
 =?us-ascii?Q?nohIuSX+8L4uui2Xr9UNSJwe2RLz8Ler9InQDx0VssG/9iDuEYuhxqgEGCCK?=
 =?us-ascii?Q?Ki6jK2SL9oQ8pZUxSxKFTUshQqXdpt7x3A2yfWf9w1G9YOGbtQWBtLxWSbYs?=
 =?us-ascii?Q?uiCAeTVzRMpfpvRHMVnruouv3ie1YJS/Av8dDTtZYo6zAkBfGYLDfDJxnGtE?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: l0OFFKZ28oHF2sLbaLjKOwUXcf4/1k8sI+owmM5CUGc+xxLHccDlhrOun8d6S0UhxoBSbjAMCwA91Z9vmDi1H5ZGrPtnWZFuYNA33R4AMAwL7EhxdJraLwYxrDg8Xlg6Om18S8RkbwITXOdzNfF2H0Vj61deV+J3hOs1P+E+BuZwmOfB06XzwrqXNEClPzQZDF2POtLVKv/93jrLcBv4icLfkdHdRaCVekkBd97TG4/vABhbKVuZ/8MPbe/wZh+7ZapqikrKz8obpQxizDaWofvkf0BFP/yREP1ZSADQ+2q7QcdOXPqeDCiAwSLjHcTVcqsYb2fYDiKeBXkFOvAvYtA1W6nCZ8xvj/daZ+pGgQM=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;6:B3s8rawMgwgSYY8fwAYPqFgKzrRA1fejmyjjU9pDonzpRVHNFbTwuyT/08erfys4fh6lWEmb37HjMXuzUOJkv/oPT/tJE4D47Y2S9wTdkBC40gejEGT+8KG0RND5cTtfOPy/FuIA0vLItwnjDAUsH7qmBqfvJ6RAB6NYdgSuPl1S39Aqr3DhjcGmCFkQaxASopVsWyzJQS8qlotw7w5HOxgtynq0ZPfjR/l4S5LUOOJ+rMsysArg+btfs6jnvGHaUBRGuhWo8lWaEiuaZd0ACLadf99Dm/iew5STtEthxnLIBxow/+Q9PoqBOJmhX/8Ra3gD4cMXmR5aIqurKhuXYpVdGFUoNrL7WzI4DDdAr/2k5BAW/KgpZDFyDSSi5v8D/haUndpCduQUmnBbsFO0wg9OrX5nhTeZ1a2eoi1L+YOKlNvocscFqOcJ4Dg+uOTGZIoxchScfTs4ebe+ohSqXQ==;5:8TxQ+SXxIaVfk+w0CFvTgou5j0zIzY9Cz4UIujTKtPulZ5RZ2kxX1z134ZkHD2PPCxvy4GGokik56GjjfFih6cZendGbBWGoj8N7Ds9gPidBIIVnobX0Iu2a97MmB1GIYqLpmChAKmX6vl42BPy5fBUnPmwY4p+vIX1ry0YACxo=;7:fpEsv3BpUZf7gPoYk6b7lE0w8XZtkeXnb6ZagrFSwAXYh6WwYj/KTl8vEPCof/QWM+7SbAiWM81D31BnfjSmFwDAqC+iofpG2EwU/A5dN/jWypQLAcqFs3eR1S+m02lKi+HBU1NDhhXNubXwp69XzLAS5Df9eCheFqVr17gdcyT9NWoga+YSvW3eXoL1zZ04pBBdD7l1E0kLXtROHbnql38C9LmZzzO6FciCJ2IX+aUwpdkiQcy7N9FC60k7z6tf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2355;20:Jb+B/zyl+5Sw0EgNBDrrmIorjjQmbEJGQfcKKo8D3PB8j+OPr7AFVIwmT29E+IFA90Vity5dMrLtm/s0yte2ttNKRZOf/zDiNfB1SPvOoAo3PesoXDnIXwiN5AgVRX3SUziW0I8pTqQdlTD3lSzkYln85KXxKd+xi5KrIPkl9QZV+SKUoNsXwscIK/eFlWnX0qeSRR2skvpT9b57RzkL2sM+xJunemNNoOTXA8IhOjg3y6TKROPmoTH6k6RHBXMh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 08:07:33.0200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fc20f9-8e03-47d5-5963-08d616f47b5b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2355
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HW register descriptions says:
"DMA Channel Reset...Software must confirm that this bit is
cleared before reprogramming any of the channel configuration registers."
There could be cases where dma stop errored out leaving dma channel
in reset state. We need to ensure that before the start of another dma,
channel is out of the reset state.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index e359938..77b265b 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/sizes.h>
 #include <linux/pm_runtime.h>
 
@@ -184,6 +185,24 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
 	acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
 }
 
+static void pre_config_reset(void __iomem *acp_mmio, u16 ch_num)
+{
+	u32 dma_ctrl;
+	int ret;
+
+	/* clear the reset bit */
+	dma_ctrl = acp_reg_read(acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
+	dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChRst_MASK;
+	acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
+	/* check the reset bit before programming configuration registers */
+	ret = readl_poll_timeout(acp_mmio + ((mmACP_DMA_CNTL_0 + ch_num) * 4),
+				 dma_ctrl,
+				 !(dma_ctrl & ACP_DMA_CNTL_0__DMAChRst_MASK),
+				 100, ACP_DMA_RESET_TIME);
+	if (ret < 0)
+		pr_err("Failed to clear reset of channel : %d\n", ch_num);
+}
+
 /*
  * Initialize the DMA descriptor information for transfer between
  * system memory <-> ACP SRAM
@@ -236,6 +255,7 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
 					      &dmadscr[i]);
 	}
+	pre_config_reset(acp_mmio, ch);
 	config_acp_dma_channel(acp_mmio, ch,
 			       dma_dscr_idx - 1,
 			       NUM_DSCRS_PER_CHANNEL,
@@ -275,6 +295,7 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
 					      &dmadscr[i]);
 	}
+	pre_config_reset(acp_mmio, ch);
 	/* Configure the DMA channel with the above descriptore */
 	config_acp_dma_channel(acp_mmio, ch, dma_dscr_idx - 1,
 			       NUM_DSCRS_PER_CHANNEL,
-- 
1.9.1

