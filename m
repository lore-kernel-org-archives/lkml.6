Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpN9RnrhE0UH/W7aK5IwnlLDtc10C1MqltwVVfvx2ZMIP0o4g8ki6vb2VSiEGAe7cUQrM67
ARC-Seal: i=1; a=rsa-sha256; t=1526280595; cv=none;
        d=google.com; s=arc-20160816;
        b=N286nurERnqw34dBajTSAxXTgGYSKOGCdU+EUwPdEGMh5vX/b+n5jf5yb6F1Un3nqc
         oAlKAZ2ZdT+mgpoYhuBgi1xyPNOTw3VoahMDUlQqeg08ZHZLw7BtDn1vLCWj4SueIRn/
         XveRn4oKphNyHc/KZ+yX7iUFuYJMDiS5AryHXzv6RlhVFH4UnHcrDwKur/9LjEDROQHq
         VUFhWj0A3vEdFSV3sBnfJQrQBHMUJYgxUaLo1uXpLpXQD0mqdrSpjQC+vc4JPG9kEBth
         LKNPL73anUfYE1xkINHufzdfAbz7GyKflDeHPLgycjYW9vTU3Qw1JJ4JC8Benw6WjjaF
         i6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=95JgR/cCMwLcmY0Wy5y5NuESw6EFSOC3EL6iOVlsBXs=;
        b=vMwOOz83yWtMdHBKWHa01YkSFiWsAd79aR2OoJBgUAq4HRlYZElTnL+gOSxOv2OweR
         L6JLXYuck0CJzwPnr6QRGQmdg77zojQl6hkytYaM0FTgsDFrs/KBI/DF8DdKsOVQ8et5
         KVk4wODnaK+dEVT7OCjEACPNaRz0iAQugsj3EiwVxcqVS1r8/BIsgM40eJmaGKXLn9r+
         APTbSxAeux5NbQ2CdUjNVE4KwJa2okufan/Ia8JkWVn5g+IyRVHcN9nZ3DZhbR+V3tPd
         XvvlAjWu/qQl42i5fykaX6JbunMARN3dVmhL8UDIzeHI+nKEp9LelEzRPEyUq+4Q6xfV
         aNAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rkAHuY7o;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rkAHuY7o;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3.18 10/23] USB: serial: visor: handle potential invalid device configuration
Date: Mon, 14 May 2018 08:48:39 +0200
Message-Id: <20180514064704.497600777@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421202448697883?=
X-GMAIL-MSGID: =?utf-8?q?1600421202448697883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -338,47 +338,48 @@ static int palm_os_3_probe(struct usb_se
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
 
