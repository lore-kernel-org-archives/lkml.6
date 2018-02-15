Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Qi0lw3pHylr5pwUdAwf4i/tvclEw6UEJzqg/27QaiSuP1IpnF0sfq10FJxPMsQVOV7gZ9
ARC-Seal: i=1; a=rsa-sha256; t=1518708375; cv=none;
        d=google.com; s=arc-20160816;
        b=LVya86Su6Y+paDwdt01acYMhZhZ6oSl2EqSqwFG13W5yzcolt784Pz67mZeu/lUSC2
         kVFdaR2uis1tO60LqZtLmDCwBTApaRpUV9/kpGfqs4KnYuZQxLNxDj1b7LTPL1K95zMd
         vlfM7RnpCcEID+XPvfVXBex5H52eCJiXRz7SmyoG2X4TlW+C9UF72jkoRTt6A/QQytQk
         Cg5F+uq7wG6WqbP3XEh6nx3Pn81GK/2Laew+oJBSt/vWMfOekn3OkkNAXE2NHBegdiTU
         JzpNguKOWgJdHQ7uEIIA/bdKMQ8+4k3QcR9ZotoY9Hd8yHYuaKkdqzoJ1NrcltRcXT7D
         1KGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=U/nITSciy9xSUOr/7X9kxz+fs+MXF1l1BvKXWlDpbM4=;
        b=WqRelgAwt41byABcqS0jEF2jEeWYynT7IumYeNUzMVj4SgprB7Is+sjavhyXsqiFZ6
         ADMMZZnIBbN/vF+HOQQRUhzsy9RI40fMW8Ik4tR+s0cCW4DALvW77iM6TdSxDpIIjWXJ
         ObtKS6iowUgUIngybn1E/3fCfeDOKCIXHLsyDFXU8ON33yBgL1fd/1x4Uhah8yJpuhmg
         QP6dX/uCX6HJqZSeWxTKOs6ogBoVSmK8mXCiIiai28YLACRYmVqA0QIKKuEmHJHlKWPg
         xhUEphgHYyerCXMrOHPbPS7aJh4EKfXFRyeZq4zeiF88+s4EbK1LuHcIXxluR8VsgzeO
         xdDA==
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
Subject: [PATCH 4.9 06/88] kaiser: fix compile error without vsyscall
Date: Thu, 15 Feb 2018 16:16:33 +0100
Message-Id: <20180215151223.418699172@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480930869989506?=
X-GMAIL-MSGID: =?utf-8?q?1592481154094747960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
