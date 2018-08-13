Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7734FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A87B2175F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A87B2175F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeHMMQE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:16:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728352AbeHMMQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:16:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A64240200A7;
        Mon, 13 Aug 2018 09:34:36 +0000 (UTC)
Received: from gondolin (ovpn-116-236.ams2.redhat.com [10.36.116.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FE8810EE780;
        Mon, 13 Aug 2018 09:34:30 +0000 (UTC)
Date:   Mon, 13 Aug 2018 11:34:27 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
Subject: Re: [PATCH v8 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
Message-ID: <20180813113427.1f074afc.cohuck@redhat.com>
In-Reply-To: <36670270-13f7-f044-7419-57f444317fd9@linux.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1533739472-7172-5-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180809110645.33b20c1f.cohuck@redhat.com>
        <36670270-13f7-f044-7419-57f444317fd9@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 13 Aug 2018 09:34:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 13 Aug 2018 09:34:36 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 11:24:48 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> Here is now the add-on patch which changes the returncode for the
> ap_instructions_available() function.
> 
> I talked with Heiko Carstens and this patch will go into the next pull
> request for the 4.19 kernel.

I was just about to ask :)

> 
> -----------------------------------------------------------------------------------------
> From 9e050f843f3281da1f65292422e30f2dd1fd6d98 Mon Sep 17 00:00:00 2001
> From: Harald Freudenberger <freude@linux.ibm.com>
> Date: Thu, 9 Aug 2018 11:59:34 +0200
> Subject: [PATCH] s390/zcrypt: fix ap_instructions_available() returncodes
> 
> During review of KVM patches it was complained that the
> ap_instructions_available() function returns 0 if AP
> instructions are available and -ENODEV if not. The function
> acts like a boolean function to check for AP instructions
> available and thus should return 0 on failure and != 0 on
> success. Changed to the suggested behaviour and adapted
> the one and only caller of this function which is the ap
> bus core code.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  arch/s390/include/asm/ap.h   | 10 +++++-----
>  drivers/s390/crypto/ap_bus.c |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)

Looks sane to me.

Acked-by: Cornelia Huck <cohuck@redhat.com>
