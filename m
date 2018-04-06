Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeDFItH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 04:49:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:48600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbeDFItE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 04:49:04 -0400
Date: Fri, 6 Apr 2018 10:49:01 +0200
From: Petr Mladek <pmladek@suse.com>
To: wen.yang99@zte.com.cn
Cc: sergey.senozhatsky.work@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bart.VanAssche@wdc.com, tj@kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn, tan.hu@zte.com.cn
Subject: Re: =?utf-8?B?562U5aSNOiBSZTogW1BBVENIIHYy?=
 =?utf-8?Q?=5D_scsi=3A_Introduc?= =?utf-8?Q?e?= sdev_printk_ratelimited to
 throttlefrequent printk
Message-ID: <20180406084901.3353tnfbup6gblfx@pathway.suse.cz>
References: <20180402021032.GE3795@jagdpanzerIV>
 <201804031419435288297@zte.com.cn>
 <20180406083016.weuoemmcgvgxlcxy@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180406083016.weuoemmcgvgxlcxy@pathway.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-04-06 10:30:16, Petr Mladek wrote:
> On Tue 2018-04-03 14:19:43, wen.yang99@zte.com.cn wrote:
> > On the other hand，queue_lock is big, looping doing something under spinlock 
> > 
> > may locked many things and taking a long time, may cause some problems.
> > 
> > So This code needs to be optimized later:
> > 
> > scsi_request_fn()
> > {
> > 	for (;;) {
> > 		int rtn;
> > 		/*
> > 		 * get next queueable request.  We do this early to make sure
> > 		 * that the request is fully prepared even if we cannot
> > 		 * accept it.
> > 		 */
> > 
> > 		req = blk_peek_request(q);
> > 
> > 		if (!req)
> > 			break;
> > 
> > 		if (unlikely(!scsi_device_online(sdev))) {
> > 			sdev_printk(KERN_ERR, sdev,
> > 				    "rejected I/O to offline device\n");
> > 			scsi_kill_request(req, q);
> > 			continue;
> > 
> > 			^^^^^^^^^ still under spinlock
> > 		}
> 
> I wonder if the following might be the best solution after all:
> 
> 		if (unlikely(!scsi_device_online(sdev))) {
> 			scsi_kill_request(req, q);
> 
> 			/*
> 			 * printk() might take a while on slow consoles.
> 			 * Prevent solftlockups by releasing the lock.
> 			 */
> 			spin_unlock_irq(q->queue_lock);
> 			sdev_printk(KERN_ERR, sdev,
> 				    "rejecting I/O to offline device\n");
> 			spin_lock_irq(q->queue_lock);
> 			continue;
> 		}
> 
> I see that the lock is released also in several other situations.
> Therefore it looks safe. Also handling too many requests without
> releasing the lock seems to be a bad idea in general. I think
> that this solution was already suggested earlier.

Just to be sure. Is it safe to kill first few requests and proceed
the others?

I wonder if the device could actually get online without releasing
the queue lock. If not, we normally killed all requests.

I wonder if a local flag might actually help to reduce the number
of messages but keep the existing behavior. I mean something like

static void scsi_request_fn(struct request_queue *q)
{
	struct scsi_device *sdev = q->queuedata;
			   ^^^^^
			   The device is the same for each request
			   in this queue.


	struct request *req;
+	bool offline_reported = false;

	/*
	 * To start with, we keep looping until the queue is empty, or until
	 * the host is no longer able to accept any more requests.
	 */
	shost = sdev->host;
	for (;;) {
		int rtn;
		req = blk_peek_request(q);
		if (!req)
			break;

		if (unlikely(!scsi_device_online(sdev))) {
+			if (!offline_reported) {
				sdev_printk(KERN_ERR, sdev,
					"rejecting I/O to offline device\n");
+				offline_reported = true;
+			}
			scsi_kill_request(req, q);
			continue;
		}


Please, note that I am not familiar with the scsi code. I am involved
because this is printk related. Unfortunately, we could not make
printk() faster. The main principle is to get messages on the console
ASAP. Nobody knows when the system might die and any message might
be important.

Best Regards,
Petr
