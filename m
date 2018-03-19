Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv7FM+cvHbrA/ae1q1yvY8rpl8J2H/NQsa0Wq6XpAqJOz/NvsiJYNlGWT5S5OOC9Dr6leRh
ARC-Seal: i=1; a=rsa-sha256; t=1521483204; cv=none;
        d=google.com; s=arc-20160816;
        b=mAB++O6++sHkPxhfG90nkkibZrsBrKqmnSiLF1FRtUpjKhfxmFodGS2FzadWWN13xF
         LJyBwGT1rfl6kgoUl7tKUJ4NJWh2Jvi5PlIFQGZ6Pr2rLE+aw7VHW9GffcoTdLfU6U6V
         NaIpgsA+kQJSLVE6mXzqdFZX6GuNoU2A56S4t/+BWqKMvFX/BKso7OKuYxMYlOpgddtF
         mjE/pDl2lCdl7IO0Gf1GibF0gYJzIqNk8NTIVKi9OYfR2iw9iJ1I6tSQu2NRX238nn+2
         A9uuXXiXmFbC5Us4JEwt323x3HqgHR2a2/LHemZ/TAr433lJVSVvjv/2VUU2q/3nGxqM
         qwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oS25TT2OBY5UG6qvI99+mjFuEtTJ6tkchI5TNYDgKOk=;
        b=yg831kJdctTVuvNBoZpK+SYS8XWw2VlFO1qrSAdaE3pDpQwt8b9Cl+jj5QMw9/m+JJ
         65cs/XMgkpwAxli2DeYpCOZcDJDUOVGxMNv9/EYI+ndYXJhSqcRdZNZabd+aObTirV2C
         z7CGdcebe01jhJBF1PeTF1jRjrH6W+U5AChmUgA8lEqbyEwBLZuYD9WEU9UgOHW0j0cf
         kZ971+16roeuI3WOXruUH0tSSWENax+BDDeXItmfY9JEJ127v5Ac9+zXi3zpo+f4tOul
         yK91EyH54awfUpAH+jAe9M23KTTJVznr5li8fCmr3xZPyEx/Ji6Nqhemp3ra7J6vNQuN
         mOuw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Valtteri=20Heikkil=C3=A4?= <rnd@nic.fi>,
	Tomasz Kramkowski <tk@the-tk.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 005/134] HID: reject input outside logical range only if null state is set
Date: Mon, 19 Mar 2018 19:04:48 +0100
Message-Id: <20180319171849.851555820@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390526332956938?=
X-GMAIL-MSGID: =?utf-8?q?1595390772616416334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Valtteri Heikkil‰" <rnd@nic.fi>


[ Upstream commit 3f3752705dbd50b66b66ad7b4d54fe33d2f746ed ]

This patch fixes an issue in drivers/hid/hid-input.c where USB HID
control null state flag is not checked upon rejecting inputs outside
logical minimum-maximum range. The check should be made according to USB
HID specification 1.11, section 6.2.2.5, p.31. The fix will resolve
issues with some game controllers, such as:
https://bugzilla.kernel.org/show_bug.cgi?id=68621

[tk@the-tk.com: shortened and fixed spelling in commit message]
Signed-off-by: Valtteri Heikkil√§ <rnd@nic.fi>
Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-input.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1135,6 +1135,7 @@ void hidinput_hid_event(struct hid_devic
 	 * don't specify logical min and max.
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
+	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
 	    (field->logical_minimum < field->logical_maximum) &&
 	    (value < field->logical_minimum ||
 	     value > field->logical_maximum)) {
