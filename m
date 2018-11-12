Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AC1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1122241E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1122241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeKMCmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:42:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36043 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeKMCmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:42:19 -0500
Received: from carbon-x1.hos.anvin.org ([199.167.24.132])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wACGlKpd3769132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 12 Nov 2018 08:47:28 -0800
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
References: <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
 <CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
 <c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
 <20181109072015.GA86700@gmail.com>
 <38905d35-29af-b522-1629-b13e98a47a42@intel.com>
 <d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
 <b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
 <d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
 <20181112045624.GA28219@gmail.com>
 <fcf1d6b5-e64f-3aea-f794-99237e1988cf@zytor.com>
 <20181112061940.GA61749@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <b78eb4e1-5671-f407-0779-0f1e893be272@zytor.com>
Date:   Mon, 12 Nov 2018 08:47:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112061940.GA61749@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 10:19 PM, Ingo Molnar wrote:
> 
>> In part as a result of this exchange I have spent some time thinking 
>> about the boot protocol and its dependencies, and there is, in fact, a 
>> much more serious problem that needs to be addressed: it is not 
>> currently possible in a forward-compatible way to map all data areas 
>> that may be occupied by bootloader-provided data. The kernel proper has 
>> an advantage here, in that the kernel will by definition always be the 
>> "owner of the protocol" (anything the kernel doesn't know how to map 
>> won't be used by the kernel anyway), but it really isn't a good 
>> situation. So I'm currently trying to think up a way to make that 
>> possible.
> 
> I might be a bit dense early in the morning, but could you elaborate? 
> What do you mean by mapping all data areas?

Alright, awake now...

As it sits right now, the protocol contains a number of data structures with
pointers, pointing to a variety of memory areas that can be set up by the
bootloader. Now, consider something like KASLR or a secondary boot loader
where we need to allocate memory in between the primary bootloader and the
kernel to be run. With the kernel proper, in the absence of KASLR, we have
solved this by marking out exactly how much memory the kernel may need before
it has its own memory manager up and running, but KASLR needs to move it
outside this range, and a secondary boot loader shim of some sort may need to
allocate additional data structures. In the particular case of an UEFI system
where we do the right thing (which Grub2 doesn't, by default) and enter via
the kernel UEFI stub we are okay, but for other boot scenarios we are in
trouble: even if we know where all the pointers are and how to determine the
size of various data structures, once the protocol is updated with new
information then that is no longer valid.

The setup_data linked list solves that under certain circumstances, but in
others it has turned out to not be adequate.

There are a couple of options:

a) Not allow any new pointers to memory areas in what is considered system
   RAM. Such data structures *must* have a setup_data linked list header.
   Pointers into E820 table reserved areas are still acceptable.

b) Create a new E820 table memory type for "boot data", similar to what UEFI
   already has, and encourage boot loaders to mark any allocated memory
   structures that way.  The main problem with that is that the poor quality
   of boot loaders may mean that that fails to happen, and because it wouldn't
   "fail hard" it is likely that they will get it wrong.

   The difference from the RESERVED memory type is that the kernel can reclaim
   that memory after the data has been recovered.

c) This might be the preferred option:

   1. Just like (a), do not allow new pointers to memory areas in system RAM
      in struct boot_params.
   2. Create a subrange of struct setup_data (e.g. bit 30 = 1) explicitly
      containing pointers to other data structures, including sizes, in a
      way that can be parsed by generic code.
   3. Encourage boot loaders to make sure the setup_data list is in order of
      ascending address (and WARN if it is not.)
   4. Add (b) as an option, for responsible boot loaders ;) to provide an
      extra level of protection.
