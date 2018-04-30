Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpWEvNz5pAY4hersVHYZD6fKRcatkhhA15gy58uiyft4h4uJdParTYwHmgyNnf05C9HcMov
ARC-Seal: i=1; a=rsa-sha256; t=1525116400; cv=none;
        d=google.com; s=arc-20160816;
        b=m64Ncx2T/ilN86G2RpwIHNMp7cAxM+2RoCz8RId8XUyxkHeY3UTtvBtxZiBgWpUCu7
         PCeQ62B+qURxtHLxsQEIN5mml0E28dHhRWlWMCQ3O6i00hkgnWyzZi+cekz33qI5zoFe
         ccYoM/kk5jEfv/bkUd1HJl38kpcxhKemPkNR+WBwSPEcFslTG7sgG33LYs810JQ8/0+I
         z2FRtpdWV5NZeaHSu3J4KPlSGBCP2pyBzD0oj7/cUCLXFTgrskvJKK4daaA2YLrB2qM9
         k8Z7hZKzkuzXj35lM+QaGtrhTkuqlko0WCjpdYG2ttvSBr7XPJDTGQZNARjBzKz3L+IH
         5o9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=125QQGxOFJwHiKfjAflJx8k3oKcu8l7U37D38ZHJkjI=;
        b=HFgPen/IKnKURj8OhDevFHIlUwAbyjnZ1BhAqmxTd0Oug6PtrwUVRkoitzhxWnxhbm
         IValrP0FjLTgzqcB7Ogixsuii+nMoGo6jCjz8Hud8BHZbf8h6IBlG7YZ3HpAeIjnmg9Y
         rb/mFnNSYYGYFzw4otKJmirmOo8DXhRjiDYLjP3L3L+BeVyrCijZ494DNltQFN91bxxP
         a0kM02/Lg4KsSWuqheC6iZ6kMrsj/a6VowVjjLqfeRnuCGZUZUNjPbad/GyU5tWDoYKH
         FugUA71RBvK8KdwtGEeLD1VHEwPrHs7i1kFiHDqikRvX+Cf9Fad9BeZ2oJR4sF//vfIx
         zhGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D5B22DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mahesh Rajashekhara <mahesh.rajashekhara@microsemi.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 40/61] scsi: sd: Defer spinning up drive while SANITIZE is in progress
Date: Mon, 30 Apr 2018 12:24:43 -0700
Message-Id: <20180430183954.747408420@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200285952229082?=
X-GMAIL-MSGID: =?utf-8?q?1599200454403833447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1935,6 +1935,8 @@ sd_spinup_disk(struct scsi_disk *sdkp)
 				break;	/* standby */
 			if (sshdr.asc == 4 && sshdr.ascq == 0xc)
 				break;	/* unavailable */
+			if (sshdr.asc == 4 && sshdr.ascq == 0x1b)
+				break;	/* sanitize in progress */
 			/*
 			 * Issue command to spin up drive when not ready
 			 */
