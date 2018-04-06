Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx492jwQQLZqahw7tjWl4p6cDmImrhYMhQxNqDA8kdAZMWaXWoukzKIJPXP2fQIsL+1SQSzYR
ARC-Seal: i=1; a=rsa-sha256; t=1523021460; cv=none;
        d=google.com; s=arc-20160816;
        b=R5BMKlKvtF0QCpx9L2adK1LlM3xAQwxIrDB5VA5UadIyY0MPf9i0tDKdN9jlTUCXoZ
         pbXUDtwzSlJaIPb8exgqjY7TQ8p9LknjIXpOZRolxmAnwBYIeOHztJxSaJ91oIv/4cYE
         JUE86S9YliwtxlOZ+eyu7h86RAGDOKA2HIHaiBg7f0eM31UTHnfUpovl+a/sJ3rKQtNp
         SaTpz+/IhZ+g6aysF7wpL7svf9MzP2zlv/qIJFH7eayeMhl1iOYG4X5IQEG8a0U856Wd
         pXerlMdELYh/ZfprD01FDH52Z5l8wu6tMpD5HLFfNb2Tq/YqymYxhD2FdNE7tusig/bj
         Qnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZA9p+ySX7xugJ9jFDYQj4VcHfFkPv/1cWeDlUX8cpug=;
        b=mlIo8TbtPLzEdca4y89wUoE0985nZSAUttkfiZalM2I4a9g3nJHu5V0HiwdrcmcCVy
         NCK0L9BVAzKZYJl6yI8I6o5mlKYyyrz83lfG3SrqHvKNeaRswin1TSgVs0QgEvCvRu0t
         m/Ui0ECmkm+imCSQd70jNIU71+jlTjurkc9Nj2blUXUdyvy8r4v8q4exsEIlR1hX5E38
         GvXk0o5/Dkhar/ZxryuzNf27BHrbLlNx09fv64ZbQqFpu2l4sj8DPei0wKEeIi89EP1j
         SUSrUKF5TQWorQop7iP09PXbsdWJjkY7Bi2iVrDD8TxhShIsbK4RKBo8tF2/rIvou3a2
         CeJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Gibson <david@gibson.dropbear.id.au>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Fam Zheng <famz@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 43/72] scsi: virtio_scsi: always read VPD pages for multiqueue too
Date: Fri,  6 Apr 2018 15:23:44 +0200
Message-Id: <20180406084308.793860189@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003512073897792?=
X-GMAIL-MSGID: =?utf-8?q?1597003751348003112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit a680f1d463aeaeb00d22af257a56e111967c2f18 upstream.

Multi-queue virtio-scsi uses a different scsi_host_template struct.  Add
the .device_alloc field there, too.

Fixes: 25d1d50e23275e141e3a3fe06c25a99f4c4bf4e0
Cc: stable@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/virtio_scsi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -819,6 +819,7 @@ static struct scsi_host_template virtscs
 	.eh_abort_handler = virtscsi_abort,
 	.eh_device_reset_handler = virtscsi_device_reset,
 
+	.slave_alloc = virtscsi_device_alloc,
 	.can_queue = 1024,
 	.dma_boundary = UINT_MAX,
 	.use_clustering = ENABLE_CLUSTERING,
