Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeC1Co3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 22:44:29 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43086 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC1Co1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 22:44:27 -0400
X-Google-Smtp-Source: AIpwx48/EYatAcIm4gbdZUKKsxK7eojXC8AH/t0E4xIr5BZUQtinutrI6T2RAWQHp7pNRGHo8xisqQ==
Date: Wed, 28 Mar 2018 11:44:22 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: wen.yang99@zte.com.cn
Cc: Bart.VanAssche@wdc.com, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn, tan.hu@zte.com.cn
Subject: Re: =?utf-8?B?562U5aSNOiBSZTogW1BBVENI?= =?utf-8?Q?=5D?= scsi:
 Replace sdev_printk with printk_deferred to avoid
Message-ID: <20180328024422.GA1352@jagdpanzerIV>
References: <199ab05df000f2e8b5497a7aaecd0951321aadae.camel@wdc.com>
 <201803281029555635678@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803281029555635678@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/28/18 10:29), wen.yang99@zte.com.cn wrote:
>    Hello Bart,
>
>    We have a detailed discussion of the problem.
>    Sergey Senozhatsky, Petr and many people have made a lot of efforts about
>    it.
>    Please see this link:
>    https://bugzilla.kernel.org/show_bug.cgi?id=199003
>
>    1, Petr suggests that it should be modified in this way:
>    IMHO, printing the same message so many times is useless. Therefore
>    some throttling would make sense. If we want to keep sdev_printk(),

The thing with retelimiting is that - yes, we do less printks but we still
do them under queue spin_lock.

So I was thinking about something like below [a quick-n-dirty workaround]

---

 drivers/scsi/scsi_lib.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0dfec0dedd5e..6c930fbdd24c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1825,9 +1825,13 @@ static void scsi_request_fn(struct request_queue *q)
 			break;
 
 		if (unlikely(!scsi_device_online(sdev))) {
+			scsi_kill_request(req, q);
+			spin_unlock_irq(q->queue_lock);
+
 			sdev_printk(KERN_ERR, sdev,
 				    "rejecting I/O to offline device\n");
-			scsi_kill_request(req, q);
+
+			spin_lock_irq(q->queue_lock);
 			continue;
 		}
 
