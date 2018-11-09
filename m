Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E1FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F237620825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F237620825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeKJGyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:54:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47255 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeKJGyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:54:02 -0500
Received: from hanvin-mobl2.amr.corp.intel.com (fmdmzpr03-ext.fm.intel.com [192.55.54.38])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wA9LAn272522899
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 9 Nov 2018 13:10:50 -0800
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
To:     Li Zhijian <zhijianx.li@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org,
        bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        QEMU Developers <qemu-devel@nongnu.org>,
        Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
 <CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
 <c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
 <20181109072015.GA86700@gmail.com>
 <38905d35-29af-b522-1629-b13e98a47a42@intel.com>
 <d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
 <b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
Date:   Fri, 9 Nov 2018 13:10:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 5:40 AM, Li Zhijian wrote:
> Just noticed that there is a field xloadflags at recent protocol
>   60 Protocol 2.12:  (Kernel 3.8) Added the xloadflags field and
> extension fields
>   61                 to struct boot_params for loading bzImage and ramdisk
>   62                 above 4G in 64bit.
> [snip]
>  617 Field name:     xloadflags
>  618 Type:           read
>  619 Offset/size:    0x236/2
>  620 Protocol:       2.12+
>  621
>  622   This field is a bitmask.
>  623
>  624   Bit 0 (read): XLF_KERNEL_64
>  625         - If 1, this kernel has the legacy 64-bit entry point at
> 0x200.
>  626
>  627   Bit 1 (read): XLF_CAN_BE_LOADED_ABOVE_4G
>  628         - If 1, kernel/boot_params/cmdline/ramdisk can be above 4G.
>  629
> 
> maybe we can reuse this field and append a new Bit 5
> XLF_INITRD_MAX_SIZE_4G and increase header version.
> For the old protocol version 2.12+, if  XLF_CAN_BE_LOADED_ABOVE_4G is
> set, we can also realize ~4GB initrd is allowed.
> 
> bootloader side:
> if protocol >= 2.15
>    if XLF_INITRD_LOAD_BELOW_4G
>       support ~4G initrd
>    fi
> else if protocol >=2.12
>    if XLF_CAN_BE_LOADED_ABOVE_4G
>     support ~4G initrd
>    fi
> fi
> 

The two are equivalent.  Obviously you have to load above 4 GB if you
have more than 4 GB of initrd.  If XLF_CAN_BE_LOADED_ABOVE_4G is not
set, then you most likely are on a 32-bit kernel and there are more
fundamental limits (even if you were to load it above the 2 GB mark, you
would be limited by the size of kernel memory.)

So, in case you are wondering: the bootloader that broke when setting
the initrd_max field above 2 GB was, of course, Grub.

So just use XLF_CAN_BE_LOADED_ABOVE_4G. There is no need for a new flag
or new field.

Also note that the ext_ramdisk_image and ext_ramdisk_size are part of
struct boot_params as opposed to struct setup_header, which means that
they are not supported when entering via the 16-bit BIOS entry point,
and I am willing to bet that there will be, ahem, "strangeness" if
entered via the 32-bit entry point if at least the command line is
loaded above the 4 GB mark; the initrd should be fine, though.

This is obviosly not an issue in EFI environments, where we enter
through the EFI handover entry point.

The main reason these were not added to struct setup_header is that
there are only 24 bytes left in that header and so space is highly
precious. One way to deal with that if we really, really need to would
be to add an initrd/initramfs type of setup_data.

	-hpa
