Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELusicuk7p7s7przDH7aJI8hMuN8BsKRFFsl80UJ65gTujUhkIuu/PJ8cqnG4F9sxs0NRoZ3
ARC-Seal: i=1; a=rsa-sha256; t=1520955364; cv=none;
        d=google.com; s=arc-20160816;
        b=RkJONQDo1+aeETTqWAj1gR1Wcf2+2HtPoHx+VHxHUMtkgMburrG+En4hVJPcUkRy3D
         y6eZNEezR87ucdTG/qZggucM05UKxGZ4HE96hizpKlDDaK/EAImEH1j0VUJ8iNxEpYEI
         qF832uypVbu7Bo8tgnXxV789s3LGW08G9dZA29hPLUtDyEvAR+3/N09axM7v7eHU8Ur3
         7PAnlEIXHk03D+WEfIUGyeap4XYUpMl/8eDgn0rgy9U0gFJOkG2zYUy86EWetSSzhhEG
         dDkR6UMPQ9Rri3BITplWSwBf14jh3iVEJX4eum6ztLj0YLeBfMFwGksipGMTn/fNStxU
         Slkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Sq1sZ6hFugLrI5SfisLZtlf0OIZ42YAAVuGoXjloIiA=;
        b=eZDvPUe5zRWMpKG1UaCEQ3+bn8ggWqqqRotITESazPUosVQHCBiilKd/U5RSbKRZ/A
         M53Xb93YrkTS+mkVc28mpi9w6t+JXYGa/iTBwXmIlTY9uhwIVKXLhAZF5V5S1gwQynsj
         q3zJ2wLYzP83VcpcnhILzSCoHq8yHVgL+LnnxnrKic8jGbNAam8f1F3CGmt7F9h+muVW
         Ydc3wNl0pAt/u2cCRmI+MIiXXjnXjkZYAqTXQNTq3u0etpJ6qx4/rdr/SBZdo9cukszo
         doCRRMZUtHOEtkIKiHRgb7lG2hrY0r1MDKTeNFkaN9XtIM5t05hYSecm0v9ak0tpikEh
         0tJw==
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
Subject: [PATCH 4.14 025/140] scsi: qla2xxx: Fix gpnid error processing
Date: Tue, 13 Mar 2018 16:23:48 +0100
Message-Id: <20180313152459.702051245@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837216880835269?=
X-GMAIL-MSGID: =?utf-8?q?1594837292943040180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
