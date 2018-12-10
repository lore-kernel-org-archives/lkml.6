Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BE0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614B12084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614B12084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbeLJUto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:49:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:53618 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJUtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:49:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wBAKnLNP015176;
        Mon, 10 Dec 2018 14:49:23 -0600
Message-ID: <8a2e104a6c5b745adca8e7f3310af564f3b8a75d.camel@kernel.crashing.org>
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>,
        Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Dec 2018 07:49:21 +1100
In-Reply-To: <20181210193317.GA31514@lst.de>
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
         <20181130103222.GA23393@lst.de>
         <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
         <42b1408cafe77ebac1b1ad909db237fe34e4d177.camel@kernel.crashing.org>
         <20181208171746.GB15228@lst.de>
         <CALjTZvb4+Ox5Jdm-xwQuxMDz_ub=mHAgPLA4NgrVNZTmUZwhnQ@mail.gmail.com>
         <20181210193317.GA31514@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 20:33 +0100, Christoph Hellwig wrote:
> On Mon, Dec 10, 2018 at 05:04:46PM +0000, Rui Salvaterra wrote:
> > Hi, Christoph and Ben,
> > 
> > It just came to my mind (and this is most likely a stupid question,
> > but still)… Is there any possibility of these changes having an
> > (positive) effect on the long-standing problem of Power Mac machines
> > with AGP graphics cards (which have to be limited to PCI transfers,
> > otherwise they'll hang, due to coherence issues)? If so, I have a G4
> > machine where I'd gladly test them.
> 
> These patches themselves are not going to affect that directly.
> But IFF the problem really is that the AGP needs to be treated as not
> cache coherent (I have no idea if that is true) the generic direct
> mapping code has full support for a per-device coherent flag, so
> support for a non-coherent AGP slot could be implemented relatively
> simply.

AGP is a gigantic nightmare :-) It's not just cache coherency issues
(some implementations are coherent, some aren't, Apple's is ... weird).

Apple has all sort of bugs, and Darwin source code only sheds light on
some of them. Some implementation can only read, not write I think, for
example. There are issues with transfers crossing some boundaries I
beleive, but it's all unclear.

Apple makes this work with a combination of hacks in the AGP "driver"
and the closed source GPU driver, which we don't see.

I have given up trying to make that stuff work reliably a decade ago :)

Cheers,
Ben.


