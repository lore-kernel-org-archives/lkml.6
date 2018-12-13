Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25B52080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544693909;
	bh=GTjSPiSbAgWLrIc6CeUDyZKHFKSMjUVUb42Z3cK+270=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ItJTzYVV8KRT+vhg3L+LJJXawEutepH7NE6+bqi4lAmH9FTKXYz1UMUUw1T3BLW0i
	 hDShZPi5MQBhAIjdO2RI+FMC+/50I7Sx8OrnDp0TbADgCO07vVS5YW/1I3eq194nhm
	 fEstbAfUp4LR751SfAgTNEcGh1/9ol0PXgmU3djk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25B52080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeLMJi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:38:28 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46195 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeLMJi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:38:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so1263136otm.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwlM//7rajUlzBAHZri4m4C8lfBJGmdRgDoRpWub1OI=;
        b=kyRrIGKe5G657XQFup4cj+3dla4T5wJsB4zVqKjfm6XSzTEu1SeRrpKgVznS7jLLQC
         TN6VMfHVnScHLvlPIg+jPZtVOOAcsP6fugji1qPre2NP8agd8l7VbgUGajwb9X2mU1Vl
         X1Eq3WaaxJKKGuV0pKMWdVqhB3LbGj0oFqWJrbqDl1CxGATqgK/ipMrp1nS3SBD7EoLZ
         3Y8at7HcRH8LqO+RQ1jOO61EkzE8HdSplp6e0k3FVtOsEErZVv8fvpZOJOW96C7X7L8L
         Qs0hDrRZ2g/72pIkN2CkhHeINjSYXXXn3JKrg/yZGQVJeR8aqqo2KRI/pZj9tvSqzLvx
         R9Jw==
X-Gm-Message-State: AA+aEWZz79bvEQLkybISEzhccZBTW4nYorb7WyvJ30EVSNJdakvDTmnr
        VZxbX6DtnfIXi0MucM51GLOLs29pEkE7BGyi+g0LKvHX
X-Google-Smtp-Source: AFSGD/Xz/zA6ZV9nHvS4GTuJ/WFogVZtxK5svxNu1Mdr6AC3cEaCQ0KI1fapfRMGtd3VvzY8AdG2rqEpOQD2LHIAFUw=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr17226345oti.258.1544693906442;
 Thu, 13 Dec 2018 01:38:26 -0800 (PST)
MIME-Version: 1.0
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20181210084653.7268-1-daniel.vetter@ffwll.ch>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Dec 2018 10:38:14 +0100
Message-ID: <CAJZ5v0jkE=Rt2ozwcTxRdUN++Sr4HXULksDeMx4jEWj1jVDcyA@mail.gmail.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ramalingam.c@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 9:47 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> Drivers might want to remove some sysfs files, which needs the same
> locks and ends up angering lockdep. Relevant snippet of the stack
> trace:
>
>   kernfs_remove_by_name_ns+0x3b/0x80
>   bus_remove_driver+0x92/0xa0
>   acpi_video_unregister+0x24/0x40
>   i915_driver_unload+0x42/0x130 [i915]
>   i915_pci_remove+0x19/0x30 [i915]
>   pci_device_remove+0x36/0xb0
>   device_release_driver_internal+0x185/0x250
>   unbind_store+0xaf/0x180
>   kernfs_fop_write+0x104/0x190

Is the acpi_bus_unregister_driver() in acpi_video_unregister() the
source of the lockdep unhappiness?
