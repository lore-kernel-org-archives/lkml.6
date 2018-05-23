Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbeEWSGq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:06:46 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:37549 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeEWSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:06:42 -0400
Date: Wed, 23 May 2018 11:06:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] watchdog: sp805: set WDOG_HW_RUNNING when appropriate
Message-ID: <20180523180639.GA27570@roeck-us.net>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
 <1527014840-21236-4-git-send-email-ray.jui@broadcom.com>
 <20180522205457.GA16363@roeck-us.net>
 <0d92b9e9-a3d1-6e91-8371-b5ed3a83e399@broadcom.com>
 <00c121ea-d197-93b8-2f56-bcca963f70fb@broadcom.com>
 <76d47e02-7a5f-3fc2-3905-cd4aa03ac69c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76d47e02-7a5f-3fc2-3905-cd4aa03ac69c@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 12:48:10PM +0100, Robin Murphy wrote:
> On 23/05/18 08:52, Scott Branden wrote:
> >
> >
> >On 18-05-22 04:24 PM, Ray Jui wrote:
> >>Hi Guenter,
> >>
> >>On 5/22/2018 1:54 PM, Guenter Roeck wrote:
> >>>On Tue, May 22, 2018 at 11:47:18AM -0700, Ray Jui wrote:
> >>>>If the watchdog hardware is already enabled during the boot process,
> >>>>when the Linux watchdog driver loads, it should reset the watchdog and
> >>>>tell the watchdog framework. As a result, ping can be generated from
> >>>>the watchdog framework, until the userspace watchdog daemon takes over
> >>>>control
> >>>>
> >>>>Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> >>>>Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> >>>>Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> >>>>---
> >>>>  drivers/watchdog/sp805_wdt.c | 22 ++++++++++++++++++++++
> >>>>  1 file changed, 22 insertions(+)
> >>>>
> >>>>diff --git a/drivers/watchdog/sp805_wdt.c
> >>>>b/drivers/watchdog/sp805_wdt.c
> >>>>index 1484609..408ffbe 100644
> >>>>--- a/drivers/watchdog/sp805_wdt.c
> >>>>+++ b/drivers/watchdog/sp805_wdt.c
> >>>>@@ -42,6 +42,7 @@
> >>>>      /* control register masks */
> >>>>      #define    INT_ENABLE    (1 << 0)
> >>>>      #define    RESET_ENABLE    (1 << 1)
> >>>>+    #define    ENABLE_MASK    (INT_ENABLE | RESET_ENABLE)
> >>>>  #define WDTINTCLR        0x00C
> >>>>  #define WDTRIS            0x010
> >>>>  #define WDTMIS            0x014
> >>>>@@ -74,6 +75,18 @@ module_param(nowayout, bool, 0);
> >>>>  MODULE_PARM_DESC(nowayout,
> >>>>          "Set to 1 to keep watchdog running after device release");
> >>>>  +/* returns true if wdt is running; otherwise returns false */
> >>>>+static bool wdt_is_running(struct watchdog_device *wdd)
> >>>>+{
> >>>>+    struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
> >>>>+
> >>>>+    if ((readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK) ==
> >>>>+        ENABLE_MASK)
> >>>>+        return true;
> >>>>+    else
> >>>>+        return false;
> >>>
> >>>    return !!(readl_relaxed(wdt->base + WDTCONTROL) & ENABLE_MASK));
> >>>
> >>
> >>Note ENABLE_MASK contains two bits (INT_ENABLE and RESET_ENABLE);
> >>therefore, a simple !!(expression) would not work? That is, the masked
> >>result needs to be compared against the mask again to ensure both bits
> >>are set, right?
> >Ray - your original code looks correct to me.  Easier to read and less
> >prone to errors as shown in the attempted translation to a single
> >statement.
> 
> 	if (<boolean condition>)
> 		return true;
> 	else
> 		return false;
> 
> still looks really dumb, though, and IMO is actually harder to read than
> just "return <boolean condition>;" because it forces you to stop and
> double-check that the logic is, in fact, only doing the obvious thing.
> 

Yes, and I won't accept it, sorry.

Guenter

> Robin.
> 
> 
> 
> p.s. No thanks for making me remember the mind-boggling horror of briefly
> maintaining part of this legacy codebase... :P
> 
> $ grep -r '? true : false' --include=*.cpp . | wc -l
> 951
