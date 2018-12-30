Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0263BC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 00:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C093A2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 00:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeL3AIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 19:08:54 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47848 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeL3AIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 19:08:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 8F5CC29798;
        Sat, 29 Dec 2018 19:08:50 -0500 (EST)
Date:   Sun, 30 Dec 2018 11:09:13 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v8 00/25] Re-use nvram module
In-Reply-To: <CAK8P3a3yF+CkvQS_funp4BPhi-10N4yse2oAeWAcWR+Ty5Pxmg@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1812301051280.215@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au> <CAK8P3a3yF+CkvQS_funp4BPhi-10N4yse2oAeWAcWR+Ty5Pxmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2018, Arnd Bergmann wrote:

> I had a look at the complete series now, and I think this is a great 
> cleanup. I replied with a couple of minor comments that you may or may 
> not want to address first.
> 

Thanks for reviewing this.

> The one thing I would like to see resolved (I hope this doesn't bring 
> back an old discussion you had already concluded) is regarding the use 
> of a global exported structure of function pointers, as opposed to using 
> either directly exported functions (with a consistent interface) or a 
> boot-time selectable structure like dma_map_ops or ppc_md.
> 

If I understand correctly, /dev/nvram was made obsolete by the nvmem 
subsystem (?). If so, there won't be new /dev/nvram users, and the 
refactoring here only has to be sufficiently flexible to meet the needs of 
existing users.

I'm not opposed to exported functions in place of a singleton ops struct. 
Other things being equal I'm inclined toward the ops struct, perhaps 
because I like encapsulation or perhaps because I don't like excess 
generality. (That design decision was made years ago and I don't remember 
the reasoning.)

All the arch_nvram_ops structs that I've defined in these patches have the 
'const' properly:

const struct nvram_ops arch_nvram_ops = {
       .read_byte      = nvram_read_byte,
       .write_byte     = nvram_write_byte,
       .read           = nvram_read,
       .write          = nvram_write,
       .get_size       = nvram_get_size,
       .set_checksum   = nvram_set_checksum,
       .initialize     = nvram_initialize,
};
EXPORT_SYMBOL(arch_nvram_ops);

This is because there's no need to do any run-time reconfiguration.

Is a collection of exported functions a better fit here?

-- 

>     Arnd
> 
