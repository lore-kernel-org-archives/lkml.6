Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EBFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19971206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbeLNV1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:27:47 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:20732 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbeLNV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:27:47 -0500
X-Greylist: delayed 11543 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Dec 2018 16:27:46 EST
X-RZG-AUTH: ":OH8QVVOrc/CP6za/qRmbF3BWedPGA1vjs2e0bDjfg8OiOrPJifeRMRhMbfKobJAvSmsJbFO0KIY="
X-RZG-CLASS-ID: mo00
Received: from [192.168.2.24]
        by smtp.strato.de (RZmta 44.8 DYNA|AUTH)
        with ESMTPSA id V03c59uBELRQ6tv
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 14 Dec 2018 22:27:26 +0100 (CET)
Subject: Re: [PATCH] acpi / apei: fix NULL deref during init
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        linux-acpi@vger.kernel.org
References: <20181214181514.29891-1-tst@schoebel-theuer.de>
 <20181214202406.GI11710@zn.tnic>
From:   Thomas Schoebel-Theuer <tst@schoebel-theuer.de>
Message-ID: <c8d62037-4a26-e18b-51a3-73fc99e76e5b@schoebel-theuer.de>
Date:   Fri, 14 Dec 2018 22:27:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20181214202406.GI11710@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 21:24, Borislav Petkov wrote:
>
> Because apei_resources_fini() happens under the same condition check and
> if arch_apei_filter_addr was false, it should not become true, all of a
> sudden. Or?

Hi Borislav,

please take a look at the stacktrace. For some reason, and only at that 
specific hardware, the condition is false, there but later the indicated 
error exit is taken whose message you can see immediately before the 
stack trace.

So this should documents the one observed case where the NULL deref is 
actually happening.

Of course, it would be possible to develop another solution, but this 
one appears the simplest and safest to me (minimum changes to the logic).

I have tested the patch on that specifc hardware: I have verified that 
the patch does not trigger the NULL deref anymore.

Of course, on any other hardware we have tested, the bug did not trigger 
at all.

If you don't have that specific hardware, you probably cannot easily 
trigger / verify the problem.

If you need access to the specfic hardware, talk to me in a private 
conversation.

Cheers,

Thomas
