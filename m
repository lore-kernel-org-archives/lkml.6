Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELusNYmsPS8TK61niDbSbOle9SPHIG4XrNWn/aldb0uzSy1Uo++AlE3V18Y/953h3ffQr+B8
ARC-Seal: i=1; a=rsa-sha256; t=1521483347; cv=none;
        d=google.com; s=arc-20160816;
        b=FkmLl6+O1KqPv31U77mz2ASlr22Un4o6+1T+egTQh5kYuigcbMc0mg6HtDLojeAxiR
         HECxMUCDJM0ufbeHitPtN2riLRiXansxSfzYAKTtW26znPZ47ffaXH+NBWglaCh49H9x
         BS/zkRMuINWY11Vt1c+VUptrVwWzzbUnDHyv6hkNGloIK5FrlYFybXkPMrp5PgDvZJDM
         LOTplUCdXqUZ+WiQHltRxrH8esmfeJupM5qF1xWJYaOXpJckmIa5G3H3zEq+elR05Ljh
         k4aeyhaS7rl9tY8RfgzVkYAPXT0I/DNo8wtcvquQLZQ7zsq2q6IzergkdTPh3AwZLgaO
         +DKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0zFlNecLEs3yDpwvPJw+sNpz1pxY2QPpV358U0aI54g=;
        b=gU+qDZxNky2GVSzQjDUecJpka23Xx4bE3tpAjj37DdMKYIUUTaIG8tICnWrGEEg4bx
         M+xdgi1Xp5ueaOG5abnsmNIIFkSiGT1EL2L0LO70Fgj9P1nY7tfma/ZMgBKCbgL3JdoT
         Ohqugtm433AzwpfD85jlrC5vYd3bEyEiExK9wfy050u0VQda1/aDTdvXKYST3XK0rHTE
         rltgKgkDoDeNzlLDgI9jMYyDp+reZSK7hXcAxJc4zHskrtq0ZFdacfgu0vziU9alEXvc
         JzIU2fH3hC9YsUFxMxOX/V9m14IvQN3cIm3Z/zy5ZZB00ZKVEPAnMJPBAlRtel+wjWDN
         ramg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Dmitry Vyukov <dvyukov@google.com>,
	Hannes Reinecke <hare@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 073/134] scsi: sg: check for valid direction before starting the request
Date: Mon, 19 Mar 2018 19:05:56 +0100
Message-Id: <20180319171859.817392692@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390670672101192?=
X-GMAIL-MSGID: =?utf-8?q?1595390922429518342?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>


[ Upstream commit 28676d869bbb5257b5f14c0c95ad3af3a7019dd5 ]

Check for a valid direction before starting the request, otherwise we
risk running into an assertion in the scsi midlayer checking for valid
requests.

[mkp: fixed typo]

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Link: http://www.spinics.net/lists/linux-scsi/msg104400.html
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sg.c |   46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -674,18 +674,14 @@ sg_write(struct file *filp, const char _
 	 * is a non-zero input_size, so emit a warning.
 	 */
 	if (hp->dxfer_direction == SG_DXFER_TO_FROM_DEV) {
-		static char cmd[TASK_COMM_LEN];
-		if (strcmp(current->comm, cmd)) {
-			printk_ratelimited(KERN_WARNING
-					   "sg_write: data in/out %d/%d bytes "
-					   "for SCSI command 0x%x-- guessing "
-					   "data in;\n   program %s not setting "
-					   "count and/or reply_len properly\n",
-					   old_hdr.reply_len - (int)SZ_SG_HEADER,
-					   input_size, (unsigned int) cmnd[0],
-					   current->comm);
-			strcpy(cmd, current->comm);
-		}
+		printk_ratelimited(KERN_WARNING
+				   "sg_write: data in/out %d/%d bytes "
+				   "for SCSI command 0x%x-- guessing "
+				   "data in;\n   program %s not setting "
+				   "count and/or reply_len properly\n",
+				   old_hdr.reply_len - (int)SZ_SG_HEADER,
+				   input_size, (unsigned int) cmnd[0],
+				   current->comm);
 	}
 	k = sg_common_write(sfp, srp, cmnd, sfp->timeout, blocking);
 	return (k < 0) ? k : count;
@@ -764,6 +760,29 @@ sg_new_write(Sg_fd *sfp, struct file *fi
 	return count;
 }
 
+static bool sg_is_valid_dxfer(sg_io_hdr_t *hp)
+{
+	switch (hp->dxfer_direction) {
+	case SG_DXFER_NONE:
+		if (hp->dxferp || hp->dxfer_len > 0)
+			return false;
+		return true;
+	case SG_DXFER_TO_DEV:
+	case SG_DXFER_FROM_DEV:
+	case SG_DXFER_TO_FROM_DEV:
+		if (!hp->dxferp || hp->dxfer_len == 0)
+			return false;
+		return true;
+	case SG_DXFER_UNKNOWN:
+		if ((!hp->dxferp && hp->dxfer_len) ||
+		    (hp->dxferp && hp->dxfer_len == 0))
+			return false;
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int
 sg_common_write(Sg_fd * sfp, Sg_request * srp,
 		unsigned char *cmnd, int timeout, int blocking)
@@ -784,6 +803,9 @@ sg_common_write(Sg_fd * sfp, Sg_request
 			"sg_common_write:  scsi opcode=0x%02x, cmd_size=%d\n",
 			(int) cmnd[0], (int) hp->cmd_len));
 
+	if (!sg_is_valid_dxfer(hp))
+		return -EINVAL;
+
 	k = sg_start_req(srp, cmnd);
 	if (k) {
 		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
