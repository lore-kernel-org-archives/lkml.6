Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+9Lj+JVHv9xmNnZtWXtMeGi/qtgq9eN3/KVY3XfCH8Mdz8PljQA5NCDhhLYi9h8j4GXcJa
ARC-Seal: i=1; a=rsa-sha256; t=1524652749; cv=none;
        d=google.com; s=arc-20160816;
        b=lZQ9aEZHRzm0Ik+JANhtnbiJE3MgNgpfAk0RyfGnNthtWjIxdGCCjECo7RUt9IZvb5
         E/x599mupTgC/yaZB+vPcAny0OugbJ9S4/W/sJ4Lc8wC+WhM4hm9mCERx6mB5osvdgzz
         bywAJiyyoDYbVRCld6DL+1DNMWsYdB9m8bvGNucvm21cpxEVbUiqWzSAwaViBpPmSWIB
         rzCzqBkkXEcMpcJbRJrodfoBSQAAHqAd0AjBSGHfjZYPn/uGRgPWaIB7z/JCgCdIPALl
         8PbWuPoJJm8aj9HODfRjshsMRe3+EniaGqGEbyv3gaujw5uCgg1I3JKyuoKxFlqBqCyc
         p51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zevzqNU1hMAsgYiE/Ebq/5RscHMoZiindGQnXuJYKuQ=;
        b=fKk3u0k+FBSEFBRfF+2vagfFIXZd7ywnXb6l+2sg9Q/KSQ1v9XJvtTIotykAtHti1p
         lcl8xpjeiosiP9NWxmfIvKSB+Y8jnsyxVuZJkDPs6GHceTUh7JyUTnD7qTR0zEI6inI7
         Rb8Bf2ISieaWjG8yqSVJaRqBF5hmn9Q+K4ALtYJWtzAJfEh+dUglau1ooCVSThXKFvJC
         EPq7LNf6KN2VzwVvDjVUSkBHOBw14xpTQ6raoPXhC5f59g6Y9tupEqCjbfUQ2u1/tSVe
         vxKrbewimWvNygPjksM4nVBrZrYrmhvUcTdV/FIO16a1MRCzxGCHVikSVYgPUAZUxADv
         WM0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Hogan <jhogan@kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 055/183] MIPS: Fix clean of vmlinuz.{32,ecoff,bin,srec}
Date: Wed, 25 Apr 2018 12:34:35 +0200
Message-Id: <20180425103244.760450636@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714281951494253?=
X-GMAIL-MSGID: =?utf-8?q?1598714281951494253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>


[ Upstream commit 5f2483eb2423152445b39f2db59d372f523e664e ]

Make doesn't expand shell style "vmlinuz.{32,ecoff,bin,srec}" to the 4
separate files, so none of these files get cleaned up by make clean.
List the files separately instead.

Fixes: ec3352925b74 ("MIPS: Remove all generated vmlinuz* files on "make clean"")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18491/
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/boot/compressed/Makefile |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -133,4 +133,8 @@ vmlinuz.srec: vmlinuz
 uzImage.bin: vmlinuz.bin FORCE
 	$(call if_changed,uimage,none)
 
-clean-files := $(objtree)/vmlinuz $(objtree)/vmlinuz.{32,ecoff,bin,srec}
+clean-files += $(objtree)/vmlinuz
+clean-files += $(objtree)/vmlinuz.32
+clean-files += $(objtree)/vmlinuz.ecoff
+clean-files += $(objtree)/vmlinuz.bin
+clean-files += $(objtree)/vmlinuz.srec
