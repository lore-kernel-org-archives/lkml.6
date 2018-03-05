Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELvvMa6np3yLb3Uw8+noh+FonWAukfy+kfU9JUsrfFAL5G2B56dJkYozPerUMZOQLRCWlto7
ARC-Seal: i=1; a=rsa-sha256; t=1520283414; cv=none;
        d=google.com; s=arc-20160816;
        b=EvH7ygsdz1AiazqIrO881zsprTOfooJKP0p5O0VxvIdArjGiSHaOawEcQqRnucirHK
         ukuoTF4pdv4LNktd0zwd3+SfBeHFuavw9ghnbkJCXc+IqHx8S+KNVNowXnInPVaFgGKS
         M91S4T/Y12GCMdb7FjH+qt7EE/nRuEMXxoRFyY/FpooMGsexdZgXcgDI5rAnTqcwfE83
         WtgSglhQ62rJnyryT/GtnRCbK3yh4PqWpwuhTAYoi/k22OMTwtfjDl5LgfET9BVPXUgQ
         5yBjFpmYorvdbGTAx6D2jorfWiFWILa+NjjspvLrmpA3/m001TrnkSx11DE/EaD1ipZd
         easw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=Rx5Dd/mRD4YImc8A5I1rSbQRp+0IPZWvLZypDdId/TM=;
        b=hyAz1aIN3KondGwvoSxBFeaHdCHpbeXxv3NtlN6BepDiLtdq6nswR1cKbdm0Qp6kJg
         N7V6piLWFjyLqufMtlkonWDKvT5D3pnrb3KfFAruqvKb4Xmu4BNLrRpM7/Me3ErQ7Jcb
         LGkZ1AywgO16SfSWK6ptJ3Gi89M5ezgttdMdAo1X/ZfE3N6DoFj7YGcWhOSn75mBq0V2
         C6ZQDIjqOkurTSJvntWcHnI3y5v0qLplBPytClTxxUG/4Vqs013hiWN9Oa6iHiY4iq5Q
         Ctjyq+FTveBVh+YOQR6vNnzgIdFoHsaQK42/6QAe2xMa+UMxxrFeatFkHz66mxxobMta
         U49w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32596995"
Subject: Re: [PATCH v12 09/11] mm: Allow arch code to override copy_highpage()
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
 davem@davemloft.net
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <ecbafa2bfcc05f22183be2e7784ed11943b1d5b2.1519227112.git.khalid.aziz@oracle.com>
 <68ee1cbc-8e21-e693-7878-777e0d5b0f0c@linux.intel.com>
 <8b441f99-ee41-e113-f52d-dbe0573bf267@oracle.com>
Cc: kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de,
 anthony.yznaga@oracle.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <2a558ec8-c46c-299e-2f14-bb33058cbd90@linux.intel.com>
Date: Mon, 5 Mar 2018 12:56:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8b441f99-ee41-e113-f52d-dbe0573bf267@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593031715838543761?=
X-GMAIL-MSGID: =?utf-8?q?1594132701327827658?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 12:42 PM, Khalid Aziz wrote:
> On 03/05/2018 12:24 PM, Dave Hansen wrote:
>> On 02/21/2018 09:15 AM, Khalid Aziz wrote:
>>> +#ifndef __HAVE_ARCH_COPY_HIGHPAGE
>>> +
>>>   static inline void copy_highpage(struct page *to, struct page *from)
>>>   {
>>>       char *vfrom, *vto;
>>> @@ -248,4 +250,6 @@ static inline void copy_highpage(struct page *to,
>>> struct page *from)
>>>       kunmap_atomic(vfrom);
>>>   }
>>>   +#endif
>>
>> I think we prefer that these are CONFIG_* options.
> 
> I added this mechanism to be same as what we have for copy_user_highpage():
> 
> ---------------
> #ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE

I think that's the old way that we generally don't want to add new
instances of.
