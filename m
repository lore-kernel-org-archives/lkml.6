Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754294AbeDYNBq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:01:46 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34068 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753367AbeDYNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:01:42 -0400
X-Google-Smtp-Source: AIpwx49ggOcvv0SsmY10Sv+tvUsTpaBPWTDemdnk5/dmctDoux1imUPFF3xFq2sPfRsoaLBp7nV5nQ==
Subject: Re: [PATCH net-next 1/2] tcp: add TCP_ZEROCOPY_RECEIVE support for
 zerocopy receive
To: Christoph Hellwig <hch@infradead.org>,
        Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Soheil Hassas Yeganeh <soheil@google.com>
References: <20180425052722.73022-1-edumazet@google.com>
 <20180425052722.73022-2-edumazet@google.com>
 <20180425062859.GA23914@infradead.org>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <5cd31eba-63b5-9160-0a2e-f441340df0d3@gmail.com>
Date: Wed, 25 Apr 2018 06:01:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425062859.GA23914@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/24/2018 11:28 PM, Christoph Hellwig wrote:
> On Tue, Apr 24, 2018 at 10:27:21PM -0700, Eric Dumazet wrote:
>> When adding tcp mmap() implementation, I forgot that socket lock
>> had to be taken before current->mm->mmap_sem. syzbot eventually caught
>> the bug.
>>
>> Since we can not lock the socket in tcp mmap() handler we have to
>> split the operation in two phases.
>>
>> 1) mmap() on a tcp socket simply reserves VMA space, and nothing else.
>>   This operation does not involve any TCP locking.
>>
>> 2) setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) implements
>>  the transfert of pages from skbs to one VMA.
>>   This operation only uses down_read(&current->mm->mmap_sem) after
>>   holding TCP lock, thus solving the lockdep issue.
>>
>> This new implementation was suggested by Andy Lutomirski with great details.
> 
> Thanks, this looks much more sensible to me.
> 

Thanks Christoph

Note the high cost of zap_page_range(), needed to avoid -EBUSY being returned
from vm_insert_page() the second time TCP_ZEROCOPY_RECEIVE is used on one VMA.

Ideally a vm_replace_page() would avoid this cost ?

     6.51%  tcp_mmap  [kernel.kallsyms]  [k] unmap_page_range                                         
     5.90%  tcp_mmap  [kernel.kallsyms]  [k] vm_insert_page                                           
     4.85%  tcp_mmap  [kernel.kallsyms]  [k] _raw_spin_lock                                           
     4.50%  tcp_mmap  [kernel.kallsyms]  [k] mark_page_accessed                                       
     3.51%  tcp_mmap  [kernel.kallsyms]  [k] page_remove_rmap                                         
     2.99%  tcp_mmap  [kernel.kallsyms]  [k] page_add_file_rmap                                       
     2.53%  tcp_mmap  [kernel.kallsyms]  [k] release_pages                                            
     2.38%  tcp_mmap  [kernel.kallsyms]  [k] put_page                                                 
     2.37%  tcp_mmap  [kernel.kallsyms]  [k] smp_call_function_single                                 
     2.28%  tcp_mmap  [kernel.kallsyms]  [k] __get_locked_pte                                         
     2.25%  tcp_mmap  [kernel.kallsyms]  [k] do_tcp_setsockopt.isra.35                                
     2.21%  tcp_mmap  [kernel.kallsyms]  [k] page_clear_age                         
