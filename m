Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpz82JKJZuq2JjtyuAczjnR73Lzk5w129yqUTYEkxFiYn0UD+2WxYwujsAWHsg19GKbZAS6
ARC-Seal: i=1; a=rsa-sha256; t=1525116361; cv=none;
        d=google.com; s=arc-20160816;
        b=CZCfj4hWWE58jSO0D8ZZzSH7YI0SiP6s+KwTBdJEDmSY14Z0/7jo/teqgMm9m4Jtl6
         PO/MdQcupyORgZ+pmEhAh+V/7sxa05VrMHrgRBiyNqr1gHhQQSrN9utehRl9y1GygOqC
         xyW0f8bkLngziZoCIXfEkZ4UKLOmCqbXHf3bOfUTlX1tuaiFaBjzO+RhIIW12gvRSGH4
         KcaBlF5vnPPeo5dCvnpSBKeNicy/4CDwMlrf998sFUUfY8LxQzTVVYaiBCWJRPtJV2kF
         KW+0gKa0FYWxFX8Zas9Zez5Ky2XshCadXOdgQgyfPgJ7FGb/Hju4ET3unaYUZTp9HOlf
         Asiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Ww5iymCPa/+VsiyBkU8qz5ishGkCD440oLGbs3KVCrI=;
        b=JXR5kM55BzPbnHW26q9B2rO7qf2Hoj1idGseLZF/Ig8MMqbOnGu8OtoxcwJykkuRvJ
         oHxd3ovgYG5Rb68N3aTmUnd/LB8fihBuEKABhJjE7WQILxuf7NEaf4L/oLDDCv8MwExQ
         s6BSAWzYMrXHfgoPWxUcyh4NlXV1PJTEC0C9g/dBDMpUwYPpAeEvwHuRENf/B1p/iJE5
         3VSaAK+RG7xmwxEqE8UE+CfJQLshx6Ypfrp+hFD5RZYDpyEaul1u0JJA2E2FYzKHl8FJ
         eCwJey9+qHB2wyp9YlgL7m+o2/z+MoQtAxii8PnuXR1FH8Pr+Z4qiHNtlhTxRResoddf
         DoZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A4322DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 34/44] scsi: sd: Defer spinning up drive while SANITIZE is in progress
Date: Mon, 30 Apr 2018 12:24:45 -0700
Message-Id: <20180430190947.695033898@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285952229082?=
X-GMAIL-MSGID: =?utf-8?q?1599200413496614128?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1929,6 +1929,8 @@ sd_spinup_disk(struct scsi_disk *sdkp)
 				break;	/* standby */
 			if (sshdr.asc == 4 && sshdr.ascq == 0xc)
 				break;	/* unavailable */
+			if (sshdr.asc == 4 && sshdr.ascq == 0x1b)
+				break;	/* sanitize in progress */
 			/*
 			 * Issue command to spin up drive when not ready
 			 */
