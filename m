Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvqxWETS5RDq8OPoF0cPmLHoMl6wkYALjbVjLoSVUhEr1a6n4VQQDl6oG4dY2FMwfFQGYeM
ARC-Seal: i=1; a=rsa-sha256; t=1519411017; cv=none;
        d=google.com; s=arc-20160816;
        b=KWA3Wc0965CTph/epF83pnm7IeY1zAS+56sPQUfONNms+0pAm70NB42Vedg+vfbM4/
         rpId623Zrl38y+tmOxXgIqL8n+3mJLnQX8aFAVgHrlbG/IqVp3/ajElIbYp3+q2ST4ui
         b6SfNNCtp+z/cxV8JUYW8Hbs3YZWFb0q0ErGyn3DG4/0EXs+DnFPpp/SU1IRoX8usW4C
         ju+j6SCgocgOTnLVmMiXqk1FCuUtKWVSIi0oEv+tTJOj6jtJjV+OhoL2wcGzWVGeOUge
         z4HJ85yctJOHlwpTH+wWhWWfkhfgmwBHzSddrxz6cFVYLWnwa53d+ZYiQV6leQaffCe/
         Eflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vSF2mz1RLrlMjgB+OLcY8BtlH7oSRvTQGYETTJNqEsc=;
        b=BXOmNqLBQ0LT8Z1ez8ZgrAWWRlpQhXDH7+xxOr/6wSzWsfJ/kFhzc+W7D2ijRvb72a
         E6qiTJLaWX5ecR/5XyHo52nW0MvAmoB1rbzVTWu1J7I78Wf6zYxpPEUUYpMlTWzT4TOp
         91Ytw/KgHgxWPexUed8AJAQHe0ivZvWw5PNdHkqPRiLkqwytrmDfugVH8OWRmsToOJVD
         H4W3tGlb/RaILl4lchHcGZJuGtw1EUHKJmIym1IzFmY7/sbHOp4uKrq2QrZSRcM2P2wk
         uc2GX0CX201wWQnGpcNdryzfJVBwbiOw+r4r74yvEhgQhn5c0G9R7NaTHZRgXtewxcXW
         e4JQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 092/193] scsi: fdomain: drop fdomain_pci_tbl when built-in
Date: Fri, 23 Feb 2018 19:25:25 +0100
Message-Id: <20180223170340.422965231@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217927716625709?=
X-GMAIL-MSGID: =?utf-8?q?1593217927716625709?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 120f83f8d6f2e2e7dea3570646722c62ecee70b0 upstream.

The fdomain SCSI host driver is one of the last remaining drivers that
manually search the PCI bus using pci_get_device rather than registering
a pci_driver instance.

This means the module device table is unused when the driver is
built-in, and we get a warning about it:

drivers/scsi/fdomain.c:1773:29: warning: 'fdomain_pci_tbl' defined but not used [-Wunused-variable]

To avoid the warning, this adds another #ifdef around the table
definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/fdomain.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/fdomain.c
+++ b/drivers/scsi/fdomain.c
@@ -1768,7 +1768,7 @@ struct scsi_host_template fdomain_driver
 };
 
 #ifndef PCMCIA
-#ifdef CONFIG_PCI
+#if defined(CONFIG_PCI) && defined(MODULE)
 
 static struct pci_device_id fdomain_pci_tbl[] = {
 	{ PCI_VENDOR_ID_FD, PCI_DEVICE_ID_FD_36C70,
