Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqvUarXT0+n5TjE60RP+9MKau955fFcn6EWhbEAjOxhfW86LjckwEi4ictnExwNo6Ud7m4V
ARC-Seal: i=1; a=rsa-sha256; t=1525116412; cv=none;
        d=google.com; s=arc-20160816;
        b=0u2tiNeZ7vgFVN6kEwwzizM56MUMEEQ2CApx511iQptqUoyC/473KAW+P4G+4Ft4/J
         e00QhEgCuXZXj5tEijlBsRpRO1XyKk4O/byQeDHEt9nypSU/GlOJlI9kCxEFfVIq4tOI
         tdgX5Y7RvtR2fx9po3fLPzxOrPRlbOFEkqfEln+TDI0SqsyXdME9OtAnopEQOrDujI2H
         U/xa7sq3hGn9zdgraofL+gkfK7Bsy77aqbQNaMbNWMqnM044Fn8OlSUo6rJr0/Sfvk6Z
         d7i8s1YsPjcrYvp3VZoNPHuhZhtUj6L7dPTbVz5eYBdT1l0KhaGmsSn+uyaMm4C8cehq
         bpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=jivmbtgVWs/C1eY0xQpYGguoV1B8XAA3lLghk9SLxe8=;
        b=o6JzqFu8D/rOxwbUctp51bvSEN2dZ1cRRo7oa+BNOBgDHU+xjvODOKQaIAvwi+38uV
         647c6UaSe8HYKDSG6fFr3DRIXlYb5WyP09OSNcXmNrXP8bf2ngTzfPnvi4J5CdSTHCyE
         pLj+1Dpxegmm8D25sVJe+ZLnb7dPTw52gGKJJWMaT019EaqlDQhgnO71bI6/5iTPhYHs
         WxOdCJ4pYQUN18vLVTilDPmIkPo13s30BvMVhkWv2YdOvtW27w+aSA/0D2VNp16JJ1j7
         aPerxtG485MWNSKDoeJNTWh9ecFVZ67Pxn68ZJuPQjSk/q+YpJcV+pyQJIbvif2Rstq7
         fcWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C3122DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.9 46/61] ARM: amba: Dont read past the end of sysfs "driver_override" buffer
Date: Mon, 30 Apr 2018 12:24:49 -0700
Message-Id: <20180430183955.253660569@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200467272175726?=
X-GMAIL-MSGID: =?utf-8?q?1599200467272175726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit d2ffed5185df9d8d9ccd150e4340e3b6f96a8381 upstream.

When printing the driver_override parameter when it is 4095 and 4094
bytes long, the printing code would access invalid memory because we
need count + 1 bytes for printing.

Cfr. commits 4efe874aace57dba ("PCI: Don't read past the end of sysfs
"driver_override" buffer") and bf563b01c2895a4b ("driver core: platform:
Don't read past the end of "driver_override" buffer").

Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/amba/bus.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -84,7 +84,8 @@ static ssize_t driver_override_store(str
 	struct amba_device *dev = to_amba_device(_dev);
 	char *driver_override, *old, *cp;
 
-	if (count > PATH_MAX)
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
 	driver_override = kstrndup(buf, count, GFP_KERNEL);
