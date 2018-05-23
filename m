Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeEWP7Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:59:25 -0400
Received: from zulu.geekplace.eu ([5.45.100.158]:38404 "EHLO zulu.geekplace.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751770AbeEWP7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:59:17 -0400
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] driver-core: return EINVAL error instead of BUG_ON()
Date: Wed, 23 May 2018 17:59:10 +0200
Message-Id: <20180523155913.29679-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180516160816.20251-1-flo@geekplace.eu>
References: <20180516160816.20251-1-flo@geekplace.eu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series makes driver_register() emit an error message and
return a failure code instead of triggering a BUG_ON().

The first patch will cause driver_register() to fail gracefully if the
driver's bus was not initialized while printing out the name of the
faulty driver *and* the name of the involved bus. The second patch
records the error code if bus_register() fails. The third and final
patch of the series extends the first patch so that the recorded error
code is also print out if non-zero. Otherwise, if drv->bus->p is NULL
but the error code is zero, then probably bus_register() was never
called before.

Greg questioned [1] whether [2/3] and [3/3] are necessary:

> And really, when has this ever happened?  Why would a bus registration
> fail and later allow a driver to be registered?

I initially assumed that this is what cause me hitting the BUG_ON()
which [1/3] replaces: The bus registration failed and then the driver
attempts to register itself. But I did not had a chance to verify
that. I'll try to do so after my vacation. Meanwhile I hope that at
least [1/3] is considered an improvement of the kernel. If so, feel
free to pick it up.

1: Message-ID: <20180516163707.GD20425@kroah.com>

Florian Schmaus (3):
  driver-core: return EINVAL error instead of BUG_ON()
  driver-core: record error on bus registration
  driver-core: print bus registration error value

 drivers/base/bus.c     |  9 +++++++--
 drivers/base/driver.c  | 12 +++++++++++-
 include/linux/device.h |  1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.16.1
