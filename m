Return-Path: <pbonzini@redhat.com>
X-Google-Smtp-Source: AG47ELvfcZ9xvFUvbXMWu+rzp0FQ2JtXOJTGIvljCv1f02PgelhK0/JXztjXjJYM4/Z4eYw6Pw2H
ARC-Seal: i=1; a=rsa-sha256; t=1519853981; cv=none;
        d=google.com; s=arc-20160816;
        b=psrBmcysZafzG3Q7BPVpjLTv66o8r3CAdZIlCvrU/zbk4RrvRGDIwQWULgloYgUwrC
         BBf8SS9pvmLh00mfP3rK/+6Ru9ESeONh8dqNKjNVMfuASYSaLSVF+1xOI4G+sGTqJWSc
         UH6SvlSLGSLauF5RxmrdifErlsupES8mw1Qf8wD7yOxauQgRmzt3+XT6ajoehdOvu7y0
         jlvCbtEmoXtzjTVG5/NIplk7M0+jf6r3pmi41cXaPIkoaJeexFj6rwfwVllpMoK1i1gI
         YsvKot7oFRrLl8kXEVwrHxd3ah0be5ZUOjDfkyYXx6B2wGuQpdnIExL7kLHSxTDRpRma
         Jz/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=je3QANJz2m6Qj1/TNuSpUo1NxU6s7UfmRaKA7uxaIY0=;
        b=SqsVxY9Sm7adDt4cL4gIAbt0rjUxWBhaz2QykP4GbyO7EDVqHopA6QTe+QqWRCD69G
         s0l8gSUNzEMooSsAli43+J0NJlo9fhHd3T3B7z+OfQraUlfM5Az2icxDb+6ioWCYRiAA
         i6rMkIXefdRRdfUtdYmWTguHr7Gsewz0OgJvCq+3ZmM/OnHRBBSnd05Eecx/qvrwRCu2
         saFFHXygv3gK5PVgBJdO4rxoSIJGD2rGiwBFFPMaABiEBEs2OHE2lFPiZD5KqiHjQFl7
         /ycSoFuRgo8tWFhfKJ+rsspFiRa7Pd2aG5Z4EqP7/eBUL2Nj8/yz566komfYZYVbic1M
         BUYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of pbonzini@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=pbonzini@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: [RFC PATCH v4 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry
 point
To: Maran Wilson <maran.wilson@oracle.com>, jgross@suse.com,
 boris.ostrovsky@oracle.com, roger.pau@citrix.com, andrew.cooper3@citrix.com,
 hch@infradead.org, JBeulich@suse.com, x86@kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rkrcmar@redhat.com,
 jpoimboe@redhat.com, bp@suse.de, kirill.shutemov@linux.intel.com,
 thomas.lendacky@amd.com, luto@kernel.org, dave.hansen@linux.intel.com,
 davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org,
 linus.walleij@linaro.org, rdunlap@infradead.org
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <239b5f48-00ad-5ff3-aa4f-ba126596c808@redhat.com>
Date: Wed, 28 Feb 2018 22:39:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670431489579630?=
X-GMAIL-MSGID: =?utf-8?q?1593682407946497410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28/02/2018 19:27, Maran Wilson wrote:
> Sorry for the delay between this version and the last -- it was mostly
> due to holidays and everyone being focused on security bug mitigation
> issues. Here are the links to the previous email threads in case it is
> helpful:
> 
> V3: https://lkml.org/lkml/2017/12/12/1230
> V2: https://lkml.org/lkml/2017/12/7/1624
> V1: https://lkml.org/lkml/2017/11/28/1280
> 
> Changes from v3:
> 
>  * Implemented Juergen's suggestion for refactoring and moving the PVH
>    code so that CONFIG_XEN is no longer required for booting KVM guests
>    via the PVH entry point.
>    Functionally, nothing has changed from V3 really, but the patches
>    look completely different now because of all the code movement and
>    refactoring. Some of these patches can be combined, but I've left
>    them very small in some cases to make the refactoring and code
>    movement easier to review.
>    My approach for refactoring has been to create a PVH entry layer that
>    still has understanding and knowledge about Xen vs non-Xen guest types
>    so that it can make run time decisions to handle either case, as
>    opposed to going all the way and re-writing it to be a completely
>    hypervisor agnostic and architecturally pure layer that is separate
>    from guest type details. The latter seemed a bit overkill in this
>    situation. And I've handled the complexity of having to support
>    Qemu/KVM boot of kernels compiled with or without CONFIG_XEN via a
>    pair of xen specific __weak routines that can be overridden in kernels
>    that support Xen guests. Importantly, the __weak routines are for
>    xen specific code only (not generic "guest type" specific code) so
>    there is no clashing between xen version of the strong routine and,
>    say, a KVM version of the same routine. But I'm sure there are many
>    ways to skin this cat, so I'm open to alternate suggestions if there
>    is a compelling reason for not using __weak in this situation.

As you say there are many ways to achieve this and I think your choice
is fully reasonable (the other alternative that comes to mind is a "Xen
detect" function that returns a struct of function pointers).

Apart from the placement of the files, it looks great.  Thanks!

Paolo
