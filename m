Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515A9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D525208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D525208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeJPN1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:27:52 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57146 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeJPN1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:27:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id B5F6927FEE;
        Tue, 16 Oct 2018 01:39:07 -0400 (EDT)
Date:   Tue, 16 Oct 2018 16:39:07 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Hannes Reinecke <hare@suse.de>
cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] esp_scsi: De-duplicate PIO routines
In-Reply-To: <2b48c925-73f0-0ca0-2f3c-3c35d90010ba@suse.de>
Message-ID: <alpine.LNX.2.21.1810161611150.130@nippy.intranet>
References: <cover.1539497520.git.fthain@telegraphics.com.au> <d5fe773ea8c922631836dad2ef2dbb952672c7c7.1539497520.git.fthain@telegraphics.com.au> <35ac9f31-7068-ab93-4629-363ee0bb4c70@suse.de> <alpine.LNX.2.21.1810151717520.10@nippy.intranet>
 <2b48c925-73f0-0ca0-2f3c-3c35d90010ba@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Hannes Reinecke wrote:

> 
> However, the function declaration really is a worry, as the actual function
> body only exists when the config option is enabled.
> So either add a dummy function or surround the function declaration by
> CONFIG_ESP_PIO.
> Otherwise I think Dan Carpenter and the likes are guaranteed to send you a
> nice mail complaining about this ...
> 

Perhaps I've misunderstood your concern here. Is it a problem that 
esp_scsi.ko may or may not export the function, depending on .config?

For example, if esp_scsi.ko came from a build with CONFIG_SUN3X_ESP=y && 
!CONFIG_SCSI_ZORRO_ESP && !CONFIG_SCSI_MAC_ESP, then it would export no 
esp_send_pio_cmd() symbol.

A dummy function (mentioned above) might then avoid a link error from 
"modprobe zorro_esp" or "modprobe mac_esp" in this scenario. (The modules 
would load but fail to work properly.)

This seems a bit too contrived so I'll post v3 for you to consider.

-- 
