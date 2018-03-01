Return-Path: <boris.ostrovsky@oracle.com>
X-Google-Smtp-Source: AG47ELt6laqdKdKbK+ZIhy15AgmeGnMF1Q/9MXQp8OEJirXW86SwCeCd3ZiDN9AGpnBMd8RfY/eX
ARC-Seal: i=1; a=rsa-sha256; t=1519920910; cv=none;
        d=google.com; s=arc-20160816;
        b=LrOy4kwFCwshEOXb0u+Hit1UIkjc4uan6cGhshCzslW2tHU1nb33uYCpXBDmUkSa/u
         eyg04esvGwVzGZ5cK4uvb1P+jOSP264lmoCaeXHuPpB7TssjVTcZwx5dcxXCKGKiI7mR
         cWfJ24fBKS/KmVPuET16kAnFcO9JGqWv/HN96QlbWrNgWJ9Giw/5ZadtiXuLoU7xvsDR
         QG9KIo71skTs9TRdnn6jYy5mLfwnuvoT71Fgv1Fj3vaXJivWnRxme88Dan9YfcLpL8yk
         22DfQNRypZeQv1Gkeg20JSHzt8xMpddbcvSk/8cEWbYpw1pFKuHNmj2UYm80TV6cztPl
         Jxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=X/v3X+l1TVHqL8nl1gU/WFdvhBzvP10dXbNdTKwc38Q=;
        b=Lq5KZzV4SdQPpUBaLfxU7T+kCgf/Yu+EQnlX0X6q21d9ocsvPoObKQJMa4XCaF4EEJ
         1b/8ZBybANZlldUEPXrC4bDNKh5Q2ymC1FMuJmlQs9xJAi38Qv7IbplkOtOuMoA+MlVQ
         150mmytD4kzO6ZfQTmJEUc+nysSyBp4uI8jBpyKPmTfJW5WCA9OqGWNBhX36KFtRneD1
         5aG9/xcmIFT2KaZdkqRSTrUHS1/hV5kduFypDpX6tk3BHaI31uUzuL1Xpfya5h79mBNa
         Q+//3ohWwPScmkjB1b6a3TVe0LdfdcF35j+sey7/9HnmGYxAJALtE/sHd9cnX5Q1Cuw1
         3rxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Dn2ck1zJ;
       spf=pass (google.com: domain of boris.ostrovsky@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=boris.ostrovsky@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=Dn2ck1zJ;
       spf=pass (google.com: domain of boris.ostrovsky@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=boris.ostrovsky@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [Xen-devel] [RFC PATCH v4 2/7] xen/pvh: Move PVH entry code out
 of Xen specific tree
To: Paolo Bonzini <pbonzini@redhat.com>, Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Maran Wilson <maran.wilson@oracle.com>
Cc: roger.pau@citrix.com, andrew.cooper3@citrix.com, hch@infradead.org,
        JBeulich@suse.com, x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, dave.hansen@linux.intel.com,
        rkrcmar@redhat.com, gregkh@linuxfoundation.org, mchehab@kernel.org,
        hpa@zytor.com, linus.walleij@linaro.org, mingo@redhat.com,
        rdunlap@infradead.org, luto@kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de, bp@suse.de, davem@davemloft.net,
        kirill.shutemov@linux.intel.com
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-3-git-send-email-maran.wilson@oracle.com>
 <20180228210814.GK11576@char.us.oracle.com>
 <e9133f97-7ecf-2868-6883-3f0cda7bbb2f@redhat.com>
 <20f82d4c-9591-7770-aeca-0331a7940f5d@suse.com>
 <98eda294-8491-35a2-b278-aeedc079640f@redhat.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <1b8962c1-8ab5-cddc-0c0b-a7419aab424b@oracle.com>
Date: Thu, 1 Mar 2018 11:15:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <98eda294-8491-35a2-b278-aeedc079640f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=912
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803010202
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670476619272001?=
X-GMAIL-MSGID: =?utf-8?q?1593752588284440660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/01/2018 03:46 AM, Paolo Bonzini wrote:
> On 01/03/2018 07:11, Juergen Gross wrote:
>>> Probably a better place for these would be
>>> arch/x86/platform/pvh/{enlighten.c,head.S}.  (Just because there are no
>>> .c or .S files in arch/x86).
>> Right.
>>
>>> Maybe Xen ought to be moved under
>>> arch/x86/platform too.
>> And hyperv and kvm, too?


I was actually thinking about having arch/x86/virt where xen, kvm,
hyperv etc should go. Not as part of this series, obviously.

-boris


> Actually yes, though for kvm I'd move the files in arch/x86/kernel
> (arch/x86/kvm is the hypervisor itself, not the "platform").
>
>> No, I think arch/x86/xen/ is fine.
> np, it was just a (somewhat crazy) suggestion. :)
>
> Paolo
