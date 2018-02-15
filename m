Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225l5UVLTb8lt5KoobxLDbtflGVak/VdnIj9VpXays/bsZHJs6FwSMmnskZ0ROo4c8XCHSpV
ARC-Seal: i=1; a=rsa-sha256; t=1518708813; cv=none;
        d=google.com; s=arc-20160816;
        b=Tk1oWZuvINiPV39HbClJApEgQ7+DAeUidhYVJez1FAhBfdSKDqu8J0rz4E8CUsdnNl
         upmULSfuURpG/Bmc03wlim/AaVHJQh4HzxRL7Twp6CCt+N6Vzz0kBQUJrgtsEx2Snt45
         NZtsCgX3vMQOTVooB0Dw1CGBhyzUEfOfy7Ehebwhni9ZtVGgTF0x27JvAHoDy8Rgg6Ob
         ZLINEb/fz5QGMktmE8KwBZp7xTBcF9jH1MW7MZhFtuDqDCNmfNLwl4IFEtDLgiHVevR7
         5Z8ECVFV5UFR6Ga/69sOpDo9rncWPtlfzYqgNSl0CJ1I5BJ8SGeHfzpPAwQjFcfcDddT
         a06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5VFVBIxBdb9gg7Af2lvC68VAyQA2z6GErl7GZ7MDaeo=;
        b=sA4SzbCB1eGApCoguXQalzjmK7lvRwvJlmpyGyGayl6gNNGs5+gLdUGOEc4VJnjF1j
         yFc8zKpTjk2wsIhxolgf/Yzf3//OQ6OoNIg6F5sFovsOSvhYsJ+MuceU28ltJJKk24I5
         PeUyEL0NjzDtS2Cd6Dypxo449P8rTmqszApeBFf5chJFGGzzlkK3i2VZGNBtuDkPXTNy
         C3hechR+jUFrmcSihYSckvh8R9mJmljedVE/E388tdIJzh8LSp7W+ipmHBax7hYqiIj5
         c3kvpa4sKayuejBZ/x5P+O/tvU127W5hCMZnotbmcP0zErnsdqj52CEzzjYgzMTpH0zu
         UG7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 053/195] [Variant 3/Meltdown] arm64: Force KPTI to be disabled on Cavium ThunderX
Date: Thu, 15 Feb 2018 16:15:44 +0100
Message-Id: <20180215151708.385177892@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481612339960313?=
X-GMAIL-MSGID: =?utf-8?q?1592481612339960313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 6dc52b15c4a4 upstream.

Cavium ThunderX's erratum 27456 results in a corruption of icache
entries that are loaded from memory that is mapped as non-global
(i.e. ASID-tagged).

As KPTI is based on memory being mapped non-global, let's prevent
it from kicking in if this erratum is detected.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[will: Update comment]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpufeature.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -803,12 +803,23 @@ static int __kpti_forced; /* 0: not forc
 static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 				int __unused)
 {
+	char const *str = "command line option";
 	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
 
-	/* Forced on command line? */
+	/*
+	 * For reasons that aren't entirely clear, enabling KPTI on Cavium
+	 * ThunderX leads to apparent I-cache corruption of kernel text, which
+	 * ends as well as you might imagine. Don't even try.
+	 */
+	if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_27456)) {
+		str = "ARM64_WORKAROUND_CAVIUM_27456";
+		__kpti_forced = -1;
+	}
+
+	/* Forced? */
 	if (__kpti_forced) {
-		pr_info_once("kernel page table isolation forced %s by command line option\n",
-			     __kpti_forced > 0 ? "ON" : "OFF");
+		pr_info_once("kernel page table isolation forced %s by %s\n",
+			     __kpti_forced > 0 ? "ON" : "OFF", str);
 		return __kpti_forced > 0;
 	}
 
