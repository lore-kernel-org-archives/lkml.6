Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbeCLITv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:19:51 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42586 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:19:49 -0400
X-Google-Smtp-Source: AG47ELuzoRz8/r76Mec9j5qCYcCyf/YKlrBQJptHfwAg+tGSlT6EJeDKV1ps8sDL8eLY/jqjIdDnJoXeV1y03N4QC3M=
MIME-Version: 1.0
From: =?UTF-8?Q?Juha_Erkkil=C3=A4?= <Juha.Erkkila@opinsys.fi>
Date: Mon, 12 Mar 2018 10:19:47 +0200
Message-ID: <CAJAOB25TAzzLfm+Q7-iCzo4_Vc4zyw0M4RO30GA27PMWvRaAfg@mail.gmail.com>
Subject: i915: Screen blanking problems with DRRS on HP Elitebook 820
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2C8JwUg030062

Hello folks,

I am seeing some blank screen issues with some HP machines that have
a product name "HP Elitebook 820 G1".  The problem does not occur with
all machines with this product name.  The problem manifests itself thus
that all of a sudden, maybe after an hour or two of use, the laptop
screen turns blank, and no user input (on keyboard or on a mouse) turns
the screen back on.  Whatever is happening on the computer before the
issue hits does not seem relevant.  The backlight of the screen is on,
but nothing is shown on the screen.  If laptop is suspended (by closing
the lid or some such action), and then resumed, the screen returns back
to normal.

Some of these machines advertise support for the DRRS (Dynamic Refresh
Rate Switching) feature in the i915-driver, some of these do not.
These machines have been manufactured sometime in the early 2014 I guess.
The issue occurs only on *some* machines that have support for DRRS.
That is, if a laptop screen does not support DRRS the problem does
not occur, and on *some* screens with DRRS support the problem occurs,
and on some screens with DRRS support it does *not* occur.

While searching for bug reports regarding this issue I could not find
much, but this problem seen here is very possibly the same:

  https://lists.debian.org/debian-user/2017/09/msg00883.html

The problem does not manifest itself on the 3.16 kernel, but on 4.9 and
4.14 it does.  I am testing the current Debian Stable (Stretch) kernels.
The i915 driver in 3.16 did not have support for DRRS (I believe),
but 4.9 and 4.14 do.

When tracing the problem I could see that it sometimes occurs exactly
when DRRS-feature slows down the display rate to 40Hz and then raises
it back again to 60Hz.  That is, it appears to happen sometimes/rarely
when DRRS does something, and not when DRRS functionality is passive.

It does seem this is a problem in hardware that can not be recognized
easily in the kernel, or at least I do not know how.  One solution is
to add a kernel parameter for turning the DRRS-functionality off, and
then selectively applying it on problematic machines.  And indeed, the
problematic machines (in our tests) appear to be functioning properly when
the following kernel patch is applied and a parameter "i915.enable_drrs=0"
is provided to the kernel.

Juha Erkkilä
Opinsys Oy

---

Here is a patch to add i915.enable_drrs kernel parameter, which can
be used to turn DRRS (Dynamic Refresh Rate Switching) on/off for i915.
Possible values are "0" and "1".  By default it is "1" (on).
Tested with 4.9.65 kernel sources (on Debian).

diff -ruN linux-4.9.65.orig/drivers/gpu/drm/i915/i915_params.c
linux-4.9.65/drivers/gpu/drm/i915/i915_params.c
--- linux-4.9.65.orig/drivers/gpu/drm/i915/i915_params.c
2017-11-24 09:33:43.000000000 +0200
+++ linux-4.9.65/drivers/gpu/drm/i915/i915_params.c     2018-02-15
13:34:13.486370208 +0200
@@ -39,6 +39,7 @@
        .enable_hangcheck = true,
        .enable_ppgtt = -1,
        .enable_psr = -1,
+       .enable_drrs = -1,
        .preliminary_hw_support =
IS_ENABLED(CONFIG_DRM_I915_PRELIMINARY_HW_SUPPORT),
        .disable_power_well = -1,
        .enable_ips = 1,
@@ -131,6 +132,11 @@
        "Override execlists usage. "
        "(-1=auto [default], 0=disabled, 1=enabled)");

+module_param_named_unsafe(enable_drrs, i915.enable_drrs, int, 0400);
+MODULE_PARM_DESC(enable_drrs, "Enable DSSR "
+       "(0=disabled, 1=enabled) "
+       "(-1=auto [default], 0=disabled, 1=enabled)");
+
 module_param_named_unsafe(enable_psr, i915.enable_psr, int, 0600);
 MODULE_PARM_DESC(enable_psr, "Enable PSR "
                 "(0=disabled, 1=enabled - link mode chosen
per-platform, 2=force link-standby mode, 3=force link-off mode) "
diff -ruN linux-4.9.65.orig/drivers/gpu/drm/i915/i915_params.h
linux-4.9.65/drivers/gpu/drm/i915/i915_params.h
--- linux-4.9.65.orig/drivers/gpu/drm/i915/i915_params.h
2017-11-24 09:33:43.000000000 +0200
+++ linux-4.9.65/drivers/gpu/drm/i915/i915_params.h     2018-02-15
13:35:29.335656880 +0200
@@ -40,6 +40,7 @@
        int enable_ppgtt;
        int enable_execlists;
        int enable_psr;
+       int enable_drrs;
        unsigned int preliminary_hw_support;
        int disable_power_well;
        int enable_ips;
diff -ruN linux-4.9.65.orig/drivers/gpu/drm/i915/intel_dp.c
linux-4.9.65/drivers/gpu/drm/i915/intel_dp.c
--- linux-4.9.65.orig/drivers/gpu/drm/i915/intel_dp.c   2017-11-24
09:33:43.000000000 +0200
+++ linux-4.9.65/drivers/gpu/drm/i915/intel_dp.c        2018-02-15
13:37:06.477318708 +0200
@@ -5283,6 +5283,11 @@
                return;
        }

+       if (!i915.enable_drrs) {
+               DRM_DEBUG_KMS("DRRS disabled by flag\n");
+               return;
+       }
+
        mutex_lock(&dev_priv->drrs.mutex);
        if (WARN_ON(dev_priv->drrs.dp)) {
                DRM_ERROR("DRRS already enabled\n");
@@ -5523,6 +5528,10 @@
                return NULL;
        }

+       /* Per platform default: all enabled. */
+       if (i915.enable_drrs == -1)
+               i915.enable_drrs = 1;
+
        downclock_mode = intel_find_panel_downclock
                                        (dev, fixed_mode, connector);
