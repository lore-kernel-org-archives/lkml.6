Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CE506C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEDB208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEDB208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936051AbeFMVZR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:25:17 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:51405 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935846AbeFMVZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:25:15 -0400
Received: from [148.252.241.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fTDGQ-0001T1-V7; Wed, 13 Jun 2018 22:25:11 +0100
Message-ID: <1528925110.2289.175.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 128/268] scsi: sd: Keep disk read-only when
 re-reading partition
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Jeremy Cline <jeremy@jcline.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     stable@vger.kernel.org, Li Ning <lining916740672@icloud.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 13 Jun 2018 22:25:10 +0100
In-Reply-To: <20180528100216.627623125@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100216.627623125@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 12:01 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jeremy Cline <jeremy@jcline.org>
> 
> [ Upstream commit 20bd1d026aacc5399464f8328f305985c493cde3 ]
> 
> If the read-only flag is true on a SCSI disk, re-reading the partition
> table sets the flag back to false.
> 
> To observe this bug, you can run:
> 
> 1. blockdev --setro /dev/sda
> 2. blockdev --rereadpt /dev/sda
> 3. blockdev --getro /dev/sda
> 
> This commit reads the disk's old state and combines it with the device
> disk-reported state rather than unconditionally marking it as RW.

It seems to me that this change is likely to cause a regression: if a
SCSI device switches from read-only to read-write state then a
subsequent rescan won't automatically change the block device to read-
write state.  The administrator will have to use the blockdev command
too.

Even if this change in behaviour is acceptable, this commit does not
implement it consistently.  The function starts by clearing the ro flag
and this commit only changes one of the three exit paths to preserve
it.  (The log message about Write Protect status also reports the
underlying SCSI device flag and not the combined ro flag, but maybe
that was intentional.)

I think this commit should be reverted, both in stable and upstream.  A
proper fix would involve splitting the ro flag into two flags—one
controlled by user-space and one read from the device—with the
effective read-only status being the logical-or of those two.

Ben.

> Reported-by: Li Ning <lining916740672@icloud.com>
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/scsi/sd.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2395,6 +2395,7 @@ sd_read_write_protect_flag(struct scsi_d
>  	int res;
>  	struct scsi_device *sdp = sdkp->device;
>  	struct scsi_mode_data data;
> +	int disk_ro = get_disk_ro(sdkp->disk);
>  	int old_wp = sdkp->write_prot;
>  
>  	set_disk_ro(sdkp->disk, 0);
> @@ -2435,7 +2436,7 @@ sd_read_write_protect_flag(struct scsi_d
>  			  "Test WP failed, assume Write Enabled\n");
>  	} else {
>  		sdkp->write_prot = ((data.device_specific & 0x80) != 0);
> -		set_disk_ro(sdkp->disk, sdkp->write_prot);
> +		set_disk_ro(sdkp->disk, sdkp->write_prot || disk_ro);
>  		if (sdkp->first_scan || old_wp != sdkp->write_prot) {
>  			sd_printk(KERN_NOTICE, sdkp, "Write Protect is %s\n",
> 				  sdkp->write_prot ? "on" : "off");

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
