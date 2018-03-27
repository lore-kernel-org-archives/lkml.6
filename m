Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48M3l54g/EfFG8ZsFjCv1rMCZ4Bgewlev4Yh/0snOuZmMWUXXg4nmdEBRjRObMEnAkRqlHU
ARC-Seal: i=1; a=rsa-sha256; t=1522168925; cv=none;
        d=google.com; s=arc-20160816;
        b=VC4yENEAY9kYBDXFwxvEx70QoPAvmxcXjTb1weM2ogiaYF3eS6TBOT4tXDjxdIp/Le
         WFk/wT0HtoH8pLSQofzN86U3epwHJLWZOpBcnt8AwiAo6nmJsxiiEgHGgS3eAEtw7ID7
         /O/8ADqKpxOwwgojyfHoDmu+SYkzkuL18VhUZGTfurByBc+LtlC/ylOtocciB4dqGDs9
         21LP3zMnym3laPeiARkatSlxcE2qvYZUtlS6ijMK0pvo8FiQVSQZUromQnfFIgUqQZ/t
         HKhTtgeCLFxh4MQCQ7p+/4d9d1LIyTMJ7qguHWss4jRkx0rJQ8fDwAlr0BncoMIshdNd
         W4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AYgwGhos/HhMRwiVglsW7xamwJRYQXYWSOK6sUuxhT0=;
        b=OQHPSGqkjdVD2R36G9N0jv68s1JeIuLGhF5YKxHkgwv+4dO9+54f8eMMDU08BYTNnX
         yDeGbcXGuwDRJuTGb5r4U18jHXEPr2l/nX75kRCSGw5DtDXjAyoYWproyZGdSn1mLR53
         Bm41KXenbKuv5tdJAFxqopy1pBsQwLCvJlFWJNiHEYvlROxw939wNF4o9PLRzeFXJb+J
         YmpxzPNgYTRPqTS5hADjZPfCbiBaPV+7IqTu7yNc126hF+m/kYRGI8kV2wTv0+RCMO1C
         IT4OYIpeiUgWHhVoBrG/1GX6C18SnVsMM0YNYrck5MLWFjUMSBYf3e1XTgrIrKSQIMsb
         Npng==
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
Subject: [PATCH 4.15 082/105] tty: vt: fix up tabstops properly
Date: Tue, 27 Mar 2018 18:28:02 +0200
Message-Id: <20180327162803.352968439@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109032191105201?=
X-GMAIL-MSGID: =?utf-8?q?1596109803252183313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
