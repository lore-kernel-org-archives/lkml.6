Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELuoD5RX4G+gA0WI/rL0oB6yMaXr2byjIyl9qbdfJa9uwxsq7UgRZWxh53U/8JQtRQncBMGi
ARC-Seal: i=1; a=rsa-sha256; t=1521575086; cv=none;
        d=google.com; s=arc-20160816;
        b=hITOx4TGS4ET1wsDc1VvN9LP7xBii4XNSX4k8GTcbpw7Y5m5JuGPAr1VLzPRxe2aGr
         nLmdE9qvtsvr1Irl91XXWdQQSSP+PTEjL1Qe9FLHwuyPJ+IQOMd93vnLZctkhk0PSQZ7
         3bei5aSJ4jzhSBb2u2l8R6iORwGrJ2MqjS8RvkgO6BLpc5kD1gE5MuaxxYUNWueWV+j+
         5Zq3iTVqUurBhneecsMIhrXjPjM4B9+ac9P1k6byvMjJdYpIwNXwZm0jF7/XXYtVNfFl
         pafjW8yzt9lokwyIySzb2Fmx3Cy28HaaatveYvsCwp2tNn2oVpzsLO6uHPjDtCU1L15K
         OQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=BeOyNGWaMwHKNPTmp5U2ODyamuRtt8pPmR1Z2SyXfgg=;
        b=Zj5HOjjSTuR+BBfBf1mbDcEW0YsFVuP47u0p78KnLVWT3wc13Q94felb72ZYm6uoQ0
         v2apab4C438P0ZAGAZl0rTP6pGdAAqp7KxO3OFouxrLkAJh19X0Tbc8WK/IjTtBVRWsn
         3ZyaqDQtouY6ZELk3Qh2Ad0xMmwtDUA7mhW3/cFpuNFpFkMiYsprYi6iZLBqQ1fuOa1T
         /D6TMTIPsqNcVKVeT9m/bsBz4TSQvhckQWccdCAyb7PT9tEIkX82vXGs3wSx+g/4K09x
         Eur44bt61QDx0yEdYNn1+Tb3s8yDcZ1ZNpEhaHDY7ncq9KO0dn4n3JEgP6eaaP/8q5nJ
         Q6oA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Tue, 20 Mar 2018 20:44:33 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
    LKML <linux-kernel@vger.kernel.org>,
    Philippe Ombredanne <pombredanne@nexb.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Kate Stewart <kstewart@linuxfoundation.org>,
    Waiman Long <longman@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] RFC: debugobjects: capture stack traces at _init()
 time
In-Reply-To: <20180320160258.11381-1-daniel.vetter@ffwll.ch>
Message-ID: <alpine.DEB.2.21.1803201929340.1714@nanos.tec.linutronix.de>
References: <20180320160258.11381-1-daniel.vetter@ffwll.ch>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595473170470511522?=
X-GMAIL-MSGID: =?utf-8?q?1595487118437294142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 20 Mar 2018, Daniel Vetter wrote:

> Sometimes it's really easy to know which object has gone boom and
> where the offending code is, and sometimes it's really hard. One case
> we're trying to hunt down is when module unload catches a live debug
> object, with a module with lots of them.
> 
> Capture a full stack trace from debug_object_init() and dump it when
> there's a problem.
> 
> FIXME: Should we have a separate Kconfig knob for the backtraces,
> they're quite expensive? Atm I'm just selecting it for the general
> debug object stuff.

Just make it boot time enabled. We really want to be able to switch it off.

> +#define ODEBUG_STACKDEPTH 32

Do we really need it that deep? I doubt that.

> +static noinline depot_stack_handle_t save_stack(struct debug_obj *obj)
> +{
> +	unsigned long entries[ODEBUG_STACKDEPTH];
> +	struct stack_trace trace = {
> +		.entries = entries,
> +		.max_entries = ODEBUG_STACKDEPTH,
> +		.skip = 2
> +	};
> +
> +	save_stack_trace(&trace);
> +	if (trace.nr_entries != 0 &&
> +	    trace.entries[trace.nr_entries-1] == ULONG_MAX)
> +		trace.nr_entries--;
> +
> +	/* May be called under spinlock, so avoid sleeping */
> +	return depot_save_stack(&trace, GFP_NOWAIT);

I really don't like the idea of unconditional allocations in that code
path. We went great length to make it perform halfways sane with the
pool. Though we should actually have per cpu pools to avoid the lock
contention, but thats a different problem.

I'd rather make the storage a fixed size allocation which is appended
to the debug object. Something like this:

struct debug_obj_trace {
	struct stack_trace	trace;
	unsigned long		entries[ODEBUG_STACKDEPTH];
};	

struct debug_obj {
	unsigned int		astate;
	void			*object;
	struct debug_obj_descr	*descr;
	struct debug_obj_trace	trace[0];
};

void __init debug_objects_mem_init(void)
{
	unsigned long objsize = sizeof (struct debug_obj);

 	if (!debug_objects_enabled)
 		return;
 
	if (debug_objects_trace_stack)
		objsize += sizeof(struct debug_obj_trace);

	obj_cache = kmem_cache_create("debug_objects_cache", objsize, 0,
 				      SLAB_DEBUG_OBJECTS, NULL);

__debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
{
	....
 	case ODEBUG_STATE_NONE:
 	case ODEBUG_STATE_INIT:
 	case ODEBUG_STATE_INACTIVE:
		if (debug_object_trace_stack) {
			obj->trace[0].trace.entries = obj->trace[0].entries;
			save_stack_trace(&trace[0].trace);
		}
 
That means we need to size the static objects which are used during early
boot with stack under the assumption that stack tracing is enabled, but
that's simple enough.

Hmm?

Thanks,

	tglx
