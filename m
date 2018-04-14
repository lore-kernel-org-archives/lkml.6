Return-Path: <kernel-hardening-return-12996-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+fB/2tb0yoXFYhqVGOH/ezlwbDrQLC5u83bhAXtekNw0NaUa8TVE5AdFQ7b9GFbaQCK6pv
ARC-Seal: i=1; a=rsa-sha256; t=1523677406; cv=none;
        d=google.com; s=arc-20160816;
        b=n8f5oWCMQ/REcpqfcZc6zZs83c9x03jAmmfKWISE0tk1Ds4cgOniub11KX8yfQHGe2
         bLG1MaQ+C/b7vGq6PALNMBx3/uPz9Tw/DunUEt3rVBH8+w4oPetbz/M3jnoj1PUYax33
         Ekze3oi/rRPz9P7+aH8PLSr29EWgEB7XsbvRklr4XTYHaqly4L5bR+KCDeL94a6mRXgk
         7uq2oBSDLt/VmU82eEo/uTuzCJNIrJ+42YVliXNsgKZwqdIO3ILksPIRJU/vGO1fsDi8
         G5OcuPXzw2RMmwbTemlL/3LASFFZT+9GWBQP4/Jn8g90s0e1S1X8EmJt5yQdDC9EHC1u
         ZiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Q9uiRdY7PzR/bkvH2eQPNQiaotHpuXnSN0Rjl7ERD04=;
        b=iSp8QJPigaiwXbxnAgHGfSfB9KiJX6ApelIWlB7KX/25r5qvC65/EcwHsEAp9FLm28
         aGTYz+butI2fmeX6Hugi6xdmO4WaH5uZUbQehlWnBLjHkury7PuBsDdzv6CBQzz4+KMB
         ubPmmKtP3tWGrFlVCjuN2xXdxkhdWqpOtR6GE2HTbjNK1xWgSMMIYDEirPNO3KVFUrTh
         uXIx5dE8Yk6zPqWPLEKnfnILAagE/YGdOXJh/IStKru3PfKXyaAExR+GNuY2ocsiJ1cK
         mYBgDmX5g7Rzej3mmsq3USxjJ+qlPwBL1KT6Zm2EHOq8Xa/rRzZ8uFMM0/8Rapf+0DW3
         OEiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12996-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12996-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12996-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12996-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] x86/xen: Remove use of VLAs
To: David Brown <david.brown@linaro.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180413221146.28476-1-labbott@redhat.com>
 <20180414025553.GA32653@davidb.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <18e8c47d-55f7-795a-053a-f667650b43b7@redhat.com>
Date: Fri, 13 Apr 2018 20:43:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180414025553.GA32653@davidb.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597670729617678421?=
X-GMAIL-MSGID: =?utf-8?q?1597691560052958995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/13/2018 07:55 PM, David Brown wrote:
> On Fri, Apr 13, 2018 at 03:11:46PM -0700, Laura Abbott wrote:
> 
>> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
>> turn on -Wvla. The few VLAs in use have an upper bound based on a size
>> of 64K. This doesn't produce an excessively large stack so just switch
>> the upper bound.
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
> 
> This comment is more in regards to many of these patches, and not as
> much this one specifically.
> 
> How confident are we in the upper bounds we're setting, and how
> obvious is it in the resulting code so that something does later
> change to overflow these bounds.
> 
> The danger here is that we're converting something a little easier to
> detect (a stack overflow), with something harder to detect
> (overflowing an array on the stack).
> 

Several people have remarked on that and the solution has been to
put in some kind of WARN and/or error check to make it obvious something
needs to be adjusted.

> I guess the question is twofold: how did you determine that 64K was
> the largest 'size' value, and how should reviewers verify this as
> well.  Perhaps this should at least be in the commit text so someone
> tracking down something with this code can find it later.
> 

It's not in the patch context but there's a large comment below:

         /*
          * A GDT can be up to 64k in size, which corresponds to 8192
          * 8-byte entries, or 16 4k pages..
          */

         BUG_ON(size > 65536);


Given the frames was calculated based off the size, that seemed
sufficient.

> David

Thanks,
Laura
