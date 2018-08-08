Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602E2C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207B8216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207B8216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeHHKqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:46:03 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:6841 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeHHKqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:46:03 -0400
X-IronPort-AV: E=Sophos;i="5.51,456,1526342400"; 
   d="scan'208";a="77334652"
Date:   Wed, 8 Aug 2018 10:27:16 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Juergen Gross <jgross@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <konrad.wilk@oracle.com>,
        <axboe@kernel.dk>, <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 2/4] xen/blkfront: cleanup stale persistent grants
Message-ID: <20180808082716.y4nwqz4y2gzp3yok@mac>
References: <20180806113403.24728-1-jgross@suse.com>
 <20180806113403.24728-4-jgross@suse.com>
 <20180806161638.nmjamflckekeuyzb@mac>
 <e28d3e77-2c6b-fc30-37e6-646ee1cfbdab@suse.com>
 <20180807141404.lzsqtdd2seqgwtgx@mac>
 <bba40203-ff97-aba6-cbb6-d3e57387778a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bba40203-ff97-aba6-cbb6-d3e57387778a@suse.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 05:56:38PM +0200, Juergen Gross wrote:
> On 07/08/18 16:14, Roger Pau Monné wrote:
> > On Tue, Aug 07, 2018 at 08:31:31AM +0200, Juergen Gross wrote:
> >> On 06/08/18 18:16, Roger Pau Monné wrote:
> >>> On Mon, Aug 06, 2018 at 01:34:01PM +0200, Juergen Gross wrote:
> >>>> Add a periodic cleanup function to remove old persistent grants which
> >>>> are no longer in use on the backend side. This avoids starvation in
> >>>> case there are lots of persistent grants for a device which no longer
> >>>> is involved in I/O business.
> >>>>
> >>>> Signed-off-by: Juergen Gross <jgross@suse.com>
> >>>> ---
> >>>>  drivers/block/xen-blkfront.c | 99 ++++++++++++++++++++++++++++++++++++++++++--
> >>>>  1 file changed, 95 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> >>>> index b5cedccb5d7d..19feb8835fc4 100644
> >>>> --- a/drivers/block/xen-blkfront.c
> >>>> +++ b/drivers/block/xen-blkfront.c
> >>>> @@ -46,6 +46,7 @@
> >>>>  #include <linux/scatterlist.h>
> >>>>  #include <linux/bitmap.h>
> >>>>  #include <linux/list.h>
> >>>> +#include <linux/workqueue.h>
> >>>>  
> >>>>  #include <xen/xen.h>
> >>>>  #include <xen/xenbus.h>
> >>>> @@ -121,6 +122,9 @@ static inline struct blkif_req *blkif_req(struct request *rq)
> >>>>  
> >>>>  static DEFINE_MUTEX(blkfront_mutex);
> >>>>  static const struct block_device_operations xlvbd_block_fops;
> >>>> +static struct delayed_work blkfront_work;
> >>>> +static LIST_HEAD(info_list);
> >>>> +static bool blkfront_work_active;
> >>>>  
> >>>>  /*
> >>>>   * Maximum number of segments in indirect requests, the actual value used by
> >>>> @@ -216,6 +220,7 @@ struct blkfront_info
> >>>>  	/* Save uncomplete reqs and bios for migration. */
> >>>>  	struct list_head requests;
> >>>>  	struct bio_list bio_list;
> >>>> +	struct list_head info_list;
> >>>>  };
> >>>>  
> >>>>  static unsigned int nr_minors;
> >>>> @@ -1764,6 +1769,12 @@ static int write_per_ring_nodes(struct xenbus_transaction xbt,
> >>>>  	return err;
> >>>>  }
> >>>>  
> >>>> +static void free_info(struct blkfront_info *info)
> >>>> +{
> >>>> +	list_del(&info->info_list);
> >>>> +	kfree(info);
> >>>> +}
> >>>> +
> >>>>  /* Common code used when first setting up, and when resuming. */
> >>>>  static int talk_to_blkback(struct xenbus_device *dev,
> >>>>  			   struct blkfront_info *info)
> >>>> @@ -1885,7 +1896,10 @@ static int talk_to_blkback(struct xenbus_device *dev,
> >>>>   destroy_blkring:
> >>>>  	blkif_free(info, 0);
> >>>>  
> >>>> -	kfree(info);
> >>>> +	mutex_lock(&blkfront_mutex);
> >>>> +	free_info(info);
> >>>> +	mutex_unlock(&blkfront_mutex);
> >>>> +
> >>>>  	dev_set_drvdata(&dev->dev, NULL);
> >>>>  
> >>>>  	return err;
> >>>> @@ -1996,6 +2010,10 @@ static int blkfront_probe(struct xenbus_device *dev,
> >>>>  	info->handle = simple_strtoul(strrchr(dev->nodename, '/')+1, NULL, 0);
> >>>>  	dev_set_drvdata(&dev->dev, info);
> >>>>  
> >>>> +	mutex_lock(&blkfront_mutex);
> >>>> +	list_add(&info->info_list, &info_list);
> >>>> +	mutex_unlock(&blkfront_mutex);
> >>>> +
> >>>>  	return 0;
> >>>>  }
> >>>>  
> >>>> @@ -2306,6 +2324,15 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
> >>>>  	if (indirect_segments <= BLKIF_MAX_SEGMENTS_PER_REQUEST)
> >>>>  		indirect_segments = 0;
> >>>>  	info->max_indirect_segments = indirect_segments;
> >>>> +
> >>>> +	if (info->feature_persistent) {
> >>>> +		mutex_lock(&blkfront_mutex);
> >>>> +		if (!blkfront_work_active) {
> >>>> +			blkfront_work_active = true;
> >>>> +			schedule_delayed_work(&blkfront_work, HZ * 10);
> >>>
> >>> Does it make sense to provide a module parameter to rune the schedule
> >>> of the cleanup routine?
> >>
> >> I don't think this is something anyone would like to tune.
> >>
> >> In case you think it should be tunable I can add a parameter, of course.
> > 
> > We can always add it later if required. I'm fine as-is now.
> > 
> >>>
> >>>> +		}
> >>>> +		mutex_unlock(&blkfront_mutex);
> >>>
> >>> Is it really necessary to have the blkfront_work_active boolean? What
> >>> happens if you queue the same delayed work more than once?
> >>
> >> In case there is already work queued later calls of
> >> schedule_delayed_work() will be ignored.
> >>
> >> So yes, I can drop the global boolean (I still need a local flag in
> >> blkfront_delay_work() for controlling the need to call
> >> schedule_delayed_work() again).
> > 
> > Can't you just call schedule_delayed_work if info->feature_persistent
> > is set, even if that means calling it multiple times if multiple
> > blkfront instances are using persistent grants?
> 
> I don't like that. With mq we have a high chance for multiple instances
> to use persistent grants and a local bool is much cheaper than unneeded
> calls of schedule_delayed_work().

OK, I'm convinced with the local bool.

Thanks, Roger.
