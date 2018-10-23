Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EACC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B6820671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B6820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeJWX1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:27:11 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:37729 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeJWX1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:27:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3B7022103C;
        Tue, 23 Oct 2018 15:03:23 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tKbjgDn9uMwD; Tue, 23 Oct 2018 15:03:23 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id D6D1A2100E;
        Tue, 23 Oct 2018 15:03:02 +0000 (UTC)
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
To:     Michal Hocko <mhocko@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181022125142.GD18839@dhcp22.suse.cz>
 <20181022165253.uphv3xzqivh44o3d@pc636>
 <20181023072306.GN18839@dhcp22.suse.cz>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <dd0c3528-9c01-12bc-3400-ca88060cb7cf@kernel.org>
Date:   Tue, 23 Oct 2018 09:02:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023072306.GN18839@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 10/23/2018 01:23 AM, Michal Hocko wrote:
> Hi Shuah,
> 
> On Mon 22-10-18 18:52:53, Uladzislau Rezki wrote:
>> On Mon, Oct 22, 2018 at 02:51:42PM +0200, Michal Hocko wrote:
>>> Hi,
>>> I haven't read through the implementation yet but I have say that I
>>> really love this cover letter. It is clear on intetion, it covers design
>>> from high level enough to start discussion and provides a very nice
>>> testing coverage. Nice work!
>>>
>>> I also think that we need a better performing vmalloc implementation
>>> long term because of the increasing number of kvmalloc users.
>>>
>>> I just have two mostly workflow specific comments.
>>>
>>>> A test-suite patch you can find here, it is based on 4.18 kernel.
>>>> ftp://vps418301.ovh.net/incoming/0001-mm-vmalloc-stress-test-suite-v4.18.patch
>>>
>>> Can you fit this stress test into the standard self test machinery?
>>>
>> If you mean "tools/testing/selftests", then i can fit that as a kernel module.
>> But not all the tests i can trigger from kernel module, because 3 of 8 tests
>> use __vmalloc_node_range() function that is not marked as EXPORT_SYMBOL.
> 
> Is there any way to conditionally export these internal symbols just for
> kselftests? Or is there any other standard way how to test internal
> functionality that is not exported to modules?
> 

The way it can be handled is by adding a test module under lib. test_kmod,
test_sysctl, test_user_copy etc.

There is a corresponding test script e.g selftests/kmod/kmod.sh that loads
the module and runs tests.

Take a look at lib/test_overflow.c - It is running some vmalloc_node tests
test_overflow.c:DEFINE_TEST_ALLOC(vmalloc_node,  vfree,	     0, 0, 1);
test_overflow.c:DEFINE_TEST_ALLOC(kvmalloc_node, kvfree,     0, 1, 1);
test_overflow.c:	err |= test_kvmalloc_node(NULL);
test_overflow.c:	err |= test_vmalloc_node(NULL);

This module could be extended to tun these stress tests perhaps? I don't see a
selftests test script for test_overflow, one could be added.

Adding Kees Cook to the thread for input on test_overflow.

thanks,
-- Shuah

