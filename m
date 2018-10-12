Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60354C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0036C2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0036C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sf-tec.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeJLVgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:36:16 -0400
Received: from mail.sf-mail.de ([78.47.74.12]:57973 "EHLO mail.sf-mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbeJLVgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:36:15 -0400
Received: (qmail 10635 invoked from network); 12 Oct 2018 14:03:39 -0000
Received: from mail.sf-mail.de ([::ffff:78.47.74.12]:50928 HELO webmail.sf-mail.de) (auth=eike@sf-mail.de)
        by mail.sf-mail.de (Qsmtpd 0.34dev) with (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA
        for <firoz.khan@linaro.org>; Fri, 12 Oct 2018 16:03:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 12 Oct 2018 16:03:35 +0200
From:   Rolf Eike Beer <eike-kernel@sf-tec.de>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-parisc-owner@vger.kernel.org
Subject: Re: [PATCH v4 3/6] parisc: add system call table generation support
In-Reply-To: <CALxhOnggUEkXVVupq0SebJV0StKqbTTCqQtaaao+oQveUFHgbg@mail.gmail.com>
References: <1539337442-3676-1-git-send-email-firoz.khan@linaro.org>
 <1539337442-3676-4-git-send-email-firoz.khan@linaro.org>
 <c6280818c999449646ec216984f2df9e@sf-tec.de>
 <CALxhOnggUEkXVVupq0SebJV0StKqbTTCqQtaaao+oQveUFHgbg@mail.gmail.com>
Message-ID: <24dae8ebfd18a60e844383ae4beed486@sf-tec.de>
X-Sender: eike-kernel@sf-tec.de
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firoz Khan wrote:

>> > +
>> > +    my_abi="$(cut -d'|' -f2 <<< $my_abis)"
> 
> Here is the logic of identifying the generated script is for compat 
> interface
> or not. So systbl_abi_syscall_table_c32 := common,compat,32 in Makefile
> will parse the script and check the second string whether this is
> "compat" or not.
> 
> Other ways are:
> 1. add an extra flag, that will again add the complexity
> 2. check if [ ${out: -5} = "c32.h" ], this looks weird
> 
> Is there any better way to do the same?

What part is that comment directed at? I guess it's the next hunk, so 
I'll comment on that.

>> "<<<" is a bash extension and will not work with /bin/sh.
>> 
>> > +    while read nr abi name entry compat ; do
>> > +     if [ $my_abi = "compat" ]; then
>> > +         if [ -z "$compat" ]; then
>> > +             emit $nxt $nr $entry
>> > +         else
>> > +             emit $nxt $nr $compat
>> > +         fi
>> > +     else
>> > +         emit $nxt $nr $entry
>> > +     fi
>> 
>> I would go for a local variable being set to $compat or $entry and
>> calling emit at only one place. And there should be only one if with 2
>> expressions, no need for 3 branches.

if [ $my_abi = "compat" -a -n "${compat}" ]; then
     somevar=${compat}
else
     somevar=${entry}
fi
emit $nxt $nr $somevar

Eike
