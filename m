Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+vUna5Bh+K/aRm6K3ob/ILVXmMoCOJa+mWJcrc5guao1dL+iGcNYVdxNV/NXE9gOJzEHqk
ARC-Seal: i=1; a=rsa-sha256; t=1523980942; cv=none;
        d=google.com; s=arc-20160816;
        b=YMSTmgBNFZF9s5ZMvfrD/TgrkZU8Im+sNnG4KOcprUnGVXxseMXbAsmuzHwJFE0+Jk
         1E3e3V6LLhCvSse8GPDNDcQ38tQSACSrSdItKTMj8lZW0f+R9No0eeDPIKfDcKKLm2ah
         elkUY3XhKSKeunDDOnrG1BaJnv6F8ie2/iFMIUK1AOFbPZJ7wNyt3Rrwi7cA9rdIQ/JI
         3hW6a9Dcn3Wm/Odb2j6IdKD795u8neFDeBEeU1R56xSpSqMiL87I3LRWTC6Knzvi4YKQ
         uSpyZ9TEQqXZz671kbqrU9jLq/Ba/Mz5wzeML6jidtPPX5p2EjAtoRHzjhZglJ7RREY4
         YMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tEUjOFLh+yA1DNcpneYnYde1wMLnzKCrbYbJllTz31E=;
        b=uvNwZ+RrL/g36ATfxHz7ACkpxPn5i0gWxsIKUxg72yOWRCAleos04xFx+ihmC9ktz4
         Mg67PmjjzQWT3xyMsdy691oZ8zKSsH4d/gv2J+Qg9mkUtzOHBik5LLKlJHqvcaB7ofQy
         aqAbpxYbg9drzPFpRUmEBzpGDwgse0blF7u8xLv+ZUiB9imN+mCtRYnGfjM//5udUr/l
         dxHjVfF1bvsLhglWVq+gLcF5JxE+jziXrTOJwLQ+AG2U5uGXvXO3C/yu8gD1D0BR9gQT
         hVJgsDZ2DGWaX6eYuWkyv79OE4ZlyqTXgwIJ0RSWuf9enrr9ziraM3pw8NEdTMR8eZDZ
         NfVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.16 58/68] nfit: fix region registration vs block-data-window ranges
Date: Tue, 17 Apr 2018 17:58:11 +0200
Message-Id: <20180417155751.699756850@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009840996584111?=
X-GMAIL-MSGID: =?utf-8?q?1598009840996584111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 8d0d8ed3356aa9ed43b819aaedd39b08ca453007 upstream.

Commit 1cf03c00e7c1 "nfit: scrub and register regions in a workqueue"
mistakenly attempts to register a region per BLK aperture. There is
nothing to register for individual apertures as they belong as a set to
a BLK aperture group that are registered with a corresponding
DIMM-control-region. Filter them for registration to prevent some
needless devm_kzalloc() allocations.

Cc: <stable@vger.kernel.org>
Fixes: 1cf03c00e7c1 ("nfit: scrub and register regions in a workqueue")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3024,15 +3024,21 @@ static void acpi_nfit_scrub(struct work_
 static int acpi_nfit_register_regions(struct acpi_nfit_desc *acpi_desc)
 {
 	struct nfit_spa *nfit_spa;
-	int rc;
 
-	list_for_each_entry(nfit_spa, &acpi_desc->spas, list)
-		if (nfit_spa_type(nfit_spa->spa) == NFIT_SPA_DCR) {
-			/* BLK regions don't need to wait for ars results */
-			rc = acpi_nfit_register_region(acpi_desc, nfit_spa);
-			if (rc)
-				return rc;
-		}
+	list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
+		int rc, type = nfit_spa_type(nfit_spa->spa);
+
+		/* PMEM and VMEM will be registered by the ARS workqueue */
+		if (type == NFIT_SPA_PM || type == NFIT_SPA_VOLATILE)
+			continue;
+		/* BLK apertures belong to BLK region registration below */
+		if (type == NFIT_SPA_BDW)
+			continue;
+		/* BLK regions don't need to wait for ARS results */
+		rc = acpi_nfit_register_region(acpi_desc, nfit_spa);
+		if (rc)
+			return rc;
+	}
 
 	acpi_desc->ars_start_flags = 0;
 	if (!acpi_desc->cancel)
