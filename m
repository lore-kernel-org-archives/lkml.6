Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtBsKa8i7KZSShSS987jIn9Cfl5S21Qo7ZPqIrjYOd3OsIy+SZkKf4BpOXtUIG8KyP38pHq
ARC-Seal: i=1; a=rsa-sha256; t=1519981197; cv=none;
        d=google.com; s=arc-20160816;
        b=kp/Ls0t/GnbfrnQuXJRHZF3fuHgtYvt8T13s5cxmeMevTwSIE499Lum5Gx9XdgTfPB
         Fd36eMGxb3x/0w3UQLRflRoe2xHLFRg0icWayOJyETX0Nqs4QmLUPfeL08v9mlmrUL3s
         Y8EQeD8KJWV60vIKrUGRpxKxDLFht/C3zszoFQsPKBeRxxihacdkj+9uzZRvuNsH1G+5
         4uQPXacXe/QWEMkZ6q5NM4iK02CDuhZwVlcIvjYFXNW0U/HQtJUYGlN14EgqJAmJIjPu
         ufQhS9H/jdpDEaYb9K0O33MQ36Kp645sQ8hTRBotW1NONsY3fhQJ7AWJggNzv9dh3fWq
         lkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rgj1YpGbQzeNGLbvYbTAwMTobCiZxMkACu4KBmh2t+E=;
        b=ZSu5e3IRNw6LVNHQ+fWNnmPpLy2yE59h1Q+DxzTot65gUDXM7Hkl8NJkpED/hKu8Jh
         5nKur1oR67VvE25jpBONyCLbMkGI7WoyB57acnM7lqIMZ2I++CriRd7/+vu27HRU7HIX
         /p8mUKrzobur+u/6Qh/n5yIsQ7rH4lHYKRTPrfYEdV2FUKvRnMazhmVGsRDxQ9u2y2z0
         YVczSj9V2AiOnFrGUBXvrr9N50Oa0+K8LC1KzxpL8VZsmimys0sj7siAePp9hl0vRigx
         TECwzkoPR/jrXLLFT4cuYTjnhRPpsnbmjqcb0a0fBmTqHnCOYT/Bh9eZl1ZIlUKbmvnN
         Otcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Prasad B Munirathnam <prasad.munirathnam@microsemi.com>,
	Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 004/115] scsi: aacraid: Fix I/O drop during reset
Date: Fri,  2 Mar 2018 09:50:07 +0100
Message-Id: <20180302084504.029995353@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815803950939061?=
X-GMAIL-MSGID: =?utf-8?q?1593815803950939061?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prasad B Munirathnam <prasad.munirathnam@microsemi.com>


[ Upstream commit 5771cfffdffe709ae9b403b6f80438ca40bf850e ]

"FIB_CONTEXT_FLAG_TIMEDOUT" flag is set in aac_eh_abort to indicate
command timeout. Using the same flag in reset handler causes the command
to time out and the I/Os were dropped.

Define a new flag "FIB_CONTEXT_FLAG_EH_RESET" to make sure I/O is
properly handled in eh_reset handler.

[mkp: tweaked commit message]

Signed-off-by: Prasad B Munirathnam <prasad.munirathnam@microsemi.com>
Reviewed-by: Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/aacraid/aacraid.h |    1 +
 drivers/scsi/aacraid/linit.c   |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1724,6 +1724,7 @@ struct aac_dev
 #define FIB_CONTEXT_FLAG_NATIVE_HBA		(0x00000010)
 #define FIB_CONTEXT_FLAG_NATIVE_HBA_TMF	(0x00000020)
 #define FIB_CONTEXT_FLAG_SCSI_CMD	(0x00000040)
+#define FIB_CONTEXT_FLAG_EH_RESET	(0x00000080)
 
 /*
  *	Define the command values
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1037,7 +1037,7 @@ static int aac_eh_bus_reset(struct scsi_
 			info = &aac->hba_map[bus][cid];
 			if (bus >= AAC_MAX_BUSES || cid >= AAC_MAX_TARGETS ||
 			    info->devtype != AAC_DEVTYPE_NATIVE_RAW) {
-				fib->flags |= FIB_CONTEXT_FLAG_TIMED_OUT;
+				fib->flags |= FIB_CONTEXT_FLAG_EH_RESET;
 				cmd->SCp.phase = AAC_OWNER_ERROR_HANDLER;
 			}
 		}
