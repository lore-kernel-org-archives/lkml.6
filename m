Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224zbyrFxM5mxG6t0U7en+Gq5OKjj4cGEK8j2IIFD6ObtWLsB5rxOBd8Kvait2VxVDXOj8dx
ARC-Seal: i=1; a=rsa-sha256; t=1517591788; cv=none;
        d=google.com; s=arc-20160816;
        b=fY5ywE1XtPjGnGvOxh0znyb7/bCcdoWfhbsZTKSo6hmYzq/c8zTw8j3pg92JU6dbTN
         tRoIMHiUFKEXva/yLlCRMqjYuwY4jJltKzMas8XJ9AkRGXs8TmD3KWJ0j3YbFqpOUs0T
         MQdGRO4YQ94qoHnljLS5n+YDEUCJMq1kQbBg1NPBs1lka8jyetXv5qAfV8XrlU61uoJI
         WbgYl8aJBiAX6Mwhn9dhBj7QrewXLIfZXCG0uc6HaNaAsnSiG5qMfrvqOQf4avcVUZA6
         ZP44W47KdSr60j6LR+5aLX+R8lnkdAG7bgG96+jwNiS91VzPl58OFENzu+7n+Ke6PL7m
         Rn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LMcwJhA+HyD/kZu65vKN/fReVgi5kAN3tmkGtScGjSM=;
        b=EZCmF+Y0B83dM6QwY1IOkmowipJ/H5SmJjejDzUAPFeRdnxezeQsbMWnb8ggaAT1DT
         kEHhzq9FJkxTij99HlERYAL83UVpKR5dauAoTT0UXIH0o6JCTGWkLM1BilxuH5NwPM2d
         Q2AT/BX3Ir9ISlFkTsJnb8FvBj0Co12ufnsdT+PABGZ5STReSjZPa6/15+FDqZhthz6O
         Mg9yHpQ7sgLydvakWmYbdYm19ZOzCUIazVzBsJlTbSALS8X/4JPFve27n1tdS+Jb/l/w
         0WvHXQCBO9n08NISAGnQiTYGtzAQ4NJ0gW1pK/ZIc4Hqaky6XBeNIusJ+8ZoFCZ1hGfR
         bF/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ganesh Mahendran <opensource.ganesh@gmail.com>,
	Martijn Coenen <maco@android.com>,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.15 43/55] android: binder: use VM_ALLOC to get vm area
Date: Fri,  2 Feb 2018 17:59:01 +0100
Message-Id: <20180202140830.313699045@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310157854405524?=
X-GMAIL-MSGID: =?utf-8?q?1591310326840910577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ganesh Mahendran <opensource.ganesh@gmail.com>

commit aac6830ec1cb681544212838911cdc57f2638216 upstream.

VM_IOREMAP is used to access hardware through a mechanism called
I/O mapped memory. Android binder is a IPC machanism which will
not access I/O memory.

And VM_IOREMAP has alignment requiement which may not needed in
binder.
    __get_vm_area_node()
    {
    ...
        if (flags & VM_IOREMAP)
            align = 1ul << clamp_t(int, fls_long(size),
               PAGE_SHIFT, IOREMAP_MAX_ORDER);
    ...
    }

This patch will save some kernel vm area, especially for 32bit os.

In 32bit OS, kernel vm area is only 240MB. We may got below
error when launching a app:

<3>[ 4482.440053] binder_alloc: binder_alloc_mmap_handler: 15728 8ce67000-8cf65000 get_vm_area failed -12
<3>[ 4483.218817] binder_alloc: binder_alloc_mmap_handler: 15745 8ce67000-8cf65000 get_vm_area failed -12

Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
Acked-by: Martijn Coenen <maco@android.com>
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder_alloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -666,7 +666,7 @@ int binder_alloc_mmap_handler(struct bin
 		goto err_already_mapped;
 	}
 
-	area = get_vm_area(vma->vm_end - vma->vm_start, VM_IOREMAP);
+	area = get_vm_area(vma->vm_end - vma->vm_start, VM_ALLOC);
 	if (area == NULL) {
 		ret = -ENOMEM;
 		failure_string = "get_vm_area";
