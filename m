Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrgNY+5IiMoodjI3wSX0dyIwp5nADq3+oNND5fqXSo9l0EKcXGsJQLk8GlQq0Hv6E5eEtwS
ARC-Seal: i=1; a=rsa-sha256; t=1525116239; cv=none;
        d=google.com; s=arc-20160816;
        b=UvngH3+HgNx6244IRSiD58k16taAXLTUO3Tf91OF+flcGA19+cGlc6bEunE8UpLtWL
         FttBGqoYHcJaxlvqkscnhlXRwk9ApdqHc5uHZIunkX2TZnweT9G5tTmQyPJsUUL33iM6
         AATb+aHMLL2jKRWPyASQ+rjGcZY6sltFkGXIRE6JQb3/ygEJbMqBbhul5UfEDjLPeef0
         wOwq79IGq1WdVSqj/kKuAbEX55jk98tdv9Yn12EqvjT8uNiAGDzbA5mmRJ756CXcfNWf
         WcN1V++EFF8e8A0UsfpQ87n4SRtd78slkIXrQ8Pj1zeEs4rXc5ZxCam9yrmpc6K9cvel
         KA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=20PfhTE+VRuD8r+6+TmR4vQQrzOtR5Y+gTI3Zx6dByo=;
        b=LESQcHp3SdnvxZ3Z4/ZRbhdmYLas9BAD9H9e6rRqbH1RFu3OQ4RcYiV8DI79e94NR5
         Y0+7uMFLkW3dNJ8AlGkjfj/plqz52+iBn5LC8L5JHK0AgwSujllyIQVVVE6H+QiAmRne
         0LiB4goi5TSFVWs4xeFd9bIbojYbQn6IFYnfJG5Ij07ZHQG7KgExZW6uuuebMfpO5DKg
         D4C3zwzxLogCzLD70fygtx/0g19yASUgxZwdFup5PZF79bMCLP0+qEwgiDKi5chsc7fg
         /51nxgnLFo7Z5iyABbp5DBzBUs43Fxi+6PYu87DBOi/oqP+MUe6+jbBewZQ11j8tJYyS
         qXaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DB122DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3.18 22/25] scsi: sd: Defer spinning up drive while SANITIZE is in progress
Date: Mon, 30 Apr 2018 12:23:29 -0700
Message-Id: <20180430183911.726349587@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285952229082?=
X-GMAIL-MSGID: =?utf-8?q?1599200285952229082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>

commit 505aa4b6a8834a2300971c5220c380c3271ebde3 upstream.

A drive being sanitized will return NOT READY / ASC 0x4 / ASCQ
0x1b ("LOGICAL UNIT NOT READY. SANITIZE IN PROGRESS").

Prevent spinning up the drive until this condition clears.

[mkp: tweaked commit message]

Signed-off-by: Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sd.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1848,6 +1848,8 @@ sd_spinup_disk(struct scsi_disk *sdkp)
 				break;	/* standby */
 			if (sshdr.asc == 4 && sshdr.ascq == 0xc)
 				break;	/* unavailable */
+			if (sshdr.asc == 4 && sshdr.ascq == 0x1b)
+				break;	/* sanitize in progress */
 			/*
 			 * Issue command to spin up drive when not ready
 			 */
