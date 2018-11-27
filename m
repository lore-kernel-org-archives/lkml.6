Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAD4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029A520989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIKHCaSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029A520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbeK0Woz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:44:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40241 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbeK0Woz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:44:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so2921996plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 03:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mwvhNdR1EhiABwT3xRrVWZkKtPImWKblPUYbLoJCiaE=;
        b=PIKHCaScSkPsejJGFDXaulgxlR/9h2f0bl1R4m30Ze9EQLqAKFejs1CVaLSOb3QNN+
         /H9sfrq3nvDAEdnQgJN/pe5BnFS1rP2h1gEhEXiy1o6mvLl2CAj0ESNjl2d7NEcnyfvi
         RAywSp+Y03qDBQOIr+/uUXBLkPQfS/FitBAwfmGagUOIrW8GU/HQqRhz8hJzG6Ne2CD4
         JMG9K59dUPXJhB+X4L1Jmx8S6qDTolZcivbW7SCz9DHeKIDe/ozAyrgaUCyH67ELzLOf
         JHqIOkfpAFgDJd7NwwCBazHMGnuqf76soUskcGi/Qk+GNfCv7KxR/Te/HRdkbepLUVud
         4i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mwvhNdR1EhiABwT3xRrVWZkKtPImWKblPUYbLoJCiaE=;
        b=GUzxTuzQFyjVbW/QuRJpzIaAZC3aikQkvJ8Bi6/Rhvne0NmwiE8cfhT8Ev4TYVKyx+
         ukjfIGbnEQpWdtX+lRjMvuGvwDbfr0BeobLjW00oMsXMBKPS8yehzY5ZDImQMbb0JGBg
         ppPq/nMQoXtx691fgyFfCGgrWKtZDaMeVAS29Wv8iAyLv6myHKMsW2XxfQCaW0gWrX/D
         1E7JKNYoBzIzhJGgXo137+C2Z+ER9CZkz3ZUs0hOZgEnb4nlrDZs2vuM/5DjvXlW/z72
         eACbh3atoe5N2gdYY5c0ocCIQvyKjn91zjdql382nQDkP4suXAspD+Q/Tz4hFbg5xLxG
         J6Dw==
X-Gm-Message-State: AA+aEWbn1LB5HoTpx0BC9OxWcpsEZYwYJjtviJTIwuXU0FW0XTf9Vunc
        nXyTzVc37TX2E9np6Pa70p8=
X-Google-Smtp-Source: AFSGD/WGSZXBQ/4xS00LrjzbK3SobEE3a1HaQiPUeza93y3HZnvudB458kLkKsuS+yz+WDOEBGG1zA==
X-Received: by 2002:a17:902:7e0d:: with SMTP id b13mr32393486plm.154.1543319237028;
        Tue, 27 Nov 2018 03:47:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 79sm3805808pge.66.2018.11.27.03.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 03:47:15 -0800 (PST)
Subject: Re: [PATCH 3/3] s390/mm: fix mis-accounting of pgtable_bytes
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Li Wang <liwang@redhat.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <1539621759-5967-1-git-send-email-schwidefsky@de.ibm.com>
 <1539621759-5967-4-git-send-email-schwidefsky@de.ibm.com>
 <CAEemH2cHNFsiDqPF32K6TNn-XoXCRT0wP4ccAeah4bKHt=FKFA@mail.gmail.com>
 <20181031073149.55ddc085@mschwideX1> <20181031100944.GA3546@osiris>
 <20181031103623.6ykzsjdenrpeth7x@kshutemo-mobl1>
 <20181127073411.GA3625@osiris>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fa0269be-48e5-c987-50b6-4dc94ac8f086@roeck-us.net>
Date:   Tue, 27 Nov 2018 03:47:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127073411.GA3625@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 11:34 PM, Heiko Carstens wrote:
> On Wed, Oct 31, 2018 at 01:36:23PM +0300, Kirill A. Shutemov wrote:
>> On Wed, Oct 31, 2018 at 11:09:44AM +0100, Heiko Carstens wrote:
>>> On Wed, Oct 31, 2018 at 07:31:49AM +0100, Martin Schwidefsky wrote:
>>>> Thanks for testing. Unfortunately Heiko reported another issue yesterday
>>>> with the patch applied. This time the other way around:
>>>>
>>>> BUG: non-zero pgtables_bytes on freeing mm: -16384
>>>>
>>>> I am trying to understand how this can happen. For now I would like to
>>>> keep the patch on hold in case they need another change.
>>>
>>> FWIW, Kirill: is there a reason why this "BUG:" output is done with
>>> pr_alert() and not with VM_BUG_ON() or one of the WARN*() variants?
>>>
>>> That would to get more information with DEBUG_VM and / or
>>> panic_on_warn=1 set. At least for automated testing it would be nice
>>> to have such triggers.
>>
>> Stack trace is not helpful there. It will always show the exit path which
>> is useless.
> 
> So, even with the updated version of these patches I can flood dmesg
> and the console with
> 
> BUG: non-zero pgtables_bytes on freeing mm: 16384
> 
> messages with this complex reproducer on s390:
> 
> echo "void main(void) {}" | gcc -m31 -xc -o compat - && ./compat
> 
> Besides that this needs to be fixed, I'd really like to see this
> changed to either a printk_once() or a WARN_ON_ONCE() within
> check_mm() so that an arbitrary user cannot flood the console.
> 
> E.g. something like the below. If there aren't any objections, I will
> provide a proper patch with changelog, etc.
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 07cddff89c7b..d7aeec03c57f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -647,8 +647,8 @@ static void check_mm(struct mm_struct *mm)
>   	}
>   
>   	if (mm_pgtables_bytes(mm))
> -		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
> -				mm_pgtables_bytes(mm));
> +		printk_once(KERN_ALERT "BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
> +			    mm_pgtables_bytes(mm));
>   

pr_alert_once ?

Guenter

>   #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
>   	VM_BUG_ON_MM(mm->pmd_huge_pte, mm);
> 
> 

