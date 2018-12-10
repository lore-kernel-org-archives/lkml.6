Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB827C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8271C20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544464658;
	bh=0idB5vfSXTFTZbVl0hucf39CXh9sNgtnKC32PrKIjW4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=PTpr/3cqY7tLeqtzpStIDItmqnSxtGDPbAi94CKpfy11eybhtnGEgg71FyNad7nQj
	 MPDB8TCZMGkgHOR+n7ZeJ4sviJV7RFp28wl+de45JLqW7ZyKPhVplJWk3501nL2Wp7
	 MOM7ajkkkMgamM89yoyte/3pr1CRv2W+uRR1gdN8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8271C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbeLJR5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:57:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbeLJR5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:57:37 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40612081F;
        Mon, 10 Dec 2018 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544464656;
        bh=0idB5vfSXTFTZbVl0hucf39CXh9sNgtnKC32PrKIjW4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SyugJv74xHwLiB6f1MKOgutx4hjEu4q0IY9tDZyVBA/TYSMVrFg4bzDhcOVdfMVub
         sX6+smEHxhiKrwlzc/38FFsixrfEz3S0L6kwLJSIAprnwT8LxQVzU1RqEY0tnQ8ETO
         rqqT9g/MYLQbY44IUGvab8xRAB3EiJe294BwZ+yg=
Subject: Re: [PATCH] selftests: do not macro-expand failed assertion
 expressions
To:     Kees Cook <keescook@chromium.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, shuah <shuah@kernel.org>
References: <20181209230047.GA1738@altlinux.org>
 <CAGXu5jKLHbfgZLGqxwG8LRs=0hy+iJGYQd61Ad5LghrkDWV=4w@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <4907f73f-2a07-d6d2-fcb8-280f3066851a@kernel.org>
Date:   Mon, 10 Dec 2018 10:57:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKLHbfgZLGqxwG8LRs=0hy+iJGYQd61Ad5LghrkDWV=4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 10:30 AM, Kees Cook wrote:
> On Sun, Dec 9, 2018 at 3:00 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>>
>> I've stumbled over the current macro-expand behaviour of the test
>> harness:
>>
>> $ gcc -Wall -xc - <<'__EOF__'
>> TEST(macro) {
>>          int status = 0;
>>          ASSERT_TRUE(WIFSIGNALED(status));
>> }
>> TEST_HARNESS_MAIN
>> __EOF__
>> $ ./a.out
>> [==========] Running 1 tests from 1 test cases.
>> [ RUN      ] global.macro
>> <stdin>:4:global.macro:Expected 0 (0) != (((signed char) (((status) & 0x7f) + 1) >> 1) > 0) (0)
>> global.macro: Test terminated by assertion
>> [     FAIL ] global.macro
>> [==========] 0 / 1 tests passed.
>> [  FAILED  ]
>>
>> With this change the output of the same test looks much more
>> comprehensible:
>>
>> [==========] Running 1 tests from 1 test cases.
>> [ RUN      ] global.macro
>> <stdin>:4:global.macro:Expected 0 (0) != WIFSIGNALED(status) (0)
>> global.macro: Test terminated by assertion
>> [     FAIL ] global.macro
>> [==========] 0 / 1 tests passed.
>> [  FAILED  ]
>>
>> The issue is very similar to the bug fixed in glibc assert(3)
>> three years ago:
>> https://sourceware.org/bugzilla/show_bug.cgi?id=18604
>>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Will Drewry <wad@chromium.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> 
> Yeah, good idea.
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 

Thanks. Applied to linux-kselftest next.

-- Shuah

