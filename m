Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Fo0AFuKAG1tCNgAAmS7hNA
	; Sat, 09 Jun 2018 07:25:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 31D94607E7; Sat,  9 Jun 2018 07:25:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEhW9p3/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A9F18606FA;
	Sat,  9 Jun 2018 07:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9F18606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeFIHZT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 03:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752858AbeFIHZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 03:25:18 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F204920874;
        Sat,  9 Jun 2018 07:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528529117;
        bh=RM2GeqTmwB0WxH+d4JM/Ta868YyVueCAL/9fmKplqwI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEhW9p3/OFjeBrF1xwN2PRzmprMYaWfUsOdpuyPv7Le+2yIK2YG2uHsMK3LMd5ioS
         jPp7rOyp2k+GDBuhfAnseyUi0Eb75S2pCf7z3oX60wxzcVOG4OWoQZIjiFAcyTt1vz
         SMpNPivASkQcY4ZVw/RbG0WLjZRYesvV6hFbj4ZQ=
Date: Sat, 9 Jun 2018 09:24:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sayali Lokhande <sayalil@codeaurora.org>
Cc: subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, linux-scsi@vger.kernel.org,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 3/3] scsi: ufs: Add sysfs support for ufs provision
Message-ID: <20180609072454.GH24148@kroah.com>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
 <1528455990-24572-4-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528455990-24572-4-git-send-email-sayalil@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 04:36:30PM +0530, Sayali Lokhande wrote:
> Add sysfs support to trigger ufs provisioning at runtime.
> Usage : echo <desc_buf> > /sys/bus/platform/drivers/*/
> 	config_descriptor/ufs_provision
> To check provisioning status:
> cat /sys/bus/platform/drivers/*/config_descriptor/ufs_provision
> 1- > Success (Reboot device to check updated provisioning)
> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  Documentation/ABI/testing/sysfs-driver-ufs |  16 ++++
>  drivers/scsi/ufs/ufs-sysfs.c               |  25 ++++++
>  drivers/scsi/ufs/ufs.h                     |   2 +
>  drivers/scsi/ufs/ufshcd.c                  | 128 +++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h                  |   5 ++
>  5 files changed, 176 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
> index 016724e..43419b5 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -883,3 +883,19 @@ Contact:	Subhash Jadavani <subhashj@codeaurora.org>
>  Description:	This entry shows the target state of an UFS UIC link
>  		for the chosen system power management level.
>  		The file is read only.
> +
> +What:		/sys/bus/platform/drivers/ufshcd/*/config_descriptor/ufs_provision
> +Date:		February 2018
> +Contact:	Sayali Lokhande <sayalil@codeaurora.org>
> +Description:	This file shows the status of runtime ufs provisioning.
> +		This can be used to provision ufs device if bConfigDescrLock is 0.
> +		Configuration buffer needs to be written in space separated format
> +		specificied as:
> +		echo <bNumberLU> <bBootEnable> <bDescrAccessEn> <bInitPowerMode>
> +		<bHighPriorityLUN> <bSecureRemovalType> <bInitActiveICCLevel>
> +		<wPeriodicRTCUpdate> <bConfigDescrLock> <LUNum> <bLUEnable>
> +		<bBootLunID> <size_in_kb> <bDataReliability> <bLUWriteProtect>
> +		<bMemoryType> <bLogicalBlockSize> <bProvisioningType>
> +		<wContextCapabilities> > ufs_provision

That's crazy big, please use configfs for this if you really want to
"provision" hardware with a new api.  That is what configfs was created
for, do not abuse sysfs like this, it is not a "single" value.

thanks,

greg k-h
