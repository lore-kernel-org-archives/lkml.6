Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsTv98YCjyF2Q7YPHg0h3sCgwwgQ/+QZ3jHWKHMBw3NJ4xy3ZUmbHdGs/wKaP2hq8CyOLUh
ARC-Seal: i=1; a=rsa-sha256; t=1521483873; cv=none;
        d=google.com; s=arc-20160816;
        b=GKO+eU8gY5qp88v3pn/c0HNHpO6aS0esAGV2wztRYhGy55bBBgR9Mygw0OvSKbaic9
         vjykwHWCd4zG5z7M0po+8XnBfFUfsGd4jkQtp5tA+mgOM+wPZUGu8ZmARI/ERqT7QZU5
         NC2ciiAyaRiKL/osw09NrarC6ydE249cSagbK3/0KY8seSy9K4yBVqHv1ATF35nfI20s
         dBbwyWnPwSO5xjoN6yLlXC4iX+YpPDaq5D57569xblzUPQAc/fNw090ZGyoD3K+DwX4C
         9Wzpj8ClXAYayVcABQZ/GKUpQ3w0MOqzzC/URnGIiRjgwM291nV/CowcN2wCl3OLN6F3
         8Mcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZWl8xQpkQjpDhMqJaiCk+PAz48ocYvif44z06dMNrq8=;
        b=Kx/evdAO/suFRJeMGj223kkKabSvN799rOF2/BC9P2Z7azlN8eipUlvSKTdUk7vvon
         BxOcngQlM19EeZhkx7SaKbvYxN3F6Y8qyipSANcHdW4cTnoA9UFxZMuCeIy6oAY/9Fty
         d4NMqTJGxGPtBJqEuBwGz+f+THOvPhhta9Cuf0RKFqYBOE7jBlpyEvdOAsHw9lfdhfgt
         QsAIstn5YtQ5tMXFs7nhoRQkAW/oVLyhQNJ1rgfqtZSUSd+lEiZHykuzv23flJilkTbw
         7EjdPTwm+iOXsawndqEGRlTs/z00GX51YXSZCFHoYDNZWfv0MBhLcGOF04f6gcNk76H3
         ZEdA==
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
Subject: [PATCH 4.9 149/241] scsi: sg: check for valid direction before starting the request
Date: Mon, 19 Mar 2018 19:06:54 +0100
Message-Id: <20180319180757.351846763@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390670672101192?=
X-GMAIL-MSGID: =?utf-8?q?1595391473974044748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -663,18 +663,14 @@ sg_write(struct file *filp, const char _
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
@@ -753,6 +749,29 @@ sg_new_write(Sg_fd *sfp, struct file *fi
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
@@ -773,6 +792,9 @@ sg_common_write(Sg_fd * sfp, Sg_request
 			"sg_common_write:  scsi opcode=0x%02x, cmd_size=%d\n",
 			(int) cmnd[0], (int) hp->cmd_len));
 
+	if (!sg_is_valid_dxfer(hp))
+		return -EINVAL;
+
 	k = sg_start_req(srp, cmnd);
 	if (k) {
 		SCSI_LOG_TIMEOUT(1, sg_printk(KERN_INFO, sfp->parentdp,
