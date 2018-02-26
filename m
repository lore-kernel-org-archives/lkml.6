Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224fOsHGRaNCm8MVZw3+kv6WEyj+hitBKplv2nFcZ8ceX8gKrhOUAlxNRw2ZDYgn1Fsn0F8C
ARC-Seal: i=1; a=rsa-sha256; t=1519676648; cv=none;
        d=google.com; s=arc-20160816;
        b=ZUMucE7tG4fzBt0vLh19km1CO/IsNnyaQxepC56o6Rql6nTG50qZGwZoHij7upyB9c
         /qo0SG6xJqMupm4x/eu7gVRnSS0hgr7ZOIdGAQU33d8nMRC62bW6VbBvC5IRj1f+/tsg
         AI3SB62pJME3EFqa/OLc84PXccKyv6Ixu4N4Wx98y4tN1bWoEReCr0nRQy/G2Nxk6Cfi
         MMsaMRpO2jDGUs3+sQ/AXMRWL7pU1GaGxFyIEoIm+VLqaZGpwKUY2q0pYFVEgtoHMkYX
         Ats4XsznyVS8XzOI0r4bD0Ax9cTpP0Dwil4PMAOfQAqgs/rdF3TcJwK0vlXDw5sRMFxx
         CAxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FD4RgaXX9snmOKDHODnW+TF9hPuhYTT2zutMw54daxI=;
        b=b+GdvvpOrzsRjFE5ddFx2JR5k6PN4Qjv34LD0L3AQRLHlpC+z9deMfYp+gq8s9W1A8
         xKktTGVQMEqICynIXHwX0uCrUEPosncADyo21V3JIOspwtnRm7DitYqN5LJ4MZGEf6ET
         9C5+pndniQngp9m5PAdOC4tToU8bUP6A/OIVZkMJd80gtY5ieDSrxJYWKDNX+DdMzGlK
         /7pPxXO/afPkkGNZAUmn2+HN104EK1VL4bJdy1pMhvJ/4mSqNqHU2jKL6Vat6lPMtopG
         iKEnhr4XDvk5GLKqMUnCwXWIV2A0fBZNMlG2ATo1G8em1wpMUb+N59fJFts5yRdKB2b4
         xopw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Babu Moger <babu.moger@amd.com>,
	Andi Kleen <ak@linux.intel.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Nicolas Pitre <nico@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will.deacon@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 25/54] Kbuild: always define endianess in kconfig.h
Date: Mon, 26 Feb 2018 21:22:02 +0100
Message-Id: <20180226202145.645881375@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496460929119249?=
X-GMAIL-MSGID: =?utf-8?q?1593496460929119249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 101110f6271ce956a049250c907bc960030577f8 upstream.

Build testing with LTO found a couple of files that get compiled
differently depending on whether asm/byteorder.h gets included early
enough or not.  In particular, include/asm-generic/qrwlock_types.h is
affected by this, but there are probably others as well.

The symptom is a series of LTO link time warnings, including these:

    net/netlabel/netlabel_unlabeled.h:223: error: type of 'netlbl_unlhsh_add' does not match original declaration [-Werror=lto-type-mismatch]
     int netlbl_unlhsh_add(struct net *net,
    net/netlabel/netlabel_unlabeled.c:377: note: 'netlbl_unlhsh_add' was previously declared here

    include/net/ipv6.h:360: error: type of 'ipv6_renew_options_kern' does not match original declaration [-Werror=lto-type-mismatch]
     ipv6_renew_options_kern(struct sock *sk,
    net/ipv6/exthdrs.c:1162: note: 'ipv6_renew_options_kern' was previously declared here

    net/core/dev.c:761: note: 'dev_get_by_name_rcu' was previously declared here
     struct net_device *dev_get_by_name_rcu(struct net *net, const char *name)
    net/core/dev.c:761: note: code may be misoptimized unless -fno-strict-aliasing is used

    drivers/gpu/drm/i915/i915_drv.h:3377: error: type of 'i915_gem_object_set_to_wc_domain' does not match original declaration [-Werror=lto-type-mismatch]
     i915_gem_object_set_to_wc_domain(struct drm_i915_gem_object *obj, bool write);
    drivers/gpu/drm/i915/i915_gem.c:3639: note: 'i915_gem_object_set_to_wc_domain' was previously declared here

    include/linux/debugfs.h:92:9: error: type of 'debugfs_attr_read' does not match original declaration [-Werror=lto-type-mismatch]
     ssize_t debugfs_attr_read(struct file *file, char __user *buf,
    fs/debugfs/file.c:318: note: 'debugfs_attr_read' was previously declared here

    include/linux/rwlock_api_smp.h:30: error: type of '_raw_read_unlock' does not match original declaration [-Werror=lto-type-mismatch]
     void __lockfunc _raw_read_unlock(rwlock_t *lock) __releases(lock);
    kernel/locking/spinlock.c:246:26: note: '_raw_read_unlock' was previously declared here

    include/linux/fs.h:3308:5: error: type of 'simple_attr_open' does not match original declaration [-Werror=lto-type-mismatch]
     int simple_attr_open(struct inode *inode, struct file *file,
    fs/libfs.c:795: note: 'simple_attr_open' was previously declared here

All of the above are caused by include/asm-generic/qrwlock_types.h
failing to include asm/byteorder.h after commit e0d02285f16e
("locking/qrwlock: Use 'struct qrwlock' instead of 'struct __qrwlock'")
in linux-4.15.

Similar bugs may or may not exist in older kernels as well, but there is
no easy way to test those with link-time optimizations, and kernels
before 4.14 are harder to fix because they don't have Babu's patch
series

We had similar issues with CONFIG_ symbols in the past and ended up
always including the configuration headers though linux/kconfig.h.  This
works around the issue through that same file, defining either
__BIG_ENDIAN or __LITTLE_ENDIAN depending on CONFIG_CPU_BIG_ENDIAN,
which is now always set on all architectures since commit 4c97a0c8fee3
("arch: define CPU_BIG_ENDIAN for all fixed big endian archs").

Link: http://lkml.kernel.org/r/20180202154104.1522809-2-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/kconfig.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -4,6 +4,12 @@
 
 #include <generated/autoconf.h>
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define __BIG_ENDIAN 4321
+#else
+#define __LITTLE_ENDIAN 1234
+#endif
+
 #define __ARG_PLACEHOLDER_1 0,
 #define __take_second_arg(__ignored, val, ...) val
 
