Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67971C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 01:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E7620671
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 01:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E7620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389266AbeG1Cxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 22:53:41 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:40386 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388893AbeG1Cxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 22:53:41 -0400
Received: from nctu-wireless-nat219.nctu.edu.tw ([140.113.136.219] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fjE2c-0006BJ-VY; Sat, 28 Jul 2018 02:29:07 +0100
Message-ID: <1532741338.21552.55.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 15/47] ubi: fastmap: Correctly handle interrupted
 erasures in EBA
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Richard Weinberger <richard@nod.at>
Cc:     martin bayern <Martinbayern@outlook.com>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 28 Jul 2018 09:28:58 +0800
In-Reply-To: <2465050.YMUAORSpTR@blindfold>
References: <20180710182337.047502999@linuxfoundation.org>
         <20180710182337.780349008@linuxfoundation.org>
         <1532571174.21552.47.camel@codethink.co.uk> <2465050.YMUAORSpTR@blindfold>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-26 at 08:25 +0200, Richard Weinberger wrote:
> Ben,
> 
> Am Donnerstag, 26. Juli 2018, 04:12:54 CEST schrieb Ben Hutchings:
> > On Tue, 2018-07-10 at 20:24 +0200, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Richard Weinberger <richard@nod.at>
> > > 
> > > commit 781932375ffc6411713ee0926ccae8596ed0261c upstream.
> > > 
> > > Fastmap cannot track the LEB unmap operation, therefore it can
> > > happen that after an interrupted erasure the mapping still looks
> > > good from Fastmap's point of view, while reading from the PEB will
> > > cause an ECC error and confuses the upper layer.
> > > 
> > > Instead of teaching users of UBI how to deal with that, we read back
> > > the VID header and check for errors. If the PEB is empty or shows ECC
> > > errors we fixup the mapping and schedule the PEB for erasure.
> > 
> > [...]
> > 
> > Isn't there a risk here, that a read error leads to erasing data that
> > might be recoverable if the read is retried?
> 
> Well, read error means that already something went very wrong. At other places
> in UBI wo also don't retry reading headers and consider it as fatal when we 
> are unable to read it.
> We could also read the EC header, but what do we gain from that?
> If the VID header is not readable we cannot check fastmap either.
> 
> What case exactly do you have in mind?

I suppose I'm thinking about data recovery from a flash device that has
become unreliable.  I'm not familiar with ubi; is there a read-only
mode where the erase wouldn't actually be performed?

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
