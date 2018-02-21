Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2249QuNo6QVmRyRKnLdsuJEsJa+UNhatGf0Bu5RUr2LA6Wz/m0sikK/Zvoauh13EFS4pDdKU
ARC-Seal: i=1; a=rsa-sha256; t=1519218188; cv=none;
        d=google.com; s=arc-20160816;
        b=MIMf/BTZDad3Nj9EsfnpV44d3K4ii9FZf1BiXCSRDil/M6AgpPPklofjnM/j1GiGF5
         JQ4N9lDuoqfg+yIcm4G3XWowzQX6hhDArf2C3GKM77C9dnVxE5STyAkfs368yIPVp2AQ
         L1hbfpQpXN7X8nW2NqFBGqtF/Ll0gaKxl1hURP0ajYUog9AeINUTy4iLhBzehxpYUqPf
         c4vd/AENF91iQSb4eCU/IzsAqgdbn+K9oNm7rEiAgmEu34akdKZbZweOVyy3RZKbxGdv
         Jm/FcMRJ/UzbUVG7MKK86d7uscoGADF5WcaLaobFulD6fkNrYqkQ2E74CVHiofr+KW4s
         CWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SerRLLUxeNLXq6dQ496/TQeBvzHiqxRFzpUWJMQaEzo=;
        b=0Rd83SNB7pzM5Yfc0ZlrgkfPqpWbWbRjXJFms8NT7e9G7bJXmX9MrQQDMdlHKuBChi
         97CEVio8YUJfHUMy/oQsU80SyZlLBalDF5rL2xRu+vjJalJ7pf8Zr0A0oMwKcnd5svNE
         Y/O3WLn/NoWH4KLqHK2ipeq3pszNYrA4RGidLkmqCcIJw5/YV8yCgFCxgeGfXeLO+OWo
         TvJUU7APLqzBOd9Z1SZ9v39EjlJMYsxMPCzl7N92B1xztFc84d+izRlweZP4MV2en4NB
         IQ7heTMy+xA7cpFJ4WLCsj3DX12J2Z+3eWJ4aqQhwvxbOBJmdYQr7+XZvc2D19KiULFx
         cetw==
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
Subject: [PATCH 4.14 119/167] xen: Fix {set,clear}_foreign_p2m_mapping on autotranslating guests
Date: Wed, 21 Feb 2018 13:48:50 +0100
Message-Id: <20180221124531.004925786@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015731101166414?=
X-GMAIL-MSGID: =?utf-8?q?1593015731101166414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
