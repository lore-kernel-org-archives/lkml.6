Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr8xJNyd5PuZa6YRHDzqYrlnh64s52pXszeW8yq8R/N/jAt+nA35AOCr5kGdXkMy37t3lSF
ARC-Seal: i=1; a=rsa-sha256; t=1525116445; cv=none;
        d=google.com; s=arc-20160816;
        b=u5T8WKG5Cj54mDzW2/c9YukE4KSR6hsCmjdMpTGgZQAwYtGHZIkZEvg4U3RMTAIjAO
         bTtGZrhiMqHBaJFw1MMlsfSl1FWWOP7FNizhWNZGbSQpsewvHobT9RHTH+AqrsBYBjwV
         H+sUfZrcJZHpF994E7iVsCfGC4ahesq9V8J+sOXFAC6r8nsAALl5obV6nOeYMXhz1g9Y
         bJkuRnVwXo7527ZlKvp7WTM8N34Lgaxqv6nRhATvM+NQz1nO/4Bo9IzseY+2QPaU49W2
         8vwsCa8kYSfXTu+k9UpKlaY9SNWi0w8HtkQlMB/xen8O+9fYziF1jBkM4GxAb8MkpjIG
         4M2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=zF1Bg62Ci7aujaTubhQdExu8bc8fOREHdgdMPxRhiMc=;
        b=NBMyET3JpqUdld/Nwun+wvW2a20ILU4Rc+NLQwFV7OdUcr1T7ibcuTbt9FvmaLpt9m
         fRUBxIrso2qxTlVS8E2c8K6ibkm9FPshDrwh1YfgijzuJKrX3Lpe4flKzK/eB4VnvvZW
         VASlzHNkkyGuGR0rt1aossyJzXDBTyF6FFCwO0ajwyMUbrdQCNBBLEB7MHsceTqnijkx
         7P889uUWUFDOm7f3PiV2lSqMW9TS1kTT9fTJrt1j5OetFncjj1fqQLA0jHIjovW+myA5
         KIop4eKfAbun5FDqrCv9cKyfVXpR2ixxwF3pyacZrdiAjTNHbiWkP+OrDD1FfzOf01hz
         XvLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D8422DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 56/91] scsi: sd: Defer spinning up drive while SANITIZE is in progress
Date: Mon, 30 Apr 2018 12:24:38 -0700
Message-Id: <20180430184007.103170251@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285952229082?=
X-GMAIL-MSGID: =?utf-8?q?1599200502333381591?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2132,6 +2132,8 @@ sd_spinup_disk(struct scsi_disk *sdkp)
 				break;	/* standby */
 			if (sshdr.asc == 4 && sshdr.ascq == 0xc)
 				break;	/* unavailable */
+			if (sshdr.asc == 4 && sshdr.ascq == 0x1b)
+				break;	/* sanitize in progress */
 			/*
 			 * Issue command to spin up drive when not ready
 			 */
