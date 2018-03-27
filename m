Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+jssgwC5us2T2SFSQS9/gb+NYVBG2HtDmSaXBhT/fA0HdqcKfHbRdKd5OWhl0VhFZge64d
ARC-Seal: i=1; a=rsa-sha256; t=1522168409; cv=none;
        d=google.com; s=arc-20160816;
        b=L1NCxEFyS7guHTAR/DEu6Rk1LveFtk4JE4/RzG3tGWJy/DPHfoaKrqmCrf7/PF4r9d
         UqswqJScWC1jt6H2uevwJ0PMGzItiYSysCkwT+YBuTz958ZMvVviZtZBlNofxF/JF37W
         9fCkPCQd/nVJQXj52DHvg4ptxWcF0qebrPvufir8/wNgAZir/Qw40b1y/8pSYRybiLYQ
         aZaRwWbJJ6rc6AqSllJEdj6vA4fYAkG8xtGq63KOpuU8CBkCtho0py1a8Y4Dhb0Bv/3Q
         tT39mmnXqeSiKiXCiGXySHDIRPAkRBSD80WUT3m4L566SxMiM2rH0W97VQ6yYEADAGDw
         MRag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rnHSVkc2Vek8v4g+qIQRZyZ5/QfR0DEARkrvs2qRUwQ=;
        b=jLmRVOEgKizjr/0483xH7CAWXHUGwq4Kg4nbBgVda3EbcWKQM4t5MKoWdshoVvB4Jv
         N/EIy5mcsoHW4TM+iO4M2Wq8FRTFa294baFwz9Tjp9JLz3D0tWv7OYbTH5JON9atRwUE
         yAO/3/lrG8pvfS6MppXMYRKJSKGlBk+PyLCPOqNCnGPKaV66w5lAvxSgPmNvUbgGHOix
         hOSGwJgQh0LhtcJ5SGJtUewRkw1pR6i6mxgxge77D2bUOL2iREr+nt0FKvcfMqoFc3dE
         3bAjK4ZZ7QfayFcx1NANc9fqcaboe3Yzdl9rxuHR5gi9cpowDJygGb/jsfv41OQ4FL61
         zufw==
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
Subject: [PATCH 4.9 48/67] tty: vt: fix up tabstops properly
Date: Tue, 27 Mar 2018 18:27:40 +0200
Message-Id: <20180327162729.950559791@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109032191105201?=
X-GMAIL-MSGID: =?utf-8?q?1596109262710003242?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1727,7 +1727,7 @@ static void reset_terminal(struct vc_dat
 	default_attr(vc);
 	update_attr(vc);
 
-	vc->vc_tab_stop[0]	= 0x01010100;
+	vc->vc_tab_stop[0]	=
 	vc->vc_tab_stop[1]	=
 	vc->vc_tab_stop[2]	=
 	vc->vc_tab_stop[3]	=
@@ -1771,7 +1771,7 @@ static void do_con_trol(struct tty_struc
 		vc->vc_pos -= (vc->vc_x << 1);
 		while (vc->vc_x < vc->vc_cols - 1) {
 			vc->vc_x++;
-			if (vc->vc_tab_stop[vc->vc_x >> 5] & (1 << (vc->vc_x & 31)))
+			if (vc->vc_tab_stop[7 & (vc->vc_x >> 5)] & (1 << (vc->vc_x & 31)))
 				break;
 		}
 		vc->vc_pos += (vc->vc_x << 1);
@@ -1831,7 +1831,7 @@ static void do_con_trol(struct tty_struc
 			lf(vc);
 			return;
 		case 'H':
-			vc->vc_tab_stop[vc->vc_x >> 5] |= (1 << (vc->vc_x & 31));
+			vc->vc_tab_stop[7 & (vc->vc_x >> 5)] |= (1 << (vc->vc_x & 31));
 			return;
 		case 'Z':
 			respond_ID(tty);
@@ -2024,7 +2024,7 @@ static void do_con_trol(struct tty_struc
 			return;
 		case 'g':
 			if (!vc->vc_par[0])
-				vc->vc_tab_stop[vc->vc_x >> 5] &= ~(1 << (vc->vc_x & 31));
+				vc->vc_tab_stop[7 & (vc->vc_x >> 5)] &= ~(1 << (vc->vc_x & 31));
 			else if (vc->vc_par[0] == 3) {
 				vc->vc_tab_stop[0] =
 					vc->vc_tab_stop[1] =
