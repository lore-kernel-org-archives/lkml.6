Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeBGONu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:13:50 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41494 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeBGONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:13:47 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@google.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>, Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] backlight: pwm_bl: support linear interpolation and brightness to human eye
Date: Wed,  7 Feb 2018 15:13:33 +0100
Message-Id: <20180207141337.22247-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

This series is a second patchset integrating the requested changes.

The first and second patch what tries to solve is the problem of
granularity for high resolution PWMs. The idea is simple interpolate
between 2 brightness values so we can have a high PWM duty cycle (a
16 bits PWM is up to 65535 possible steps) without having to list
out every possible value in the dts. I think that this patch is
required to not break backward compability, to be more flexible and
also extend the functionality to be able to use high resolution PWM
with enough steps to have a good UI experience in userspace.

The thirth and fourth patch is a bit more ambicious, the idea is let
decide the driver the brightness-levels required in function of the PWM
resolution. To do this create a brightness-levels table filled with the
CIE 1931 algorithm values to convert brightness to PWM duty cycle.

More detailed info is available in the commit message of every patch.

Both functionalities were tested on a Samsung Chromebook Plus (that has
a 16 bits PWM) and a SL50 device (with a 8 bits PWM)

Waiting for your feedback.

Best regards,

Enric Balletbo i Serra (4):
  backlight: pwm_bl: linear interpolation between brightness-levels
  dt-bindings: pwm-backlight: add a num-interpolation-steps property.
  backlight: pwm_bl: compute brightness of LED linearly to human eye.
  dt-bindings: pwm-backlight: move brightness-levels to optional.

 .../bindings/leds/backlight/pwm-backlight.txt      |  34 ++-
 drivers/video/backlight/pwm_bl.c                   | 235 +++++++++++++++++++--
 2 files changed, 249 insertions(+), 20 deletions(-)

-- 
2.15.1
