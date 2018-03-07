Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs8JalPMoIpR2BWiHWgraXOwl4g6UrKJWFU8ca2FH3ETgoj1KNAAOnz0rnVf4T7F/kTWXol
ARC-Seal: i=1; a=rsa-sha256; t=1520451897; cv=none;
        d=google.com; s=arc-20160816;
        b=NBH+NCR/v2G5nX2piMj7iPp4tdaY6vV530KrL6xXjxqdKW5+FL5nhQBgTQjCFB1C4a
         YSYu8D4xdHLr6Lk++YwRyBLu8N2+uAETn4DDF5DhtbIbZPRvpeYQZD9MAgffbQ5kD+fV
         yYSsNy0kn1IOjknVXOrkl0kil/egih8ttvq+dM95wT/o3Z36OOiCvLcYHbutcb+a7K3X
         iOqYGkZt8ae14LtmireGbAVrT0j/rZHrhmDF/Hzgn4om+4VVHQ+Gp0Y5piEbxMAQqmgd
         y4ZjNWiZ/vMR+bAlBehzjgE9LrEolhjWxdHrkgqVF0IK85pgt2fkVlm2L51szZCcKXRB
         6X8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lg6TpQT5YKZTZZvfIheQwq8tBm4XqvFv1QbmnSiUTno=;
        b=dBvpmlLb6O2E5KnGXY74wJMQZjipOl931oxOBOzFDtUoNr+lrTCgUsdWJO6Qt8ZaCA
         4fXe6kmfWx+XoB01PII9zgqO1SSoxCk/GsGfI5ku585TQf/lXTYkF/Q6yNfScJHAqz83
         21pqJjcNJkEAgLBWQ3eqwpf9yJd1IgLquWpsBQVHun/LhWiQbo8FQEQIt1v4EJdqoDJp
         zG0OdoyB6ZHvVt2nHAV/sMDOXzLTUG6sxOX1TxYYc3jFn1qNDJZkgboK0TLMHegQ0fMd
         Hj4NUUjE5UfGZCcirSyeBs8QsEPpDTfu8gSVaYZ0j2WZAy85RWjkGymW2Amrf+m5TmYQ
         vc8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 4.14 021/110] parisc: Use cr16 interval timers unconditionally on qemu
Date: Wed,  7 Mar 2018 11:38:04 -0800
Message-Id: <20180307191042.414882182@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309081003158357?=
X-GMAIL-MSGID: =?utf-8?q?1594309369572986433?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit 5ffa8518851f1401817c15d2a7eecc0373c26ff9 upstream.

When running on qemu we know that the (emulated) cr16 cpu-internal
clocks are syncronized. So let's use them unconditionally on qemu.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/include/asm/processor.h |    2 ++
 arch/parisc/kernel/time.c           |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -316,6 +316,8 @@ extern int _parisc_requires_coherency;
 #define parisc_requires_coherency()	(0)
 #endif
 
+extern int running_on_qemu;
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_PARISC_PROCESSOR_H */
--- a/arch/parisc/kernel/time.c
+++ b/arch/parisc/kernel/time.c
@@ -248,7 +248,7 @@ static int __init init_cr16_clocksource(
 	 * different sockets, so mark them unstable and lower rating on
 	 * multi-socket SMP systems.
 	 */
-	if (num_online_cpus() > 1) {
+	if (num_online_cpus() > 1 && !running_on_qemu) {
 		int cpu;
 		unsigned long cpu0_loc;
 		cpu0_loc = per_cpu(cpu_data, 0).cpu_loc;
