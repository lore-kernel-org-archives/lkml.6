Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B744C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5949214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfAIGbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:31:21 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:51403 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbfAIGbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:31:21 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43ZK5f5s3KzB09Zp;
        Wed,  9 Jan 2019 07:31:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id EwtYdEygmGE5; Wed,  9 Jan 2019 07:31:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43ZK5f5JQKzB09Zn;
        Wed,  9 Jan 2019 07:31:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 916578B7F0;
        Wed,  9 Jan 2019 07:31:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Xfv5UHXxnK9N; Wed,  9 Jan 2019 07:31:19 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A05F38B7EA;
        Wed,  9 Jan 2019 07:31:18 +0100 (CET)
Subject: Re: [PATCH] lkdtm: Add a tests for NULL pointer dereference
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
References: <8593f7faf89812a9987d44d9ae615d64dca4d77f.1544800744.git.christophe.leroy@c-s.fr>
 <CAGXu5jKeGp_z_69SybtkSaE381Ui7aXCxp9yBxv=TS0=hSsm-A@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2d2e8cef-dd12-75e8-4779-fe4437e2169c@c-s.fr>
Date:   Wed, 9 Jan 2019 07:31:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKeGp_z_69SybtkSaE381Ui7aXCxp9yBxv=TS0=hSsm-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/01/2019 à 02:14, Kees Cook a écrit :
> On Fri, Dec 14, 2018 at 7:26 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> Introduce lkdtm tests for NULL pointer dereference: check
>> access or exec at NULL address.
> 
> Why is this not already covered by the existing tests? (Is there
> something special about NULL that is being missed?) I'd expect SMAP
> and SMEP to cover NULL as well.

Most arches print a different message whether the faulty address is 
above or under PAGE_SIZE. Below is exemple from x86:

	pr_alert("BUG: unable to handle kernel %s at %px\n",
		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
		 (void *)address);


Until recently, the powerpc arch didn't do it. When I implemented it 
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=49a502ea23bf9dec47f8f3c3960909ff409cd1bb), 
I needed a way to test it and couldn't find an existing one, hence this 
new LKDTM test.

But maybe I missed something ?

Christophe

> 
> -Kees
> 
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   drivers/misc/lkdtm/core.c  |  2 ++
>>   drivers/misc/lkdtm/lkdtm.h |  2 ++
>>   drivers/misc/lkdtm/perms.c | 18 ++++++++++++++++++
>>   3 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
>> index bc76756b7eda..36910e1d5c09 100644
>> --- a/drivers/misc/lkdtm/core.c
>> +++ b/drivers/misc/lkdtm/core.c
>> @@ -157,7 +157,9 @@ static const struct crashtype crashtypes[] = {
>>          CRASHTYPE(EXEC_VMALLOC),
>>          CRASHTYPE(EXEC_RODATA),
>>          CRASHTYPE(EXEC_USERSPACE),
>> +       CRASHTYPE(EXEC_NULL),
>>          CRASHTYPE(ACCESS_USERSPACE),
>> +       CRASHTYPE(ACCESS_NULL),
>>          CRASHTYPE(WRITE_RO),
>>          CRASHTYPE(WRITE_RO_AFTER_INIT),
>>          CRASHTYPE(WRITE_KERN),
>> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
>> index 3c6fd327e166..b69ee004a3f7 100644
>> --- a/drivers/misc/lkdtm/lkdtm.h
>> +++ b/drivers/misc/lkdtm/lkdtm.h
>> @@ -45,7 +45,9 @@ void lkdtm_EXEC_KMALLOC(void);
>>   void lkdtm_EXEC_VMALLOC(void);
>>   void lkdtm_EXEC_RODATA(void);
>>   void lkdtm_EXEC_USERSPACE(void);
>> +void lkdtm_EXEC_NULL(void);
>>   void lkdtm_ACCESS_USERSPACE(void);
>> +void lkdtm_ACCESS_NULL(void);
>>
>>   /* lkdtm_refcount.c */
>>   void lkdtm_REFCOUNT_INC_OVERFLOW(void);
>> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
>> index fa54add6375a..62f76d506f04 100644
>> --- a/drivers/misc/lkdtm/perms.c
>> +++ b/drivers/misc/lkdtm/perms.c
>> @@ -164,6 +164,11 @@ void lkdtm_EXEC_USERSPACE(void)
>>          vm_munmap(user_addr, PAGE_SIZE);
>>   }
>>
>> +void lkdtm_EXEC_NULL(void)
>> +{
>> +       execute_location(NULL, CODE_AS_IS);
>> +}
>> +
>>   void lkdtm_ACCESS_USERSPACE(void)
>>   {
>>          unsigned long user_addr, tmp = 0;
>> @@ -195,6 +200,19 @@ void lkdtm_ACCESS_USERSPACE(void)
>>          vm_munmap(user_addr, PAGE_SIZE);
>>   }
>>
>> +void lkdtm_ACCESS_NULL(void)
>> +{
>> +       unsigned long tmp;
>> +       unsigned long *ptr = (unsigned long *)NULL;
>> +
>> +       pr_info("attempting bad read at %px\n", ptr);
>> +       tmp = *ptr;
>> +       tmp += 0xc0dec0de;
>> +
>> +       pr_info("attempting bad write at %px\n", ptr);
>> +       *ptr = tmp;
>> +}
>> +
>>   void __init lkdtm_perms_init(void)
>>   {
>>          /* Make sure we can write to __ro_after_init values during __init */
>> --
>> 2.13.3
>>
> 
> 
