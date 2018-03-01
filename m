Return-Path: <pbonzini@redhat.com>
X-Google-Smtp-Source: AG47ELu15PPnW2zkINiF1zUOW4pFbSmA893BTcwR7GobtVptiundPAByTWAB81Kk5bCMKwlAnBad
ARC-Seal: i=1; a=rsa-sha256; t=1519893990; cv=none;
        d=google.com; s=arc-20160816;
        b=PQUrwWjkm17T2B7MreoxQGx17V4oo5/4T1oriPCV8ViAkt0CCFqfzbjZM+AvAf6Do8
         XItBz4CZUVhQQvgPhCdaNr5NI/gF8fPieIcDrM9El/Z168dRvqZeJ0QZGa3x+kkkvohY
         HwoYdehLp5sMYDCzZVak5Yzmtpe70hNAZQ8/RGJF3Mesl5Hx7cmINV5v0bKU3FFf+tkd
         r0i935cL2qyDgNfuKpFjm0GxbLqDf5frdr9PfYD2YZC9e8tGqgFUXumD6I/mROZZwvkq
         xhvTSeSf6SHyE9dDdQVq/D75vp5QAAwtAAJZ76Ra+x3q7Kr87QLQkpRzNGSV98GgJjg1
         0GQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=vX417QZM4JhIzXHq0vlXt1730HUbpxktEQjE+y5QCds=;
        b=wekkCjDraf60O0RUPkqiVyo3Dy783UTQTtzmbuy/3V8uwZICQs7D6z0lQ5k7aG3Ppg
         d0f8yWOXZp5kue6vtF4C3YhAtmv6BdkEZDkq5bQtGGX5edZJhOjEpcdKtdOZc+muytqt
         K8od1F9AnICi/AT+8dIKzbTv36kMkbuS8/OmDMPAiG63bVK3SPbvQzdx0gERYlZyQY14
         1bEQmB7wxpZWfHf1tMrsuXuzya02Su+Cp+T54TZ1l28q6QMUg0zwKB7RT5BNcPutLvkm
         PFPZwd80MvrVufKWbDcPRGA677MFpBPqinH7e0pS1vf2r4/F6tpEfw1y6KQVWFTdZ9Fj
         f+Sw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [Xen-devel] [RFC PATCH v4 2/7] xen/pvh: Move PVH entry code out
 of Xen specific tree
To: Juergen Gross <jgross@suse.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Maran Wilson <maran.wilson@oracle.com>
Cc: boris.ostrovsky@oracle.com, roger.pau@citrix.com,
 andrew.cooper3@citrix.com, hch@infradead.org, JBeulich@suse.com,
 x86@kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thomas.lendacky@amd.com,
 dave.hansen@linux.intel.com, rkrcmar@redhat.com, gregkh@linuxfoundation.org,
 mchehab@kernel.org, hpa@zytor.com, linus.walleij@linaro.org,
 mingo@redhat.com, rdunlap@infradead.org, luto@kernel.org,
 jpoimboe@redhat.com, tglx@linutronix.de, bp@suse.de, davem@davemloft.net,
 kirill.shutemov@linux.intel.com
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-3-git-send-email-maran.wilson@oracle.com>
 <20180228210814.GK11576@char.us.oracle.com>
 <e9133f97-7ecf-2868-6883-3f0cda7bbb2f@redhat.com>
 <20f82d4c-9591-7770-aeca-0331a7940f5d@suse.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98eda294-8491-35a2-b278-aeedc079640f@redhat.com>
Date: Thu, 1 Mar 2018 09:46:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20f82d4c-9591-7770-aeca-0331a7940f5d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670476619272001?=
X-GMAIL-MSGID: =?utf-8?q?1593724361223398756?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/03/2018 07:11, Juergen Gross wrote:
>> Probably a better place for these would be
>> arch/x86/platform/pvh/{enlighten.c,head.S}.  (Just because there are no
>> .c or .S files in arch/x86).
> Right.
> 
>> Maybe Xen ought to be moved under
>> arch/x86/platform too.
> And hyperv and kvm, too?

Actually yes, though for kvm I'd move the files in arch/x86/kernel
(arch/x86/kvm is the hypervisor itself, not the "platform").

> No, I think arch/x86/xen/ is fine.

np, it was just a (somewhat crazy) suggestion. :)

Paolo
