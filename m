Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A2ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2574A207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 23:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2574A207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeJYHkx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:40:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeJYHkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:40:53 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7558818A0;
        Wed, 24 Oct 2018 23:10:51 +0000 (UTC)
Date:   Wed, 24 Oct 2018 16:10:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     jglisse@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/6] mm/hmm: fix race between hmm_mirror_unregister()
 and mmu_notifier callback
Message-Id: <20181024161047.cd979d1c3da115844182de3b@linux-foundation.org>
In-Reply-To: <20181019160442.18723-4-jglisse@redhat.com>
References: <20181019160442.18723-1-jglisse@redhat.com>
        <20181019160442.18723-4-jglisse@redhat.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018 12:04:39 -0400 jglisse@redhat.com wrote:

> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> In hmm_mirror_unregister(), mm->hmm is set to NULL and then
> mmu_notifier_unregister_no_release() is called. That creates a small
> window where mmu_notifier can call mmu_notifier_ops with mm->hmm equal
> to NULL. Fix this by first unregistering mmu notifier callbacks and
> then setting mm->hmm to NULL.
> 
> Similarly in hmm_register(), set mm->hmm before registering mmu_notifier
> callbacks so callback functions always see mm->hmm set.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@vger.kernel.org

I added your Signed-off-by: to this one.  It's required since you were
on the patch delivery path.

