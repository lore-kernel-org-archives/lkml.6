Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD654C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9751920850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skCX43Tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9751920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934780AbeFRLwU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:52:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45148 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeFRLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:52:15 -0400
Received: by mail-lf0-f68.google.com with SMTP id a13-v6so4080346lfk.12;
        Mon, 18 Jun 2018 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=u6lapVaDPJDLDEq9Vwies/bT1iQPkezn3nOqZiIx/8A=;
        b=skCX43TnUmuqtBmGJ7eLbQt7WnI2Y2+eqRZNZtqW5uKvFEhzuGQBr7kSyQIirFpHYv
         CsN5ZoG9v0EGOvX0y/r4U4zBOHK+sdiUDn7Ecd0L9LYc0wRUSeQVjnh1XZ8zev50msWY
         cXOMyYhuRbppnr3za4IX8s/lMJ/YBUb9ZnjXRpVY/m+3KxhOxVML/07buIRedtsRPsr9
         bsMX7gi2Qq6b9VrFzT+O45hqZROWvhNWqLfy53kYalgIdFBE8xx3oDF5+GI6SYYYVm1R
         Am0A9fv94U5m9JFLR183TEO7tG0mNqkCkmejFuQEqEbeOpB8clRBC1RcPxL01kCN7cLO
         NjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=u6lapVaDPJDLDEq9Vwies/bT1iQPkezn3nOqZiIx/8A=;
        b=bU8FA2ztxcpi/TR06OqCNGBlZF7eeQNQ1H1UMppMjRaou3k+CriyV8HYlFc3sqzGBJ
         fYZ3lVg2vPo1upC2SuEbl8gJGzgXgDSiHB53NjodqtQ/bV1JqTq4Uuk1K9VC9QxvZfxT
         McoozJpELw9kh9lO9h2o+E4UNN9LXhYEUWRPoWx/my2SYK3XGg3T3c47He3+lWJ7lYvX
         CxvP0Swl0SWVBNH4tBnwWOz4yEahbnjzkUGjtRjQfCW2lpp/ZyxhsQKhbWlZ2uMH8ofA
         ZDZWk+KaGdlsBu2hUJaTFSLp5YcZd3Cs0s+bRu1Eg+1TI9MV1Rcd1iUkUcIUNUjATSb8
         2WSw==
X-Gm-Message-State: APt69E2nh+awC4HMKU12vX2Hxucc7dFKvJhsbC7A/cALdhQBGze5Eg0I
        AvtSsT45kaQihVz60meoC1Z6iJHQFXMTd5a8BUs=
X-Google-Smtp-Source: ADUXVKLue/FrGPMlDAIEnlBXHnCR5j7eCcDrQfyl03s+b1/noQlC+7LSLGJ7fJkHD9VsNGRD4vfIggri5xK89sflljQ=
X-Received: by 2002:a19:8ecd:: with SMTP id a74-v6mr6989950lfl.12.1529322733434;
 Mon, 18 Jun 2018 04:52:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 04:52:12
 -0700 (PDT)
In-Reply-To: <f992c920-7e57-8099-b13c-f3651c0d1594@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-5-songjun.wu@linux.intel.com> <CAK8P3a0K6qezHLcjkeq0zd+iQJQc_qbT2JhtZGrCNRT495sUvQ@mail.gmail.com>
 <f992c920-7e57-8099-b13c-f3651c0d1594@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jun 2018 13:52:12 +0200
X-Google-Sender-Auth: 0Kucv6JGWonQB_x2QIskA4_VNNA
Message-ID: <CAK8P3a3Zgtk56RAuP=J=-F9VPLxCu=vyGRFpTdBjtnWbOX+4KQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
To:     "Wu, Songjun" <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:39 AM, Wu, Songjun
<songjun.wu@linux.intel.com> wrote:
>
>
> On 6/14/2018 6:07 PM, Arnd Bergmann wrote:
>>
>> On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com>
>> wrote:
>>>
>>> Previous implementation uses platform-dependent functions
>>> ltq_w32()/ltq_r32() to access registers. Those functions are not
>>> available for other SoC which uses the same IP.
>>> Change to OS provided readl()/writel() and readb()/writeb(), so
>>> that different SoCs can use the same driver.
>>>
>>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>>
>> Are there any big-endian machines using this driver? The original
>> definition
>> of ltq_r32() uses non-byteswapping __raw_readl() etc, which suggests
>> that the registers might be wired up in a way that matches the CPU
>> endianess (this is usally a bad idea in hardware design, but nothing
>> we can influence in the OS).
>>
>> When you change it to readl(), that will breaks all machines that rely
>> on the old behavior on big-endian kernels.
>
> It will not break existing big-endian SoC as SWAP_IO_SPACE is disabled.
>
> Disable SWAP_IO_SPACE will not impact ltq_r32 as it uses non-byte swapping
> __raw_readl() and it makes readl work in big-endian kernel too.
>
> The old Lantiq platform enable SWAP_IO_SPACE to support PCI as it's a
> little-endian bus plus PCI TX/RX swap enable impacted both data and control
> path.

Right, I see now what you mean. I was getting confused by how MIPS
defines the __raw_* accessors differently from other big-endian
architectures when CONFIG_SWAP_IO_SPACE is disabled.

I suppose this just means you can't use any PCI drivers using __raw_
accessors or memcpy_fromio(), but your patch to the serial driver is fine.

> Alternatively PCI device driver has to do endian swap, It is better to let
> PCI device driver to do endian swap instead because SWAP_IO_SPACE is global
> wide macro.
> Once we set it, other peripheral such as USB has to change its register
> access as well

I'm not entirely sure what you mean here, I would assume that aiming for
maximum compatibility with existing drivers would be the main goal here.
The USB platform drivers can already deal with being compiled for either
(or both) endianess.

      Arnd
