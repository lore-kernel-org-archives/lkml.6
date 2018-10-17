Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276ADECDE3D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA97721477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BsYuTKvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA97721477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJRHPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:15:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeJRHPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A3xmIxQE/qQ44bWf8Ps0hwRkE9rUw8JX3NwGiFM8VeA=; b=BsYuTKvNrh54cw27Kvn4OX+z/
        BQ/BJ5dSHu07+qwEgUvJ52NHkKXtSvEjg6CdT7eYRsh+zi5lu54mCJ2ubIWPs+AgjySltJwOCe018
        wP7KG1ib8hjiD9XayZ9gPNWn0Hixbjui3voZ0GyiGci6NSgmRsAxgTCoeCEcWtf0nkOUXfRQ0Lto+
        nAZuMZalTJY7zfWOOv6mNckzI95kPBJZIKqGR2Doh0aU3/gopD6HP/xX7/USIo7KNnMrSre9WUC9t
        EYszVLFms0rzDd3qSnuRoxnh1cdsqSi2ASGG5OW7rUBdWsN80TcwnKSYOm/83hA2tYlGLFADnfvQr
        T6DZdUU1Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCv3m-0001ox-Fw; Wed, 17 Oct 2018 23:17:02 +0000
Subject: Re: [PATCH v5 03/27] x86/fpu/xstate: Introduce XSAVES system states
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
References: <20181011151523.27101-1-yu-cheng.yu@intel.com>
 <20181011151523.27101-4-yu-cheng.yu@intel.com>
 <20181017104137.GE22535@zn.tnic>
 <32da559b-7958-60db-e328-f0eb316e668e@infradead.org>
 <20181017225829.GA32023@zn.tnic>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fde4c237-6210-f4e4-5362-c2e24a9916a2@infradead.org>
Date:   Wed, 17 Oct 2018 16:17:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017225829.GA32023@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 3:58 PM, Borislav Petkov wrote:
> On Wed, Oct 17, 2018 at 03:39:47PM -0700, Randy Dunlap wrote:
>> Would you mind explaining this request? (requirement?)
>> Other than to say that it is the preference of some maintainers,
>> please say Why it is preferred.
>>
>> and since the <type>s above won't typically be the same length,
>> it's not for variable name alignment, right?
> 
> Searching the net a little, it shows you have asked that question
> before. So what is it you really wanna know?

OK, you have shown that your web search skills are better than mine.

I asked what I really wanted to know.

ta.
-- 
~Randy
