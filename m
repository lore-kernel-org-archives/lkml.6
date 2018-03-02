Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvB1IpqYxMbT/TUiNmiBGemeLnFzthXeCWDnj0dXF0G7az5aQRVbVibpieeloLeNczqo3WS
ARC-Seal: i=1; a=rsa-sha256; t=1519981399; cv=none;
        d=google.com; s=arc-20160816;
        b=a80Swjj80jnRN8P1EEBZN4pQC4L1yRGKUnq2xCW8GNaHQR76pib5liWwtkEbXhykEX
         tnH6f0WNML/Z/vY0SA3ZHlrhJaVa38h3pShmkI+S7sPwIZDJSSUjt8dlAaW1ZKzyWLjW
         PHRMC7E7omtB0KkB/d3Igkzb+UNXww8z69JLR/hiz4qfuB3zswQHvgCv93B2qPmhJ5RZ
         EfgEvq72/Mq5MN8KkoTLgr4snfQEjg+n+/3IC/xZHPkDMzhFTZLR+tOviEHJLk0GTqV+
         wbWiowJYm4C/7NEnKJwmqu/V4yoBzQz1WAKUqOzdScEQokPhkJ235aHo9tJioOvUqaMB
         rkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4aYawlAWu5fqLsdjXYUgjxDBYW3uM+rUaljIH1uUddo=;
        b=U4mn6PzwbI8BE3ECLyTsNDOtzDmgFMC35JPrUXdOGPj6eZTCZ237eCHFgH3JVXuB7h
         uEaOegm0/Ddpq+RfH/iRy5D2J2RJzzecP6V1bTPRI/5kn/1WdYsM8We5VimK5H0hgttP
         KGxrdk3vgUMOHWAcy2oSBfav4gHhrLOSAkj4lITQVB1hyfWGzEex2r00neNaYBziRe4y
         mlYE4Q6fYwMv/JOdZRviAuz5tioQRaSs01gRqTpmkTEgKSATJpVeBKukhqfRPlnrw/pM
         mGBKdzhedyi3IOUTWsa9lwUh7+pizHYuSY+981FU17ha6bo6LTBtjK2VfxbEu0ZkR7if
         X4mA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Young <dyoung@redhat.com>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Bryan ODonoghue <pure.logic@nexus-software.ie>,
	Ge Song <ge.song@hxt-semitech.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-efi@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 079/115] x86/efi: Fix kernel param add_efi_memmap regression
Date: Fri,  2 Mar 2018 09:51:22 +0100
Message-Id: <20180302084507.050323187@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593816015729604737?=
X-GMAIL-MSGID: =?utf-8?q?1593816015729604737?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Young <dyoung@redhat.com>


[ Upstream commit 835bcec5fdf3f9e880111b482177e7e70e3596da ]

'add_efi_memmap' is an early param, but do_add_efi_memmap() has no
chance to run because the code path is before parse_early_param().
I believe it worked when the param was introduced but probably later
some other changes caused the wrong order and nobody noticed it.

Move efi_memblock_x86_reserve_range() after parse_early_param()
to fix it.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Ge Song <ge.song@hxt-semitech.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180102172110.17018-2-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/setup.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -928,9 +928,6 @@ void __init setup_arch(char **cmdline_p)
 		set_bit(EFI_BOOT, &efi.flags);
 		set_bit(EFI_64BIT, &efi.flags);
 	}
-
-	if (efi_enabled(EFI_BOOT))
-		efi_memblock_x86_reserve_range();
 #endif
 
 	x86_init.oem.arch_setup();
@@ -984,6 +981,8 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	if (efi_enabled(EFI_BOOT))
+		efi_memblock_x86_reserve_range();
 #ifdef CONFIG_MEMORY_HOTPLUG
 	/*
 	 * Memory used by the kernel cannot be hot-removed because Linux
