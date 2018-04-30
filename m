Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZquqLnParA8G5KbV+miF4METfAeFZL2IH/Ledo74yJYOEqk9heBRkrlkDf7lckoQmiAlQxf
ARC-Seal: i=1; a=rsa-sha256; t=1525116506; cv=none;
        d=google.com; s=arc-20160816;
        b=jvKEiyCW6RSy2l7vqBZkbf+32yFfbnWdQndPFDGewaDPqHjm8e406N5yT58xzLhKU2
         PDR5l7TSIW8BdEEB04BZQVEQWhGREX4Gu1y+jLYefTu+ytWXUERoEpRXbAJHWTgxGdoN
         rzxcnLWHT1CK9utxkdIk/L4Olp9sKZFH7ReFM3g7eGpj6esF/ZOmWgo/lRgtPaP+cpUW
         BVgpMC8ERKTuHCzEWbf58MVkp4C0W8ATYh+mDE16zawg/Th51DEDTs4dFAGm/tTbTx/1
         lriv8eeHHBgF0bdFghU+Q8KiJRcwm79+XmNWyaTq9OODLat57im89+X563pKZZWy/6sA
         R35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=NdD9BDSsgI2sHYPWaK61HTqwCoA350yyaYa5nqbyBHU=;
        b=v97y2z/ao60VMkMaFt0vNqY7La3mCl3Wgt/oB6WgqQ5KK55skKqeWGihVmStNF9jfg
         H4IPfb6HN0lT/bUXSQG1meTQz7KOw4MlzSZNfQENusXLUg5QxH2ve0Mr+gohwoKblkiq
         xVsWuxp5ZcB7Dq22HJ+QxdbNSBUrVb9idZu51YuCNpxk6TWwZJ/HO1TVjOj3dFLLQSXT
         6/8CkesJEWjhB2rgOyB4Lxadf7teGwiB/oMLkozE19M2bfVpdmanD4lvLlWdx7o8jXI5
         JlN0lNbMyaaF2QZOTJOh/tcHWUDfmwcVAu5LA1Vgn8fykwKArt1ZWQLNGtgJRcezxqOs
         vqDw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43B822DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.16 062/113] scsi: sd: Defer spinning up drive while SANITIZE is in progress
Date: Mon, 30 Apr 2018 12:24:33 -0700
Message-Id: <20180430184017.837931605@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285952229082?=
X-GMAIL-MSGID: =?utf-8?q?1599200565802673481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2121,6 +2121,8 @@ sd_spinup_disk(struct scsi_disk *sdkp)
 				break;	/* standby */
 			if (sshdr.asc == 4 && sshdr.ascq == 0xc)
 				break;	/* unavailable */
+			if (sshdr.asc == 4 && sshdr.ascq == 0x1b)
+				break;	/* sanitize in progress */
 			/*
 			 * Issue command to spin up drive when not ready
 			 */
