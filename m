Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x2279v0xar+WHwX6HKyylriWL1WglUNcfG1EyKxHxxowMkf0aOUBn1gsOaJ1xeF46AAeq3+7p
ARC-Seal: i=1; a=rsa-sha256; t=1518569327; cv=none;
        d=google.com; s=arc-20160816;
        b=dDVNvkfNVBxwAjMaDd3tnkgmphFaWHBpVF1BqxJieNDV/gM56UaRxtyuY0R+NLBnMl
         6FGpQjij1rLV7+9FDq3mFa5lAy3ix59pGGDflsIeXu83ibo6w5lYL5yR9q0EmaChZ1s9
         tlnGvMm+cqWux7JIxkK82ytYqERYOf6nxWsAVvVU7qLWesKy5eHzdby96EBP4z3kCQ0V
         yjRHW6jQdFWqk3DBq8U4t05+pj9pDE4u87CPLaz/T0H2pW2fVi/DJfgEfBYoOvDsH6oJ
         6+/URLFhnZY3+ydaBNDsEpZaooRjDF3VanJT+zH5OJyaQwYZIn+OUv8Ojj8VV180feqO
         fsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=Fdmbc5D4C8FZduSlU+cWuHrXJgyWOTNzGOZCHRCHFPE=;
        b=mqXmTJaBbc9TcPNyWyth0XfODxX81OmXN7WVdwvqUb0boI/2m3/JBlpBEuwfqePS4l
         G1ZHlLOcN+sDtectLQ337FyqpTck7/Es2rWigFdwABHnoahG1xAEL05yHCo0N372UWsE
         4NYvmrHnepxhPr+qeII+ZHdMXozxHd+/WRJDXRz2jqF3OHWZxH2XbdefoQsBuA6qGOS+
         LsbHMrf6A/Wlm1HNXIYgbM+akOgN03N78gtEdJP/OT77wlcDCf+/5MOg7vvxCKxHL86h
         G2EZbmx8H8z6JYdX2hlY4gaOM03gTqEsLpj2bGO+tEt3rb63fwQE/IYdLrRwH0/bOuln
         Z2Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=IUCkEx8f;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=IUCkEx8f;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH] headers: untangle kmemleak.h from mm.h
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>,
 sparclinux@vger.kernel.org, X86 ML <x86@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 John Johansen <john.johansen@canonical.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <a4629db7-194d-3c7c-c8fd-24f61b220a70@infradead.org>
 <20180212072727.saupl35jvwex6hbe@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0e4fbe75-7757-6129-b937-1e849ad8946a@infradead.org>
Date: Tue, 13 Feb 2018 16:48:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212072727.saupl35jvwex6hbe@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------F0B99163494C332BC7F40931"
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178829884506725?=
X-GMAIL-MSGID: =?utf-8?q?1592335350877961407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------F0B99163494C332BC7F40931
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 02/11/2018 11:27 PM, Ingo Molnar wrote:
> 
> * Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Currently <linux/slab.h> #includes <linux/kmemleak.h> for no obvious
>> reason. It looks like it's only a convenience, so remove kmemleak.h
>> from slab.h and add <linux/kmemleak.h> to any users of kmemleak_*
>> that don't already #include it.
>> Also remove <linux/kmemleak.h> from source files that do not use it.
>>
>> This is tested on i386 allmodconfig and x86_64 allmodconfig. It
>> would be good to run it through the 0day bot for other $ARCHes.
>> I have neither the horsepower nor the storage space for the other
>> $ARCHes.
>>
>> [slab.h is the second most used header file after module.h; kernel.h
>> is right there with slab.h. There could be some minor error in the
>> counting due to some #includes having comments after them and I
>> didn't combine all of those.]
>>
>> This is Lingchi patch #1 (death by a thousand cuts, applied to kernel
>> header files).
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Nice find:
> 
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> 
> I agree that it needs to go through 0-day to find any hidden dependencies we might 
> have grown due to this.

Andrew,

This patch has mostly survived both 0day and ozlabs multi-arch testing with
2 build errors being reported by both of them.  I have posted patches for
those separately. (and are attached here)

other-patch-1:
lkml.kernel.org/r/5664ced1-a0cd-7e4e-71b6-9c3a97d68927@infradead.org
"lib/test_firmware: add header file to prevent build errors"

other-patch-2:
lkml.kernel.org/r/b3b7eebb-0e9f-f175-94a8-379c5ddcaa86@infradead.org
"integrity/security: fix digsig.c build error"

Will you see that these are merged or do you want me to repost them?

thanks,
-- 
~Randy

--------------F0B99163494C332BC7F40931
Content-Type: text/x-patch;
 name="integrity_security_digsig_add_header.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="integrity_security_digsig_add_header.patch"

From: Randy Dunlap <rdunlap@infradead.org>

security/integrity/digsig.c has build errors on some $ARCH due to a
missing header file, so add it.

  security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org
Link: http://kisskb.ellerman.id.au/kisskb/head/13396/
---
 security/integrity/digsig.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-416-rc1.orig/security/integrity/digsig.c
+++ lnx-416-rc1/security/integrity/digsig.c
@@ -18,6 +18,7 @@
 #include <linux/cred.h>
 #include <linux/key-type.h>
 #include <linux/digsig.h>
+#include <linux/vmalloc.h>
 #include <crypto/public_key.h>
 #include <keys/system_keyring.h>
 




--------------F0B99163494C332BC7F40931
Content-Type: text/x-patch;
 name="lib_test_firmware_add_header_file.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lib_test_firmware_add_header_file.patch"

From: Randy Dunlap <rdunlap@infradead.org>

lib/test_firmware.c has build errors on some $ARCH due to a
missing header file, so add it.

  lib/test_firmware.c:134:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
  lib/test_firmware.c:620:25: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: http://kisskb.ellerman.id.au/kisskb/head/13396/
---
 lib/test_firmware.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-416-rc1.orig/lib/test_firmware.c
+++ lnx-416-rc1/lib/test_firmware.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/vfree.h>
 
 #define TEST_FIRMWARE_NAME	"test-firmware.bin"
 #define TEST_FIRMWARE_NUM_REQS	4




--------------F0B99163494C332BC7F40931--
