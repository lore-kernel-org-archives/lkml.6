Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F115FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C3E20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f6eWLktr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kuAfSeG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C3E20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936079AbeFMPRd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:17:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39076 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935898AbeFMPRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:17:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9802A60385; Wed, 13 Jun 2018 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528903050;
        bh=4lZrBOwRPj3Edwm/u+r0Bwzyd4chLKaj4gBJ/gi6WOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f6eWLktr1/LCBM5kKNP60taWOQQu8KdDFJ8iqczJnjwaQ5tITLV2cOHvfBm1W4/Nf
         MOdFO3NAamtgYRLlFQ7DUXFnJsN9kH76SEDiJf6aigROL6Q2uE7I+qbS2WNK4jFBo7
         ePMknnvL3XNRg8dd/3Nx8ErrPbXwnNk+bEUGc58U=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3644960351;
        Wed, 13 Jun 2018 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528903049;
        bh=4lZrBOwRPj3Edwm/u+r0Bwzyd4chLKaj4gBJ/gi6WOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kuAfSeG6QL7JQiDl+vM+JJztH/9TyK4x2VC8/T2hjfv39qipCKGsgJyeu9qn0LUy0
         Q5ZOxVgv+/bnOSSutTqDFYg64yRtNKvEljKCDUzmDTfAiXxyfHg72/wjE4wtcF+bBs
         Hs9YF4yp+Mwr4KseuvnoOzqb4oBDG37QP3VvUYFs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Jun 2018 11:17:29 -0400
From:   okaya@codeaurora.org
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
In-Reply-To: <CAKv+Gu8UG_D0AAR8Usdi7DrucqaEs+f-JTU1voR-CcrtNY2ZEQ@mail.gmail.com>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
 <26470c5c-55db-9dff-3794-4e4a96c8bcb6@codeaurora.org>
 <CAKv+Gu8UG_D0AAR8Usdi7DrucqaEs+f-JTU1voR-CcrtNY2ZEQ@mail.gmail.com>
Message-ID: <442896963833043f84dd9d0c14d88351@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-13 11:06, Ard Biesheuvel wrote:
> On 13 June 2018 at 16:22, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Hi Ard,
>> 
>> On 5/18/2018 10:17 AM, Sinan Kaya wrote:
>>> A host bridge is allowed to remap BAR addresses using _TRA attribute 
>>> in
>>> _CRS windows.
>>> 
>>> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff 
>>> window] (bus address [0x00100000-0x1fffffff])
>>> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>>> 
>>> When a VGA device is behind such a host bridge and the resource is
>>> translated efifb driver is trying to do ioremap against bus address
>>> rather than the resource address and is failing to probe.
>>> 
>>> efifb: probing for efifb
>>> efifb: cannot reserve video memory at 0x1e000000
>>> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
>>> efifb: mode is 800x600x32, linelength=3200, pages=1
>>> efifb: scrolling: redraw
>>> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>>> 
>>> Use the host bridge offset information to convert bus address to
>>> resource address in the fixup.
>>> 
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> ---
>> 
>> I didn't see any messages about these getting picked up for 4.18.
>> 
>> Are they queued on your own branch?
>> 
> 
> No, you never cc'ed me on them until now.

Ouch, I hoped that you would get it via get_maintainer script. Sorry for 
that.
