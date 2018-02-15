Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226/bU8lZH7NR4vrJglAask1zmLZ7Ueib7tX3aikSMqy7TWb5+T8Nv/Qxpub+/tyoKcR8OUP
ARC-Seal: i=1; a=rsa-sha256; t=1518708689; cv=none;
        d=google.com; s=arc-20160816;
        b=kQ/a/mf8IsSSVj6BnRlPohXDEa5w8SOwRBwh8fBsGpfXqrth13d37grbDoC4KfmwOZ
         w20eiSrhg0yjUTQ/0q81gldPaeTDrUGEZ4pSg/zoXz6fQ94Sd3XfrnAF15W0tkMkBXkC
         Qm1bHYatKkVYq+Wb0f4GaUJ8J/riQf4khe+KkSC+KAg0/sOTL9rIB4mx309hGnNvt1NN
         OlwLc3ff34p248wikMmBd+N06g4TgbJwNLJ6BWQKGmN/XaEBtj0zufJwG2FA/+26ypDL
         M48oiMfhMHysox79l085GSTrkKRzxQS1OMRwpmKXjUuoQYltJ5RCEj99dqOqGPJ7GiYE
         A9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DqFph+7kPoNlnWNSKGnASAednUU1dNLEsQ0RGZk5xPg=;
        b=UATap1+WF0ADCCnfsSQmlcNNPWSy0Tlczm82Naxt5DuK4XyAgm0Gt/Nl+uzPxzHpPz
         WL1UM/ssK7DjKZ4017/ZzRZEG6BFxTAYTsW45FXfx1zcDfP1yinsqia3oaqYHNHIBTf4
         qNZGhzYXypTK+VqJ9PBDjNMjqi3KKNivOZBtxBo2MSR8It8mA8yInkg4M0IrJRkp921y
         17B4bNL9zkEOrCVmC2li22arbjlwKF2CQFNx0s5fxAVpoBBZ5xP2qXexq3YcAQ7dvbBZ
         H6skFsj5zeS8tyr/arycDWZkwSO+t3iUZ12JxkPZSCgVQ7sViuaV/IX8F1Ol/zDLWXwZ
         oPqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 043/195] [Variant 3/Meltdown] arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
Date: Thu, 15 Feb 2018 16:15:34 +0100
Message-Id: <20180215151707.897042366@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481483131893734?=
X-GMAIL-MSGID: =?utf-8?q?1592481483131893734?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 0617052ddde3 upstream.

Although CONFIG_UNMAP_KERNEL_AT_EL0 does make KASLR more robust, it's
actually more useful as a mitigation against speculation attacks that
can leak arbitrary kernel data to userspace through speculation.

Reword the Kconfig help message to reflect this, and make the option
depend on EXPERT so that it is on by default for the majority of users.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -807,15 +807,14 @@ config FORCE_MAX_ZONEORDER
 	  4M allocations matching the default size used by generic code.
 
 config UNMAP_KERNEL_AT_EL0
-	bool "Unmap kernel when running in userspace (aka \"KAISER\")"
+	bool "Unmap kernel when running in userspace (aka \"KAISER\")" if EXPERT
 	default y
 	help
-	  Some attacks against KASLR make use of the timing difference between
-	  a permission fault which could arise from a page table entry that is
-	  present in the TLB, and a translation fault which always requires a
-	  page table walk. This option defends against these attacks by unmapping
-	  the kernel whilst running in userspace, therefore forcing translation
-	  faults for all of kernel space.
+	  Speculation attacks against some high-performance processors can
+	  be used to bypass MMU permission checks and leak kernel data to
+	  userspace. This can be defended against by unmapping the kernel
+	  when running in userspace, mapping it back in on exception entry
+	  via a trampoline page in the vector table.
 
 	  If unsure, say Y.
 
