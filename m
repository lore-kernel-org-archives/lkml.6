Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeB0RCJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:02:09 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53098 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750997AbeB0RCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:02:08 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <o-takashi@sakamocchi.jp>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: control: Fix memory corruption risk in snd_ctl_elem_read
Date: Tue, 27 Feb 2018 17:01:18 +0000
Message-ID: <20180227170118.23197-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=842 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802270211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch "ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE
operations" introduced a potential for kernel memory corruption due
to an incorrect if statement allowing non-readable controls to fall
through and call the get function. For TLV controls a driver can omit
SNDRV_CTL_ELEM_ACCESS_READ to ensure that only the TLV get function
can be called. Instead the normal get() can be invoked unexpectedly
and as the driver expects that this will only be called for controls
<= 512 bytes, potentially try to copy >512 bytes into the 512 byte
return array, so corrupting kernel memory.

The problem is an attempt to refactor the snd_ctl_elem_read function
to invert the logic so that it conditionally aborted if the control
is unreadable instead of conditionally executing. But the if statement
wasn't inverted correctly.

The correct inversion of

    if (a && !b)

is
    if (!a || b)

Fixes: becf9e5d553c2 ("ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE operations")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/core/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 0b3026d937b1..8a77620a3854 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -889,7 +889,7 @@ static int snd_ctl_elem_read(struct snd_card *card,
 
 	index_offset = snd_ctl_get_ioff(kctl, &control->id);
 	vd = &kctl->vd[index_offset];
-	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) && kctl->get == NULL)
+	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) || kctl->get == NULL)
 		return -EPERM;
 
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
-- 
2.11.0
