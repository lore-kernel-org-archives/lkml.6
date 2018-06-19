Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2649C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8959220693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8959220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935985AbeFSV15 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:27:57 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:50624 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755540AbeFSV1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:27:53 -0400
Received: from localhost.localdomain (pD95EF733.dip0.t-ipconnect.de [217.94.247.51])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 8C7A4289CB9;
        Tue, 19 Jun 2018 21:24:47 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH RFC 0/4] Adding DT functionality to w1 busses
Date:   Tue, 19 Jun 2018 23:27:40 +0200
Message-Id: <20180619212744.794-1-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to fully move battery-supplied devices over to devicetree, the
onewire subsystem must get some updates.

Currently, the w1 bus system works like this. Device families, such as
battery controllers etc, are registered to the w1 core. Once a master
device is probed, it starts scanning the bus. Slave devices that are
revealed through this scan and that match previously registered
families are then registered, and their .add_slave() callback is
invoked.

Some devices, such as the ds2760, use that callback to call
platform_device_alloc() at runtime with a fixed device name to
instanciate their only user. That user does the actual work, while the
slave device merely functions as an I/O proxy. In the user
implementation, the w1 slave device is accessible through
dev->parent.

Now, for devicetree environments, this has to change a bit. First, slave
devices need to have a matching table so they can be listed as sub-nodes
of their master bus controller. Second, the core needs to match the
entries in these tables against the sub-nodes of the master node.
These two are trivial to do.

The next question is how the w1 slave device and its user(s) are linked
together. I'm proposing a DT layout with the following example:

	onewire {
		compatible = "w1-gpio";

		w1_slave: slave@0 {
			compatible = "maxim,w1-ds2760";
		};
	};

	battery-supply {
		compatible = "maxim,ds2760-supply";
		w1-slave = <&w1_slave>;
	};

Another option would be to place the supply user as another nested node
under the slave device, but I'm not sure if that's beneficial. I'm open
to discussions though.

This patch set implements the changes for the above in the w1 core.
Changing the supply users is left for later when the basics have
settlerd, but a helper to reference slave devices through phandles is
already provided.


Thanks,
Daniel


Daniel Mack (4):
  dt-bindings: w1: document sub-node bindings for DS2760
  w1: core: match sub-nodes of bus masters in devicetree
  w1: core: provide helper to look up w1 slaves through devicetree nodes
  w1: ds2760: add devicetree matching glue

 .../devicetree/bindings/w1/w1-ds2760.txt      |  9 +++++
 .../devicetree/bindings/w1/w1-gpio.txt        |  6 +++
 Documentation/devicetree/bindings/w1/w1.txt   | 17 ++++++++
 drivers/w1/slaves/w1_ds2760.c                 | 15 ++++++-
 drivers/w1/w1.c                               | 40 +++++++++++++++++++
 include/linux/w1.h                            | 13 ++++++
 6 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/w1/w1-ds2760.txt
 create mode 100644 Documentation/devicetree/bindings/w1/w1.txt

-- 
2.17.1

