Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D1E8DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAD520891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NDjfecgC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A6c5O/w+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAD520891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935975AbeFMP3s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:29:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47770 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935691AbeFMP3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:29:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 93B69607E4; Wed, 13 Jun 2018 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528903785;
        bh=w8R8PRtDH1eStbOmAhiPpB1ROXDe2l1AVqLT4aDqdrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NDjfecgCPylx+oE9K93ZUweW+ZRMXp1nDKGLXbiBbp2NsZQhLw/JIl9tWUoyP+D0O
         954ggKakxQ5ETOqk+DM0k0Gkke9VPmj072OZHCGOr6w+wkdzK08QkI80Ebp1KOoIjY
         2WwDuMXErTkC7fYNP4qQ16ymKyD7OzgMOye+d3NE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B4207602FC;
        Wed, 13 Jun 2018 15:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528903784;
        bh=w8R8PRtDH1eStbOmAhiPpB1ROXDe2l1AVqLT4aDqdrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A6c5O/w+38bPVL/xwGMkXSEL0qxKVr27a3LpqlmXseMEQ09qyB1Tt9NgmSaoOs4VA
         gmWx/NHUG4nricGB+L4LnLyjCid3ylVO4nZ1qtjYsBk66NpTqI+bl+gPsh3W5mtkzP
         6PT1alqUyBFt7LlomLy/25e8q9NKdNfs7Nd/vFg0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Jun 2018 11:29:44 -0400
From:   okaya@codeaurora.org
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Peter Jones <pjones@redhat.com>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
In-Reply-To: <CAKv+Gu_ZRNvW9CeqRyUpQGnrkkoOi1Hh08re=_Gz=EGVTAvbsA@mail.gmail.com>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
 <26470c5c-55db-9dff-3794-4e4a96c8bcb6@codeaurora.org>
 <CAKv+Gu8UG_D0AAR8Usdi7DrucqaEs+f-JTU1voR-CcrtNY2ZEQ@mail.gmail.com>
 <442896963833043f84dd9d0c14d88351@codeaurora.org>
 <CAKv+Gu_ZRNvW9CeqRyUpQGnrkkoOi1Hh08re=_Gz=EGVTAvbsA@mail.gmail.com>
Message-ID: <2be0216f218f9635595f39a8da3afad7@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-13 11:22, Ard Biesheuvel wrote:
> On 13 June 2018 at 17:17,  <okaya@codeaurora.org> wrote:
>> On 2018-06-13 11:06, Ard Biesheuvel wrote:
>>> 
>>> On 13 June 2018 at 16:22, Sinan Kaya <okaya@codeaurora.org> wrote:
>>>> 
>>>> Hi Ard,
>>>> 
>>>> On 5/18/2018 10:17 AM, Sinan Kaya wrote:
>>>>> 
>>>>> A host bridge is allowed to remap BAR addresses using _TRA 
>>>>> attribute in
>>>>> _CRS windows.
>>>>> 
>>>>> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff
>>>>> window] (bus address [0x00100000-0x1fffffff])
>>>>> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>>>>> 
>>>>> When a VGA device is behind such a host bridge and the resource is
>>>>> translated efifb driver is trying to do ioremap against bus address
>>>>> rather than the resource address and is failing to probe.
>>>>> 
>>>>> efifb: probing for efifb
>>>>> efifb: cannot reserve video memory at 0x1e000000
>>>>> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
>>>>> efifb: mode is 800x600x32, linelength=3200, pages=1
>>>>> efifb: scrolling: redraw
>>>>> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>>>>> 
>>>>> Use the host bridge offset information to convert bus address to
>>>>> resource address in the fixup.
>>>>> 
>>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>>> ---
>>>> 
>>>> 
>>>> I didn't see any messages about these getting picked up for 4.18.
>>>> 
>>>> Are they queued on your own branch?
>>>> 
>>> 
>>> No, you never cc'ed me on them until now.
>> 
>> 
>> Ouch, I hoped that you would get it via get_maintainer script. Sorry 
>> for
>> that.
> 
> Actually, get_maintainer is right: this should go through the fbdev
> tree not the EFI tree
> 
> Were you going to resend them? If not, I can find them in my archive
> and ack them, and we will ask Bartlomiej to take them for v4.19

I prefer ack rather than resend to be honest.
