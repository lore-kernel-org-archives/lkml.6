Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753156AbeDPR5v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:57:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40043 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeDPR5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:57:48 -0400
X-Google-Smtp-Source: AIpwx48UIyvD0CI6fIsxzBEil5iSOE5JkaVuN+qbMPI50pgPB029PCoEwEvNsbygfSZ2cDQqjZByEw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clk: add duty cycle support
Date: Mon, 16 Apr 2018 19:57:40 +0200
Message-Id: <20180416175743.20826-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the possibility to control the duty cycle ratio of a
clock within the clock framework.

This useful when the duty cycle ratio depends on another parameter
controlled by the clock framework. For example, the duty cycle ratio may
depends on the value of a divider (ratio = N / div).

This is also useful if the related clock is part of large tree. In this
case, using CCF to control the clock tree and the PWM framework for the
duty cycle would be a nightmare for the provider and the consumer.

A clock provider is not required to implement the operation to set and get
the duty cycle. If it does not implement .get_duty_cycle(), the ratio is
assumed to be 50%.

This series also provides pass-through operations ready to be used for
clock which don't resample the clock signal (such as gates and muxes).
This is provided to make things easier for consumers. Clocks are usually
made of several elements, like a composite clocks with a mux, a divider,
and a gate. With the pass-through ops set on the gate, the consumer does
not need to be aware that the duty cycle is actually controlled by the
divider, it can continue to use the clock through the gate, as usual.  The
simple propagation will stop at the first clock which resample the signal
(such as a divider).

Patch 2 and 3 add the pass-through ops to the generic gate and mux ops.  In
this first version, it is unconditional, but maybe we should provide a flag
to let people decide what is best for them ?

The series has been developed to handled the sample clocks provided by
audio clock controller of amlogic's A113 SoC. To support i2s modes, this
clock need to have a 50% duty cycle ratio, while it should be just one
pulse of the parent clock in dsp modes.

PS: Checkpatch complains heavily about the white space in the trace header
file. I believe I have respected the style already used in this
file. Please let me know if it should be done differently.

Jerome Brunet (3):
  clk: add duty cycle support
  clk: gate: add duty cycle passthrough ops
  clk: mux: add duty cycle passthrough ops

 drivers/clk/clk-gate.c       |   2 +
 drivers/clk/clk-mux.c        |   4 +
 drivers/clk/clk.c            | 196 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/clk-provider.h |  17 ++++
 include/linux/clk.h          |  32 +++++++
 include/trace/events/clk.h   |  36 ++++++++
 6 files changed, 282 insertions(+), 5 deletions(-)

-- 
2.14.3
