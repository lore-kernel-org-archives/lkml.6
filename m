Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24801C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FDB2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG4fQjWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392796AbfBNVCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:02:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37993 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387417AbfBNVC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:02:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so3699687pfi.5;
        Thu, 14 Feb 2019 13:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q3qM7WbpSUs0Mr94IJ5MG4aDalyPzNXynKMWm/LGRvQ=;
        b=DG4fQjWhgqS/FAJjkTkgArrayvwFAIQRvqnyAQEfy3YN2952KM0OjZaj7DT36rkO7V
         kOkYUQ7qiaiCLc13tuzjpudvxFGG7umfGSkuSCuYLM27xefRFBAokZRKpUUNWig0IyQF
         DBtLFs7A/7SW5EqYzitTrE5S6n77pZMjZRFhHLINltINh9X2Sv8JvYH2cfz1OSAyLTub
         7rbIYRljEqL9npnpG5BENlUh1MhKmUxee5bAdL+SSuadchiI2ufgycTNK3oYfb9xVhnC
         rgyWUG1WAm+6j//N34ZWLSp48l3TFjyd2QQcj8ivfeAMHkfSVbNwkpIOgW6m3X1dkgiv
         amoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q3qM7WbpSUs0Mr94IJ5MG4aDalyPzNXynKMWm/LGRvQ=;
        b=HvDHtHX03f+YzbJpodJHPMTN+Db6wEh35MuCbKMRhWKqiZR3ywnIN+xWhLDUW8qgkN
         y7h0RDk8SxWVDjie+Ey2FVVgYeN0+PkRDtTk+vAYlh+50lemtsPt12ktPY2X8KD1uCFY
         41vaeB4o/MDLnra3lVX8e3wiKk/AeMjXB0owlRAM77wNMcmnnYO3065pIspxZFINY7tF
         7SgkjyyGZ09YAtTqn6ZA8LmrdYumWC77r+kA7954wCP8GMKBUFLeb0uhTjSNdTtLNGOP
         OGO9EVhysjvDiimCVN/slw+rNCVJwQUy03hUXyH8mNj4T0LJdbQoqEgQzvLEGWBNM8U+
         9+uw==
X-Gm-Message-State: AHQUAuZV3GETPvbuCTNu9UXSeGCwaNf6872foc9EBh6+QizC4Fk423Z9
        +k1uKTU3tizFrPjIvkdjNrU=
X-Google-Smtp-Source: AHgI3IZZrBv5NeGvcuGZ0w/0Qa2SrCaJsQ1Xaf1iPZ8VgvYJXUmG1AfVoFMwBgt7TSmCc9ueIEfwUw==
X-Received: by 2002:a63:2586:: with SMTP id l128mr1869676pgl.104.1550178148885;
        Thu, 14 Feb 2019 13:02:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n25sm5175607pfi.173.2019.02.14.13.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 13:02:27 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:02:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/50] 4.20.9-stable review
Message-ID: <20190214210226.GA23386@roeck-us.net>
References: <20190213183655.747168774@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 07:38:05PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.9 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 15 18:36:30 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 343 pass: 330 fail: 13
Failed tests: 
	sh:rts7751r2dplus_defconfig:initrd 
	sh:rts7751r2dplus_defconfig:ata:rootfs 
	sh:rts7751r2dplus_defconfig:mmc:rootfs 
	sh:rts7751r2dplus_defconfig:usb:rootfs 
	sh:rts7751r2dplus_defconfig:usb-hub:rootfs 
	sh:rts7751r2dplus_defconfig:usb-ohci:rootfs 
	sh:rts7751r2dplus_defconfig:usb-ehci:rootfs 
	sh:rts7751r2dplus_defconfig:usb-xhci:rootfs 
	sh:rts7751r2dplus_defconfig:usb-uas-ehci:rootfs 
	sh:rts7751r2dplus_defconfig:usb-uas-xhci:rootfs 
	sh:rts7751r2dplus_defconfig:scsi[53C810]:rootfs 
	sh:rts7751r2dplus_defconfig:scsi[53C895A]:rootfs
	sh:rts7751r2dplus_defconfig:scsi[FUSION]:rootfs

This failure gave me a bit of trouble. It is similar to the failure observed
earlier with v4.4.y, but changing the C compiler version did not help (I
tried 8.2.0 and 5.5.0), and changing the qemu version did not help either.
Bisect points to commit 31e8a058e1f ("Revert "ext4: use ext4_write_inode()
when fsyncing w/o a journal") as the culprit. No idea why that would be
the case, but I repeated the bisect twice with the same results, and
reverting that revert indeed fixes the problem. This is weird since
one of the failing tests doesn't even mount a file system but boots
from initrd. Go figure. Bisect results are below.

Guenter

---
# bad: [f4a86d6d2a0bdead7cf98d552481367e6356ef28] Linux 4.20.9-rc1
# good: [0788acb1a3ed1589da1768ba64b1e5c76e8cb661] Linux 4.20.8
git bisect start 'HEAD' 'v4.20.8'
# good: [df6033ca3341635d8f529d6cdb6d37257df6f783] MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled
git bisect good df6033ca3341635d8f529d6cdb6d37257df6f783
# good: [da33f30a55d08758a63de90038344f956252ea8f] drm/rockchip: rgb: update SPDX license identifier
git bisect good da33f30a55d08758a63de90038344f956252ea8f
# good: [3ef454cd518997a8447080fb01743aaa4d4de8ae] xfrm: Make set-mark default behavior backward compatible
git bisect good 3ef454cd518997a8447080fb01743aaa4d4de8ae
# bad: [b442f17368f050887aae5d525b4dd0e146440f94] libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()
git bisect bad b442f17368f050887aae5d525b4dd0e146440f94
# bad: [31e8a058e1f9aa32254f64a9643853062141895a] Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"
git bisect bad 31e8a058e1f9aa32254f64a9643853062141895a
# good: [0bc4dd12c3196b01d2123f95bb1c949e5eebe483] drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BIOSen
git bisect good 0bc4dd12c3196b01d2123f95bb1c949e5eebe483
# first bad commit: [31e8a058e1f9aa32254f64a9643853062141895a] Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"
