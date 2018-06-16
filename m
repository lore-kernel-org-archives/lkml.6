Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3FBC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447B9208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 07:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSgBh4qv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447B9208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965273AbeFPHQ5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 03:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932319AbeFPHQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 03:16:55 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB80B20896;
        Sat, 16 Jun 2018 07:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529133415;
        bh=qbLeKsV/sae/jdSyRBZogPnNMxkwQZWjvXx5jmI1UBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSgBh4qvzzok93OJd0isH2lCVb0erUWpgrs3FfMf6gObTqlI2vN8Su8j0KfzscS7a
         qCJo/XWaLdGoc381+rf7+d/TQXTs14c5gJoA/gyLDtYwnnqRlfahSj+iUZYH/hlhau
         KZZLZ7hFwzVbzy0ZNOvFfVKfJ6RM26HcOMzNrUso=
Date:   Sat, 16 Jun 2018 09:16:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 1/4] scsi: ufs: Add Configuration Descriptor to sysfs
Message-ID: <20180616071632.GD30558@kroah.com>
References: <20180615210049.126123-1-evgreen@chromium.org>
 <20180615210049.126123-2-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615210049.126123-2-evgreen@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 02:00:46PM -0700, Evan Green wrote:
> This change adds the configuration descriptor to the UFS
> sysfs interface. This is done in preparation for making the
> interface writable, which will enable provisioning UFS devices
> via Linux.
> 
> The configuration descriptor is laid out as a header, then a set of
> (usually 8) copies of the same descriptor for each unit.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> Changes since v1:
> 	- Squashed documentation changes into this change.
> 	- Reworked sysfs layout so that instead of a sysfs file for a
> unit selector and then a common set of unit attributes, each unit in
> the config descriptor has its own directory. This required a little
> bit of kobject magic. Alternatively I could use standard device
> attributes and simply allocate N*M of them from a template. I have
> that coded up, and can go with that if preferred, but I thought
> this was a little nicer since it wasted less memory.

Ick, don't use "raw" kobjects please, as userspace will not see them
correctly in the libraries that track devices and attributes, like
libudev.

And what is wrong with using configfs?  I thought that was the better
way to go for something like this.  You are configuring the device,
which is exactly what configfs was created for, to keep people from
having to do this type of mess in sysfs.

thanks,

greg k-h
