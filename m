Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932391AbeEHOU3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:20:29 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:43977 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbeEHOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:20:27 -0400
X-Google-Smtp-Source: AB8JxZrSgMzp+iWXfgyk8+VNeaPiEd8H+FUrQvVLYpjvvTmXy7RVnktbvkfSRv+At51e/Wbnc/5ezQ==
Date: Tue, 8 May 2018 07:20:23 -0700
From: Tejun Heo <tj@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: ata_piix: Fix a possible data race in
 piix_pci_device_resume
Message-ID: <20180508142023.GJ2368884@devbig577.frc2.facebook.com>
References: <20180508034613.12969-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508034613.12969-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 08, 2018 at 11:46:13AM +0800, Jia-Ju Bai wrote:
> The write operation to "host->flags" is protected by
> the lock on line 1048, but the read operation to
> this data on line 1046 is not protected by the lock.
> Thus, there may exist a data race for "host->flags".
> 
> To fix this data race, the read operation to "host->flags" 
> should be also protected by the lock.

This isn't necessarily wrong.  It isn't different from atomic bitops -
the modifications are synchronized but what the reads get is
determined by memory ordering or other synchronization.  Here, the
whole suspend / resume paths are always synchronized and the spinlocks
are there just in case there are other writers to the field.

Thanks.

-- 
tejun
