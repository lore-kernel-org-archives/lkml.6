Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225MvpHyh4VQ/AXxkSJvmgbgbgeAd/4Do5YXDBcJmrANCl8kSdgPieNX//xBZXV1cs/9K0W/
ARC-Seal: i=1; a=rsa-sha256; t=1518708163; cv=none;
        d=google.com; s=arc-20160816;
        b=ac63/7BoCqgCJiKF9andbVPudlmqQR3QRXeSQYNNjSeUfi3HTIMmwPc3AyX5laY9E3
         8MOhU/lzh2Si/fCxL+FoF46RNQl00Qv4m35juYxTzIaIxWRaAbWZGTxOQwAQvoOIYgn4
         vtSV2Ip+AD2Q5MizY6rLgRC8EbuYURJHXNbZxsPzJhgrDyx/sRZmQk9eKo0kiq4jzAwO
         +Z+C6Y5gkADUZ6Db1VXi0/wLA6u6IkgnRYERHCpnWI3K25tyOzCuuj0Wjl0LeGkp7YfU
         zGPSfkwLXidE9BIplVSx8BQtVByXBHwDjF7/kLjrR/xYYlR/0+eYDRdUZ3g8hLVuSTNB
         kCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QSLZGBm2JqsoeOBYSWlzPSxFBk+W6B6PA6JhQUh9Z6A=;
        b=U90bC6m5zSbPb/uH38qRPX/5Mb9sk9m9DPgqiWxjvWQxIvIoZxwAEs9NBXx6/wjaqu
         4mawrcI2SYIzThKlBYIapz5bBFBrCtIAykYNUDbXhUbJdmceewew00E1YhlsZnrZGvch
         tOLG/qWseZUW+jsHKRkGJmrYs2Zj1umR5Mn9N5TLVauzzeg7Q1taCptnWDK3ls0F9Ki8
         MM+jE8kkZz/OHPv1MtzEOc9S6uNSj1sHyRAa2kzx9QvJCTfK2MthS429IOAKa7vqFPN7
         0nqKw8fwG/dR6YgXoJbV0ZxlMe6Srr2uH4C6DPwEgIOwqcZH6v0b1VY9SvFJX7ET2poa
         9Iyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	Hugh Dickins <hughd@google.com>
Subject: [PATCH 4.4 045/108] kaiser: fix compile error without vsyscall
Date: Thu, 15 Feb 2018 16:16:42 +0100
Message-Id: <20180215151228.707491687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480930869989506?=
X-GMAIL-MSGID: =?utf-8?q?1592480930869989506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugh Dickins <hughd@google.com>

Tobias noticed a compile error on 4.4.115, and it's the same on 4.9.80:
arch/x86/mm/kaiser.c: In function ‘kaiser_init’:
arch/x86/mm/kaiser.c:348:8: error: ‘vsyscall_pgprot’ undeclared
                                   (first use in this function)

It seems like his combination of kernel options doesn't work for KAISER.
X86_VSYSCALL_EMULATION is not set on his system, while LEGACY_VSYSCALL
is set to NONE (LEGACY_VSYSCALL_NONE=y). He managed to get things
compiling again, by moving the 'extern unsigned long vsyscall_pgprot'
outside of the preprocessor statement. This works because the optimizer
removes that code (vsyscall_enabled() is always false) - and that's how
it was done in some older backports.

Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/vsyscall.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -13,7 +13,6 @@ extern void map_vsyscall(void);
  */
 extern bool emulate_vsyscall(struct pt_regs *regs, unsigned long address);
 extern bool vsyscall_enabled(void);
-extern unsigned long vsyscall_pgprot;
 #else
 static inline void map_vsyscall(void) {}
 static inline bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
@@ -22,5 +21,6 @@ static inline bool emulate_vsyscall(stru
 }
 static inline bool vsyscall_enabled(void) { return false; }
 #endif
+extern unsigned long vsyscall_pgprot;
 
 #endif /* _ASM_X86_VSYSCALL_H */
