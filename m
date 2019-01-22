Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C175C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A35621019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548155238;
	bh=PN9qyb7Tga6APWiAMsAzlzUCzqb/OG4ULtvSOZ/biqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mwTcYf6xLVKYmFpqiY8HS1cBZE4nHybK6E1oyHnMNWaLkrkwYiw8ABeJAMCLpuh5p
	 YAkbxR389cWgILMNIxBLaFW/r7iz7GVfXHGpj4oSl7147MSEPDyJZWs1L0vIe+ZAsc
	 QDgFapuSV18SlwBcCPlL+jtA2Y6FnMjU6n4CCntA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfAVLHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:07:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfAVLHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:07:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9C6020879;
        Tue, 22 Jan 2019 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548155235;
        bh=PN9qyb7Tga6APWiAMsAzlzUCzqb/OG4ULtvSOZ/biqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APYQNW2TCAS07fUZjRVRG4pu2wNlaISegCHTqDh91PIHUJQg7LfWFuSGh/Z1Jeofu
         Wt/MXh8K0VzV+Mj5LBzXu+lGpupKtU/Nf/07a3Pz7PMJHOnPGI8t/CbVVlVfwk9fj8
         gF45lIB6Kfdu3pfmbbI+FCyeF3wxwMVx29cDQ74k=
Date:   Tue, 22 Jan 2019 12:07:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rkir@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drivers: platform: goldfish:
 goldfish_address_space: add a driver
Message-ID: <20190122110712.GA1004@kroah.com>
References: <20190109021112.5836-1-rkir@google.com>
 <20190109021112.5836-2-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109021112.5836-2-rkir@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 06:11:11PM -0800, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> A driver for the Goldfish Android emulator that occupies
> address space to use it with the memory sharing device
> on the QEMU side. The memory sharding device allocates
> subranges and populate them with actual RAM.
> This allows sharing host's memory with the guest.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> Changes in v3:
>  - No changes.
> 
> Changes in v2:
>  - Removed WARN_ON.
>  - Moved to drivers/platform/goldfish (from drivers/misc).
> 
>  drivers/platform/goldfish/Kconfig             |   9 +
>  drivers/platform/goldfish/Makefile            |   1 +
>  .../goldfish/goldfish_address_space.c         | 666 ++++++++++++++++++
>  .../linux/goldfish/goldfish_address_space.h   |  27 +
>  4 files changed, 703 insertions(+)
>  create mode 100644 drivers/platform/goldfish/goldfish_address_space.c
>  create mode 100644 include/uapi/linux/goldfish/goldfish_address_space.h
> 
> diff --git a/drivers/platform/goldfish/Kconfig b/drivers/platform/goldfish/Kconfig
> index 74fdfa68d1f2..60ecec4a3c59 100644
> --- a/drivers/platform/goldfish/Kconfig
> +++ b/drivers/platform/goldfish/Kconfig
> @@ -16,4 +16,13 @@ config GOLDFISH_PIPE
>  	  This is a virtual device to drive the QEMU pipe interface used by
>  	  the Goldfish Android Virtual Device.
>  
> +config GOLDFISH_ADDRESS_SPACE
> +	tristate "A Goldfish driver that talks to the memory sharing device in QEMU"
> +	depends on PCI
> +	depends on GOLDFISH
> +	help
> +	  A Goldfish driver that allocates address space ranges in the guest to
> +	  populate them later in the host. This allows sharing host's memory
> +	  with the guest.

How does QEMU do this today?  There isn't a virtio or some other virtual
memory device that allows memory regions to be shared?  I can't believe
that there isn't one yet.  If not, then this should be some kind of
"generic" QEMU memory device, not a "goldfish" specific one, right?

Please work with the QEMU developers on this, I need their ack before I
can take something like this.

thanks,

greg k-h
