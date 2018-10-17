Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC72ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57301213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XNiTasvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57301213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJRGhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:37:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJRGhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BwoZ3WcDYWO+yjIugTPr7sNhogD+F87PcyQx2HZ+CEE=; b=XNiTasvjUqxcUKVyKvrs7Tn7M
        P/okGbwZe6l2a2/avbd6hbeACXL3UNOXfuqlTiGwbMj1coP7CodqEBx2nyDTHQHVjgm3yIqNKnU0T
        hfP9jgNgIKdxkrUQw/6wsYfym9EUaFj+73rL1G1TPJh+/uJYcGx7+uLloCM9f4JBKj1jYJu74IlL6
        fchsKREhN7In+1cuheh0VWKoRHQWxktJTSVtpZ64gQ8GyCBH0eEp2geF51DnM0BBCYbX44h7USySx
        qb/954R/wiv9ffAU7RilAgJsWnthxB/HTzepMntJJNSPunxDHNujAOUmQ6qtWUtYxsgaK4fCmwLW3
        k2xth4JuQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCuTn-00041p-Oy; Wed, 17 Oct 2018 22:39:51 +0000
Subject: Re: [PATCH v5 03/27] x86/fpu/xstate: Introduce XSAVES system states
To:     Borislav Petkov <bp@alien8.de>, Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <32da559b-7958-60db-e328-f0eb316e668e@infradead.org>
Date:   Wed, 17 Oct 2018 15:39:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017104137.GE22535@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 3:41 AM, Borislav Petkov wrote:

>> @@ -702,6 +703,7 @@ static int init_xstate_size(void)
>>   */
>>  static void fpu__init_disable_system_xstate(void)
>>  {
>> +	xfeatures_mask_all = 0;
>>  	xfeatures_mask_user = 0;
>>  	cr4_clear_bits(X86_CR4_OSXSAVE);
>>  	fpu__xstate_clear_all_cpu_caps();
>> @@ -717,6 +719,8 @@ void __init fpu__init_system_xstate(void)
>>  	static int on_boot_cpu __initdata = 1;
>>  	int err;
>>  	int i;
>> +	u64 cpu_user_xfeatures_mask;
>> +	u64 cpu_system_xfeatures_mask;
> 
> Please sort function local variables declaration in a reverse christmas
> tree order:
> 
> 	<type> longest_variable_name;
> 	<type> shorter_var_name;
> 	<type> even_shorter;
> 	<type> i;

Hi,

Would you mind explaining this request? (requirement?)
Other than to say that it is the preference of some maintainers,
please say Why it is preferred.

and since the <type>s above won't typically be the same length,
it's not for variable name alignment, right?

thanks,
-- 
~Randy
