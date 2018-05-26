Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031707AbeEZKZI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 06:25:08 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:58747 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031615AbeEZKZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 06:25:07 -0400
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Eric Anholt <eric@anholt.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Phil Elwell <phil@raspberrypi.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] mailbox: bcm2835: Fix of_xlate return value
Date: Sat, 26 May 2018 12:24:00 +0200
Message-Id: <1527330240-6181-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:qXsp9dKLa81BswkD3cgAfgRVR3VR4YxrXLJBlCE8RZSSAG9uRTJ
 aodYgLFgqGc6YYepljhH2651S8XWU2JkZPMtL+H7TGoXXFinAQqnHMUyCiXwGKMvhNozGFO
 Z4Rd9BY1yu9THkNhpeOJ0fWwJNPZgWQaWMr7R0T4JNXK9hEMyLJ0sRiSTwSzrb+J44YIOXm
 go5QhJ/u/bg40gvopKtFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:77Rjb3R+PhU=:KTEdXo0MXpW8YlKcTcwsG0
 PuMWl81vAEprWQIXS1JFn8K/R4nCCJ3Wi9bc6HoJmASqiqD8XDpBeYEBTUUNBeIIjeEFtfkEA
 6l4dHlRN8rg19MRgAslYhKAkLL0zaJZgxOT23yKj2vTCQqv7hzZcIjjdqrNsh7fEpC8kf9yM9
 Khz9cj+QwTIX0g7uCw22LdOrUy1eqqwJyriXxbo6v9kXQQM6VEnIDVVJ7dq8QYaOnNk44nezy
 P71uygR+kf8KaeqPo8O7w7G/qJg6o3iNygoy4I+xYZ2X5c7TbGS4K3gBUoiw8w3qO9t+5z+dd
 +zo9utP1CVJDGkwS+ncGMvmRvQGcjyzcd41bFFeZAHd7BlgI5bjRJGYiWDe5cOmGgpPAZ6Rwo
 wtq9VOhgbwg8igYe8riQ2ElbaKp+7ozi1P/R5UGvwuTYBIDQeuO8sQ3/okrNlshi/c3GMQ4Yd
 vNpZWEKqir6g+xSQXdyq8AM0e79hNu/u8/HLEtXgrVecB0Rnrjmm8W9y+CPReXKouQy9ojfqF
 fIysU0aBZHnNln9jgRhO2tid3tTXvLi9nqFrQuGXmxrDkCSEoXmDfxXr+tlFUHPgBJ+ETQNEJ
 APdNUK3psDVVl6bpykjAJ0eyxrULkAvLEA3fvtOZpm0DkOnm8S983NXW/AmfaN9ezqvChNIWR
 RcpIqWgHhQOIkDbD9VN+pBh7bumSlT6jsTHXSgGQw49Nss7+kjIAONe7oH55wfV4hobY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bcm2835-mailbox returns NULL instead of an error pointer, which could
result in a NULL ptr dereference in mbox_request_channel. So fix this
by returning a proper error pointer.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 0bae6af6d704 ("mailbox: Enable BCM2835 mailbox support")
---
 drivers/mailbox/bcm2835-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
index cfb4b44..e92bbc5 100644
--- a/drivers/mailbox/bcm2835-mailbox.c
+++ b/drivers/mailbox/bcm2835-mailbox.c
@@ -134,7 +134,7 @@ static struct mbox_chan *bcm2835_mbox_index_xlate(struct mbox_controller *mbox,
 		    const struct of_phandle_args *sp)
 {
 	if (sp->args_count != 0)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	return &mbox->chans[0];
 }
-- 
2.7.4
