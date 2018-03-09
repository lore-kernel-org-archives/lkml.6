Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeCISmX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:42:23 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:37522 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeCISmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:42:19 -0500
X-Google-Smtp-Source: AG47ELtf0jFuRcvPKt8EezHHC4qhMcJ1F8F6y+Q7Ea7/VkNEfkaO9QkFVZ3KKX5sWGGCRFJHx5TeUA==
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc: benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 0/8] Introduce the Counter subsystem
Date: Fri,  9 Mar 2018 13:41:52 -0500
Message-Id: <cover.1520614431.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:
  - Organize counter subsystem to its own drivers/counter/ directory
  - Remove Simple Counter and Quadrature Counter interfaces
  - Remove simple_write callback from Generic Counter interface
  - Refactor documentation to utilize Sphinx for code inclusion
  - Remove dummy-counter driver
  - Remove unnecessary character device
  - Enforce interface via opaque callback value types and functions
  - Add ENUM macros for Signal, Count, and device extensions
  - Resolve const qualifier discard warnings by utilizing containers
  - Remove "synapses" attribute
  - Reorganize Signal and Count attributes to respective subdirectories
  - Append "_list" suffix to the "actions" and "functions" symbols
  - Reimplement all 104-QUAD-8 extension attributes
  - Add STM32 Timer quadrature encoder driver

Overview
========

This version of the patchset has been primarily a simplification and
stablization effort. As was brought up in review of the previous
release, the Simple Counter and Quadrature Counter interfaces added a
lot of complexity for little benefit to the ABI. I decided keeping it
simple is a good approach for an interface, as it should keep the system
code easier to maintainer while still allowing consumers the flexibility
to utilize the interface to their requirements.

Opaque structures
=================

I still believe it is important to maintain some control over the
expected data types accessed by the Generic Counter interface so I have
introduced three opaque structures to represent Signal and Count values:

	* struct signal_read_value
	* struct count_read_value
	* struct count_write_value

As their names imply, these three opaque structs representing the Signal
read value, Count read value, and Count write value. Drivers should not
interact with these opaque structures directly, but rather utilize the
following functions respectively:

	* set_signal_read_value
	* set_count_read_value
	* get_count_write_value

These functions respectively take a "type" parameter which specifies the
the data type the driver expects. For Count values, the following two
types are introduced in this patchset:

	* COUNT_POSITION_UNSIGNED:
		Position represented as an unsigned integer
	* COUNT_POSITION_SIGNED:
		Position represented as a signed integer

Similarly, Signal values may be represented by the following type
introduced in this patchset:

	* SIGNAL_LEVEL:
		Input signal level represented by two discrete states:
		low (SIGNAL_LEVEL_LOW) or high (SIGNAL_LEVEL_HIGH)

I expect new types to be introduced as future counter drivers are
merged, thus allowing the interface to grow in a controlled fashion.

Helper macros
=============

This patchset introduces the following six helper macros for defining
extension attributes:

	* COUNTER_SIGNAL_ENUM
	* COUNTER_SIGNAL_ENUM_AVAILABLE
	* COUNTER_COUNT_ENUM
	* COUNTER_COUNT_ENUM_AVAILABLE
	* COUNTER_DEVICE_ENUM
	* COUNTER_DEVICE_ENUM_AVAILABLE

These macros were based off of the IIO_ENUM and IIO_ENUM_AVAILABLE
macros and fulfill a similar function for the Generic Counter interface:
simplify boilerplate code for enum Signal, Count, or global counter
device extension attributes.

Compiler warnings resolution
============================

In the previous revision of this patchset, several const qualifier
discard warnings were displayed due to the generic use of the
counter_attribute_create function to map a struct counter_device_attr
to an attribute callback. The essential issue was passing a Signal,
Count, or extension's component data (which may be const) via the void
pointer provided in struct counter_device_attr.

To resolve this issue, I implemented containers for each distinct type
of attribute. The respective container is allocated for the attribute,
populated with the relevant data, and then passed via the existing
struct counter_device_attr code. This method allows the container to
maintain the necessary const qualifier for the component data, while
still permitting the generic behavior of counter_attribute_create.

The containers are purely a system implementation detail, so they are
not exposed outside of generic-counter.c file, but I'll list them here
for reference:

	* struct signal_comp_t
	* struct name_comp_t
	* struct signal_ext_comp_t
	* struct action_comp_t
	* struct action_avail_comp_t
	* struct count_comp_t
	* struct count_ext_comp_t
	* struct funct_avail_comp_t
	* struct ext_comp_t

Signal and Count subdirectories
===============================

The Signal and Count attributes are now organized within respective
subdirectories. A subdirectory is created and populated for each Signal
in the following format, where X is the unqiue ID of the counter device
and Y is the unique ID of the respective Signal:

    /sys/bus/counter/devices/counterX/signalY

Similarly, each Count has a subdirectory created to house its relevant
sysfs attributes, where Y is the unique ID of the respective Count:

    /sys/bus/counter/devices/counterX/countY

In addition, I have removed the "countY_synapses" attribute because it
did not conform to the sysfs rule of one attribute one thing. I believe
this would be better implemented inside the respective Count's
subdirectory as a further "synapses" subdirectory with links within to
the respective Signal subdirectories. However, I'm not quite sure how to
implement this yet; struct attribute_group appears to allow only one
level of subdirectories, so to support two or more would require another
approach that I will need to research.

Something to consider if we do implement "synapses" subdirectories is
whether it is convenient to place the "action" and "action_available"
attributes within to keep synapse information together.

STM32 timer quadrature encoder driver
=====================================

Benjamin Gaignard is providing a counter driver in patchset for the
STM32 timer quadrature encoder. The driver makes use of the Generic
Counter interface and its simplicity conveniently serves as a further
reference example for future authors.

Now that the 104-QUAD-8 driver has all extension attributes
reimplemented to utilize the Generic Counter interface, I decided to
drop the dummer-counter in favor of providing drivers for real devices
to serve as example -- this gives up the benefit of supporting real
devices to make sure the interface is robust and adequately useful.

Although not included with this patchset, the stm32-lptimer-cnt.c file
can also be updated with Generic Counter interface support. Supporting
more devices to see what is needed or lacking should help the Generic
Counter interface evolve.

Merge conflict warning
======================

Changes in the ISA_BUS_API Kconfig option are expected for the 4.17
merge, and I expect a subsequent merge conflict to pop up regarding the
104_QUAD_8 Kconfig option. In particular the following patch has been
picked up in the gpio subsystem tree for merge during the 4.17 window:
https://patchwork.ozlabs.org/patch/853987/

To resolve this conflict, the 104_QUAD_8 Kconfig option simply needs to
select ISA_BUS_API rather than depend on it.

William Breathitt Gray

Benjamin Gaignard (3):
  dt-bindings: counter: Document stm32 quadrature encoder
  counter: stm32-timer-cnt: Add sysfs documentation
  Counter: Add STM32 Timer quadrature encoder

William Breathitt Gray (5):
  counter: Introduce the Generic Counter interface
  counter: Documentation: Add Generic Counter sysfs documentation
  docs: Add Generic Counter interface documentation
  counter: 104-quad-8: Add Generic Counter interface support
  counter: 104-quad-8: Documentation: Add Generic Counter sysfs
    documentation

 Documentation/ABI/testing/sysfs-bus-counter        |  120 ++
 .../ABI/testing/sysfs-bus-counter-104-quad-8       |  115 ++
 .../ABI/testing/sysfs-bus-counter-stm32-timer-cnt  |   21 +
 .../bindings/counter/stm32-timer-cnt.txt           |   26 +
 .../devicetree/bindings/mfd/stm32-timers.txt       |    7 +
 Documentation/driver-api/generic-counter.rst       |  321 +++++
 Documentation/driver-api/index.rst                 |    1 +
 MAINTAINERS                                        |   14 +-
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/counter/104-quad-8.c                       | 1261 +++++++++++++++++
 drivers/counter/Kconfig                            |   58 +
 drivers/{iio => }/counter/Makefile                 |    6 +-
 drivers/counter/generic-counter.c                  | 1416 ++++++++++++++++++++
 drivers/{iio => }/counter/stm32-lptimer-cnt.c      |    0
 drivers/counter/stm32-timer-cnt.c                  |  356 +++++
 drivers/iio/Kconfig                                |    1 -
 drivers/iio/Makefile                               |    1 -
 drivers/iio/counter/104-quad-8.c                   |  596 --------
 drivers/iio/counter/Kconfig                        |   33 -
 include/linux/counter.h                            |  524 ++++++++
 21 files changed, 4246 insertions(+), 634 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-stm32-timer-cnt
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
 create mode 100644 Documentation/driver-api/generic-counter.rst
 create mode 100644 drivers/counter/104-quad-8.c
 create mode 100644 drivers/counter/Kconfig
 rename drivers/{iio => }/counter/Makefile (52%)
 create mode 100644 drivers/counter/generic-counter.c
 rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (100%)
 create mode 100644 drivers/counter/stm32-timer-cnt.c
 delete mode 100644 drivers/iio/counter/104-quad-8.c
 delete mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 include/linux/counter.h

-- 
2.16.2
