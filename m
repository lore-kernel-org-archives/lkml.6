Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91BEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9978F265C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9978F265C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbeFZIY7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:24:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752852AbeFZIYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:24:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8461400224C;
        Tue, 26 Jun 2018 08:24:53 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4EE6276E9;
        Tue, 26 Jun 2018 08:24:52 +0000 (UTC)
Date:   Tue, 26 Jun 2018 10:24:49 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>,
        qemu-devel <qemu-devel@nongnu.org>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] s390/boot: block uncompressed vmlinux booting attempts
Message-ID: <20180626102449.50b65335.cohuck@redhat.com>
In-Reply-To: <7cb526fc-9da4-248b-d5c4-cb463a2c2bac@de.ibm.com>
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
        <cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
        <patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
        <7cb526fc-9da4-248b-d5c4-cb463a2c2bac@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 08:24:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 08:24:53 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 09:30:19 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06/25/2018 05:09 PM, Vasily Gorbik wrote:
> > Since uncompressed kernel image "vmlinux" elf file is not bootable under
> > qemu anymore, add a check which would report that.
> > 
> > Qemu users are encouraged to use bzImage or
> > arch/s390/boot/compressed/vmlinux instead.
> > 
> > The check relies on s390 linux entry point ABI definition, which is only
> > present in bzImage and arch/s390/boot/compressed/vmlinux.
> > 
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>  
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> some proposals regarding the wording below..
> 
> [...]
> > +
> > +	sclp_early_printk("The linux kernel boot failure: the image is corrupted or not bootable.\n");
> > +	sclp_early_printk("Please check that you are using bootable kernel image \"bzImage\".\n");
> > +	sclp_early_printk("(or alternatively \"arch/s390/boot/compressed/vmlinux\" image for qemu)\n");  
> 
> What about making this explain things a bit more, e.g. something like
> 
> Linux kernel boot failure: The boot image does not contain all necessary
> components (like the entry point and decompressor). The plain vmlinux ELF
> file no longer carries all necessary parts for starting up. Please use
> bzImage or arch/s390/boot/compressed/vmlinux.

Yes, that sounds good. With the changed message,

Acked-by: Cornelia Huck <cohuck@redhat.com>
