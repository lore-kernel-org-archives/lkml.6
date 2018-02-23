Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuzf5wfnNfuUDrhOpatDWrrVlyfrMlhgutl7vaJjSIMPQO+/EM/+nPwXyN55HrAvGkxD2lX
ARC-Seal: i=1; a=rsa-sha256; t=1519410953; cv=none;
        d=google.com; s=arc-20160816;
        b=tVnUll8y3ZtNJ4GlWBg43awvNEdYW1I6AeSz+XC/OuMJuLSDrvwM3n2euGoumYpv7+
         xGTAS1CkyXsySmlTSmVsi+5ONtXF3fhLQfQWcpFEqyUl3YOO/H3v5efbhLfMYNSAYbvx
         UiE8IzVEUTzikpTSCE1v5WAcCPQwJg/rdDFKxmqbcvu9cey74Efy9E0Ie8YSI0ar+0y/
         0F5kE4M3d9PoRKCuZL2whbrbNm+XROYSCN6mDiYzSR3iCUZvvEy2APsRDK6MWZmz2A7h
         MDZG6DlYvF8CAmtPohSpGVmDjVB1qqnseEx63f9PTNK98v4UApBDdhjV5xTDu/Giqk6Y
         NV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/Bwf1TDGtB1YtuNtMTEC0nqn4FXSnd2mpV8e94wxPH8=;
        b=dyqOUN8C2JyCygY1XoAOi1Uie5CaKwCroV/QiDxgVo2ovKyYu2wZz7F/oqctTwp/FI
         tEWRrWNmdX6BKItkZ9LgYhgcKxmbaKZLCd0AOra1Ei27Q5z1vEjB9IFKne4PIKyh+HT8
         MIiDZWL/ULX7GcC2VTd7oUHTsBwbd4R1K6DMr6HbqOHF7/wcbN9jZeCmtJrvZWVh56XU
         zq+LiNgcifLI5lN5gwEBCsf5warVMy5+XMC+plVC3ZWFRuJ9flo08HYYNsqKyfZDb959
         mGoLL8gvlMWD2fd869TW3AAsuxBlYVAssKXHWsfyb2ZqEcQOB976k2bGxwrSIKyjTSX5
         2OHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 068/193] scsi: advansys: fix build warning for PCI=n
Date: Fri, 23 Feb 2018 19:25:01 +0100
Message-Id: <20180223170336.603617213@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217860144452845?=
X-GMAIL-MSGID: =?utf-8?q?1593217860144452845?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit f46e7cd36b5f2ce2bfb567e278a10ca717f85b84 upstream.

The advansys probe function tries to handle both ISA and PCI cases, each
hidden in an #ifdef when unused. This leads to a warning indicating that
when PCI is disabled we could be using uninitialized data:

drivers/scsi/advansys.c: In function  advansys_board_found :
drivers/scsi/advansys.c:11036:5: error:  ret  may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/scsi/advansys.c:10928:28: note:  ret  was declared here
drivers/scsi/advansys.c:11309:8: error:  share_irq  may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/scsi/advansys.c:10928:6: note:  share_irq  was declared here

This cannot happen in practice because the hardware in question only
exists for PCI, but changing the code to just error out here is better
for consistency and avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/advansys.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -11030,6 +11030,9 @@ static int advansys_board_found(struct S
 		ASC_DBG(2, "AdvInitGetConfig()\n");
 
 		ret = AdvInitGetConfig(pdev, shost) ? -ENODEV : 0;
+#else
+		share_irq = 0;
+		ret = -ENODEV;
 #endif /* CONFIG_PCI */
 	}
 
