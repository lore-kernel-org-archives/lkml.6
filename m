Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/UMdwADVtS28pD1bJvdGIPaMdPVQEYEvbNt3h2HK3B9dOaNX9DR6Zz9OoBFtDs+tf7i183
ARC-Seal: i=1; a=rsa-sha256; t=1523021673; cv=none;
        d=google.com; s=arc-20160816;
        b=jp/N32WTGCsROwob+imKgtIyHhHbDQwJAMPKBvfg0fU40Op6MJdwcRVJiIL7Mg1EIr
         9Xfdq6c1hGIMhKLhm11vbyS9cZyhTWCwihDS62scTbQpRoMYq6Kz29z555A1u0DnGZ+5
         z1spV59xViSXWDAI+ucQxQgscgVf9z07uzGDlAaht5CI9CePuK1kXn/OE7qVvd/u0HFT
         CbdszQg7dn/z7XE0Wt5JuwvedFL1TUBV+ceAZxTbLwZnrAawzkBgagVqZ1ripSiR+U1z
         Fc+XPpy5Etml1yu3Y/FNRhoPB5Qm40XdCLJtpRqafr/ueNymD570jRBb9zvgx+f9WStb
         fYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qF/tECtzQPIjRNeMBr10q78jFyAS2n8RNiqXIFMKaWk=;
        b=ao3tbsoMLh8fUJpSU1UH+vMTCgH1FNJaz+Se9s1z73d7Ek+CoIkJvgZO5mz9aV8DSs
         qJ56sIBmU3pYFKy1Ql63PYwmbPFr0+tqleqA8bncIm/+jU2tW6KW9jmZ1YH3mbBOT/rh
         fvEeLh+2JLY+tjPQHRkxq+QkCgyz21CvIbXlKbecYpyONErKsQEGsFKaKghme7NSfCHy
         r78/VfRUyUMNPQYqW4rd+S+CLwqVH1zwznz08NAIMOehcmF560HZVuf6KlvWCBXilK4T
         +KIAOY5YPm8/H6MdqkHbidlKnohE70ljOXBt6BAxNf3/HXjHRNM+JSwU89lOtrDJIMR6
         RSrw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Yury Norov <ynorov@caviumnetworks.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Will Deacon <will.deacon@arm.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 032/102] arm64: avoid overflow in VA_START and PAGE_OFFSET
Date: Fri,  6 Apr 2018 15:23:13 +0200
Message-Id: <20180406084336.133024456@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003703417188797?=
X-GMAIL-MSGID: =?utf-8?q?1597003974708098928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <ndesaulniers@google.com>

commit 82cd588052815eb4146f9f7c5347ca5e32c56360 upstream.

The bitmask used to define these values produces overflow, as seen by
this compiler warning:

arch/arm64/kernel/head.S:47:8: warning:
      integer overflow in preprocessor expression
  #elif (PAGE_OFFSET & 0x1fffff) != 0
         ^~~~~~~~~~~
arch/arm64/include/asm/memory.h:52:46: note:
      expanded from macro 'PAGE_OFFSET'
  #define PAGE_OFFSET             (UL(0xffffffffffffffff) << (VA_BITS -
1))
                                      ~~~~~~~~~~~~~~~~~~  ^

It would be preferrable to use GENMASK_ULL() instead, but it's not set
up to be used from assembly (the UL() macro token pastes UL suffixes
when not included in assembly sources).

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
Suggested-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/memory.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -64,8 +64,10 @@
  * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area.
  */
 #define VA_BITS			(CONFIG_ARM64_VA_BITS)
-#define VA_START		(UL(0xffffffffffffffff) << VA_BITS)
-#define PAGE_OFFSET		(UL(0xffffffffffffffff) << (VA_BITS - 1))
+#define VA_START		(UL(0xffffffffffffffff) - \
+	(UL(1) << VA_BITS) + 1)
+#define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
+	(UL(1) << (VA_BITS - 1)) + 1)
 #define KIMAGE_VADDR		(MODULES_END)
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
 #define MODULES_VADDR		(VA_START + KASAN_SHADOW_SIZE)
