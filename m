Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C440C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEDB206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547663179;
	bh=xnGEX9v6nmKAsw2QN5b5mi4P3QWOR/2zUgstlmwUAJM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=eP4DjzjShP/yY4SDEEVj8571zOaqJ+ybAkV7nK0JuCZI/GZw/LlyGolnQsfPBV9Rz
	 HEGeVi81UvAEdWpBWISARx8mFWB08u8gQqwCMUNk8wFR2LZ1HoiyKtoCBMZ2qFDiav
	 4I2igtwYxTABzcio5ZhHc5WSHAjL9UnRCSNoOeDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfAPS0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:26:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbfAPS0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:26:15 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03256206C2;
        Wed, 16 Jan 2019 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547663174;
        bh=xnGEX9v6nmKAsw2QN5b5mi4P3QWOR/2zUgstlmwUAJM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lQGERS4tCUZX+yjgowEXKui5On8Lf6nX96c9ds9vkhTb56yB2t0I0njSfOvlpnHCz
         6+dPF67EzjXbHCqdm0fLOfgdc1cMX1e7ho1I7aZsZhtHgAkEPmmYIMUILzV4GZtjg2
         PhuNw0/tmRtQDrC/d6Wqbw4BndQx1pnHh+8cmQLQ=
Subject: Re: [PATCH 3/4] selftests: seccomp: use LDLIBS instead of LDFLAGS
To:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Cc:     Fathi Boudra <fathi.boudra@linaro.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        shuah <shuah@kernel.org>
References: <20190116174320.14938-1-daniel.diaz@linaro.org>
 <20190116174320.14938-3-daniel.diaz@linaro.org>
 <CAGXu5j+1tOvB0jHk=kCxfhTg-PEPjCHp2TQb++wZsGxJCcQxng@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <dfe6e14f-ccf4-80ef-7bdd-23d7d2698bb8@kernel.org>
Date:   Wed, 16 Jan 2019 11:26:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+1tOvB0jHk=kCxfhTg-PEPjCHp2TQb++wZsGxJCcQxng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 11:13 AM, Kees Cook wrote:
> On Wed, Jan 16, 2019 at 9:44 AM Daniel Díaz <daniel.diaz@linaro.org> wrote:
>>
>> From: Fathi Boudra <fathi.boudra@linaro.org>
>>
>> seccomp_bpf fails to build due to undefined reference errors:
>>
>>   aarch64-linaro-linux-gcc --sysroot=/build/tmp-rpb-glibc/sysroots/hikey
>>   -O2 -pipe -g -feliminate-unused-debug-types -Wl,-no-as-needed -Wall
>>   -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed -lpthread seccomp_bpf.c -o
>>   /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf
>>   /tmp/ccrlR3MW.o: In function `tsync_sibling':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1920: undefined reference to `sem_post'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1920: undefined reference to `sem_post'
>>   /tmp/ccrlR3MW.o: In function `TSYNC_setup':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1863: undefined reference to `sem_init'
>>   /tmp/ccrlR3MW.o: In function `TSYNC_teardown':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1904: undefined reference to `sem_destroy'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1897: undefined reference to `pthread_kill'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1898: undefined reference to `pthread_cancel'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1899: undefined reference to `pthread_join'
>>   /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /tmp/ccrlR3MW.o: In function `TSYNC_siblings_fail_prctl':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1978: undefined reference to `sem_wait'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1990: undefined reference to `pthread_join'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1992: undefined reference to `pthread_join'
>>   /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_ancestor':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2016: undefined reference to `sem_wait'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2032: undefined reference to `pthread_join'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2034: undefined reference to `pthread_join'
>>   /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /tmp/ccrlR3MW.o: In function `TSYNC_two_sibling_want_nnp':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2046: undefined reference to `sem_wait'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2058: undefined reference to `pthread_join'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2060: undefined reference to `pthread_join'
>>   /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_no_filter':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2073: undefined reference to `sem_wait'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2098: undefined reference to `pthread_join'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2100: undefined reference to `pthread_join'
>>   /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_one_divergence':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2125: undefined reference to `sem_wait'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2143: undefined reference to `pthread_join'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2145: undefined reference to `pthread_join'
>>   /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>   /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_not_under_filter':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2169: undefined reference to `sem_wait'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2202: undefined reference to `pthread_join'
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2227: undefined reference to `pthread_join'
>>   /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
>>   /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
>>
>> It's GNU Make and linker specific.
>>
>> The default Makefile rule looks like:
>>
>> $(CC) $(CFLAGS) $(LDFLAGS) $@ $^ $(LDLIBS)
>>
>> When linking is done by gcc itself, no issue, but when it needs to be passed
>> to proper ld, only LDLIBS follows and then ld cannot know what libs to link
>> with.
>>
>> More detail:
>> https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html
>>
>> LDFLAGS
>> Extra flags to give to compilers when they are supposed to invoke the linker,
>> ‘ld’, such as -L. Libraries (-lfoo) should be added to the LDLIBS variable
>> instead.
>>
>> LDLIBS
>> Library flags or names given to compilers when they are supposed to invoke the
>> linker, ‘ld’. LOADLIBES is a deprecated (but still supported) alternative to
>> LDLIBS. Non-library linker flags, such as -L, should go in the LDFLAGS
>> variable.
>>
>> https://lkml.org/lkml/2010/2/10/362
>>
>> tools/perf: libraries must come after objects
>>
>> Link order matters, use LDLIBS instead of LDFLAGS to properly link against
>> libpthread.
>>
>> Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
> 

Thanks for the patch.

> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Shuah, can you take this?
> 

Thanks for Ack. I will get this in for 5.0-rc3 or rc4.

thanks,
-- Shuah
