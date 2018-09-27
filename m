Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85C6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A3B216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ntv9xbXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A3B216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeI0UUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:20:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbeI0UUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hBu/g35Gt8ZJ/4aKNk9hpqghffLFUTwLodfPiV4W11w=; b=Ntv9xbXHMhU9FC3a7/RHdsSku
        5NEAzl1fmIOqnyX+RYjfDItexnVPyTDM++iJ6LAYTit3CKKSBrKwNVr6bJhmDkO4oGghlkMx2ecOA
        EeG2rG+t/H5huZ5CLXRnA1Iq2FGYKgRaLHSee8PzPSuRMxozXRldZV2Z0qrm4Up6NIFwKlpw0YMFd
        ZwsAg7oF9XVSsJtfXB+09VEzD8RpRbefKLNrWC/8EG56dVKk8lW7LQ6nZbRQ6xuZEst5oHoezBPfe
        /knrqj2rSNWol29nVTJCcums3aJw6UL1CcnWIZi8GRm19LVDYDRGTGERjyuPYVod61CyfLLo2oevS
        Fo0KBCEjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5WrF-0001Xt-VN; Thu, 27 Sep 2018 14:01:33 +0000
Date:   Thu, 27 Sep 2018 07:01:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        sayali <sayalil@codeaurora.org>
Subject: Re: [PATCH v4] scsi: ufs: Make sysfs attributes writable
Message-ID: <20180927140133.GA22096@infradead.org>
References: <20180808224454.243790-1-evgreen@chromium.org>
 <6dd8a547-7260-09b8-9096-8a1564b08e70@intel.com>
 <8fd05b2d-fa48-78af-6f1c-7e485c1008f6@intel.com>
 <CAD=FV=W7h_3LwV-P5_E58-3qOo7Y-yQDTDfSLoU1+3c_6ZF0cg@mail.gmail.com>
 <yq1h8idgj5y.fsf@oracle.com>
 <CAD=FV=WNHDd8icQi3wtFV98w1zdEd-QqFn1PrZeXQWgYt4Yo1w@mail.gmail.com>
 <CAE=gft57aP3Qx-zdHR1UsJwS7JjVEpVvmCSTk3ctWrRF2=W4ww@mail.gmail.com>
 <SN6PR04MB4925DAB09EED762CDCCBBF47FC140@SN6PR04MB4925.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB4925DAB09EED762CDCCBBF47FC140@SN6PR04MB4925.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 06:32:47AM +0000, Avri Altman wrote:
> Also, in this context there is the series in 
> https://www.spinics.net/lists/linux-scsi/msg123479.html
> which allows to send UPIUs via a bsg device.
> 
> It's not a provisioning series per-se like Evan's and Sayali's.
> It covers the provisioning functionality,
> But also allow to send task management UPIU, and UIC commands,
> Which can be used for testing and validation.

And as someone having been involved with review of a few different
UFS provisioning bits this is what I think we should be merging.

Instead of being in a rat race of adding ever new sysfs or configfs
attributes for things that don't matter to normal driver operation
I'd rather have a relatively clean pass through interface and move
policy to userspace.  Especially given that there are plenty of
vendor specific commands at these levels as well.
