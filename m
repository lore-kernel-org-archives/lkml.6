Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48oxspiMdECjclu10gkSGNhhAc06rbrvgL1a+jhgfLuk2THSSwOYxPhwxxYQay7MYL0zApn
ARC-Seal: i=1; a=rsa-sha256; t=1524406891; cv=none;
        d=google.com; s=arc-20160816;
        b=E5rhW2Zsf7xwGTYn48qPnQTd14xXji3zOa/yMF/SGHv8LHNnicz4L7tp7IhGwtugTB
         Nr9lnCHrVV0JtAAv1jTqYlEp7hPDYJNMK1dHMvsrPbYgNLlQsjEqR9pr3RutOFpmEOsF
         GQK3Ds1dpvDwcClOht0oOig5FXa2k2AiUcHEb2A88uOwiLW+jzD/RMKIUrFQOGi2GgjA
         2pDJ+qKwq9lokET7Nb+A5kcObEeEdmtkNA2d7W3vLZjXoeVbParOkyqm+BvXr/aubgxW
         JYD9hPxiWTWQ5ROGdQpiI69o86FFPoN4u8AahioBzRHuoqjeyUFdxiWaHSSiQH3bGB5C
         oYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0Uju3BFDEBwIxbursc0qcB5JeKDrQpm0YxnyoUT+MS8=;
        b=Il8WCCVZ+y3g4HbvipH+zkozvm48VfZH8MkGhZFkcLlxoGK9/e4Fxm/g8S6lQLT60z
         MwdymjiTIfkV5jdll90+QEu0yvNCr2JHWEK05IGdQZdP2FI9I6iqs/NLiAOQ8PFG/rEd
         K1/1hArSVYaObPY24GXpAZDkaILIpQH9zWbQu8ad+wmlb1PBrVMCONYxmiVKNsFQy4tu
         QML9zdrx66sLeWDe9tfsfacd2aQtbRA7hX3Qu00PjyQE5rriBQOD77OhySTWNgTpJTDj
         XY99eTlzvCIhfA0G8ExLPiXaylNsP2r8vEdowdaKaNngFUY45oil3Z6glS2OI/SV9ZDy
         N3fA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 3.18 42/52] HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device
Date: Sun, 22 Apr 2018 15:54:15 +0200
Message-Id: <20180422135317.319690304@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455251173047528?=
X-GMAIL-MSGID: =?utf-8?q?1598456480796266264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>

commit a955358d54695e4ad9f7d6489a7ac4d69a8fc711 upstream.

Doing `ioctl(HIDIOCGFEATURE)` in a tight loop on a hidraw device
and then disconnecting the device, or unloading the driver, can
cause a NULL pointer dereference.

When a hidraw device is destroyed it sets 0 to `dev->exist`.
Most functions check 'dev->exist' before doing its work, but
`hidraw_get_report()` was missing that check.

Cc: stable@vger.kernel.org
Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hidraw.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -197,6 +197,11 @@ static ssize_t hidraw_get_report(struct
 	int ret = 0, len;
 	unsigned char report_number;
 
+	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	dev = hidraw_table[minor]->hid;
 
 	if (!dev->ll_driver->raw_request) {
