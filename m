Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225o/011GVvLCHKKyjU+U4XPV6x0+uF+tjo2R/I3jMrA/rI8MKNGpy7LuwfmF2TxKOF2qVrx
ARC-Seal: i=1; a=rsa-sha256; t=1519218676; cv=none;
        d=google.com; s=arc-20160816;
        b=dOm2lgTxkTqPFrhqoCNR8T7fhMWXr0x7uLxIbYxZ54EqQLkvYCZ2LPpRs/iTR0FYHB
         P6TlYP5+toZ4rz2Hv8THjU2k3AWWCWBsljB69Q9YcKz0CV7sDA5rxsgFK5dKOSjLCJMo
         QI3tReGiQQh8SPpDCwueeHwFZc+TUbalb0LaifwhpGeeEMQggrDxC7Ny7pLc+52Qo3JM
         b+ThJjGJ8KS9skEG+U4Qx9Q2r9di95e23SeKPs7bxZ+tjKmLIJAsEqWSatd8OQ8en/EE
         /0uEw7yf/TefOa4JAZu5wK02QSQ7NccmwiSHSPHGtGFLVarsXvubQiwtQygmH+MBdnHP
         gDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Mtd7ZOzmarsTz80pEViqRLcNd/ScEk4BTZFljAiWY/o=;
        b=0ealFl5Ep2SiIh4+WZaCBIOtjCtYbM0ujC7fQZunhfLim9Ai7WtQS8M5KkcwVwlR2J
         cUp5Vxzs/vzC+I6VKvzkGGiNCYHhpbqtKeHomNKCMpxSKwIBxrv18DUjWTLGG4WULC8E
         9krlJGy9vB6KR3FU6vIu6pRjewluVhZ7MZARd3y0Um+cKgxS87eyddG1yVXZMfUOVA+s
         U3CzRv6jWo771KDEOMRA4EsJxMWCjwEvD4cbw10ux+Urk2VPCZsRYEmyYtZoqmPJKiM6
         YZ4ORxsJy9xSa3qaaHVWGKmRwyJvFEqbSs7jUPvLgBYDX5O36JEghNQhudROgpdQc43e
         v1Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Simon Gaiser <simon@invisiblethingslab.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 4.15 122/163] xen: Fix {set,clear}_foreign_p2m_mapping on autotranslating guests
Date: Wed, 21 Feb 2018 13:49:11 +0100
Message-Id: <20180221124536.845877001@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015731101166414?=
X-GMAIL-MSGID: =?utf-8?q?1593016242227288790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Gaiser <simon@invisiblethingslab.com>

commit 781198f1f373c3e350dbeb3af04a7d4c81c1b8d7 upstream.

Commit 82616f9599a7 ("xen: remove tests for pvh mode in pure pv paths")
removed the check for autotranslation from {set,clear}_foreign_p2m_mapping
but those are called by grant-table.c also on PVH/HVM guests.

Cc: <stable@vger.kernel.org> # 4.14
Fixes: 82616f9599a7 ("xen: remove tests for pvh mode in pure pv paths")
Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/p2m.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -694,6 +694,9 @@ int set_foreign_p2m_mapping(struct gntta
 	int i, ret = 0;
 	pte_t *pte;
 
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return 0;
+
 	if (kmap_ops) {
 		ret = HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref,
 						kmap_ops, count);
@@ -736,6 +739,9 @@ int clear_foreign_p2m_mapping(struct gnt
 {
 	int i, ret = 0;
 
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return 0;
+
 	for (i = 0; i < count; i++) {
 		unsigned long mfn = __pfn_to_mfn(page_to_pfn(pages[i]));
 		unsigned long pfn = page_to_pfn(pages[i]);
