Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqqBNagEE83AwdPb2ldeG/mjiwxa60uGt/ZyDzr660xJqp6gAn59iTjYrdDGUkDP61PzHzt
ARC-Seal: i=1; a=rsa-sha256; t=1526937284; cv=none;
        d=google.com; s=arc-20160816;
        b=ceMa2rzPbqXq60/j4VnMYuBN/ShBB7TGOk6zdw+UGWTUkQQ/B7XesicYrI1h+N1z+O
         url3x5888B4Dp8fYH0EwK8Lv4kzCce1tuvoRSCDaEmr0yM+AZ8heM7WoTEOQF+ZjSSWx
         pkspDIZ4EWd5WJD3Qzk487qtllRLAXLaE+F1KylXsjSKxCjQaYMZ+tMDwXy+TKqkd20T
         Ht8P/oGFFdtCQKo362eZ0kEpWiGg0y+1e5iSMUp4H6torz0o16XhrNJAfEGMm9tlLEQg
         PpfEf+cuzuFD+sR+3x/+3ZLBrnqXrvr0l5nLgejuR+TjTzpXJirJivFhvMRCAwWJd119
         swGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=eqJrRuXDG7xuR0/wv/4vMgKmx6Fw5bcKRx+NuNIgwdk=;
        b=s7HlAybIXrGaFwOBz07nS4V+wHLfjZE8W4v2vNGhuhtRIAZd7ubzSOYp/v2Hy0n9fd
         otWVY04Ar7x3DP/G7nQbSeVrA6ev6QIXQlaFebOTcjBP4GxD8LYwsNoBgLgepxR4ukIQ
         lADAhRg/6jT4bd+2OFvmvSGGF498ojO4q4CmPM33s/DCT7OCU7z3+Xqb0YMrWr5w/eFt
         /B4ZCwgSbpRh8qSpwPqsZNCGMxJP7jngVTTT0evMXpUEIzTBBTExFI8nWv6WNadXZfIk
         3lmSpsbjBo0AHWxAfZG0vJrpGcG6NCSDN9cRgPQl1ppiJGgiHcfkWl8NUOMZ5aZuf274
         LHcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MDhU/m1X;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=MDhU/m1X;
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
Subject: [PATCH 4.9 26/87] efi: Avoid potential crashes, fix the struct efi_pci_io_protocol_32 definition for mixed mode
Date: Mon, 21 May 2018 23:11:02 +0200
Message-Id: <20180521210422.740871956@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109790218666482?=
X-GMAIL-MSGID: =?utf-8?q?1601109790218666482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -330,7 +330,8 @@ __setup_efi_pci32(efi_pci_io_protocol_32
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
@@ -436,7 +437,8 @@ __setup_efi_pci64(efi_pci_io_protocol_64
 	if (status != EFI_SUCCESS)
 		goto free_struct;
 
-	memcpy(rom->romdata, pci->romimage, pci->romsize);
+	memcpy(rom->romdata, (void *)(unsigned long)pci->romimage,
+	       pci->romsize);
 	return status;
 
 free_struct:
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -380,8 +380,8 @@ typedef struct {
 	u32 attributes;
 	u32 get_bar_attributes;
 	u32 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u32 romimage;
 } efi_pci_io_protocol_32;
 
 typedef struct {
@@ -400,8 +400,8 @@ typedef struct {
 	u64 attributes;
 	u64 get_bar_attributes;
 	u64 set_bar_attributes;
-	uint64_t romsize;
-	void *romimage;
+	u64 romsize;
+	u64 romimage;
 } efi_pci_io_protocol_64;
 
 typedef struct {
