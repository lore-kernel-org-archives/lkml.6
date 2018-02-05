Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227S9FZgyFK6ItRwWpRtILoZLfZfj3c4PHgE2GhiDzti2qX2+nEpEEVGWwQoEZrflB52k8Ms
ARC-Seal: i=1; a=rsa-sha256; t=1517855119; cv=none;
        d=google.com; s=arc-20160816;
        b=U7D59jAFhFtkQzrE/XctgP94B0fnqhBA+PJvT8G+mxz6gOBiv4/lQ5wMeFIi2oPNlH
         WDKeRKk1dDdbK/wK7bdntavkws50K+uKwMC6ydkUdaoXfZ50ETB7rf6lv7jI7Gxa5BLW
         rkEdiaZE5P7DnKkqwMoa5OjFJl5dOiwu3sjM1fRdr4pSx5ILLGGWmhlt8GwxY/zTBoon
         SJFWeVVG2HxUEvObqVq8jTnoOxQD07toJBVj+r7B0xNTzxT+nTzn67bn2DmW8IVd/ELG
         yefD0Rem4Z42hBnto3dj72K5LkoFheiIIBs06pVWACJxvE8xTOKqCOf9pylA4ZVZzdLZ
         DY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dbri5otLoN88FgTn87i/Gg8OlzlWnCIPS6LAVqHvqY4=;
        b=fHWGrF+tWug7Kqy76L+qu+i2vxhwqZccwRyt/+hlUqlnaq/sbkvmNHvUTnJRz6X0lP
         36QtPUQTRYkLRunB7fCKZe1kqMiDs4ttGWiTmdgK3cuN2kyMMUStKiU6uKnRP4LMmd5D
         bKPHstIUXtQkOotpyI0dv3Qc0EPe0daeS6qNUTMrxyE/MzmZg2NwZVbvhR6/X4T4Obea
         stKp/Aif8q0BLbq5iP8IkUFt+HVudoGepHuJjX0fuPmNBVYQrLAPzDhWE89Hc9UTfe2Y
         7jhG1SUQaF/ZeFjzC+vHIVrq2Cm9hibVL23Tqw8m5rslPZQeytLOb6SpbFB8v5N+2JZ5
         Uz6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	ak@linux.intel.com,
	peterz@infradead.org,
	Tomohiro <misono.tomohiro@jp.fujitsu.com>,
	dave.hansen@intel.com,
	bp@alien8.de,
	arjan@linux.intel.com,
	dwmw@amazon.co.uk
Subject: [PATCH 4.15 28/60] x86/spectre: Check CONFIG_RETPOLINE in command line parser
Date: Mon,  5 Feb 2018 10:23:01 -0800
Message-Id: <20180205182215.096951832@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586365402935858?=
X-GMAIL-MSGID: =?utf-8?q?1591586450337321248?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dou Liyang douly.fnst@cn.fujitsu.com

commit 9471eee9186a46893726e22ebb54cade3f9bc043

The spectre_v2 option 'auto' does not check whether CONFIG_RETPOLINE is
enabled. As a consequence it fails to emit the appropriate warning and sets
feature flags which have no effect at all.

Add the missing IS_ENABLED() check.

Fixes: da285121560e ("x86/spectre: Add boot time option to select Spectre v2 mitigation")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: Tomohiro <misono.tomohiro@jp.fujitsu.com>
Cc: dave.hansen@intel.com
Cc: bp@alien8.de
Cc: arjan@linux.intel.com
Cc: dwmw@amazon.co.uk
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/f5892721-7528-3647-08fb-f8d10e65ad87@cn.fujitsu.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/bugs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -213,10 +213,10 @@ static void __init spectre_v2_select_mit
 		return;
 
 	case SPECTRE_V2_CMD_FORCE:
-		/* FALLTRHU */
 	case SPECTRE_V2_CMD_AUTO:
-		goto retpoline_auto;
-
+		if (IS_ENABLED(CONFIG_RETPOLINE))
+			goto retpoline_auto;
+		break;
 	case SPECTRE_V2_CMD_RETPOLINE_AMD:
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_amd;
