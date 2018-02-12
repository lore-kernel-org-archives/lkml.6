Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AH8x227X6ynW/OWbErj21qXiEEnUyvFivzLVUevpgsHaBCghe8WmQFr5qcAlXECeElSclSiMqpCm
ARC-Seal: i=1; a=rsa-sha256; t=1518438493; cv=none;
        d=google.com; s=arc-20160816;
        b=FP42n2yOeNJGPYqrH+ZY4vMdHcQ/s4iRqw13gUGoGfx4UPB5R5NLnMyUadDj4diNP9
         5mIu9DJTsAYGeh9BN3uycAwjYPQJTmnUG8jHI9CuOc3mCUG0kVy9lIryvO0IM1++crRr
         +lpayudcgHUnM2T7Kd+hY5ABVb6l2OtP9jNex4LPWISV4JWtD/oDXXPid2Lx7DxQPlIW
         PHyQ/4JBoQqYSq67OMvdtucQISyeOJze+m6ix3YxKcWyHJSPyz0JkkI3cjWfgL4CL8mE
         5rq/OpwCCB1KaQJSRWdmiQlV5G4Hda2ADM5bZBPTYO9Y+VmQOImteiJGKsVqJHuPKCjU
         7Ldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=FthO39enbU7sqyIq3vl7ODlMOy8577PG59WuzMP1zSE=;
        b=rN0V02/POWXRmMYW5zcEBU75jJ65BkXxOc9kwwdkJ2Z58C11Iar03NV3VpOOQI7wOU
         VnEap/nBkNQa2sBIBzVt/Lt2C8k3AC0hBL/3NouJd3RYqNrSRrvXvPvDMH7s45KE6IRy
         gJxcXbMwFzMn4OOa0e18eRXuHeXqTW5RMQ6Nc6EKBo9V89a9agZTrj8lpg+3fwsFyNZ2
         q35KiiiEmR9LPIxwYZ2v8tzB15U5F/kBeF4lj/qNy5psbK3pudvcGpBpe49hehWAY0Ue
         Jb/o6NVHlihzuCk6+DMVXBP+Q5+8nkGZ1pVCGHGiNfKPdP+RqhiqIAkgcmkUev3H+Itq
         FHsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, John Johansen <john.johansen@canonical.com>, "netdev\@vger.kernel.org" <netdev@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] headers: untangle kmemleak.h from mm.h
In-Reply-To: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
References: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
Date: Mon, 12 Feb 2018 23:28:09 +1100
Message-ID: <87zi4ev1d2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178829884506725?=
X-GMAIL-MSGID: =?utf-8?q?1592198162481420737?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Randy Dunlap <rdunlap@infradead.org> writes:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Currently <linux/slab.h> #includes <linux/kmemleak.h> for no obvious
> reason. It looks like it's only a convenience, so remove kmemleak.h
> from slab.h and add <linux/kmemleak.h> to any users of kmemleak_*
> that don't already #include it.
> Also remove <linux/kmemleak.h> from source files that do not use it.
>
> This is tested on i386 allmodconfig and x86_64 allmodconfig. It
> would be good to run it through the 0day bot for other $ARCHes.
> I have neither the horsepower nor the storage space for the other
> $ARCHes.
>
> [slab.h is the second most used header file after module.h; kernel.h
> is right there with slab.h. There could be some minor error in the
> counting due to some #includes having comments after them and I
> didn't combine all of those.]
>
> This is Lingchi patch #1 (death by a thousand cuts, applied to kernel
> header files).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

I threw it at a random selection of configs and so far the only failures
I'm seeing are:

  lib/test_firmware.c:134:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]                                                                                                          
  lib/test_firmware.c:620:25: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
  lib/test_firmware.c:620:2: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
  security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]

Full results trickling in here, not all the failures there are caused by
this patch, ie. some configs are broken in mainline:

  http://kisskb.ellerman.id.au/kisskb/head/13396/

cheers
