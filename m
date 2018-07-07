Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4ACC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729A2208A2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 21:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729A2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932820AbeGGVOE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 17:14:04 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:44213 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932518AbeGGVOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 17:14:03 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id AAB2D300002A0;
        Sat,  7 Jul 2018 23:14:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 789D536A1A; Sat,  7 Jul 2018 23:14:01 +0200 (CEST)
Date:   Sat, 7 Jul 2018 23:14:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH 5/5] thunderbolt: Add support for runtime PM
Message-ID: <20180707211401.GA13111@wunner.de>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
 <20180618110731.57427-6-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618110731.57427-6-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 02:07:31PM +0300, Mika Westerberg wrote:
> Implement this using standard Linux runtime PM APIs so that when all the
> children devices are runtime suspended, the Thunderbolt host controller
> PCI device is runtime suspended as well. The ICM firmware then starts
> powering down power domains towards RTD3 but it can prevent this if it
> detects that there is an active Display Port stream (this is not visible
> to the software, though).
> 
> The Thunderbolt host controller will be runtime resumed either when
> there is a remote wake event (device is connected or disconnected), or
> when there is access from userspace that requires hardware access.

IIUC, if there is no xdomain, after 15 s all switch devices as well as
the domain device and the NHI will have runtime suspended.  The control
channel is torn down as well, so you can no longer receive notifications
over it.  Then how is wakeup of the NHI signalled on hotplug/unplug?
Do you get a PME for the NHI device?  Because I'm fairly certain that
I do not get a PME for the Light Ridge in my MacBook Pro, but I'll test
this once more and modify negotiate_os_control() to grant PME control
to the OS.

Thanks,

Lukas
