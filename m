Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932793AbeD0Nkf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:40:35 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932648AbeD0Nkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:40:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/5] timekeeping: API cleanup and extensions
Date: Fri, 27 Apr 2018 15:40:11 +0200
Message-Id: <20180427134016.2525989-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:dhJpLOtb2GhOi/OjqmBb3m/TbZ91Xy+f3dLTE9f3a/Ixg1akWyS
 uJF45LqMtfBBKxZke9QWGiUxmQQA1F09dsUNkHTDaZfqvSazCzRPHMADaluvKtZdpOATvA+
 OrQXJocLv0gjNjVOSaEX/Qrp+HLEyFrr1Si6BbZTbE9No6D1m1PLGZ/QR/fNAnsDqxMuxDd
 8GuB8nA79fhpyAtdWxuAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Oonr4mGMZQk=:XnY1lc+ICCkqf2G+TTBgcU
 PCeIYpQG9OmwVrMRwpr0C3o6NO0lG2V7vzvxHijS0/da9CUBgmySndszqaION18XU6LnmtCaK
 AMRECLYwt4S0hm1JWSugeggtqGiXGQqwLFXCNgqtfb4awVLtaXMds+/ITNkdaMyAXFA/jjsyJ
 ufIk+kZomkzX2wArTGcsGD81pNo3JVh5adEKdB6Mo30o2VPmvB1kYpQ8weCeMwh85rooWL9fj
 q3DgPbcHm7tj2AGr1AIIYJjudjdNldPt+78n9hdF7qy9mLPGVgu5pe1u+pgituXPKgvX2lykY
 42rJ9uQ2PrCfdY1vKXDYdlnOh084hXzsdva3Nug/3W7War1x6AXHFG3Y04BxiZ7n1J7imi4s3
 D41XsriWt2jWZ1bsIMoYuFZgTXh2EHT352RE0SNhNSs6VCW+w9AuH0WsmFMwgw21Smh/5iONj
 sF8muWFfGA+2rii1TqxW+qehp6vm2B8fF1d/1DgLB3JM2yTtG/rSDBqYTgNd1M1zKOmQhmyGS
 OpOROJYQ/oYMVuNMA6ANP6X610J+3gKpsq+b3Dn/JN8urkWbHsEdZegMx54A/ZIfjCfUQuDxg
 zn79ZoixULmNUUzmEaJPGa+vvEZGV0EL/9SxDuTReA4WGeaWe4hj9nw+Sc1ucNWAsp6PCnTQ4
 XW9f/zDxSUbWlDQhGcwybSiZgK8O6NY64JrhzJvFk9yD3jJ1aS+4cZoPs2bl3sydk4po=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

I've had these patches for a while but never got around to submitting
them. I recently rebased them after the boot time removal and now again
after the revert.

I'd like to see these go into v4.18 as a preparation for a last set of
driver conversions to y2038-safe interfaces that I've held off for now
since the interfaces were suboptimal.

The problems solved by this series are:
- aliasing timespec to timespec64 is a little erorr-prone,
  and in particular requires ugly casts to print a tv_sec field
  using the same format string across architectures

- naming is inconsistent, and while converting from the
  deprecated time_t to something else, I'd like to also
  convert to a ktime_get_*() API for consistency

- drivers that use current_kernel_time() today often care
  about the call being fast but don't care about it being
  CLOCK_REALTIME based, so they are better off being changed
  to a CLOCK_MONOTONIC or CLOCK_BOOTTIME based accessor
  to avoid issues with time going backwards.

	Arnd

Arnd Bergmann (5):
  timekeeping: Remove timespec64 hack
  timekeeping: Clean up ktime_get_real_ts64
  timekeeping: Standardize on ktime_get_*() naming
  timekeeping: Add ktime_get_coarse_with_offset
  timekeeping: Add more coarse clocktai/boottime interfaces

 include/linux/time32.h        | 18 ++-------
 include/linux/time64.h        |  7 ----
 include/linux/timekeeping.h   | 91 ++++++++++++++++++++++++++++++++++++-------
 include/linux/timekeeping32.h | 70 ++++++---------------------------
 kernel/time/time.c            |  2 -
 kernel/time/timekeeping.c     | 73 ++++++++++++++++------------------
 6 files changed, 124 insertions(+), 137 deletions(-)

-- 
2.9.0
