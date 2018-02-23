Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224C4NEdISglQkpLzAYqBbPzLwPiDl9ex8VsAxTYI5wq9WJYr8r9Z0PJJXKuMrEJOj0tlAdQ
ARC-Seal: i=1; a=rsa-sha256; t=1519412305; cv=none;
        d=google.com; s=arc-20160816;
        b=S3WW5DgJuZkt+Qi+P0x+uPeD6ycJi8jmCGJPGcym6jn20VZ7htXoV7AIktUItZYRAf
         EDKSmH+McVTJkDnqcg8DCmTsIF1+ASn8O9U5aDzKbNJ6+8jABgZGnHtpL5C40NWYgHF1
         gFo4Y+iD5hHPSjd8DBHF5BCa+Od/GhiUDLZUYLcZ7DuzWWLBYOypAjgPUPOdtWaZLOEc
         v6qwLDEdKq2WI1yY8VmHnLBaBXgeytbP46GewHiF01pQvgorJOHpJbkATOpWDetJw4Jn
         RHtBr9NWdJFe6BJFDoWb4/cgqbBXfGCZOXRvrAxqkyXovHmppzUuwnLJpoMkWHN6W5xy
         e1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SrvcRk4j1j38TPi+Zh3X7q/+o1nVUWAxqGlTjtOErZc=;
        b=cU2b0T3NQWghSjlOhZKwN1RbbHv3K8lz8p8QX+TmzK/JA4NeehiSqoUJh3THwXVE1h
         ZiWxuuP+G1mgtlvSM4nAmLw3tfZet1fTPc5Zfz0ZXGkUgV/fmww/7RI7W72J/2n1RDxS
         QYNAHNvKm2nSPJAVFm/KdNpyZS4PgPdPFmQyPEzqgTHF9XmDReeaNUpjSv1REIsm9HQr
         CYNOvxq5IdSjSPNjjJ8RN1LNBScfkmpt92L7sfrhdMtHJIWockovxB8WN5FQdbXgh0L2
         /2pl53RFGqGYqVAlRtM+SrOlVR+Suf64ClPCfoX4hz1E/jowT+pFW2lBmamPwsGDaI/v
         vhTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.15 34/45] staging: fsl-mc: fix build testing on x86
Date: Fri, 23 Feb 2018 19:29:13 +0100
Message-Id: <20180223170720.745684314@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218854631563652?=
X-GMAIL-MSGID: =?utf-8?q?1593219278005281049?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 02b7b2844c2ffd3b614ec2b9293e8c7f041d60da upstream.

Selecting GENERIC_MSI_IRQ_DOMAIN on x86 causes a compile-time error in
some configurations:

drivers/base/platform-msi.c:37:19: error: field 'arg' has incomplete type

On the other architectures, we are fine, but here we should have an additional
dependency on X86_LOCAL_APIC so we can get the PCI_MSI_IRQ_DOMAIN symbol.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/fsl-mc/bus/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -8,7 +8,7 @@
 
 config FSL_MC_BUS
 	bool "QorIQ DPAA2 fsl-mc bus driver"
-	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86 || PPC)))
+	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86_LOCAL_APIC || PPC)))
 	select GENERIC_MSI_IRQ_DOMAIN
 	help
 	  Driver to enable the bus infrastructure for the QorIQ DPAA2
