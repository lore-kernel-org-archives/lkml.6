Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E392AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A732218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ArJa+DJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbeLSRTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:19:38 -0500
Received: from mail-eopbgr720076.outbound.protection.outlook.com ([40.107.72.76]:7136
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728199AbeLSRTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yD+f7fZf1uIdmJSjjeHTa4NQClT7bNwJNL3zH7z2Fo=;
 b=ArJa+DJfXE24FG48hLXhDou2DcFhWt+L+kPdq31sIM0a1JSas7bC2Mkc8EdqWNb2prXqFHlAZ4GvZMwB8Zdg9HPh8amHEs5///9HaxMOYWD6oVDWBOVHSxBclwHrnWa6LC6jqoYwpCvZ9zYChBDlZ0PvPXUhqOqTVu8/MLTGLh8=
Received: from MWHPR02CA0036.namprd02.prod.outlook.com (2603:10b6:301:60::25)
 by BY2PR0201MB0728.namprd02.prod.outlook.com (2a01:111:e400:2c8a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1446.19; Wed, 19 Dec
 2018 17:19:30 +0000
Received: from BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR02CA0036.outlook.office365.com
 (2603:10b6:301:60::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.17 via Frontend
 Transport; Wed, 19 Dec 2018 17:19:30 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT014.mail.protection.outlook.com (10.152.76.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Wed, 19 Dec 2018 17:19:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfVF-0004vW-3Y; Wed, 19 Dec 2018 09:19:25 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfVA-0002m0-01; Wed, 19 Dec 2018 09:19:20 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBJHJF10027029;
        Wed, 19 Dec 2018 09:19:15 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfV4-0002k9-Cv; Wed, 19 Dec 2018 09:19:15 -0800
From:   Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] ASoC: xlnx: add pcm formatter platform driver
Date:   Wed, 19 Dec 2018 22:49:08 +0530
Message-ID: <1545239949-112845-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(189003)(199004)(186003)(336012)(426003)(2906002)(14444005)(126002)(486006)(4744004)(6666004)(356004)(47776003)(2616005)(446003)(11346002)(476003)(7696005)(51416003)(48376002)(36756003)(110136005)(2201001)(50466002)(16586007)(316002)(76176011)(106002)(305945005)(36386004)(9786002)(63266004)(26005)(77096007)(106466001)(7416002)(5660300001)(81166006)(81156014)(8936002)(8676002)(478600001)(39060400002)(50226002)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB0728;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT014;1:DTdotz3NwldognlrgRPsgQEcL1iTM5y9b8YlZ2BdnijjFn1/kNUhbHt9Ylcab03wB9Yk4NvtW6MtOKuQyZQ1diKbWojfBUP9yjtPVSK74v0nBUoTqYeEtTdIYLfVAUwa
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5348d3a-e0b5-4138-b3b6-08d665d622d3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR0201MB0728;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0728;3:/C1nyTI8US0vrVbGjBkRlI8N+C/EijX1mwO2qld9xiScFcTwANoBW/p61UXxFUMPUb0WGLTu7UC6KkQ1XKn2rCl40zabAAz/J4waTACRAbb6U8bZ8bs2ycF+VxVomAehfxz29XHgWz1KoI0PvyVnNwkMlTitL7V2XVgMNFOrclQruLXKWZhPmwuWqwDZkKb3Rp6pMAzRt/Sx7lZP0u4SjBCXXAq2RX4HwAiNIrODE6+O0f2UZ6ckGm1CK2rUm1Y8sGuMRBj9Jy+o2fw5wVjUUJ6DNvnaEzy/bLgpc0XvOPgdcr7CEk9NQw0GDCOCth43AuGYFbues1+Sti9twGTeKnSyeo4TWY/IBdM/qXL3OJE=;25:Mzrthr6+ZneDVbzlIryuCeAlfSs0R0EgtISK4KubkXIlrZVMTTT+i3Z0WmME7wVG8V2cRsUDokao9jnuPYWBj7dI/QdU5D1Lkm1TMb7aor7afqC0IbKKoZucFecyGnzgbsFfaLc0++0p0KcWC6VbBgi7Gq+mIbsF5EpLus1Nio69wAQ9YpERCaowSitQmXBMpGX7uq1+yx4xSRyNR/Kt5w7B4ByCZWfV5MgiScH0PlVag56+fgR+/0mZDKYGWHj7pY8nH5jGiq5wJT1glEA+AxN6lYn1dHR3qOTWVTWWZx6+nK4ABkRRQJGZs8GTt7lSLWwoo9neWpVA+MaLXbnn0aqGnuaTeEEwVNsx7MxNbM8=
X-MS-TrafficTypeDiagnostic: BY2PR0201MB0728:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0728;31:NR3j+xhXxQIWJDrViJ7NFB3D0fYnQp7+Ui9fKKCEPgvYdF8N0G/bJviEvhUIBObY0t7xERyqV9zd5rw8sKXEd+EgEIM6CSC7nMnD0FwC4Wu25N2qdLZTzNIa4E/katwtFIVU5cNYLorslQyVnuKxJss7foFQaDmnJq3dvX60eK2U7PthE8KhGt6fGOVN8LJDB1YNlTzS8EEJQJa2NSp0lEEToDdGJERxAuhiaUPBCJs=;20:zlllv6ci0m6tSMEN+cZf15i9wYuW0klU4PqI0QCLlh7UnTcsA+NjT+k7+MHqiDIcgEXUQ77egLU1gX/IHUgcPQqp3qDD3YmWokJvkSFjP6kMdHqo658PkDCdmyH4AhsTj46ctlQy+zGyeJYcyb8/1124Tkn2CJHRyY4zl3K17C6R3TdqSVGe3kyQBEtNVilo2D0aCIf7p0HrlyuhTKODeZl+twv/V2+aoWvVtE4gVAEK5/ZUvu86bb3nzfhYzQ/E4683+zOQijJgMi6zO50yI1G3Zjoz0t87RrnXiOXL51E7aeNfvhnntVvOocZxzTHwBtNGq7KpYyvRwXxwO1/O0u0g0+K3kVZDGoj69Gr3bFs3s5Lounf1laNj/AK+KGCZHnDSBNOMJXCzpWQly++KTlbAaB7sMA8oSyv6Ie6nkoOJYhqwih5cSj3EoWUomTbBh6asQPBrUVdW+L/nra9i7ZBluSUJP67RpPLlqx8p9hwg8TfaZ6cmMwbsXdyTw1jF
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB07282D559CA53FD70F04C851BABE0@BY2PR0201MB0728.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93004095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR0201MB0728;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB0728;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0728;4:gkRRnxd/7CWNLEysIBAHQZe+M/5vpk12vqYTn+EaLLaXcQS2QGgXx+hl/1b1R8UhHKk67pB1BIszNcg/pWXvxnlHtGgAN8QvZdhpS7zrPRIQIqEOQqOpT1+XKgE6haiohBhm5RqyFFDDNgx6EarVhfRPa7VLIuVz5JL8r1yDQb7iHOdo2dOf+F1ak9mWawWtddl2oBQgBVqbZFOsCu5gOqJnWly0MXduY9nErMJidpIf8qG/CoUTFG297Ys72ax+5iaMU1wCr3v3IU9aUgiayg==
X-Forefront-PRVS: 0891BC3F3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0201MB0728;23:G6XQ9UCqQ8+NZDh9ZeW/7+mNmTJkDCNyN0jTL53?=
 =?us-ascii?Q?bmRE0Gjb6icFyfj9fL7JVG/Qe/fXw+tsp1ItcqVBLJZCHkEXXxSvrQB5UBoV?=
 =?us-ascii?Q?xBxxZkd8AzSTjIEGWhlyxKh+3huIoHH/Qbmpj1LDX3B6AWoKzsNlPu+cHKes?=
 =?us-ascii?Q?fvFC3jqRQ/taBUUnKBx8Gsvop/qLpY3DVjy0JR6Vgmo5pG4eHO9WWSGz26ZX?=
 =?us-ascii?Q?eepYbBgTKAXdBn14timvw+dJE3Kzfd6inC7xch2lcvgc6vTF5F2nyCT/jvpI?=
 =?us-ascii?Q?GIWX8Vf9IFRDUXy8UcquR0dkjeKqpY3qXot8UHYChWi9HPw2emsGqRI4aYhq?=
 =?us-ascii?Q?n+vGsoYkEM4GLjoQw3pVm2AuozBo1hrWE2KJyrCZs72JQHoKRVQHqOdeFYxX?=
 =?us-ascii?Q?XqFa43daoi8LhIwxYUt2cRFo8kT3avGiJMBt8cmO0MinY2Pe7QW6vggopNPo?=
 =?us-ascii?Q?hHm+KkaaecOVqnUJCTLiTKUggl5sG9ercgfnuFNwuzK64iSruIVPkCRu5EzU?=
 =?us-ascii?Q?v9copKvrXIFyl4D2Y4owqQchGf1Sha6FNmAm5ZrAAs0n/ifRCTyKvFV/hoFE?=
 =?us-ascii?Q?U5aTdPOIahOj1RigFKoqUbeAGLDTG8zbOHwCj2VlGAXGu46pI49boz3YY5mY?=
 =?us-ascii?Q?jOjjh8hrTABogLETYgm2tXR5pVTjN8ygTGSq+ouuD1piB8M1pLwpLazy08ey?=
 =?us-ascii?Q?VJ0VlnURcZqD6eivqhsYBHMWa+Jm19szJ9isZJ8IBvqHtiAihBrlWf3pzFmA?=
 =?us-ascii?Q?3wG3yk7N7zhOM11/unF1ziV2A0Sq/d30JlFG6rPrgkqOOakZ9IlYA4HWhlL5?=
 =?us-ascii?Q?1lagVpZPnRFk6r+5Uz98e0um7zs++G81YuGKGRXVd1QwrkQhKpcgJdBJrKMe?=
 =?us-ascii?Q?FwwmKGt375uthMMWf8cauTWPKzYR+JtQlaGF6wthgo2ZpbLQcnVgnbeYw4Fg?=
 =?us-ascii?Q?xza+fwO9jS0uW+Fe1WUw/qc+kqnH6Kk6Ylrh6yg8J0qEkKezMwQCIoI/stDO?=
 =?us-ascii?Q?LG7DsxGV4t3dCIsh7JuUpo0JdNPLZXefvaCpBc04/GyMzGscpSspWPy+j3Uu?=
 =?us-ascii?Q?aj2GuWCuR1IMvOSetNJQaApmRLWGhyYL2eysP8qyBijvKXG4I0henA/oQrlY?=
 =?us-ascii?Q?vY0hmvDehQBzqJ4ShX3c5pYSXkq1f87ZVZPm/TlazDY8iTbV+6KEMoQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: zHtn65gv7LgabazRGsLRX1o4tId66ALLrBPHnEna4/Ts4gXhwOT+pZR7LVGJiGH3SESAhvahYcX3jabQYIcFU5c1GQp97nSicGOZxJ8fFAjarQqhF53ZBUxiTCvE6FR5VapLLHw135d30p1V9xVfS+mruQEQuTxfj4i+6HPw6/4pLweS2evhP0KOfzn4bljSGsZcmjhJXSZidnWcZti63vCCesvMjFMeU12fDpg+FMW7avSPNI3U8p51FSDaFM975BFeKtjFG10YJy9j8pPJgJgwTy/IitIzrMZRXt39nRFBxhQpxUzS3E0pLEz9gv7S
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB0728;6:U0FSR3kjVXXq7rCJGA0tpbY1lFer8ZyvoVmTso+tIxdRPC5Plvq3wSuRsE4A5OED4cqwGywGYPhbhS56rkIbj3Mz33BDvHlbjynHpNbuR6cZdBRxyulSX7I0VicH8GVQLULe2reGB5iBCZPISWGZXRN9tmlYgeBztnI/XWTgpxJ2mcMWSn5AeCfAcOPwmBvKPh9Fqp3WFPQtz6pNPbBHAacpYM56duyHLN8O9vuY9cfOMZcx3AnWpCWr8CqhznxAW6Gl6eeRL5m2+2GTT5TmHhya3Gq2x6M3Aso3oJtvcLnfjvw65Z1gNY6yWMu7mjn/AY79SWPCIRhHKdwwpnTe0/5MuTieX2hS+4bZVIzo5igsTesldeB/wm4msvGmqOgrbPjFAYSif2RyyyKr2Ga3ammEbu9fYv8+d3nKdK7bNXVPFZvByDS/SPOEqBML1ZBrDz0Z5Zow1oqqg89RjGMdeg==;5:1UTG/wMi8gS4BJnWfBREvY+nka22899oSsV7PSc6CxqpJrhtaHV19J+dIiYFYgc4clxNvYVekqk0mebxFltW/rMmSBUUTba5dARw2acXh5tpyGYSFe1Af0lwbFEiHjk5YPfTKQxWDb/a04SLjJMaZQ0QeOLv+c4xwgKiCUMcahc=;7:UxaHuZdkAIecwsJH5hhIK2Z8EB8sx9ag7WunfmhwSAeBruqsloUSVAAwd6j40EG43/SaqE4YA3t66gBf6OvvP8ZeVQnxFfQJGGmgJWhdawSu1cJMPUi2sOdxjzFuLdmTRvSPL6IyiLdEBDWtWqUWZw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2018 17:19:26.1052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5348d3a-e0b5-4138-b3b6-08d665d622d3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB0728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio formatter PL IP supports DMA of two streams -
mm2s and s2mm for playback and capture respectively. Apart from
DMA, IP also does conversions like PCM to AES and viceversa.
This patch adds DMA component driver for the IP.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 561 ++++++++++++++++++++++++++++++++++
 1 file changed, 561 insertions(+)
 create mode 100644 sound/soc/xilinx/xlnx_formatter_pcm.c

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
new file mode 100644
index 0000000..a6da5ad
--- /dev/null
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -0,0 +1,561 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Xilinx ASoC audio formatter support
+//
+// Copyright (C) 2018 Xilinx, Inc.
+//
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sizes.h>
+
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
+#define DRV_NAME "xlnx_formatter_pcm"
+
+#define XLNX_S2MM_OFFSET	0
+#define XLNX_MM2S_OFFSET	0x100
+
+#define XLNX_AUD_CORE_CONFIG	0x4
+#define XLNX_AUD_CTRL		0x10
+#define XLNX_AUD_STS		0x14
+
+#define AUD_CTRL_RESET_MASK	BIT(1)
+#define AUD_CFG_MM2S_MASK	BIT(15)
+#define AUD_CFG_S2MM_MASK	BIT(31)
+
+#define XLNX_AUD_FS_MULTIPLIER	0x18
+#define XLNX_AUD_PERIOD_CONFIG	0x1C
+#define XLNX_AUD_BUFF_ADDR_LSB	0x20
+#define XLNX_AUD_BUFF_ADDR_MSB	0x24
+#define XLNX_AUD_XFER_COUNT	0x28
+#define XLNX_AUD_CH_STS_START	0x2C
+#define XLNX_BYTES_PER_CH	0x44
+
+#define AUD_STS_IOC_IRQ_MASK	BIT(31)
+#define AUD_STS_CH_STS_MASK	BIT(29)
+#define AUD_CTRL_IOC_IRQ_MASK	BIT(13)
+#define AUD_CTRL_TOUT_IRQ_MASK	BIT(14)
+#define AUD_CTRL_DMA_EN_MASK	BIT(0)
+
+#define CFG_MM2S_CH_MASK	GENMASK(11, 8)
+#define CFG_MM2S_CH_SHIFT	8
+#define CFG_MM2S_XFER_MASK	GENMASK(14, 13)
+#define CFG_MM2S_XFER_SHIFT	13
+#define CFG_MM2S_PKG_MASK	BIT(12)
+
+#define CFG_S2MM_CH_MASK	GENMASK(27, 24)
+#define CFG_S2MM_CH_SHIFT	24
+#define CFG_S2MM_XFER_MASK	GENMASK(30, 29)
+#define CFG_S2MM_XFER_SHIFT	29
+#define CFG_S2MM_PKG_MASK	BIT(28)
+
+#define AUD_CTRL_DATA_WIDTH_SHIFT	16
+#define AUD_CTRL_ACTIVE_CH_SHIFT	19
+#define PERIOD_CFG_PERIODS_SHIFT	16
+
+#define PERIODS_MIN		2
+#define PERIODS_MAX		6
+#define PERIOD_BYTES_MIN	192
+#define PERIOD_BYTES_MAX	(50 * 1024)
+
+enum bit_depth {
+	BIT_DEPTH_8,
+	BIT_DEPTH_16,
+	BIT_DEPTH_20,
+	BIT_DEPTH_24,
+	BIT_DEPTH_32,
+};
+
+struct xlnx_pcm_drv_data {
+	void __iomem *mmio;
+	bool s2mm_presence;
+	bool mm2s_presence;
+	unsigned int s2mm_irq;
+	unsigned int mm2s_irq;
+	struct snd_pcm_substream *play_stream;
+	struct snd_pcm_substream *capture_stream;
+	struct clk *axi_clk;
+};
+
+/*
+ * struct xlnx_pcm_stream_param - stream configuration
+ * @mmio: base address offset
+ * @interleaved: audio channels arrangement in buffer
+ * @xfer_mode: data formatting mode during transfer
+ * @ch_limit: Maximum channels supported
+ * @buffer_size: stream ring buffer size
+ */
+struct xlnx_pcm_stream_param {
+	void __iomem *mmio;
+	bool interleaved;
+	u32 xfer_mode;
+	u32 ch_limit;
+	u64 buffer_size;
+};
+
+static const struct snd_pcm_hardware xlnx_pcm_hardware = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_BATCH | SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_RESUME,
+	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
+		   SNDRV_PCM_FMTBIT_S24_LE,
+	.channels_min = 2,
+	.channels_max = 2,
+	.rates = SNDRV_PCM_RATE_8000_192000,
+	.rate_min = 8000,
+	.rate_max = 192000,
+	.buffer_bytes_max = PERIODS_MAX * PERIOD_BYTES_MAX,
+	.period_bytes_min = PERIOD_BYTES_MIN,
+	.period_bytes_max = PERIOD_BYTES_MAX,
+	.periods_min = PERIODS_MIN,
+	.periods_max = PERIODS_MAX,
+};
+
+static int xlnx_formatter_pcm_reset(void __iomem *mmio_base)
+{
+	u32 val, retries = 0;
+
+	val = readl(mmio_base + XLNX_AUD_CTRL);
+	val |= AUD_CTRL_RESET_MASK;
+	writel(val, mmio_base + XLNX_AUD_CTRL);
+
+	val = readl(mmio_base + XLNX_AUD_CTRL);
+	/* Poll for maximum timeout of approximately 100ms (1 * 100)*/
+	while ((val & AUD_CTRL_RESET_MASK) && (retries < 100)) {
+		mdelay(1);
+		retries++;
+		val = readl(mmio_base + XLNX_AUD_CTRL);
+	}
+	if (val & AUD_CTRL_RESET_MASK)
+		return -ENODEV;
+
+	return 0;
+}
+
+static void xlnx_formatter_disable_irqs(void __iomem *mmio_base, int stream)
+{
+	u32 val;
+
+	val = readl(mmio_base + XLNX_AUD_CTRL);
+	val &= ~AUD_CTRL_IOC_IRQ_MASK;
+	if (stream == SNDRV_PCM_STREAM_CAPTURE)
+		val &= ~AUD_CTRL_TOUT_IRQ_MASK;
+
+	writel(val, mmio_base + XLNX_AUD_CTRL);
+}
+
+static irqreturn_t xlnx_mm2s_irq_handler(int irq, void *arg)
+{
+	u32 val;
+	void __iomem *reg;
+	struct device *dev = arg;
+	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
+
+	reg = adata->mmio + XLNX_MM2S_OFFSET + XLNX_AUD_STS;
+	val = readl(reg);
+	if (val & AUD_STS_IOC_IRQ_MASK) {
+		writel(val & AUD_STS_IOC_IRQ_MASK, reg);
+		if (adata->play_stream)
+			snd_pcm_period_elapsed(adata->play_stream);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static irqreturn_t xlnx_s2mm_irq_handler(int irq, void *arg)
+{
+	u32 val;
+	void __iomem *reg;
+	struct device *dev = arg;
+	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
+
+	reg = adata->mmio + XLNX_S2MM_OFFSET + XLNX_AUD_STS;
+	val = readl(reg);
+	if (val & AUD_STS_IOC_IRQ_MASK) {
+		writel(val & AUD_STS_IOC_IRQ_MASK, reg);
+		if (adata->capture_stream)
+			snd_pcm_period_elapsed(adata->capture_stream);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int xlnx_formatter_pcm_open(struct snd_pcm_substream *substream)
+{
+	int err;
+	u32 val, data_format_mode;
+	u32 ch_count_mask, ch_count_shift, data_xfer_mode, data_xfer_shift;
+	struct xlnx_pcm_stream_param *stream_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *prtd = substream->private_data;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
+	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(component->dev);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+	    !adata->mm2s_presence)
+		return -ENODEV;
+	else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+		 !adata->s2mm_presence)
+		return -ENODEV;
+
+	stream_data = kzalloc(sizeof(*stream_data), GFP_KERNEL);
+	if (!stream_data)
+		return -ENOMEM;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ch_count_mask = CFG_MM2S_CH_MASK;
+		ch_count_shift = CFG_MM2S_CH_SHIFT;
+		data_xfer_mode = CFG_MM2S_XFER_MASK;
+		data_xfer_shift = CFG_MM2S_XFER_SHIFT;
+		data_format_mode = CFG_MM2S_PKG_MASK;
+		stream_data->mmio = adata->mmio + XLNX_MM2S_OFFSET;
+		adata->play_stream = substream;
+
+	} else {
+		ch_count_mask = CFG_S2MM_CH_MASK;
+		ch_count_shift = CFG_S2MM_CH_SHIFT;
+		data_xfer_mode = CFG_S2MM_XFER_MASK;
+		data_xfer_shift = CFG_S2MM_XFER_SHIFT;
+		data_format_mode = CFG_S2MM_PKG_MASK;
+		stream_data->mmio = adata->mmio + XLNX_S2MM_OFFSET;
+		adata->capture_stream = substream;
+	}
+
+	val = readl(adata->mmio + XLNX_AUD_CORE_CONFIG);
+
+	if (!(val & data_format_mode))
+		stream_data->interleaved = true;
+
+	stream_data->xfer_mode = (val & data_xfer_mode) >> data_xfer_shift;
+	stream_data->ch_limit = (val & ch_count_mask) >> ch_count_shift;
+	dev_info(component->dev,
+		 "stream %d : format = %d mode = %d ch_limit = %d\n",
+		 substream->stream, stream_data->interleaved,
+		 stream_data->xfer_mode, stream_data->ch_limit);
+
+	snd_soc_set_runtime_hwparams(substream, &xlnx_pcm_hardware);
+	runtime->private_data = stream_data;
+
+	/* Resize the period size divisible by 64 */
+	err = snd_pcm_hw_constraint_step(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64);
+	if (err) {
+		dev_err(component->dev,
+			"unable to set constraint on period bytes\n");
+		return err;
+	}
+
+	/* enable DMA IOC irq */
+	val = readl(stream_data->mmio + XLNX_AUD_CTRL);
+	val |= AUD_CTRL_IOC_IRQ_MASK;
+	writel(val, stream_data->mmio + XLNX_AUD_CTRL);
+
+	return 0;
+}
+
+static int xlnx_formatter_pcm_close(struct snd_pcm_substream *substream)
+{
+	int ret;
+	struct xlnx_pcm_stream_param *stream_data =
+			substream->runtime->private_data;
+	struct snd_soc_pcm_runtime *prtd = substream->private_data;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,
+								    DRV_NAME);
+
+	ret = xlnx_formatter_pcm_reset(stream_data->mmio);
+	if (ret) {
+		dev_err(component->dev, "audio formatter reset failed\n");
+		goto err_reset;
+	}
+	xlnx_formatter_disable_irqs(stream_data->mmio, substream->stream);
+
+err_reset:
+	kfree(stream_data);
+	return 0;
+}
+
+static snd_pcm_uframes_t
+xlnx_formatter_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	u32 pos;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct xlnx_pcm_stream_param *stream_data = runtime->private_data;
+
+	pos = readl(stream_data->mmio + XLNX_AUD_XFER_COUNT);
+
+	if (pos >= stream_data->buffer_size)
+		pos = 0;
+
+	return bytes_to_frames(runtime, pos);
+}
+
+static int xlnx_formatter_pcm_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	u32 low, high, active_ch, val, bytes_per_ch, bits_per_sample;
+	int status;
+	u64 size;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct xlnx_pcm_stream_param *stream_data = runtime->private_data;
+
+	active_ch = params_channels(params);
+	if (active_ch > stream_data->ch_limit)
+		return -EINVAL;
+
+	size = params_buffer_bytes(params);
+	status = snd_pcm_lib_malloc_pages(substream, size);
+	if (status < 0)
+		return status;
+
+	stream_data->buffer_size = size;
+
+	low = lower_32_bits(substream->dma_buffer.addr);
+	high = upper_32_bits(substream->dma_buffer.addr);
+	writel(low, stream_data->mmio + XLNX_AUD_BUFF_ADDR_LSB);
+	writel(high, stream_data->mmio + XLNX_AUD_BUFF_ADDR_MSB);
+
+	val = readl(stream_data->mmio + XLNX_AUD_CTRL);
+	bits_per_sample = params_width(params);
+	switch (bits_per_sample) {
+	case 8:
+		val |= (BIT_DEPTH_8 << AUD_CTRL_DATA_WIDTH_SHIFT);
+		break;
+	case 16:
+		val |= (BIT_DEPTH_16 << AUD_CTRL_DATA_WIDTH_SHIFT);
+		break;
+	case 20:
+		val |= (BIT_DEPTH_20 << AUD_CTRL_DATA_WIDTH_SHIFT);
+		break;
+	case 24:
+		val |= (BIT_DEPTH_24 << AUD_CTRL_DATA_WIDTH_SHIFT);
+		break;
+	case 32:
+		val |= (BIT_DEPTH_32 << AUD_CTRL_DATA_WIDTH_SHIFT);
+		break;
+	}
+
+	val |= active_ch << AUD_CTRL_ACTIVE_CH_SHIFT;
+	writel(val, stream_data->mmio + XLNX_AUD_CTRL);
+
+	val = (params_periods(params) << PERIOD_CFG_PERIODS_SHIFT)
+		| params_period_bytes(params);
+	writel(val, stream_data->mmio + XLNX_AUD_PERIOD_CONFIG);
+	bytes_per_ch = DIV_ROUND_UP(params_period_bytes(params), active_ch);
+	writel(bytes_per_ch, stream_data->mmio + XLNX_BYTES_PER_CH);
+
+	return 0;
+}
+
+static int xlnx_formatter_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int xlnx_formatter_pcm_trigger(struct snd_pcm_substream *substream,
+				      int cmd)
+{
+	u32 val;
+	struct xlnx_pcm_stream_param *stream_data =
+			substream->runtime->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		val = readl(stream_data->mmio + XLNX_AUD_CTRL);
+		val |= AUD_CTRL_DMA_EN_MASK;
+		writel(val, stream_data->mmio + XLNX_AUD_CTRL);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		val = readl(stream_data->mmio + XLNX_AUD_CTRL);
+		val &= ~AUD_CTRL_DMA_EN_MASK;
+		writel(val, stream_data->mmio + XLNX_AUD_CTRL);
+		break;
+	}
+
+	return 0;
+}
+
+static int xlnx_formatter_pcm_new(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
+								    DRV_NAME);
+	return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+			SNDRV_DMA_TYPE_DEV, component->dev,
+			xlnx_pcm_hardware.buffer_bytes_max,
+			xlnx_pcm_hardware.buffer_bytes_max);
+}
+
+static const struct snd_pcm_ops xlnx_formatter_pcm_ops = {
+	.open = xlnx_formatter_pcm_open,
+	.close = xlnx_formatter_pcm_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = xlnx_formatter_pcm_hw_params,
+	.hw_free = xlnx_formatter_pcm_hw_free,
+	.trigger = xlnx_formatter_pcm_trigger,
+	.pointer = xlnx_formatter_pcm_pointer,
+};
+
+static const struct snd_soc_component_driver xlnx_asoc_component = {
+	.name = DRV_NAME,
+	.ops = &xlnx_formatter_pcm_ops,
+	.pcm_new = xlnx_formatter_pcm_new,
+};
+
+static int xlnx_formatter_pcm_probe(struct platform_device *pdev)
+{
+	int ret;
+	u32 val;
+	struct xlnx_pcm_drv_data *aud_drv_data;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+
+	aud_drv_data = devm_kzalloc(dev, sizeof(*aud_drv_data), GFP_KERNEL);
+	if (!aud_drv_data)
+		return -ENOMEM;
+
+	aud_drv_data->axi_clk = devm_clk_get(dev, "s_axi_lite_aclk");
+	if (IS_ERR(aud_drv_data->axi_clk)) {
+		ret = PTR_ERR(aud_drv_data->axi_clk);
+		dev_err(dev, "failed to get s_axi_lite_aclk(%d)\n", ret);
+		return ret;
+	}
+	ret = clk_prepare_enable(aud_drv_data->axi_clk);
+	if (ret) {
+		dev_err(dev,
+			"failed to enable s_axi_lite_aclk(%d)\n", ret);
+		return ret;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "audio formatter node:addr to resource failed\n");
+		ret = -ENXIO;
+		goto clk_err;
+	}
+	aud_drv_data->mmio = devm_ioremap_resource(dev, res);
+	if (IS_ERR(aud_drv_data->mmio)) {
+		dev_err(dev, "audio formatter ioremap failed\n");
+		ret = PTR_ERR(aud_drv_data->mmio);
+		goto clk_err;
+	}
+
+	val = readl(aud_drv_data->mmio + XLNX_AUD_CORE_CONFIG);
+	if (val & AUD_CFG_MM2S_MASK) {
+		aud_drv_data->mm2s_presence = true;
+		aud_drv_data->mm2s_irq = platform_get_irq_byname(pdev,
+								 "irq_mm2s");
+		if (aud_drv_data->mm2s_irq < 0) {
+			dev_err(dev, "xlnx audio mm2s irq resource failed\n");
+			ret = aud_drv_data->mm2s_irq;
+			goto clk_err;
+		}
+		ret = devm_request_irq(dev, aud_drv_data->mm2s_irq,
+				       xlnx_mm2s_irq_handler, 0,
+				       "xlnx_formatter_pcm_mm2s_irq", dev);
+		if (ret) {
+			dev_err(dev, "xlnx audio mm2s irq request failed\n");
+			goto clk_err;
+		}
+		ret = xlnx_formatter_pcm_reset(aud_drv_data->mmio +
+					       XLNX_MM2S_OFFSET);
+		if (ret) {
+			dev_err(dev, "audio formatter reset failed\n");
+			goto clk_err;
+		}
+		xlnx_formatter_disable_irqs(aud_drv_data->mmio +
+					    XLNX_MM2S_OFFSET,
+					    SNDRV_PCM_STREAM_PLAYBACK);
+	}
+	if (val & AUD_CFG_S2MM_MASK) {
+		aud_drv_data->s2mm_presence = true;
+		aud_drv_data->s2mm_irq = platform_get_irq_byname(pdev,
+								 "irq_s2mm");
+		if (aud_drv_data->s2mm_irq < 0) {
+			dev_err(dev, "xlnx audio s2mm irq resource failed\n");
+			ret = aud_drv_data->s2mm_irq;
+			goto clk_err;
+		}
+		ret = devm_request_irq(dev, aud_drv_data->s2mm_irq,
+				       xlnx_s2mm_irq_handler, 0,
+				       "xlnx_formatter_pcm_s2mm_irq",
+				       dev);
+		if (ret) {
+			dev_err(dev, "xlnx audio s2mm irq request failed\n");
+			goto clk_err;
+		}
+		ret = xlnx_formatter_pcm_reset(aud_drv_data->mmio +
+					       XLNX_S2MM_OFFSET);
+		if (ret) {
+			dev_err(dev, "audio formatter reset failed\n");
+			goto clk_err;
+		}
+		xlnx_formatter_disable_irqs(aud_drv_data->mmio +
+					    XLNX_S2MM_OFFSET,
+					    SNDRV_PCM_STREAM_CAPTURE);
+		}
+
+	dev_set_drvdata(dev, aud_drv_data);
+
+	ret = devm_snd_soc_register_component(dev, &xlnx_asoc_component,
+					      NULL, 0);
+	if (ret) {
+		dev_err(dev, "pcm platform device register failed\n");
+		goto clk_err;
+	}
+
+	dev_info(dev, "pcm platform device registered\n");
+	return 0;
+
+clk_err:
+	clk_disable_unprepare(aud_drv_data->axi_clk);
+	return ret;
+}
+
+static int xlnx_formatter_pcm_remove(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(&pdev->dev);
+
+	if (adata->s2mm_presence)
+		ret = xlnx_formatter_pcm_reset(adata->mmio + XLNX_S2MM_OFFSET);
+
+	/* Try MM2S reset, even if S2MM  reset fails */
+	if (adata->mm2s_presence)
+		ret = xlnx_formatter_pcm_reset(adata->mmio + XLNX_MM2S_OFFSET);
+
+	if (ret)
+		dev_err(&pdev->dev, "audio formatter reset failed\n");
+
+	clk_disable_unprepare(adata->axi_clk);
+	return ret;
+}
+
+static const struct of_device_id xlnx_formatter_pcm_of_match[] = {
+	{ .compatible = "xlnx,audio-formatter-1.0"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, xlnx_formatter_pcm_of_match);
+
+static struct platform_driver xlnx_formatter_pcm_driver = {
+	.probe	= xlnx_formatter_pcm_probe,
+	.remove	= xlnx_formatter_pcm_remove,
+	.driver	= {
+		.name	= DRV_NAME,
+		.of_match_table	= xlnx_formatter_pcm_of_match,
+	},
+};
+
+module_platform_driver(xlnx_formatter_pcm_driver);
+MODULE_AUTHOR("Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

