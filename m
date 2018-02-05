Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2277gJhfLzay31+FhuxrVUqbjJL/2AXTzanH8K9y+065FX47R1VsDMf2YqveQWsmPsC1BYof
ARC-Seal: i=1; a=rsa-sha256; t=1517855007; cv=none;
        d=google.com; s=arc-20160816;
        b=YwncBUZH0MHN0Oq2LjhotRv5wkG/xX3iOTi/WHWQSmZtmOi77MBR4xB3dAJVVYvSJ+
         0ib2TVXuJ0IlsTTCtqOmPoltGBAhy2fdfYa3xN8/w+RoXDmdfulo597JXF17nAXoOt8S
         IbhMHDuAXA87T6KdL3W5Yft0Tby6EFX61cx7Wm/FNDOUUuliciUDE0v4MxSunglJ0cJq
         mviMIAt1nJ65W7rOfLASVAriFAs/wdzVuknw+eb/ypfNiH5uOzyhBPLmyf2jfm++2gqm
         1gUIgjSwSFlEYjJy0yVrCQpylXC0smU9ondrijvTEcBla3vDltevvsJamNX4AJh20D+d
         /+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HJsD859MHemQ85kQzLqIYkh9vYpOq9WoXmekObsRry4=;
        b=ptcsJHJKCiyX3ovYg1m73yQAHps+21UwuKjMwPT7u9rucMDWZMt06GnPcAqZuEFcMh
         pCoLG6cJBJYhsDrozXnzTByCUZaJuZd8hyk+SruIB62F7k1PUPgK6YBmxv26avGLCUsE
         DMliSdBkY3TwJQ9Qhhab+s7dWsjysLvEvn2AQvPvwrPrzEvn1nLT3ON/ZbOdsLxYfeC9
         JwzB29uPVoxvy/ND5zOxHcsHLDTilpvPIO1xvgjUuSiN6CY3xenvsQhxURt5WTedTixo
         a9mWC2MJ1IryB93t/6BNjUbSqiW44TOgEmPfKlqhymFbY7wZBN6TdyGyhK9RXMaRx6Zn
         XMlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 02/64] powerpc/64s: Wire up cpu_show_meltdown()
Date: Mon,  5 Feb 2018 10:22:21 -0800
Message-Id: <20180205182138.665709120@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586332256254649?=
X-GMAIL-MSGID: =?utf-8?q?1591586332256254649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit fd6e440f20b1a4304553775fc55938848ff617c9 upstream.

The recent commit 87590ce6e373 ("sysfs/cpu: Add vulnerability folder")
added a generic folder and set of files for reporting information on
CPU vulnerabilities. One of those was for meltdown:

  /sys/devices/system/cpu/vulnerabilities/meltdown

This commit wires up that file for 64-bit Book3S powerpc.

For now we default to "Vulnerable" unless the RFI flush is enabled.
That may not actually be true on all hardware, further patches will
refine the reporting based on the CPU/platform etc. But for now we
default to being pessimists.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/Kconfig           |    1 +
 arch/powerpc/kernel/setup_64.c |    8 ++++++++
 2 files changed, 9 insertions(+)

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -164,6 +164,7 @@ config PPC
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_SMP_IDLE_THREAD
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -884,4 +884,12 @@ void __init setup_rfi_flush(enum l1d_flu
 	if (!no_rfi_flush)
 		rfi_flush_enable(enable);
 }
+
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	if (rfi_flush)
+		return sprintf(buf, "Mitigation: RFI Flush\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
 #endif /* CONFIG_PPC_BOOK3S_64 */
