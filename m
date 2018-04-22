Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/TgjL9DPi/RsZKekDu4ubcV/2VgWhu6KhRywcUturffF09QfJCHOYLHWLdzW7AE+SY27G9
ARC-Seal: i=1; a=rsa-sha256; t=1524405697; cv=none;
        d=google.com; s=arc-20160816;
        b=m5IppzjW8dBEMe+Xlwba1rkGjAsj8zTM5pR5KZLYlnxsVKS1EIPKcwrh5OUgITTjYy
         NugO/qcpTiyyTgDy9qZVfhVcTqQOO+xpFFwu59uFx5xg0zI7qvkC9e62y/rXfOs1RNNf
         bk3DV6p/YGtEkVEHD9jltBoirTXlsdRlavnYYT796ASg1GJjlOAUNC+MX82pl9F9RFa+
         yeob9NHdluBUOPwQjA4OHv2aoSLv0QbHEDnjvRG9G2E5Wp2+lmt4sb+Hy53yDWUntzN8
         VMmNkuh8RHkvgC8PzCOS9JVhj7eEDQWEIdiF2SZDnSzREGpBwztEoFNm4dAhF+YtD7rC
         JPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jVu4AZnk93YIqENmC4cfpAtVVZY4As+y90weueFd4BA=;
        b=BAnegTq0ULfyb9a7k5PEFlhrrfChO8Is0gkjjc6Gi+g4xdzcMhBCmaEEb8+oLnR3ck
         Dh6A5kEiMJVeCYwP+ztN4BbVb1LEvgLY+iX+bCRP8ZWawNkKjKz8+nJ0F0LECcszfIDa
         p7RZpvTSRT1XoBr8hDnuwb0xt04go4Wb8SjeaFNtUe8yS4SW4Og4IjILENyJKl+1gMmj
         r1SiB3wm7RZregYjrdIiZo+7PsHnLS1oDNTw0sk/VbDtVUstcSAW9a0E2/iOhYUAMcwD
         4xxojHVMsa69e292CzsuZ+C4p/Dl4i3D3z6R7ZKNNIZCQB+QiOPCNLgA0EIi24nqIPx3
         VnOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Toshi Kani <toshi.kani@hpe.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.16 126/196] nfit: skip region registration for incomplete control regions
Date: Sun, 22 Apr 2018 15:52:26 +0200
Message-Id: <20180422135110.768930335@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455228555784870?=
X-GMAIL-MSGID: =?utf-8?q?1598455228555784870?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 0731de476a37c33485af82d64041c9d193208df8 upstream.

Per the ACPI specification the only functional purpose for a DIMM
Control Region to be mapped into the system physical address space, from
an OSPM perspective, is to support block-apertures. However, there are
some BIOSen that publish DIMM Control Region SPA entries for pre-boot
environment consumption.  Undo the kernel policy of generating disabled
'ndblk' regions when this configuration is detected.

Cc: <stable@vger.kernel.org>
Fixes: 1f7df6f88b92 ("libnvdimm, nfit: regions (block-data-window...)")
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2583,7 +2583,7 @@ static int acpi_nfit_init_mapping(struct
 	struct acpi_nfit_system_address *spa = nfit_spa->spa;
 	struct nd_blk_region_desc *ndbr_desc;
 	struct nfit_mem *nfit_mem;
-	int blk_valid = 0, rc;
+	int rc;
 
 	if (!nvdimm) {
 		dev_err(acpi_desc->dev, "spa%d dimm: %#x not found\n",
@@ -2603,15 +2603,14 @@ static int acpi_nfit_init_mapping(struct
 		if (!nfit_mem || !nfit_mem->bdw) {
 			dev_dbg(acpi_desc->dev, "spa%d %s missing bdw\n",
 					spa->range_index, nvdimm_name(nvdimm));
-		} else {
-			mapping->size = nfit_mem->bdw->capacity;
-			mapping->start = nfit_mem->bdw->start_address;
-			ndr_desc->num_lanes = nfit_mem->bdw->windows;
-			blk_valid = 1;
+			break;
 		}
 
+		mapping->size = nfit_mem->bdw->capacity;
+		mapping->start = nfit_mem->bdw->start_address;
+		ndr_desc->num_lanes = nfit_mem->bdw->windows;
 		ndr_desc->mapping = mapping;
-		ndr_desc->num_mappings = blk_valid;
+		ndr_desc->num_mappings = 1;
 		ndbr_desc = to_blk_region_desc(ndr_desc);
 		ndbr_desc->enable = acpi_nfit_blk_region_enable;
 		ndbr_desc->do_io = acpi_desc->blk_do_io;
