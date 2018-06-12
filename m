Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C4FF3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18A02086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLTYh0Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18A02086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934956AbeFLWko (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:40:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55443 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934418AbeFLWkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:40:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so1406466wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 15:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hx+vH43n5PZp+7APDmcf4yYkJPhesrm9wSMWB7GYEHU=;
        b=OLTYh0Ca+AOx3QiLpvNr97g9V/xMO/L1Dgs+bzG6y2BwFDSql/MCJSUysiqRSqbJtF
         zelOWvjBdfrr//3u/Wfyzzs5p6bCTWTFTTRc4Il4k9G0U5V+WfmhVxBkGCbwYcM/iJqM
         P7Rc/BpGPOLOrZ1uqNZlpe/7dFb+Bv5NtfCdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hx+vH43n5PZp+7APDmcf4yYkJPhesrm9wSMWB7GYEHU=;
        b=GlrRjgcnnXIeSHtrOPmUehhQjiXNcxx6h7+EDJ88NQ09FSiwMdVgeEKyCFL8txDCCO
         1sF7iHYiIB6NGU326b1uFf3B3+iR4dIr0tWRvfPaNdqjS60qeR2qQmCYgg1QEoK9JkmJ
         0mNNjWA9G34/4iPROrJHUAhnHPrrFCaZrdMfV8ig293jiAZCtAzz7PG1kbhYcTkDnBfx
         FRdvSeuidYzDi2Oe3CxIjIFecARilF5p4jDO9p/SCF6V/w+YuoCTAuEmZh7CzPaB7X0E
         JfcUIEkhQieo8Sr9SLTuR2BlgyLhL7a0f9XWGyd9te6LYyDhtB3JekoabEyxwq7yIEv/
         2fiw==
X-Gm-Message-State: APt69E3ag5iExZ49Hi96wA8I83k0FIllnTWYbUsHwww37c52AeZp4MTT
        UKq+GNDIrTa/CD4d4wD6V4WI3HqWM2ibBVTailHHUA==
X-Google-Smtp-Source: ADUXVKLCj8hXGyqXJlcd2NZ7ATlt3LW0LtN+7/5up1MD9y5gtGNlVb01gvsKDcU74eiJXSkPErt7yYCf6lfIub3Ugwo=
X-Received: by 2002:a1c:3c4:: with SMTP id 187-v6mr1681283wmd.96.1528843242241;
 Tue, 12 Jun 2018 15:40:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8ac3:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 15:40:41
 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 12 Jun 2018 15:40:41 -0700
Message-ID: <CALAqxLVCpyKzGJPVtBuipnZbGbDC_Z0rPBrn-J2mkMsQsSvdtA@mail.gmail.com>
Subject: REGRESSION?: debugfs: inode: debugfs_create_dir uses mode permission
 from parent
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,
  I noticed recently that linus/master (plus patches) stopped booting
to UI on HiKey960, and I bisected the issue down to:
92170b62f1c1 ("debugfs: inode: debugfs_create_dir uses mode permission
from parent")

On the HiKey960 board, we mount debugfs via:
   mount debugfs /sys/kernel/debug /sys/kernel/debug mode=755

But since the change, it seems most of the nodes in /sys/kernel/debug
are: drwx------

Which ends up breaking the egl library, keeping it from loading.

This seems to be the expected behavior of the patch, but I'm surprised
the mode override is now ignored. It seems like the potential fix here
would be to set the /sys/kernel/debug dir to 755 prior to mounting? Or
is there some other advised solution?

thanks
-john
