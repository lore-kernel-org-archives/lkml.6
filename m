Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DEFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B23925632
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B23925632
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbeFYIte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:49:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754071AbeFYItc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:49:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA495401EF2B;
        Mon, 25 Jun 2018 08:49:31 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7044479DD;
        Mon, 25 Jun 2018 08:49:30 +0000 (UTC)
Date:   Mon, 25 Jun 2018 10:49:28 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        qemu-s390x <qemu-s390x@nongnu.org>,
        qemu-devel <qemu-devel@nongnu.org>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: s390 qemu boot failure in -next
Message-ID: <20180625104928.6c4cb239.cohuck@redhat.com>
In-Reply-To: <your-ad-here.call-01529915788-ext-6027@work.hours>
References: <20180622194736.GA5794@roeck-us.net>
        <126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
        <88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
        <20180625100548.64222dad.cohuck@redhat.com>
        <your-ad-here.call-01529915788-ext-6027@work.hours>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 25 Jun 2018 08:49:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 25 Jun 2018 08:49:32 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 10:36:33 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> This change has been done on purpose. Uncompressed image is not going
> to be bootable any more. In future the decompressor phase would get
> more function (early memory detection as an example) and there is no
> chance to duplicate that code in uncompressed image as well (to keep it
> bootable on its own). The patch series commit messages contain more
> technical details.
> 
> For qemu either bzImage or arch/s390/boot/compressed/vmlinux should be
> used, which are bootable images.
> 
> But that's really confusing that uncompressed vmlinux is still kind
> of booting. May be we should discuss how to avoid this confusion
> (may be change uncompressed image enty point to a function doing
> disabled wait with badb007 or smth) and how to encourage people to use
> arch/s390/boot/compressed/vmlinux instead.

So, the intention is that you can't boot the uncompressed image
anywhere? (Was it possible before, e.g. when punching the image under
z/VM?) If yes, it would make sense to explicitly fence it. But I'm
worried that it would break previously working setups (did we document
the purpose of the images anywhere?)
