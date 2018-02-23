Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226yVi90FgUuUjz2RX9RRJkTazejWHfmBrOz9bf5P9zaKlxAsUpkH/KsatdUkVQ1nMPG5iby
ARC-Seal: i=1; a=rsa-sha256; t=1519411031; cv=none;
        d=google.com; s=arc-20160816;
        b=sslAAi/2j2Grw8XuUfzJ6LfIrKAdUMVsybBIz3SJmhGBAl0QeUP37B4C8fcVbJTK70
         qMUgBNDFNFwZ+8RN8TIbMcpF0OGDXN/7AjrL+ISyVNJaWMvRNDg9+r7KjqqNbnJHEP1x
         t/Z87g8HQw3I1KAZbujQb6ln0K/ZRaCwEBFLDKrvIqFlAxdDyMZfzDhb6wmHsJIbRb8b
         hkjQRU4i9E8axxZ+XDB6Fz2E2trooAXxZZSd7L+98PSguRs8zuXRnBHGQihoSn8gTZ3s
         X8vVCfWvnhfm5izWoGjtLEQ2zwQb+eSi7gRnL1UrkWP4LGs7n+RAU9RaXlZd9+m4NsQw
         tZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4d1XRmA8Z0tj87k/lvkVfC1Ro3xDiqhLYdX0sOKqRiw=;
        b=wgNfCtPj0Nd7m3sCu8USfyGO5QOvnU7NMK9UjlfCNc7bfeZNUTZ4yBefzNwsIvw6mw
         0xhtkkasUTvxn7WTadlzzFtEnt84I12mH2dJ12XihIW1Ab9WH4u6lhPO6o6r5vUQ2U8/
         KQm6UDcqkyC5KAtByliCFoNUPVQnfOgc03o0m3aEVWGgaPztcF8Q8nYIjuFxuRZiSor/
         wdl+u0ZaQURL+Wh3SSjK+xHArRDgFHR8POqPkHFWn9k2qWhWS3AQU9dDj8/lfzRSDO6r
         VxWMLfNVPv6jHa/9moxfC2LjVvyZL5Ff+sOC3uOiJZ/j0ambO4VjdwbQa3AYAO9FwOs4
         Kgbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 097/193] scsi: mvumi: use __maybe_unused to hide pm functions
Date: Fri, 23 Feb 2018 19:25:30 +0100
Message-Id: <20180223170341.232962399@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217941928771618?=
X-GMAIL-MSGID: =?utf-8?q?1593217941928771618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit fddbeb80a904aae41c84ed566e2b0d1de55907df upstream.

The mvumi scsi hides the references to its suspend/resume functions in
an #ifdef but does not hide the implementation the same way:

drivers/scsi/mvumi.c:2632:12: error: 'mvumi_suspend' defined but not used [-Werror=unused-function]
drivers/scsi/mvumi.c:2651:12: error: 'mvumi_resume' defined but not used [-Werror=unused-function]

This adds __maybe_unused annotations so the compiler knows it can
silently drop them instead of warning, while avoiding the addition of
another #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/mvumi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -2629,7 +2629,7 @@ static void mvumi_shutdown(struct pci_de
 	mvumi_flush_cache(mhba);
 }
 
-static int mvumi_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused mvumi_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct mvumi_hba *mhba = NULL;
 
@@ -2648,7 +2648,7 @@ static int mvumi_suspend(struct pci_dev
 	return 0;
 }
 
-static int mvumi_resume(struct pci_dev *pdev)
+static int __maybe_unused mvumi_resume(struct pci_dev *pdev)
 {
 	int ret;
 	struct mvumi_hba *mhba = NULL;
