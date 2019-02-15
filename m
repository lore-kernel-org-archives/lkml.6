Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1D7C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8D421925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND7qq1mE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfBORWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:22:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45915 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBORWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:22:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so5083200pgc.12;
        Fri, 15 Feb 2019 09:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=waIhOJmT+hnauAJYG02v2FixnoZ2MiMnecp7+uGLDeY=;
        b=ND7qq1mETm/p39CP3uFhU4Jh5yxipGStABhTbIvycZY0ZgPesXIL6GJBQNpGlok095
         HGkfJO3ypvSJyFiOQIu+65CRA7kG8V6VL3M8yDrtkM5KdqrKeHsyHz1i6402Oj5cwly8
         FGRaoFO4bjsa/ID95pYoWnejIkHGdeKlW5/xTldmvM23XDCDYhdAsm7WEYfFkzQhxzjs
         1v4+FNWqWqcwm4lebz3WzT3lt8UZjM3Er8i5e1ow5NckP7OJzMsyMydnCQ2qv6FrfIL3
         kFrQGMSp7T92EcnD7jDX/tcEH8WRX9KnygxQt7O5FU9zhzHFQYiAEKFCfbDvcOzW1wrT
         Gwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=waIhOJmT+hnauAJYG02v2FixnoZ2MiMnecp7+uGLDeY=;
        b=HjFkGZsGd1M2iM+C/p0VT8nEl+i/F+7GEwatifS4WE447LXHBdienynL3cHNAdKH+H
         JNtP7Qucs2rxhzbbtv/akbSlHi/5KHhdvdJXPr1LBWL4iMGnIIL4vBMblNlyPDGAg+9R
         AN3h7yU00CZJ474b0QiawmdYcdir2Og/axuJHWbQakEz2TXNoZbuGm0H2lTm3YTc76OL
         rr32MuA5KQETJZqtTmYDcuPIyF1dC0W0o5Vy4f5lt/mGFsIB5ah9ulTC9HbU11yCESQe
         KpW2AFLhWTukRh6oyV2Z9un5Sx30Hg4DCCAXJID76A8dF9rQtNYbCF6G5x6D2RYUjN1Y
         Pv1Q==
X-Gm-Message-State: AHQUAuYr18+CojeAWRld+yPFBdDbXjTkhajbOik6MTbM8VgvRp5fZCgZ
        R1qNf+j89zi+j7/+bAeT2+k=
X-Google-Smtp-Source: AHgI3IbAJZn3cJIMZAU9yQXfL+1jlWpn4TusK/NGXNCxmH2Dd3DvVlzqWbuNSXh1HjyZxiOeQ1oHBg==
X-Received: by 2002:aa7:81d0:: with SMTP id c16mr10752681pfn.153.1550251344289;
        Fri, 15 Feb 2019 09:22:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v75sm10559963pfa.164.2019.02.15.09.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 09:22:22 -0800 (PST)
Date:   Fri, 15 Feb 2019 09:22:21 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/50] 4.20.9-stable review
Message-ID: <20190215172221.GA21472@roeck-us.net>
References: <20190213183655.747168774@linuxfoundation.org>
 <20190214210226.GA23386@roeck-us.net>
 <20190215065622.GB14473@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215065622.GB14473@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 07:56:22AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 14, 2019 at 01:02:26PM -0800, Guenter Roeck wrote:
> > On Wed, Feb 13, 2019 at 07:38:05PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.20.9 release.
> > > There are 50 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Fri Feb 15 18:36:30 UTC 2019.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Build results:
> > 	total: 159 pass: 159 fail: 0
> > Qemu test results:
> > 	total: 343 pass: 330 fail: 13
> > Failed tests: 
> > 	sh:rts7751r2dplus_defconfig:initrd 
> > 	sh:rts7751r2dplus_defconfig:ata:rootfs 
> > 	sh:rts7751r2dplus_defconfig:mmc:rootfs 
> > 	sh:rts7751r2dplus_defconfig:usb:rootfs 
> > 	sh:rts7751r2dplus_defconfig:usb-hub:rootfs 
> > 	sh:rts7751r2dplus_defconfig:usb-ohci:rootfs 
> > 	sh:rts7751r2dplus_defconfig:usb-ehci:rootfs 
> > 	sh:rts7751r2dplus_defconfig:usb-xhci:rootfs 
> > 	sh:rts7751r2dplus_defconfig:usb-uas-ehci:rootfs 
> > 	sh:rts7751r2dplus_defconfig:usb-uas-xhci:rootfs 
> > 	sh:rts7751r2dplus_defconfig:scsi[53C810]:rootfs 
> > 	sh:rts7751r2dplus_defconfig:scsi[53C895A]:rootfs
> > 	sh:rts7751r2dplus_defconfig:scsi[FUSION]:rootfs
> > 
> > This failure gave me a bit of trouble. It is similar to the failure observed
> > earlier with v4.4.y, but changing the C compiler version did not help (I
> > tried 8.2.0 and 5.5.0), and changing the qemu version did not help either.
> > Bisect points to commit 31e8a058e1f ("Revert "ext4: use ext4_write_inode()
> > when fsyncing w/o a journal") as the culprit. No idea why that would be
> > the case, but I repeated the bisect twice with the same results, and
> > reverting that revert indeed fixes the problem. This is weird since
> > one of the failing tests doesn't even mount a file system but boots
> > from initrd. Go figure. Bisect results are below.
> > 
> > Guenter
> > 
> > ---
> > # bad: [f4a86d6d2a0bdead7cf98d552481367e6356ef28] Linux 4.20.9-rc1
> > # good: [0788acb1a3ed1589da1768ba64b1e5c76e8cb661] Linux 4.20.8
> > git bisect start 'HEAD' 'v4.20.8'
> > # good: [df6033ca3341635d8f529d6cdb6d37257df6f783] MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled
> > git bisect good df6033ca3341635d8f529d6cdb6d37257df6f783
> > # good: [da33f30a55d08758a63de90038344f956252ea8f] drm/rockchip: rgb: update SPDX license identifier
> > git bisect good da33f30a55d08758a63de90038344f956252ea8f
> > # good: [3ef454cd518997a8447080fb01743aaa4d4de8ae] xfrm: Make set-mark default behavior backward compatible
> > git bisect good 3ef454cd518997a8447080fb01743aaa4d4de8ae
> > # bad: [b442f17368f050887aae5d525b4dd0e146440f94] libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()
> > git bisect bad b442f17368f050887aae5d525b4dd0e146440f94
> > # bad: [31e8a058e1f9aa32254f64a9643853062141895a] Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"
> > git bisect bad 31e8a058e1f9aa32254f64a9643853062141895a
> > # good: [0bc4dd12c3196b01d2123f95bb1c949e5eebe483] drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BIOSen
> > git bisect good 0bc4dd12c3196b01d2123f95bb1c949e5eebe483
> > # first bad commit: [31e8a058e1f9aa32254f64a9643853062141895a] Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"
> 
> That's really odd, given that this is only showing up in sh and not in
> any of the other releases.  I'll blame gcc for this one :(
> 
I suspect it may be a code alignment issue, but who knows. The problem
is gone in v4.20.10, meaning the revert of "exec: load_script: don't
blindly truncate shebang string" "fixed" the problem as well.

Guenter
