Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755251AbeDPNnQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755208AbeDPNnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:43:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B72321789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Mon, 16 Apr 2018 15:43:09 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Kees Cook <keescook@chromium.org>
Subject: Re: Wrong module .text address in 4.16.0
Message-ID: <20180416134309.lt7mrxe5khcuhozl@redbean>
References: <7e17e3b1-25c3-cb61-ae94-dcbb1bf3473e@linux.ibm.com>
 <3836add7-8691-77c1-33d2-0fbee7051795@de.ibm.com>
 <2dc648ad-0a6b-ba79-5d6a-fb3e3029994f@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2dc648ad-0a6b-ba79-5d6a-fb3e3029994f@de.ibm.com>
X-OS: Linux redbean 4.15.3-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Christian Borntraeger [16/04/18 12:53 +0200]:
>Can this be related to
>commit ef0010a30935de4e0211cbc7bdffc30446cdee9b
>    vsprintf: don't use 'restricted_pointer()' when not restricting
>and related commits?
>
>To me it looks like %pk is always printing the hash, but never the real pointer -
>no matter what kernel.kptr_restrict says.

(Added Kees and Tobin to CC)

Can confirm, a git bisect confirms that ef0010a3093 was the first bad commit.

And yeah, the default seems to be to always hash the pointer address now,
regardless of kptr_restrict. See Documentation/sysctl/kernel.txt:

    When kptr_restrict is set to 0 (the default) the address is hashed before
    printing. (This is the equivalent to %p.)

And to quote from the relevant patchset (https://lkml.org/lkml/2017/11/28/1593):

   The added advantage of hashing %p is that security is now opt-out, if
   you _really_ want the address you have to work a little harder and use %px.

So for users of /sys/module/*/sections, we will need to work around
this and possibly use %px for the real address. But perhaps we should
base the usage of %px on kptr_restrict? That is what m_show() in
module.c currently does, which is why you get the correct address when
you look at /proc/modules (it uses %px and either shows 0's or the
real address based on kallsyms_show_value()). module_sect_show() uses
%pK so it's getting hashed. Is there a better way of doing this?

Jessica

>
>
>On 04/16/2018 08:23 AM, Christian Borntraeger wrote:
>> FWIW, this breaks at least perf capability to resolve module symbols.
>> Adding some more CCs for perf and module.
>>
>>
>> On 04/16/2018 07:51 AM, Thomas-Mich Richter wrote:
>>> I just installed 4.16.0 and discovered the module .text address is
>>> wrong. It happens on s390 and x86 platforms. I have not tested others.
>>>
>>> Here is the issue, I have used module qeth_l2 on s390 which is the
>>> ethernet device driver:
>>>
>>> root@s35lp76 ~]# lsmod
>>> Module                  Size  Used by
>>> qeth_l2                94208  1
>>> ...
>>>
>>> [root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
>>> qeth_l2 94208 1 - Live 0x000003ff80401000   <---- This is the correct address in memory
>>> [root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
>>> 0x0000000018ea8363      <---- This is the wrong address
>>> [root@s35lp76 ~]#
>>>
>>> File /sys/module/qeth_l2/sections/.text displays a very strange
>>> address which is definitely wrong. It should be something like
>>> 0x000003ff80401xxx.
>>>
>>> Same on x86.
>>>
>>> I have checked file kernel/module.c function add_sect_attrs()
>>> and it calls module_sect_show() when the sysfs file is read.
>>> And module_sect_show() uses
>>>
>>>   sprintf(buf, "0x%pK\n", (void *)sattr->address);
>>>
>>> and my sysctl setting should be correct:
>>> [root@s35lp76 linux]# sysctl -a | fgrep kernel.kptr_restrict
>>> kernel.kptr_restrict = 0
>>> [root@s35lp76 linux]#
>>>
>>> I wonder if somebody else has seen this issue?
>>> Ideas how to fix this?
>>>
>>> Thanks
>>>
>
