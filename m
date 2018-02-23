Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvxQY0cNFMs+TRXoix1Z4w0hWUU7AMp3BIu/n25kICNVEENA7qu93UP0dTByaZOsNIaAO1e
ARC-Seal: i=1; a=rsa-sha256; t=1519411652; cv=none;
        d=google.com; s=arc-20160816;
        b=VUxltEH/DuTyTB10lh6jEILbzbGe6Bq+MlfrPe9eVjkkZ8aQ5UN/ogYGoRXBb93VtB
         /z9Q6Y4kunJdvnctemozwAcn0ZFYk3A/wMUN9hc50kb5DjAarRiXJX9Q0e2qf6RxvGYt
         BcIl47gl54euZ97gwzyH9DPWF409YDqrd6/bUUoUrLoqJyu2RL+f5MRCb3PtlRZXT66E
         39I0DsHyYBd0eprbIrJW88iK3X6io/mIrtcrTvPkoM6abWy7Ett+3giWQtXLrTbWCfYm
         ctxb9UyIY0kgJd09e9R70/wmQWQllM5FF+wdpTBmXKj28tnXQEMpL2MIah4Gbq6HoeCP
         swMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V6Ao1EbYFCZl08OWcpdgIZxin3P1SWiimrTsR37QGaA=;
        b=gxXPATu9pUtG++5e2/emeJoeTQzWB0Bc7gb/VpSkcxTd0NgtJeimrL7sv/mll2cdTb
         J2kQCexoCl44hNlsNWhyxvlsN13taj9tgqXssXA9gdktz+GjKe6seEtAkLX/19pGHaid
         sIdGVzFqDC4fS7f/+PqOqrexu5EuYlTfJJ/OthmupcKFAX8ZlYEpV4I8xLGG7Qtb48G4
         DVCtBATcKgXKObnbLy9MpWft9NJiQg8eOyI3w9YhosXcO+1puR7P2FkiuB0gdbqluVJu
         hizR1glR7IK537iIpjbSlTaXirviCaZozBdKfEAfHDJaHeIVHWv/IPOMwc1H8Rn5GZzQ
         c0Kg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 115/145] scsi: advansys: fix uninitialized data access
Date: Fri, 23 Feb 2018 19:27:01 +0100
Message-Id: <20180223170739.696833771@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217996534204075?=
X-GMAIL-MSGID: =?utf-8?q?1593218592705644032?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 44a5b977128c0ffff0654392b40f4c2ce72a619b upstream.

gcc-7.0.1 now warns about a previously unnoticed access of uninitialized
struct members:

drivers/scsi/advansys.c: In function 'AscMsgOutSDTR':
drivers/scsi/advansys.c:3860:26: error: '*((void *)&sdtr_buf+5)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
         ((ushort)s_buffer[i + 1] << 8) | s_buffer[i]);
                          ^
drivers/scsi/advansys.c:3860:26: error: '*((void *)&sdtr_buf+7)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/scsi/advansys.c:3860:26: error: '*((void *)&sdtr_buf+5)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/scsi/advansys.c:3860:26: error: '*((void *)&sdtr_buf+7)' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The code has existed in this exact form at least since v2.6.12, and the
warning seems correct. This uses named initializers to ensure we
initialize all members of the structure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/advansys.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -6291,18 +6291,17 @@ static uchar AscGetSynPeriodIndex(ASC_DV
 static uchar
 AscMsgOutSDTR(ASC_DVC_VAR *asc_dvc, uchar sdtr_period, uchar sdtr_offset)
 {
-	EXT_MSG sdtr_buf;
-	uchar sdtr_period_index;
-	PortAddr iop_base;
-
-	iop_base = asc_dvc->iop_base;
-	sdtr_buf.msg_type = EXTENDED_MESSAGE;
-	sdtr_buf.msg_len = MS_SDTR_LEN;
-	sdtr_buf.msg_req = EXTENDED_SDTR;
-	sdtr_buf.xfer_period = sdtr_period;
+	PortAddr iop_base = asc_dvc->iop_base;
+	uchar sdtr_period_index = AscGetSynPeriodIndex(asc_dvc, sdtr_period);
+	EXT_MSG sdtr_buf = {
+		.msg_type = EXTENDED_MESSAGE,
+		.msg_len = MS_SDTR_LEN,
+		.msg_req = EXTENDED_SDTR,
+		.xfer_period = sdtr_period,
+		.req_ack_offset = sdtr_offset,
+	};
 	sdtr_offset &= ASC_SYN_MAX_OFFSET;
-	sdtr_buf.req_ack_offset = sdtr_offset;
-	sdtr_period_index = AscGetSynPeriodIndex(asc_dvc, sdtr_period);
+
 	if (sdtr_period_index <= asc_dvc->max_sdtr_index) {
 		AscMemWordCopyPtrToLram(iop_base, ASCV_MSGOUT_BEG,
 					(uchar *)&sdtr_buf,
