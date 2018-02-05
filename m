Return-Path: <pbonzini@redhat.com>
X-Google-Smtp-Source: AH8x22681K8HnM49+tOG7JWyyMyUZIJ1pNKWB4Uhk+CMCPz7bNSIOdWJmhQ3xA+xVLMT92GxMHii
ARC-Seal: i=1; a=rsa-sha256; t=1517858564; cv=none;
        d=google.com; s=arc-20160816;
        b=qAhq76h1JoDbqTyhWiStJh9lE9LiMRGcMHZMRZ09CmrUay8GQwiqbsbSdLfr94UHGo
         r6OUVsTnPOoGPq53ubLOS9jxKgV44o8dlB3XeQlgDcRKMKdwiIo1fIVqDXij5VZ2Uybp
         dUi+mj8xFaBaNpnBHnNuFJurxTpecseyQP37mWmP8WvIm2qcNxO/ik6fVOqrXQ5GApHw
         3EtHqpxsefftfBS6RR4/heOazY/szETXt/SFT8zmPmNXUkJ1Yy0yiNnA3b66HUKBtCV6
         QuvlPfu4cfZzTWc6qhOyqt7mqFDOOYEwxzgyvTSQqMFqUVURnYUmUGiu9ZggTHe4oiTj
         HW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=slUcPxs9SGGuvprJzyoFnEfz8ewZEqGOl9ZgOacpxlw=;
        b=BUfGBZGPpEO+22/6Rq/1y/nhPyO1x7rgPp8jDxvpebxi11qgbtTbN1OW+bi9S54qM/
         nF+AF+Uhar8MuPJZReXRQB8vT+MVZ8h4xxLtLoSYvKigxotJQZ3YaGXEPgMp4QluZvm7
         t4FwLDhtry9GztETuboXQ8VQjPL4riXOCdlwg7zZ1A2Ig3qCVJO9QO1D62keEgwgFfcc
         nuFNQnERVkRXcL/txjBi1aEw4v0qX672rrmeR0K0aH9OdpNLRX5Jrj6G+a3yMzCKJBRY
         9ZoSo0KEH5bhkUU4e3ERQdWyF4oAxD34s9jKncP6A5daif/vxXPpyw/oVOJ8MLBcvZDr
         VQ1g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [PATCH v6 2/5] KVM: x86: Add IBPB support
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
 KarimAllah Ahmed <karahmed@amazon.de>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, Ashok Raj
 <ashok.raj@intel.com>, Asit Mallick <asit.k.mallick@intel.com>,
 Dave Hansen <dave.hansen@intel.com>,
 Arjan Van De Ven <arjan.van.de.ven@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dan Williams
 <dan.j.williams@intel.com>, Jun Nakajima <jun.nakajima@intel.com>,
 Andy Lutomirski <luto@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
 <1517522386-18410-3-git-send-email-karahmed@amazon.de>
 <20180202174932.GR28192@char.us.oracle.com>
 <1517594544.31953.62.camel@infradead.org>
 <20180202195601.GD28192@char.us.oracle.com>
 <1517602575.31953.74.camel@infradead.org>
 <20180202202857.GI28192@char.us.oracle.com>
 <20180202205258.2819b14f@alans-desktop>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2030fb28-ca91-744d-52b3-5469b18e6f27@redhat.com>
Date: Mon, 5 Feb 2018 20:22:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180202205258.2819b14f@alans-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582659331850?=
X-GMAIL-MSGID: =?utf-8?q?1591590062356446413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/02/2018 21:52, Alan Cox wrote:
>>> No. The AMD feature bits give us more fine-grained support for exposing
>>> IBPB or IBRS alone, so we expose those bits on Intel too.  
>> But but.. that runs smack against the idea of exposing a platform that
>> is as close to emulating the real hardware as possible.
> Agreed, and it's asking for problems in the future if for example Intel
> or another non AMD vendor did ever use that leaf for something different.

Leaves starting at 0 are reserved to Intel; leaves starting at
0x80000000 are reserved to AMD.

0x40000000 to 0x400000FF (some will say 0x4FFFFFFF) are reserved to
hypervisors.

> Now whether there ought to be an MSR range every vendor agrees is never
> implemented so software can use it is an interesting discussion.

For MSRs there is no explicit indication, but traditionally Intel is
using numbers based at 0 and AMD is using numbers based at 0xC0000000.

Furthermore, the manuals for virtualization extensions tell you that
Intel isn't planning to go beyond 0x1FFF, and AMD is planning to use
only 0xC0000000-0xC0001FFF and 0xC0010000-0xC0011FFF.

Thanks,

Paolo
