Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrg/qnTwG5dm3ol78vjVqHaDR5TjYcMgwShf/cq4njWjcXUCkwE+Cp2FQ3PZhdgSKNc4f7F
ARC-Seal: i=1; a=rsa-sha256; t=1525767225; cv=none;
        d=google.com; s=arc-20160816;
        b=pkfw4rFKQ390Uv9qAgEY054hJikU4yEOy0n8jj7fWenYs9/AmOVfFeDG+7YuUGPfrd
         Y8PRqMImOG8FvpYKXbLw+L/MmpAXHtMg6Gobhnlt8kdkDSjXS8qz7LMZ+it+2fAeMfa7
         WMZfGAnhiMr0+W5xb4n0G0V2TfXhNSWxg9LgEQkCyh7b0iEr0sOoK6jo0aoBkhiUPN2U
         TmNMjz7TZ6zp5udEx9CS0QTGxomdA52PGkhhftU7QOipqE81nnWzIFdR8eB8tTQ2seX9
         9ODGT+iluLfPtIEm2fFmFpDh8wz/ldg0GG4wlgHoS4k2CWXgsv5ngNNnlykk98OwvtBj
         i52w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6GGMnjzrmp8BO8Bosz4uEF9yu9+c4C15keqf0kmDaGE=;
        b=q0wB8W9W8vs8aIgoHL9AU4JmUdxdji0B9dGpTCShhhKaPSG7cSQummJiQH5oifBrAT
         lpklfBRJuWePeTWacB7safgnLmrqOf+JoQN+jRexokpobCgg9CmEBzQ4HnXi1kHtc6ad
         gC8ReXD56tF7V4V7eynlbv2l/D99wT5VfYYgKgv2qCn7rPpntfHtUEEUEWTNuGaoanRO
         x5a2emBDXRIPEyxKcyp7YlJVrGgZAtcrAB35lQTKUGGvpjml2MmVk4MoJ1ez06krvM/E
         q0X66RHcf5mQl6NAVgnIVED0Q3EMkgJBp7OwAfbk1cfwz4ZABe0wpZD2JTfGW6YyPjvN
         +Tgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IuNo24B7;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IuNo24B7;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.16 36/52] USB: serial: visor: handle potential invalid device configuration
Date: Tue,  8 May 2018 10:10:34 +0200
Message-Id: <20180508073933.167258455@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882894176244438?=
X-GMAIL-MSGID: =?utf-8?q?1599882894176244438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 4842ed5bfcb9daf6660537d70503c18d38dbdbb8 upstream.

If we get an invalid device configuration from a palm 3 type device, we
might incorrectly parse things, and we have the potential to crash in
"interesting" ways.

Fix this up by verifying the size of the configuration passed to us by
the device, and only if it is correct, will we handle it.

Note that this also fixes an information leak of slab data.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ johan: add comment about the info leak ]
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/visor.c |   69 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

--- a/drivers/usb/serial/visor.c
+++ b/drivers/usb/serial/visor.c
@@ -335,47 +335,48 @@ static int palm_os_3_probe(struct usb_se
 		goto exit;
 	}
 
-	if (retval == sizeof(*connection_info)) {
-			connection_info = (struct visor_connection_info *)
-							transfer_buffer;
-
-		num_ports = le16_to_cpu(connection_info->num_ports);
-		for (i = 0; i < num_ports; ++i) {
-			switch (
-			   connection_info->connections[i].port_function_id) {
-			case VISOR_FUNCTION_GENERIC:
-				string = "Generic";
-				break;
-			case VISOR_FUNCTION_DEBUGGER:
-				string = "Debugger";
-				break;
-			case VISOR_FUNCTION_HOTSYNC:
-				string = "HotSync";
-				break;
-			case VISOR_FUNCTION_CONSOLE:
-				string = "Console";
-				break;
-			case VISOR_FUNCTION_REMOTE_FILE_SYS:
-				string = "Remote File System";
-				break;
-			default:
-				string = "unknown";
-				break;
-			}
-			dev_info(dev, "%s: port %d, is for %s use\n",
-				serial->type->description,
-				connection_info->connections[i].port, string);
-		}
+	if (retval != sizeof(*connection_info)) {
+		dev_err(dev, "Invalid connection information received from device\n");
+		retval = -ENODEV;
+		goto exit;
 	}
-	/*
-	* Handle devices that report invalid stuff here.
-	*/
+
+	connection_info = (struct visor_connection_info *)transfer_buffer;
+
+	num_ports = le16_to_cpu(connection_info->num_ports);
+
+	/* Handle devices that report invalid stuff here. */
 	if (num_ports == 0 || num_ports > 2) {
 		dev_warn(dev, "%s: No valid connect info available\n",
 			serial->type->description);
 		num_ports = 2;
 	}
 
+	for (i = 0; i < num_ports; ++i) {
+		switch (connection_info->connections[i].port_function_id) {
+		case VISOR_FUNCTION_GENERIC:
+			string = "Generic";
+			break;
+		case VISOR_FUNCTION_DEBUGGER:
+			string = "Debugger";
+			break;
+		case VISOR_FUNCTION_HOTSYNC:
+			string = "HotSync";
+			break;
+		case VISOR_FUNCTION_CONSOLE:
+			string = "Console";
+			break;
+		case VISOR_FUNCTION_REMOTE_FILE_SYS:
+			string = "Remote File System";
+			break;
+		default:
+			string = "unknown";
+			break;
+		}
+		dev_info(dev, "%s: port %d, is for %s use\n",
+			serial->type->description,
+			connection_info->connections[i].port, string);
+	}
 	dev_info(dev, "%s: Number of ports: %d\n", serial->type->description,
 		num_ports);
 
