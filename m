Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49E5cuQuGeVovNsb9M76S07OjS63jDfjR5N1pwa4QU6QH0uLLtMg599xI+DaxGfQ5NPnPF3
ARC-Seal: i=1; a=rsa-sha256; t=1523021219; cv=none;
        d=google.com; s=arc-20160816;
        b=sGzV1/FAJXrEALCCRsz42eVhQL/T8hlhTQsTzNUtzxnHXtrrDymWOiukNF5L8P9RkP
         nmJ73Bb7UC99iuN/+puFZUKIxiDR40juUmCNFM4Vn1QG4THsELGo/mKCSlj1usnju1Wl
         LN6gctapecB/BWGRaC5JteyOj+O8UOzpWx/z5VA45/U+PkEVEnkbTZ62uaHB8Pb2SoSw
         OFy6N5HoJ1gEa1lW7FQs0expMYgWg5uyHWJn3AVEeZZprLqdWi9PYn5HCWgTQuob2BXV
         h9AGRXk59v3pVEH1QcxWBOeVOKLvwoFw1pMYbYy998A0S7P9CEwsedyNGZj5wRyJxgeT
         pJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X26HQcrq+GaiHxx43zopS2kYjsQuDFfVQT8GZlWZwl4=;
        b=Wpx4aKrCHwUh+G+/hSy3FdM5gkhtLS5cB/TN+/9/p/E9MFiQ/dnLZMnynVTIKPFO3I
         hR977wfKJMYxfZo4rmtkS43LR7gJHrT9TcsqM+jWWW31Iz59jnY/kvm0xafYuu0IpcwF
         K/3AGB5MUahqtm/JsJwgJ4D7QkjZM14K14wCxOfv8gGIm7Hn1bBsFMRCEEoJfIGPOTy0
         IF+eGWGfyvc5ekTXKPar5eFH9JUjGpiN/8UGTztNEOJvoi3zAEE2CUWZIKctX4cLq8Sa
         Rs5qqK5HsINgaOSOaoK8exnpp5F280qpb05sai8WwrAGrC1SdLlK7m9nn6qvvZtIKgZb
         LzVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Holderness <j4_james@hotmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 19/93] tty: vt: fix up tabstops properly
Date: Fri,  6 Apr 2018 15:22:48 +0200
Message-Id: <20180406084225.819385537@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003498229230777?=
X-GMAIL-MSGID: =?utf-8?q?1597003498229230777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit f1869a890cdedb92a3fab969db5d0fd982850273 upstream.

Tabs on a console with long lines do not wrap properly, so correctly
account for the line length when computing the tab placement location.

Reported-by: James Holderness <j4_james@hotmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1705,7 +1705,7 @@ static void reset_terminal(struct vc_dat
 	default_attr(vc);
 	update_attr(vc);
 
-	vc->vc_tab_stop[0]	= 0x01010100;
+	vc->vc_tab_stop[0]	=
 	vc->vc_tab_stop[1]	=
 	vc->vc_tab_stop[2]	=
 	vc->vc_tab_stop[3]	=
@@ -1748,7 +1748,7 @@ static void do_con_trol(struct tty_struc
 		vc->vc_pos -= (vc->vc_x << 1);
 		while (vc->vc_x < vc->vc_cols - 1) {
 			vc->vc_x++;
-			if (vc->vc_tab_stop[vc->vc_x >> 5] & (1 << (vc->vc_x & 31)))
+			if (vc->vc_tab_stop[7 & (vc->vc_x >> 5)] & (1 << (vc->vc_x & 31)))
 				break;
 		}
 		vc->vc_pos += (vc->vc_x << 1);
@@ -1808,7 +1808,7 @@ static void do_con_trol(struct tty_struc
 			lf(vc);
 			return;
 		case 'H':
-			vc->vc_tab_stop[vc->vc_x >> 5] |= (1 << (vc->vc_x & 31));
+			vc->vc_tab_stop[7 & (vc->vc_x >> 5)] |= (1 << (vc->vc_x & 31));
 			return;
 		case 'Z':
 			respond_ID(tty);
@@ -2001,7 +2001,7 @@ static void do_con_trol(struct tty_struc
 			return;
 		case 'g':
 			if (!vc->vc_par[0])
-				vc->vc_tab_stop[vc->vc_x >> 5] &= ~(1 << (vc->vc_x & 31));
+				vc->vc_tab_stop[7 & (vc->vc_x >> 5)] &= ~(1 << (vc->vc_x & 31));
 			else if (vc->vc_par[0] == 3) {
 				vc->vc_tab_stop[0] =
 					vc->vc_tab_stop[1] =
