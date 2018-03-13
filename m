Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELukbDk8Wtx5PYFRn6a+LaKts0+Y30vXu48nWjEEiF21s2yrk6caXUseDhxKuQxgDFsblfZ5
ARC-Seal: i=1; a=rsa-sha256; t=1520955399; cv=none;
        d=google.com; s=arc-20160816;
        b=PfBbOyoUqLBF7hgS/dU1ACmF9/6DF2qkd7iCk02ErTT25am9PYxoBT0BUhIg0VAZNG
         vUFnQiDVhmE0p2JqPmHW1QfDeL/35djb9GiaXE+LPaD2gl2DeFksyvzu5tYAVd4wBz/P
         qf/S5vbU5K4Dj8e4H5BK4oLVnYnrCTALx16YdcIkpxekd0szZfPO3ok02sPS9zBIdoky
         DtJME0xFArbBc/cqyusJvL2fKHkIuPtCotnxQY9Pq5vCh2P6EfWEr3qvCxmhP9VVhSJV
         KZGWKDn6Kc/f2Oo3bB6PeTuhQ/ZrjtfF6ioWnYzRds9W39YdZAE4TlTGW572f28gOvqN
         XhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ff8gcn3j0iowiPl+13Sj3MEmgE6AU5bzFoWhgaQsm8c=;
        b=PO3w6pRYo3LojaNtdJp8HXq9CjPn2Xv+Wm6te/OAzNFJ6LP/XyT30PmL3vjhcRDkHg
         FQoxJuqXH9iAX2XxeZ9Mv+jX+Qwx9X8XnRpx8dWUP9eoVDLY6hvgKgDMKvYoMB8LfV8Y
         V3alKqbxrwD8Vq17R8jiECENVjIEJMuMcOq5ZYvcmQOQC0HxhRpqDCWaDxJ3xNBf7tSc
         RR4QvXDhFHAVMI1mi3oIm0CFeBFNcnecfKsDMWybdpGw7YtDTxKJXwLWq8CMG7DHdbj7
         62Ls8H9Nqar1VE+rQRWzZdv3zlXV00sv2VUQx73ADi6/KYUMRTsxx3f+fOHxyoAfL766
         sydQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Quinn Tran <quinn.tran@cavium.com>,
	Himanshu Madhani <himanshu.madhani@cavium.com>,
	Hannes Reinecke <hare@suse.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 037/140] scsi: qla2xxx: Fix scan state field for fcport
Date: Tue, 13 Mar 2018 16:24:00 +0100
Message-Id: <20180313152500.634088746@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837165411969531?=
X-GMAIL-MSGID: =?utf-8?q?1594837329031002537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 76f9a2dd4c60183879a1898bcd56a1dbab19a85d upstream.

Add correct value of scan_state field indicating state of the FC port

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_target.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -5788,6 +5788,7 @@ static fc_port_t *qlt_get_port_database(
 		tfcp->port_type = fcport->port_type;
 		tfcp->supported_classes = fcport->supported_classes;
 		tfcp->flags |= fcport->flags;
+		tfcp->scan_state = QLA_FCPORT_FOUND;
 
 		del = fcport;
 		fcport = tfcp;
