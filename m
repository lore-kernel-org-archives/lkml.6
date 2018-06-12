Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 52871C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051812084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051812084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754409AbeFLVjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:39:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36811 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754325AbeFLVjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:39:18 -0400
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.54.41])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w5CLd32O180626
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 12 Jun 2018 14:39:04 -0700
Subject: Re: [RFC] x86/vdso: Align vdso after searching for free area
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasiliy Khoruzhick <vasilykh@arista.com>, x86@kernel.org
References: <20180612204948.4752-1-dima@arista.com>
 <1528838651.26829.69.camel@arista.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6d53a9e3-5776-1073-a5ae-60d50db3e467@zytor.com>
Date:   Tue, 12 Jun 2018 14:39:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528838651.26829.69.camel@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/18 14:24, Dmitry Safonov wrote:
>>
>> Move align_vdso_addr() after get_unmapped_area() to make sure that
>> errata for AMD 15h is always applied.
> 
> Alternative dirty-hacky idea:
> specify some (struct file*) to get_unmapped_area() for vdso vma, then
> mapping would be automatically aligned. Dirty as hell as relies on
> get_unmapped_area() realization details.
> 


I have mentioned several times that I would like to see the vdso
actually be an actual file in a filesystem, that the kernel *or* user
space can map (needs to be MAP_SHARED, of course.)

The vdso data page needs to be moved after the ELF object itself for
this to work. Ideally it should be given an actual ELF segment (and
ideally an ELF section as well.)  The easy way to do this is to give the
linker a dummy vvar page as a properly aligned section at compile time,
into which space the kernel can map the real vvar page. The only
downside is that the linker likes to put section headings after the
actual data, so it may end up taking up an extra page over the current
arrangement. However, I think the gains outweigh the losses.

	-hpa
