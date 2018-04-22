Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48IPj+njz+tmC4V1c9gtc9B+Vou4SkXfoMhX9Om2Vpvx0uFPzB27EEPWRqJ9ZqoB/3ZwtlN
ARC-Seal: i=1; a=rsa-sha256; t=1524405529; cv=none;
        d=google.com; s=arc-20160816;
        b=SYG6a1nbE4Kbgl9nzSVel/QlB29T/YLtHJuLEgrxl4j+Z1VwV0hT/rmor2wcPq43V6
         8F/mqW+U5tGEXbijTMRkI0UmOa/q88tmvenkuyttXhNiXxqUx+apL7E0OMX29rw0z213
         c5oxYnfyeWxLm43/e9hZKU/HJjVhjgAucIbNR+wUDB1N6x0fafU8jgnU/L1SEMRtQPIl
         1fTJuUzF7nH4d6JeGRCXtdpr8P3k+3hah7unFtE9KdiL0ujbGfwwgXMyaeMi6Q2PjNXC
         giUVxw00k8+45hCGnUC7ejHXmsKndygiyd1lB5NCoV77K0xLg8S9CHdm91gcBVBAbYi1
         1sOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AOQWTYw8WA/8vLPc0pt7VCchKVMlO+B/DE8V941Jsv4=;
        b=pOjZza+RCD/vLqp7nVgd7CdzDNUBvYhCCTcV+1eqgd2GCgzV7TEDGxq3kzTfxb5XO1
         yxcR77bIG8gC7VXelnBONNR/gzwKBaDttdqyQoHOiWtVMA9ooruOL5dCflpFYyrGw4Bq
         SbxGSCrMQKcnA8sbnTpPeX/5dmi2PM2+cbbtgmtuwe/nuMqgZkRX2mNVk+4UlLab+9lT
         yKTqUlWS9DGCkcePL6RdMK56Ddpwz2AfLRtxa5YoFoYruYGrRDokdfxepw2BK2kOwg+s
         rcjzxqeuzYDBaV4zm64hDs1eEuz8MPjk/PYwPwLfzpw7zgezA30B7vVv9uwzv2p5U3sR
         kabA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 083/196] block: use 32-bit blk_status_t on Alpha
Date: Sun, 22 Apr 2018 15:51:43 +0200
Message-Id: <20180422135108.598605082@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455052659939248?=
X-GMAIL-MSGID: =?utf-8?q?1598455052659939248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 6e2fb22103b99c26ae30a46512abe75526d8e4c9 upstream.

Early alpha processors cannot write a single byte or word; they read 8
bytes, modify the value in registers and write back 8 bytes.

The type blk_status_t is defined as one byte, it is often written
asynchronously by I/O completion routines, this asynchronous modification
can corrupt content of nearby bytes if these nearby bytes can be written
simultaneously by another CPU.

- one example of such corruption is the structure dm_io where
  "blk_status_t status" is written by an asynchronous completion routine
  and "atomic_t io_count" is modified synchronously
- another example is the structure dm_buffer where "unsigned hold_count"
  is modified synchronously from process context and "blk_status_t
  write_error" is modified asynchronously from bio completion routine

This patch fixes the bug by changing the type blk_status_t to 32 bits if
we are on Alpha and if we are compiling for a processor that doesn't have
the byte-word-extension.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org	# 4.13+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/blk_types.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -20,8 +20,13 @@ typedef void (bio_end_io_t) (struct bio
 
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
+ * Alpha cannot write a byte atomically, so we need to use 32-bit value.
  */
+#if defined(CONFIG_ALPHA) && !defined(__alpha_bwx__)
+typedef u32 __bitwise blk_status_t;
+#else
 typedef u8 __bitwise blk_status_t;
+#endif
 #define	BLK_STS_OK 0
 #define BLK_STS_NOTSUPP		((__force blk_status_t)1)
 #define BLK_STS_TIMEOUT		((__force blk_status_t)2)
