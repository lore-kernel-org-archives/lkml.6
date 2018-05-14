Return-Path: <baolu.lu@linux.intel.com>
X-Google-Smtp-Source: AB8JxZoMWwVuFHaZFJVjvXinT3T/ED9SrCfS5Se5WcGnuXPWMCHIYbKl/gQTNttJ0vglAjkgbhqA
ARC-Seal: i=1; a=rsa-sha256; t=1526283838; cv=none;
        d=google.com; s=arc-20160816;
        b=ZDJaR1jn4eN39ootJntQzuAlUD8mHJAzctzX+62gWMde+TbitrKGl0DvDp3KDg6jrg
         uMbcdsKSYNzDq+VXKFJtx7sT63I0gLtz9iiiBR3yR7PNCSUqN3ephNiexO+pN5a1iCxJ
         R438PW3MyiSKCkZpZmjZ9mLSq2if1BwZnCh317KjX5mSGgMhVAH7PoQDe6Waj7TtNNnF
         AZB0zJWt2qfE//ChAwZSQM+kHp7E2reRcTvnFx1zM1NJLbGm+/+TEfejjiKY2ou5X019
         iOY+h7Ymaj9cNwGFcMhrCy1wWnpR6LVHUS71Y9WIV5z4FNcAeq0pug0Vhxrp+jPGX99v
         C79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=UCz5dW1WWQJDcSQVZbzVStDe7VdF6bwgQDYYeCK3EJQ=;
        b=Nf6ug1bXCHXl2ckXBliN6iSapQpf5KLuWlx82srSnBLMw8FkzNcTmufoQwv8s8cd7f
         amFKLNzN375Yq4bVVOJFpcwSlYXqYmYg5fddFUsnZM2DYztnE2mNEYNFK4pT25GEvL2n
         Bq4+08yYr04SOu+rRYWe2+3SwqstxmDRQGBlJ3OYQGXKOWCygSmv3pavRKOeJwyf5sNs
         WYiE/q88YYLzLLhHWwgxhDMUOER1TTxxhCe99SYf+4xOGDCA4VdEekBbuC3VcoEzZ1EP
         nWSBizKcCbsrrhuCToZI/5CrIJI0KCkBEnJOy2MmLPuNYP5iZ4Pw7pPUqbV5SA00wezQ
         lnjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="41574446"
Subject: Re: [PATCH v5 15/23] iommu: handle page response timeout
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-16-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AF93E3A.2040902@linux.intel.com>
Date: Mon, 14 May 2018 15:43:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-16-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202363768984525?=
X-GMAIL-MSGID: =?utf-8?q?1600424602465608041?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/12/2018 04:54 AM, Jacob Pan wrote:
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
>  drivers/iommu/iommu.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h |  4 ++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 02fed3e..1f2f49e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -827,6 +827,37 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
>  
> +static void iommu_dev_fault_timer_fn(struct timer_list *t)
> +{
> +	struct iommu_fault_param *fparam = from_timer(fparam, t, timer);
> +	struct iommu_fault_event *evt;
> +
> +	u64 now;
> +
> +	now = get_jiffies_64();
> +
> +	/* The goal is to ensure driver or guest page fault handler(via vfio)
> +	 * send page response on time. Otherwise, limited queue resources
> +	 * may be occupied by some irresponsive guests or drivers.
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
> +	list_for_each_entry(evt, &fparam->faults, list) {
> +		if (time_after64(now, evt->expire))
> +			pr_err("Page response time expired!, pasid %d gid %d exp %llu now %llu\n",
> +				evt->pasid, evt->page_req_group_id, evt->expire, now);
> +	}
> +	mod_timer(t, now + prq_timeout);
> +}
> +

This timer scheme is very rough.

The timer expires every 10 seconds (by default).

0                   10                 20                30                 40            
+---------------+---------------+---------------+---------------+
^  ^   ^  ^                        ^
 |   |     |    |                         |
F0 F1  F2 F3                       (F1,F2,F3 will not be handled until here!)

F0, F1, F2, F3 are four page faults happens during [0, 10s) time
window. F1, F2, F3 timeout won't be handled until the timer expires
again at 20s. That means a fault might be pending there until about
(2 * prq_timeout) seconds later.

Out of curiosity, Why not adding a timer in iommu_fault_event, starting it in
iommu_report_device_fault() and removing it in iommu_page_response()?

Best regards,
Lu Baolu


>  /**
>   * iommu_register_device_fault_handler() - Register a device fault handler
>   * @dev: the device
> @@ -879,6 +910,9 @@ int iommu_register_device_fault_handler(struct device *dev,
>  	param->fault_param->data = data;
>  	INIT_LIST_HEAD(&param->fault_param->faults);
>  
> +	if (prq_timeout)
> +		timer_setup(&param->fault_param->timer, iommu_dev_fault_timer_fn,
> +			TIMER_DEFERRABLE);
>  done_unlock:
>  	mutex_unlock(&param->lock);
>  
> @@ -935,6 +969,8 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  {
>  	int ret = 0;
>  	struct iommu_fault_event *evt_pending;
> +	struct timer_list *tmr;
> +	u64 exp;
>  	struct iommu_fault_param *fparam;
>  
>  	/* iommu_param is allocated when device is added to group */
> @@ -955,7 +991,17 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  			ret = -ENOMEM;
>  			goto done_unlock;
>  		}
> +		/* Keep track of response expiration time */
> +		exp = get_jiffies_64() + prq_timeout;
> +		evt_pending->expire = exp;
>  		mutex_lock(&fparam->lock);
> +		if (list_empty(&fparam->faults)) {
> +			/* First pending event, start timer */
> +			tmr = &dev->iommu_param->fault_param->timer;
> +			WARN_ON(timer_pending(tmr));
> +			mod_timer(tmr, exp);
> +		}
> +
>  		list_add_tail(&evt_pending->list, &fparam->faults);
>  		mutex_unlock(&fparam->lock);
>  	}
> @@ -1572,6 +1618,13 @@ int iommu_page_response(struct device *dev,
>  		}
>  	}
>  
> +	/* stop response timer if no more pending request */
> +	if (list_empty(&param->fault_param->faults) &&
> +		timer_pending(&param->fault_param->timer)) {
> +		pr_debug("no pending PRQ, stop timer\n");
> +		del_timer(&param->fault_param->timer);
> +	}
> +
>  done_unlock:
>  	mutex_unlock(&param->fault_param->lock);
>  	return ret;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 722b90f..f3665b7 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -360,6 +360,7 @@ enum iommu_fault_reason {
>   * @iommu_private: used by the IOMMU driver for storing fault-specific
>   *                 data. Users should not modify this field before
>   *                 sending the fault response.
> + * @expire: time limit in jiffies will wait for page response
>   */
>  struct iommu_fault_event {
>  	struct list_head list;
> @@ -373,6 +374,7 @@ struct iommu_fault_event {
>  	u32 prot;
>  	u64 device_private;
>  	u64 iommu_private;
> +	u64 expire;
>  };
>  
>  /**
> @@ -380,11 +382,13 @@ struct iommu_fault_event {
>   * @dev_fault_handler: Callback function to handle IOMMU faults at device level
>   * @data: handler private data
>   * @faults: holds the pending faults which needs response, e.g. page response.
> + * @timer: track page request pending time limit
>   * @lock: protect pending PRQ event list
>   */
>  struct iommu_fault_param {
>  	iommu_dev_fault_handler_t handler;
>  	struct list_head faults;
> +	struct timer_list timer;
>  	struct mutex lock;
>  	void *data;
>  };
