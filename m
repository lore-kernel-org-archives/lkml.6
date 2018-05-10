Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964895AbeEJMwV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:52:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54461 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757217AbeEJMwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:52:15 -0400
X-Google-Smtp-Source: AB8JxZqa0ufTI/YoYMJdy6+J+qElJMBQiQkptMd5dZVb9J1KBRV8hZhUWEjnYsNVgiSqT298K2JBuQ==
From: Dmitry Safonov <dima@arista.com>
To: linux-kernel@vger.kernel.org
Cc: 0x7f454c46@gmail.com, Dmitry Safonov <dima@arista.com>,
        Arnd Bergmann <arnd@arndb.de>, "Theodore Ts'o" <tytso@mit.edu>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] ratelimit: Do not lose messages under limit
Date: Thu, 10 May 2018 13:52:09 +0100
Message-Id: <20180510125211.12583-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two issues with ratelimiting as far a I can see:
1. Messages may be lost even if their amount fit burst limit;
2. "suppressed" message may not be printed if there is no call to
   ___ratelimit() after interval ends.

I address (1) issue in the second patch.
While the (2) issue will require adding timers to print "suppressed"
message and care if ratelimit is on stack and no more exists. Which
looks too much at this point.

Dmitry Safonov (2):
  random: Omit double-printing ratelimit messages
  lib/ratelimit: Lockless ratelimiting

 drivers/char/random.c            | 22 +++++++--------
 drivers/gpu/drm/i915/i915_perf.c |  4 +--
 include/linux/ratelimit.h        | 34 ++++++++++++++---------
 lib/ratelimit.c                  | 59 +++++++++++++++++++---------------------
 4 files changed, 61 insertions(+), 58 deletions(-)

-- 
2.13.6
