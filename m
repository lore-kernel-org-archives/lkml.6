Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC17C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EBB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544550081;
	bh=wZpVqfwtzpeydOVcZT8MnZLBdCVQBBsefPTJrmD04yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pr2GsiOX01VjrbhBR9G3OUAP9g/aZvcBVAsMVJi18rvkSQKCLymq8Iav1SDWaA/A0
	 +PBK0NgHLg5f82Hcv61w3ddOZI7LiaRIJa1YLyCIVjJr371HkSVoMVg5TWqSckp0m3
	 enJfEjloiU/XdQisRgj8lxA9hwGb/+2zfo31Yb6Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EBB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeLKRlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbeLKRlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:41:19 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073692086D;
        Tue, 11 Dec 2018 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544550079;
        bh=wZpVqfwtzpeydOVcZT8MnZLBdCVQBBsefPTJrmD04yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wYRahKRpiWhhtCg4kbgDGVeLHJe8dFYxnm5S82zfI9vRR0r3zLS/F8IJbZD2vNbCj
         iAySfI23Znob8UEcPq2JK4IlypxOgAslDjd2wZbBGa6tI+W6oGemasRxH/ZUhC9y1j
         Vqe/qaJxDf41dW3W7SE4IzsHKRCrYMHU/lWGJHlc=
Date:   Tue, 11 Dec 2018 09:41:17 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org
Subject: Re: [BUG BISECT next] Files cannot be opened after "fsverity: Move
 verity status check to fsverity_file_open"
Message-ID: <20181211174116.GB221175@gmail.com>
References: <CAJKOXPdNS+Qs6t1GwrgYhWT5EbtORJwYMzSrDPf8oAxv7ndNBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPdNS+Qs6t1GwrgYhWT5EbtORJwYMzSrDPf8oAxv7ndNBg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 03:15:53PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> Bisect from today's next pointed me to:
> commit 4de97efb578a094e8fbf279522d41eb9ece1e3e0
> Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> Date:   Sat Dec 8 12:21:43 2018 +0530
>     fsverity: Move verity status check to fsverity_file_open
> 
> as a reason of "Operation not supported" when reading any file from
> mounted ext4fs (from SD card). Rootfs from nfsroot works but reading
> from /home with ext4fs fails.
> 
> Mounts:
> 192.168.1.10:/srv/nfs/odroidhc1 on / type nfs4
> (rw,relatime,vers=4.0,rsize=131072,wsize=131072,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.1.12,local_lock=none,addr=192.168.1.10)
> /dev/mmcblk0p2 on /home type ext4 (rw,relatime)
> 
> Configuration:
> 1. Arch ARM Linux
> 2. exynos_defconfig
>   - All my Odroid boards (ARMv7, Exynos)
>     Systemd: v239, v238
> 3. All boards boot from TFTP with NFS root (NFSv4)
> No specific errors in boot log:
> https://krzk.eu/#/builders/21/builds/1034/steps/12/logs/serial0
> 
> Let me know if you need any more data.
> 
> Best regards,
> Krzysztof

Thanks Krzysztof.  Ted, this is the same bug I pointed out in my review of this
patch yesterday (https://patchwork.kernel.org/patch/10719197/#22371523).  Can
you fix or revert the two broken patches?  Thanks,

- Eric
