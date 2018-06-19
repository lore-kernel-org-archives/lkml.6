Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B5BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C81320693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C81320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755718AbeFSGlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:41:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750816AbeFSGlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:41:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1AA3281A4E99;
        Tue, 19 Jun 2018 06:41:01 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-135.ams2.redhat.com [10.36.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 567847C37;
        Tue, 19 Jun 2018 06:40:55 +0000 (UTC)
Subject: Re: [PATCH 06/10] x86/cet: Add arch_prctl functions for shadow stack
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "H. J. Lu" <hjl.tools@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
References: <20180607143807.3611-1-yu-cheng.yu@intel.com>
 <CALCETrU6axo158CiSCRRkC4GC5hib9hypC98t7LLjA3gDaacsw@mail.gmail.com>
 <1528403417.5265.35.camel@2b52.sc.intel.com>
 <CALCETrXz3WWgZwUXJsDTWvmqKUArQFuMH1xJdSLVKFpTysNWxg@mail.gmail.com>
 <CAMe9rOr49V8rqRa_KVsw61PWd+crkQvPDgPKtvowazjmsfgWWQ@mail.gmail.com>
 <alpine.DEB.2.21.1806121155450.2157@nanos.tec.linutronix.de>
 <CAMe9rOoCiXQ4iVD3j_AHGrvEXtoaVVZVs7H7fCuqNEuuR5j+2Q@mail.gmail.com>
 <CALCETrXO8R+RQPhJFk4oiA4PF77OgSS2Yro_POXQj1zvdLo61A@mail.gmail.com>
 <CAMe9rOpLxPussn7gKvn0GgbOB4f5W+DKOGipe_8NMam+Afd+RA@mail.gmail.com>
 <CALCETrWmGRkQvsUgRaj+j0CP4beKys+TT5aDR5+18nuphwr+Cw@mail.gmail.com>
 <CAMe9rOpzcCdje=bUVs+C1WrY6GuwA-8AUFVLOG325LGz7KHJxw@mail.gmail.com>
 <alpine.DEB.2.21.1806122046520.1592@nanos.tec.linutronix.de>
 <CAMe9rOrGjJf0aMnUjAP38MqvOiW3=iXGQjcUT3O=f9pE85hXaw@mail.gmail.com>
 <CALCETrVsh5t-V1Sm88LsZE_+DS0GE_bMWbcoX3SjD6GnrB08Pw@mail.gmail.com>
 <CAGXu5jK0gospOXRpN6zYiQPXOZeE=YpVAz2qu4Zc3-32v85+EQ@mail.gmail.com>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <e152e1a7-e3b1-c3c4-ce1a-874e97300b37@redhat.com>
Date:   Tue, 19 Jun 2018 08:40:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK0gospOXRpN6zYiQPXOZeE=YpVAz2qu4Zc3-32v85+EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 19 Jun 2018 06:41:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 19 Jun 2018 06:41:01 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 02:52 AM, Kees Cook wrote:
> Adding Florian to CC, but if something gets CET enabled, it really
> shouldn't have a way to turn it off. If there's a way to turn it off,
> all the ROP research will suddenly turn to exactly one gadget before
> doing the rest of the ROP: turning off CET. Right now ROP is: use
> stack-pivot gadget, do everything else. Allowed CET to turn off will
> just add one step: use CET-off gadget, use stack-pivot gadget, do
> everything else. :P
> 
> Following Linus's request for "slow introduction" of new security
> features, likely the best approach is to default to "relaxed" (with a
> warning about down-grades), and allow distros/end-users to pick
> "forced" if they know their libraries are all CET-enabled.

The dynamic linker can tell beforehand (before executing any user code) 
whether a process image supports CET.  So there doesn't have to be 
anything gradual about it per se to preserve backwards compatibility.

The idea to turn off CET probably comes from the desire to support 
dlopen.  I'm not sure if this is really necessary because the complexity 
is rather nasty.  (We currently do something similar for executable 
stacks.)  I'd rather have a switch to turn off the feature upon process 
start.  Things like NSS and PAM modules need to be recompiled early.  (I 
hope that everything that goes directly to the network via custom 
protocols or hardware such as smartcards is proxied via daemons these days.)

Thanks,
Florian
