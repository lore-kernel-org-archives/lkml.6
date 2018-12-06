Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BAEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFA620892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFA620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbeLFMfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:35:04 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:42044 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbeLFMfE (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 6 Dec 2018 07:35:04 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Thu, 06 Dec 2018 13:35:01 +0100
Received: from [192.168.1.132] (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Thu, 06 Dec 2018 10:28:08 +0000
Message-ID: <1544092087.5492.3.camel@suse.com>
Subject: Re: [PATCH] Revert "firmware: dmi_scan: Use lowercase letters for
 UUID"
From:   Jean Delvare <jdelvare@suse.com>
To:     Peter Korsgaard <peter@korsgaard.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 06 Dec 2018 11:28:07 +0100
In-Reply-To: <87a7ljyppx.fsf@dell.be.48ers.dk>
References: <20181205211351.5309-1-peter@korsgaard.com>
         <1544086444.5492.1.camel@suse.com> <87a7ljyppx.fsf@dell.be.48ers.dk>
Organization: Suse Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 10:22 +0100, Peter Korsgaard wrote:
> > > > > > "Jean" == Jean Delvare <jdelvare@suse.com> writes:
> 
>  > On Wed, 2018-12-05 at 22:13 +0100, Peter Korsgaard wrote:
>  >> This reverts commit 712ff25450bd01366301eef81c33e865d901e7b7.
>  >> 
>  >> The output of dmi_save_uuid() is exposed to user space as
>  >> /sys/devices/virtual/dmi/id/*_uuid, so this breaks backwards compatibility,
>  >> E.G.  I have systems that include the content of dmi/id/product_uuid as part
>  >> of the keyphrase for cryptsetup luksOpen.
>  >> 
>  >> As the change was purely cosmetical, revert it to fix such breakage.
> 
>  > The change is not "cosmetical". The change was done to comply with RFC
>  > 4122:
> 
>  > https://tools.ietf.org/html/rfc4122
> 
>  >   The hexadecimal values "a" through "f" are output as
>  >   lower case characters and are case insensitive on input.
> 
> I get that - but it changes the content of sysfs entries, breaking real
> systems - E.G. a user space ABI regression.

I know it's very convenient to play the "user-space ABI regression"
card whenever you want a change reverted. However the interface itself
did not change. The sysfs file name did not change, the nature of its
contents did not change. The only thing which changed is the exact
contents details of the file. In my opinion that does not qualify as an
"ABI regression".

> It is a cosmetic code change in the sense that no known software was
> broken with the upper case characters.

It bothered someone enough to create a ticket asking me to fix it in
dmidecode:
https://savannah.nongnu.org/bugs/index.php?53569

And it wouldn't make sense that the kernel uses a different format from
dmidecode.

>  > If "cryptsetup luksOpen" does not lowercase digits before computing its
>  > key passphrase, then it's not RFC 4122-compliant and should be fixed.
> 
> cryptsetup naturally doesn't know anything about RFC 4122. It just reads
> a disk encryption keyphrase which happen to include the content of
> id/product_uuid because of my scripts.

OK, so basically your script infringes RFC 4122, and instead of fixing
that, you ask me to stop respecting that RFC on my side.

Out of curiosity, what's the purpose of your encryption strategy? That
someone who would open your computer and steal only the disk (as
opposed to stealing the whole computer) would be unable to read the
disk's contents? Do thieves really do that?

>  > Nak. This is too late. Changing it again would just add confusion.
> 
> Please reconsider. 4.17 is from June, and 4.19 has only recently become
> LTS.

I can't see how this is related with kernel 4.19 becoming LTS.

My patch has been public since April 8th, 2018. It has been in 3
official kernel versions already. I did not hear any complaint about
that change in 8 months. You are the first one to complain, and that's
about a custom script that's not RFC-compliant and that you could fix
with a one-liner.

Look, you can imagine that I was perfectly aware of what I was doing
when I made that change, and that I pondered the decision carefully at
that time. And my decision was that the change should be made. As far
as I'm concerned, this ship has sailed already, sorry.

-- 
Jean Delvare
SUSE L3 Support
