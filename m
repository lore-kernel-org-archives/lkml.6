Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8980CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D57920827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D57920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeKIBXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:23:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:36856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbeKIBXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:23:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB262AE5C;
        Thu,  8 Nov 2018 15:47:34 +0000 (UTC)
Date:   Thu, 8 Nov 2018 15:47:32 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Yi Wang <wang.yi59@zte.com.cn>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        suravee.suthikulpanit@amd.com, puwen@hygon.cn,
        davidwang@zhaoxin.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] x86/cpu: fix prototype warning
In-Reply-To: <20181108153226.GF7543@zn.tnic>
Message-ID: <alpine.LSU.2.21.1811081538120.21712@wotan.suse.de>
References: <1541639548-11149-1-git-send-email-wang.yi59@zte.com.cn> <20181108150318.GD7543@zn.tnic> <20181108153226.GF7543@zn.tnic>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Nov 2018, Borislav Petkov wrote:

> And frankly, I don't see why we should be fixing all those. So what if a 
> global function does't have a previous prototype declaration?!
> 
> Micha, is there anything "useful" that warning bitches about or should 
> we disable it?

What tglx said.  If you don't intend such functions to be called 
from other units make them static, if you do intend them to be callable 
declare the properly.

[There's also one subtle issue with argument promotions.  prototypeless 
functions are called as if they are declared "int name()" that is 
default argument promotions take place (float->double, {char,short}->int), 
which won't happen with prototypes, and argument type conversions won't 
take place (as no parameter types are known).  This might lead to 
different values between calling a prototyped and a prototype-less 
function arriving at the function even though the call expression looked 
the same]


Ciao,
Michael.
