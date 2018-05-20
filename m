Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbeETPoW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 11:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752536AbeETPn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 11:43:58 -0400
Date: Sun, 20 May 2018 16:31:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: benjamin.gaignard@st.com, fabrice.gasnier@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/9] docs: Add Generic Counter interface
 documentation
Message-ID: <20180520163109.22b11af8@archlinux>
In-Reply-To: <aa4d62315bb11ddc66d0e1a685c81b1721ffe624.1526487615.git.vilhelm.gray@gmail.com>
References: <cover.1526487615.git.vilhelm.gray@gmail.com>
        <aa4d62315bb11ddc66d0e1a685c81b1721ffe624.1526487615.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 13:51:06 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds high-level documentation about the Generic Counter
> interface.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Various comments inline.  I've been doing a lot long reviews recently
(outside of the kernel world) and keep discovering the old rule that
everytime you read a document you'll find something else to
improve :(

Jonathan
> ---
>  Documentation/driver-api/generic-counter.rst | 336 +++++++++++++++++++
>  Documentation/driver-api/index.rst           |   1 +
>  MAINTAINERS                                  |   1 +
>  3 files changed, 338 insertions(+)
>  create mode 100644 Documentation/driver-api/generic-counter.rst
> 
> diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
> new file mode 100644
> index 000000000000..5c6b9c008c06
> --- /dev/null
> +++ b/Documentation/driver-api/generic-counter.rst
> @@ -0,0 +1,336 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================
> +Generic Counter Interface
> +=========================
> +
> +Introduction
> +============
> +
> +Counter devices are prevalent within a diverse spectrum of industries.
> +The ubiquitous presence of these devices necessitates a common interface
> +and standard of interaction and exposure. This driver API attempts to
> +resolve the issue of duplicate code found among existing counter device
> +drivers by introducing a generic counter interface for consumption. The
> +Generic Counter interface enables drivers to support and expose a common
> +set of components and functionality present in counter devices.
> +
> +Theory
> +======
> +
> +Counter devices can vary greatly in design, but regardless of whether
> +some devices are quadrature encoder counters or tally counters, all
> +counter devices consist of a core set of components. This core set of
> +components, shared by all counter devices, is what forms the essence of
> +the Generic Counter interface.
> +
> +There are three core components to a counter:

Enumerate them here.  If people are reading this as a paged document (pdf etc)
then the list of 3 as titles of next few sections may not be clear.

* Count

* Signal

* Synapse 

> +
> +COUNT
> +-----
> +A Count represents the count data for a set of Signals. The Generic
> +Counter interface provides the following available count data types:
> +
> +* COUNT_POSITION_UNSIGNED:
> +  Unsigned integer value representing position.
> +
> +* COUNT_POSITION_SIGNED:
> +  Signed integer value representing position.

Just a thought: As the '0' position is effectively arbitrary is there any
actual difference between signed and unsigned? If we defined all counters
to be unsigned and just offset any signed ones so the range still fitted
would we end up with a simpler interface - there would be no real loss
of meaning that I can see..  I suppose it might not be what people expect
though when they see their counters start at a large positive value...




> +
> +A Count has a count function mode which represents the update behavior
> +for the count data. The Generic Counter interface provides the following
> +available count function modes:
> +
> +* Increase:
> +  Accumulated count is incremented.
> +
> +* Decrease:
> +  Accumulated count is decremented.
> +
> +* Pulse-Direction:
> +  Rising edges on quadrature pair signal A updates the respective count.
> +  The input level of quadrature pair signal B determines direction.
> +
Perhaps group the quadrature modes for the point of view of this document?
Might be slightly easier to read?  

* Quadrature Modes

  - x1 A: etc.

> +* Quadrature x1 A:
> +  If direction is forward, rising edges on quadrature pair signal A
> +  updates the respective count; if the direction is backward, falling
> +  edges on quadrature pair signal A updates the respective count.
> +  Quadrature encoding determines the direction.
> +
> +* Quadrature x1 B:
> +  If direction is forward, rising edges on quadrature pair signal B
> +  updates the respective count; if the direction is backward, falling
> +  edges on quadrature pair signal B updates the respective count.
> +  Quadrature encoding determines the direction.
> +
> +* Quadrature x2 A:
> +  Any state transition on quadrature pair signal A updates the
> +  respective count. Quadrature encoding determines the direction.
> +
> +* Quadrature x2 B:
> +  Any state transition on quadrature pair signal B updates the
> +  respective count. Quadrature encoding determines the direction.
> +
> +* Quadrature x2 Rising:
> +  Rising edges on either quadrature pair signals updates the respective
> +  count. Quadrature encoding determines the direction.

This one I've never met.  Really? There are devices who do this form
of crazy? It gives really uneven counting and I'm failing to see when
it would ever make sense...  References for these odd corner cases
would be good.


__|---|____|-----|____
____|----|____|-----|____

001122222223334444444


> +
> +* Quadrature x2 Falling:
> +  Falling edges on either quadrature pair signals updates the respective
> +  count. Quadrature encoding determines the direction.
> +
> +* Quadrature x4:
> +  Any state transition on either quadrature pair signals updates the
> +  respective count. Quadrature encoding determines the direction.
> +
> +A Count has a set of one or more associated Signals.
> +
> +SIGNAL
> +------
> +A Signal represents a counter input data; this is the input data that is
> +analyzed by the counter to determine the count data; e.g. a quadrature
> +signal output line of a rotary encoder. Not all counter devices provide
> +user access to the Signal data.
> +
> +The Generic Counter interface provides the following available signal
> +data types for when the Signal data is available for user access:
> +
> +* SIGNAL_LEVEL_LOW:
> +  Signal line is in a low state.
> +
> +* SIGNAL_LEVEL_HIGH:
> +  Signal line is in a high state.
> +
> +A Signal may be associated with one or more Counts.
> +
> +SYNAPSE
> +-------
> +A Synapse represents the association of a Signal with a respective
> +Count. Signal data affects respective Count data, and the Synapse
> +represents this relationship.
> +
> +The Synapse action mode specifies the Signal data condition which
> +triggers the respective Count's count function evaluation to update the
> +count data. The Generic Counter interface provides the following
> +available action modes:
> +
> +* None:
> +  Signal does not trigger the count function. In Pulse-Direction count
> +  function mode, this Signal is evaluated as Direction.
> +
> +* Rising Edge:
> +  Low state transitions to high state.
> +
> +* Falling Edge:
> +  High state transitions to low state.
> +
> +* Both Edges:
> +  Any state transition.
> +
> +A counter is defined as a set of input signals associated with count
> +data that are generated by the evaluation of the state of the associated
> +input signals as defined by the respective count functions. Within the
> +context of the Generic Counter interface, a counter consists of Counts
> +each associated with a set of Signals, whose respective Synapse
> +instances represent the count function update conditions for the
> +associated Counts.
> +
> +Paradigm
> +========
> +
> +The most basic counter device may be expressed as a single Count
> +associated with a single Signal via a single Synapse. Take for example
> +a counter device which simply accumulates a count of rising edges on a
> +source input line::
> +
> +                Count                Synapse        Signal
> +                -----                -------        ------
> +        +---------------------+
> +        | Data: Count         |    Rising Edge     ________
> +        | Function: Increase  |  <-------------   / Source \
> +        |                     |                  ____________
> +        +---------------------+
> +
> +In this example, the Signal is a source input line with a pulsing
> +voltage, while the Count is a persistent count value which is repeatedly
> +incremented. The Signal is associated with the respective Count via a
> +Synapse. The increase function is triggered by the Signal data condition
> +specified by the Synapse -- in this case a rising edge condition on the
> +voltage input line. In summary, the counter device existence and
> +behavior is aptly represented by respective Count, Signal, and Synapse
> +components: a rising edge condition triggers an increase function on an
> +accumulating count datum.
> +
> +A counter device is not limited to a single Signal; in fact, in theory
> +many Signals may be associated with even a single Count. For example, a
> +quadrature encoder counter device can keep track of position based on
> +the states of two input lines::
> +
> +                   Count                 Synapse     Signal
> +                   -----                 -------     ------
> +        +-------------------------+
> +        | Data: Position          |    Both Edges     ___
> +        | Function: Quadrature x4 |  <------------   / A \
> +        |                         |                 _______
> +        |                         |
> +        |                         |    Both Edges     ___
> +        |                         |  <------------   / B \
> +        |                         |                 _______
> +        +-------------------------+
> +
> +In this example, two Signals (quadrature encoder lines A and B) are
> +associated with a single Count: a rising or falling edge on either A or
> +B triggers the "Quadrature x4" function which determines the direction
> +of movement and updates the respective position data. The "Quadrature
> +x4" function is likely implemented in the hardware of the quadrature
> +encoder counter device; the Count, Signals, and Synapses simply
> +represent this hardware behavior and functionality.
> +
> +Signals associated with the same Count can have differing Synapse action
> +mode conditions. For example, a quadrature encoder counter device
> +operating in a non-quadrature Pulse-Direction mode could have one input
> +line dedicated for movement and a second input line dedicated for
> +direction::
> +
> +                   Count                   Synapse      Signal
> +                   -----                   -------      ------
> +        +---------------------------+
> +        | Data: Position            |    Rising Edge     ___
> +        | Function: Pulse-Direction |  <-------------   / A \ (Movement)
> +        |                           |                  _______
> +        |                           |
> +        |                           |       None         ___
> +        |                           |  <-------------   / B \ (Direction)
> +        |                           |                  _______
> +        +---------------------------+
> +
> +Only Signal A triggers the "Pulse-Direction" update function, but the
> +instantaneous state of Signal B is still required in order to know the
> +direction so that the position data may be properly updated. Ultimately,
> +both Signals are associated with the same Count via two respective
> +Synapses, but only one Synapse has an active action mode condition which
> +triggers the respective count function while the other is left with a
> +"None" condition action mode to indicate its respective Signal's
> +availability for state evaluation despite its non-triggering mode.
> +
> +Keep in mind that the Signal, Synapse, and Count are abstract
> +representations which do not need to be closely married to their
> +respective physical sources. This allows the user of a counter to
> +divorce themselves from the nuances of physical components (such as
> +whether an input line is differential or single-ended) and instead focus
> +on the core idea of what the data and process represent (e.g. position
> +as interpreted from quadrature encoding data).
> +
> +Userspace Interface
> +===================
> +
> +Several sysfs attributes are generated by the Generic Counter interface,
> +and reside under the /sys/bus/counter/devices/counterX directory, where
> +counterX refers to the respective counter device. Please see
> +Documentation/ABI/testing/sys-bus-counter-generic-sysfs for detailed
> +information on each Generic Counter interface sysfs attribute.
> +
> +Through these sysfs attributes, programs and scripts may interact with
> +the Generic Counter paradigm Counts, Signals, and Synapses of respective
> +counter devices.
> +
> +Driver API
> +==========
> +
> +Driver authors may utilize the Generic Counter interface in their code
> +by including the include/linux/iio/counter.h header file. This header

Didn't this move?

> +file provides several core data structures, function prototypes, and
> +macros for defining a counter device.
> +
> +.. kernel-doc:: include/linux/counter.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/counter/generic-counter.c
> +   :export:
> +
> +Implementation
> +==============
> +
> +To support a counter device, a driver must first allocate the available
> +Counter Signals via counter_signal structures. These Signals should
> +be stored as an array and set to the signals array member of an
> +allocated counter_device structure before the Counter is registered to
> +the system.
> +
> +Counter Counts may be allocated via counter_count structures, and
> +respective Counter Signal associations (Synapses) made via
> +counter_synapse structures. Associated counter_synapse structures are
> +stored as an array and set to the the synapses array member of the
> +respective counter_count structure. These counter_count structures are
> +set to the counts array member of an allocated counter_device structure
> +before the Counter is registered to the system.
> +
> +Driver callbacks should be provided to the counter_device structure via
> +a constant counter_ops structure in order to communicate with the
> +device: to read and write various Signals and Counts, and to set and get
> +the "action mode" and "function mode" for various Synapses and Counts
> +respectively.
> +
> +A defined counter_device structure may be registered to the system by
> +passing it to the counter_register function, and unregistered by passing
> +it to the counter_unregister function. Similarly, the
> +devm_counter_register and devm_counter_unregister functions may be used
> +if device memory-managed registration is desired.
> +
> +Extension sysfs attributes can be created for auxiliary functionality
> +and data by passing in defined counter_device_ext, counter_count_ext,
> +and counter_signal_ext structures. In these cases, the
> +counter_device_ext structure is used for global configuration of the
> +respective Counter device, while the counter_count_ext and
> +counter_signal_ext structures allow for auxiliary exposure and
> +configuration of a specific Count or Signal respectively.
> +
> +Architecture
> +============
> +
> +When the Generic Counter interface counter module is loaded, the
> +counter_init function is called which registers a bus_type named
> +"counter" to the system. Subsequently, when the module is unloaded, the
> +counter_exit function is called which unregisters the bus_type named
> +"counter" from the system.
> +
> +Counter devices are registered to the system via the counter_register
> +function, and later removed via the counter_unregister function. The
> +counter_register function establishes a unique ID for the Counter
> +device and creates a respective sysfs directory, where X is the
> +mentioned unique ID:
> +
> +    /sys/bus/counter/devices/counterX
> +
> +Sysfs attributes are created within the counterX directory to expose
> +functionality, configurations, and data relating to the Counts, Signals,
> +and Synapses of the Counter device, as well as options and information
> +for the Counter device itself.
> +
> +Each Signal has a directory created to house its relevant sysfs
> +attributes, where Y is the unique ID of the respective Signal:
> +
> +    /sys/bus/counter/devices/counterX/signalY
> +
> +Similarly, each Count has a directory created to house its relevant
> +sysfs attributes, where Y is the unique ID of the respective Count:
> +
> +    /sys/bus/counter/devices/counterX/countY
> +
> +For a more detailed breakdown of the available Generic Counter interface
> +sysfs attributes, please refer to the
> +Documentation/ABI/testing/sys-bus-counter file.
> +
> +The Signals and Counts associated with the Counter device are registered
> +to the system as well by the counter_register function. The
> +signal_read/signal_write driver callbacks are associated with their
> +respective Signal attributes, while the count_read/count_write and
> +function_get/function_set driver callbacks are associated with their
> +respective Count attributes; similarly, the same is true for the
> +action_get/action_set driver callbacks and their respective Synapse
> +attributes. If a driver callback is left undefined, then the respective
> +read/write permission is left disabled for the relevant attributes.
> +
> +Similarly, extension sysfs attributes are created for the defined
> +counter_device_ext, counter_count_ext, and counter_signal_ext
> +structures that are passed in.
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index 6d8352c0f354..5fd747c4f2ce 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -25,6 +25,7 @@ available subsections can be seen below.
>     frame-buffer
>     regulator
>     iio/index
> +   generic-counter
>     input
>     usb/index
>     pci
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1413e3eb49e5..7a01aa63fb33 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3674,6 +3674,7 @@ M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-counter*
> +F:	Documentation/driver-api/generic-counter.rst
>  F:	drivers/counter/
>  F:	include/linux/counter.h
>  
