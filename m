Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbeDPMnL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:43:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33773 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbeDPMnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:43:09 -0400
X-Google-Smtp-Source: AIpwx49frWSDCaGnOU7Dizy/3d/CugcYtRz1YciL/EYR1CfRwA5OF6zaN58o4+3EQEnwyWJo4Tsnmg==
Subject: Re: Crashes/hung tasks with z3pool under memory pressure
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mawilcox@microsoft.com,
        asavery@chromium.org, gwendal@chromium.org
References: <20180412215501.GA16406@roeck-us.net>
 <CAMJBoFMq8DoWdcrajB_xyMrGXsUsbMjos_U60mOvf01MpK_9Kw@mail.gmail.com>
 <20180413173555.GA30587@roeck-us.net>
 <CAMJBoFPXObpXyQWz-zPJ7JnC-Z5FqqrLfr5BFWKdh+szZrPZ7A@mail.gmail.com>
 <20180413175615.GA30242@roeck-us.net>
From: Vitaly Wool <vitalywool@gmail.com>
Message-ID: <b241e25a-50a3-fefb-0443-ad6c0a200898@gmail.com>
Date: Mon, 16 Apr 2018 14:43:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413175615.GA30242@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Guenter,

On 04/13/2018 07:56 PM, Guenter Roeck wrote:

> On Fri, Apr 13, 2018 at 05:40:18PM +0000, Vitaly Wool wrote:
>> On Fri, Apr 13, 2018, 7:35 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>>> On Fri, Apr 13, 2018 at 05:21:02AM +0000, Vitaly Wool wrote:
>>>> Hi Guenter,
>>>>
>>>>
>>>> Den fre 13 apr. 2018 kl 00:01 skrev Guenter Roeck <linux@roeck-us.net>:
>>>>
>>>>> Hi all,
>>>>> we are observing crashes with z3pool under memory pressure. The kernel
>>>> version
>>>>> used to reproduce the problem is v4.16-11827-g5d1365940a68, but the
>>>> problem was
>>>>> also seen with v4.14 based kernels.
>>>>
>>>> just before I dig into this, could you please try reproducing the errors
>>>> you see with https://patchwork.kernel.org/patch/10210459/ applied?
>>>>
>>> As mentioned above, I tested with v4.16-11827-g5d1365940a68, which already
>>> includes this patch.
>>>
>> Bah. Sorry. Expect an update after the weekend.
>>
> NP; easy to miss. Thanks a lot for looking into it.
>
I wonder if the following patch would make a difference:

diff --git a/mm/z3fold.c b/mm/z3fold.c
index c0bca6153b95..5e547c2d5832 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -887,19 +887,21 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
  				goto next;
  		}
  next:
-		spin_lock(&pool->lock);
  		if (test_bit(PAGE_HEADLESS, &page->private)) {
  			if (ret == 0) {
-				spin_unlock(&pool->lock);
  				free_z3fold_page(page);
  				return 0;
  			}
-		} else if (kref_put(&zhdr->refcount, release_z3fold_page)) {
-			atomic64_dec(&pool->pages_nr);
-			spin_unlock(&pool->lock);
-			return 0;
+		} else {
+			spin_lock(&zhdr->page_lock);
+			if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
+				atomic64_dec(&pool->pages_nr);
+				return 0;
+			}
+			spin_unlock(&zhdr->page_lock);
  		}
  
+		spin_lock(&pool->lock);
  		/*
  		 * Add to the beginning of LRU.
  		 * Pool lock has to be kept here to ensure the page has


Thanks,
    Vitaly
