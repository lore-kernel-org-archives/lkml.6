Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqIU1r4lSfLZ3oDSMu9a1YO+n5biOSt7mBfGXkyd3tqNQ8/PaMveB3LgDazcVp+n/Eno57S
ARC-Seal: i=1; a=rsa-sha256; t=1524837759; cv=none;
        d=google.com; s=arc-20160816;
        b=ajoIV9cz2XLLqHT6+aCmchX4Vv5iKstZlx4YxLnLeBHBmUoV6VSE0O6BGyuuDTC+nh
         +04V3NGGNhU5ZEfuOwyKqBJTXlCu0x8d8Mcs6j/iNG5opf3Y3IcqxhqMQTbY9BIfFZAm
         3Ree11vCHQKZSwq6uKPetpbsDaf0akIcnBfCei04rDcdF3jkP5yRisopzHem/ALYzrxb
         l6pk7Pt8DMFGXONuq10Ce4X9xOph38yQ3qStv9ocdOLxPFNUt6h5nZt0J6Hnl0FWTUOq
         L39S65Ae34lcYVlCN02MmF9uRmKZy1zaXGoaAYyC3RCpwv9frOq7hKUrs96xf+RS+zZX
         VQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=DhnfcmE0mBUE1ZGvJFClK/CgR0gk3CBmrSx718Moz3k=;
        b=EBZ/qlppZ+lh9zfWfJVxj2SWSXFETLL427VlTmUOkDEK+LHSID6PLsgqGv6UCofQqp
         CQ7kn1MvH214ljeOzB6z3AIm9AwP700PB4EsAegv+60s+N5iEMBVupWej/6kEqOhh6O/
         HyfKRSAEuHq/9oMSEqr975Hi9zCUhPRJsgxtgI+VgV26CuP/XIIGcGKJbc94z7E2jVR4
         /gPiXiIq9NKvSrhmtICRtzJAqEniv4qauo44sCh8ijeihZLYmYXCtH9E1cZHB0inyYAL
         895zeLIVFzj5Ub8yjKBznzt+/SIadAPdbozme0dSRIojFqaV8Q8lppdBz7YeXpDHe1Tp
         9tiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAAB21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sebastian Ott <sebott@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 49/50] s390/cio: update chpid descriptor after resource accessibility event
Date: Fri, 27 Apr 2018 15:58:51 +0200
Message-Id: <20180427135658.563557072@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908278822416225?=
X-GMAIL-MSGID: =?utf-8?q?1598908278822416225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Ott <sebott@linux.ibm.com>

commit af2e460ade0b0180d0f3812ca4f4f59cc9597f3e upstream.

Channel path descriptors have been seen as something stable (as
long as the chpid is configured). Recent tests have shown that the
descriptor can also be altered when the link state of a channel path
changes. Thus it is necessary to update the descriptor during
handling of resource accessibility events.

Cc: <stable@vger.kernel.org>
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/chsc.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -451,6 +451,7 @@ static void chsc_process_sei_link_incide
 
 static void chsc_process_sei_res_acc(struct chsc_sei_nt0_area *sei_area)
 {
+	struct channel_path *chp;
 	struct chp_link link;
 	struct chp_id chpid;
 	int status;
@@ -463,10 +464,17 @@ static void chsc_process_sei_res_acc(str
 	chpid.id = sei_area->rsid;
 	/* allocate a new channel path structure, if needed */
 	status = chp_get_status(chpid);
-	if (status < 0)
-		chp_new(chpid);
-	else if (!status)
+	if (!status)
 		return;
+
+	if (status < 0) {
+		chp_new(chpid);
+	} else {
+		chp = chpid_to_chp(chpid);
+		mutex_lock(&chp->lock);
+		chp_update_desc(chp);
+		mutex_unlock(&chp->lock);
+	}
 	memset(&link, 0, sizeof(struct chp_link));
 	link.chpid = chpid;
 	if ((sei_area->vf & 0xc0) != 0) {
