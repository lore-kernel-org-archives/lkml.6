Return-Path: <lars@metafoo.de>
X-Google-Smtp-Source: AIpwx4/cWC5yh6JDrctt4Dw7wCMdUCD2j5L3obJyLu4vKLxHwfmdGfee7eql53lc4SVXN4DqS5KM
ARC-Seal: i=1; a=rsa-sha256; t=1522912771; cv=none;
        d=google.com; s=arc-20160816;
        b=GM+6lcynvpxdjVkY4tmsJWGiTBxszDCx/B3CWg2BbkDA6ZFvOiqXhT4Wg+zAhGvFFj
         SVAB0rR9jO9GorDJXjscKXCMh49e4aquK2zVEtW/r41cO0ru2wniHvWXTvb85kR0hEzu
         f5jwlb87CdNrjqfekazXuIWu4akKNCvzyEu9amz1H2/zJScMKo1Z/jr6YQkwLOgpquwT
         o9igPOpxvg1bhcYTdHLtP6kAtN2dEiK4GapbiFuZsqptYw2CHlu+Naetl/vVWisHgUeC
         0aKxcUbClYmx80wE92YRA0V7D9syLjMCjVb0FnYmCJOyEDl+gPpPu3BMNFDPz8yoJReh
         uRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=JWu20gynn+GCyqhfKi7ueVN1rMYLMWFkTy6vIZpxh8I=;
        b=CrDmqigHRPcOtCZ36ZkE1IDusWjoN0jWXeaychQNAfqo5zBk2xVqVQvvV5mxGji9/C
         gN1dhuiueuL5p56Ow4dqTeG9y5GySj+AH1wmk6uHYBFj52ZdEIjFbHI0PCvVqTII5OZG
         UuqAseLOoLXz7oc7jDMrgJ1x8MRABQTm5lx43PRcVUH/5nPUp36qKG+7/PtCxbgbLXji
         BmFnLtfqR1elSUuLB+tp3v/C79ko5jvS0IB6/cK1TbUFGArF0MsuG/zdxYSpLnFChMeI
         EdDfNbB45Fc243N96WrtBcV38dCo/UaJ45FRHP21Pz2AJokIawKI270bjkDUM1RZUapG
         5Fiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 78.46.137.84 is neither permitted nor denied by best guess record for domain of lars@metafoo.de) smtp.mailfrom=lars@metafoo.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 78.46.137.84 is neither permitted nor denied by best guess record for domain of lars@metafoo.de) smtp.mailfrom=lars@metafoo.de
Subject: Re: [GIT PULL] USB/PHY driver patches for 4.17-rc1
To: Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
References: <20180404103121.GA7420@kroah.com>
 <CAGXu5jKHivZfs_1KfCMM2i1Z4Q5Vs2k7CX8P2twtuVQ_tWmT7A@mail.gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2d80686d-529d-0238-b91c-3fb88bcf37d5@metafoo.de>
Date: Thu, 5 Apr 2018 09:19:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKHivZfs_1KfCMM2i1Z4Q5Vs2k7CX8P2twtuVQ_tWmT7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596886739239351292?=
X-GMAIL-MSGID: =?utf-8?q?1596889782248518256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/05/2018 08:31 AM, Kees Cook wrote:
> On Wed, Apr 4, 2018 at 3:31 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> Lars-Peter Clausen (2):
>>       usb: gadget: ffs: Execute copy_to_user() with USER_DS set
> 
> https://git.kernel.org/linus/4058ebf33cb0be88ca516f968eda24ab7b6b93e4
> 
> Isn't there a better way to do this without the set_fs() usage? We've
> been try to eliminate it in the kernel. I thought there was a safer
> way to use iters now?

The problem is use_mm(). It needs to be accompanied with set_fs(DS_USER) to
work reliably. This has simply been missing for this particular instance of
use_mm().

Now, in my opinion, use_mm() is not the best approach here in the first
place and instead of using copy_to_user() it is probably better to map the
userspace pages to kernel space and then access them directly. But that's a
lot more intrusive and separate from this issue.

- Lars
