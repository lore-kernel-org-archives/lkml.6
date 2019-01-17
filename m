Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565F8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA1C2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfAQXp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:45:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35287 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfAQXp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:45:27 -0500
Received: from hanvin-mobl2.amr.corp.intel.com (fmdmzpr04-ext.fm.intel.com [192.55.54.39])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0HNink3948140
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 17 Jan 2019 15:44:50 -0800
Subject: Re: [PATCH 17/17] module: Prevent module removal racing with
 text_poke()
To:     Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "deneen.t.dock@intel.com" <deneen.t.dock@intel.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-18-rick.p.edgecombe@intel.com>
 <20190117165422.d33d1af83db8716e24960a3c@kernel.org>
 <B48C6E93-AD57-4FF8-BBE8-887A5E965793@vmware.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <ab04ceec-0708-06df-a399-cb53fce41a37@zytor.com>
Date:   Thu, 17 Jan 2019 15:44:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <B48C6E93-AD57-4FF8-BBE8-887A5E965793@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 10:07 AM, Nadav Amit wrote:
>> On Jan 16, 2019, at 11:54 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>
>> On Wed, 16 Jan 2019 16:32:59 -0800
>> Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:
>>
>>> From: Nadav Amit <namit@vmware.com>
>>>
>>> It seems dangerous to allow code modifications to take place
>>> concurrently with module unloading. So take the text_mutex while the
>>> memory of the module is freed.
>>
>> At that point, since the module itself is removed from module list,
>> it seems no actual harm. Or would you have any concern?
> 
> So it appears that you are right and all the users of text_poke() and
> text_poke_bp() do install module notifiers, and remove the module from their
> internal data structure when they are done (*). As long as they prevent
> text_poke*() to be called concurrently (e.g., using jump_label_lock()),
> everything is fine.
> 
> Having said that, the question is whether you “trust” text_poke*() users to
> do so. text_poke() description does not day explicitly that you need to
> prevent modules from being removed.
> 
> What do you say?
> 

Please make it explicit.

	-hpa

