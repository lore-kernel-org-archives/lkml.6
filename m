Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032925AbeBONqX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:46:23 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:35591 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031806AbeBONqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:46:22 -0500
Subject: Re: fs_struct refcounting: spinlock vs atomic
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <7547a9ed-a2e7-e975-a3ba-f41abc16f4bc@metux.net>
 <CAFLxGvz2t8rnEQh4VBJ8v3b66GKA5DY3iMk33jnMP664+RMubw@mail.gmail.com>
From: Enrico Weigelt <lkml@metux.net>
Organization: metux IT consult
Message-ID: <9cc188a2-406e-bf7c-e769-e982735ba5b6@metux.net>
Date: Thu, 15 Feb 2018 14:46:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvz2t8rnEQh4VBJ8v3b66GKA5DY3iMk33jnMP664+RMubw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Rq3kIMdyg3tInrbtctdG+O5dJjhyB09e2PEZAZYfUHw9M1pa5RC
 GKBbofBW68Ywfe4IO9ARzB2kelw88vNElwVAg22FkxSig4+f5zzBqB0SchMLpP+FgFlDsIv
 yjDcgyfalLTXWhAAteRiz5bdaLdQixGXvy3fuNfywuFHxGsi6USS+sSHXm4tMc9+r7K2oxO
 g2CIttAQhNZ+qDZIPIsng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8scOW/p/L0U=:Y3NrRZQfJ8d6MSJVWPxAg3
 qUaYpjGu91eFdY6/2V7Kj8/DqVU2vgSVcJPd12B4beHjSC37y3+aVMfaxyo2VepxzGdnMNdJ+
 +1JAsnPw8s9fbvLTomx4JZ7j6tGyV1v2l/tX1IykSktwNvatg2YMASu7T2Bxy2EfeKxJoXcv4
 qzv4UHpYoGpRn2WZU5xqCwJ6vGaQJAbT5Nig7BO2r27/BsGyu6snoxKZX/IeSTmnEnEZgWB5V
 b+csnCX8CyohEQW2hiwM2UaRz7bRTSfSPao8sOTv23nnMuJcS7TUj8NvLAN++pTOQ9Mq1g/et
 6hWjMI3YXRvRVizXRcjLwFqP+5Wvx17Vpm2znRZPGBi+Msr9a1PeMXDn2enhc9z1+tzpglg0W
 o0f4buCndgMuBl0P93oAgvbCBji3Wh4NX3PkbUJ33XeW3C3NsuPy6UPtaqeDpGWJOAwda7uam
 QkWfDeFdUD+fX2ivM2RYc/7msOIiLDHQIesRyZGP8dlfr16pooSBqpZrU9clMTvDVC2Op0cYo
 2GwNVwalNihNgTBanfj3qvRKApTXfzWvlaHCC6zE5KVRkk7CP6GzfpstpOQLtINPY/mX5++EP
 pPQbINCMdh056PEvqG/RXBbdDEmdhkglAFTeVtFRLD+1Ly2NyG7pYCaYJAjtrZb5JFsYvadkv
 FYYr5ldFqMdfq2uoBZ01gix3MBdJRP9w7xei6DSMvFkmM89NHGtAY+4d5RNEs9A0YOdL5Svdg
 TwYgyvtHqr15ldjxP+dQ16rT1ntWKqqpySK5g9G0m9njNeZJo2DeBSdyNoY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.02.2018 10:14, Richard Weinberger wrote:
> On Wed, Feb 14, 2018 at 10:13 PM, Enrico Weigelt <lkml@metux.net> wrote:
>> Hi folks,
>>
>>
>> in fork.c, a spinlock is held for fs_struct refcounting, while other
>> places - eg. switch_task_namespaces uses atomic_dec_and_test() on
>> the nsproxy.
>>
>> What's the exact difference here ? Could the atomic counting also used
>> for fs_struct ?
> 
> Well, the spinlock protects more than just the counter. So atomic won't do it.

Okay. Is that needed in that case ?

See unshare() syscall:

if (new_fs) {
	fs = current->fs;
	spin_lock(&fs->lock);
	current->fs = new_fs;
	if (--fs->users)
		new_fs = NULL;
	else
		new_fs = fs;
	spin_unlock(&fs->lock);
}

Seems to me, that we're just refcounting here, and once it went dont to
zero, nobody else can access it anymore.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
