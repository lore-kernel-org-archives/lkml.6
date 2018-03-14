Return-Path: <kernel-hardening-return-12612-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvr697grDChAaq3OZEpS5Vw/IlUaEIBuo7J8Y+CPog/B/52K0RuRTNlWC4mG75/TSTDGsFC
ARC-Seal: i=1; a=rsa-sha256; t=1521049449; cv=none;
        d=google.com; s=arc-20160816;
        b=NkG+nA3thA+RjXmNH8sDSQMpSrg5kxklVIbWpYb3CYYz25w+rPGx3Wb1R2SvL+lE0m
         I1KCq9aVjCiFAFr1hbLTaPEKKbNxeKDaGpY0GX8MKjulvKutTzuAwkMe7YeYj0YkwuJC
         sB4q7F2qChJIP0Wz6wIMoESNUsqhlzwHo+DF7cJRlkD2lXrDv9IugcA/aPJn3HfzDEJz
         mxQQKmWIuMJfd8+lpw8/dTl6ES8mVTQ27HpmsB8OGOvdgp3eZlgfD6puy3FK4zTXTpRm
         pkVtsm0D1Iuti7qDRklFAVwDbwm1R6Sz8lEheIhK3FCPQkn3gV3bhA2p527SV9POzGdR
         x5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=yzdILt00B4EjKrlLJ7gnXbMNAFLn3k/aGh1gRsS+7Hg=;
        b=M+FWEgmn0JgKQrBNLWwhK6r+X/J8h5MMmfEaxeVL7itAWCodHtDqTLquEfA45+HI3y
         hGnipw4zE4Gp1exekZ1wYDYH7NF23w4dp+fvS3a7VcZQWEvnwm4tovc5bNiMOw2UFk84
         I2dyNVMM+dBgyBiEdTCXWTo06SAaHtB/U3SnEDo2zuijs5wnzTDAApIX8VXt7KXw8miV
         O34RrRaAqi/4oeW7cmGpUIqAM1oXPZfKbWhsG26iUqATJqyL7LYtJoSWED9Fp0zqEVxv
         MiPjQSjXjsy7p7At+rXZp5VVh/cRT1GMJMkBFke/zgOzxsQW+95Dhdafpyp8peRCS0Tr
         RNDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H113QMdJ;
       spf=pass (google.com: domain of kernel-hardening-return-12612-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12612-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=H113QMdJ;
       spf=pass (google.com: domain of kernel-hardening-return-12612-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12612-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/8] struct page: add field for vm_struct
To: Matthew Wilcox <willy@infradead.org>, Igor Stoppa <igor.stoppa@huawei.com>
Cc: david@fromorbit.com, rppt@linux.vnet.ibm.com, keescook@chromium.org,
 mhocko@kernel.org, labbott@redhat.com,
 linux-security-module@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <20180313214554.28521-5-igor.stoppa@huawei.com>
 <20180313220040.GA15791@bombadil.infradead.org>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <7b18521c-539b-2ba1-823e-e83be071c13f@gmail.com>
Date: Wed, 14 Mar 2018 10:43:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313220040.GA15791@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860882497845479?=
X-GMAIL-MSGID: =?utf-8?q?1594935947558139439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/13/18 3:00 PM, Matthew Wilcox wrote:
> On Tue, Mar 13, 2018 at 11:45:50PM +0200, Igor Stoppa wrote:
>> When a page is used for virtual memory, it is often necessary to obtain
>> a handler to the corresponding vm_struct, which refers to the virtually
>> continuous area generated when invoking vmalloc.
>>
>> The struct page has a "mapping" field, which can be re-used, to store a
>> pointer to the parent area.
>>
>> This will avoid more expensive searches, later on.
>>
>> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Igor, do you mind sticking these tags on the files that have spent some 
time reviewing a revision of your patchset (like the Reviewed-by: tags I 
provided last revision?)

Thanks,
Jay
