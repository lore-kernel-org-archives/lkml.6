Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E979C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C345A20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C345A20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeIGOhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:37:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57828 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbeIGOhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:37:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63C9818A;
        Fri,  7 Sep 2018 02:57:09 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67DEF3F614;
        Fri,  7 Sep 2018 02:57:08 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 0/6] arm64/mm: Move swapper_pg_dir to rodata
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <3748f344-465e-63ee-8a9b-5ac1502163c2@arm.com>
Date:   Fri, 7 Sep 2018 10:57:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822095432.12125-1-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

(I'm a bit confused about which version of this series I should be looking at.
I have a v4, and two v4-resends, all of which are different. Please only mark
something as 'resend' if it is exactly the same!)


On 22/08/18 10:54, Jun Yao wrote:
> The set_init_mm_pgd() is reimplemented using assembly in order to
> avoid being instrumented by kasan.

There are some tidier ways of fixing this. The kasan init code is also C code
that is run before kasan is initialized. Kbuild is told not to let KASAN touch
it with 'KASAN_SANITISE_filename.o := n'.

But, in this case you're only calling into C code from pre-kasan head.S so you
can use the same helper to set init_mm.pgd. I don't think this is worth the
effort, we can just do the store in assembly. (more in patch 3).


Thanks,

James
