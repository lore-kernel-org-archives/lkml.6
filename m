Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C84C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BB3214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 18:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BB3214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeKLEjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 23:39:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40747 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbeKLEjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 23:39:35 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wABIniOV3349172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 11 Nov 2018 10:49:45 -0800
Subject: Re: PLEASE REVERT URGENTLY: Re: [PATCH v5 2/3] x86/boot: add acpi
 rsdp address to setup_header
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, corbet@lwn.net,
        boris.ostrovsky@oracle.com
References: <20181010061456.22238-1-jgross@suse.com>
 <20181010061456.22238-3-jgross@suse.com>
 <f7c78ee7-b548-7f04-24da-7321b6c64c97@zytor.com>
 <bd2d17cd-072c-cad6-94ad-52373700a1c9@suse.com>
 <2934552c-d150-0afb-6fa9-9398cb94d86a@zytor.com>
 <5a2f5cb8-7332-f490-eabf-cfcbdcd1abc4@suse.com>
 <59ca1053-9176-f1db-6e6c-96b47aaaa09d@zytor.com>
 <f16c53a4-7a5c-de01-c3cc-095226f6ca40@suse.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3e773a2d-3f69-5ccd-7d8b-9878fba30d00@zytor.com>
Date:   Sun, 11 Nov 2018 10:49:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <f16c53a4-7a5c-de01-c3cc-095226f6ca40@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/18 1:03 AM, Juergen Gross wrote:
> 
> How would that help? The garabge data written could have the correct
> terminal sentinel value by chance.
> 
> That's why I re-used an existing field in setup_header (the version) to
> let grub tell the kernel which part of setup_header was written by grub.
> 
> That's the only way I could find to let the kernel distinguish between
> garbage and actual data.

There is plenty of space *before* the setup_header part of struct boot_params
too -- look a the various __pad fields, especially (in your case), __pad3[16]
and __pad4[116] would suit the bill just fine.

>> It would be enormously helpful if you could find out any more details about
>> exactly what they are doing to break things.
> 
> That's easy:
> 
> The memory layout is:
> 
> 0x1f1 bytes of data, including the sentinel, the setup_header, and then
> more data.
> 
> grub did read the kernel's setup_header in the correct size into its
> buffer (which contains random garbage before that), intializes the first
> 0x1f1 including the sentinel byte, and then writes back the buffer, but
> using a too large length for that.

Are you kidding me... it really overwrites it with completely random data, and
not simply overspilling contents of the file?

In that case it might not be possible (or desirable) to use those N bytes
following the setup_heaader, or we need to a bigger sentinel than one byte
(probability being what it is, 256^n gets to be a pretty big number for any n,
very quickly drowning in the noise compared to other potential sources of boot
failures, and most likely less fatal than most.)

How big is this garbage dump?  I'm going to brave a guess it is 512 bytes.  In
that case this is hardly a big deal: the E820 map begins at 0x290, and the
setup_header maximum goes to 0x280, so it is only 15 bytes lost.  If it is
worse than that, we would risk losing __pad8[48] and __pad9[276], and
especially the latter would be painful. In those case perhaps we should use
0x281..0x290 as a 15-byte sentinel; that is going to be virtually foolproof.

I'm also thinking that it might be desirable to add a flags field (__pad2
would be ideal) to struct boot_params; it would let us recycle some of the
obsolete fields (hd0_info, hd1_info, sys_desc_table, olpc_ofw_header, ...) and
perhaps be able to add some more robustness against these sort of things. This
would be the right way to do what your version feedback mechanism would do.

The reason why the feedback mechanism is fundamentally broken is that it only
gives the boot loader a way to assert that it supports a certain version of
the protocol, but it doesn't say *which* bootloader does such an assert -- and
therefore it is still wide open to implementation error.

We do, in fact, already have a feedback mechanism: the bootloader ID and
bootloader version. One way we could deal with this problem is to bump the
bootloader version reported by Grub, and add a quirk to the kernel that if the
bootloader ID is Grub (7) and the version is less than a certain number, zero
those fields. In fact, the more I think about it, this is what we should do.

That being said, Grub really needs to be kept honest.  They keep making both
severe design (like refusing to use the BIOS and UEFI entry points provided by
the kernel by default) and implementation errors, apparently without
meaningful oversight. I really ask that the people more closely involved with
Grub try to keep a closer eye on their code as it applies to Linux.

	-hpa
