Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1C1214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 03:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FRBaNjhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1C1214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbeKLNt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 08:49:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbeKLNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 08:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iu6ISZLQVmEbx4GKJ7doUdsMco4P7jQgdY7kvZvh9ts=; b=FRBaNjhy+rJEn3na+0M7e6BR5
        i3uZGLbOY9/8Jnm2xas4eqCVxq3aWquOFmU4u65vMNSMypt610+zE5evY3QZvMlVd+YfVi9v07G+F
        YqOaJKI/BAt47C5291Jkgd0qCNewE0wK6sw8FPP8hV9vlosStN4jWUs4rG5MYTyunsKCbMD/QQwTZ
        cTi7hb5c3yVLnf4bxJnG6Fxt8byJ/JIdxfuxSPfvP1aBqcaWx9uAyZ4fdD9cOmEcFjSpNMzz3V1G9
        WvAH/lIRySWDJ+caidhWfJz+IMgG7uQpuLf+FYoNTUummwcgt0qwkCe9OKU2K56zqX1Y9mDWIYjSP
        CEJhp+fDg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM3N0-0005CI-AK; Mon, 12 Nov 2018 03:58:38 +0000
Date:   Sun, 11 Nov 2018 19:58:38 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Timofey Titovets <timofey.titovets@synesis.ru>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, Timofey Titovets <nefelim4ag@gmail.com>
Subject: Re: [PATCH v2] ksm: allow dedup all tasks memory
Message-ID: <20181112035838.GF21824@bombadil.infradead.org>
References: <20181111212610.25213-1-timofey.titovets@synesis.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111212610.25213-1-timofey.titovets@synesis.ru>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:26:10AM +0300, Timofey Titovets wrote:
> ksm by default working only on memory that added by
> madvice().
> 
> And only way get that work on other applications:
>  - Use LD_PRELOAD and libraries
>  - Patch kernel
> 
> Lets use kernel task list in ksm_scan_thread and add logic to allow ksm
> import VMA from tasks.
> That behaviour controlled by new attribute: mode
> I try mimic hugepages attribute, so mode have two states:
>  - normal       - old default behaviour
>  - always [new] - allow ksm to get tasks vma and try working on that.
> 
> To reduce CPU load & tasklist locking time,
> ksm try import VMAs from one task per loop.
> 
> So add new attribute "mode"
> Two passible values:
>  - normal [default] - ksm use only madvice
>  - always [new]     - ksm will search vma over all processes memory and
>                       add it to the dedup list

Do you have any numbers for how much difference this change makes with
various different workloads?
