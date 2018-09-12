Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75D3C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5975320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5975320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeILIor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:44:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36276 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeILIor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:44:47 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fzw2i-0004ez-AX
        for linux-kernel@vger.kernel.org; Wed, 12 Sep 2018 03:42:16 +0000
Received: by mail-pg1-f199.google.com with SMTP id r130-v6so335973pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 20:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=aXxNqNspj+KDKZoHbbhXEJI2ZTufxtHMGihZ6WM602A=;
        b=t+3G5+XXItWtJu/NqWD4Zay4lGJaoV17eE94YsUoQu8xdTL6Z1FwfjHXo3wyuCbj7O
         fCAC2kcrLRgFgJWWOE3+CDN7uyGP8FvOQLxOeVPq7QMoOwp7tqzCHnfpgoeVfMkcFax9
         Cg0PnbHhBUpRj69C58vH4U6KuV4dTKNhVyDQGofolAF+u5skdIVjjrVxlxtdPsvEbUCx
         lSOso9rgbyeokDYC3ARJD6/972ZN0LK2V/SWhIJDz+eexIZ91yu/89/hLJPWr+cWZuxo
         Z32rX+zGTv1bH0eGNl2OnjvQ0K81jAve/lChDXWgXriqxB0UvApJZcqkixZwui2XoUhF
         5ndQ==
X-Gm-Message-State: APzg51ByuM/nDZtXpRyXOsABpBKoSPHntS/X0HbDQ7MRy4NezQCTre6A
        EiOPH+aUIQ14NP0lB80dwmKfdBvJi2atCNIUe63WPbx138B0dbwPBsbnRIlUceHlaDgAUqTAhw5
        b8p62qXxSEPpcNc5XQLcHPhPHk/MAg5evSL3dgZUOjg==
X-Received: by 2002:a62:8d16:: with SMTP id z22-v6mr33163146pfd.181.1536723734767;
        Tue, 11 Sep 2018 20:42:14 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdYEVcqQjiFHhioIwwwgTf9ZY+/1qKto0bDnY9/lKQ8AENvzh36Gw/+JEvtb/YroRUMaEhnPRg==
X-Received: by 2002:a62:8d16:: with SMTP id z22-v6mr33163124pfd.181.1536723734244;
        Tue, 11 Sep 2018 20:42:14 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id f13-v6sm22391225pgs.92.2018.09.11.20.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 20:42:13 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Regression caused by commit 7bb05b85bc2d ("r8169: don't use MSI-X on
 RTL8106e")
Message-Id: <5D685053-1A33-4553-8678-A50C542466FD@canonical.com>
Date:   Wed, 12 Sep 2018 11:42:10 +0800
Cc:     Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     jian-hong@endlessm.com, Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian-Hong,

There's a Dell machine with RTL8106e stops to work after S3 since the  
commit introduced.
So I am wondering if it's possible to revert the commit and use  
DMI/subsystem id based quirk table?

It's because of commit bc976233a872 ("genirq/msi, x86/vector: Prevent  
reservation mode for non maskable MSI") cleared the reservation mode, and I  
can see this after S3:

[   94.872838] do_IRQ: 3.33 No irq handler for vector

If the device uses MSI-X instead of MSI, the issue doesn't happen because  
of reservation mode.


Hi Thomas,

Is it something should be handled by x86 BIOS? Because I don't see this  
issue when I use Suspend-to-Idle, which doesn't use BIOS to do suspend.

Kai-Heng

