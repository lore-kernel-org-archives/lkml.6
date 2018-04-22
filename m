Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/N9KUk1dAL+A2aBfxTeNuaAglCvk84HBCL5j0PWNRvSdVL4cA0vtKOGd+DRjvpUQnQkSKF
ARC-Seal: i=1; a=rsa-sha256; t=1524405437; cv=none;
        d=google.com; s=arc-20160816;
        b=sObmTM/DTTsGBY85AXflA+6YOVkGRvyrzjtp1BLhJEprsQDF/TZuLy8NU+cgNW3reC
         AhRf4NIN9UdG//tA4sUOL+spILDpnifwY603PbJIpyEbX5L5ackYGXRu9uJSiAJA+SAF
         0+AhD3Uy4eVDuwAqKPRsiU1f9R2IXBkZrv1ecchL8GmcpFIH/gDMvOkGtwNqVW0jrDQm
         k5vimLhjrw8lHJeddrm/IUzIpeMuGfYWjUMc1eXqyO+HQ5JFGVzz/XrA6cvrykH91jnE
         8vc5HYRlQ3cnwTX+KESHPFC0guITx50he7MNgZ3rQ7dfWwaE9RvcE/axFn7Nea016uct
         9KAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q1X85Zj1GOOwDcJSQATQeh7u9hukFjwfPw6ICdTUCD0=;
        b=LmtcLQAyrSBHQ+1SjX8FQ/KED5Oyk7ANn5ycrOrozWc+0HpG2Mo0je4Xs8jVZz/lyi
         TbL7TKk91wnTpglBSq7ewMcKAjjPaD3BB0XOTBIuuiuWb8tZ2MJm1lUG5JEUPTRAVcw3
         sSjs3eguwAepy4LAVSA4HWsSWR1uX3Hn/Wr4Olgu9JvjNIoaqf+x8S0M8u8RNaQiq8uP
         cH5JbZsBQLuDB2/DrwFC1IZC5Ra7KlpaPCOhTRQfY7oZJBzs2pdyn51dhONxpH/nVR74
         5K4lPSz5Bj7E4dUMdLdm6KhYhs/P5g4K39Q2z4nTfKVqL5A7uGUtTQMbM1rpBfOwGOgv
         6kbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Young <dyoung@redhat.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Simon Horman <horms@verge.net.au>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 066/196] powerpc/kexec_file: Fix error code when trying to load kdump kernel
Date: Sun, 22 Apr 2018 15:51:26 +0200
Message-Id: <20180422135107.671473484@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454956801762645?=
X-GMAIL-MSGID: =?utf-8?q?1598454956801762645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

commit bf8a1abc3ddbd6e9a8312ea7d96e5dd89c140f18 upstream.

kexec_file_load() on powerpc doesn't support kdump kernels yet, so it
returns -ENOTSUPP in that case.

I've recently learned that this errno is internal to the kernel and
isn't supposed to be exposed to userspace. Therefore, change to
-EOPNOTSUPP which is defined in an uapi header.

This does indeed make kexec-tools happier. Before the patch, on
ppc64le:

  # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
  kexec_file_load failed: Unknown error 524

After the patch:

  # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
  kexec_file_load failed: Operation not supported

Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
Cc: stable@vger.kernel.org # v4.10+
Reported-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Reviewed-by: Simon Horman <horms@verge.net.au>
Reviewed-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/machine_kexec_file_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -43,7 +43,7 @@ int arch_kexec_kernel_image_probe(struct
 
 	/* We don't support crash kernels yet. */
 	if (image->type == KEXEC_TYPE_CRASH)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
 		fops = kexec_file_loaders[i];
