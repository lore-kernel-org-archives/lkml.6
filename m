Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4227EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC88E20676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC88E20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbeIXX0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:26:09 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:41170 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeIXX0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:26:09 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8OHMX41014899;
        Tue, 25 Sep 2018 02:22:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Tue, 25 Sep 2018 02:22:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8OHMRwf014866
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 25 Sep 2018 02:22:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Kees Cook <keescook@chromium.org>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
 <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
 <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
 <39457e79-3816-824b-6b4d-89d21b03f9ce@i-love.sakura.ne.jp>
 <b209d4b8-81a5-30aa-f4d1-9372bbb1b842@schaufler-ca.com>
 <a2858469-cf38-7706-52b5-1d5fd5ed43ad@tycho.nsa.gov>
 <2a1ceb8c-0288-47ff-a763-d620e904b5b2@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f0059ebc-3586-dd08-efe5-f9ea69747218@i-love.sakura.ne.jp>
Date:   Tue, 25 Sep 2018 02:22:28 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2a1ceb8c-0288-47ff-a763-d620e904b5b2@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/25 1:15, Casey Schaufler wrote:
>>>>    Since all free hooks are called when one of init hooks failed, each
>>>>    free hook needs to check whether init hook was called. An example is
>>>>    inode_free_security() in security/selinux/hooks.c (but not addressed in
>>>>    this patch).
>>>
>>> I *think* that selinux_inode_free_security() is safe in this
>>> case because the blob will be zeroed, hence isec->list will
>>> be NULL.
>>
>> That's not safe - look more closely at what list_empty_careful() tests, and then think about what happens when list_del_init() gets called on that isec->list.  selinux_inode_free_security() presumes that selinux_inode_alloc_security() has been called already.  If you are breaking that assumption, you have to fix it.
> 
> Yup. I misread the macro my first time around. Easy fix.

Oh, I didn't notice that it is doing !list_empty_careful() than list_empty_careful().
Unsafe indeed. But easy to fix.

> 
>> Is there a reason you can't make inode_alloc_security() return void since you moved the allocation to the framework? 
> 
> No reason with any of the existing modules, But I could see someone
> doing unnatural things during allocation that might result in a
> failure.

Currently upstreamed LSM modules and AKARI would be OK. But I can't guarantee it
for future / not-yet-upstreamed LSM modules.
