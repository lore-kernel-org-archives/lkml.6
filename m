Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAE5FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D121920892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5b26bEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D121920892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeG3TC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbeG3TC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:02:58 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62AE2083E;
        Mon, 30 Jul 2018 17:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532971618;
        bh=NLGEQdNghfrbPSAR1Wbv767r3dY+4F+S0v48uttJ7ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a5b26bExjCMn1B7G/UaJIbYY7tRDcpl3EPQKAVu/9GWp3DXlGJxYg0ijnRhOB1JCt
         x4E1WIeGCEUceExaD0E0XBda58doCizHN9Lr0Q5QxRYx/dbY3mcHLAZdylwGLQCQ1p
         R8Q3VwRcCwmINu4efDl+y5jLNlVJSN3dQeqzbJBs=
Date:   Mon, 30 Jul 2018 12:26:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Rajat Jain <rajatja@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayurkumar.patel@intel.com, rajatxjain@gmail.com,
        Richard Hughes <rhughes@redhat.com>,
        Carlos Garnacho <cgarnach@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
Message-ID: <20180730172656.GL173328@bhelgaas-glaptop.roam.corp.google.com>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
 <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
 <20180730083210.GA9641@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730083210.GA9641@wunner.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:32:10AM +0200, Lukas Wunner wrote:
> On Fri, Jul 27, 2018 at 03:26:19PM -0500, Bjorn Helgaas wrote:
> > The question is where those sysfs files should be.  Currently they are
> > associated with the device at the *upstream* end of the link.  In the
> > example above, they're associated with the Root Port:
> > 
> >   /sys/devices/pci0000:00/0000:00:1c.2/power/link_state
> > 
> > I don't know if that's the right place, or if they should be
> > associated with the device at the *downstream* end of the link, i.e.,
> > 04:00.0.  The downstream end might be better because:
> > 
> >   - It's easier to associate the downstream end with a device the user
> >     cares about, e.g., a NIC, GPU, etc.  This is mostly a user-
> >     interface issue.
> > 
> >   - A link can lead to a multi-function device, and the spec allows
> >     those functions to have different ASPM settings (see PCIe r4.0,
> >     sec 5.4.1).  With the sysfs files at the upstream end of the link,
> >     we have no way to configure those functions individually.
> > 
> > Any thoughts?
> 
> Conceivably, could the downstream end not be enumerated at all?
> (E.g. a hotplug or rescan is necessary for it to be enumerated?)
> 
> If so, the upstream end might be better because the ASPM settings
> can be configured in advance, before the downstream end appears.

Yes, of course there may be ports (root ports or switch downstream
ports) that have nothing connected yet.  The ASPM Control on a
hot-added device would normally be 0 (ASPM disabled).  Usually we can
enable features on the upstream end before the downstream end, but
this sentence in sec 5.4.1.3 is concerning:

  Software must not enable L0s in either direction on a given Link
  unless components on both sides of the Link each support L0s;
  otherwise, the result is undefined.

If we can trust that statement, if we enable ASPM on the upstream end,
then hot-add a device that doesn't support L0s, the result may be
undefined.  So I'm a little wary of configuring ASPM before a
downstream device is present.

I think the sysfs control files are absent if there's no downstream
device, but we create them when the hot-add happens, in paths like
this:

  pciehp_configure_device
    pci_scan_slot(bus)
      pcie_aspm_init_link_state(bus->self)

It seems ugly to me that this ASPM init is attached to the *parent*
instead of being done somewhere like pci_configure_device().
