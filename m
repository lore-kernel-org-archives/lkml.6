Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqXUHOoFsbo6r8UN0TKPMgY5isRVqqtVHaeLuX7McbKG7HKrYQbFrfWqC4p0VWM2TpovPu4
ARC-Seal: i=1; a=rsa-sha256; t=1525116411; cv=none;
        d=google.com; s=arc-20160816;
        b=ne1cqOZpyw55lsQug5yWjoB/DvTsy9aHgBuDDttUrd6MBluxp8z/qg9xoQNUU9QBw0
         Ug1+hnyYcIS994DuMAggu0U3NpEi/E/BCK+kmcqIZVAgCC+yugvSKJrPUBlrcZVlEd9Y
         VBfJzAKUksq7zc3pLddbfqmflfl1L4IrKwPpVFFQ5t4zGv8F8eHYFwr7XDn2FeUXdA3A
         ARg1wt4Lo68+SiD5p5gk0iMLwxF+zD/OkEDmKbCtqQjNZGNPHdl6jRbvPuC3ydiB9WiV
         XsK2J7E5w5NcoUa+Vm+2cyekcQcD4czBCYQe9KXxMnlJIttXzSAzhvRdmdFKaGJts5dN
         SY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=QpiyMt1ebROpmBD0KrUNmUWdm7XmAoK0vdJRp9/nGg4=;
        b=bc+YP95Dqutz+30Biasfdgm/ouKAV6IfGgZ9Y6XhrAjN0Ksh7jQtrkZdN2nemIJR6j
         1I6wtRdQgNQwH5hu9t8sGXixUzbs9P3zZnVZno0GuEPiSNQD813yo/qlTS48NMYqjn5J
         qpiHf9BtiRo/xb/yek1sEGJklnQFevQ/481jrqJcXGTGqmojAJZRgv0O+EAu9UxC1nrX
         jDo2Y5ZGaU+Io7nvBoMvh/Rvq07KvNw1wcgV8kFQK2+YvFrsUgZ7Om2dzrSwVkA7fU4X
         IChEFT1akw/juL9NVMlLSL47Rv5NeGODKJ8e2MyghdmG2XcoKN4vwPj0Bjl9uQNbGDD6
         uu7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A71122E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.9 44/61] ARM: amba: Make driver_override output consistent with other buses
Date: Mon, 30 Apr 2018 12:24:47 -0700
Message-Id: <20180430183955.093881754@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200414584259129?=
X-GMAIL-MSGID: =?utf-8?q?1599200465794090411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 5f53624662eaac89598641cee6cd54fc192572d9 upstream.

For AMBA devices with unconfigured driver override, the
"driver_override" sysfs virtual file is empty, while it contains
"(null)" for platform and PCI devices.

Make AMBA consistent with other buses by dropping the test for a NULL
pointer.

Note that contrary to popular belief, sprintf() handles NULL pointers
fine; they are printed as "(null)".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/amba/bus.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -70,9 +70,6 @@ static ssize_t driver_override_show(stru
 {
 	struct amba_device *dev = to_amba_device(_dev);
 
-	if (!dev->driver_override)
-		return 0;
-
 	return sprintf(buf, "%s\n", dev->driver_override);
 }
 
