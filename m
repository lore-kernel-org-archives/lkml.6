Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeBWNOy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:14:54 -0500
Received: from mail-yb0-f179.google.com ([209.85.213.179]:44174 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeBWNOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:14:52 -0500
X-Google-Smtp-Source: AG47ELvIAtT73GdqH1W0PA1KYybQUmKJuyJT/fxQmK+4fjJ0T0AUrZjUbMWXtYTtn/qJkUueU70CvQ==
Date: Fri, 23 Feb 2018 08:14:42 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v4 00/11] Introduce the Counter subsystem
Message-ID: <20180223131442.GA19039@sophia>
References: <cover.1513266127.git.vilhelm.gray@gmail.com>
 <20180101111630.7201e743@archlinux>
 <20180101130427.644b7a9d@archlinux>
 <CA+M3ks7QfOB4uNKF5FS7mESV-uT8oTziLJwU+XLbOb5Bqc_ynA@mail.gmail.com>
 <CA+M3ks4-dQ0tokrJza_j1fA_coxebnwMVyCjF1-ascE_fhrg8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+M3ks4-dQ0tokrJza_j1fA_coxebnwMVyCjF1-ascE_fhrg8Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 01:58:36PM +0100, Benjamin Gaignard wrote:
>2018-01-15 10:02 GMT+01:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>:
>> 2018-01-01 14:04 GMT+01:00 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>:
>>> On Mon, 1 Jan 2018 11:16:30 +0000
>>> Jonathan Cameron <jic23@kernel.org> wrote:
>>>
>>> Sorry to top post but I just want to add some general comments across
>>> the whole series.
>>>
>>> 1) Basics look good to me.  It all fits together well.
>>> 2) I'm concerned about the two 'simplified interfaces' for a couple of reasons:
>>> a) They add a lot of code and I'm not convinced the simplifications justify that.
>>> b) They aren't as generically applicable as we might want. For example, it's
>>> common for SoC Encoder blocks to operative in both the simple counter mode and
>>> the quadrature counter mode.  To support that we have (I think) to go back to
>>> basics and do it ourselves from the generic counter interface.  The TI eQEP
>>> IP does these modes for example.
>>>
>>> So these simplifications serve two purposes (I think)
>>> 1) To enforce interface.  This is nice (and I did some similar stuff in IIO
>>>    for the same reason) but there is so much flexibility in the rest of the
>>>    interface (from a code point of view) that I'm unsure this is significant.
>>> 2) To save on boiler plate.  I'm not sure we save that much and that it couldn't
>>>    mostly be achieved by providing some useful utility functions and
>>>    standard enums / string arrays for the common cases.
>>>
>>> We have to justify a couple of thousand lines of core code.  To do that we
>>> need to be saving a reasonably multiple more than that in driver code.
>>>
>>> The full setup for a generic_counter is not so complex that we need this
>>> stuff.  Your examples make it all pretty clear what is going on and a
>>> couple of clean well commented drivers to act as a baseline for new
>>> implementations would get us much of the rest of the way.
>>>
>>> So going well, but this aspect needs some more consideration.
>>>
>>> I also think we need at least rough outlines of a few more drivers
>>> in here to convince people that there aren't any problems that this
>>> is too inflexible to cover.  Hopefully an ST one will be forthcoming.
>>> If not we can do the exercise off datasheets.
>>>
>>
>> Sorry for the long delay before answering to thread.
>> I have succesfully implement and test a quadrature encoder driver
>> on stm32 timer part. Some clean up are need but the basic functions
>> like setting the two supported modes (quadX2 or quadX4) supported by
>> my hardware, counting, preset and direction are functional.
>>
>> I have used the "simplified interface" so my driver is quite simple with
>> only few functions to implement (~300 lines of code).
>> When this series will be upstream we can convert stm32 drivers to use it.
>>
>> Thanks a lot for this work.
>> Benjamin
>
>Any news about those patches ?
>
>Regards,
>Benjamin

Hi Benjamin,

Sorry for going dark all this time, I'm still incorporating the changes
suggested by Jonathan in his review. The biggest change will likely be a
reimplementation of the "simple" and "quadrature" API as macros
leveraging the "generic" API in order to reduce a lot of redundant code
under the hood.

I think I might be comfortable releasing the next revision of the
patchset on March 3 or 4, so keep an eye out for it then. :)

William Breathitt Gray

>
>>
>>> Jonathan
>>>
>>>> On Thu, 14 Dec 2017 15:50:29 -0500
>>>> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>>>>
>>>> > Introduction
>>>> > ============
>>>> >
>>>> > Apologies for going silent these past couple months just to return with
>>>> > a patchset over 3000 lines larger than the last -- I should have been
>>>> > releasing intermediate versions along the way so shame on me!
>>>>
>>>> :) Sometimes it's better to wait until you are moderately happy with it
>>>> yourself!
>>>>
>>>> > The
>>>> > Counter system has effectively been rewritten anew, so I believe very
>>>> > little of the code in the previous versions of this patchset remain.
>>>> > However, the Generic Counter paradigm has pretty much remained the same
>>>> > so the theory should be familar. Regardless, I realize I'm dropping off
>>>> > this patchset near the winter holidays so I don't expect a review until
>>>> > well into January -- I'm just releasing this now before I myself head
>>>> > off on an end of year sabbatical.
>>>>
>>>> It's at least a few hours into January so here goes before life gets
>>>> properly busy again.
>>>>
>>>> >
>>>> > The most significant difference between this version and the previous,
>>>> > as well as part of the reason for the implementation code changes, is
>>>> > the complete separation of the Generic Counter system from IIO. I
>>>> > decided it was improper to build the Generic Counter system on top of
>>>> > IIO core: it was leading to ugly code, convulted hacks, and forced
>>>> > restrictions on the Generic Counter interface in order to appease the
>>>> > architecture of the IIO system. Most importantly, the IIO core code that
>>>> > was leveraged by the Generic Counter was so minor (essentially just the
>>>> > sysfs attribute support) that it did not justify the extensive
>>>> > hoop-jumping performed to make the code work.
>>>> >
>>>> > So this patchset introduces the Generic Counter interface without the
>>>> > dependence on IIO code. This now gives the Generic Counter system the
>>>> > freedom to aptly represent counter devices without implementation
>>>> > compatibility concerns regarding other high-level subsystems.
>>>> >
>>>> > This also makes sense ontologically I believe because whereas the IIO
>>>> > system appears more focused on representing the industrial I/O of a
>>>> > device and their configuration directly, the Generic Counter system is
>>>> > more concerned with the abstract representation of that counter device
>>>> > and the relationships and configurations within which define its
>>>> > operation at a high-level; a counter driver could in theory separately
>>>> > support both the high-level Generic Counter representation of the device
>>>> > as a whole (what are we counting conceptually, how much are we counting,
>>>> > etc.), as well as the low-level IIO representation of the individual
>>>> > inputs and outputs on that device (are the signals differential, do
>>>> > certain signals have current requirements, etc.).
>>>>
>>>> I think there are concepts that over time may blur the lines more
>>>> but agree with the basic point. I'm just planning to nick all your
>>>> good ideas if they will improve IIO in turn.
>>>>
>>>> >
>>>> > Overview
>>>> > ========
>>>> >
>>>> > This patchset may be divided into three main groups:
>>>> >
>>>> >         * Generic Counter
>>>> >         * Simple Counter
>>>> >         * Quadrature Counter
>>>> >
>>>> > Each group begins with a patch introducing the implementation of the
>>>> > interface system, followed afterwards by documentation patches. I
>>>> > recommend reading through the documentation patches first to familiarize
>>>> > your with the interface itself before jumping into the source code for
>>>> > the implementation.
>>>> >
>>>> > The Simple Counter and Quadrature Counter groups also have example
>>>> > driver code in the dummy-counter and 104-quad-8 patches respectively.
>>>> > The Simple Counter and Quadrature Counter systems themselves being
>>>> > subclasses of the Generic Counter may serve as example driver code for
>>>> > the Generic Counter interface -- though I may end up adding an explicit
>>>> > Generic Counter example in a later patch to the dummy-counter for easier
>>>> > reference.
>>>> >
>>>> > Since the Generic Counter system no longer depends on IIO, I moved all
>>>> > Counter related source code to the drivers/iio/counter/ directory to
>>>> > keep everything contained together. In addition, with the IIO Kconfig
>>>> > dependency removed, the COUNTER menu appear now appears at the same
>>>> > level as the IIO menu:
>>>> >
>>>> >         -> Device drivers
>>>> >           -> Counter Support (COUNTER [=m])
>>>> >
>>>> > I'm not sure if I should move driver/iio/counter/ to driver/counter/ in
>>>> > order to match the Kconfig heirarchy or to keep it where it is to match
>>>> > the legacy IIO counter location established when we first added the
>>>> > 104-QUAD-8 driver.
>>>>
>>>> I would move it out entirely - otherwise things are just confusing.
>>>> You 'could' sit it in IIO (as in put it under the top level menu option)
>>>> if you would prefer but I don't thing that really makes sense.
>>>>
>>>> >
>>>> > Paradigm updates
>>>> > ================
>>>> >
>>>> > The Generic Counter paradigm has essentially remained the same from the
>>>> > previous patch, but I have made some minor updates. In particular, I've
>>>> > finally settled on a naming convention for the core components of a
>>>> > Counter:
>>>> >
>>>> >         COUNT
>>>> >         -----
>>>> >         A Count represents the count data for a set of Signals. A Count
>>>> >         has a count function mode (e.g. "increase" or "quadrature x4")
>>>> >         which represents the update behavior for the count data. A Count
>>>> >     also has a set of one or more associated Signals.
>>>> >
>>>> > This component was called "Value" in the previous patches. I believe
>>>> > "Count" is a more direct name for this data, and it also matches how
>>>> > datasheets and people commonly refer to this information in
>>>> > documentation.
>>>>
>>>> Agreed - better name.
>>>>
>>>> >
>>>> >         SIGNAL
>>>> >         ------
>>>> >         A Signal represents a counter input data; this is the data that
>>>> >         is typically analyzed by the counter to determine the count
>>>> >         data. A Signal may be associated to one or more Counts.
>>>> >
>>>> > The naming for this component has not changed since the previous
>>>> > patches. I believe "Signal" is a fitting enough name for the input
>>>> > data, as well as matching the common nomenclature for existing counter
>>>> > devices.
>>>> >
>>>> >         SYNAPSE
>>>> >         -------
>>>> >         A Synapse represents the association of a Signal with a
>>>> >         respective Count. Signal data affects respective Count data, and
>>>> >         the Synapse represents this relationship. The Synapse action
>>>> >         mode (e.g. "rising edge" or "double pulse") specifies the Signal
>>>> >         data condition which triggers the respective Count's count
>>>> >         function evaluation to update the count data. It is possible for
>>>> >         the Synapse action mode to be "none" if a Signal is associated
>>>> >         with a Count but does not trigger the count function (e.g. the
>>>> >         direction signal line for a Pulse-Direction encoding counter).
>>>> >
>>>> > This component was called "Trigger" in the previous patches. I do not
>>>> > believe "Trigger" was a good name for two main reasons: it could easily
>>>> > be confused for the existing IIO trigger concept, and most importantly
>>>> > it does not convey the connection association aspect of the
>>>> > Count-Signal relationship.
>>>>
>>>> An alternative here would be to use MAP as a number of similar
>>>> 'connection' type arrangements in the kernel do. It doesn't really
>>>> imply the 'how' element though so perhaps a new term is indeed better.
>>>>
>>>>
>>>> >
>>>> > I settled on the "Synapse" name both due to etymology -- from Greek
>>>> > _sunapsis_ meaning "conjunction" -- as well as a biological analogy:
>>>> > just as neurons connect and fire communication over synapses, so does a
>>>> > Counter Signal connect and fire communication to a Counter Count over a
>>>> > Counter Synapse.
>>>> >
>>>> > Following the same naming convention and analogy, what was previously
>>>> > called trigger_mode is now known as action_mode, named in reference to
>>>> > action potential -- the condition in a neuron which triggers a fire
>>>> > communication over a synapse, just as a Counter Signal condition
>>>> > specified in the action_mode of a Counter Synapse triggers the count
>>>> > function evaluation for a Counter Count.
>>>> >
>>>> > Counter classes descriptions
>>>> > ============================
>>>> >
>>>> > The Generic Counter interface is the most general interface for
>>>> > supporting counter devices; if it qualifies as a Counter, then it can be
>>>> > represented by the Generic Counter interface. Unfortunately, the
>>>> > flexibility of the interface does result in a more cumbersome
>>>> > integration for driver authors: much of the components must be manually
>>>> > configured by the author, which can be a tedious task for large and
>>>> > complex counter devices.
>>>> >
>>>> > To this end, two subclasses of the Generic Counter interface as
>>>> > introduced in this patchset: the Simple Counter interface, and the
>>>> > Quadrature Counter interface. Both of these interfaces inherit the
>>>> > Generic Counter paradigm, and may be seen as extensions to the interface
>>>> > which restrict the components to a respective specific class of counter
>>>> > devices in order to provide a more apt interface for such devices.
>>>> >
>>>> >         Simple Counter
>>>> >         --------------
>>>> >         Simple Counters are devices that count edge pulses on an input
>>>> >         line (e.g. tally counters).
>>>> >
>>>> >         Since the relationship between Signals and Counts is known to be
>>>> >         one-to-one, a simple_counter_count structure already contains
>>>> >         the associated Signal member for the respective Count. A driver
>>>> >         author no longer needs to worry about allocating a separate
>>>> >         Signal and Synapse, nor about configuring the association
>>>> >         between the respective Count and Signal; the Simple Counter
>>>> >         interface abstracts away such details.
>>>> >
>>>> >         Furthermore, since the device type is known, component
>>>> >         properties may be further defined and restricted: Count data is
>>>> >         a signed integer, Signal data "low" and "high" state is set via
>>>> >         enumeration constants, and so are count function and action mode
>>>> >         restricted to well-defined "increase"/"decrease" and
>>>> >         "none"/"rising edge"/"falling edge"/"both edges" enumeration
>>>> >         constants respectively.
>>>>
>>>> I do wonder a little on whether this is too restrictive to actually
>>>> represent many devices.
>>>> >
>>>> >         Quadrature Counter
>>>> >         ------------------
>>>> >         Quadrature Counters are devices that track position based on
>>>> >         quadrature pair signals (e.g. rotary encoder counters).
>>>> >
>>>> >         Since the relationship between Signals and Counts is known to be
>>>> >         a quadrature pair of Signals to each Count, a quad_counter_count
>>>> >         structure already contains the associated Signal members for the
>>>> >         respective Count. A driver author no longer needs to worry about
>>>> >         allocating separate Signals and Synapses for each quadrature
>>>> >         pair, nor about configuring the association between the
>>>> >         respective Count and Signals; the Quadrature Counter interface
>>>> >         abstracts away such details.
>>>> >
>>>> >         Furthermore, since the device type is known, component
>>>> >         properties may be further defined and restricted: Count data is
>>>> >         a signed integer, Signal data "low" and "high" state is set via
>>>> >         enumeration constants, and so is count function mode restricted
>>>> >         to well-defined enumeration constants to represent modes such as
>>>> >         "pulse-direction" and "quadrature x4" for example.
>>>>
>>>> Pulse direction is definitely not a quadrature counter...  Maybe this needs
>>>> a rename to dual-signal-counter or similar?
>>>>
>>>> Another classic case here would be increment / decrement counters where
>>>> a signal is used for each operation (counting items between two light gates
>>>> - used a lot in tracking products in the production industry).
>>>>
>>>> >
>>>> > Note how driver authors no longer need to interact with Synapses
>>>> > directly when utilizing the Simple Counter and Quadrature Counter
>>>> > interfaces. This should make it easier too for authors to add support
>>>> > since they don't need to fully understand the underlying Counter
>>>> > paradigm in order to take advantage of the interfaces -- just define the
>>>> > Counts and Signals, and they're ready to go.
>>>> >
>>>> > Even more so, the Quadrature Counter interface takes it a step further
>>>> > and doesn't require action_modes to be explicitly set -- rather they are
>>>> > implicitly determined internally by the system based on the direction
>>>> > and function mode. Abstractions like these should make the Counter
>>>> > interface system as a whole robust enough to handle the diverse classes
>>>> > of counter devices out in the real world.
>>>> >
>>>> > Compilation warnings
>>>> > ====================
>>>> >
>>>> > There are three main compilation warnings which pop for this patchset.
>>>> > I've inspected these warnings and none are errors, however they do
>>>> > require some explanation.
>>>> >
>>>> >         * 104-quad-8: warning: enumeration value
>>>> >                 ‘QUAD_COUNTER_FUNCTION_PULSE_DIRECTION’ not handled in
>>>> >                 switch
>>>> >
>>>> > The first warning is rather simple to explain: the
>>>> > QUAD_COUNTER_FUNCTION_PULSE_DIRECTION state is handled by the parent if
>>>> > statement's else condition, so an explicit case condition is not
>>>> > necessary. I can add a default case line to pacify the compiler, but
>>>> > since it would be empty the effort seems frivolous.
>>>>
>>>> Do it anyway and put a comment of /* Should not get here */
>>>>
>>>> Suppressing false warnings is useful from a code maintenance point of view.
>>>>
>>>> > In some sense as
>>>> > well, a default case may make the switch logic less clear by implying
>>>> > the possibility of additional cases which are not possible in the
>>>> > context of that code path.
>>>> >
>>>> >         * simple-counter: warning: assignment discards ‘const’ qualifier
>>>> >                 from pointer target type
>>>> >         * quad-counter: warning: assignment discards ‘const’ qualifier
>>>> >                 from pointer target type
>>>> >
>>>> > The second warning comes from the mapping of
>>>> > simple_counter_device_ext/quad_counter_device_ext,
>>>> > simple_counter_count_ext/quad_counter_count_ext, and
>>>> > simple_counter_signal_ext/quad_counter_signal_ext to the internal
>>>> > Counter counter_device_ext, counter_count_ext, and counter_signal_ext
>>>> > structures respectively.
>>>> >
>>>> > The priv member of the counter_device_ext, counter_count_ext, or
>>>> > counter_signal_ext is leveraged to pass the respective
>>>> > simple_counter_device_ext/quad_counter_device_ext,
>>>> > simple_counter_count_ext/quad_counter_count_ext, or
>>>> > simple_counter_signal_ext/quad_counter_signal_ext structure to their
>>>> > respective read/write callback. The priv member is generic on purpose to
>>>> > allow any desired data to be passed; the supplied read/write callbacks
>>>> > should know the datatype of the passed-in priv argument so they cast it
>>>> > appropriately to access their expected data.
>>>> >
>>>> > As such, the 'const' qualifier of the structures are thus discarded but
>>>> > subsequently cast back when the respective registered callback functions
>>>> > are called. Since this is the intended use case of the priv member -- to
>>>> > generically pass driver data for later recast -- I don't believe this
>>>> > warning needs to be rectified.
>>>>
>>>> All warnings need to be rectified.  Sorry but this noise will do two things:
>>>> 1) Get you a patch every few weeks from someone fixing it.
>>>> 2) Potentially make real warnings harder to see.
>>>>
>>>> Sometimes we have to play games to work around them, but such is life.
>>>>
>>>> >
>>>> >         * generic-counter: warning: passing argument 5 of
>>>> >                 ‘counter_attribute_create’ discards ‘const’ qualifier
>>>> >                 from pointer target type
>>>> >         * generic-counter: warning: passing argument 6 of
>>>> >                 ‘counter_attribute_create’ discards ‘const’ qualifier
>>>> >                 from pointer target type
>>>> >
>>>> > The third warnings comes from a similar situation to the second warning:
>>>> > a 'const' argument is passed generically via 'void *' for later recast.
>>>> > In this cast, I decided to create a generic function called
>>>> > counter_attribute_create in order to simplify the sysfs attribute
>>>> > registration code in the generic-counter.c file.
>>>> >
>>>> > The counter_attribute_create function takes in read and write callbacks,
>>>> > as well as two optional generic data arguments to be stored as 'void *'
>>>> > (the component and component_data parameters). Using this setup allows
>>>> > the counter_attribute_create function to be the sole function necessary
>>>> > to create a desired Generic Counter sysfs attribute: read and write
>>>> > callbacks are passed along with relevant Counter component and data
>>>> > generically, which can be cast back later inside those read and write
>>>> > functions to match the expected datatype.
>>>> >
>>>> > Using a generic counter_attribute_create function reduces duplicate
>>>> > code, but it does result in many superfluous compilation warnings. I can
>>>> > define new attribute_create functions specific to each type of sysfs
>>>> > attribute in order to pacify the warnings, but that seems to be such a
>>>> > waste to increase the amount of code with duplications that are
>>>> > unnecessary. What would you recommend; should I attempt to pacify these
>>>> > warnings or leave them be?
>>>>
>>>> You must fix them I'm afraid.
>>>>
>>>> >
>>>> > Known TODO items
>>>> > ================
>>>> >
>>>> > Although I've added the interface documentation files with rst file
>>>> > extensions, I still need to familiarize myself with Sphinx markup
>>>> > constructs to take advantage of the language. For example, I've copied
>>>> > verbatim several structure definitions into the documentation directly,
>>>> > but I believe this would be better left dynamically generated by using
>>>> > the relevant markup syntax. I'll try to clean up the documentation then
>>>> > once I've brushed up on Sphinx.
>>>> >
>>>> > As noted in a previous patchset version, the signal_write callback
>>>> > should be removed from the interface; there are few if any cases where
>>>> > it makese sense to have a signal_write callback since Signals are
>>>> > always considered inputs in the context of the Counter paradigm.
>>>> >
>>>> > I've retained the signal_write callback in this version since I'm unsure
>>>> > how to implement the dummy-counter Signal source. Benjamin Gaignard
>>>> > suggested implementing dummy-counter as a gpio-counter which could use
>>>> > gpio to provide a software quadratic counter. Is this the path I should
>>>> > take?
>>>>
>>>> It would certainly work well and be simple enough for easy understanding.
>>>> Also, it might be a useful driver in it's own right.
>>>>
>>>> >
>>>> > Furthermore, the dummy-counter driver defines its own single
>>>> > platform_device which restricts it to loading only a single instance.
>>>> > I can fix this to allow multiple instances in the next patchset version
>>>> > -- as suggested, I'll check out industrialio-sw-device.c for reference.
>>>> >
>>>> > Right now the dummy-counter driver only has example code for the Simple
>>>> > Counter interface. It may be prudent to add example code for the Generic
>>>> > Counter and Quadrature Counter interfaces too. I think dummy-counter
>>>> > should serve as the reference driver implementation for all the Counter
>>>> > interfaces, so that driver authors have an example of how to integrate
>>>> > the particular interface they desire.
>>>>
>>>> Such a driver is useful, but it doesn't add much if you have another,
>>>> only slightly more complex real driver that also does the job.
>>>> Perhaps do them all as gpio based drivers for example?
>>>> >
>>>> > Finally, I only added very basic support for the Quadrature Counter
>>>> > interface in the 104-QUAD-8 driver. It's possible to support all
>>>> > existing IIO Counter sysfs attributes in the 104-QUAD-8 driver via
>>>> > corresponding quad_counter_device_ext, quad_counter_count_ext, and
>>>> > quad_counter_signal_ext structures, such that only the
>>>> > /sys/bus/counter/devices/counterX/ directory needs to be accessed to
>>>> > interact with the 104-QUAD-8 device. I'll try to add support for those
>>>> > remaining sysfs attributes in the next patchset version.
>>>> >
>>>> > If I missed anything from the last patchset version review just remind
>>>> > me again and I'll add it to my TODO list. ;)
>>>>
>>>> You are seriously optimistic if you think we can remember!
>>>>
>>>> Jonathan
>>>>
>>>> >
>>>> > William Breathitt Gray (11):
>>>> >   iio: Introduce the Generic Counter interface
>>>> >   counter: Documentation: Add Generic Counter sysfs documentation
>>>> >   docs: Add Generic Counter interface documentation
>>>> >   counter: Introduce the Simple Counter interface
>>>> >   counter: Documentation: Add Simple Counter sysfs documentation
>>>> >   docs: Add Simple Counter interface documentation
>>>> >   counter: Add dummy counter driver
>>>> >   counter: Introduce the Quadrature Counter interface
>>>> >   counter: Documentation: Add Quadrature Counter sysfs documentation
>>>> >   docs: Add Quadrature Counter interface documentation
>>>> >   counter: 104-quad-8: Add Quadrature Counter interface support
>>>> >
>>>> >  .../ABI/testing/sysfs-bus-counter-generic-sysfs    |  73 ++
>>>> >  .../ABI/testing/sysfs-bus-counter-quadrature-sysfs |  76 ++
>>>> >  .../ABI/testing/sysfs-bus-counter-simple-sysfs     |  61 ++
>>>> >  Documentation/driver-api/iio/generic-counter.rst   | 434 +++++++++
>>>> >  Documentation/driver-api/iio/index.rst             |   3 +
>>>> >  Documentation/driver-api/iio/quad-counter.rst      | 444 +++++++++
>>>> >  Documentation/driver-api/iio/simple-counter.rst    | 393 ++++++++
>>>> >  MAINTAINERS                                        |   9 +
>>>> >  drivers/iio/Kconfig                                |   3 +-
>>>> >  drivers/iio/counter/104-quad-8.c                   | 257 +++++-
>>>> >  drivers/iio/counter/Kconfig                        |  35 +-
>>>> >  drivers/iio/counter/Makefile                       |   6 +
>>>> >  drivers/iio/counter/dummy-counter.c                | 308 +++++++
>>>> >  drivers/iio/counter/generic-counter.c              | 992 +++++++++++++++++++++
>>>> >  drivers/iio/counter/quad-counter.c                 | 774 ++++++++++++++++
>>>> >  drivers/iio/counter/simple-counter.c               | 734 +++++++++++++++
>>>> >  include/linux/iio/counter.h                        | 629 +++++++++++++
>>>> >  17 files changed, 5216 insertions(+), 15 deletions(-)
>>>> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-generic-sysfs
>>>> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-quadrature-sysfs
>>>> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-simple-sysfs
>>>> >  create mode 100644 Documentation/driver-api/iio/generic-counter.rst
>>>> >  create mode 100644 Documentation/driver-api/iio/quad-counter.rst
>>>> >  create mode 100644 Documentation/driver-api/iio/simple-counter.rst
>>>> >  create mode 100644 drivers/iio/counter/dummy-counter.c
>>>> >  create mode 100644 drivers/iio/counter/generic-counter.c
>>>> >  create mode 100644 drivers/iio/counter/quad-counter.c
>>>> >  create mode 100644 drivers/iio/counter/simple-counter.c
>>>> >  create mode 100644 include/linux/iio/counter.h
>>>> >
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
