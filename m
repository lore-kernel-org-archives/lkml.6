Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4C1C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 07:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE992084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 07:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfATHCi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 02:02:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57191 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfATHCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 02:02:38 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0K71LVK1953801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sat, 19 Jan 2019 23:01:21 -0800
Date:   Sat, 19 Jan 2019 23:01:13 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190119103606.GA17400@kroah.com>
References: <20190118225543.86996-1-joel@joelfernandes.org> <20190119102800.GB17723@infradead.org> <20190119103606.GA17400@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the kernel
To:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        dancol@google.com, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        karim.yaghmour@opersys.com, Kees Cook <keescook@chromium.org>,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paulmck@linux.vnet.ibm.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rdunlap@infradead.org, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
From:   hpa@zytor.com
Message-ID: <8BD4CB7A-944C-4EC5-A198-1D85C9EE28D6@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 19, 2019 2:36:06 AM PST, Greg KH <gregkh@linuxfoundation.org> wrote:
>On Sat, Jan 19, 2019 at 02:28:00AM -0800, Christoph Hellwig wrote:
>> This seems like a pretty horrible idea and waste of kernel memory.
>
>It's only a waste if you want it to be a waste, i.e. if you load the
>kernel module.
>
>This really isn't any different from how /proc/config.gz works.
>
>> Just add support to kbuild to store a compressed archive in initramfs
>> and unpack it in the right place.
>
>I think the issue is that some devices do not use initramfs, or switch
>away from it after init happens or something like that.  Joel has all
>of
>the looney details that he can provide.
>
>thanks,
>
>greg k-h

Yeah, well... but it is kind of a losing game... the more in-kernel stuff there is the less smiley are things to actually be supported.

Modularizing is it in some ways even crazier in the sense that at that point you are relying on the filesystem containing the module, which has to be loaded into the kernel by a root user. One could even wonder if a better way to do this would be to have "make modules_install" park an archive file – or even a directory as opposed to a symlink – with this stuff in /lib/modules. We could even provide a tmpfs shim which autoloads such an archive via the firmware loader; this might even be generically useful, who knows.

Note also that initramfs contents can be built into the kernel. Extracting such content into a single-instance tmpfs would again be a possibility.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
