Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41415C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1045620827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1045620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbeKFBSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:18:39 -0500
Received: from tartarus.angband.pl ([54.37.238.230]:35930 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbeKFBSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:18:39 -0500
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1gJhGZ-0001zh-CP; Mon, 05 Nov 2018 16:58:15 +0100
Date:   Mon, 5 Nov 2018 16:58:15 +0100
From:   Adam Borowski <kilobyte@angband.pl>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     linux-mm@kvack.org, open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org
Subject: Re: Creating compressed backing_store as swapfile
Message-ID: <20181105155815.i654i5ctmfpqhggj@angband.pl>
References: <CAOuPNLjuM5qq3go9ZFZcK0G5pQxTQb0DY36xu+8SL4vC4zJntw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuPNLjuM5qq3go9ZFZcK0G5pQxTQb0DY36xu+8SL4vC4zJntw@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 08:31:46PM +0530, Pintu Agarwal wrote:
> Hi,
> 
> I have one requirement:
> I wanted to have a swapfile (64MB to 256MB) on my system.
> But I wanted the data to be compressed and stored on the disk in my swapfile.
> [Similar to zram, but compressed data should be moved to disk, instead of RAM].
> 
> Note: I wanted to optimize RAM space, so performance is not important
> right now for our requirement.
> 
> So, what are the options available, to perform this in 4.x kernel version.
> My Kernel: 4.9.x
> Board: any - (arm64 mostly).
> 
> As I know, following are the choices:
> 1) ZRAM: But it compresses and store data in RAM itself
> 2) frontswap + zswap : Didn't explore much on this, not sure if this
> is helpful for our case.
> 3) Manually creating swapfile: but how to compress it ?
> 4) Any other options ?

Loop device on any filesystem that can compress (such as btrfs)?  The
performance would suck, though -- besides the indirection of loop, btrfs
compresses in blocks of 128KB while swap wants 4KB writes.  Other similar
option is qemu-nbd -- it can use compressed disk images and expose them to a
(local) nbd client.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ Have you heard of the Amber Road?  For thousands of years, the
⣾⠁⢰⠒⠀⣿⡁ Romans and co valued amber, hauled through the Europe over the
⢿⡄⠘⠷⠚⠋⠀ mountains and along the Vistula, from Gdańsk.  To where it came
⠈⠳⣄⠀⠀⠀⠀ together with silk (judging by today's amber stalls).
