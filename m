Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939957AbeE1QR3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:17:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965064AbeE1KMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:12:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 159/185] ALSA: vmaster: Propagate slave error
Date: Mon, 28 May 2018 12:03:20 +0200
Message-Id: <20180528100111.271339579@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 2e2c177ca84aff092c3c96714b0f6a12900f3946 ]

In slave_update() of vmaster code ignores the error from the slave
get() callback and copies the values.  It's not only about the missing
error code but also that this may potentially lead to a leak of
uninitialized variables when the slave get() don't clear them.

This patch fixes slave_update() not to copy the potentially
uninitialized values when an error is returned from the slave get()
callback, and to propagate the error value properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/vmaster.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -68,10 +68,13 @@ static int slave_update(struct link_slav
 		return -ENOMEM;
 	uctl->id = slave->slave.id;
 	err = slave->slave.get(&slave->slave, uctl);
+	if (err < 0)
+		goto error;
 	for (ch = 0; ch < slave->info.count; ch++)
 		slave->vals[ch] = uctl->value.integer.value[ch];
+ error:
 	kfree(uctl);
-	return 0;
+	return err < 0 ? err : 0;
 }
 
 /* get the slave ctl info and save the initial values */
