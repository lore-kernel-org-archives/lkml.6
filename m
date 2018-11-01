Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE885C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820112082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="blXMwtiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820112082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeKBDAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:00:23 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:37065 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbeKBDAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:00:23 -0400
Received: by mail-wm1-f52.google.com with SMTP id p2-v6so2024439wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nKXgcVwO8dM4jvqQU7QDD2B8DoDlWrqDfj4kGWQY3iU=;
        b=blXMwtiGHuF5vHAoBxSMOKriSdCKs0oLJ7AcslVZwdrNGSJ5vFwRbgpMK2CArY9iXR
         0KJ8Gcus7FRGtbvCAOHb1zLk+xXWrrMqzNsUrU5zZ3ZsbRJX3MEziqY7H02dccQMGkj7
         wm8aGa1ozwsz3mwQh4UNFY8czaMW/rNa4A0G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nKXgcVwO8dM4jvqQU7QDD2B8DoDlWrqDfj4kGWQY3iU=;
        b=WNqadfRXW/YELR8dZAnChXHJQBq2n42ZJQ/rHI0UjCR6408VbpVBT41t9VJheCa9yu
         yG9XU+6gYMBYXYhGfJDJX0e9OQ4DceO0XgpGMuIByTUEswC49YVc9uOaEGrrM3EKrLCZ
         GPRC9yYvaZO+3PMJnCc98e1yXK8FWiDKQ7AYbEY5BCQJndm/cpbtrl86DVH9eEAhbtrQ
         o3UNACK4fzf+2xd7XCPLwrsKSshXwcSPKWwvnhkcTDumh+XP6uQYyxLntHQ2ZnYmayB7
         OGabOCYkyBVe7v01Ob55E7iOo60HfDhGMoLw/14Ziq03Zq7QUCAjfK67lIWn/1ZreDU4
         m0vQ==
X-Gm-Message-State: AGRZ1gL0Dbk9WEwlAwPmDoDCGNiyV2yZjtREz85rFldVy+VfNs94axaY
        P9AoFjJ/KBph470o5JXmt6jmWrUxHLzZ7lNpxGjcAg==
X-Google-Smtp-Source: AJdET5fnaCbtD0XQ3RdBr2JutYFADAEVYmnWLkDFgd0J021Cck0wu8WmFfUcncBF7yf1jrvYCPD57p9XL5fhynp63t4=
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr6007738wml.15.1541094981383;
 Thu, 01 Nov 2018 10:56:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:4054:0:0:0:0:0 with HTTP; Thu, 1 Nov 2018 10:56:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1811011841060.1642@nanos.tec.linutronix.de>
References: <20181015160945.5993-1-christopher.s.hall@intel.com>
 <alpine.DEB.2.21.1810191720590.6075@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1810191955250.1651@nanos.tec.linutronix.de>
 <CALAqxLWHdZn9RCcYbYicKXeu3QiCuVna27mWBQPbFvaj9gm-fw@mail.gmail.com>
 <alpine.DEB.2.21.1810192050250.1651@nanos.tec.linutronix.de>
 <CALAqxLVrPH-SFacys6pWBvL79OBwiAMUOL55oy3S7C+7pNffHA@mail.gmail.com>
 <alpine.DEB.2.21.1810192244150.1651@nanos.tec.linutronix.de>
 <CALAqxLUpKU73kzBh6mxgoCX4nEueuE42REcXw6F6DYYk4Hry6Q@mail.gmail.com>
 <CALAqxLUKOYYm=bzn4owZC_UgWTqrVPiz2TSnLFm1RNak3tm8-g@mail.gmail.com> <alpine.DEB.2.21.1811011841060.1642@nanos.tec.linutronix.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 1 Nov 2018 10:56:20 -0700
Message-ID: <CALAqxLV7SGRx_jKyM_RmzBGmnqAtDRXQLcH4Yjj+HKCY1O9sOQ@mail.gmail.com>
Subject: Re: TSC to Mono-raw Drift
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christopher Hall <christopher.s.hall@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        jesus.sanchez-palencia@intel.com,
        Gavin Hindman <gavin.hindman@intel.com>,
        liam.r.girdwood@intel.com, Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 10:44 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 23 Oct 2018, John Stultz wrote:
>> On Fri, Oct 19, 2018 at 3:36 PM, John Stultz <john.stultz@linaro.org> wrote:
>> I spent a little bit of time thinking this out. Unfortunately I don't
>> think its a simple matter of calculating the granularity error on the
>> raw clock and adding it in each interval. The other trouble spot is
>> that the adjusted clocks (monotonic/realtime) are adjusted off of that
>> raw clock. So they would need to have that error added as well,
>> otherwise the raw and a otherwise non-adjusted monotonic clock would
>> drift.
>>
>> However, to be correct, the ntp adjustments made would have to be made
>> to both the base interval + error, which mucks the math up a fair bit.
>
> Hmm, confused as usual. Why would you need to do anything like that?

Because the NTP adjustment is done off of what is now the raw clock.
If the raw clock is "corrected" the ppb adjustment has to be done off
of that corrected rate.

Otherwise with no correction, the raw clock and the monotonic clock
would drift apart.

thanks
-john
