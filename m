Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCA6C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BA82064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BA82064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbeIFSHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:07:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34016 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbeIFSHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:07:38 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxuO8-00085i-ML; Thu, 06 Sep 2018 15:32:00 +0200
Date:   Thu, 6 Sep 2018 15:32:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/fault: Decode page fault OOPSes better
In-Reply-To: <0a4c64885e9a51705dcc0f49526823ed429e0720.1535773238.git.luto@kernel.org>
Message-ID: <alpine.DEB.2.21.1809061524170.1570@nanos.tec.linutronix.de>
References: <0a4c64885e9a51705dcc0f49526823ed429e0720.1535773238.git.luto@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018, Andy Lutomirski wrote:
> @@ -671,6 +705,48 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>  		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
>  		 (void *)address);
>  
> +	errcode[0] = 0;

error_code vs. errcode ? errtxt perhaps?

> +#define ERRSTR(x) if (error_code & X86_PF_##x) strcat(errcode, " " #x)
> +	ERRSTR(PROT);
> +	ERRSTR(WRITE);
> +	ERRSTR(USER);
> +	ERRSTR(RSVD);
> +	ERRSTR(INSTR);
> +	ERRSTR(PK);
> +#undef ERRSTR

Eeew. That's too ugly to live.

static inline errstr(unsigned long ec, char *buf, unsigned long mask,
       	      	     const char *txt)
{
	....
}

and then

	errstr(error_code, errtxt, X86_PF_PROT, "PROT");

Yes, it's slightly more to type but this macro mess in the middle of the
code just makes my eyes bleed.

Thanks,

	tglx
