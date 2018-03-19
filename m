Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtsofXrRVQhSIbNmUtXI14mKnFcD2cMk3Krp9SnmHsKqsfLHOoPJDiZfUm8SfBEgdWNy78H
ARC-Seal: i=1; a=rsa-sha256; t=1521483922; cv=none;
        d=google.com; s=arc-20160816;
        b=F/a5Sb8od+XIlX+kti031BOhpcLk05uUltwxFyZg5QcYN+q0HXO4LY4aiGYwsOHEsZ
         WyekuRHrunRRHZadNH0xn9N1EZh72tDJ0UQbKKWb6V+DK7W+WhAMLb0A4ONSnaD+FDsS
         8VM9fayfGIzIG0SK9q+GuLYNYW9TDYbBFVw3+XZ7YHYASPEBqPsrANiexpQG8i2xR5HR
         etfhLq3ICFJ8RqOa8HVH3QplcGI/a8qaEHDY1WRPcxewfEx2JSxbk6rXJef1jek+Ni7Q
         Du/ZwkvAHe5TZaRoFRoT0Tz519bbnMmxCHwvT1v1R86hPpw2X6b8ujNBq4vn1mc35yRx
         hLXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BU04hODEiKGJQYfMxCvcxyYYP570pjLvkrfpu8cisYo=;
        b=1AXvxeKOZubBi3DkSXdivOT/XIkpIBu4KGNwi1NDX/mLV5L1rS+c7dGH10q5Vyq1ed
         pM7pjtDiKdxPL01EWkdsftrTTnxFiBQ0JSCe+PaXJpb+ivOLCLqfOhB6klz6Xk561VvI
         TMF3UtqK+TeWDwBCOvdubn2PMAXWjp+vqJnvI9EWg1GRw6tHkbEo+xFeP4PTY/PUKzJT
         8JwrYWg/LpB01WukNS09DNKkbnKkthqRjprmdK82T4muNaB5IftNHReLQh28tiXF4QZr
         cfkRVWuIlEpuw3iuRQ3lErkxfnnbmSbGOY0dsJtU1PfJ+k53iYxZQMGWiP93W/OfVhWd
         /cNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 166/241] HID: elo: clear BTN_LEFT mapping
Date: Mon, 19 Mar 2018 19:07:11 +0100
Message-Id: <20180319180758.032392117@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390684316858028?=
X-GMAIL-MSGID: =?utf-8?q?1595391525842291269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>


[ Upstream commit 9abd04af951e5734c9d5cfee9b49790844b734cf ]

ELO devices have one Button usage in GenDesk field, which makes hid-input map
it to BTN_LEFT; that confuses userspace, which then considers the device to be
a mouse/touchpad instead of touchscreen.

Fix that by unmapping BTN_LEFT and keeping only BTN_TOUCH in place.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-elo.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -42,6 +42,12 @@ static int elo_input_configured(struct h
 {
 	struct input_dev *input = hidinput->input;
 
+	/*
+	 * ELO devices have one Button usage in GenDesk field, which makes
+	 * hid-input map it to BTN_LEFT; that confuses userspace, which then
+	 * considers the device to be a mouse/touchpad instead of touchscreen.
+	 */
+	clear_bit(BTN_LEFT, input->keybit);
 	set_bit(BTN_TOUCH, input->keybit);
 	set_bit(ABS_PRESSURE, input->absbit);
 	input_set_abs_params(input, ABS_PRESSURE, 0, 256, 0, 0);
