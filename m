Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuCN/uo0xOEBugaLAstnnKVSpHsiCw6ix7jpAg3kvq2F7OkfOawJtoTbWZftEe8TBzJgbRd
ARC-Seal: i=1; a=rsa-sha256; t=1520955292; cv=none;
        d=google.com; s=arc-20160816;
        b=vz35nf3FrzLg30DYRYLdpuvKLKrpArBN3OXS6Rsd66MYYwz/qycDoEb8gNNhHRVM5f
         AECoLrloHbOiAWqJSXYmdw5jwCBXcQVPDjrvZUqisLo/Ji5jdHR6wRQXgcbqBVfI+Ym0
         Kf/mLXFaP13acDtA7TigvZJC62fxMNGVWOKVT+jNajLnjlb5QvY8ORvfMY7bH4HFtlL/
         iOmiU6lAMlYFMwfNSW0Hv10V4GfqJzFDzyxIasMBL8HNx7Nd1cV1dyQWoE4OQPNrlP4F
         YZvGlA5YtL0sgsN2tqg8+gurxzBHc0QF7l2Rqz1rBnNCzbRix4mnhl6kCSiOqcO7Z35V
         zsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GE3myyTBuCjJ3Xo/jcBqWQUeiZUspG1wGbVippm94Tw=;
        b=YJM+/Qg/s7VKNQcfuHFRyMw7kc3anMtF2Wn5Q/mYU9zgvqEMZ8CzYTZl1sCmVDU9Wp
         uGz+e8tbBRX+ooVXGIcKvVagJVLNon2XMI+ouk4pEr1w4CIl66uLGDeeqgpNvVGkQ5Oh
         YZa9KuJULJfU9jD/Ec9I2UIV/xz/m07MmktMf1ZpO9Jt7f+cuHh3v3IB2d8h+7Xecye1
         n89f9AWxvXFJatABe1TrBUXju2cWjo4NP4sSrw6RParBMqRjpq8wIAib/sC0I3UqC07o
         c5SycLanqK4ywiPjna8qKdxRax/4yY7yvY+h8Ef0WUYMq9UkFvXNaL6PiudhhrVuunxq
         KBUQ==
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
Subject: [PATCH 4.15 125/146] scsi: qla2xxx: Fix gpnid error processing
Date: Tue, 13 Mar 2018 16:24:52 +0100
Message-Id: <20180313152329.854024033@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837216880835269?=
X-GMAIL-MSGID: =?utf-8?q?1594837216880835269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <quinn.tran@cavium.com>

commit 22e786ea47f8795c561e1a01b6a66bb2cae2fc20 upstream.

Stop GPNID command from advancing if command has failed.

Fixes: 726b85487067d ("qla2xxx: Add framework for async fabric discovery")
Cc: <stable@vger.kernel.org> # 4.10+
Signed-off-by: Quinn Tran <quinn.tran@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_gs.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3211,6 +3211,11 @@ static void qla2x00_async_gpnid_sp_done(
 	    sp->name, res, ct_req->req.port_id.port_id,
 	    ct_rsp->rsp.gpn_id.port_name);
 
+	if (res) {
+		sp->free(sp);
+		return;
+	}
+
 	memset(&ea, 0, sizeof(ea));
 	memcpy(ea.port_name, ct_rsp->rsp.gpn_id.port_name, WWN_SIZE);
 	ea.sp = sp;
