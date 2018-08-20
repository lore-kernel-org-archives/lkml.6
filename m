Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD38DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6FF20C07
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6FF20C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeHTErC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 00:47:02 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:42998 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725745AbeHTErC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 00:47:02 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1frZ4J-0007Ho-AW; Mon, 20 Aug 2018 03:33:19 +0200
Date:   Mon, 20 Aug 2018 03:33:19 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from Linus' tree
Message-ID: <20180820013319.slygmbleia55evtl@angband.pl>
References: <20180820081323.23a47af3@canb.auug.org.au>
 <CA+55aFw4WcLcFJkoWoE2v--J3s2Hk8JBU92=Zh351FH7xY8zpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+55aFw4WcLcFJkoWoE2v--J3s2Hk8JBU92=Zh351FH7xY8zpw@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 04:21:57PM -0700, Linus Torvalds wrote:
> On Sun, Aug 19, 2018 at 3:13 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next build (powerpc ppc64_defconfig) produced these
> > warnings:
> >
> > fs/cifs/cifssmb.c:605:3: warning: 'strncpy' writing 16 bytes into a region of size 1 overflows the destination [-Wstringop-overflow=]
> >    strncpy(pSMB->DialectsArray+count, protocols[i].name, 16);
> >
> > Presumably caused by my update to gcc 8.2.0.
> 
> Yeah. There are some patches to mark some arrays as non-strings to get
> rid of these, but we'll see. Maybe we'll just disable the new gcc
> warning if it causes more pain than it is worth.

Every single use of strncpy() for a C string is either a bug, inefficiency,
or both.  In this particular case the code:

        count = 0;
        for (i = 0; i < CIFS_NUM_PROT; i++) {
                strncpy(pSMB->DialectsArray+count, protocols[i].name, 16);
                count += strlen(protocols[i].name) + 1;
                /* null at end of source and target buffers anyway */
        }

* pointlessly clears 16 bytes in every iteration
* calculates the string's length twice
* there's no protection against buffer overflow anyway

So what is the strncpy() there for, when an unbounded copy would be just as
good?  For other cases, there's a bunch of better functions: strlcpy(),
snprintf(), even strlen()+memcpy(), etc.

Valid uses of strncpy() do exist (such as SCSI structs), but those deal with
fixed-width fields.  Thus, gcc is right for warning for at least some of
misuse of strncpy() for C strings.  The function wasn't designed for them.

(Skipped analysis why strncpy is always a bad choice for C strings.)


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ What Would Jesus Do, MUD/MMORPG edition:
⣾⠁⢰⠒⠀⣿⡁ • multiplay with an admin char to benefit your mortal [Mt3:16-17]
⢿⡄⠘⠷⠚⠋⠀ • abuse item cloning bugs [Mt14:17-20, Mt15:34-37]
⠈⠳⣄⠀⠀⠀⠀ • use glitches to walk on water [Mt14:25-26]
