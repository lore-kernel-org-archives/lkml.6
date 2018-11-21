Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F52C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6C9214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6C9214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbeKVDZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:25:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbeKVDZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:25:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90D0930832E5;
        Wed, 21 Nov 2018 16:49:56 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B29F5C265;
        Wed, 21 Nov 2018 16:49:55 +0000 (UTC)
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
Date:   Wed, 21 Nov 2018 11:49:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542653726-5655-8-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 21 Nov 2018 16:49:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2018 01:55 PM, Waiman Long wrote:
> The db->lock is a raw spinlock and so the lock hold time is supposed
> to be short. This will not be the case when printk() is being involved
> in some of the critical sections. In order to avoid the long hold time,
> in case some messages need to be printed, the debug_object_is_on_stack()
> and debug_print_object() calls are now moved out of those critical
> sections.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  lib/debugobjects.c | 61 +++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 19 deletions(-)
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index 403dd95..4216d3d 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -376,6 +376,8 @@ static void debug_object_is_on_stack(void *addr, int onstack)
>  	struct debug_bucket *db;
>  	struct debug_obj *obj;
>  	unsigned long flags;
> +	bool debug_printobj = false;
> +	bool debug_chkstack = false;
>  
>  	fill_pool();
>  
> @@ -392,7 +394,7 @@ static void debug_object_is_on_stack(void *addr, int onstack)
>  			debug_objects_oom();
>  			return;
>  		}
> -		debug_object_is_on_stack(addr, onstack);
> +		debug_chkstack = true;
>  	}
>  
>  	switch (obj->state) {
> @@ -403,20 +405,25 @@ static void debug_object_is_on_stack(void *addr, int onstack)
>  		break;
>  
>  	case ODEBUG_STATE_ACTIVE:
> -		debug_print_object(obj, "init");
>  		state = obj->state;
>  		raw_spin_unlock_irqrestore(&db->lock, flags);
> +		debug_print_object(obj, "init");
>  		debug_object_fixup(descr->fixup_init, addr, state);
>  		return;
>  
>  	case ODEBUG_STATE_DESTROYED:
> -		debug_print_object(obj, "init");
> +		debug_printobj = true;
>  		break;
>  	default:
>  		break;
>  	}
>  
>  	raw_spin_unlock_irqrestore(&db->lock, flags);
> +	if (debug_chkstack)
> +		debug_object_is_on_stack(addr, onstack);
> +	if (debug_printobj)
> +		debug_print_object(obj, "init");
> +
>  }
>  
>  /**
> @@ -474,6 +481,8 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
>  
>  	obj = lookup_object(addr, db);
>  	if (obj) {
> +		bool debug_printobj = false;
> +
>  		switch (obj->state) {
>  		case ODEBUG_STATE_INIT:
>  		case ODEBUG_STATE_INACTIVE:
> @@ -482,14 +491,14 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
>  			break;
>  
>  		case ODEBUG_STATE_ACTIVE:
> -			debug_print_object(obj, "activate");
>  			state = obj->state;
>  			raw_spin_unlock_irqrestore(&db->lock, flags);
> +			debug_print_object(obj, "activate");
>  			ret = debug_object_fixup(descr->fixup_activate, addr, state);
>  			return ret ? 0 : -EINVAL;
>  
>  		case ODEBUG_STATE_DESTROYED:
> -			debug_print_object(obj, "activate");
> +			debug_printobj = true;
>  			ret = -EINVAL;
>  			break;
>  		default:
> @@ -497,10 +506,13 @@ int debug_object_activate(void *addr, struct debug_obj_descr *descr)
>  			break;
>  		}
>  		raw_spin_unlock_irqrestore(&db->lock, flags);
> +		if (debug_printobj)
> +			debug_print_object(obj, "activate");
>  		return ret;
>  	}
>  
>  	raw_spin_unlock_irqrestore(&db->lock, flags);
> +
>  	/*
>  	 * We are here when a static object is activated. We
>  	 * let the type specific code confirm whether this is
> @@ -532,6 +544,7 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
>  	struct debug_bucket *db;
>  	struct debug_obj *obj;
>  	unsigned long flags;
> +	bool debug_printobj = false;
>  
>  	if (!debug_objects_enabled)
>  		return;
> @@ -549,24 +562,27 @@ void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
>  			if (!obj->astate)
>  				obj->state = ODEBUG_STATE_INACTIVE;
>  			else
> -				debug_print_object(obj, "deactivate");
> +				debug_printobj = true;
>  			break;
>  
>  		case ODEBUG_STATE_DESTROYED:
> -			debug_print_object(obj, "deactivate");
> +			debug_printobj = true;
>  			break;
>  		default:
>  			break;
>  		}
> -	} else {
> +	}
> +
> +	raw_spin_unlock_irqrestore(&db->lock, flags);
> +	if (!obj) {
>  		struct debug_obj o = { .object = addr,
>  				       .state = ODEBUG_STATE_NOTAVAILABLE,
>  				       .descr = descr };
>  
>  		debug_print_object(&o, "deactivate");
> +	} else if (debug_printobj) {
> +		debug_print_object(obj, "deactivate");
>  	}
> -
> -	raw_spin_unlock_irqrestore(&db->lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(debug_object_deactivate);
>  
> @@ -581,6 +597,7 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
>  	struct debug_bucket *db;
>  	struct debug_obj *obj;
>  	unsigned long flags;
> +	bool debug_printobj = false;
>  
>  	if (!debug_objects_enabled)
>  		return;
> @@ -600,20 +617,22 @@ void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
>  		obj->state = ODEBUG_STATE_DESTROYED;
>  		break;
>  	case ODEBUG_STATE_ACTIVE:
> -		debug_print_object(obj, "destroy");
>  		state = obj->state;
>  		raw_spin_unlock_irqrestore(&db->lock, flags);
> +		debug_print_object(obj, "destroy");
>  		debug_object_fixup(descr->fixup_destroy, addr, state);
>  		return;
>  
>  	case ODEBUG_STATE_DESTROYED:
> -		debug_print_object(obj, "destroy");
> +		debug_printobj = true;
>  		break;
>  	default:
>  		break;
>  	}
>  out_unlock:
>  	raw_spin_unlock_irqrestore(&db->lock, flags);
> +	if (debug_printobj)
> +		debug_print_object(obj, "destroy");
>  }
>  EXPORT_SYMBOL_GPL(debug_object_destroy);
>  
> @@ -642,9 +661,9 @@ void debug_object_free(void *addr, struct debug_obj_descr *descr)
>  
>  	switch (obj->state) {
>  	case ODEBUG_STATE_ACTIVE:
> -		debug_print_object(obj, "free");
>  		state = obj->state;
>  		raw_spin_unlock_irqrestore(&db->lock, flags);
> +		debug_print_object(obj, "free");
>  		debug_object_fixup(descr->fixup_free, addr, state);
>  		return;
>  	default:
> @@ -717,6 +736,7 @@ void debug_object_assert_init(void *addr, struct debug_obj_descr *descr)
>  	struct debug_bucket *db;
>  	struct debug_obj *obj;
>  	unsigned long flags;
> +	bool debug_printobj = false;
>  
>  	if (!debug_objects_enabled)
>  		return;
> @@ -732,22 +752,25 @@ void debug_object_assert_init(void *addr, struct debug_obj_descr *descr)
>  			if (obj->astate == expect)
>  				obj->astate = next;
>  			else
> -				debug_print_object(obj, "active_state");
> +				debug_printobj = true;
>  			break;
>  
>  		default:
> -			debug_print_object(obj, "active_state");
> +			debug_printobj = true;
>  			break;
>  		}
> -	} else {
> +	}
> +
> +	raw_spin_unlock_irqrestore(&db->lock, flags);
> +	if (!obj) {
>  		struct debug_obj o = { .object = addr,
>  				       .state = ODEBUG_STATE_NOTAVAILABLE,
>  				       .descr = descr };
>  
>  		debug_print_object(&o, "active_state");
> +	} else if (debug_printobj) {
> +		debug_print_object(obj, "active_state");
>  	}
> -
> -	raw_spin_unlock_irqrestore(&db->lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(debug_object_active_state);
>  
> @@ -783,10 +806,10 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
>  
>  			switch (obj->state) {
>  			case ODEBUG_STATE_ACTIVE:
> -				debug_print_object(obj, "free");
>  				descr = obj->descr;
>  				state = obj->state;
>  				raw_spin_unlock_irqrestore(&db->lock, flags);
> +				debug_print_object(obj, "free");
>  				debug_object_fixup(descr->fixup_free,
>  						   (void *) oaddr, state);
>  				goto repeat;

As a side note, one of the test systems that I used generated a
debugobjects splat in the bootup process and the system hanged
afterward. Applying this patch alone fix the hanging problem and the
system booted up successfully. So it is not really a good idea to call
printk() while holding a raw spinlock.

Cheers,
Longman

