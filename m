Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F35C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA5A20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA5A20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeGYIKo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:10:44 -0400
Received: from ozlabs.org ([203.11.71.1]:59791 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbeGYIKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:10:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id 41b5hj5qqKz9s1x;
        Wed, 25 Jul 2018 17:00:21 +1000 (AEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id BF7FAEE78BF; Wed, 25 Jul 2018 17:00:21 +1000 (AEST)
Message-ID: <0f185351330a7f1d66409fe6a2dc02aae6826039.camel@neuling.org>
Subject: Re: [PATCH 0/7] powerpc: Modernize unhandled signals message
From:   Michael Neuling <mikey@neuling.org>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Alastair D'Silva <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 25 Jul 2018 17:00:21 +1000
In-Reply-To: <20180724192720.32417-1-muriloo@linux.ibm.com>
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, 2018-07-24 at 16:27 -0300, Murilo Opsfelder Araujo wrote:
> Hi, everyone.
> 
> This series was inspired by the need to modernize and display more
> informative messages about unhandled signals.
> 
> The "unhandled signal NN" is not very informative.  We thought it would
> be helpful adding a human-readable message describing what the signal
> number means, printing the VMA address, and dumping the instructions.
> 
> We can add more informative messages, like informing what each code of a
> SIGSEGV signal means.  We are open to suggestions.
> 
> I have collected some early feedback from Michael Ellerman about this
> series and would love to hear more feedback from you all.

Nice.. the instruction dump would have been very handy when debugging the PCR
init issue I had a month or so back.

> Before this series:
> 
>     Jul 24 13:01:07 localhost kernel: pandafault[5989]: unhandled signal 11 at 00000000100007d0 nip 000000001000061c lr 00003fff85a75100 code 2
> 
> After this series:
> 
>     Jul 24 13:08:01 localhost kernel: pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
>     Jul 24 13:08:01 localhost kernel: Instruction dump:
>     Jul 24 13:08:01 localhost kernel: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>     Jul 24 13:08:01 localhost kernel: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

What happens if we get a sudden flood of these from different processes that
overlap their output? Are we going to be able to match up the process with
instruction dump?

Should we prefix every line with the PID to avoid this?

Mikey
