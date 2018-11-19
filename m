Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989E5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659822080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659822080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbeKTHO1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:14:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36205 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730797AbeKTHO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:14:27 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wAJKmu5I2716553
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 19 Nov 2018 12:48:56 -0800
Date:   Mon, 19 Nov 2018 12:48:49 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20181119204025.GL14688@zn.tnic>
References: <20181119184556.11479-1-bp@alien8.de> <CALCETrV34q-BP2w8A1s82-a8Hg062=RYzk+SCOa31W7ftsznPA@mail.gmail.com> <a1b79c06-ab34-e774-df6b-c98323b13bae@zytor.com> <20181119204025.GL14688@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86/TSC: Use RDTSCP
To:     Borislav Petkov <bp@alien8.de>
CC:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Tom Lendacky <Thomas.Lendacky@amd.com>
From:   hpa@zytor.com
Message-ID: <F724A9C4-BA69-4713-B267-11547832F8FB@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 19, 2018 12:40:25 PM PST, Borislav Petkov <bp@alien8.de> wrote:
>On Mon, Nov 19, 2018 at 12:17:35PM -0800, H. Peter Anvin wrote:
>> On 11/19/18 11:52 AM, Andy Lutomirski wrote:
>> > 
>> > I thought I benchmarked this on Intel at some point and found the
>> > LFENCE;RDTSC variant to be slightly faster.  But I believe you, so:
>> > 
>> > Acked-by: Andy Lutomirski <luto@kernel.org>
>> > 
>> 
>> As long as the difference isn't significant, the simplicity would
>seem to be a
>> win.
>
>Right, I think by simplicity you mean RDTSCP. :)
>
>Also in the sense that you have a single instruction which gives you
>that barrier of waiting for all older insns to retire before reading
>the
>TSC vs two where you don't necessarily know what happens on the uarch
>level. I mean, nothing probably happens but RDTSCP is still simpler :)
>
>Also, hpa, isn't LFENCE; RDTSC and RDTSCP equivalent on Intel? In the
>sense that RDTSCP microcode practically adds an LFENCE before reading
>the TSC?
>
>Because SDM says:
>
>"The RDTSCP instruction is not a serializing instruction, but it does
>wait until all previous instructions have executed and all previous
>loads are globally visible."
>
>which sounds pretty much like an LFENCE to me:
>
>"LFENCE does not execute until all prior instructions have completed
>locally, and no later instruction begins execution until LFENCE
>completes."

I don't know the exact sequence of fencing operations it is equivalent to, but it is probably something quite similar.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
