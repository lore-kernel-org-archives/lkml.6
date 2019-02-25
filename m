Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48F620643
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfBYOtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:49:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42729 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfBYOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:49:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so4590102pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 06:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mMDQumBGVXpA3A1u4UOXH2tePQ2H7YXxmyd0MJ93a4Q=;
        b=FeDDEMSQxANdvGP25fOT3dUU7Vgi40O3DSA/8aelDcdJF09mV6KXCuiSxnnSfSjZmX
         rTSXAljc0WE6++WH6CHmXlKmSILfY7uPFwo4HsUNVwj/d8VzHQbuZfgmZffcmbECVTLe
         fEASjglosxLaYwAjifwt6uvl6/wkSsaTwd2MBdOL5fI0axdUGaHYp/YeFUQLgmSzC+u4
         dy551Z1KrA+0Gg3NlstEd0DVtwlmelZviJkS15Qni1TtzwdDFYOCTboej/Dk6mfH7NHn
         HjZ3ah7jLzp96h09Q3QEMx1SqdiSu8fC3k2WUIVyQCM4g36JJy072TwptFi/d+5WW0mo
         go4w==
X-Gm-Message-State: AHQUAub+KrJ5fxr4g8+XkpRk65rXHGk22yfSIfO+OMCKiw5bhXolutBv
        4cJ3BKdH4hlIoVcbf7D6BDIHdNHb
X-Google-Smtp-Source: AHgI3IYJhe/DuxMP/ysKFcjFWRt9pk/xQrEtvzyMHX99Heut/bx18rhPswX/zVKvklhFpc9LT2NAMA==
X-Received: by 2002:a63:144:: with SMTP id 65mr19648980pgb.38.1551106146952;
        Mon, 25 Feb 2019 06:49:06 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id o5sm27955002pfi.118.2019.02.25.06.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 06:49:05 -0800 (PST)
Subject: Re: [PATCH] nvmet: disable direct I/O when unavailable
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Max Gurtovoy <maxg@mellanox.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
References: <20190221182234.22345-1-jthumshirn@suse.de>
 <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
 <9d8e96de-d68d-8961-21e8-4cb8e79b4a08@mellanox.com>
 <2185e4e5-086a-d0c2-0fee-a7a5c98267bb@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a85e85d6-6a06-7663-3a12-710b6467dedd@acm.org>
Date:   Mon, 25 Feb 2019 06:49:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <2185e4e5-086a-d0c2-0fee-a7a5c98267bb@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 1:37 AM, Johannes Thumshirn wrote:
> On 24/02/2019 11:54, Max Gurtovoy wrote:
>> What is the status of iSCSI/SRP targets in this case ?
> 
> iSCSI/SRP passes in the following:
> 
>   /*
>    * Use O_DSYNC by default instead of O_SYNC to forgo syncing
>    * of pure timestamp updates.
>    */
>   flags = O_RDWR | O_CREAT | O_LARGEFILE | O_DSYNC;

That code fragment comes from the LIO file backend. There is no 
requirement for a SCSI target core file backend to use O_DSYNC. SCST 
allows users to choose whether or not O_DSYNC should be used:

	if (virt_dev->wt_flag && !virt_dev->nv_cache)
		open_flags |= O_DSYNC;

Bart.

