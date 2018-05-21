Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo0g1UZp25QpOBBlXpuk2D5/Sa9nMfdIBpIY0WXI3z4z24radBYoKfEn9QzEplMqm//Dzbq
ARC-Seal: i=1; a=rsa-sha256; t=1526937845; cv=none;
        d=google.com; s=arc-20160816;
        b=KhGL1K3c5FmaCMPi7pNhBY9VVh/eJ/RAJyr8hSdmdC7qHxvcXm5AvWKy25Euxrwzqz
         niqcAGI/vFdmElC4sOLyevM4qE8V56/XZqiHqD4kKtQbRF3lwKERgXIaMUxcRj5thFt9
         s4TY12ZR9LDg2ZZK5BAqc4VCkckw+tVvn8QGXM0Y2N8XTFeN23vFCQgVpc4R7T0P5RGu
         Q2xI7n4XiadScflQOiqrXTmffaq2KMiprrSyRrV1Q5ssYqlCA6iXFJt6xznwkLZIG6dl
         tq8HMSx/v4izNOoz0asMlXaYVJ5TSLe9nrwL9jeVUsezC/GhLQU16tKRQSBXmZ2aXOYV
         UeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ZMCjYibgX63eJAZHxTQTfXeBKhap+MeoLgtV0WwDQcc=;
        b=AeNgGKd31o40Mli5ANvpUNK/+WhkPcVdaMPQmNuU3OWGZ+5fTkz7eg/HPLzB+WcBAp
         Ofrqz1gSwMqG8FP06GsqRPoG1JvvFtT/PijcNTp2uiewng7w9Gkvcw+k6WFWDQNOJT9Q
         iQm4eS0raXd8K2TD+4eaPvzhv9tgYS3iPQtJK8yUyQGd+DBzCHh2CZ2jM6NvH2p0U9vT
         663mBVwrYuZPT5rXnr2jxH+HdrOCSp+ZSGNIOx8IjIATbSEFnp6v8PqLLowtdbtTJ1GS
         UZIlTvG2ee7GgtFPfobfwgtFuvoGJAUeIC45v9S81R8Sqm/ddINbe6a1dLAf7//ACGTk
         9yXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Rsyk6kH3;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Rsyk6kH3;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-efi@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 047/110] efi: Avoid potential crashes, fix the struct efi_pci_io_protocol_32 definition for mixed mode
Date: Mon, 21 May 2018 23:11:44 +0200
Message-Id: <20180521210508.645245136@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109790218666482?=
X-GMAIL-MSGID: =?utf-8?q?1601110377778220921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 0b3225ab9407f557a8e20f23f37aa7236c10a9b1 upstream.

Mixed mode allows a kernel built for x86_64 to interact with 32-bit
EFI firmware, but requires us to define all struct definitions carefully
when it comes to pointer sizes.

'struct efi_pci_io_protocol_32' currently uses a 'void *' for the
'romimage' field, which will be interpreted as a 64-bit field
on such kernels, potentially resulting in bogus memory references
and subsequent crashes.

Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: <stable@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504060003.19618-13-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/boot/compressed/eboot.c |    6 ++++--
 include/linux/efi.h              |    8 ++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -163,7 +163,8 @@ __setup_efi_pci32(efi_pci_io_protocol_32
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
@@ -269,7 +270,8 @@ __setup_efi_pci64(efi_pci_io_protocol_64
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -395,8 +395,8 @@ typedef struct {
 	u32 attributes;
 	u32 get_bar_attributes;
 	u32 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u32 romimage;
 } efi_pci_io_protocol_32;
 
 typedef struct {
@@ -415,8 +415,8 @@ typedef struct {
 	u64 attributes;
 	u64 get_bar_attributes;
 	u64 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u64 romimage;
 } efi_pci_io_protocol_64;
 
 typedef struct {
