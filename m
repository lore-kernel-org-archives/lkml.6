Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18738C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E364620656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfAOD1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:27:45 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35453 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfAOD1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:27:44 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x0F3RRgw006468;
        Tue, 15 Jan 2019 04:27:27 +0100
Date:   Tue, 15 Jan 2019 04:27:27 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Silvio Cesare <silvio.cesare@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: [PATCH v2 4/8] ASoC: imx-audmux: change snprintf to scnprintf for
 possible overflow
Message-ID: <20190115032727.GA6440@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Silvio Cesare <silvio.cesare@gmail.com>

Change snprintf to scnprintf. There are generally two cases where using
snprintf causes problems.

1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
In this case, if snprintf would have written more characters than what the
buffer size (SIZE) is, then size will end up larger than SIZE. In later
uses of snprintf, SIZE - size will result in a negative number, leading
to problems. Note that size might already be too large by using
size = snprintf before the code reaches a case of size += snprintf.

2) If size is ultimately used as a length parameter for a copy back to user
space, then it will potentially allow for a buffer overflow and information
disclosure when size is greater than SIZE. When the size is used to index
the buffer directly, we can have memory corruption. This also means when
size = snprintf... is used, it may also cause problems since size may become
large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
configuration.

The solution to these issues is to use scnprintf which returns the number of
characters actually written to the buffer, so the size variable will never
exceed SIZE.

Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>

--

v2:
  - adjust subject line
  - added alsa-devel & Mark
  - added acked-by
  - added reviewed-by

The patches in this series were sent by Silvio to the security list
to fix a minor memory disclosure issue after this article was published:
                                                          
  http://blog.infosectcbr.com.au/2018/11/memory-bugs-in-multiple-linux-kernel.html


 sound/soc/fsl/imx-audmux.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 392d5eef356d..99e07b01a2ce 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -86,49 +86,49 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = snprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
+	ret = scnprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
 		       pdcr, ptcr);
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_TFSDIR)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxFS output from %s, ",
 				audmux_port_string((ptcr >> 27) & 0x7));
 	else
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxFS input, ");
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_TCLKDIR)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxClk output from %s",
 				audmux_port_string((ptcr >> 22) & 0x7));
 	else
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"TxClk input");
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
 
 	if (ptcr & IMX_AUDMUX_V2_PTCR_SYN) {
-		ret += snprintf(buf + ret, PAGE_SIZE - ret,
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 				"Port is symmetric");
 	} else {
 		if (ptcr & IMX_AUDMUX_V2_PTCR_RFSDIR)
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxFS output from %s, ",
 					audmux_port_string((ptcr >> 17) & 0x7));
 		else
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxFS input, ");
 
 		if (ptcr & IMX_AUDMUX_V2_PTCR_RCLKDIR)
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxClk output from %s",
 					audmux_port_string((ptcr >> 12) & 0x7));
 		else
-			ret += snprintf(buf + ret, PAGE_SIZE - ret,
+			ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 					"RxClk input");
 	}
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret,
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret,
 			"\nData received from %s\n",
 			audmux_port_string((pdcr >> 13) & 0x7));
 
-- 
2.19.2
