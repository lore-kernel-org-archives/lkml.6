Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpix6a+lBrcfpEdZnE1r+YD+BjUOIoCmd9m2ApE9OGqDOnjb1x1ZwVgIlyVMLbZE/6CbZPS
ARC-Seal: i=1; a=rsa-sha256; t=1525116446; cv=none;
        d=google.com; s=arc-20160816;
        b=MKVN4r4k0S/wBcimGbKiU8kIanwj0utnw8a0q96mTd1tgz7de1be8MnN4RDdfmlBop
         0otLjCCdHMM/hVPvdr6S4iZ61/WCBdwZoge1wqerI3Vms1TzNtPyJBo+9YLKEaENNA+J
         ird96OdvKjHfbvOD133oBL5PhVlMYiPtY/kPa8JZ+bPod6WxgGfez98LybF6W4bWyJkH
         0GJ2WoNLz3MUIdWDqlc7bTZe0s+T3/h65CpZXIHeqFvdU45XNgCyuEOdtmIA50Q33L8K
         uNpA8tqBwbWyXwXaPnIkBx70U7YcWRXunqXLRb/RFNO4/ma4Kq9lpCHl41UlNlXjyHZI
         /Z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=e9LblJuZ2SPRt75/ifzcJ3+6Z0Tn4LDhj/rqR9CWj6M=;
        b=hcDgcnKbfKkXKwuvyJ6gnelyjsJr0I6Z4ix6KlUPRc4bRweoKHZMOiDtyFhmAimgU9
         WzkkOuUgbNMJ6SG5DrXH3176r/f0Vbdh0LwMPGludF7NWmGeqksA0C2a2hQGSivEbcN1
         yjDi8G2x7zfw4SZYWWi+9z0BsE7sSPHCviz6bhYPYBORASfzqX8G0b+Mxdp4xmJ1to3G
         Hor2gEnM5BhoIUo2qOeh+nDcN3s6q91I3zVSGeDxgtLwAHBH2jd4UtI0c2ZAy/8lMPKj
         yk7EQES4PKDyY/9/7/YEhdlfDoCaqPG/Ozb9xlLngrS2or7TSWNl6pZeKG5BgZKos+Jh
         +joA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E29722DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dong Jia Shi <bjsdjshi@linux.ibm.com>,
	Halil Pasic <pasic@linux.vnet.ibm.com>,
	Pierre Morel <pmorel@linux.vnet.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 58/91] vfio: ccw: process ssch with interrupts disabled
Date: Mon, 30 Apr 2018 12:24:40 -0700
Message-Id: <20180430184007.196458060@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200503442942312?=
X-GMAIL-MSGID: =?utf-8?q?1599200503442942312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cornelia Huck <cohuck@redhat.com>

commit 3368e547c52b96586f0edf9657ca12b94d8e61a7 upstream.

When we call ssch, an interrupt might already be pending once we
return from the START SUBCHANNEL instruction. Therefore we need to
make sure interrupts are disabled while holding the subchannel lock
until after we're done with our processing.

Cc: stable@vger.kernel.org #v4.12+
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/cio/vfio_ccw_fsm.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -20,12 +20,12 @@ static int fsm_io_helper(struct vfio_ccw
 	int ccode;
 	__u8 lpm;
 	unsigned long flags;
+	int ret;
 
 	sch = private->sch;
 
 	spin_lock_irqsave(sch->lock, flags);
 	private->state = VFIO_CCW_STATE_BUSY;
-	spin_unlock_irqrestore(sch->lock, flags);
 
 	orb = cp_get_orb(&private->cp, (u32)(addr_t)sch, sch->lpm);
 
@@ -38,10 +38,12 @@ static int fsm_io_helper(struct vfio_ccw
 		 * Initialize device status information
 		 */
 		sch->schib.scsw.cmd.actl |= SCSW_ACTL_START_PEND;
-		return 0;
+		ret = 0;
+		break;
 	case 1:		/* Status pending */
 	case 2:		/* Busy */
-		return -EBUSY;
+		ret = -EBUSY;
+		break;
 	case 3:		/* Device/path not operational */
 	{
 		lpm = orb->cmd.lpm;
@@ -51,13 +53,16 @@ static int fsm_io_helper(struct vfio_ccw
 			sch->lpm = 0;
 
 		if (cio_update_schib(sch))
-			return -ENODEV;
-
-		return sch->lpm ? -EACCES : -ENODEV;
+			ret = -ENODEV;
+		else
+			ret = sch->lpm ? -EACCES : -ENODEV;
+		break;
 	}
 	default:
-		return ccode;
+		ret = ccode;
 	}
+	spin_unlock_irqrestore(sch->lock, flags);
+	return ret;
 }
 
 static void fsm_notoper(struct vfio_ccw_private *private,
