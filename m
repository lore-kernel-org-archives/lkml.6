Return-Path: <kernel-hardening-return-12590-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvJXfTz62MFCl9qHnUMGA8mBFk+1OjAieFSf4/kFpMyigD2giYUByTEmwaIlnFBFi4YZliI
ARC-Seal: i=1; a=rsa-sha256; t=1521032203; cv=none;
        d=google.com; s=arc-20160816;
        b=ipXHObSbCJyRT9cp/2aEpsBjc9RKaD9IHKj/rHWWu77AbIEvgbCEpuun5UwRmA0+PF
         riuynfRY8vdRYrw3cgGHffWnfI2bdB47aku7C3jp7IwfBj40y1fPgbFKQd0TEvtwQBkQ
         958wRBoNQe62F0DKBPXKHFEqCs8C3DWRpLNPtDCOh8q7+QVomJtLom+19NDALHVXrh+M
         NguRcF9E1kjQnKqToJAZxg5FEB6k3NrGn/qMqJNhw7GoQF8BkFtRmqRAhvAkuPNyAqVL
         xn7eW0Q4dNbUIv4rxxNXABNoR2LlbM4byDh9vnOp3tJxGM85KpJXJ3fRYA3lGXuSY89m
         vWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=pUED4CqKi0u9c2CPYZtVpoPQI0490o6wQLnVz3PqKbM=;
        b=DM+6MC5oTBwZpt8W3FH8eJ0Qs+pBlfB7HjJszCMT05rxp1Q98S3W1x+HsFpqkx9D9X
         ZhKVb+kU03bEnkwwu0Wb1xE1rXYgd1SBW3GywVMoNky+zEfUcy4U2DLwaX7RlRrp3o9m
         jBZU7PqFJpB0swnENIP60VOnsJXPU6HDnJpzo4HizpLxwimB9KQzH1Ucm7GBWSb7Fv9m
         LWv0lFDjxJNf8wc0TicT4p5rJa3ajVqEuozirSXIyPUJsMTHoItpzQ3m3tX5vz7ckx7x
         sQpUdkUloqjCbl+cIMwGJnDtUmrbGcyq7qS3/t+ntNnpWzjKX6gB8ymHEk/k7kHIw66W
         sXvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12590-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12590-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12590-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12590-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [RFC PATCH v19 0/8] mm: security: ro protection for dynamic data
To: Matthew Wilcox <willy@infradead.org>
CC: <keescook@chromium.org>, <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>,
	<mhocko@kernel.org>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <a9bfc57f-1591-21b6-1676-b60341a2fadd@huawei.com>
 <20180314115653.GD29631@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <8623382b-cdbe-8862-8c2f-fa5bc6a1213a@huawei.com>
Date: Wed, 14 Mar 2018 14:55:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314115653.GD29631@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860649725336168?=
X-GMAIL-MSGID: =?utf-8?q?1594917863526548336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 14/03/18 13:56, Matthew Wilcox wrote:
> On Wed, Mar 14, 2018 at 01:21:54PM +0200, Igor Stoppa wrote:

[...]

> You misread my proposal.  I did not suggest storing the 'start', but the
> 'end'.

Ok, but doesn't that only change the race scenario?

Attempting to free one allocation, while it is in progress, so that all
the "space" bits are written, but the "end bit" is not yet written.
That will eat up also the following, complete allocation, if there is no
locking in place.

[...]

>> The implementation which interleaves "space" and "start" does not suffer
>> from this sort of races, because the alteration of the interleaved
>> bitmaps is atomic.
> 
> This would be a bug in the allocator implementation.  Obviously it has to
> maintain the integrity of its own data structures.

But I cannot imagine how to do it, with the split bitmaps, without a
lock :-/
And genalloc is supposed to be lockless.

>> Does this justification for the use of interleaved bitmaps (iow the
>> current implementation) make sense?
> 
> I think you're making a mistake by basing the pmalloc allocator on
> genalloc.

It was recommended to me because it was a close match to the allocator
that I was writing from scratch and, when I looked at it, I could only
agree that it was very close.

But I have no particular reason for preferring it, if something better
is available. It was just never brought up before.
At least not that I noticed.

>  The page_frag allocator seems like a much better place to
> start than genalloc.  It has a significantly lower overhead and is
> much more suited to the kind of probably-identical-lifespan that the
> pmalloc API is going to persuade its users to have.


Could you please provide me a pointer?
I did a quick search on 4.16-rc5 and found the definition of page_frag
and sk_page_frag(). Is this what you are referring to?

--
igor
