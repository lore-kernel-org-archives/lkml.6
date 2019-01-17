Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6255C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF99320851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfAQX7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:59:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36165 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbfAQX7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:59:07 -0500
Received: from hanvin-mobl2.amr.corp.intel.com ([134.134.139.83])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0HNwVxt951657
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 17 Jan 2019 15:58:32 -0800
Subject: Re: [PATCH 17/17] module: Prevent module removal racing with
 text_poke()
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-18-rick.p.edgecombe@intel.com>
 <20190117165422.d33d1af83db8716e24960a3c@kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e865e051-be79-adce-7275-72abf2173bdb@zytor.com>
Date:   Thu, 17 Jan 2019 15:58:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117165422.d33d1af83db8716e24960a3c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 11:54 PM, Masami Hiramatsu wrote:
> On Wed, 16 Jan 2019 16:32:59 -0800
> Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:
> 
>> From: Nadav Amit <namit@vmware.com>
>>
>> It seems dangerous to allow code modifications to take place
>> concurrently with module unloading. So take the text_mutex while the
>> memory of the module is freed.
> 
> At that point, since the module itself is removed from module list,
> it seems no actual harm. Or would you have any concern?
> 

The issue isn't the module list, but rather when it is safe to free the
contents, so we don't clobber anything. We absolutely need to enforce
that we can't text_poke() something that might have already been freed.

That being said, we *also* really would prefer to enforce that we can't
text_poke() memory that doesn't actually contain code; as far as I can
tell we don't currently do that check.

This, again, is a good use for a separate mm context. We can enforce
that that context will only ever contain valid page mappings for actual
code pages.

(Note: in my proposed algorithm, with a separate mm, replace INVLPG with
switching CR3 if we have to do a rollback or roll forward in the
breakpoint handler.)

	-hpa
