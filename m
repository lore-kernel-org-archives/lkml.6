Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtxBz1besXZsr89jG9yNe81PyhxcntPGvNTOY2+P1zqH7ig38qIi3+WWDi4/avlVAFJbqS/
ARC-Seal: i=1; a=rsa-sha256; t=1521800321; cv=none;
        d=google.com; s=arc-20160816;
        b=ZR1nkYMIGuqg3+0fSTVAAChqVw2zwuy5UHVixsSOgvcIRwOZBzHBakv2wBsf44vh1J
         zX9xPiEoHLtmHQnan8T1/zRD5J8DpIMw8yM2KcjaE2FPMxSWnck2Viv/E6JXziM5VNOF
         dcFvqGhm8c9ZLTs5jNQziQ56x43C8RqrIfm3hv//uF/HjHpBwiatUFxHBD+JJOESn0Jw
         0HaMTEwKm3QNEdm3NFSOAygc/Yc/WGZUIZoONOjnhKFWzZCyQxz0U7NRA4+1Rh4zkD74
         gZ3DWjFTdVDLf6+LNauq7Ru9zNevszRCRJhD7OXEvRcvnP8iChqB5eCpc/GnqISPMrGY
         nqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GJEyrwluEpkctcecIXI4Ouwjy+FMHvlW75rYrvlEf7A=;
        b=omX3mOPf2eOVblYt9YQ+S2Y0zOCQaoU5gVjP3r3PHbFnTvbyIeheOWVR9UaT7eipQ6
         /9boupIwYgzaZvNtI4nHYjNvf5Q3l5GKsJjr6Z5n+05hqgodlezU0xAdGCtYXAfzw066
         m8Y1gpTYc5R+x0dtbfQK2RG2Jr7yy/rPTKo9C+OUlX/lGpZLMVawMtf6rUQH9ydv9SIM
         58AwyVZpMR+IgC4AJfTVlLrqBdsE/EE7o2Eay7lyY91wpchiGtm+Y2yJCr0Zoph7Cd9H
         cERNVS0iv8MUFP1O4dpTD2Vyt9TPodZVtH8rBLBsdL8tkpCiX7eP2sTICS5oOeaXbjc9
         T0Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 19/47] Fix driver usage of 128B WQEs when WQ_CREATE is V1.
Date: Fri, 23 Mar 2018 10:55:10 +0100
Message-Id: <20180323094248.948554014@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722598540263975?=
X-GMAIL-MSGID: =?utf-8?q?1595723294027665461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Smart <jsmart2021@gmail.com>


[ Upstream commit 3f247de750b8dd8f50a2c1390e2a1238790a9dff ]

There are two versions of a structure for queue creation and setup that the
driver shares with FW. The driver was only treating as version 0.

Verify WQ_CREATE with 128B WQEs in V0 and V1.

Code review of another bug showed the driver passing
128B WQEs and 8 pages in WQ CREATE and V0.
Code inspection/instrumentation showed that the driver
uses V0 in WQ_CREATE and if the caller passes queue->entry_size
128B, the driver sets the hdr_version to V1 so all is good.
When I tested the V1 WQ_CREATE, the mailbox failed causing
the driver to unload.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_sli.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -13469,6 +13469,9 @@ lpfc_wq_create(struct lpfc_hba *phba, st
 	case LPFC_Q_CREATE_VERSION_1:
 		bf_set(lpfc_mbx_wq_create_wqe_count, &wq_create->u.request_1,
 		       wq->entry_count);
+		bf_set(lpfc_mbox_hdr_version, &shdr->request,
+		       LPFC_Q_CREATE_VERSION_1);
+
 		switch (wq->entry_size) {
 		default:
 		case 64:
