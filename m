Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7230AC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B0A21A17
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 11:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B0A21A17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbeHLNyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 09:54:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59408 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeHLNyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 09:54:15 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 926ccf08591eb1c1; Sun, 12 Aug 2018 13:16:31 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] platform/x86: Add ACPI i2c-multi-instantiate pseudo driver
Date:   Sun, 12 Aug 2018 13:14:23 +0200
Message-ID: <1946404.OiO1uWY7Ot@aspire.rjw.lan>
In-Reply-To: <9805a950-dfd3-df13-15e8-d60703ce0498@redhat.com>
References: <20180809114046.21366-1-hdegoede@redhat.com> <CAJZ5v0jbNTGEXWJ+CtPOKSM=AyB5-3hV-tMCYehj5w87i_2znA@mail.gmail.com> <9805a950-dfd3-df13-15e8-d60703ce0498@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 9, 2018 2:08:41 PM CEST Hans de Goede wrote:
> Hi,
> 
> On 09-08-18 13:55, Rafael J. Wysocki wrote:
> > On Thu, Aug 9, 2018 at 1:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> >> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
> >> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
> >> i2c-device.
> >>
> >> But in some rare cases the manufacturer has decided to describe multiple
> >> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
> >>
> >> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
> >> code to support this corner-case.
> >>
> >> This commit introduces a new i2c-multi-instantiate driver which fixes this
> >> in a different way. This new driver can be built as a module which will
> >> only loaded on affected systems.
> >>
> >> This driver will instantiate a new i2c-client per I2cSerialBus resource,
> >> using the driver_data from the acpi_device_id it is binding to to tell it
> >> which chip-type (and optional irq-resource) to use when instantiating.
> >>
> >> Note this driver depends on a platform device being instantiated for the
> >> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
> >> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> >>
> >> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >> Changes in v2:
> >> -Rebase on top of 4.18-rc2
> >>
> >> Changes in v3:
> >> -Change from an i2c-driver using a hack to allow having multiple i2c clients
> >>   at the same address to a platform-driver
> >>
> >> Changes in v4:
> >> -Tweak MAINTAINERS entry a bit
> >>
> >> Changes in v5:
> >> -s/no_clients/num_clients/
> >> -Change patch Subject prefix to platform/x86
> >>
> >> Changes in v6:
> >> -s/irq_idx/gpio_irq_idx/
> > 
> > And this is the only patch that has changed in v6, right?
> 
> Correct.
> 
> > Anyway, if you have further updates on top of this series, please send
> > them as incremental patches.
> 
> Ok, will do.

The series has been applied, thanks!


