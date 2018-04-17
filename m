Return-Path: <gkohli@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/Onb26y/dxanJEJ/xFklSd7zu01gCdcNHnwNT5nLrLCJKvrtQn/Jdt14k4+eDgpiAdNoCQ
ARC-Seal: i=1; a=rsa-sha256; t=1523946590; cv=none;
        d=google.com; s=arc-20160816;
        b=VqhGplTHO+4AbvKui72pmEaDHag+nOxsMhRyKVJIdC3SJKgJ3RZazYzbCEU4Y/bMUK
         1ozK7pft2GXDVCF+l82oPdMOpLAfcid7olKl6kEKwcrGEXw+aUqDMCR2qlMP81rPNBH8
         jAB5F/6mTRWSOS4c7YN2q9tO42kPQfBBUObPLlMIKLBrOhWHgxojXUB81U+oiM6nLzzj
         9W0jw0Zs1CLva0vusy0aAYSutgt9+DLKWCZreaaYypfYp7Mx9rGikIy0Au2VcPKffvMg
         dMFrekKnvnoPSNJrSPZravgAk6g30phpZSA4r3xgda5w0+RdMUWBlsbzwwFedVY1Mzuj
         zD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ybvGS2NkaFo74f0xK5C14mjhcHrgQAQjHB270eky5Ms=;
        b=ENvsQ7EJjgBhLUhgOt+590aigzG+z8kztFVI68SL7oDaYrRDOKNUgsu3Yp6vwiBWoG
         90Y6gQcrxrHzUjybgozPuwWl8GIJAfdFpvdtEFBeUOchxhjNIvrdihi6nsR8eMWiveL0
         VL56HP/KRly8E/Qn2FBBIfoifW7UwOY5NgFI1y7vpkq5kVGOI2Pr6RALDKRz7RzQpme1
         aqy9ZdDgpC076FBfXzMFLxpT8F7fbiawNVFCQBRiYpF7KlY5czql2j9NUndmE3CfBJi1
         KK02E260Yqp5XKKwBORodLcAkUv27WM5tVMqi7YxbwBRvkLKjv4vsAwZmjijf2HVRQbE
         uEDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DOBf8M30;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DOBf8M30;
       spf=pass (google.com: domain of gkohli@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=gkohli@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DOBf8M30;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DOBf8M30;
       spf=pass (google.com: domain of gkohli@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=gkohli@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 521B6603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH] percpu_counter: Remove debug_object_free call twice
To: Tejun Heo <tj@kernel.org>
Cc: gregkh@linuxfoundation.org, nborisov@suse.com, akpm@linux-foundation.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523612103-15071-1-git-send-email-gkohli@codeaurora.org>
 <20180416214810.GF1911913@devbig577.frc2.facebook.com>
From: "Kohli, Gaurav" <gkohli@codeaurora.org>
Message-ID: <a9ef4575-bfb9-c854-ea71-0a5e1af97f5d@codeaurora.org>
Date: Tue, 17 Apr 2018 11:59:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416214810.GF1911913@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597623102391720322?=
X-GMAIL-MSGID: =?utf-8?q?1597973819869044767?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/17/2018 3:18 AM, Tejun Heo wrote:

> On Fri, Apr 13, 2018 at 03:05:03PM +0530, Gaurav Kohli wrote:
>> During percpu_counter destroy, debug_object_free is calling
>> twice which may create race. So removing once instance of call
>> from debug_percpu_counter_deactivate.
> I don't quite follow.  Can you please elaborate how it can be called
> twice?

Hi Tejun,

In percpu_counter_fixup_free function, first call is percpu_counter_destroy -> debug_percpu_counter_deactivate (this will set inactive and free the debug object as well for percpu counter) -> free_percpu (finally freeing the counters).

Below is the code snippet:

         case DEBUG_STATE_ACTIVE:

                 percpu_counter_destroy(fbc); -> first call

                 debug_object_free(fbc, &percpu_counter_debug_descr); -> this will again call the same debug object free, if somehow counters will reinitialize between these two calls.

                 

We are seeing one race condition issue where one object of db list is corrupted and just before object of that corrupted node is percpu_counter, Still i am not sure the reason of race as it is very

difficult to reproduce. But i have found this during code review. Please correct me, if i misunderstood this.

>
> Thanks.
>
>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
