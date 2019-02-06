Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E34C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2282175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 10:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfBFKF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 05:05:29 -0500
Received: from ozlabs.org ([203.11.71.1]:35733 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfBFKF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 05:05:29 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43vcWp4B2fz9sMM;
        Wed,  6 Feb 2019 21:05:26 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.0-rc5
In-Reply-To: <5ccff302-3986-5892-d072-5c334484f990@infradead.org>
References: <20190204134234.13636-1-geert@linux-m68k.org> <33e58393-97f1-321e-5ee0-a1242c7c7a26@infradead.org> <5ccff302-3986-5892-d072-5c334484f990@infradead.org>
Date:   Wed, 06 Feb 2019 21:05:25 +1100
Message-ID: <87zhr9kza2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> On 2/4/19 9:46 AM, Randy Dunlap wrote:
>> On 2/4/19 5:42 AM, Geert Uytterhoeven wrote:
>>> Below is the list of build error/warning regressions/improvements in
>>> v5.0-rc5[1] compared to v4.20[2].
>>>
>>> Summarized:
>>>   - build errors: +2/-4
>>>   - build warnings: +113/-14843
>>>
>>> JFYI, when comparing v5.0-rc5[1] to v5.0-rc4[3], the summaries are:
>>>   - build errors: +0/-0
>>>   - build warnings: +56/-59
>>>
>>> Note that there may be false regressions, as some logs are incomplete.
>>> Still, they're build errors/warnings.
>>>
>>> Happy fixing! ;-)
>>>
>>> Thanks to the linux-next team for providing the build service.
>>>
>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8834f5600cf3c8db365e18a3d5cac2c2780c81e5/ (238 out of 240 configs)
>>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8fe28cb58bcb235034b64cbbb7550a8a43fd88be/ (all 240 configs)
>>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f17b5f06cb92ef2250513a1e154c47b78df07d40/ (238 out of 240 configs)
>>>
>>>
>>>
>>> *** WARNINGS ***
>>>
>>> 113 warning regressions:
>> 
>>>   + warning: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS:  => N/A
>> 
>> Hi Geert,
>> 
>> I am trying to find the above warning (needle) in the haystack.
>> Can you please direct me to which config/build it is in?
>> 
>> Is there a good way for me to find it?
>> 
>> thanks.
>> 
>
> Working backwards, it probably comes from this:
>
> config CURRITUCK
> 	bool "IBM Currituck (476fpe) Support"
> 	depends on PPC_47x
> 	select SWIOTLB
> 	select 476FPE
> 	select PPC4xx_PCI_EXPRESS
>
> This is the only similar Kconfig segment that does not select FORCE_PCI
> but PPC4xx_PCI_EXPRESS depends on PCI but
> # CONFIG_PCI is not set
>
> This could be related to a recent series of patches that allows ACPI to
> be built without having PCI enabled.
>
> Michael?

There isn't really an easy way to do it sorry.

If you download the page for the revision:
  http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8834f5600cf3c8db365e18a3d5cac2c2780c81e5/

With a lot of grep/sed/awk you can get a list of the URLs for all the
builds eg. one would be:

  http://kisskb.ellerman.id.au/kisskb/buildresult/13676551/

And then you can just tack on "log/" to get:

  http://kisskb.ellerman.id.au/kisskb/buildresult/13676551/log/

Which you can wget and grep.

But that's all a bit of a pain.

I have on my todo list to add json formatted build results and revision
pages, which would make it quite a bit simpler. But of course I haven't
had time to do it yet :/

cheers
