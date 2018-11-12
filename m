Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD42C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCDF21722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCDF21722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbeKLPx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 10:53:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51741 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731226AbeKLPxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 10:53:55 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wAC60lUC3546540
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 11 Nov 2018 22:00:47 -0800
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Li Zhijian <zhijianx.li@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org,
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
 <d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
 <20181112045624.GA28219@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <fcf1d6b5-e64f-3aea-f794-99237e1988cf@zytor.com>
Date:   Sun, 11 Nov 2018 22:00:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112045624.GA28219@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 8:56 PM, Ingo Molnar wrote:
> 
>> Also note that the ext_ramdisk_image and ext_ramdisk_size are part of
>> struct boot_params as opposed to struct setup_header, which means that
>> they are not supported when entering via the 16-bit BIOS entry point,
>> and I am willing to bet that there will be, ahem, "strangeness" if
>> entered via the 32-bit entry point if at least the command line is
>> loaded above the 4 GB mark; the initrd should be fine, though.
>>
>> This is obviosly not an issue in EFI environments, where we enter
>> through the EFI handover entry point.
>>
>> The main reason these were not added to struct setup_header is that
>> there are only 24 bytes left in that header and so space is highly
>> precious. One way to deal with that if we really, really need to would
>> be to add an initrd/initramfs type of setup_data.
> 
> Is there no way to extend that header by making an extended header part 
> of the payload?
> 
> IIRC that header is small and fixed size to be part of a single sector at 
> the very beginning of boot images, but accessing any extended header bits 
> from the payload section shouldn't really be an issue for a modern 
> bootloader to handle, right?
> 
> Such an extended header could use a more modern (self-extending) ABI as 
> well.
> 

Yes, although I don't really think it is as much of an issue as it seems at
this point.

The limit comes from having used a one-byte jump instruction at the beginning;
however, these days that limit is functionally walled.

It is of course possible to address this if it should become necessary,
however, the current protocol has lasted for 23 years so far and we haven't
run out yet, even with occasional missteps. As such, I don't think we are in a
huge hurry to address this particular aspect.

In part as a result of this exchange I have spent some time thinking about the
boot protocol and its dependencies, and there is, in fact, a much more serious
problem that needs to be addressed: it is not currently possible in a
forward-compatible way to map all data areas that may be occupied by
bootloader-provided data. The kernel proper has an advantage here, in that the
kernel will by definition always be the "owner of the protocol" (anything the
kernel doesn't know how to map won't be used by the kernel anyway), but it
really isn't a good situation. So I'm currently trying to think up a way to
make that possible.

	-hpa
