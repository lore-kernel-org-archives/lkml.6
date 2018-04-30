Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZofTGsOnhNpLld8pxYr6YxSeQQLMQ7lDcRMptBrPOnD3DbsTaW5c2T8q32otG1mZLwlltz7
ARC-Seal: i=1; a=rsa-sha256; t=1525116462; cv=none;
        d=google.com; s=arc-20160816;
        b=uFaPk0zN7oyWN4nLfRQf7Pp7uqSPabFbTOxcvNLCBTRkLU72lqDm4S/Rdn+YEGuSD2
         Ho49SdnUZMfs0w9cB4tXXYFd1PxQZphaobXU/u13coQfkXnourr033oWPq4C2qm0D1Y3
         zyQq7fFHK1uE9VzsabG9Ue1KlXhoRuU+zKaG8YnRQ/aCeCbu23U443uR75Cb4HE2t33h
         6l4TQfd6olulCvGSX9ES2sCW0ydIjzTK9WPN0y0WUSULl7b/NpjhGSoYDUD1BskGylmR
         sRmTPEswIqh3hgB9htDxMMgdh1qdqxpyXd70aVS8dwWvyo9IwsyeA2PJdfX8iwoSHGgz
         hXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=7WKLn29I1xOx1NK3P7DKgkLOCc8T4NFEyx0rAbeGMo0=;
        b=PbPu9aC5/SA8aWF6RIZgyi8U0ZvBM92mtKjMrOtRuW6UmORFZpzhen2inlmuH2Gz9q
         PYuGpaYEGPcVeZRj6PZWGFACsaUdH0D7PTtlaDe1NB7ZUmajiXUYJlQIHx0lEVlABPDc
         JyrdHrIj5XRGaCUbmdNgdSTJbjdYDjS87cuI6OKmbWeQkIx30ifPOhPxVrmwMtFpd4Vg
         Q6UGeoKdXt1tabrRwpEVl4aDjjERvF9khxnGcHHu5a6HA9OBpBRfsaOlaTX/ao2D2pcy
         17Vuht4ixEns+k5v1OjHHeN2DCxbGXJjhBPZfgaXsfXlU675I+BaF7uDxsQNfQnKLCJo
         fpdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C22422E72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.14 66/91] ARM: amba: Dont read past the end of sysfs "driver_override" buffer
Date: Mon, 30 Apr 2018 12:24:48 -0700
Message-Id: <20180430184007.599011308@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200467272175726?=
X-GMAIL-MSGID: =?utf-8?q?1599200519516904363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
