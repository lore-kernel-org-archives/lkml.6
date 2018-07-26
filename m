Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D234CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D56920852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D56920852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeGZDf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:35:27 -0400
Received: from ozlabs.org ([203.11.71.1]:43657 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbeGZDf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:35:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41bbRq179Qz9ryl;
        Thu, 26 Jul 2018 12:20:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>
Cc:     linux-kernel@vger.kernel.org,
        Alastair D'Silva <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/7] powerpc: Modernize unhandled signals message
In-Reply-To: <20180725193647.GA23643@kermit-br-ibm-com>
References: <20180724192720.32417-1-muriloo@linux.ibm.com> <0f185351330a7f1d66409fe6a2dc02aae6826039.camel@neuling.org> <20180725193647.GA23643@kermit-br-ibm-com>
Date:   Thu, 26 Jul 2018 12:20:52 +1000
Message-ID: <87wotihh4r.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
> On Wed, Jul 25, 2018 at 05:00:21PM +1000, Michael Neuling wrote:
>>  On Tue, 2018-07-24 at 16:27 -0300, Murilo Opsfelder Araujo wrote:
>> > This series was inspired by the need to modernize and display more
>> > informative messages about unhandled signals.
...
>> 
>> Nice.. the instruction dump would have been very handy when debugging the PCR
>> init issue I had a month or so back.

These things may be related :)

>> What happens if we get a sudden flood of these from different processes that
>> overlap their output? Are we going to be able to match up the process with
>> instruction dump?
>
> As to the flood of messages, ___ratelimit() makes me think that we'll
> likely see some warn messages informing how many show_signal_msg()
> callbacks were suppressed, instead of interleaved messages and
> instruction dumps.
>
> As to matching process with instruction dump, I believe we'd need more
> information to glue them together.
>
> What if we modify show_instructions() to accept a string prefix to be
> printed along with each line?
>
>> Should we prefix every line with the PID to avoid this?
>
> That's possible.  An alternative would be prefixing each line with the
> process name and its PID, as in the first line.  For example:
>
>     pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
>     pandafault[10758]: Instruction dump:
>     pandafault[10758]: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>     pandafault[10758]: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
>
> The above can be interleaved with other messages and we'll still be able
> to match process and its corresponding instruction dump.

Yeah prefixing with the comm and pid is nice.

Also the "Instruction dump:" line is a waste of space.

I prefer the x86 format, where it's prefixed with "code:", eg:

  pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
  pandafault[10758]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
  pandafault[10758]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

cheers
