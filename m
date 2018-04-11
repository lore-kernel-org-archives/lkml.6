Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49YqNECt2wxlseJFtngSrQLwI+/+ur5IhyNZEyWK8YWcQsU3GHoYv8PMp5NyRGXcG67ve6I
ARC-Seal: i=1; a=rsa-sha256; t=1523473158; cv=none;
        d=google.com; s=arc-20160816;
        b=Bb2byr/heYW8yfIvPoPJr+evV+26obb7ZwuBE8CBLO+cjPEZODe3vBNfzhmK28j238
         P7Lngw0GD1+WcyzVrg2eomtL7FjED6G7vtwAXpiUH0vyg8FTE3pdAWEd5ocmXbHLwMAP
         nEVzeurE8IBmmLVDJNrzXSXl9MxuAP/88UUcqKmudzHwX+kLGg8AfV/jMjVZvGzqLWzb
         uVczgRczB5GdxdyMkqNNkDpczQtQ0WQsGKWwvp5GwJ99sUhfeVPU4xU0nuLCJ0CK86I4
         fveJDtg1NWzAXdUn728psqBz4xC/v6ZMx04jgzPDDyX4LtRDhHJSyWIXu9zJtplcqBn1
         bzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UPIyYRXbW8ZV809j+cJP6PWKFBk0RwHoY1sW9/8RhU4=;
        b=om3KohDW2mSPAcFXkF6MhDH5V76w6AOtrosqwMrSSNqzkDjs4SEMy+UB09z9L8KO5H
         /B43fw+l21h1SBEklHT8n4pVbsWAviByeKnums0OhipK6c88LM2VNlSLrsXKAU9JydpE
         Ny7Renk8Gfvh/TnrTIrkm/fAvrV+Ic4lTDV+VzPj3Cp22LoTY+iYBZYB8HIed0l2m1v+
         o9fmr8JTsu3JEa52Oc+7k8sW/CzMmACvCQk2txK3mhL1wcSLIw53/CXk0GcsaTVATQD1
         0kC2I0aLuVVaHQS3//jAT3zWycVJooeUe1E730rffPu1vm41QZLjhqt2A7hbS53tXhUF
         3O2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lee Chun-Yi <jlee@suse.com>,
	Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	Dave Young <dyoung@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ravi Shankar <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-efi@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 149/310] x86/efi: Disable runtime services on kexec kernel if booted with efi=old_map
Date: Wed, 11 Apr 2018 20:34:48 +0200
Message-Id: <20180411183628.840963751@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477390399055336?=
X-GMAIL-MSGID: =?utf-8?q?1597477390399055336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>


[ Upstream commit 4e52797d2efefac3271abdc54439a3435abd77b9 ]

Booting kexec kernel with "efi=old_map" in kernel command line hits
kernel panic as shown below.

 BUG: unable to handle kernel paging request at ffff88007fe78070
 IP: virt_efi_set_variable.part.7+0x63/0x1b0
 PGD 7ea28067
 PUD 7ea2b067
 PMD 7ea2d067
 PTE 0
 [...]
 Call Trace:
  virt_efi_set_variable()
  efi_delete_dummy_variable()
  efi_enter_virtual_mode()
  start_kernel()
  x86_64_start_reservations()
  x86_64_start_kernel()
  start_cpu()

[ efi=old_map was never intended to work with kexec. The problem with
  using efi=old_map is that the virtual addresses are assigned from the
  memory region used by other kernel mappings; vmalloc() space.
  Potentially there could be collisions when booting kexec if something
  else is mapped at the virtual address we allocated for runtime service
  regions in the initial boot - Matt Fleming ]

Since kexec was never intended to work with efi=old_map, disable
runtime services in kexec if booted with efi=old_map, so that we don't
panic.

Tested-by: Lee Chun-Yi <jlee@suse.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20170526113652.21339-4-matt@codeblueprint.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/platform/efi/efi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -832,9 +832,11 @@ static void __init kexec_enter_virtual_m
 
 	/*
 	 * We don't do virtual mode, since we don't do runtime services, on
-	 * non-native EFI
+	 * non-native EFI. With efi=old_map, we don't do runtime services in
+	 * kexec kernel because in the initial boot something else might
+	 * have been mapped at these virtual addresses.
 	 */
-	if (!efi_is_native()) {
+	if (!efi_is_native() || efi_enabled(EFI_OLD_MEMMAP)) {
 		efi_memmap_unmap();
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
