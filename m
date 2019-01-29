Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0DDC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BB121738
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MuT7E3+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfA2Bzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:55:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37399 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfA2Bzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:55:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so8612659plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 17:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJmK86iaqhwA0O+aVdcJ7tSqpGuZHn6LzNzGo8HF8IU=;
        b=MuT7E3+kITYpnGMQjYzNyvXfj/kAxc7/Li5tOgCpfPccnHbGeKfoJxB8R3ybxt7unf
         AnYdMf89+Dci9v+24a0EtXI9vYAA6Q/DD6k1aNX9pXIxEVTtv4vH6KvYFPBSm80rTnY0
         +KhRhu/WW/go8xbxLN4u12W/hGSo/0Eoec5OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YJmK86iaqhwA0O+aVdcJ7tSqpGuZHn6LzNzGo8HF8IU=;
        b=OMRgjPb0I6/y3vzJeuzxc6E/q9pDU9tpOkMJvJXq7YHVzOoIwS+RGUSNTKt0CMtbWG
         kSsteexZWneWpcwom0NgCLAfSsEmmXArD8PKH4RWskOlbQLQvlANgtKSiiQLzXusR8Li
         53KpFGX3FG8p3cLc4G113qTpufBX6X/wT/MT6nVyTzBXhm83/2x3gQ6BXXYVENaRR8TQ
         WrK3mSlTW8ERQI+Kdp54QI7lTz5tV27iaUQ4pvE3BFiKtMn61scWbA1zacOZ1vuyOztY
         JJVIg7IsM7s5ZZTTCuUo8iJ5nPfc54A0tZ+UoaH1hAUmjiGJmvY9bTsUil1g8dQcQNa4
         Yglg==
X-Gm-Message-State: AJcUuke4q02tVw6zFd1AbtSgXBhe2Sfb7Dsgiu4S8A+uZWzLZcb4MvQB
        XUXUdzZReGuZQWUMJowTQkhsstluGo4oWg==
X-Google-Smtp-Source: ALg8bN6O0+yNZR6lm1umTmZ5Vu3OjOP1j1y/9PDRYUT3MNEX/mdkc8nBml6IZh5nuv2/SH7fzAvx8A==
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr24619904pll.265.1548726949513;
        Mon, 28 Jan 2019 17:55:49 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g15sm142911530pfj.131.2019.01.28.17.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 17:55:48 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [RFC/PATCH 0/5] DVFS in the OPP core
Date:   Mon, 28 Jan 2019 17:55:42 -0800
Message-Id: <20190129015547.213276-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is an RFC around how we can implement DVFS for devices
that aren't your typical OPPish device (i.e. GPU/CPU). They don't have a
strict set of frequencies that they have been tested at to derive some
operating performance point. Instead they have a coarser set of
frequency max or 'fmax' OPPs that describe the maiximum frequency the
device can operate at with a given voltage.

The approach we take is to let the devm_pm_opp_set_rate() API accept 0
as a valid frequency indicating the frequency isn't required anymore and
to make the same API use the clk framework to round the frequency passed
in instead of relying on the OPP table to specify each frequency that
can be used. Once we have these two patches in place, we can use the OPP
API to change clk rates instead of clk_set_rate() and use all the recent
OPP enhancements that have been made around required-opps and genpd
performance states to do DVFS for all devices.

One nice feature of this approach is that we don't need to change the
OPP binding to support this. We can specify only the max frequencies and
the voltage requirements in DT with the existing binding and slightly
tweak the OPP code to achieve these results. 

This series includes a conversion of the uart and spi drivers on
qcom sdm845 where these patches are being developed. It shows how a
driver is converted from the clk APIs to the OPP APIs and how
enable/disable state of the clk is communicated to the OPP layer.

Some open topics and initial points for discussion are:

1) The dev_pm_opp_set_rate() API changes may break something that's 
relying on the rate rounding that OPP provides. If those exist,
we may need to implement another API that is more explicit about using
the clk API instead of the OPP tables.

2) dev_pm_opp_set_rate(0) is an interesting solution to the problem of
dropping the rate requirement. Is there anything better than this?

3) How do we handle devices that already have power-domains specified in
DT? The opp binding for required-opps doesn't let us specify the power
domain to target, instead it assumes that whatever power domain is
attached to a device is the one that OPP needs to use to change the
genpd performance state. Do we need a
dev_pm_opp_set_required_opps_name() or something to be explicit about
this? Can we have some way for the power domain that required-opps
correspond to be expressed in the OPP tables themselves?

4) How do we achieve the "full constraint" state? i.e. what do we do
about some devices being active and others being inactive during boot
and making sure that the voltage for the shared power domains doesn't
drop until all devices requiring it have informed OPP about their
power requirements?

Rajendra Nayak (4):
  OPP: Make dev_pm_opp_set_rate() with freq=0 as valid
  tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
  spi: spi-geni-qcom: Use OPP API to set clk/perf state
  arm64: dts: sdm845: Add OPP table for all qup devices

Stephen Boyd (1):
  OPP: Don't overwrite rounded clk rate

 arch/arm64/boot/dts/qcom/sdm845.dtsi  | 115 ++++++++++++++++++++++++++
 drivers/opp/core.c                    |  26 ++++--
 drivers/spi/spi-geni-qcom.c           |  12 ++-
 drivers/tty/serial/qcom_geni_serial.c |  15 +++-
 4 files changed, 155 insertions(+), 13 deletions(-)

For the interested, these patches are located here:

   https://github.com/rrnayak/linux/ v5.0-rc3/opp-corners-wip

I've generated these patches by cutting off the top of that tree and
massaging the commit text a bit for the first patch.

base-commit: 49a57857aeea06ca831043acbb0fa5e0f50602fd
prerequisite-patch-id: 9c3ee728603596b8b0ba06ffd66084bdc21b1271
prerequisite-patch-id: f160e050bcd74f5de6fad66329381853869a6a97
prerequisite-patch-id: aa23548d2b486c29489b4304d85799d08762254e
prerequisite-patch-id: 40dd117c45fecb4308298352346546612db94b64
prerequisite-patch-id: cd102fa42bab19897c2295e8b990b2156626054a
prerequisite-patch-id: 3b9e5c8ed65ee96cc0f1c50166cf6bbb597ef582
prerequisite-patch-id: 7e71b957b90ad51d0619944d5ebc859380e8e3e4
prerequisite-patch-id: 5abd2bd6b3ae3e91551e2b8f9295169019ba82c7
prerequisite-patch-id: 68bb3e44cf4e5dbd363a1a1750e4d378971ed393
prerequisite-patch-id: 882b14ef9527b15d22cfddbb5fa2b9d43df1ff04
prerequisite-patch-id: 6fc14ddeb074fb0826f1f40031e9d161f1361666
-- 
Sent by a computer through tubes

