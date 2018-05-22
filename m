Return-Path: <reinette.chatre@intel.com>
X-Google-Smtp-Source: AB8JxZoRmoylcpclqNgsdk1WB/lu7Y5NHqAqSMOgR3L2DQ0odtwvBBxOZK3fQcj0IlkXXiUOOjP5
ARC-Seal: i=1; a=rsa-sha256; t=1527022959; cv=none;
        d=google.com; s=arc-20160816;
        b=D7rWEMnda/p2qSApbFKutP10lA1SE7nYhGtHK5nuWmUfS3jdX5yOf8TXlXl9bbf2Dw
         f28lxhIqUlERlbkr6gL0iMmEdZbERRPIo9YzJRn273z/eJik03E4AoJCFotBLC5NYMqD
         aqbKKWdDgJwHwRPXPauXMfpaqFTJucmPY1oZoa/aZdABf+WUjK3TXrgxmspkxKnh68XG
         AYpXbta6cKFRW1Q/MbB88gHxzSLGVDu7MTkZXsCeOC4qLmRe74rvn9XKghQU6njhe1OG
         /K5vvLmZi9zSgHsWJ/51HtNXamU73L8xy+Ox4eq4zoBm+WKAeFQmaTCqfrXBM0AGtMsF
         i8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=0dM+QJ2vUrxWCtcKZzQaXQmzTQOb/Z2eT+JMV1953us=;
        b=QqjWtaA2mvPOhizjF/ym9HsB/gzCT1relvCMGtV/Cesms7X4jYI/yTI/5tnzLBQXGh
         Oy2GoIU+Wj9SZ2UHvuKQdKV+hgzKtGZDNsAdDCtH+V4ehz/MMykSd+fQJbK/HeXEmcJU
         V8n9kPd016AOY4lLHe4inUrllq39JBFkQTL51scBY+96ejr73fTHgKKSclgs0/WRfR8U
         Hc7Ktouy53IZyJEPGysoq5ww6eOUnW1IQIUZGl+xZpTPuwTt8xfclEDMUSvsgsbNQ08v
         nC8Ti7nGNN1f2fRiL+xcFlT+Dbs/iO2KvDfhYXHek3xE51JAeLXUkLGezCmBGOFQ2X/8
         gWdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of reinette.chatre@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=reinette.chatre@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of reinette.chatre@intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=reinette.chatre@intel.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="43394696"
Subject: Re: [PATCH V4 34/38] x86/intel_rdt: Create debugfs files for
 pseudo-locking testing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
 vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
 jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
 hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1526987654.git.reinette.chatre@intel.com>
 <2da8730575c589eb7303c7b18a2721da40c446e2.1526987654.git.reinette.chatre@intel.com>
 <20180522194300.GA9656@kroah.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <b32a1e6a-1675-0c96-69d3-75bc97a672b4@intel.com>
Date: Tue, 22 May 2018 14:02:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180522194300.GA9656@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1601199626751319595?=
X-GMAIL-MSGID: =?utf-8?q?1601199626751319595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Thank you very much for taking a look.

On 5/22/2018 12:43 PM, Greg KH wrote:
> On Tue, May 22, 2018 at 04:29:22AM -0700, Reinette Chatre wrote:
>> @@ -149,6 +151,9 @@ struct pseudo_lock_region {
>>  	unsigned int		line_size;
>>  	unsigned int		size;
>>  	void			*kmem;
>> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
>> +	struct dentry		*debugfs_dir;
>> +#endif
> 
> Who cares, just always have this here, it's not going to save you
> anything to #ifdef the .c code everywhere just for this one pointer.

ok

> 
>> @@ -174,6 +180,9 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>>  		plr->d->plr = NULL;
>>  	plr->d = NULL;
>>  	plr->cbm = 0;
>> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
>> +	plr->debugfs_dir = NULL;
>> +#endif
> 
> See?  Ick.
> 
>> +	ret = strtobool(buf, &bv);
>> +	if (ret == 0 && bv) {
>> +		ret = debugfs_file_get(file->f_path.dentry);
>> +		if (unlikely(ret))
>> +			return ret;
> 
> Only ever use unlikely/likely if you can measure the performance
> difference.  Hint, you can't do that here, it's not needed at all.

Here my intention was to follow the current best practices and in the
kernel source I am working with eight of the ten usages of
debugfs_file_get() is followed by an unlikely(). My assumption was thus
that this is a best practice. Thanks for catching this - I'll change it.

>> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
>> +	plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
>> +					      debugfs_resctrl);
>> +	if (IS_ERR(plr->debugfs_dir)) {
>> +		ret = PTR_ERR(plr->debugfs_dir);
>> +		plr->debugfs_dir = NULL;
>> +		goto out_region;
> 
> Ick no, you never need to care about the return value of a debugfs call.
> You code should never do something different if a debugfs call succeeds
> or fails.  And you are checking it wrong, even if you did want to do
> this :)

Ah - I see I need to be using IS_ERR_OR_NULL() instead of IS_ERR()? If
this is the case then please note that there seems to be quite a few
debugfs_create_dir() calls within the kernel that have the same issue.

>> +	}
>> +
>> +	entry = debugfs_create_file("pseudo_lock_measure", 0200,
>> +				    plr->debugfs_dir, rdtgrp,
>> +				    &pseudo_measure_fops);
>> +	if (IS_ERR(entry)) {
>> +		ret = PTR_ERR(entry);
>> +		goto out_debugfs;
>> +	}
> 
> Again, you don't care, don't do this.
> 
>> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
>> +	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
>> +#endif
> 
> Don't put ifdefs in .c files, it's not the Linux way at all.  You can
> make this a lot simpler/easier to maintain over time if you do not.

My mistake - I assumed this would be ok based on my interpretation of
how CONFIG_GENERIC_IRQ_DEBUGFS is used.

I could rework the debugfs code to be contained in a new debugfs
specific .c file that is only compiled if the configuration is set. The
ifdefs will then be restricted to a .h file that contains the
declarations of these debugfs functions with empty variants when the
user did not select the debugfs config option.

Would that be acceptable to you?

Reinette
