Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr2thy6yHbS1MWKuNd4NLdfWMitMJsl+1N7/Bo0whSULx5S3a60FkpXPF2WiSvxNTq8+Qj9
ARC-Seal: i=1; a=rsa-sha256; t=1525116532; cv=none;
        d=google.com; s=arc-20160816;
        b=MZ1pWDg+GfEgxYXFACeIIBU/eagz5L29vyUEYsrZHbOQBB40dHreR+DmQWIZTZlWuc
         +vwoW8r+0+tGyIX/pLG3/OMnFnHq7JFPw4UIbjkR5kxePNtzO+d0Aq4e4VU59vjuHPke
         1WCG67KcNdAA75d2nteOFIFCYzEossco63VVJ0uNjYGax5YKJefeDRm23c0AF8PxMtoS
         jz1lshTneMPqgdmbDM8/630JuvHd0fEgbwHwNC1r0xQ/kdVKlgnhzaID/O3F+vbFU8+z
         ziQzqBZI2lD+rW+xSOCAgCC9fgPfJRBl7K4DMnd3ATjGlmS0woZUiSxt3ifQlFMt+1il
         yb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=awGJggrmdeZ6zI6VDi9uzRx0/NRvjrxA9S2BiPXN9Mw=;
        b=cio6QeoZZX0SAM1/S3cnx2l2eh2v6QuXpER9O7EXxQWODXre5OGM5Bol3JI1uS9fUm
         TFvkog/xVVBxb/zVvWz1heojnpkJXTELXvWqmR6wl5Gevrc8FaTF6J1n/Aoe/hSuVygr
         L9jP9LHJbSskaRPhHdYGhoHkuDf9oGMf9tgx0gMw6zENnNsLgJcJwaJEH2Fi7n5dFJm7
         blNI/ne4LCUrT8g3/RS+ep4nWjd8YpHwf8ByesKfrVFAvIxoBtmzAcas9N9UMNUaMtX6
         HEnQwPWdO2+HmUD0DODY6AaJPJ6q47VNkcn2fry4tVshR8WYbEymoK3M3MwnAS5kqwnA
         3RMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3A922DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikita Lipski <mikita.lipski@amd.com>,
	Harry Wentland <Harry.Wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.16 103/113] drm/amd/display: Fix deadlock when flushing irq
Date: Mon, 30 Apr 2018 12:25:14 -0700
Message-Id: <20180430184019.560271947@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200593272959034?=
X-GMAIL-MSGID: =?utf-8?q?1599200593272959034?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikita Lipski <mikita.lipski@amd.com>

commit ad64dc0137968f09800e58174bbfd5eac9fe5418 upstream.

Lock irq table when reading a work in queue,
unlock to flush the work, lock again till all tasks
are cleared

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -400,14 +400,15 @@ void amdgpu_dm_irq_fini(struct amdgpu_de
 {
 	int src;
 	struct irq_list_head *lh;
+	unsigned long irq_table_flags;
 	DRM_DEBUG_KMS("DM_IRQ: releasing resources.\n");
-
 	for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
-
+		DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
 		/* The handler was removed from the table,
 		 * it means it is safe to flush all the 'work'
 		 * (because no code can schedule a new one). */
 		lh = &adev->dm.irq_handler_list_low_tab[src];
+		DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 		flush_work(&lh->work);
 	}
 
