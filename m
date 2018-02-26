Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2246fWdnR3THFuv9m5Lm4oFAOZxxU+GBi8PAD04QTMbYUOYVvDzLvcPvgw+ujUfQaUL1i5zp
ARC-Seal: i=1; a=rsa-sha256; t=1519676678; cv=none;
        d=google.com; s=arc-20160816;
        b=xHHKlKjSnvPCpjdaPL3TFThUJyj7NlP4cRKVMcV1Rc4+80EwnCZj3e9bHW/wYiP6ct
         CnglLJqxits5Suoj+9NzXHz51k/WM4gf35ITT3ganlxfORwFQH6cMmSnbaUWCmw8O452
         3XieEhJPYqczBkqPV1P2T4pkDZdjAE6SGs94CidPZFi2TIs8QyZ2rgLXFfomUSqgn4N7
         J9HFabpocK0aTHI2RYmoINiispyZK/wG8/jnNAdgN7Ql0jSdqbbp7mRRD64XILQ7PDjN
         jvq6kFSvgFu4A34T7Be/PC5k0rybiVuyjILNJVBKPXMx5jI0AcZX8uyypp982sS8Q5bo
         SMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ghOdayHawiZQzTx3dy8r1e45N6mAEQ10Ua9slkZ8jHQ=;
        b=y8iPuv7Aycir/mylup0wVKhGDWOGDx5iEbXqv4/3gnkgwGiBS7CEcQtMxeE8BSwzNO
         ucHWJbF9fnnW9G9WQOPxq/pb0v4HCDYElu+lVswCSvo/3RrssYuokrgy+S15Do+Tl0p4
         +M//COAaRoAYewKD7RQ/WYuej9JpjZgb5ze/uI/nxVSoKXbTNZNDCG2ex1kboy0794fx
         Q2YBgP/4aPlMYfaz/86E97xB2Wq0+OeOqwylTuJ2HFxzRUIaIgrGNMjITql/bDpEW44h
         ODEtV3/tZinrKjzxmtiFUcypwRE/TF1IFys/sz0ZeBl3QpSCxejfg2ZitCE3g+LBtUQu
         bnUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	kbuild test robot <lkp@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 04/54] MIPS: boot: Define __ASSEMBLY__ for its.S build
Date: Mon, 26 Feb 2018 21:21:41 +0100
Message-Id: <20180226202144.593307237@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496492959707345?=
X-GMAIL-MSGID: =?utf-8?q?1593496492959707345?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 0f9da844d87796ac31b04e81ee95e155e9043132 upstream.

The MIPS %.its.S compiler command did not define __ASSEMBLY__, which meant
when compiler_types.h was added to kconfig.h, unexpected things appeared
(e.g. struct declarations) which should not have been present. As done in
the general %.S compiler command, __ASSEMBLY__ is now included here too.

The failure was:

    Error: arch/mips/boot/vmlinux.gz.its:201.1-2 syntax error
    FATAL ERROR: Unable to parse input tree
    /usr/bin/mkimage: Can't read arch/mips/boot/vmlinux.gz.itb.tmp: Invalid argument
    /usr/bin/mkimage Can't add hashes to FIT blob

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 28128c61e08e ("kconfig.h: Include compiler types to avoid missed struct attributes")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -126,6 +126,7 @@ $(obj)/vmlinux.its.S: $(addprefix $(srct
 
 quiet_cmd_cpp_its_S = ITS     $@
       cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
+			-D__ASSEMBLY__ \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
 			-DVMLINUX_BINARY="\"$(3)\"" \
 			-DVMLINUX_COMPRESSION="\"$(2)\"" \
