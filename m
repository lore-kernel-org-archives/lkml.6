Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EBDC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FAA24458
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FAA24458
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754340AbeFVPGG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:06:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32967 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751295AbeFVPGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:06:05 -0400
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w5MF5wmo112570
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 22 Jun 2018 08:05:59 -0700
Date:   Fri, 22 Jun 2018 08:05:52 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrVNGjdLv4zde=qz6kJW55yZxXvLqoHxbRpQCr==gW6gBQ@mail.gmail.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com> <20180621211754.12757-8-h.peter.anvin@intel.com> <CALCETrVNGjdLv4zde=qz6kJW55yZxXvLqoHxbRpQCr==gW6gBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 7/7] x86/ldt,ptrace: provide regset access to the LDT
To:     Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <h.peter.anvin@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
From:   hpa@zytor.com
Message-ID: <8991CF11-DDE0-4E93-B913-82968DCFB661@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 22, 2018 7:49:13 AM PDT, Andy Lutomirski <luto@kernel.org> wrote:
>On Thu, Jun 21, 2018 at 2:18 PM H. Peter Anvin, Intel
><h.peter.anvin@intel.com> wrote:
>>
>> From: "H. Peter Anvin" <hpa@linux.intel.com>
>>
>> Provide ptrace/regset access to the LDT, if one exists.  This
>> interface provides both read and write access. The write code is
>> unified with modify_ldt(); the read code doesn't have enough
>> similarity so it has been kept made separate.
>
>For this and for the GDT, you've chosen to use struct user_desc as
>your format instead of using a native hardware descriptor format.  Any
>particular reason why?  If nothing else, it will bloat core files a
>bit more than needed.

I did because REGSET_TLS was implemented that way, and that is simply a subset of the GDT (which made the same code trivially applicable to both.) modify_ldt() does it *both* ways for extra fun (one for reading, and one for writing.)

->active is defined as "beyond this point the regset contains only the default value", which seemed appropriate in this case.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
