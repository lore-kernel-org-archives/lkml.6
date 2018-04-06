Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48TJyloSAvsZ1WtcBCz0dB3O4DD/S+KUaSbCSAs2YQaJmi0mAawCsjqVFZa/8x5ESm41h4K
ARC-Seal: i=1; a=rsa-sha256; t=1523021109; cv=none;
        d=google.com; s=arc-20160816;
        b=k/j8w+bJyfDtSRBPfe9ZKMP+lQWnUupqfTnG/Fp2X6HWN3zBp/jCbMhpe1WRRFlD+W
         1y5XbAAuMpZdovj2eOkhi1PyMlJeIJmlhtEyvvyl4YtiN3kwkAcZ0SumdUzNjWzyWSs+
         4/L/HKZ5YMSPhMjq8eK7AWrpa4A339Ut44bCmU7Mi2BprM56oOMs6jJwph82Z6N19Ajx
         K2c9dfMHBCe1j/WQ/G05iGNZWoY93bpgjjhO+fCI/huxTZ8UtxreTYNGsGPNEN+TLAeN
         LuOu2v2OPT1XmGEYfU6SbMGD5ICBINO8QQIW3AG9bEwPbVSynKLaP2EWawzhXEIOnCe5
         FKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TTzWabWgop/KIv2p1KF9F3Z7zZN+wKIG+aB9bXLKrxY=;
        b=lUbr/gJhrsw73n4JF33fJmUunWXqjoGWcuBFaWVus3MNfaGfLAt9up3wxbJ08j6LHe
         ABSp9jdkBlf9Zv8Q6bZVkfWxeQYPSpOjPERzNr+DGEKJqs6DHFDzJT1owvj73ns7p0tS
         Ood5tbE0lyf6UTvbl5A2Gw93mCyilpznGEhG0yge+krweXxx7hQcg3LvRe+pIJ14Bc41
         AXB+ouTfyIQ1diuF9URCGdFK+qQDk7m4yy1JksbsV+G6YF5KWiGWirW/9yb58oBjdfOf
         n7VQ5kYqgdpX7tRujWvh6XNJwrGukCmss7YjqmaI4eH8TP7Ny2qGecZUXwHohWkTA4ZX
         2CAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3.18 11/93] libata: Modify quirks for MX100 to limit NCQ_TRIM quirk to MU01 version
Date: Fri,  6 Apr 2018 15:22:40 +0200
Message-Id: <20180406084225.464014653@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003383593649606?=
X-GMAIL-MSGID: =?utf-8?q?1597003383593649606?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit d418ff56b8f2d2b296daafa8da151fe27689b757 upstream.

When commit 9c7be59fc519af ("libata: Apply NOLPM quirk to Crucial MX100
512GB SSDs") was added it inherited the ATA_HORKAGE_NO_NCQ_TRIM quirk
from the existing "Crucial_CT*MX100*" entry, but that entry sets model_rev
to "MU01", where as the entry adding the NOLPM quirk sets it to NULL.

This means that after this commit we no apply the NO_NCQ_TRIM quirk to
all "Crucial_CT512MX100*" SSDs even if they have the fixed "MU02"
firmware. This commit splits the "Crucial_CT512MX100*" quirk into 2
quirks, one for the "MU01" firmware and one for all other firmware
versions, so that we once again only apply the NO_NCQ_TRIM quirk to the
"MU01" firmware version.

Fixes: 9c7be59fc519af ("libata: Apply NOLPM quirk to ... MX100 512GB SSDs")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4228,10 +4228,13 @@ static const struct ata_blacklist_entry
 	/* Crucial BX100 SSD 500GB has broken LPM support */
 	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
 
-	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
-	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+	/* 512GB MX100 with MU01 firmware has both queued TRIM and LPM issues */
+	{ "Crucial_CT512MX100*",	"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
+	/* 512GB MX100 with newer firmware has only LPM issues */
+	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM |
+						ATA_HORKAGE_NOLPM, },
 
 	/* 480GB+ M500 SSDs have both queued TRIM and LPM issues */
 	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
