Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125F8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF9A20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF9A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbeK3DtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:49:13 -0500
Received: from ale.deltatee.com ([207.54.116.67]:56506 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbeK3DtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:49:13 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gSPPF-00045c-HO; Thu, 29 Nov 2018 09:43:15 -0700
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181112150215.508-1-namit@vmware.com>
 <20181112150215.508-2-namit@vmware.com> <20181113113000.GB4788@gmail.com>
 <40E4E1B4-EF5F-43A1-B42C-C4CF6349FC62@vmware.com>
 <48577A3F-0F76-4CCA-A959-965344D7259F@vmware.com>
 <7ff5de62-d1df-9a67-1c86-497ce00a4de4@deltatee.com>
 <7072A2D8-30F8-45CB-AB0C-B1BE4A30259A@vmware.com>
 <db8293cf-9abc-e899-8f43-6e42039006d9@deltatee.com>
 <521458D7-A27C-4112-81ED-1974EFE96A76@vmware.com>
 <be24a6eb-ebf0-8d9f-0051-681f0da66109@deltatee.com>
 <5682CCB4-B7D3-4DDC-81BB-2D4DCE968A3D@vmware.com>
 <336cf7d8-6495-b112-8d3a-c146222fda78@deltatee.com>
 <1CAF7187-4732-4BC9-8F7F-93EB16ED14E9@vmware.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7602f831-72db-888b-4b99-14763a2a3ac5@deltatee.com>
Date:   Thu, 29 Nov 2018 09:43:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1CAF7187-4732-4BC9-8F7F-93EB16ED14E9@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, x86@kernel.org, hpa@zytor.com, bp@alien8.de, tglx@linutronix.de, michal.lkml@markovi.net, yamada.masahiro@socionext.com, mingo@redhat.com, mingo@kernel.org, namit@vmware.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/2] Makefile: Fix distcc compilation with x86 macros
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-11-28 6:31 p.m., Nadav Amit wrote:
>> On Nov 28, 2018, at 4:49 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>>
>> On 2018-11-28 5:38 p.m., Nadav Amit wrote:
>>> So what’s your take? Would you think this patch is still needed? Should it
>>> only be enabled automatically for distcc and not for distcc-pump?
>>
>> Not sure. The patch will probably slow things down a lot (seeing
>> assembly is always done locally and there are twice as many compile
>> steps) and will create some confusion once it's possible to disable it
>> for the new versions. Maybe hold off and see if anyone else complains?
>>
>> I don't really know how you'd detect whether pump is in use or not and
>> I'm uncertain as to whether any of the auto detection can actually be
>> made to be reliable.
> 
> A silly `$(CC) —version | grep pump ` test.

Actually I'm not sure that's going to work in all cases. If CC="distcc
gcc", then "$(CC) --version" just looks like "gcc --version"...

Logan
