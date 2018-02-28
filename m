Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x226FdklPSZMjh+qTIDG2M9ojkivjakxXmO9AaWjPr4YQWLaXm94C9z0j1fITIpaFR1eMoMTl
ARC-Seal: i=1; a=rsa-sha256; t=1519831335; cv=none;
        d=google.com; s=arc-20160816;
        b=YPgucj6hUxn4x9Mug3Rds4/aIxx+y/DRSt42c+4dQ+CSM/YpShLtw/S7tJ9sVfbDDZ
         N8ZM7HPnBhKhJn9K6aGZAFLG9XnA5pY6vrNQghHHv1qnJ7846+JGGm+FnJGUeplqx7Ur
         jlLBTfLqEuMLkIOf84uUgTZpabbTRaqArSqqLYCmGuHBa5P56BvNc7KtrDz+rBCPYPKd
         i9/AeWgNj2c30P7BV7BZAvI9z4RPfOzrL6SBiKtq8vWCMyYBSwkXav2FhlNj0KQWUnMs
         OqD5j2yAvnfbfAse6bWl8bCp7lWd7AbX5koatl2FGJvEQfllFRfkjpWymXN/DsJUyiQG
         RqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=aaYgO1ccU17p+ngIB8/2f9+Dv/waaMsyqkBGC22OfI4=;
        b=CWXcUdVzj5YDgUtgcbmKFACN6KVB8cidHKoeokndbxscdaZFPzNFnNIlyYFpcOhyqU
         wnlfM3z01uG9i9nRaqa0GsBgKX4N+7UTedwA4JxYi/mYcVge+cLdbYh/4tHW5Td6DCfA
         zv0cO6T3D8q//LnMkM+XzF0uNwwA301q17zeMccEW6Ki8PdMQVBW3npWErpPQByxozYS
         X7lH7h5SANaM8k4Vd3tqMQEvW6LTBNFw4aVR+/W1ZMUs5AXUSd8sUTlp6L0YZwpJToVp
         inDo5C9SNUjPFyGfhELKQPv0d9J9oeTTKlfj8t4IvIRXjM+TpSx/gKh7WHL5N47QGMVJ
         ddng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Alan Stern" <stern@rowland.harvard.edu>,
 "Colin Ian King" <colin.king@canonical.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.540472503@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 015/140] usb: host: fix incorrect updating of offset
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658662601688064?=
X-GMAIL-MSGID: =?utf-8?q?1593658662601688064?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 1d5a31582ef046d3b233f0da1a68ae26519b2f0a upstream.

The variable temp is incorrectly being updated, instead it should
be offset otherwise the loop just reads the same capability value
and loops forever.  Thanks to Alan Stern for pointing out the
correct fix to my original fix.  Fix also cleans up clang warning:

drivers/usb/host/ehci-dbg.c:840:4: warning: Value stored to 'temp'
is never read

Fixes: d49d43174400 ("USB: misc ehci updates")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/ehci-dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -785,7 +785,7 @@ static ssize_t fill_registers_buffer(str
 			default:		/* unknown */
 				break;
 			}
-			temp = (cap >> 8) & 0xff;
+			offset = (cap >> 8) & 0xff;
 		}
 	}
 #endif
