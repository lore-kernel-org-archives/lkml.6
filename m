Return-Path: <ghackmann@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519755363; cv=none;
        d=google.com; s=arc-20160816;
        b=rcryRIoApuOKaB9YcnxcH2HUlu5CeU59uwOGNb7dyLCxbuKHkrN4kpSxEHiTxvjWQT
         LIMlS/HHS7wgLllAfHxs/huikgVt1PRSYxxgLjMsTTvTomVny2vKBUdcwrpujuxM2nZH
         gKJviOimeEZdeLVtH8LsWN9c0oLtAnbF1HDKN/FuJF73jTgSRU+vHE3WmxEmwPDGXGMj
         lHEp3FciWNVmpHc5AwonuKhokeYrw/ekHJ6gQ4t5xmxu1piwjrHwSn1s0BEtjy61T59j
         MGOvaiA2XvGKoAPfsFzYtvF49i7RiGqwiYuj7NsF813dFWxeGdT4EFKvczel8hBsddvz
         wHtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=q1+tb5auK6ygaN43iQq0m2FE6+xm++j9R6f4Un/r+ZE=;
        b=GO0Vldrjb4Vb8CWfe6HyBxeaPCFs0htuJD/POaAPK7dqG+hblL8EWp2DB1mr8+FwNC
         Z6dm7gC966AhP5VeDC29lyuG14wyRV80VYylZgdniyZGJtA955Bt4m+eW0UjGq+jvybi
         Ah+k3d0Y1aL3Ku7wPFJzvOlIEB01nzKxdttSuJEaspK3oLOtPlycMveTCmxrHP/mjXCx
         Hc6Bg5zQokGmgf8OhMlMP48xXfba8xDwt0bMyuv+P6IurgcQquFoZnurXQDdcfkT6Yob
         Tqzfhm1yMMsR8LAnNI0kxr5SZxcuDLs1LAOrC8u5Ho2dASJWIz/uJWH98GkmPnzk7+Uc
         oTvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=OLL2OKeU;
       spf=pass (google.com: domain of ghackmann@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ghackmann@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=OLL2OKeU;
       spf=pass (google.com: domain of ghackmann@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ghackmann@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AH8x2277LlcA1TUWvVr7cJw/psMJt93kEpEarvJeG/FJfIUzOLUppsLsd3kBfZ1dIndfJgEMMhICYg==
Subject: Re: [PATCH v2] staging: android: ashmem: Fix lockdep issue during
 llseek
To: Joel Fernandes <joelaf@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
 Arve Hjonnevag <arve@android.com>, stable@vger.kernel.org
References: <20180216190201.59572-1-joelaf@google.com>
 <20180222134832.GA1400@kroah.com>
 <CAJWu+or6oK--zi6uDUipHY42wf79aVHo3WuZXXUvzR-7Atod4A@mail.gmail.com>
From: Greg Hackmann <ghackmann@google.com>
Message-ID: <8242bd71-4c84-73d4-81a1-01471024c338@google.com>
Date: Tue, 27 Feb 2018 10:16:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAJWu+or6oK--zi6uDUipHY42wf79aVHo3WuZXXUvzR-7Atod4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1593132500003855945?=
X-GMAIL-MSGID: =?utf-8?q?1593579000282397422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/22/2018 01:02 PM, Joel Fernandes wrote:
> (reposting in plain text, sorry for the previous HTML email, I should
> have not posted from the Phone)
> 
> On Thu, Feb 22, 2018 at 5:48 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Fri, Feb 16, 2018 at 11:02:01AM -0800, Joel Fernandes wrote:
>>> ashmem_mutex create a chain of dependencies like so:
>>>
>>> (1)
>>> mmap syscall ->
>>>   mmap_sem ->  (acquired)
>>>   ashmem_mmap
>>>   ashmem_mutex (try to acquire)
>>>   (block)
>>>
>>> (2)
>>> llseek syscall ->
>>>   ashmem_llseek ->
>>>   ashmem_mutex ->  (acquired)
>>>   inode_lock ->
>>>   inode->i_rwsem (try to acquire)
>>>   (block)
>>>
>>> (3)
>>> getdents ->
>>>   iterate_dir ->
>>>   inode_lock ->
>>>   inode->i_rwsem   (acquired)
>>>   copy_to_user ->
>>>   mmap_sem         (try to acquire)
>>>
>>> There is a lock ordering created between mmap_sem and inode->i_rwsem
>>> causing a lockdep splat [2] during a syzcaller test, this patch fixes
>>> the issue by unlocking the mutex earlier. Functionally that's Ok since
>>> we don't need to protect vfs_llseek.
>>>
>>> [1] https://patchwork.kernel.org/patch/10185031/
>>> [2] https://lkml.org/lkml/2018/1/10/48
>>>
>>> Cc: Todd Kjos <tkjos@google.com>
>>> Cc: Arve Hjonnevag <arve@android.com>
>>> Cc: Greg Hackmann <ghackmann@google.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com
>>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>>> ---
>>> Changes since first version:
>>> Don't relock after vfs call since its not needed. Only reason we lock is
>>> to protect races with asma->file.
>>> https://patchwork.kernel.org/patch/10185031/
>>
>> I'd like some acks from others before I take this patch.
> 
> GregH, Todd, could you provide Acks?

Acked-by: Greg Hackmann <ghackmann@google.com>
