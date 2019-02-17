Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D2AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C262075C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 08:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfBQIej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 03:34:39 -0500
Received: from ozlabs.org ([203.11.71.1]:40759 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfBQIej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 03:34:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 442Kzx30D5z9sLw;
        Sun, 17 Feb 2019 19:34:37 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Balbir Singh <bsingharora@gmail.com>
Cc:     erhard_f@mailbox.org, jack@suse.cz, linuxppc-dev@ozlabs.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due to pgd/pud_present()
In-Reply-To: <20190216142206.GE14180@gate.crashing.org>
References: <20190214062339.7139-1-mpe@ellerman.id.au> <20190216105511.GA31125@350D> <20190216142206.GE14180@gate.crashing.org>
Date:   Sun, 17 Feb 2019 19:34:36 +1100
Message-ID: <87bm3add9f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:

> Hi all,
>
> On Sat, Feb 16, 2019 at 09:55:11PM +1100, Balbir Singh wrote:
>> On Thu, Feb 14, 2019 at 05:23:39PM +1100, Michael Ellerman wrote:
>> > In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
>> > rather than just checking that the value is non-zero, e.g.:
>> > 
>> >   static inline int pgd_present(pgd_t pgd)
>> >   {
>> >  -       return !pgd_none(pgd);
>> >  +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
>> >   }
>> > 
>> > Unfortunately this is broken on big endian, as the result of the
>> > bitwise && is truncated to int, which is always zero because
>
> (Bitwise "&" of course).

Thanks, I fixed that up.

cheers
