Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225gMY3R738dSGgFzp9PYcm92QalmK2UoPXVnqDm4y3AaN+qUUYZ5cLozWTPIdpAu93Sczwj
ARC-Seal: i=1; a=rsa-sha256; t=1517591817; cv=none;
        d=google.com; s=arc-20160816;
        b=F/hYRaqp2fbF0YAspBAa160meWtHmVp2RixyzOQZhTC8OjVQ6GE1nE2E9/Y18L+5gr
         Fu2n8Dl+HSPPEh91gu9CP8eIGnuSz8WrmOveOtYpfJIHsFkFc2KFpluUheQJAZWfAofa
         aMZAh98lllQoRQ63mUCpW/xtk6juB6mhkq+p94oS+sInpPLgsVqudOzkjrk1tXpB+cZg
         OJkh184yilB9G7srBn08kp12AYiqovEF67E1rCRF+WoWxXPSfl6ORwPz9fCBfUJ/dPYC
         2+ECS2Hz6QEFiXIYwqAWXtaVcQJFmjgCnT4ZhTgV9OQUrUtbha2u9XOKZfcacJuqRn7p
         omTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X10+0AmtSCgXqo3u9kaXF1I9dVo69CZfe/xcb2vbv7k=;
        b=UCllKt4onpI/iKHPdJsbXI/7qJ+7zizPGBw6TCCwXtHb2wPnp4H6E7RSzywhYSx2jO
         0zayYvluHrdzrFbEDUze7pIA7cftYvT+ji85RjBsRHnXJ6ZynCESoxzAb48gDpul3HwY
         OhPRooS1it8uQ42b+QM+DUWul07zr7/xydPFCuraMXSVeDy4H7TcdKp8ga4ue7M1BNSQ
         +9B8k+5AFyi4Jp3ihPgkUe/MfBMp7wbw9ONK0O9VEsRizmOaJrf/sxKlEE9qMQ8P2Uae
         zXl8RxRq9ihT8yfFjWg+uu4U4GwKNe9yheLhBzOp5ARXfVn5a0BIE/uJEo1NzO2MTjCR
         5StA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Cathy Avery <cavery@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.15 26/55] scsi: storvsc: missing error code in storvsc_probe()
Date: Fri,  2 Feb 2018 17:58:44 +0100
Message-Id: <20180202140828.920638248@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591310357562911184?=
X-GMAIL-MSGID: =?utf-8?q?1591310357562911184?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit ca8dc694045e9aa248e9916e0f614deb0494cb3d upstream.

We should set the error code if fc_remote_port_add() fails.

Fixes: daf0cd445a21 ("scsi: storvsc: Add support for FC rport.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Cathy Avery <cavery@redhat.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/storvsc_drv.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1834,8 +1834,10 @@ static int storvsc_probe(struct hv_devic
 		fc_host_node_name(host) = stor_device->node_name;
 		fc_host_port_name(host) = stor_device->port_name;
 		stor_device->rport = fc_remote_port_add(host, 0, &ids);
-		if (!stor_device->rport)
+		if (!stor_device->rport) {
+			ret = -ENOMEM;
 			goto err_out4;
+		}
 	}
 #endif
 	return 0;
