Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD283C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F7B218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Yvl1gGbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfBFALi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45735 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfBFALe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id t6so3213155edw.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bm2bfrig1u8sdvSQGYkmziO995BytTCx2B7Yh/bdjcY=;
        b=Yvl1gGblQILe6uSFp2dhuWivUoqZyNpvypQseVf86yma7yOVpmi9vEEpcrBOKVhNip
         hZUTVtej7BzCPswE8q0pH/N3C17Fkdsk8bPjsR12WWTST8lkXeIL5n7igxmIAmCOAfLp
         +jpH5smD3Y/wdUMX27G6b8646RiEn0UIIS0qvCN8onXM9Ad27PinFxZtIw8dkLB8h3bh
         GuL3BNcGwv1Uu+6hoAHoiFqCDZgitE2d3RTBWxKvpwouoOxlixaPrtAxnyzf9p1cON0y
         HlvV5tTfxgYaSLuVN2CvYKXfjvuehUPBJ+MFj8fMBlOQgBobvjNXYaXJKLYklh2oGgWf
         8xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bm2bfrig1u8sdvSQGYkmziO995BytTCx2B7Yh/bdjcY=;
        b=XYymQGviIuJxn/QcRv4KC6NyafMHwuTyMxpJlOMH9Kf/MOhyDNdgxhG0l883jfAzsq
         5XdL36Whoj23ag9GjxicNoYi0djfM4BlSGZ91T23lnGBm1Z66V8lK2l6IJZ6oJM4Y0gn
         r+0fdI0tv1UHqISHyrV68TTLHFRyuztx9pgIBlH4zvFcaaimscKKhvzPd3+IqLcDCmJs
         bkgRKhR79k1DDljqzyrnE5g6MewHYDSRyokSEkZPYGg+IrN8DkYD9niWXCaQTZ3bVkGY
         XnKLY63AL5/jjpBKoZ0iOZhTmO0eC/UCNt+saAGstBGj3mVmQHn7JFihWletHyHRXSmh
         Z+2w==
X-Gm-Message-State: AHQUAuZ23x0xElnj4Dr/Xx+XufGZHaP8/0eQNnyvB8VwgHqMpZQsCUDs
        maaA891WP8/5Qy6qjsHibeHIIEhOEKE=
X-Google-Smtp-Source: AHgI3IaMpoMQbGtokpQePYbo6ODA+ABs+iuD91FziR3i8U+WHJpdmvAEC3tHXoXAesqRKF4h+TTNAg==
X-Received: by 2002:a17:906:d288:: with SMTP id ay8mr5468223ejb.59.1549411892598;
        Tue, 05 Feb 2019 16:11:32 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:32 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 17/32] x86/vdso2c: Sort vdso entries by addresses for linker script
Date:   Wed,  6 Feb 2019 00:10:51 +0000
Message-Id: <20190206001107.16488-18-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two linker scripts for vdso .so(s):
- *-timens.lds for building vdso for processes inside time namespace
  (it has bigger functions and needs to build firstly)
- *.lds for host processes vdso
  (it has smaller functions and entry addresses should be adjusted
  with the linker script magic to fit with entries from timens)

To adjust entries on host vdso, *.lds includes *.entries.
Those are generated by vdso2c while parsing timens vdso.

Linker doesn't allow going back on some addresses, so sort entries
to timens VDSO before writing them to .entries file.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.c | 13 +++++++++++++
 arch/x86/entry/vdso/vdso2c.h | 20 +++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 72731c4cfdce..4f91640398b2 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -119,6 +119,19 @@ static void fail(const char *format, ...)
 	va_end(ap);
 }
 
+struct vdso_entry {
+	unsigned long addr;
+	const char *name;
+};
+
+static int entry_addr_cmp(const void *_a, const void *_b)
+{
+	const struct vdso_entry *a = _a;
+	const struct vdso_entry *b = _b;
+
+	return (a->addr < b->addr) - (a->addr > b->addr);
+}
+
 /*
  * Evil macros for little-endian reads and writes
  */
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 065dac6c29c8..50566dd94451 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -21,6 +21,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
 	const char *secstrings;
 	INT_BITS syms[NSYMS] = {};
+	struct vdso_entry *entries, *next_entry;
 
 	ELF(Phdr) *pt = (ELF(Phdr) *)(raw_addr + GET_LE(&hdr->e_phoff));
 
@@ -88,6 +89,10 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		GET_LE(&hdr->e_shentsize) * GET_LE(&symtab_hdr->sh_link);
 
 	syms_nr = GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
+	entries = calloc(syms_nr, sizeof(*entries));
+	if (!entries)
+		fail("malloc()\n");
+	next_entry = entries;
 	/* Walk the symbol table */
 	for (i = 0; i < syms_nr; i++) {
 		unsigned int k;
@@ -122,11 +127,20 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		if (ELF_FUNC(ST_TYPE, sym->st_info) != STT_FUNC)
 			continue;
 
-		fprintf(out_entries_lds, "\t\t. = ABSOLUTE(%#lx);\n",
-				(unsigned long)GET_LE(&sym->st_value));
-		fprintf(out_entries_lds, "\t\t*(.text.%s*)\n", name);
+		next_entry->addr = GET_LE(&sym->st_value);
+		next_entry->name = name;
+		next_entry++;
 	}
 
+	qsort(entries, next_entry - entries, sizeof(*entries), entry_addr_cmp);
+
+	while (next_entry != entries && out_entries_lds) {
+		next_entry--;
+		fprintf(out_entries_lds, "\t\t. = ABSOLUTE(%#lx);\n\t\t*(.text.%s*)\n",
+			next_entry->addr, next_entry->name);
+	}
+	free(entries);
+
 	/* Validate mapping addresses. */
 	for (i = 0; i < sizeof(special_pages) / sizeof(special_pages[0]); i++) {
 		INT_BITS symval = syms[special_pages[i]];
-- 
2.20.1

