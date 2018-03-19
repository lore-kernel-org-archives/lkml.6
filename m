Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELscFSbkO95+IUsOG//7XJ3z7+lPYw1S82lxla1D1KXESuUeyu0N+jCwtKdrAfY0HYkfYY2q
ARC-Seal: i=1; a=rsa-sha256; t=1521483441; cv=none;
        d=google.com; s=arc-20160816;
        b=xO7kZNIvGyd9dEK30Q9PVfrKsdQRPdA79y2WL93DQ8/kykDEpf27fROOHyl/aUTcz3
         MKmkSIxwpe6G7WWWim6wDC4Htysn7FnqPUjAwLG0o0AtCdyR0NxQKyTakrTJ5eRC85a/
         ckqLIGnRbQkHCrneLQeZS7ASBCgfDXFSxxsdJ75WA4ez1GxG6AVCN7pKs3SkfRzp7Ofj
         2eZJkiJuw5bQEmwwcz2XDpR9Uq+lb1KvGgipoSvrO40/VgxtaYBdHEpIJjXIHJPO9QoB
         VqOCKsqCYInDZDqOg/TNhDm6BisGSraonpCzxVovx6i3z/mWppo/EPiSGgrdvDIK/yBY
         n/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Npt6m+JKsF0LUAPB3UFb3oMUZp+PP6+1XBnjHrDIDNE=;
        b=NMLGFezahkMjisC7pJ4GtBfcrrhUxO6j9ZhEWeW7tFicXh+kq1FrlBzy/CBXTLwnBO
         gPhdNEg6F0M0mE1N3N8b4WGqF4bCtc/42H9SGNJNah7JNgDdC6rXW0ME/jtKUSTSSu7/
         VkC0pfWDS8leAVg33tkZ8TFcFCu4kfRHLjKiYzWv29sv4hsYNrXNdWO2y17IczFyvN/K
         yCHLi+DMUz6Du6KPhHB/drfNtQ5te1j07C90GiS0+L0dIrGS1hQ0AtRmQ+7FSWM/3nV9
         X2/UBS9iqEjM3Nng56mWVcECc7fRHVjb5KX3unNkqcWeiEN4IiwXhuRm1roG38xGhTUg
         GrNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Chris Clayton <chris2553@googlemail.com>,
	Douglas Gilbert <dgilbert@interlog.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Cristian Crinteanu <crinteanu.cristian@gmail.com>
Subject: [PATCH 4.4 126/134] scsi: sg: fix SG_DXFER_FROM_DEV transfers
Date: Mon, 19 Mar 2018 19:06:49 +0100
Message-Id: <20180319171907.481030335@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390662644513499?=
X-GMAIL-MSGID: =?utf-8?q?1595391021485239236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 68c59fcea1f2c6a54c62aa896cc623c1b5bc9b47 upstream.

SG_DXFER_FROM_DEV transfers do not necessarily have a dxferp as we set
it to NULL for the old sg_io read/write interface, but must have a
length bigger than 0. This fixes a regression introduced by commit
28676d869bbb ("scsi: sg: check for valid direction before starting the
request")

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Fixes: 28676d869bbb ("scsi: sg: check for valid direction before starting the request")
Reported-by: Chris Clayton <chris2553@googlemail.com>
Tested-by: Chris Clayton <chris2553@googlemail.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Tested-by: Chris Clayton <chris2553@googlemail.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Cristian Crinteanu <crinteanu.cristian@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sg.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -769,8 +769,11 @@ static bool sg_is_valid_dxfer(sg_io_hdr_
 		if (hp->dxferp || hp->dxfer_len > 0)
 			return false;
 		return true;
-	case SG_DXFER_TO_DEV:
 	case SG_DXFER_FROM_DEV:
+		if (hp->dxfer_len < 0)
+			return false;
+		return true;
+	case SG_DXFER_TO_DEV:
 	case SG_DXFER_TO_FROM_DEV:
 		if (!hp->dxferp || hp->dxfer_len == 0)
 			return false;
