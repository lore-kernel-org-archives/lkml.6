Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01119C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89EC2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218889;
	bh=IgvIW6DgqY/tcfUk3f/8ePXEjNift/3I2THuG9eF+eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uB6klhbMhviDi7bswpaAv8VoeBCVttEKXlnTJf8G+X5G0gtnLTjgwE64LJHbIZJvR
	 p16H9C9TuTABVkjtIbncuHxEYDc+e3v4n9FW7E9eiSZzPF6vfhUggp7SWC/iwKk1uc
	 bkGjcwJ1AIsuqQa+DJ6Ivi20B+dYzjvPXlChUa9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389355AbfAKOcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389325AbfAKOcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A6852133F;
        Fri, 11 Jan 2019 14:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217124;
        bh=IgvIW6DgqY/tcfUk3f/8ePXEjNift/3I2THuG9eF+eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQzSUEzrWxV0fzszAJ+/K4CCpTMQnu/YAuQeB6b/C97HQS72iJN99hiU+9LwVvKmQ
         knmqawErzs0CXhFwW7aJinRFfblOncKKJje86fpT1XqcZ9+BkK9/6eRWF4DaupAyNn
         iOOUWOSdomwVMkVq8NRz+/Z2MiE2OgA/iwA9cyIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 051/105] Input: synaptics - enable SMBus for HP EliteBook 840 G4
Date:   Fri, 11 Jan 2019 15:14:22 +0100
Message-Id: <20190111131107.360833214@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7a71712293ba303aad928f580b89addb0be2892e ]

dmesg reports that "Your touchpad (PNP: SYN3052 SYN0100 SYN0002 PNP0f13)
says it can support a different bus."

I've tested the offered psmouse.synaptics_intertouch=1 with 4.18.x and
4.19.x and it seems to work well. No problems seen with suspend/resume.

Also, it appears that RMI/SMBus mode is actually required for 3-4 finger
multitouch gestures to work -- otherwise they are not reported at all.

Information from dmesg in both modes:

  psmouse serio3: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1,
      caps: 0xf00123/0x840300/0x2e800/0x0, board id: 3139, fw id: 2000742

  psmouse serio3: synaptics: Trying to set up SMBus access
  rmi4_smbus 6-002c: registering SMbus-connected sensor
  rmi4_f01 rmi4-00.fn01: found RMI device,
      manufacturer: Synaptics, product: TM3139-001, fw id: 2000742

Signed-off-by: Mantas Mikulėnas <grawity@gmail.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 515a0b0d48bf..e9ec5d10e0a9 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -179,6 +179,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN200f", /* T450s */
+	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	NULL
 };
-- 
2.19.1



