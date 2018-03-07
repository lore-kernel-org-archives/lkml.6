Return-Path: <kernel-hardening-return-12194-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtesb4b7vPqFFszFkkwmWmVxi//ESk831he0SMI1hjbM3TZDYdO1D5myBDm9qvFn4u6t6Rq
ARC-Seal: i=1; a=rsa-sha256; t=1520428758; cv=none;
        d=google.com; s=arc-20160816;
        b=kbtlgEbc4jgvUBNcJCoA3bwcWIu1Am9nqeyJYlnupDK8pWmi6OxfwdF8JNc4z5KzRk
         cUGud7aOfi7uInbJdgB7LKLCNJKVRsjvMUlm1Ww4X//PL3I5etpLZSuySuz+rlTZVBrV
         5bRbGxtPhgnHW970dbYdKGdzk6RIivKmUGr6W0rh1nDWLH3LjiywSxU88zN2A8sUM9UE
         42ITd61HFImpL3UE/7/HPeCuiqqQjFBrIlCi4M6SY1xU8x8QLZjZpzrcpdMpNqTiFVKn
         gEJjFkkvufL89sj1J6tXnLbPk9fgzOPpynOc+S8yxSqFgxhdRVwNYNasp2022VnIoU/Y
         U/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=kl+VA5wFf4VVXJhTK1TvzoG0Yn7hB7AsS5rYZfUPrmA=;
        b=GuypCrIJDx8dq+WJsQKCfRoleNk20smCNY1gxCsUFs5JQP02JneGbf+AVTt9z5CxC+
         BQp5t0W8bOpohzNOuz+btvux5XFwj/SV5njRogFeYtj/kXrwACNq/frqc7XuCS7nAkD4
         4WUboLD5osOXwzExfYOi8KHDszZg8MQWUeRXRY3jsxVMckxGHE4bVS5jqiDpLYZwrXdN
         FYlO/20fj13E6sVPht1DqRsh42G751Bx+GD51MTv/njtU6j91AVe75gnUxXbubkfcESA
         By8892uKeoebcRpuIiRTh+5ABJcSxpB1kshbityG0ac1Sqm30vv2X6lmGUc6GsmujcU+
         pP5w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12194-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12194-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12194-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12194-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 6/7] lkdtm: crash on overwriting protected pmalloc var
To: J Freyensee <why2jjj.linux@gmail.com>, <david@fromorbit.com>,
	<willy@infradead.org>, <keescook@chromium.org>, <mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-7-igor.stoppa@huawei.com>
 <1723ee8d-c89e-0704-c2c3-254eda39dc8b@gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <6378e63e-174f-642e-d319-1d121b74d3d7@huawei.com>
Date: Wed, 7 Mar 2018 15:18:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1723ee8d-c89e-0704-c2c3-254eda39dc8b@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676876599291388?=
X-GMAIL-MSGID: =?utf-8?q?1594285105852208066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 06/03/18 19:20, J Freyensee wrote:

> On 2/28/18 12:06 PM, Igor Stoppa wrote:

[...]

>>   void __init lkdtm_perms_init(void);
>>   void lkdtm_WRITE_RO(void);
>>   void lkdtm_WRITE_RO_AFTER_INIT(void);
>> +void lkdtm_WRITE_RO_PMALLOC(void);
> 
> Does this need some sort of #ifdef too?

Not strictly. It's just a function declaration.
As long as it is not used, the linker will not complain.
The #ifdef placed around the use and definition is sufficient, from a
correctness perspective.

But it's a different question if there is any standard in linux about
hiding also the declaration.

I am not very fond of #ifdefs, so when I can I try to avoid them.

>> +	pr_info("attempting bad pmalloc write at %p\n", i);
>> +	*i = 0;
> 
> OK, now I'm on the right version of this patch series, same comment 
> applies.  I don't get the local *i assignment at the end of the 
> function, but seems harmless.


Because that's the whole point of the function: prove that pmalloc
protection works (see the message in the pr_info one line above).

The function is supposed to do:

* create a pool
* allocate memory from it
* protect it
* try to alter it (and crash)

*i = 0; performs the last step

--
igor
