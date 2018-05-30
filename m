Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbeE3Lmj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:42:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60675 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751854AbeE3LG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:58 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "=?UTF-8?Q?=E8=8C=83=E9=BE=99=E9=A3=9E?=" <long7573@126.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.938113122@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 013/153] ALSA: seq: Fix racy pool initializations
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit d15d662e89fc667b90cd294b0eb45694e33144da upstream.

ALSA sequencer core initializes the event pool on demand by invoking
snd_seq_pool_init() when the first write happens and the pool is
empty.  Meanwhile user can reset the pool size manually via ioctl
concurrently, and this may lead to UAF or out-of-bound accesses since
the function tries to vmalloc / vfree the buffer.

A simple fix is to just wrap the snd_seq_pool_init() call with the
recently introduced client->ioctl_mutex; as the calls for
snd_seq_pool_init() from other side are always protected with this
mutex, we can avoid the race.

Reported-by: 范龙飞 <long7573@126.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/seq_clientmgr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1000,7 +1000,7 @@ static ssize_t snd_seq_write(struct file
 {
 	struct snd_seq_client *client = file->private_data;
 	int written = 0, len;
-	int err = -EINVAL;
+	int err;
 	struct snd_seq_event event;
 
 	if (!(snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_OUTPUT))
@@ -1015,11 +1015,15 @@ static ssize_t snd_seq_write(struct file
 
 	/* allocate the pool now if the pool is not allocated yet */ 
 	if (client->pool->size > 0 && !snd_seq_write_pool_allocated(client)) {
-		if (snd_seq_pool_init(client->pool) < 0)
+		mutex_lock(&client->ioctl_mutex);
+		err = snd_seq_pool_init(client->pool);
+		mutex_unlock(&client->ioctl_mutex);
+		if (err < 0)
 			return -ENOMEM;
 	}
 
 	/* only process whole events */
+	err = -EINVAL;
 	while (count >= sizeof(struct snd_seq_event)) {
 		/* Read in the event header from the user */
 		len = sizeof(event);
