Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F7EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D9222419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D9222419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbeKMEwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:52:47 -0500
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:51180 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727530AbeKMEwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:52:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B52FF2827;
        Mon, 12 Nov 2018 18:58:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: limit38_db533c51f058
X-Filterd-Recvd-Size: 2013
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Nov 2018 18:58:14 +0000 (UTC)
Message-ID: <3470156e35390d1810a6a5e4a554a77493c0d44f.camel@perches.com>
Subject: Re: [PATCH] scsi: libsas: Remove pcidev reference
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Date:   Mon, 12 Nov 2018 10:58:12 -0800
In-Reply-To: <dd39734e-4113-f9fd-6890-a83e80093c7e@huawei.com>
References: <1542043689-214071-1-git-send-email-john.garry@huawei.com>
         <584e7b4fcd6f95fe0c581f6f9472852685c754d1.camel@perches.com>
         <310504a2-f33c-183b-d00a-fa067b273dfd@huawei.com>
         <3b62b0ad-53ba-37c2-817c-591d94eed838@huawei.com>
         <31d224e8c4b9bcebc3657c17fa50302f7da90e64.camel@perches.com>
         <dd39734e-4113-f9fd-6890-a83e80093c7e@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-12 at 18:48 +0000, John Garry wrote:
> On 12/11/2018 18:30, Joe Perches wrote:
[]
> > diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
[]
> > @@ -32,7 +32,10 @@
> >  #include <scsi/libsas.h>
> >  #include <scsi/sas_ata.h>
> > 
> > -#define sas_printk(fmt, ...) printk(KERN_NOTICE "sas: " fmt, ## __VA_ARGS__)
> > +#ifdef pr_fmt
> > +#undef pr_fmt
> > +#endif
> > +#define pr_fmt(fmt) "sas: " fmt
> 
> Some other subsystem may try to include this header, and gets its 
> message prefix overwritten. Just a consequence for doing something bad, 
> right?

Right.

And as this file is internal to drivers/scsi/libsas
that seems very unlikely to occur.

It also might useful to use the common debugging
mechanisms and convert SAS_DPRINTK to pr_debug
which would use the same #define pr_fmt.


