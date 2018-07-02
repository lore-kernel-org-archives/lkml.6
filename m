Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64C6C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB1E24E67
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB1E24E67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeGBSzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:55:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753263AbeGBSzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:55:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A22DB406E87A;
        Mon,  2 Jul 2018 18:55:37 +0000 (UTC)
Received: from crecklin.bos.csb (ovpn-120-13.rdu2.redhat.com [10.10.120.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3ED31C55F;
        Mon,  2 Jul 2018 18:55:36 +0000 (UTC)
Reply-To: crecklin@redhat.com
Subject: Re: [PATCH v3] add param that allows bootline control of hardened
 usercopy
To:     Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1530101255-13988-1-git-send-email-crecklin@redhat.com>
 <CAGXu5jLDULvf-VBhUfBXtSNaSWpq8irgg56LT3nHDft5gZg5Lw@mail.gmail.com>
 <5506a72f-99ac-b47c-4ace-86c43b17b5c5@redhat.com>
 <CAGXu5jL8XDYE+B=a_TBM2K8F-c3f4Jz6zcm3ggacbPNN2wCtpg@mail.gmail.com>
From:   Christoph von Recklinghausen <crecklin@redhat.com>
Organization: Red Hat
Message-ID: <0076b929-4785-0665-0e08-789c504f6b78@redhat.com>
Date:   Mon, 2 Jul 2018 14:55:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jL8XDYE+B=a_TBM2K8F-c3f4Jz6zcm3ggacbPNN2wCtpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 02 Jul 2018 18:55:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 02 Jul 2018 18:55:37 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'crecklin@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 02:43 PM, Kees Cook wrote:
> On Sat, Jun 30, 2018 at 1:43 PM, Christoph von Recklinghausen
> <crecklin@redhat.com> wrote:
>> The last issue I'm chasing is build failures on ARCH=m68k. The error is
>> atomic_read and friends needed by the jump label code not being found.
>> The config has CONFIG_BROKEN_ON_SMP=y, so the jump label calls I added
>> will only be made #ifndef CONFIG_BROKEN_ON_SMP. Do you think that's
>> worth a mention in the blurb that's added to
>> Documentation/admin-guide/kernel-parameters.txt?
> Uhm, that's weird -- I think the configs on m68k need fixing then? I
> don't want to have to sprinkle that ifdef in generic code.
>
> How are other users of static keys and jump labels dealing with m68k weirdness?
>
> -Kees
>
There's also CONFIG_JUMP_LABEL which is defined in x86_64 but not
defined in the m68k configs. I'll use that instead. In hindsight I
should have spotted that but didn't.

Thanks,

Chris

