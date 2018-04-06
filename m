Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755137AbeDFPDQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:03:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752521AbeDFPDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:03:14 -0400
Date: Fri, 6 Apr 2018 16:02:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <benjamin.gaignard@st.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/8] counter: Introduce the Generic Counter interface
Message-ID: <20180406160246.00006001@huawei.com>
In-Reply-To: <20180401004154.GA21955@sophia>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
        <e64e423c19d69a9578e95de9db6ca41e231d63da.1520614431.git.vilhelm.gray@gmail.com>
        <20180324173358.571e2fd8@archlinux>
        <20180401004154.GA21955@sophia>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Mar 2018 20:41:54 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sat, Mar 24, 2018 at 05:33:58PM +0000, Jonathan Cameron wrote:
> >On Fri,  9 Mar 2018 13:42:23 -0500
> >William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >  
> >> This patch introduces the Generic Counter interface for supporting
> >> counter devices.
> >> 
> >> In the context of the Generic Counter interface, a counter is defined as
> >> a device that reports one or more "counts" based on the state changes of
> >> one or more "signals" as evaluated by a defined "count function."
> >> 
> >> Driver callbacks should be provided to communicate with the device: to
> >> read and write various Signals and Counts, and to set and get the
> >> "action mode" and "count function" for various Synapses and Counts
> >> respectively.
> >> 
> >> To support a counter device, a driver must first allocate the available
> >> Counter Signals via counter_signal structures. These Signals should
> >> be stored as an array and set to the signals array member of an
> >> allocated counter_device structure before the Counter is registered to
> >> the system.
> >> 
> >> Counter Counts may be allocated via counter_count structures, and
> >> respective Counter Signal associations (Synapses) made via
> >> counter_synapse structures. Associated counter_synapse structures are
> >> stored as an array and set to the the synapses array member of the
> >> respective counter_count structure. These counter_count structures are
> >> set to the counts array member of an allocated counter_device structure
> >> before the Counter is registered to the system.
> >> 
> >> A counter device is registered to the system by passing the respective
> >> initialized counter_device structure to the counter_register function;
> >> similarly, the counter_unregister function unregisters the respective
> >> Counter. The devm_counter_register and devm_counter_unregister functions
> >> serve as device memory-managed versions of the counter_register and
> >> counter_unregister functions respectively.
> >> 
> >> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>  
> >
> >Hi William,
> >
> >I would leave the existing drivers where they are until you are ready
> >to convert them.  I.e. Do the moves as separate patches from this one
> >as it just adds noise here and they aren't ready immediately.
> >
> >The externs in the header add code for no benefit and make it hard
> >to align the parameters nicely. I would drop them all.
> >
> >Few other minor bits and bobs inline.  There is a lot of 'automatic'
> >cleanup in here, but I think you have missed a few cases where the
> >attribute element hasn't 'yet' been added to the list. (I may be
> >missing something)
> >
> >Fundamentally looks good though.
> >
> >Jonathan  
> 
> Hi Jonathan,
> 
> Most of these are simple cleanups so I don't anticipate any trouble
> incorporating them in version 6 of this patchset. :-)
> 
> Regarding the "name" strings allocated throughout, these are freed later
> in the free_counter_device_groups_list function (which is called on
> error codes passed up). This unwinding is hard to follow so I think I'll
> refactor these code blocks to perform frees closer to the relevant
> memory allocations; despite the additional code, I expect the clearer
> logic will aid future debugging endevors.
> 
> Some minor comments follow.
> 
> William Breathitt Gray
> 
> [...]
> 
> >> +static int counter_counts_register(
> >> +	struct counter_device_attr_group *const groups_list,
> >> +	const struct counter_device *const counter)
> >> +{
> >> +	const size_t num_counts = counter->num_counts;
> >> +	struct device *const dev = &counter->device_state->dev;
> >> +	size_t i;
> >> +	struct counter_count *count;
> >> +	const char *name;
> >> +	int err;
> >> +
> >> +	/* At least one Count must be defined */
> >> +	if (!counter->counts || !num_counts) {
> >> +		dev_err(dev, "Counts undefined\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	/* Register each Count */
> >> +	for (i = 0; i < num_counts; i++) {
> >> +		count = counter->counts + i;  
> >Is counter->counts ever set anywhere?  
> 
> This is the array of struct counter_count defined by the consuming
> driver. The preceding null checks are sanity checks -- drivers should
> always set the counts and num_counts members before calling the
> counter_register function.
> 
> Since drivers are required to set these members, perhaps I should
> remove the sanity checks as superfluous since it is unlikely an unset
> counts or num_counts member would pass unnoticed by driver authors,
> reviews, and maintainers. Would it make sense to remove this
> conditional?
I'd leave the there - don't do much harm and might catch something
one day!

> 
> >> +/**
> >> + * devm_counter_register - Resource-managed counter_register
> >> + * @dev:	device to allocate counter_device for
> >> + * @counter:	pointer to Counter to register
> >> + *
> >> + * Managed counter_register. The Counter registered with this function is
> >> + * automatically unregistered on driver detach. This function calls
> >> + * counter_register internally. Refer to that function for more information.
> >> + *
> >> + * If an Counter registered with this function needs to be unregistered
> >> + * separately, devm_counter_unregister must be used.
> >> + *
> >> + * RETURNS:
> >> + * 0 on success, negative error number on failure.
> >> + */
> >> +int devm_counter_register(struct device *dev,
> >> +	struct counter_device *const counter)  
> >Where possible align with the opening bracket.
> >checkpatch.pl --strict (but take into account some of the warnings will
> >be silly so don't fix them all).  
> 
> I'll try this out and see how it looks with everything aligned to the
> opening bracket.
> 
> One worry I have is in the case of parameter definitions that are wide
> such as in the counter_attribute_create function, which has two function
> pointers as parameters. In cases like these, aligning to the opening
> brackets would produce very vertical parameter lists.
> 
> Should I mix and match, i.e. align to the opening brackets for some
> functions while permitting others to follow a single tab alignment, or
> would it be better to commit to a single alignment style throughout the
> entire file?

Align what you can sensibly do.   So yes, mixed styles preferred as
there should only be a few cases where they can't be aligned and that
is the standard kernel style.

> 
> [...]
> 
> >> +/**
> >> + * struct count_read_value - Opaque Count read value
> >> + * @buf:	string representation of Count read value
> >> + * @len:	length of string in @buf  
> >I wonder if you are ever going to want to have in kernel consumers.
> >Using strings this early level would make that hard.
> >
> >I'm also unclear on why it makes sense to do so given count
> >is always an integer - Potentially things could get interesting
> >when you are either signed or unsigned and matching the number of
> >bits (s16, u16 or similar).
> >
> >Given this is in kernel interface though, nothing stops you modifying
> >it later if you change your mind about this.  
> 
> Yes, the idea here is to keep it opaque so that the implementation can
> change independently without requiring changes to consuming drivers.
> Although counts right now are integers, there may be drivers in the
> future which require another type such as floating-point, so I want to
> keep it generic enough to support those type of devices in the future
> without causing drastic changes to the existing drivers that depend on
> the Generic Counter API.
> 
> Since the struct count_read_value is opaque, the decision to use strings
> here was for my own convenience since I can pass the buf member directly
> to the relevant attribute show and store functions; this implementation
> can easily change for any future requirements.
> 
> [...]
> 
> >> +enum signal_value_type {
> >> +	SIGNAL_LEVEL = 0  
> >This one surprised me.  Only one option?  
> 
> At present it does seem silly to declare an enum for a single option,
> but I want to keep the paradigm established by enum count_value_type
> consistent with an enum signal_value_type.
> 
> Currently, only the 104-QUAD-8 driver provides a signal_read callback,
> so we only have the SIGNAL_LEVEL type defined to represent a Signal
> low/high state. Since the Generic Counter paradigm is flexible enough to
> represent Signals of various types, I expect future counter driver
> patches to add their signal types as new enum signal_value_type options
> as required. Although, I anticipate SIGNAL_LEVEL serving the majority of
> counter devices just fine; I don't see many devices requiring Signal
> representations other than low/high.

Fair enough.

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
