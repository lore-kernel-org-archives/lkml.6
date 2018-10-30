Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D39C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A472080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A472080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbeJ3RtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:49:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:41666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbeJ3RtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:49:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EAD1AE92;
        Tue, 30 Oct 2018 08:56:43 +0000 (UTC)
Message-ID: <1540889786.12349.9.camel@suse.com>
Subject: Re: scsi_set_medium_removal timeout issue
From:   Oliver Neukum <oneukum@suse.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Cc:     "usb-storage@lists.one-eyed-alien.net" 
        <usb-storage@lists.one-eyed-alien.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Date:   Tue, 30 Oct 2018 09:56:26 +0100
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED1F19F1CF@dggemm526-mbx.china.huawei.com>
References: <678F3D1BB717D949B966B68EAEB446ED1F19F1CF@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2018-10-30 at 08:28 +0000,  Zengtao (B)  wrote:
> Hi 

> For the issue itself, there is my observation:
> In the step 4, the Host will issue an PREVENT_ALLOW_MEDIUM_REMOVAL scsi command.
> and and timeout happens due to the device 's very slow fsg_lun_fsync_sub.
> I found there are two methods to workaround the issue: 
> 1. Change the timeout value of host scsi command PREVENT_ALLOW_MEDIUM_REMOVAL to
> to about 60 seconds from 10 seconds.

That is near useless, because the gadget can be used with other
systems.

> 2. Remove the fsg_lun_fsync_sub in the device's Mass storage gadget driver.

It exists for a reason. The blocks have to be on the medium.
It seems to me that your gadget just allows too many dirty pages in the
cache.

	Regards
		Oliver

