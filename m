Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3310AC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CE6204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CE6204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeLGJu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:50:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:18029 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbeLGJuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:50:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 01:50:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,324,1539673200"; 
   d="scan'208";a="99445578"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga008.jf.intel.com with ESMTP; 07 Dec 2018 01:50:21 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Maynard CABIENTE <maynard.cabiente@raritan.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] usb: dwc2: Revert "usb: dwc2: Disable all EP's on disconnect"
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7B47A2@am04wembxa.internal.synopsys.com>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com> <20181121154504.13052-1-m.szyprowski@samsung.com> <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com> <20181123144307.GC2970@unbuntlaptop> <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com> <2b48a7b5-f806-d761-97f6-885ae6c69a7e@samsung.com> <410670D7E743164D87FA6160E7907A56013A7B47A2@am04wembxa.internal.synopsys.com>
Date:   Fri, 07 Dec 2018 11:50:21 +0200
Message-ID: <87lg517jj6.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,


Minas Harutyunyan <minas.harutyunyan@synopsys.com> writes:

> Hi Marek,
>
> On 12/6/2018 7:04 PM, Marek Szyprowski wrote:
>> Dear Minas,
>> 
>> On 2018-12-04 13:34, Minas Harutyunyan wrote:
>>> On 11/23/2018 6:43 PM, Dan Carpenter wrote:
>>>> Ugh...  We also had a long thread about the v2 patch but it turns out
>>>> the list was not CC'd.  I should have checked for that.
>>>>
>>>> You have to pass a flag to say if the caller holds the lock or not...
>>>>
>>>> regards,
>>>> dan carpenter
>>>>
>>> Hi Dan, Marek, Maynard,
>>>
>>> Could you please apply bellow patch over follow patches:
>>>
>>> dccf1bad4be7 usb: dwc2: Disable all EP's on disconnect
>>> 6f774b501928 usb: dwc2: Fix ep disable spinlock flow.
>>>
>>> Please review and test. Feedback is appreciated :-)
>> 
>> Okay, I finally managed to find some time to check this. Your diff is
>> mangled, so I had to manually apply it. Frankly, it is very similar to
>> the revert I proposed. I've checked it on my test machines and it fixes
>> the issues. I'm not very happy about the unlock/lock design, but it
>> should be safe in this case and doesn't make the code even more complex.
>> Feel free to add a following tag to the final patch:
>> 
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Thanks for testing.

should $Subject be applied? Can you resend rebased on testing/next with
Tested-by tags collected if you're happy with it?

thanks

-- 
balbi
