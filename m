Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvgyuQaDiqf9G9OKHhaVVehce76ZOitsE/KtmxT5Ju8pmIfNW+pStRPCMRMiMfgCSVQt7ez
ARC-Seal: i=1; a=rsa-sha256; t=1520955199; cv=none;
        d=google.com; s=arc-20160816;
        b=jaqPDc4hdOP6S5IGixmhVRbH6oHeX7uDvLU3hjQpU1VfPh5ocNSBcjLgno3+zVeEKz
         zM61VpFhceVkvDJqg0D1kY+jVv8yY9gVw1Bmj9s7PINiXrL/5sUAhIrCz+U3KL7XYmtn
         EbGETeBY5KGFOr/c2TvXIk5j02KOe8SmhYUamOyNADwEsBQvsHrHI4FAbN+ahmbt02od
         nUg+xIWNV52LS0QJ/PW4/IqHSGWrzCOLJ3BO/LJMNGiaDK7QW7fQOf3nx00gIbjDgzMt
         pmjfih8G7o1uPCpzzAitZTGMqtD1x8G27cKOaQLeurdZ2LhqnCV2QMmy0hw/JLV/NeSz
         oxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7gtIq/lQHq6ap10nJhOV0CXeuS/pyaixJnvoYSWqGI4=;
        b=NoXDdYXPPHgkpeHOt58GyEnaor6KWZuR6nPpcGJj3PuzSQcFa56O4ZSpnTma2P9rD1
         Ko2yBycRiBTeQfttI0Y3uYBzU659CPkalo0Lz/Tdg9YJh6dpC6MYszwE6WCXB+HuzGh4
         /4U2gKhXYVUdVdqb7rYAObmkDfQLTEroK0+Iu0RLRsRYnVWBFDRCteODWCY1iUnuo/Nb
         ZLnwv4yvQByB+Ms23QfAikFDXlHYykpGUF2y1Sw6Sy/tsmZ7h1Z28k2hEOczc+jl+JaM
         FIFCG9Wwg82BNJ4x0s6pRjWA6iec+eFe5itNb5C8PkW46R9cWmTOsoz4DbEEAObYO63/
         l/Xg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	James Ettle <james@ettle.org.uk>,
	Jeffery Miller <jmiller@neverware.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.15 122/146] tpm: only attempt to disable the LPC CLKRUN if is already enabled
Date: Tue, 13 Mar 2018 16:24:49 +0100
Message-Id: <20180313152329.652720758@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837119781067640?=
X-GMAIL-MSGID: =?utf-8?q?1594837119781067640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Martinez Canillas <javierm@redhat.com>

commit 6c9f0ce0dffe64da2204f38b0fd90f3ae2a8903c upstream.

Commit 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
added logic in the TPM TIS driver to disable the Low Pin Count CLKRUN
signal during TPM transactions.

Unfortunately this breaks other devices that are attached to the LPC bus
like for example PS/2 mouse and keyboards.

One flaw with the logic is that it assumes that the CLKRUN is always
enabled, and so it unconditionally enables it after a TPM transaction.

But it could be that the CLKRUN# signal was already disabled in the LPC
bus and so after the driver probes, CLKRUN_EN will remain enabled which
may break other devices that are attached to the LPC bus but don't have
support for the CLKRUN protocol.

Fixes: 5e572cab92f0 ("tpm: Enable CLKRUN protocol for Braswell systems")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: James Ettle <james@ettle.org.uk>
Tested-by: Jeffery Miller <jmiller@neverware.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis_core.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -694,7 +694,8 @@ static void tpm_tis_clkrun_enable(struct
 	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
 	u32 clkrun_val;
 
-	if (!IS_ENABLED(CONFIG_X86) || !is_bsw())
+	if (!IS_ENABLED(CONFIG_X86) || !is_bsw() ||
+	    !data->ilb_base_addr)
 		return;
 
 	if (value) {
@@ -751,6 +752,7 @@ int tpm_tis_core_init(struct device *dev
 		      acpi_handle acpi_dev_handle)
 {
 	u32 vendor, intfcaps, intmask;
+	u32 clkrun_val;
 	u8 rid;
 	int rc, probe;
 	struct tpm_chip *chip;
@@ -776,6 +778,13 @@ int tpm_tis_core_init(struct device *dev
 					ILB_REMAP_SIZE);
 		if (!priv->ilb_base_addr)
 			return -ENOMEM;
+
+		clkrun_val = ioread32(priv->ilb_base_addr + LPC_CNTRL_OFFSET);
+		/* Check if CLKRUN# is already not enabled in the LPC bus */
+		if (!(clkrun_val & LPC_CLKRUN_EN)) {
+			iounmap(priv->ilb_base_addr);
+			priv->ilb_base_addr = NULL;
+		}
 	}
 
 	if (chip->ops->clk_enable != NULL)
