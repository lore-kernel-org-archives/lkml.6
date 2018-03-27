Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48+xyisaXiCtOz8jhaenqOcGFQi2RpqZPNL3oEnu36OaTglJPS0Q0kNm0+bjHW2aQzSWW9G
ARC-Seal: i=1; a=rsa-sha256; t=1522168630; cv=none;
        d=google.com; s=arc-20160816;
        b=DWB5QSHyYbp+nBL7SWvRpU2jXouMiEnUPRghThcj3whaBRdkBJP0kDX28Z0XercgV/
         NHrD1a8IK3VYBx4jV5A225i9AZWJD24KtvlvCTDn86GMXRpdgY/7/94BVcdmJiV2Sjp2
         XS7eG1WeB45DhlxdP5+T5DEj3I4pO4tZGIIwMFPn04GvS8gx7cmtArVFpaoykxOY+Yve
         NgDWT8tui0YtcgOK8Oqf354n60omnYJMpAjjvo1C8r7tWNyyRUNbMifLcLiD+GGlyANo
         +E5735nChMm2ksuxqUlXdiEYzSmRhxGkbiIDALC79USnwbnrPA4sPwrAnylPHRUPYAZD
         sc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KhPsUS08KnmLBtHa+jIs4vLlC8pOjhPA+Sd2WJ1nZ4Y=;
        b=jKIFdU5/w/nQ95E93zRDhDh1bZ+L/o1r6UoTwhcHIUPLrt/IUMPcT2vAgoPlD40ca1
         04aaYzW1MN/hNOWsRo1EqFQFh+TtUDYTw0r/WFSH/gZItzZ3COneNtfWmuZ2pXQeYOWe
         4jU1pZ7kfAFEDV37mb2zY2nbwmO5hUoi/lCiAo2A4zaoP+bT3l2Kk6zok8Hl61MWn/ms
         aNh8+FZdS9t+dN6YLRtulqSuvJivy00k72cqnHltG5Q9vrMjihZ7CcwnkCM0Mdan/jeF
         7GwCN+2Dj/uIrcpe4CULVUK0nlQXJbCuIJqQ2I8BfWwpX7F+Q9UJ6Ngc0nN/sMPbd8KJ
         DV3w==
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
Subject: [PATCH 4.14 077/101] tty: vt: fix up tabstops properly
Date: Tue, 27 Mar 2018 18:27:49 +0200
Message-Id: <20180327162754.810703237@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109032191105201?=
X-GMAIL-MSGID: =?utf-8?q?1596109493731505518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1725,7 +1725,7 @@ static void reset_terminal(struct vc_dat
 	default_attr(vc);
 	update_attr(vc);
 
-	vc->vc_tab_stop[0]	= 0x01010100;
+	vc->vc_tab_stop[0]	=
 	vc->vc_tab_stop[1]	=
 	vc->vc_tab_stop[2]	=
 	vc->vc_tab_stop[3]	=
@@ -1769,7 +1769,7 @@ static void do_con_trol(struct tty_struc
 		vc->vc_pos -= (vc->vc_x << 1);
 		while (vc->vc_x < vc->vc_cols - 1) {
 			vc->vc_x++;
-			if (vc->vc_tab_stop[vc->vc_x >> 5] & (1 << (vc->vc_x & 31)))
+			if (vc->vc_tab_stop[7 & (vc->vc_x >> 5)] & (1 << (vc->vc_x & 31)))
 				break;
 		}
 		vc->vc_pos += (vc->vc_x << 1);
@@ -1829,7 +1829,7 @@ static void do_con_trol(struct tty_struc
 			lf(vc);
 			return;
 		case 'H':
-			vc->vc_tab_stop[vc->vc_x >> 5] |= (1 << (vc->vc_x & 31));
+			vc->vc_tab_stop[7 & (vc->vc_x >> 5)] |= (1 << (vc->vc_x & 31));
 			return;
 		case 'Z':
 			respond_ID(tty);
@@ -2022,7 +2022,7 @@ static void do_con_trol(struct tty_struc
 			return;
 		case 'g':
 			if (!vc->vc_par[0])
-				vc->vc_tab_stop[vc->vc_x >> 5] &= ~(1 << (vc->vc_x & 31));
+				vc->vc_tab_stop[7 & (vc->vc_x >> 5)] &= ~(1 << (vc->vc_x & 31));
 			else if (vc->vc_par[0] == 3) {
 				vc->vc_tab_stop[0] =
 					vc->vc_tab_stop[1] =
