Return-Path: <kernel-hardening-return-12824-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx489/WjTku7vn1S5NA60/YOww0gjRo/1kxXUbZGEmqbc2NwtnkIUuewXcmUUZFWxzTqjSp4O
ARC-Seal: i=1; a=rsa-sha256; t=1522355152; cv=none;
        d=google.com; s=arc-20160816;
        b=giY9Le7H4XX3MHmYDL27zUa82zDwg2isB6UpLiO/G/kFz8E3ZRVAHHQ1BbPIa8oZ6s
         JXvGxVRs/eAZFBg3er/SdH+NTY7NBH9ndGBKGleme3Z9M7S7mtmRvGXgPEXPCOL0N04l
         /hR8jI8V5PGlDJN4tEFYNCndOIsz0Fb1nNeQeauu93EHV82BiHb/AbEuc8fSc/mTiXqZ
         Br5dvLAjxRRCZOqwWR2jLVP40EOggelxqhddBe8S8w0azc5BwyM7u2AobmvXIPCGhJkT
         sTkcC2lSVjvKJPh6/5+p9t8j8FS72wjK4RAF+KXcs3vDADEx3nThxp9SedmnyXSIhcJ5
         veCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=qNx+9UQkTGCgs6+mFL971GimGbxM+MGj5rILPg1ugHs=;
        b=vNjNV7bW40Tf0OhKLzD5s8KM3byz7Q/dFbLB7FqlCAg3URfjuUzhDQ7hS1y0SuplJy
         /Pl/eaLQZcFREdMgi20m7RR+vW5Wxyy7BVhwn4fHp1VGfR43qxrRdBC2WEesR25dJ0Py
         eisnzLh43H82A2O0pCe3RuI7mojf5BrEe9kpd5PvNIzdlPKMo/d6c4kGKbBMrbb48CvV
         R2llovMpacOQwoaJn8Sp6BvrHSFuMyvYC/Q8RCYWTsNHp4VHqwXUMW2bQf1vQU3/XmYr
         cg0NMU1px5AVygqVOIfL/d4ANyd2l+ZgJ3NTJm4bOfNRRWIIHYc9lzSLGB0f/KNvy6yl
         +BfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kxftk0AA;
       spf=pass (google.com: domain of kernel-hardening-return-12824-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12824-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Kxftk0AA;
       spf=pass (google.com: domain of kernel-hardening-return-12824-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12824-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [RFC PATCH v21 0/6] mm: security: ro protection for dynamic data
To: Jonathan Corbet <corbet@lwn.net>, Igor Stoppa <igor.stoppa@huawei.com>
Cc: willy@infradead.org, keescook@chromium.org, mhocko@kernel.org,
 david@fromorbit.com, rppt@linux.vnet.ibm.com, labbott@redhat.com,
 linux-security-module@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180327153742.17328-1-igor.stoppa@huawei.com>
 <20180327105509.62ec0d4d@lwn.net>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <5b2a6d5d-5e33-614b-c362-c02a99509def@gmail.com>
Date: Fri, 30 Mar 2018 00:25:22 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327105509.62ec0d4d@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596105811324274585?=
X-GMAIL-MSGID: =?utf-8?q?1596305076671800504?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27/03/18 20:55, Jonathan Corbet wrote:
> On Tue, 27 Mar 2018 18:37:36 +0300
> Igor Stoppa <igor.stoppa@huawei.com> wrote:
> 
>> This patch-set introduces the possibility of protecting memory that has
>> been allocated dynamically.
> 
> One thing that jumps out at me as I look at the patch set is: you do not
> include any users of this functionality.  Where do you expect this
> allocator to be used?  Actually seeing the API in action would be a useful
> addition, I think.

Yes, this is very true.
Initially I had in mind to use LSM hooks as easy example, but sadly they 
seem to be in an almost constant flux.

My real use case is to secure both those and the SELinux policy DB.
I have said this few times, but it didn't seem to be worth mentioning in 
the cover letter.

I was hoping to get this merged and then attack both LSM and SELinux, 
but it didn't fly, so few months ago i decided to try it all together 
and put on hold my efforts to get pmalloc merged.

However, in January, happened this:
http://www.openwall.com/lists/kernel-hardening/2018/01/24/1

which rekindled my hopes to get pmalloc in first, as it would make my 
life easier in proposing the changes to SELinux, if they ar ebased on a 
nAPI that is already merged.

So I hope that, once both API and implementation for pmalloc are in good 
shape, xfs could be the first customer.

If that doesn't happen, I'll go back to the initial plan. Or look for 
some other easier target.

Also the IMA policy could benefit from pmalloc protection, I think, I 
spent about a week hacking on it and it seems feasible.
But it's not exactly small either.

I do not know if I should have followed some other path, but I'm having 
a bit of a hard time, since the API is objectively touching core 
functionality, and the change I'd like to use as example affects such a 
large component a SELinux.

--
igor
