Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CF8C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D74120849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544537769;
	bh=63Jpb+FCl42cdiA8bmbAmfKW9W8CJNmW8I58R7aZWr0=;
	h=From:Date:Subject:To:List-ID:From;
	b=2AELvFlLWEdkkX5g+KANPwfuki5paAOhsA8dayHL2OEz80skldBlMLeFk1YoNqmcl
	 S1kmLFEsIZidCXOzc5Q4+4fLIUy00gq9gj9uld0VNkMm3f1KRGNwUC91JipgMMe6EP
	 VrOqxCy8wA+kC2H21T0KKJXFXEf+yH1azrxRV46Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D74120849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLKOQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:16:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeLKOQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:16:07 -0500
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9774320851;
        Tue, 11 Dec 2018 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544537766;
        bh=63Jpb+FCl42cdiA8bmbAmfKW9W8CJNmW8I58R7aZWr0=;
        h=From:Date:Subject:To:From;
        b=iZAJEKTTqg73XFCFVfAvRYMGPfbvNTldkwLcYUdUPfFRtHiaQaPySEiZs3dFH6nR8
         0KHDzj6OCaEeQOW3qpyf2Ial4rkst1x8lkpMsGiSD3U12wq8GAP/KGOLoFzZkQZoJg
         9qrN3Sl+FJNhfhP5LXBZHnrbt+rCxF05I+1Hz4XU=
Received: by mail-lj1-f170.google.com with SMTP id x85-v6so13120822ljb.2;
        Tue, 11 Dec 2018 06:16:06 -0800 (PST)
X-Gm-Message-State: AA+aEWaOdXpqSPGnvZzQn4DomeWyU04MndwwnmRjSzoPbwT5xe8qyhoT
        gLytUuADdiY+sV5DBKNDFBB8pKTXxt31xKB5vQw=
X-Google-Smtp-Source: AFSGD/Wic1p8neykUE5eohK1jq+IzM8SuNX/0Veqev4wtSbWMXCHbC79B7Fa9g3Qr+9amTRKeM9vmpAM4ISfKTjr2CU=
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr10897043ljj.161.1544537764710;
 Tue, 11 Dec 2018 06:16:04 -0800 (PST)
MIME-Version: 1.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 11 Dec 2018 15:15:53 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdNS+Qs6t1GwrgYhWT5EbtORJwYMzSrDPf8oAxv7ndNBg@mail.gmail.com>
Message-ID: <CAJKOXPdNS+Qs6t1GwrgYhWT5EbtORJwYMzSrDPf8oAxv7ndNBg@mail.gmail.com>
Subject: [BUG BISECT next] Files cannot be opened after "fsverity: Move verity
 status check to fsverity_file_open"
To:     Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Bisect from today's next pointed me to:
commit 4de97efb578a094e8fbf279522d41eb9ece1e3e0
Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Date:   Sat Dec 8 12:21:43 2018 +0530
    fsverity: Move verity status check to fsverity_file_open

as a reason of "Operation not supported" when reading any file from
mounted ext4fs (from SD card). Rootfs from nfsroot works but reading
from /home with ext4fs fails.

Mounts:
192.168.1.10:/srv/nfs/odroidhc1 on / type nfs4
(rw,relatime,vers=4.0,rsize=131072,wsize=131072,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.1.12,local_lock=none,addr=192.168.1.10)
/dev/mmcblk0p2 on /home type ext4 (rw,relatime)

Configuration:
1. Arch ARM Linux
2. exynos_defconfig
  - All my Odroid boards (ARMv7, Exynos)
    Systemd: v239, v238
3. All boards boot from TFTP with NFS root (NFSv4)
No specific errors in boot log:
https://krzk.eu/#/builders/21/builds/1034/steps/12/logs/serial0

Let me know if you need any more data.

Best regards,
Krzysztof
