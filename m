Return-Path: <Jean-Philippe.Brucker@arm.com>
X-Google-Smtp-Source: AIpwx4+DtT855gztthcBvZv8D8AoHtx2+vSPeLZm/JVm025TK0U4ujbCT1vTlxYUPewOzHBamLQw
ARC-Seal: i=1; a=rsa-sha256; t=1524497791; cv=none;
        d=google.com; s=arc-20160816;
        b=ORB1XcM3BWe4K5O1yySCej9V50xVYWQVpv1Q5OlZAdY4jxoQIXk7GOSmdoAKAlb8m1
         zhXpSgHpcknYAczYbr2mPoIMVDGj0GIdyH38xMnRzJTYoZArvC8crjh9ahjgDfxSlf8Y
         1DjhAua+gKuCeyAdNko1oW48PUZ7W8u7skXevAQfqssJuXs5tkNyEbR3UVd4uPoMBYjk
         TGvTuzj8h62NWIlwlyjaa+P5YHRZi+A0vf2SxalOS8IITLm4bFotPbbZmaRibLduGebs
         zJOisNvkBzemQ1AIGRDw0gxhJ/juPH9AuGBBqvAI8BV73PW9U55dlQqAEdtRp3hVspei
         I/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=XURLlucZo7hguqxYhGQgYvgozT4ptJV6woY+biBQ13g=;
        b=VjAkS98ScwNwzqOFZwjfUaW35rqe7raefSPX0ekV3Ji5+KKM0dIW3ZAsI4mcX38bGG
         SMqN+GFtSi7V+OlYYAyjkxJdvCIodnaq/iWbAUnSOomEkaUqIxebiuKywwgbc33+Gr+g
         rpKzqzdU44rvT0zfTOdkOWPkWwDRnahLIQbQanTT6SoybJbHuITibkup1qJFIGchexuG
         eQoLnDoe5ZMNj7UOs6FCu1Q41RtEH++6dSEPeciJuWWcHwPYS9K4lYssb/UNfepuHoV+
         ORiAB3jN7fvBDdt0CXI7OfrvPqNGehmw78E1EI6zVyruDdkBMxQqvT9GM7ig7RhfGvaw
         jSbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=Jean-Philippe.Brucker@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=Jean-Philippe.Brucker@arm.com
Date: Mon, 23 Apr 2018 16:36:23 +0100
From: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Raj Ashok <ashok.raj@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 14/22] iommu: handle page response timeout
Message-ID: <20180423153622.GC38106@ostrya.localdomain>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-15-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1523915351-54415-15-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910205943696?=
X-GMAIL-MSGID: =?utf-8?q?1598551795772155994?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 10:49:03PM +0100, Jacob Pan wrote:
> When IO page faults are reported outside IOMMU subsystem, the page
> request handler may fail for various reasons. E.g. a guest received
> page requests but did not have a chance to run for a long time. The
> irresponsive behavior could hold off limited resources on the pending
> device.
> There can be hardware or credit based software solutions as suggested
> in the PCI ATS Ch-4. To provide a basic safty net this patch
> introduces a per device deferrable timer which monitors the longest
> pending page fault that requires a response. Proper action such as
> sending failure response code could be taken when timer expires but not
> included in this patch. We need to consider the life cycle of page
> groupd ID to prevent confusion with reused group ID by a device.
> For now, a warning message provides clue of such failure.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  drivers/iommu/iommu.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/iommu.h |  4 ++++
>  2 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 628346c..f6512692 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -799,6 +799,39 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
>  
> +/* Max time to wait for a pending page request */
> +#define IOMMU_PAGE_RESPONSE_MAXTIME (HZ * 10)
> +static void iommu_dev_fault_timer_fn(struct timer_list *t)
> +{
> +	struct iommu_fault_param *fparam = from_timer(fparam, t, timer);
> +	struct iommu_fault_event *evt, *iter;
> +
> +	u64 now;
> +
> +	now = get_jiffies_64();
> +
> +	/* The goal is to ensure driver or guest page fault handler(via vfio)
> +	 * send page response on time. Otherwise, limited queue resources
> +	 * may be occupied by some irresponsive guests or drivers.

By "limited queue resources", do you mean the PRI fault queue in the
pIOMMU device, or something else?


I'm still uneasy about this timeout. We don't really know if the guest
doesn't respond because it is suspended, because it doesn't support PRI
or because it's attempting to kill the host. In the first case, then
receiving and responding to page requests later than 10s should be fine,
right?

Or maybe the guest is doing something weird like fetching pages from
network storage and it occasionally hits a latency oddity. This wouldn't
interrupt the fault queues, because other page requests for the same
device can be serviced in parallel, but if you implement a PRG timeout
it would still unfairly disable PRI.

In the other cases (unsupported PRI or rogue guest) then disabling PRI
using a FAILURE status might be the right thing to do. However, assuming
the device follows the PCI spec it will stop sending page requests once
there are as many PPRs in flight as the allocated credit.

Even though drivers set the PPR credit number arbitrarily (because
finding an ideal number is difficult or impossible), the device stops
issuing faults at some point if the guest is unresponsive, and it won't
grab any more shared resources, or use slots in shared queues. Resources
for pending faults can be cleaned when the device is reset and assigned
to a different guest.


That's for sane endpoints that follow the spec. If on the other hand, we
can't rely on the device implementation to respect our maximum credit
allocation, then we should do the accounting ourselves and reject
incoming faults with INVALID as fast as possible. Otherwise it's an easy
way for a guest to DoS the host and I don't think a timeout solves this
problem (The guest can wait 9 seconds before replying to faults and
meanwhile fill all the queues). In addition the timeout is done on PRGs
but not individual page faults, so a guest could overflow the queues by
triggering lots of page requests without setting the last bit.


If there isn't any possibility of memory leak or abusing resources, I
don't think it's our problem that the guest is excessively slow at
handling page requests. Setting an upper bound to page request latency
might do more harm than good. Ensuring that devices respect the number
of allocated in-flight PPRs is more important in my opinion.

> +	 * When per device pending fault list is not empty, we periodically checks
> +	 * if any anticipated page response time has expired.
> +	 *
> +	 * TODO:
> +	 * We could do the following if response time expires:
> +	 * 1. send page response code FAILURE to all pending PRQ
> +	 * 2. inform device driver or vfio
> +	 * 3. drain in-flight page requests and responses for this device
> +	 * 4. clear pending fault list such that driver can unregister fault
> +	 *    handler(otherwise blocked when pending faults are present).
> +	 */
> +	list_for_each_entry_safe(evt, iter, &fparam->faults, list) {
> +		if (time_after64(evt->expire, now))
> +			pr_err("Page response time expired!, pasid %d gid %d exp %llu now %llu\n",
> +				evt->pasid, evt->page_req_group_id, evt->expire, now);
> +	}
> +	mod_timer(t, now + IOMMU_PAGE_RESPONSE_MAXTIME);
> +}
> +
>  /**
>   * iommu_register_device_fault_handler() - Register a device fault handler
>   * @dev: the device
> @@ -806,8 +839,8 @@ EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
>   * @data: private data passed as argument to the handler
>   *
>   * When an IOMMU fault event is received, call this handler with the fault event
> - * and data as argument. The handler should return 0. If the fault is
> - * recoverable (IOMMU_FAULT_PAGE_REQ), the handler must also complete
> + * and data as argument. The handler should return 0 on success. If the fault is
> + * recoverable (IOMMU_FAULT_PAGE_REQ), the handler can also complete

This change might belong in patch 12/22

>   * the fault by calling iommu_page_response() with one of the following
>   * response code:
>   * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
> @@ -848,6 +881,9 @@ int iommu_register_device_fault_handler(struct device *dev,
>  	param->fault_param->data = data;
>  	INIT_LIST_HEAD(&param->fault_param->faults);
>  
> +	timer_setup(&param->fault_param->timer, iommu_dev_fault_timer_fn,
> +		TIMER_DEFERRABLE);
> +
>  	mutex_unlock(&param->lock);
>  
>  	return 0;
> @@ -905,6 +941,8 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  {
>  	int ret = 0;
>  	struct iommu_fault_event *evt_pending;
> +	struct timer_list *tmr;
> +	u64 exp;
>  	struct iommu_fault_param *fparam;
>  
>  	/* iommu_param is allocated when device is added to group */
> @@ -925,6 +963,17 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  			goto done_unlock;
>  		}
>  		memcpy(evt_pending, evt, sizeof(struct iommu_fault_event));
> +		/* Keep track of response expiration time */
> +		exp = get_jiffies_64() + IOMMU_PAGE_RESPONSE_MAXTIME;
> +		evt_pending->expire = exp;
> +
> +		if (list_empty(&fparam->faults)) {

The list_empty() and timer modification need to be inside fparam->lock,
otherwise we race with iommu_page_response

Thanks,
Jean

> +			/* First pending event, start timer */
> +			tmr = &dev->iommu_param->fault_param->timer;
> +			WARN_ON(timer_pending(tmr));
> +			mod_timer(tmr, exp);
> +		}
> +
>  		mutex_lock(&fparam->lock);
>  		list_add_tail(&evt_pending->list, &fparam->faults);
>  		mutex_unlock(&fparam->lock);
> @@ -1542,6 +1591,13 @@ int iommu_page_response(struct device *dev,
>  		}
>  	}
>  
> +	/* stop response timer if no more pending request */
> +	if (list_empty(&param->fault_param->faults) &&
> +		timer_pending(&param->fault_param->timer)) {
> +		pr_debug("no pending PRQ, stop timer\n");
> +		del_timer(&param->fault_param->timer);
> +	}
