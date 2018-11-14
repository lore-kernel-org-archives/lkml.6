Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC58C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4852A22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BA4LdDtO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yeibz1Jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4852A22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeKODg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:36:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49624 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbeKODg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:36:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BBFF0606E1; Wed, 14 Nov 2018 17:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542216771;
        bh=rm+0L8MwEivEl4nYerhTAxYAzFfv3FnWMx3/8gDSrXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BA4LdDtO9VgV6JIcokz/1+UoB8qSS75hMNyTNzajA+ATctBOspNSj0uLX/hJK42Qr
         lIlnsnoOH3PAxPtyX4N9Izemj2YX9wuDeKfqraAGMyYXYTPScSghW1ve7l5V//1igC
         ZvJNaof/ORHkR8GgEG4a+75LpfPJqlWYkJgGiIB4=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DA92B60591;
        Wed, 14 Nov 2018 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542216770;
        bh=rm+0L8MwEivEl4nYerhTAxYAzFfv3FnWMx3/8gDSrXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yeibz1JwexR/+xLXat8iBWCamdKz3j5lGqItHZpTjALcnzrSzFPuU+CV6qr47Wyto
         KSoQ3Q7uiskw3hxN4dgZawinfAH6N7hJve3g4J+9EgiChuD6WmBlpUtyOPTNOVngBJ
         P0t70xEDaJHTjFgZs9ZkNinl7V2fImZo5aTkkYDE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Nov 2018 09:32:50 -0800
From:   isaacm@codeaurora.org
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>, crecklin@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/usercopy: Use memory range to be accessed for
 wraparound check
In-Reply-To: <7C54170F-DE66-47E0-9C0D-7D1A97DCD339@oracle.com>
References: <1542156686-12253-1-git-send-email-isaacm@codeaurora.org>
 <FFE931C2-DE41-4AD8-866B-FD37C1493590@oracle.com>
 <5dcd06a0f84a4824bb9bab2b437e190d@AcuMS.aculab.com>
 <7C54170F-DE66-47E0-9C0D-7D1A97DCD339@oracle.com>
Message-ID: <50baa4900e55b523f18eea2759f8efae@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-14 03:46, William Kucharski wrote:
>> On Nov 14, 2018, at 4:09 AM, David Laight <David.Laight@ACULAB.COM> 
>> wrote:
>> 
>> From: William Kucharski
>>> Sent: 14 November 2018 10:35
>>> 
>>>> On Nov 13, 2018, at 5:51 PM, Isaac J. Manjarres 
>>>> <isaacm@codeaurora.org> wrote:
>>>> 
>>>> diff --git a/mm/usercopy.c b/mm/usercopy.c
>>>> index 852eb4e..0293645 100644
>>>> --- a/mm/usercopy.c
>>>> +++ b/mm/usercopy.c
>>>> @@ -151,7 +151,7 @@ static inline void check_bogus_address(const 
>>>> unsigned long ptr, unsigned long n,
>>>> 				       bool to_user)
>>>> {
>>>> 	/* Reject if object wraps past end of memory. */
>>>> -	if (ptr + n < ptr)
>>>> +	if (ptr + (n - 1) < ptr)
>>>> 		usercopy_abort("wrapped address", NULL, to_user, 0, ptr + n);
>>> 
>>> I'm being paranoid, but is it possible this routine could ever be 
>>> passed "n" set to zero?
>>> 
>>> If so, it will erroneously abort indicating a wrapped address as (n - 
>>> 1) wraps to ULONG_MAX.
>>> 
>>> Easily fixed via:
>>> 
>>> 	if ((n != 0) && (ptr + (n - 1) < ptr))
>> 
>> Ugg... you don't want a double test.
>> 
>> I'd guess that a length of zero is likely, but a usercopy that 
>> includes
>> the highest address is going to be invalid because it is a kernel 
>> address
>> (on most archs, and probably illegal on others).
>> What you really want to do is add 'ptr + len' and check the carry 
>> flag.
> 
> The extra test is only a few extra instructions, but I understand the
> concern. (Though I don't
> know how you'd access the carry flag from C in a machine-independent
> way. Also, for the
> calculation to be correct you still need to check 'ptr + (len - 1)'
> for the wrap.)
> 
> You could also theoretically call gcc's __builtin_uadd_overflow() if
> you want to get carried away.
> 
> As I mentioned, I was just being paranoid, but the passed zero length
> issue stood out to me.
> 
>     William Kucharski

Hi William,

Thank you and David for your feedback. The check_bogus_address() routine 
is only invoked from one place in the kernel, which is 
__check_object_size(). Before invoking check_bogus_address, 
__check_object_size ensures that n is non-zero, so it is not possible to 
call this routine with n being 0. Therefore, we shouldn't run into the 
scenario you described. Also, in the case where we are copying a page's 
contents into a kernel space buffer and will not have that buffer 
interacting with userspace at all, this change to that check should 
still be valid, correct?

Thanks,
Isaac Manjarres
