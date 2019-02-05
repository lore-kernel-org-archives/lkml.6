Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E06FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1022175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RNGdFSsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfBEWq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:46:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51994 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbfBEWqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5XJRIrdkjENJb3QKmYgGMjGqndnRXzAHnf6fe8/YMzw=; b=RNGdFSsdVUtMmIkFrYmy3oKzg+
        xoPbhs0n0J7XnWShg1UA+eJmnI3jxCUvDrXbONLN9qtwr6s/oJtyp7N+wXtnPIcUiAyZaXvs9t6Lj
        7Bb3rwWZM42Q+MDpoFJfaVKNx1MLY+ot3Z8DhUrOpC7ErAx9P+ngztVPydYQb+R8/LSNbiCtYyJMX
        ODRkE2g6j3LOs9LekxM7xUD0EyTZMRGo5HGEcyAZ+ZnsMrL5EOZVMlQ+bEW+obNBXVZXFk4UzGZbc
        SSMUDSS6iqVsdpyRFh3KkXyFTBjC7GSkXpKcm26dcMXongllBdY9Ymf+3DLh213kXMzWEXDekIYLb
        39aO04zg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gr9Tr-0007DD-P9; Tue, 05 Feb 2019 22:46:16 +0000
Subject: Re: [PATCH v5 01/13] taint: Introduce a new taint flag (insecure)
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190201205319.15995-1-chang.seok.bae@intel.com>
 <20190201205319.15995-2-chang.seok.bae@intel.com>
 <CALCETrXi=PEOXCQYkCO9BLL+oaoJonRohWoxvUqxZdiWURc3=Q@mail.gmail.com>
 <20190205132146.2e61b3df9e7be49e22b7d903@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f41a5d14-b642-0969-3c7a-cc12b820d208@infradead.org>
Date:   Tue, 5 Feb 2019 14:46:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190205132146.2e61b3df9e7be49e22b7d903@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 1:21 PM, Andrew Morton wrote:
> On Fri, 1 Feb 2019 18:42:29 -0800 Andy Lutomirski <luto@kernel.org> wrote:
> 
>> On Fri, Feb 1, 2019 at 12:54 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>>>
>>> For testing (or root-only) purposes, the new flag will serve to tag the
>>> kernel taint accurately.
>>>
>>> When adding a new feature support, patches need to be incrementally
>>> applied and tested with temporal parameters. Currently, there is no flag
>>> for this usage.
>>
>> I think this should be reviewed by someone like akpm.  akpm, for
>> background, this is part of an x86 patch series.  If only part of the
>> series is applied, the kernel will be blatantly insecure (but still
>> functional and useful for testing and bisection), and this taint flag
>> will be set if this kernel is booted.  With the whole series applied,
>> there are no users of the taint flag in the kernel.
>>
>> Do you think this is a good idea?
> 
> What does "temporal parameters" mean?  A complete description of this
> testing process would help.
> 
> I sounds a bit strange.  You mean it assumes that people will partially
> apply the series to test its functionality?  That would be inconvenient.

Ack.  I don't think we need to (or should) worry about that kind of
muckup.

> - Can the new and now-unused taint flag be removed again at
>   end-of-series?
> 
> - It would be a lot more convenient if we had some means of testing
>   after the whole series is applied, on a permanent basis - some
>   debugfs flag, perhaps?
> 


-- 
~Randy
