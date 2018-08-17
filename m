Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895C9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 04:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6552152B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 04:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6552152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeHQHvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 03:51:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:46710 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbeHQHvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 03:51:37 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7H4nAsD017258;
        Thu, 16 Aug 2018 23:49:11 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] pci: Rework is_added race fix and address bridge enable races
Date:   Fri, 17 Aug 2018 14:48:56 +1000
Message-Id: <20180817044902.31420-1-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is really two series but since they conflict a bit separately
here they are in one:

First we undo the mess of those atomic priv_flags. The atomicity
doesn't provide any security since there's no locking against
the other state pertaining to those flags, it only protects the
flags themselves.

The is_added mess is fixed much more simply by moving the assignment
of the flag to before we start the driver. This is in line with the
rest of the PCI code: until bound to the device model, we are essentially
assuming a single threaded environment. is_added is a flag that is
logically owned by that part of the PCI code, and thus should be set
and cleared within that "safer" environment.

This removes the horrid relative includes in the powerpc code as well.

The second part aims at fixing the enable/disable/set_master races,
and does so by providing a framework for future device state locking
issues.

It introduces a pci_dev->state_mutex which is used at a lower level
than the device_lock (the device lock isn't suitable, as explained
in the cset comments) and uses it to protect enablement and set_master.


