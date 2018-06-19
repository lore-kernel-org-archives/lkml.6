Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB9EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C48205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C48205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mielke.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966775AbeFSPaJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:30:09 -0400
Received: from nimbus1.mmprivatehosting.com ([54.208.90.49]:54318 "EHLO
        nimbus1.mmprivatehosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966502AbeFSPaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:30:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTP id D9EB060028;
        Tue, 19 Jun 2018 15:30:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at mmprivatehosting.com
Received: from dave.mielke.cc (CPEc8be196b689f-CMac202ebc50a0.cpe.net.cable.rogers.com [174.115.138.203])
        (Authenticated sender: relay@dave.mielke.cc)
        by nimbus1.mmprivatehosting.com (Postfix) with ESMTPA;
        Tue, 19 Jun 2018 15:30:06 +0000 (UTC)
Received: from beta.private.mielke.cc (beta.private.mielke.cc [192.168.0.2])
        by dave.mielke.cc (Postfix) with ESMTPS id DD72F4B2;
        Tue, 19 Jun 2018 11:30:05 -0400 (EDT)
Received: from beta.private.mielke.cc (localhost [127.0.0.1])
        by beta.private.mielke.cc (8.15.2/8.15.2) with ESMTP id w5JFU5bS002918;
        Tue, 19 Jun 2018 11:30:05 -0400
Received: (from dave@localhost)
        by beta.private.mielke.cc (8.15.2/8.15.2/Submit) id w5JFU4QS002917;
        Tue, 19 Jun 2018 11:30:04 -0400
Date:   Tue, 19 Jun 2018 11:30:04 -0400
From:   Dave Mielke <Dave@mielke.cc>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] have the vt console preserve unicode characters
Message-ID: <20180619153004.GA2677@beta.private.mielke.cc>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org>
 <20180619130953.bxil552igfkckjmr@angband.pl>
 <20180619135213.GB2563@beta.private.mielke.cc>
 <20180619151459.3il7hfdqyucit57o@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180619151459.3il7hfdqyucit57o@angband.pl>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[quoted lines by Adam Borowski on 2018/06/19 at 17:14 +0200]

>> Not at all. We braille users, especially when working with languages other than
>> English, need more than 256 non-braille characters. Even for those who can live
>> with just 256 non-braille characters, it's still a major pain having to come up
>> with a usable braille-capable font for every needed 256 non-braille characters
>> set. I can assure you, as an actual braille user, that the limitation has been
>> a very long-standing problem and it's a great relief that it's finally been
>> resolved.
>
>Ok, I thought Braille is limited to 2x3 dots, recently extended to 2x4;
>thanks for the explanation!

Yes, that's correct, but we do things like use a single braille cell to mean
more than one thing and figure out which it is by context. That', for example,
is how we handle box drawing characters. Also, for another example, we can tell
based on which language we're currently reading.

>But those of us who are sighted, are greatly annoyed by characters that are
>usually taken for granted being randomly missing.  For example, no console
>font+mapping shipped with Debian supports ░▒▓▄▀ (despite them being a
>commonly used part of the BIOS charset), so unless you go out of your way to
>beat them back they'll be corrupted (usually into ♦).  Then Perl6 wants ｢｣⚛,
>and so on.  All these problems would instantly disappear the moment console
>sheds the limit of 256/512 glyphs.

Yes, it's really the very same problem. It's just a little more annoying, I
think, in braille since, if we want the 256 braille cell characters, we need to
give up 256 useful non-braille characters.

>So I'm pretty happy seeing this patch set.

So am I! :-)

-- 
I believe the Bible to be the very Word of God: http://Mielke.cc/bible/
Dave Mielke            | 2213 Fox Crescent | WebHome: http://Mielke.cc/
EMail: Dave@Mielke.cc  | Ottawa, Ontario   | Twitter: @Dave_Mielke
Phone: +1 613 726 0014 | Canada  K2A 1H7   |
