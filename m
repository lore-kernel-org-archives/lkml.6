Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4DAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F255E24675
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F255E24675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933797AbeFVRLD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:11:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51987 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932819AbeFVRLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:11:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C5D0DF5941C3;
        Sat, 23 Jun 2018 01:10:57 +0800 (CST)
Received: from localhost (10.47.144.153) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.382.0; Sat, 23 Jun 2018
 01:10:57 +0800
Date:   Fri, 22 Jun 2018 18:10:43 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <jic23@kernel.org>, <pmeerw@pmeerw.net>, <knaack.h@gmx.de>,
        <fabrice.gasnier@st.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 00/10] Introduce the Counter subsystem
Message-ID: <20180622181043.00003d56@huawei.com>
In-Reply-To: <cover.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.144.153]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 17:06:46 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Changes in v7:
>  - Use git-format-patch "-M" switch option to format renames properly
>    (apologies to Jonathan for reviewing delete/add pairs in past revs)
>  - Remove superfluous license boilerplate in favor of SPDX lines
>  - Rename functions to match <noun>_<action> naming convention; e.g.
>    signal_read_value_set, count_read_value_set, etc.
>  - Rename COUNT_POSITION_UNSIGNED to COUNT_POSITION, and remove
>    COUNT_POSITION_SIGNED
>  - Inline local variables that are only used once
>  - Remove COUNT_FUNCTION_QUADRATURE_X2_RISING and
>    COUNT_FUNCTION_QUADRATURE_X2_FALLING; these can be reintroduced when
>    a practical use-case is determined
>  - Explicitly free allocated attribute pointers on error in
>    counter_device_groups_prepare
>  - Remove pretty tab alignment for symbol declarations in counter.h
>  - Fix kernel-doc syntax typos ("groups_list" and "groups" missing ':')
>  - Clarify in kernel-doc comments the use of "val" parameter for the
>    signal_read, count_read, and count_write callbacks
>  - Cleanup Generic Counter attributes documentation (explain preset
>    registers, remove superfluous text, etc.)
>  - Cleanup Generic Counter driver API documentation (improve formatting
>    by reorganizing options into intended sections, fix typos, etc.)
>  - Utilize register defines to remove dependence on magic numbers in
>    104-QUAD-8 counter driver
>  - Update Kconfig description for the 104-QUAD-8 counter driver to
>    describe its Generic Counter interface
>  - Remove "mode" wording from STM32 Timer dt-bindings documentation;
>    STM32 Timer features a proper quadrature encoder counter device
>  - Fix typo in STM32 Timer documentation: IN1/IN2 pins are CH1/CH2 pins
> 
> Hi Greg,
> 
> This patchset is stabilizing so I hope you can take a look over it and
> advise. This patchset introduces the Counter subsystem and the Generic
> Counter driver API.
> 
> Last year, the STM32 LPTimer IIO driver authored by Fabrice Gasnier
> opened up a discussion about the architecture of the IIO Counter
> interface. The IIO Counter interface was developed to provide support
> for the 104-QUAD-8 IIO driver -- several new IIO attributes were
> implemented to support the functionality of the 104-QUAD-8 device. When
> the STM32 LPTimer IIO driver was introduced, it too attempted to utilize
> the IIO Counter interface to support the counter functionality of the
> STM32 LPTimer device.
> 
> However, there were some difficulties with the IIO Counter interface.
> For example, the 104-QUAD-8 device features a pulse-direction counter
> and quadrature encoder counter (which can be toggled via the
> quadrature_mode attribute), as well as three quadrature encoder modes
> (x1, x2, and x4) which are set via the existing IIO scale attribute.
> While this method works for the 104-QUAD-8, the STM32 LPTimer featured a
> slightly different Quadrature x2 mode with different state machine
> behavior -- as such there is ambiguity over what behavior "quadrature
> x2" represents in the IIO Counter interface.
> 
> I decided to strip down these devices to arrive at the core essence of
> what constitutes a "counter device" and therefore design a "generic
> counter" abstraction to better represent these devices and prevent the
> ambiguity we discovered with the existing IIO Counter interface. This
> abstraction became the Generic Counter paradigm, which is explained in
> detail within the Documentation/driver-api/generic-counter.rst file
> introduced by this patchset.
> 
> Initially we attempted to further extend the IIO Counter interface in
> order to integrate the Generic Counter API as part of the IIO subsystem,
> but the outcome wasn't as clean as we desired. The results of our
> efforts proved to grow increasingly complicated, sparsed with hacks, and
> more often than not fought with the IIO subsystem rather than
> complemented it. I decided to separate the Generic Counter API from the
> IIO subsystem, and give it its own Counter subsystem in which to reside.
> This allowed us to streamline development and avoid jeopardizing the
> integrity of the IIO subsystem (we no longer have to bend the IIO API to
> support our needs, but can instead implement the necessary
> functionalities in the Counter subsystem as required).
> 
> The Counter subsystem has three consuming drivers thus far: two ported
> from the IIO subsystem (104-QUAD-8 and STM32 LPTimer counter) and one
> unique to the Counter subsystem (STM32 Timer counter). In userspace, the
> Generic Counter interface is rather intuitive:
> 
>     * /sys/bus/counter/devices/
>       - enumerated directories for counter devices
>     * /sys/bus/counter/devices/counterX/
>       - attributes for counterX where X is the enumeration ID
>     * /sys/bus/counter/devices/counterX/signalY
>       - attributes for signal Y where Y is the enumeration ID
>     * /sys/bus/counter/devices/counterX/countY
>       - attributes for count Y where Y is the enumeration ID
> 
> Although at this point the Counter subsystem is functionally separate
> from the IIO subsystem, I believe it would be prudent to merge this
> introduction patchset via the IIO tree due to the historical context of
> these counter drivers and the development of this patchset. Are there
> any additions or changes you believe I should make to this patchset
> going forward?
> 

I'm fine with this approach if Greg doesn't mind.  I've explicitly
given reviewed-by / acks where I normally would just sign off whilst
applying to make it clear I'm happy if we do decide on a different
route.  Has the side effect that I know which ones I liked last time
on a slow brewing complex set like this one.

Anyhow, we'll figure out the long term plan after these are in.
I'm happy with continuing to route through the IIO tree as this isn't
(I think) going to be a particularly busy as subsystems go.

Other options are fine with me as well!

Well done on getting it to this state.

Jonathan

> Sincerely,
> 
> William Breathitt Gray
> 
> Benjamin Gaignard (2):
>   counter: Add STM32 Timer quadrature encoder
>   dt-bindings: counter: Document stm32 quadrature encoder
> 
> Fabrice Gasnier (2):
>   counter: stm32-lptimer: add counter device
>   dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move
> 
> William Breathitt Gray (6):
>   counter: Introduce the Generic Counter interface
>   counter: Documentation: Add Generic Counter sysfs documentation
>   docs: Add Generic Counter interface documentation
>   counter: 104-quad-8: Add Generic Counter interface support
>   counter: 104-quad-8: Documentation: Add Generic Counter sysfs
>     documentation
>   iio: counter: Add deprecation markings for IIO Counter attributes
> 
>  Documentation/ABI/testing/sysfs-bus-counter   |  230 +++
>  .../ABI/testing/sysfs-bus-counter-104-quad-8  |   36 +
>  Documentation/ABI/testing/sysfs-bus-iio       |    8 +
>  .../testing/sysfs-bus-iio-counter-104-quad-8  |   16 +
>  .../{iio => }/counter/stm32-lptimer-cnt.txt   |    0
>  .../bindings/counter/stm32-timer-cnt.txt      |   31 +
>  .../devicetree/bindings/mfd/stm32-lptimer.txt |    2 +-
>  .../devicetree/bindings/mfd/stm32-timers.txt  |    7 +
>  Documentation/driver-api/generic-counter.rst  |  342 ++++
>  Documentation/driver-api/index.rst            |    1 +
>  MAINTAINERS                                   |   14 +-
>  drivers/Kconfig                               |    2 +
>  drivers/Makefile                              |    1 +
>  drivers/{iio => }/counter/104-quad-8.c        |  782 ++++++++-
>  drivers/counter/Kconfig                       |   59 +
>  drivers/{iio => }/counter/Makefile            |    6 +-
>  drivers/counter/generic-counter.c             | 1519 +++++++++++++++++
>  drivers/{iio => }/counter/stm32-lptimer-cnt.c |  361 +++-
>  drivers/counter/stm32-timer-cnt.c             |  390 +++++
>  drivers/iio/Kconfig                           |    1 -
>  drivers/iio/Makefile                          |    1 -
>  drivers/iio/counter/Kconfig                   |   34 -
>  include/linux/counter.h                       |  534 ++++++
>  23 files changed, 4292 insertions(+), 85 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
>  rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)
>  create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>  create mode 100644 Documentation/driver-api/generic-counter.rst
>  rename drivers/{iio => }/counter/104-quad-8.c (44%)
>  create mode 100644 drivers/counter/Kconfig
>  rename drivers/{iio => }/counter/Makefile (52%)
>  create mode 100644 drivers/counter/generic-counter.c
>  rename drivers/{iio => }/counter/stm32-lptimer-cnt.c (48%)
>  create mode 100644 drivers/counter/stm32-timer-cnt.c
>  delete mode 100644 drivers/iio/counter/Kconfig
>  create mode 100644 include/linux/counter.h
> 


