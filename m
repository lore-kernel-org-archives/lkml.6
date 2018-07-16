Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C27ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6512086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bKiU7/Ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6512086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeGPH3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 03:29:20 -0400
Received: from mail-eopbgr730063.outbound.protection.outlook.com ([40.107.73.63]:60032
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727540AbeGPH3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 03:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+BTeOYsMttBsTNtmGexOm4hZugHFsi7R0o5MQZArlo=;
 b=bKiU7/UbvaBOq8lC9vhQUzlXqjq1kGTCg6sdWsOA5m7BHGFzKXKgQ8/DSTNPx4LS+OqQmgszNED18w3DQDjLE3Uv0J9CwWh1FXcPA0rDKCuvjQ9lKTabS18chKVpviPpa30bgn8yMwRqCjFDcmsm8+iEHnodUa3SP2uO4cnC8J4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 SN1PR12MB2365.namprd12.prod.outlook.com (2603:10b6:802:25::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 16 Jul 2018 07:03:13 +0000
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
Subject: [PATCH 1/2] ASoC: AMD: Send correct channel for configuring DMA descriptors
Date:   Mon, 16 Jul 2018 15:02:40 +0800
Message-Id: <1531724566-4019-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::28) To SN1PR12MB2365.namprd12.prod.outlook.com
 (2603:10b6:802:25::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68fe4949-396c-409b-323e-08d5eaea37bc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2365;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;3:1kpkKVUNUPvHQMHFCS0yB6ruI1V1OFDpXZLWyYZY6h48wrQ10/l6g6SIuQvhMZTPuzNCcPHYdfePwjYsGAQsTbwp7RU23d9A9QPgzVg5u/lrxREquCDFa55yHmeqTkK6IRUUR009hserxTSPnkM0P+jjVJhpPb3SEQQ4/Z1iDl9+ve7OFRhEVXCJY8QijRrt0TjVDyaGnf59WwZVGlZ85/mgxUT5Rl67gm6GhQoDK9dAptlbkm7douOTcmw5RT5A;25:loZL+n02AVgIDWMXhHxkpYS5e12Wodq7VBuO4G7tsXqCl5eMsIZ9bJVA3WzQtWCgby9erbYxapg3z3RDJBjmipVoFy7ty6A11vBdu8ItlbugMZzMoe9PUpJbRFOqrawgEvEC6Vj7M/VeqQN9htbOWmL6YqkCMwnoTcNSUdvMqXWLidTD8aa1JUgmEgbZCIV95h+WtbxbIx8Nrf6pw8Nv16GzH9mkUiqKyP9mUWaMC7F00J2HTJQp4r/sRnz8hLblkWgtce/Qp7NCljjv93iepYj7dAtrGhpwyXF2aXIgGaIhomgC1scTuiqTU17l6oaTrbnvUD4cCeTJEkp1+oQSww==;31:wOAGx2j2XkZs5v/ur7aMN1c+efwzvajItBUcpgGxUVGPRfwcY9Xfae7J2fkP847z9/iTkVYLNiEGvt26a5avfLCBPVVE02AiB5i75m8du1RjlmJGN4LkkRPk2MgvZ5KAJVKHTTpbeJ5wdb3slwmNLUYW5G/Gk45kvimy52Or9OGn7Bq9X5iVqRr/aFLbbfNPh0PLIwLISphsDW0rHbr7gdyGvnaj+lZ9gjhhEnrdiR0=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2365:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;20:fBSyHPbhXeZAJLPYntixxwwUolWCBFZi1Kv9laoJ8sw0ON9iJIKM5K1RaP7NaHmcJ4JDUg/ctBt666ICVqI01JJ2fvDeTrahpUJAyPD11vsgBaY8rP22Qusqe9Ks8XJzI0qRFmVtH4mV5Sd93XjqB4NlTKb6yqnVQVMPhMgbzX5JDQM0bXUd8xc+1wCsj1EZSefx3fQG3O/tZ6G/W+hBB+qnHxviCAhOazGeQnyoO05hKb5XyMGOmOSTkP7HYmbtE65MRtbiouN0lI5fOTMF8PJXuBge3I6Imi52Z6hduVnrIeGbZ8LsS1r9bDqzCrWpSgU0bFgk+KiJ7qdS5HW5AmD1K9AqbmcYJPNLcsaKMBzgB2hHf2SR0a8Zy5gAu3fcdRYD63nJ0fC9Tj2IOHHdS6VDfVRW7DtRYZ8uS5nzflKmRuuEPnlZY5Pm7BFay4QWrzK4cO8KpGvgkW8QO7hlf+5XORS0PYRdeEdazh7kxkjXmYtzz3gz0a5OzDXmuesz;4:dN9pg9FTahSXhDEdqi1jVJrgvP2N1FJzbkByXhsvaC3B2zRx2nyrhKh7IGPCY1dWy8jiH4dvyWeaGJvJDmrr7OhcXBidv8kvvwQhgHnnyHQoHJnJQEBGNC2IoCx7vAlliaPKfG3YUk3REJQLCNkpWF/rSOwYFtUHmo7eX/2VzxgXx0H04acgvx7aDFEFSLtUwiBe50/weYGc3kPTYhJ8wyrfpKPUQixor/ctR51fc1BjbwBH0o18lEIi6cvetDeX2Bc93fKpY6CuKYJ7Q2Sz5TC5ODANzWkQUVrdl3Hm5yozWb3GfCAMb8/E8fJmz0gN
X-Microsoft-Antispam-PRVS: <SN1PR12MB236557213AA07DB3C3897CDBF85D0@SN1PR12MB2365.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB2365;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2365;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(18054003)(199004)(189003)(51416003)(6116002)(16526019)(6486002)(1671002)(386003)(7696005)(186003)(48376002)(36756003)(26005)(72206003)(52116002)(50466002)(478600001)(97736004)(3846002)(106356001)(105586002)(53416004)(316002)(8936002)(50226002)(5660300001)(2906002)(16586007)(25786009)(44832011)(14444005)(54906003)(86362001)(53936002)(81166006)(81156014)(4326008)(305945005)(6666003)(8676002)(7736002)(109986005)(66066001)(2616005)(476003)(956004)(47776003)(486006)(68736007)(39060400002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2365;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2365;23:oErFMN6zNjpqmkU+RxygE8BTw9bIMIqWf9LLQx6RM?=
 =?us-ascii?Q?olD3M9AIIlYje1PWPWzxDLnNaUlOIMRlu2/MuDEpz9CJTDEgAWZmq5+/hRbO?=
 =?us-ascii?Q?eIzdjSm7ZV3+PrFqva5a7UFVoy+fAb0xWXcCE97sKP3sbErNm+Se1RPwTrHG?=
 =?us-ascii?Q?yzEoyWDpKROnvPIhzB0IkPu3mMivJX7qJW6yicHYQcExQy4rs938S+4Frjru?=
 =?us-ascii?Q?tlvBp/+vke3aJT+xIZR5nNtu4iihRZKS7L5k7b894NvdiGX2GBYepc5Y1gcS?=
 =?us-ascii?Q?dTbtjk3QDXV1SwpfzJSY5XQrnGTAa2ZwvPkuvwFi66PDkKrIXX3GrjedKGOT?=
 =?us-ascii?Q?ilPOkN/TeQhLv8TgRr8D9MMKx+YjFgx9PkavCvrCIEXWEQPjuEBV6aQchNv3?=
 =?us-ascii?Q?e2gzz8ZOOgxOvLgMnwV76GOLlT7eFDMKDrwkEpz9HM3kn/ogT99D+h/WHVXS?=
 =?us-ascii?Q?xyZB8aFg5Rm4VE7FTE4CIhjdArZuaP5w7P/vo83x3/+wpnahcqPrQhBhPoIS?=
 =?us-ascii?Q?mWFhYqaYzzTO9EaA+T3ZLCKdwazM3JaN84+jEqtktj63ju/gdGeX1MtuiUrw?=
 =?us-ascii?Q?hSczyVhoOGIZ267ROgUADUm78Cwzi7IKEfBDKjZhr3YcUezAGGNXqIxBNPZR?=
 =?us-ascii?Q?bZInMhgLZ89aPmqZZZxWbqACeaY8dcKW0dHgyK6stHo3SCXMJHNs/rNoeEcd?=
 =?us-ascii?Q?kRHY+Ijo2Q44poc3M08eQ67wDPBeX/HROIz+9UdqmMYVCw2v0rDUCRITXbuU?=
 =?us-ascii?Q?iJhpmRzIxOktfUq2XUtiVqgy6tCRvY737k5/Vqf8zvPLOeghndSIHyiUuzfB?=
 =?us-ascii?Q?TpgDyKnrBPucstj8Ma2NKs07WCtALzMm0C2ofLK48sz7vmRzVg7fl1D1Spdv?=
 =?us-ascii?Q?aHKAi6Tr9t+JTC88V52CjkCG8SelEJo7xlJDqqRMpC2nhPSu12PY/RdS3mNM?=
 =?us-ascii?Q?z3z/Sbed7xF1chOBE7VArVbKSZc6RVQWHGych8siC4MhKu7kTSVi7GGHep2G?=
 =?us-ascii?Q?R16YDkICRXg7yOw8449Vb6v3wtzo02iSU/96JFkOMPl7Y6VfFiA8HwnvzpYE?=
 =?us-ascii?Q?mpUBblBwGd4qnQpII1sw98ghgataqoWwN6lCxojhPJ3H3cpG61whAV0Q7LPl?=
 =?us-ascii?Q?mGtzU1A8d3ycpIXsoWV59KY+bc+ItFBVPD7AVPlkkWx31RFnL/3SEcnCKTmV?=
 =?us-ascii?Q?pOOL85z8BlGveaNBYUm+5Hi9kiTU5yVYwokwMHQI2SLx2ILY8c/F4F5Vzmdw?=
 =?us-ascii?Q?TOdMO9NJPnTQw63Gw1iGg2Lq2X9MX2JZs0q6gyTVnsInmMu3/2LFr7MDW/A9?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: aPKqquEY7uskZOXLTcGrzSovs6c4gEdNqt0jbE/EC78ABy8LxLIH13M2QBl+/HChVL0uiUpwNlODfX28YGP+OIcdh4ZybdwktvWCSPRRbNLlYVSQoGmVp/5TKoh2e+qQyJG5yHU8etsu0hF46YGOvyvQ4wbw11T8qmDjo3WcnNKV/Mdr3kYMmp1gqCstoIJRqmP9GfLGRWRCEVzz5kByzTLiAhk55dYYOIQMKbVr2LxkUfVvxY0HX+zcWA2A7A8b24apQv6dfsv/mFDTLsIvzerV9WYvKabsGXT2p68CqeJoQZ/BwC06ZGjJ8fodPjYi1ub7HavjiR7c91PTWPBVRgHCG+jVqK6DEN3FiCurGYM=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;6:9RlmUcJF70C+m1sfwHUyOL/Ak4K8aKL8x0fYZaj3fW0Gewi9Z5LM1ECW4pt4Bgcvr0JvNwQZ2drdfpzVTCpHZxmzHZ8rrsvSm1kDLx8s6eDUCrqcZMWxrdLvWHLlh412sx2ahO8e8araXxWmSQ1t8VwwgcwZfjqi3LImAFOKXmWTLorOWmwWzuLgcO1Pm/mCNH4wrFRJ1OUFq0dCS39G+W2D1tSf8eWUi9WglJ2gGn143DBJk1X7kHvljAMrsx4DVqceosuHA2aiKsudaKzKrV9y828lc4wmy9Bio0y5MbOZ5ntcRF/dNwRGnjrFlXTcXkeVDmqsS9X9snT5lh8SGnBs0Tw4ffMSwWZI7yf1InsoR3BO2+gTCGhFZgZ8ZMUrX2TMTGQX25buQNNVOfrYZ5sANw4LjYwKRUcsHV46xzXXGVqgPv7ihaGhEvpDjerRktZa4KV5N+uC0fxuD3ss1w==;5:UE1WRWekaxgVCegEWRVLeZEEn3qBdlmiOfiI7qqgANKurkvgdhxdmXtMT0O+EiI+pro6Kvt4b725xGiuaPvYEttggZKFr5micicC2PiJDe6MuYY1bERTdgfycDTOc5USXLJRXfAHdtKue1IfmHIzStE/W4wM/3YwKa2plhNnKiw=;24:Dm1C3aZ3nwC4BQBNhcPz2cDCUXkJAK/ZIDWUHCnws/S2NnrIg1j7AxNggoQ9UzkQuUNZgZ47Xm93c3APOl13CT4hN9qnCLFEfewilw2kVlI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2365;7:EUaEQ1p0BRxNQlDp3Er3G0eopYUplVw3CbJwsTbTPzwFuLLkOnLIaOVGG+FyF3oU8uEy3qgy2RujFP88n9+eSdhyIzk7Geo4l1UOi/a3PdfEl71Z5ITnEYHubnWWn1wGLeQ50AAi9gQh44QM6JuA6JY2veOzga+vc4OyaDAVQJ7/iPYOFp8UzFNmLNhbD9yx9mZpBoYxRAW3ehQGS8mTWWwoVd6wuayevdJMkm5Pv47L/181cq98wQzAV96qH9xn;20:+GjpLq23+Uds2TwBm8LoiaGvUTTeYBe0opDQ62MyVV6jMFR0qycJcaBXndxZ/Z3/uu+5n/LC+ZpjiuaB+B6fI3m+3H68DG/IzGcBLY2d2z+g3xF+1bVugL91XWeFYKYhfH3eGWLBGc3vetLhxnHBfxOr4rmnZbIBLDjohhCkLhGbiTb4c56ZV0gvfN+5GfgZrIJltHiExVq3KYpFrrIuCRrWOQJ4Yo2n78zmfyMjDffyGvlzAVORcHEWnl4Y+PdS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 07:03:13.8591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fe4949-396c-409b-323e-08d5eaea37bc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2365
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier, ch1 was used to define ACP-SYSMEM transfer and ch2 for
ACP-I2S transfer. With recent patches ch1 is used to define channel
order number 1 and ch2 as channel order number 2. Thus,
Playback:
ch1:SYSMEM->ACP
ch2:ACP->I2S
Capture:
ch1:I2S->ACP
ch1:ACP->SYSMEM

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 65c1033..eeb8677 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -322,17 +322,27 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
+	u16 ch_acp_sysmem, ch_acp_i2s;
+
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       rtd->pte_offset);
+
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		ch_acp_sysmem = rtd->ch1;
+		ch_acp_i2s = rtd->ch2;
+	} else {
+		ch_acp_i2s = rtd->ch1;
+		ch_acp_sysmem = rtd->ch2;
+	}
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, rtd->pte_offset,
-				       rtd->ch1, rtd->sram_bank,
+				       ch_acp_sysmem, rtd->sram_bank,
 				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, rtd->sram_bank,
-				       rtd->destination, rtd->ch2,
+				       rtd->destination, ch_acp_i2s,
 				       rtd->dma_dscr_idx_2, asic_type);
 }
 
@@ -995,16 +1005,24 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
+	u16 ch_acp_sysmem, ch_acp_i2s;
 
 	if (!rtd)
 		return -EINVAL;
 
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		ch_acp_sysmem = rtd->ch1;
+		ch_acp_i2s = rtd->ch2;
+	} else {
+		ch_acp_i2s = rtd->ch1;
+		ch_acp_sysmem = rtd->ch2;
+	}
 	config_acp_dma_channel(rtd->acp_mmio,
-			       rtd->ch1,
+			       ch_acp_sysmem,
 			       rtd->dma_dscr_idx_1,
 			       NUM_DSCRS_PER_CHANNEL, 0);
 	config_acp_dma_channel(rtd->acp_mmio,
-			       rtd->ch2,
+			       ch_acp_i2s,
 			       rtd->dma_dscr_idx_2,
 			       NUM_DSCRS_PER_CHANNEL, 0);
 	return 0;
-- 
1.9.1

