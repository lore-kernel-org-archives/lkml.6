Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B3F24344
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lECakIob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B3F24344
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966032AbeF0VXp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965946AbeF0VXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:23:43 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C302244A;
        Wed, 27 Jun 2018 21:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530134622;
        bh=kg0Y27VLEzNGxqr3Mej6igWB1kjN82s6dipEssk/1QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lECakIobiZ+A+uZcCHppteJr66iJx87skjarM6mt7oaQms9EszuARbslAsI3o8dH/
         Qi8ClTZnLtdcbzD9zwneTsTrqJm45mtdWhzt71TTLVvip9GhmNnBTBqhathotS5zaa
         gfoKrUQc+Vc6ISs7BgJb6JUdP/7BLXOvXoiOTkvg=
Date:   Wed, 27 Jun 2018 16:23:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: i801: Fix runtime PM
Message-ID: <20180627212340.GA161569@bhelgaas-glaptop.roam.corp.google.com>
References: <20180626143913.7361-1-jarkko.nikula@linux.intel.com>
 <20180627221550.0fa5f2df@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627221550.0fa5f2df@endymion>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Rafael, linux-pm, linux-kernel]

On Wed, Jun 27, 2018 at 10:15:50PM +0200, Jean Delvare wrote:
> Hi Jarkko,
> 
> On Tue, 26 Jun 2018 17:39:12 +0300, Jarkko Nikula wrote:
> > Commit 9c8088c7988 ("i2c: i801: Don't restore config registers on
> > runtime PM") nullified the runtime PM suspend/resume callback pointers
> > while keeping the runtime PM enabled. This causes that device stays in
> > D0 power state and sysfs /sys/bus/pci/devices/.../power/runtime_status
> > shows "error" when runtime PM framework attempts to autosuspend the
> > device.
> > 
> > This is due PCI bus runtime PM which checks for driver runtime PM
> > callbacks and returns with -ENOSYS if they are not set. Fix this by
> > having a shared dummy runtime PM callback that returns with success.
> > 
> > Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> 
> I don't want to sound like I'm trying to decline all responsibility for
> a regression I caused, but frankly, if just using SIMPLE_DEV_PM_OPS()
> breaks runtime PM, then it's the PM model which is broken, not the
> i2c-i801 driver.
> 
> I will boldly claim that the PCI bus runtime code is simply wrong in
> returning -ENOSYS in the absence of runtime PM callbacks, and it should
> be changed to return 0 instead. Or whoever receives that -ENOSYS should
> not treat it as an error - whatever makes more sense.
> 
> Having to add dummy functions in every PCI driver that doesn't need to
> do anything special for runtime PM sounds plain stupid. It should be
> pretty obvious that a whole lot of drivers are going to use
> SIMPLE_DEV_PM_OPS() because it exists and seems to do what they want,
> and all of them will be bugged because the PCI core is doing something
> silly and unexpected.
> 
> So please let's fix it at the PCI subsystem core level. Adding Bjorn
> and the linux-pci list to Cc.

Thanks Jean.  What you describe does sound broken.  I think the PM
guys (cc'd) will have a better idea of how to deal with this.
