Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73130C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3404320846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3404320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbeGZD1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:27:32 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:45913 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbeGZD1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:27:32 -0400
Received: from nctu-wireless-nat219.nctu.edu.tw ([140.113.136.219] helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fiVlz-00051Q-RH; Thu, 26 Jul 2018 03:13:00 +0100
Message-ID: <1532571174.21552.47.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 15/47] ubi: fastmap: Correctly handle interrupted
 erasures in EBA
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     martin bayern <Martinbayern@outlook.com>,
        Richard Weinberger <richard@nod.at>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 26 Jul 2018 10:12:54 +0800
In-Reply-To: <20180710182337.780349008@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
         <20180710182337.780349008@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-10 at 20:24 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Richard Weinberger <richard@nod.at>
> 
> commit 781932375ffc6411713ee0926ccae8596ed0261c upstream.
> 
> Fastmap cannot track the LEB unmap operation, therefore it can
> happen that after an interrupted erasure the mapping still looks
> good from Fastmap's point of view, while reading from the PEB will
> cause an ECC error and confuses the upper layer.
> 
> Instead of teaching users of UBI how to deal with that, we read back
> the VID header and check for errors. If the PEB is empty or shows ECC
> errors we fixup the mapping and schedule the PEB for erasure.
[...]

Isn't there a risk here, that a read error leads to erasing data that
might be recoverable if the read is retried?

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
