Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoUy0W9JSnHlUIfWT5zz3p3zOQ/7Eay1rfV8aopUslDmkM1lIHYvNPQ+ZWtsj+l166DJoIv
ARC-Seal: i=1; a=rsa-sha256; t=1524837931; cv=none;
        d=google.com; s=arc-20160816;
        b=DGLV+T4H9IDMeYjNQX+9H7bJ9GRLQQN4hpcFGgIu/Pidb6Jxa6pGImT3y67INX9FlM
         daI6AVrWbyhp9NNCzBjRSizbmdt80lzx6Gr+M+DAkiBw7OD5IX/S+q/QiF4OblkLGK+J
         VJNUoUSTqxzKzsVflXPXHubS4OVZsrbBrqXMiM2sm5rIIrBe1pJgxuat6olNtNy//9Y6
         li4UbcujIOmufHLtHss4vjIApFcokoHqDphvlITvXp2ot2X+Zo4sFbGv4ojJQxFcPVoJ
         ojMEymTc0eMITE6ln1ezhhUBFKgjsZVGxcly/EcBdFLbpw/IMGvoWBEyN4LHn97Etpsc
         Ro6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=IQ/g7fetFyfX8mnC5ztb4Y/BNNjlgYwK65pjBWViFJs=;
        b=u20glEoP26t6CFkEEyzOOVsMtHDrefuX4Hs5/LtPRoBujbelTc+LBcZOsv7ruwoWtL
         shwt54CtvNnDeuczM83fReVQGL3F5QUHkJpflik6Y9B1KoYP1LolUV5tKJNZR5KrMw/Q
         W0D281NDIKxI15xEH1nwwTVlb+KTd5ojDgvKedjURZHb0HQJG55h5OExYarQoWr7TjuU
         bSOEjbn1lOIzKt5uln84UkWmvJCOt2gxoP5swuQou5U0me/FGTNDUXUQrY8q5Nghx0Tg
         HIpYMroB7R8AlGb3rA/2axwIv7OM3wZrkPmawG7O3hLmqi+yAdd5mfKjy+KVvubuHfrJ
         ON0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D901C21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sebastian Ott <sebott@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 71/74] s390/cio: update chpid descriptor after resource accessibility event
Date: Fri, 27 Apr 2018 15:59:01 +0200
Message-Id: <20180427135712.884420018@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908278822416225?=
X-GMAIL-MSGID: =?utf-8?q?1598908458722970258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
