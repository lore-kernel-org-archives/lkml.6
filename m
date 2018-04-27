Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrkm3DI1S8VvnifHrrx9FfGYrNQ8/RQmQQVZj6Ma4JJbB0cjDfE0yjqoXj50nDmgAU0JU9I
ARC-Seal: i=1; a=rsa-sha256; t=1524837772; cv=none;
        d=google.com; s=arc-20160816;
        b=EEc+WlHj9LLJ7KZOQQNK3ZW7/7+oEWB/9de5k1VnuZD2RTQVYMX4hZpTZ8gS0BUVUD
         PZ4RYa9m2h5akvDP0zugs2pDN3ELEJlBaWEc1oVt76kFNp2OONlGJ3DNDdkc/X92dIsQ
         Vv2z7hreIge79vCUrrq1OisfFbCi/lWPX/wnnOcTQf1xcbu+1ZcB4lkv7tnlPllV0aD8
         XXqXdzcDRNBDLD9Omo6rGSN1teWp2M68rg1Fwec9280wtLdzvo97ZPkqABFmy40cnyY/
         +nEEFAlzIr4kp9ZEk4FrpRBM8FPQ7Uzz5fdY2XBcP/lWiQOqhCVJ2ObMEmK4jogb2q9e
         PYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=mhPhGuMLYSkf/I8529BTfaf16je6idTn9+aXHyiMWOI=;
        b=hMvw0pTXaK+H7y6foNQjt9B40CM+ejKB4qGJrYMsKx/QDQnjG1oXrbsFQL25QgAp/d
         bm9LWVrqzcXEEvSo3cV2dZlqCRnyQ+lIJ5zEhrXGr+6E7yI6F27Xpdkn00h0mBMcb+TO
         +IHmKk0avRmW7aA0+UYKMNMcMM7oqrZBAxqDLvuCIwGjp5bLuJLTpHv80hN1wQ4F46bN
         SuS0Bnf2GCrDxXqGoZAXdkr8o1OR8SUidDE3ekmHu2IVNemIXj/GV5JO4inVDqhp3kxY
         z+1I+hPS/XvfhFkk+eeDD3zNOMQ1w4ra6YtY+ARJFcQIqdoW+icNLhk5iQPGaZnnbLvH
         GE9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E013A2189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matt Redfearn <matt.redfearn@imgtec.com>,
	linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 11/74] MIPS: Generic: Fix big endian CPUs on generic machine
Date: Fri, 27 Apr 2018 15:58:01 +0200
Message-Id: <20180427135710.365986182@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908292965249714?=
X-GMAIL-MSGID: =?utf-8?q?1598908292965249714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit a3078e593b74fe196e69f122f03ff0b32f652c53 upstream.

Big endian CPUs require SWAP_IO_SPACE enabled to swap accesses to little
endian peripherals.

Without this patch, big endian kernels fail to communicate with little
endian periperals, such as PCI devices, on QEMU and FPGA based
platforms.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/15105/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -95,6 +95,7 @@ config MIPS_GENERIC
 	select PCI_DRIVERS_GENERIC
 	select PINCTRL
 	select SMP_UP if SMP
+	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_CPU_MIPS32_R6
